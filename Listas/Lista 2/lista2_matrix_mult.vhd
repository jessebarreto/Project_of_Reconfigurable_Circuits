----------------------------------------------------------------------------------
-- Company: Universidade de Brasilia
-- Engineer: Jesse Barreto de Barros - 17/0067033
-- 
-- Create Date: 06.05.2017 00:57:36
-- Design Name: Lista 2
-- Module Name: lista2_matrix_mult - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.entities.all;
use work.fpupack.all;
use work.matrixmultiplierpack.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity lista2_matrix_mult is
  Port	(
  			clk		: in	STD_LOGIC;
  			reset	: in	STD_LOGIC;
  			start	: in	STD_LOGIC;
  			matrixA	: in 	Matrix;
  			matrixB	: in 	Matrix;
  			matrixZ : out	Matrix;
  			ready	: out	STD_LOGIC
  		);
end lista2_matrix_mult;

architecture Behavioral of lista2_matrix_mult is
	component lista2_matrix_mult_cascade_adder_3 is
		Port
		( 
			reset : in STD_LOGIC;
			clk : in STD_LOGIC;
			startA : in STD_LOGIC;
			startB : in STD_LOGIC;
			startC : in STD_LOGIC;
			a : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
			b : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
			c : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
			z : out STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
			ready : out STD_LOGIC
			);
	end component lista2_matrix_mult_cascade_adder_3;
	
	signal sigMatrixA : Matrix := (others => (others => '0'));
	signal sigMatrixB : Matrix := (others => (others => '0'));
	signal sigMatrixZ : Matrix := (others => (others => '0'));

	signal resMults : Matrices := (others => (others => '0'));
	signal resMult : Matrix := (others => (others => '0'));
	
	signal sigMulReadys : STD_LOGIC_VECTOR (MATRIXSIZE*MATRIXSIZE*MATRIXSIZE-1 downto 0) := (others => '0');
	signal sigAdderStart: STD_LOGIC := '0';
	signal sigAdderReadys : STD_LOGIC_VECTOR (MATRIXSIZE*MATRIXSIZE-1 downto 0) := (others => '0');
begin
	-- Multipliers
	MultGenK: for k in 1 to MATRIXSIZE generate
		MultGenRow: for i in 1 to MATRIXSIZE generate
			MultGenCol: for j in 1 to MATRIXSIZE generate
				mulX : multiplierfsm_v2 port map
				(
					reset       => reset,
					clk         => clk,
					op_a        => matrixA((i-1)*MATRIXSIZE + k),
					op_b    	=> matrixB((k-1)*MATRIXSIZE + j),
					start_i	    => start,
					mul_out     => resMults(((k-1)*MATRIXSIZE + (i-1))*MATRIXSIZE + j),
					ready_mul   => sigMulReadys(((k-1)*MATRIXSIZE + (i-1))*MATRIXSIZE + j - 1)
				);
			end generate;
		end generate;
	end generate;
	
	-- Adders - Pode ser otimizado? - Não consegui resover o problema para ficar paralelo para qualquer NxN Matrix
	AdderGenRow: for i in 1 to MATRIXSIZE generate
		AdderGenCol: for j in 1 to MATRIXSIZE generate
			Matrix1x1: if MATRIXSIZE = 1 generate
				resMult((i-1)*MATRIXSIZE + j) <= resMults((i-1)*MATRIXSIZE + j);
			end generate;
			
			Matrix2x2: if MATRIXSIZE = 2 generate
				sigAdderStart <= sigMulReadys(((1-1)*MATRIXSIZE + (i-1))*MATRIXSIZE + j - 1) and sigMulReadys(((2-1)*MATRIXSIZE + (i-1))*MATRIXSIZE + j - 1);
				Adder2x2_1lv1: addsubfsm_v6 port map
				(
					reset       => reset,
					clk         => clk,
					op          => '0',
					op_a        => resMults(((1-1)*MATRIXSIZE + (i-1))*MATRIXSIZE + j),
					op_b    	=> resMults(((2-1)*MATRIXSIZE + (i-1))*MATRIXSIZE + j),
					start_i	    => sigAdderStart,
					addsub_out  => resMult((i-1)*MATRIXSIZE + j),
					ready_as    => sigAdderReadys((i-1)*MATRIXSIZE + j - 1)
				);
			end generate;
			
			Matrix3x3 : if MATRIXSIZE = 3 generate
				Adder3x3: lista2_matrix_mult_cascade_adder_3 port map
				(
					reset       => reset,
					clk         => clk,
					startA		=> sigMulReadys(((1-1)*MATRIXSIZE + (i-1))*MATRIXSIZE + j - 1),
					startB		=> sigMulReadys(((2-1)*MATRIXSIZE + (i-1))*MATRIXSIZE + j - 1),
					startC		=> sigMulReadys(((3-1)*MATRIXSIZE + (i-1))*MATRIXSIZE + j - 1),
					a			=> resMults(((1-1)*MATRIXSIZE + (i-1))*MATRIXSIZE + j),
					b			=> resMults(((2-1)*MATRIXSIZE + (i-1))*MATRIXSIZE + j),
					c			=> resMults(((3-1)*MATRIXSIZE + (i-1))*MATRIXSIZE + j),
					z			=> resMult((i-1)*MATRIXSIZE + j),
					ready		=> sigAdderReadys((i-1)*MATRIXSIZE + j - 1)
				);
			end generate;
		end generate;
	end generate;
	
	-- Output
	ready <= sigAdderReadys(0);	
	matrixZ <= resMult;
	
end Behavioral;
