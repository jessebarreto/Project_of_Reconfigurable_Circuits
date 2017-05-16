----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.03.2017 18:44:56
-- Design Name: 
-- Module Name: tb_ex6_barrelshift_multifuncional - Behavioral
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

entity tb_ex6_barrelshift_multifuncional is
--  Port ( );
end tb_ex6_barrelshift_multifuncional;

architecture Behavioral of tb_ex6_barrelshift_multifuncional is
	component ex6_barrelshift_multifuncional is
    Port ( data : in STD_LOGIC_VECTOR (7 downto 0);
    	   lr : in STD_LOGIC;
           output : out STD_LOGIC_VECTOR (7 downto 0));
	end component ex6_barrelshift_multifuncional;
	
	signal data, output : STD_LOGIC_VECTOR (7 downto 0);
	signal lr : STD_LOGIC;
begin
	uut : ex6_barrelshift_multifuncional port map(data => data, lr => lr, output => output);
	process
	begin
		lr <= '1';
		wait for 20 ns;
		lr <= '0';
		wait for 20 ns;
	end process;

	process
	begin 
		data <= X"00"; wait for 10 ns;
		data <= X"01"; wait for 10 ns;
		data <= X"02"; wait for 10 ns;
		data <= X"03"; wait for 10 ns;
		data <= X"04"; wait for 10 ns;
		data <= X"05"; wait for 10 ns;
		data <= X"06"; wait for 10 ns;
		data <= X"07"; wait for 10 ns;
		data <= X"08"; wait for 10 ns;
		data <= X"09"; wait for 10 ns;
		data <= X"0a"; wait for 10 ns;
		data <= X"a0"; wait for 10 ns;
		data <= X"aa"; wait for 10 ns;
		data <= X"bb"; wait for 10 ns;
		data <= X"cc"; wait for 10 ns;
		data <= X"dd"; wait for 10 ns;
		data <= X"ee"; wait for 10 ns;
		data <= X"af"; wait for 10 ns;
		data <= X"fa"; wait for 10 ns;
		data <= X"11"; wait for 10 ns;
	end process;
end Behavioral;
