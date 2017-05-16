----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.03.2017 05:08:02
-- Design Name: 
-- Module Name: ex5_greaterthan_2bits - Behavioral
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

entity ex5_greaterthan_2bits is
    Port ( a : in STD_LOGIC_VECTOR (1 downto 0);
           b : in STD_LOGIC_VECTOR (1 downto 0);
           z : out STD_LOGIC);
end ex5_greaterthan_2bits;

architecture Behavioral of ex5_greaterthan_2bits is
begin
-- SOMA DE PRODUTOS COMPLETA
--	z <= (	((not a(1)) and (a(0)) and (not b(1)) and (not b(0))) or
--			((a(1)) and (not a(0)) and (not b(1)) and (not b(0))) or
--			((a(1)) and (not a(0)) and (not b(1)) and (b(0))) or
--			((a(1)) and (a(0)) and (not b(1)) and (not b(0))) or
--			((a(1)) and (a(0)) and (b(1)) and (not b(0))) or
--			((a(1)) and (a(0)) and (not b(1)) and (b(0))));
	z <= (a(1) and (not b(1))) or ((a(1)) and (a(0)) and (not b(0))) or ((a(0)) and (not b(1)) and (not b(0)));

end Behavioral;
