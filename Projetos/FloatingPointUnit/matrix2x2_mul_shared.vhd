----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.04.2017 09:37:04
-- Design Name: 
-- Module Name: matrix2x2_mul_shared - Behavioral
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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.fpupack.all;
use work.entities.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity matrix2x2_mul_shared is
	Port ( clk : in STD_LOGIC;
		   reset : in STD_LOGIC;
		   start : in STD_LOGIC;
		   ready : out STD_LOGIC;
		   matrix1_a11 : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
		   matrix1_a12 : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
		   matrix1_a21 : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
		   matrix1_a22 : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
		   matrix2_a11 : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
		   matrix2_a12 : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
		   matrix2_a21 : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
		   matrix2_a22 : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
		   matrixout_a11 : out STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
		   matrixout_a12 : out STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
		   matrixout_a21 : out STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
		   matrixout_a22 : out STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0));
end matrix2x2_mul_shared;

architecture Behavioral of matrix2x2_mul_shared is
	signal s_mux1_out : STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
	signal s_mux2_out : STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
	signal s_mux3_out : STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
	signal s_mux4_out : STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
	signal s_demux4_in : STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
	
	signal s_sel : STD_LOGIC_VECTOR (1 downto 0);
	
	signal s_ready : STD_LOGIC;
	signal s_start : STD_LOGIC;
begin

	element1 : matrix_element_mult port map(clk => clk,
											reset => reset,
											start =>s_start,
											a1 => s_mux1_out,
											a2 => s_mux2_out,
											b1 => s_mux3_out,
											b2 => s_mux4_out,
											ready => s_ready,
											y => s_demux4_in);

	-- MUX1
	with s_sel select
		s_mux1_out <= matrix1_a11 when "00",
					  matrix1_a11 when "01",
					  matrix1_a21 when "10",
					  matrix1_a21 when others;
	
	-- MUX2
	with s_sel select
		s_mux2_out <= matrix1_a12 when "00",
					  matrix1_a12 when "01",
					  matrix1_a22 when "10",
					  matrix1_a22 when others;

	-- MUX3
	with s_sel select
		s_mux2_out <= matrix2_a11 when "00",
					  matrix2_a12 when "01",
					  matrix2_a11 when "10",
					  matrix2_a12 when others;

	-- MUX4
	with s_sel select
		s_mux2_out <= matrix2_a21 when "00",
					  matrix2_a22 when "01",
					  matrix2_a21 when "10",
					  matrix2_a22 when others;
					  
	-- DEMUX
	demux_saida1 : process (clk, reset)
	begin
		if (reset = '1') then
			matrixout_a11 <= (others => '0');
		elsif (rising_edge(clk)) then
			if (s_sel = "00") then
				matrixout_a11 <= s_demux_in;
			end if;
		end if;
	end process;
							  					  
	
end Behavioral;
