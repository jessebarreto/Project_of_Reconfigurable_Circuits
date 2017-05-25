----------------------------------------------------------------------------------
-- Company: Universidade de Brasilia
-- Engineer: Jesse Barreto de Barros - 17/0067033
-- 
-- Create Date: 06.05.2017 00:57:36
-- Design Name: 
-- Module Name: lista2_matrix_mult_cascade_adder_3 - Behavioral
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

entity lista2_matrix_mult_cascade_adder_3 is
		Port ( reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           startA : in STD_LOGIC;
           startB : in STD_LOGIC;
           startC : in STD_LOGIC;
           a : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
           b : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
           c : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
           z : out STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
           ready : out STD_LOGIC);
end lista2_matrix_mult_cascade_adder_3;

architecture Behavioral of lista2_matrix_mult_cascade_adder_3 is
	signal res_1lv1 : STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0) := (others => '0') ;
	signal res_2lv1 : STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0) := (others => '0') ;
	signal start_1lv1 : STD_LOGIC := '0';
	signal start_1lv2 : STD_LOGIC := '0';
	signal ready_1lv1 : STD_LOGIC := '0';
begin
	-- Components Level 1
	start_1lv1 <= startA and startB;
	Adder2x2_1lv1: addsubfsm_v6 port map
	(
		reset       => reset,
		clk         => clk,
		op          => '0',
		op_a        => a,
		op_b    	=> b,
		start_i	    => start_1lv1,
		addsub_out  => res_1lv1,
		ready_as    => ready_1lv1
	);
	
	-- Components Level 2
	start_1lv2 <= ready_1lv1;
	Adder2x2_1lv2: addsubfsm_v6 port map
	(
		reset       => reset,
		clk         => clk,
		op          => '0',
		op_a        => res_1lv1,
		op_b    	=> c,
		start_i	    => start_1lv2,
		addsub_out  => z,
		ready_as    => ready
	);

end Behavioral;
