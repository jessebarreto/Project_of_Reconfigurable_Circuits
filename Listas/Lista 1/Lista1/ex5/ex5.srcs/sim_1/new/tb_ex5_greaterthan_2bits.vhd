----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.03.2017 05:32:00
-- Design Name: 
-- Module Name: tb_ex5_greaterthan_2bits - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_ex5_greaterthan_2bits is
--  Port ( );
end tb_ex5_greaterthan_2bits;

architecture Behavioral of tb_ex5_greaterthan_2bits is
	component ex5_greaterthan_2bits is
	Port ( a : in STD_LOGIC_VECTOR (1 downto 0);
	           b : in STD_LOGIC_VECTOR (1 downto 0);
	           z : out STD_LOGIC);
	end component ex5_greaterthan_2bits;
	
	signal a, b : std_logic_vector (1 downto 0);
	signal z : std_logic;
begin
	
	uut : ex5_greaterthan_2bits port map(a => a,
										 b => b,
										 z => z);
	
	process
	begin
		a <= "00"; b <= "00"; wait for 10 ns;
		a <= "00"; b <= "01"; wait for 10 ns;
		a <= "00"; b <= "10"; wait for 10 ns;
		a <= "00"; b <= "11"; wait for 10 ns;
		a <= "01"; b <= "00"; wait for 10 ns;
		a <= "01"; b <= "01"; wait for 10 ns;
		a <= "01"; b <= "10"; wait for 10 ns;
		a <= "01"; b <= "11"; wait for 10 ns;
		a <= "10"; b <= "00"; wait for 10 ns;
		a <= "10"; b <= "01"; wait for 10 ns;
		a <= "10"; b <= "10"; wait for 10 ns;
		a <= "10"; b <= "11"; wait for 10 ns;
		a <= "11"; b <= "00"; wait for 10 ns;
		a <= "11"; b <= "01"; wait for 10 ns;
		a <= "11"; b <= "10"; wait for 10 ns;
		a <= "11"; b <= "11"; wait for 10 ns;
		wait;
	end process;
end Behavioral;
