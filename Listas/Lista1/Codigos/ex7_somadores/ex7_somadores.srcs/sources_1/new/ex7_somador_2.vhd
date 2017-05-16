----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.03.2017 20:27:24
-- Design Name: 
-- Module Name: ex7_somador_2 - Behavioral
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

entity ex7_somador_2 is
	Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
           b : in STD_LOGIC_VECTOR (3 downto 0);
           opsel : in STD_LOGIC_VECTOR (1 downto 0);
           z : out STD_LOGIC);
end ex7_somador_2;

architecture Behavioral of ex7_somador_2 is
	signal mux1_out, mux2_out : std_logic;
	signal z_aux, mux1_aux, mux2_aux : std_logic_vector(0 downto 0);
begin
	process(opsel, a)
	begin
		case opsel is
			when "00" => mux1_out <= a(0);
			when "01" => mux1_out <= a(1);
			when "10" => mux1_out <= a(2);
			when "11" => mux1_out <= a(3);
			when others => mux1_out <= '0';
		end case;
	end process;

	process(opsel, b)
	begin
		case opsel is
			when "00" => mux2_out <= b(0);
			when "01" => mux2_out <= b(1);
			when "10" => mux2_out <= b(2);
			when "11" => mux2_out <= b(3);
			when others => mux2_out <= '0';
		end case;
	end process;
	
	mux1_aux(0) <= mux1_out;
	mux2_aux(0) <= mux2_out;
	z_aux <= mux1_aux + mux2_aux; 
	z <= z_aux(0);

end Behavioral;
