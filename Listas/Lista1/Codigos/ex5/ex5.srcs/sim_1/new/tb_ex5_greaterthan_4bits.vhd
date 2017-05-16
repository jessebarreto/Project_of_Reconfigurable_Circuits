----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.03.2017 11:43:34
-- Design Name: 
-- Module Name: tb_ex5_greaterthan_4bits - Behavioral
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

entity tb_ex5_greaterthan_4bits is
--  Port ( );
end tb_ex5_greaterthan_4bits;

architecture Behavioral of tb_ex5_greaterthan_4bits is
	component ex5_greaterthan_4bits is
    Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
           b : in STD_LOGIC_VECTOR (3 downto 0);
           z : out STD_LOGIC);
	end component ex5_greaterthan_4bits;
	
	signal a, b : std_logic_vector (3 downto 0);
	signal z : std_logic;
begin
	uut : ex5_greaterthan_4bits port map(	a => a,
											b => b,
											z => z);
		-- *********TEST EVERY POSSIBILITY!*************						
--		process
--			variable aux : std_logic_vector (7 downto 0);
--		begin
--			for I in 0 to 2**aux'length - 1 loop
--				aux := std_logic_vector(TO_UNSIGNED(I, aux'length));
--				a <= aux(7 downto 4);
--				b <= aux(3 downto 0);
--				wait for 10 ns;
--			end loop;
--			wait;
--		end process;

--            ********** TEST SET OF COMBINATIONS *********
	process
	begin
		for I in 0 to 2**a'length - 1 loop
			a <= std_logic_vector(TO_UNSIGNED(I, a'length));
			wait for 10 ns;
		end loop;
	end process;
	process
	begin
		for I in 2**b'length - 1 downto 0 loop
			b <= std_logic_vector(TO_UNSIGNED(I, b'length));
			wait for 10 ns;
		end loop;
	end process;
end Behavioral;
