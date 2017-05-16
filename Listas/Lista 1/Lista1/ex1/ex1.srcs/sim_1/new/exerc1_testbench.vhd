----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.03.2017 15:44:18
-- Design Name: 
-- Module Name: exerc1_testbench - Behavioral
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

entity exerc1_testbench is
--  Port ( );
end exerc1_testbench;

architecture Behavioral of exerc1_testbench is
	component exerc1 is
		Port ( a : in  std_logic;
	  		 b : in  std_logic;
	  		 c : in  std_logic;
	  		 d : out std_logic);
	end component exerc1;
	
	signal a,b,c : std_logic;
	signal d : std_logic;
	
begin
	U1 : exerc1 port map (a => a, b => b, c => c, d => d);
	
	process
	begin
		a <= '0'; b <= '0'; c <= '0'; wait for 10 ns;
		a <= '0'; b <= '0'; c <= '1'; wait for 10 ns;
		a <= '0'; b <= '1'; c <= '0'; wait for 10 ns;
		a <= '0'; b <= '1'; c <= '1'; wait for 10 ns;
		a <= '1'; b <= '0'; c <= '0'; wait for 10 ns;
		a <= '1'; b <= '0'; c <= '1'; wait for 10 ns;
		a <= '1'; b <= '1'; c <= '0'; wait for 10 ns;
		a <= '1'; b <= '1'; c <= '1'; wait for 10 ns;
		wait;
	end process;
end Behavioral;
