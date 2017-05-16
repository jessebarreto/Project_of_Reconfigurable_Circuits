----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.03.2017 20:27:24
-- Design Name: 
-- Module Name: ex7_somador_1 - Behavioral
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
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ex7_somador_1 is
    Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
           b : in STD_LOGIC_VECTOR (3 downto 0);
           opsel : in STD_LOGIC_VECTOR (1 downto 0);
           z : out STD_LOGIC);
end ex7_somador_1;

architecture Behavioral of ex7_somador_1 is
	signal suma0, suma1, suma2, suma3  : std_logic_vector (0 downto 0);
	signal sumb0, sumb1, sumb2, sumb3  : std_logic_vector (0 downto 0);
	signal sum0, sum1, sum2, sum3 : std_logic_vector(0 downto 0);
begin
	suma0(0) <= a(0); 
	suma1(0) <= a(1); 
	suma2(0) <= a(2); 
	suma3(0) <= a(3); 
	sumb0(0) <= b(0); 
	sumb1(0) <= b(1); 
	sumb2(0) <= b(2); 
	sumb3(0) <= b(3);
	sum0 <= suma0 + sumb0;
	sum1 <= suma1 + sumb1;
	sum2 <= suma2 + sumb2;
	sum3 <= suma3 + sumb3; 
	
	process (sum0, sum1, sum2, sum3, opsel)
	begin
		case opsel is
			when "00" => z <= sum0(0); 
			when "01" => z <= sum1(0);
			when "10" => z <= sum2(0);
			when "11" => z <= sum3(0);
			when others => z <= '0';
		end case;
	end process;
end Behavioral;
