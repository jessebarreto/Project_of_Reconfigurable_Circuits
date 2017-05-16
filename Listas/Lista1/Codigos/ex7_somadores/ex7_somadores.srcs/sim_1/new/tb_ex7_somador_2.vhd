----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.03.2017 21:33:24
-- Design Name: 
-- Module Name: tb_ex7_somador_2 - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_ex7_somador_2 is
--  Port ( );
end tb_ex7_somador_2;

architecture Behavioral of tb_ex7_somador_2 is
	component ex7_somador_2 is
    Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
           b : in STD_LOGIC_VECTOR (3 downto 0);
           opsel : in STD_LOGIC_VECTOR (1 downto 0);
           z : out STD_LOGIC);
	end component ex7_somador_2;
	
	signal a, b : STD_LOGIC_VECTOR (3 downto 0);
	signal opsel : STD_LOGIC_VECTOR (1 downto 0);
	signal z : STD_LOGIC;
begin
	uut : ex7_somador_2 port map(a => a, b => b, opsel => opsel, z => z);

	process
	begin
		for I in 0 to 11 loop
			opsel <= std_logic_vector(TO_UNSIGNED(I, opsel'length));
			wait for 20 ns;
		end loop; 
	end process;

	process
	begin
		for I in 0 to 22 loop
			a <= std_logic_vector(TO_UNSIGNED(I, a'length));
			wait for 10 ns;
		end loop; 
	end process;

	process
	begin
		for I in 0 to 15 loop
			b <= std_logic_vector(TO_UNSIGNED(I, b'length));
			wait for 15 ns;
		end loop; 
	end process;
end Behavioral;
