----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.04.2017 08:53:17
-- Design Name: 
-- Module Name: matrix2x2_mult - Behavioral
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

entity matrix2x2_mult is
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
end matrix2x2_mult;

architecture Behavioral of matrix2x2_mult is
	
	-- Signals
	signal s_ready1 : STD_LOGIC := '0';
	signal s_ready2 : STD_LOGIC := '0';
	signal s_ready3 : STD_LOGIC := '0';
	signal s_ready4 : STD_LOGIC := '0';
begin
	ready <= s_ready1;
	
	element1 : matrix_element_mult port map(clk => clk,
											reset => reset,
											start =>start,
											a1 => matrix1_a11,
											a2 => matrix1_a12,
											b1 => matrix2_a11,
											b2 => matrix2_a21,
											ready => s_ready1,
											y => matrixout_a11);
											
	element2 : matrix_element_mult port map(clk => clk,
											reset => reset,
											start =>start,
											a1 => matrix1_a11,
											a2 => matrix1_a12,
											b1 => matrix2_a12,
											b2 => matrix2_a22,
											ready => s_ready2,
											y => matrixout_a12);										

	element3 : matrix_element_mult port map(clk => clk,
											reset => reset,
											start =>start,
											a1 => matrix1_a21,
											a2 => matrix1_a22,
											b1 => matrix2_a11,
											b2 => matrix2_a21,
											ready => s_ready3,
											y => matrixout_a21);																						
											
	element4 : matrix_element_mult port map(clk => clk,
											reset => reset,
											start =>start,
											a1 => matrix1_a21,
											a2 => matrix1_a22,
											b1 => matrix2_a12,
											b2 => matrix2_a22,
											ready => s_ready4,
											y => matrixout_a22);											
																						


end Behavioral;