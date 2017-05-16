----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.03.2017 15:13:30
-- Design Name: 
-- Module Name: tb_ex3 - Behavioral
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

entity tb_ex3 is
--  Port ( );
end tb_ex3;

architecture Behavioral of tb_ex3 is
	component ex3 is
		Port ( a : in STD_LOGIC;
	    	   b : in STD_LOGIC;
	    	   c : in STD_LOGIC;
	    	   d : in STD_LOGIC;
	    	   e : in STD_LOGIC;
	    	   f : in STD_LOGIC;
	    	   g : in STD_LOGIC;
	    	   h : in STD_LOGIC;
	    	   y : out std_logic);
	end component ex3;
	
	signal abcd : std_logic_vector (3 downto 0);
	signal efgh : std_logic_vector (3 downto 0);
	signal y : std_logic;
begin
	
	uut : ex3 port map(	a => abcd(0),
						b => abcd(1),
						c => abcd(2),
						d => abcd(3),
						e => efgh(0),
						f => efgh(1),
						g => efgh(2),
						h => efgh(3),
						y => y);

	process
	begin
			abcd <= X"0"; wait for 10 ns;
			abcd <= X"1"; wait for 10 ns;
			abcd <= X"2"; wait for 10 ns;
			abcd <= X"3"; wait for 10 ns;
			abcd <= X"4"; wait for 10 ns;
			abcd <= X"5"; wait for 10 ns;
			abcd <= X"6"; wait for 10 ns;
			abcd <= X"7"; wait for 10 ns;
			abcd <= X"8"; wait for 10 ns;
			abcd <= X"9"; wait for 10 ns;
			abcd <= X"f"; wait for 10 ns;
			abcd <= X"a"; wait for 10 ns;
			abcd <= X"b"; wait for 10 ns;
			abcd <= X"c"; wait for 10 ns;
			abcd <= X"d"; wait for 10 ns;
			abcd <= X"e"; wait for 10 ns;
			abcd <= X"f"; wait for 10 ns;
			abcd <= X"a"; wait for 10 ns;
			abcd <= X"f"; wait for 10 ns;
			wait;
	end process;

	process
	begin
			efgh <= X"0"; wait for 15 ns;
			efgh <= X"1"; wait for 15 ns;
			efgh <= X"2"; wait for 15 ns;
			efgh <= X"3"; wait for 15 ns;
			efgh <= X"4"; wait for 15 ns;
			efgh <= X"5"; wait for 15 ns;
			efgh <= X"6"; wait for 15 ns;
			efgh <= X"7"; wait for 15 ns;
			efgh <= X"8"; wait for 15 ns;
			efgh <= X"9"; wait for 15 ns;
			efgh <= X"a"; wait for 15 ns;
			efgh <= X"b"; wait for 15 ns;
			efgh <= X"c"; wait for 15 ns;
			efgh <= X"d"; wait for 15 ns;
			efgh <= X"e"; wait for 15 ns;
			efgh <= X"f"; wait for 15 ns;
			efgh <= X"a"; wait for 15 ns;
			efgh <= X"f"; wait for 15 ns;
			wait;
	end process;	
end Behavioral;
