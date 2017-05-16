----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.03.2017 23:07:54
-- Design Name: 
-- Module Name: tb_ex4 - Behavioral
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

entity tb_ex4 is
--  Port ( );
end tb_ex4;

architecture Behavioral of tb_ex4 is
	component ex4 is
		Port ( a1 : in STD_LOGIC;
			   b1 : in STD_LOGIC;
			   c1 : in STD_LOGIC;
			   d1 : in STD_LOGIC;
			   e1 : in STD_LOGIC;
			   f1 : in STD_LOGIC;
			   y1 : out STD_LOGIC;
			   a2 : in STD_LOGIC;
			   b2 : in STD_LOGIC;
			   c2 : in STD_LOGIC;
			   d2 : in STD_LOGIC;
			   y2 : out STD_LOGIC);
	end component ex4;

	signal abc1, def1 : std_logic_vector (2 downto 0);
	signal ab2, cd2 : std_logic_vector (1 downto 0);
	signal y1, y2 : std_logic;
begin
	uut : ex4 port map( a1 => abc1(0),
					b1 => abc1(1),
					c1 => abc1(2),
					d1 => def1(0),
					e1 => def1(1),
					f1 => def1(2),
					y1 => y1,
					a2 => ab2(0),
					b2 => ab2(1),
					c2 => cd2(0),
					d2 => cd2(1),
					y2 => y2);
					
	process
	begin
		abc1 <= "000"; wait for 20 ns;
		abc1 <= "001"; wait for 20 ns;
		abc1 <= "010"; wait for 20 ns;
		abc1 <= "011"; wait for 20 ns;
		abc1 <= "100"; wait for 20 ns;
		abc1 <= "101"; wait for 20 ns;
		abc1 <= "110"; wait for 20 ns;
		abc1 <= "111"; wait for 20 ns;
		wait;
	end process;
	
	process
	begin
		def1 <= "000"; wait for 15 ns;
		def1 <= "001"; wait for 15 ns;
		def1 <= "010"; wait for 15 ns;
		def1 <= "011"; wait for 15 ns;
		def1 <= "111"; wait for 15 ns;
		def1 <= "100"; wait for 15 ns;
		def1 <= "101"; wait for 15 ns;
		def1 <= "110"; wait for 15 ns;
		def1 <= "111"; wait for 15 ns;
		wait;
	end process;
		
	process
	begin
		ab2 <= "00"; wait for 20 ns;
		ab2 <= "01"; wait for 20 ns;
		ab2 <= "10"; wait for 20 ns;
		ab2 <= "11"; wait for 20 ns;
		wait;
	end process;

	process
	begin
		cd2 <= "00"; wait for 15 ns;
		cd2 <= "01"; wait for 15 ns;
		cd2 <= "11"; wait for 15 ns;
		cd2 <= "10"; wait for 15 ns;
		cd2 <= "11"; wait for 15 ns;
		wait;
	end process;
end Behavioral;
