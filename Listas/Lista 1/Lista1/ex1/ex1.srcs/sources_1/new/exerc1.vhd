----------------------------------------------------------------------------------
-- Company:  Universidade de Brasilia
-- Engineer: Jesse Barreto de Barros
-- 
-- Create Date: 25.03.2017 15:10:53
-- Design Name: 
-- Module Name: exerc1 - Behavioral
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

entity exerc1 is
  Port ( a : in  std_logic;
  		 b : in  std_logic;
  		 c : in  std_logic;
  		 d : out std_logic);
end exerc1;

architecture Behavioral of exerc1 is
begin
	d <= not (a and ((a and b) or not c));
end Behavioral;
