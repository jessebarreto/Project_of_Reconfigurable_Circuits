----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 
-- Design Name: 
-- Module Name: lista2_sobel_conv - Behavioral
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
use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use work.sobelpack.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity lista2_sobel_conv is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           kernelval : in STD_LOGIC_VECTOR (TEMPLATEDEPTH-1 downto 0);
           neighval : in STD_LOGIC_VECTOR (PIXELDEPTH-1 downto 0);
           multres : out STD_LOGIC_VECTOR (MULTDEPTH-1 downto 0));
end lista2_sobel_conv;

architecture Behavioral of lista2_sobel_conv is
begin
	-- Convolution Operation
	process(clk, reset)
		variable var : STD_LOGIC_VECTOR (MULTDEPTH-1 downto 0) := (others => '0');
	begin
		if rising_edge(clk) then
			if reset = '1' then
				multres <= (others => '0');
			else
				var := neighval * kernelval; 
				multres <= neighval * kernelval;
			end if;
		end if;
	end process;
end Behavioral;
