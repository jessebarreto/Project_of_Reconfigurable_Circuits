----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.03.2017 22:55:31
-- Design Name: 
-- Module Name: ex4 - Behavioral
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

entity ex4 is
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
end ex4;

architecture Behavioral of ex4 is
begin
	y1 <= not ((a1 and b1 and c1) or (d1 and e1 and f1));
	y2 <= not ((a2 and b2) or (c2 and d2));
end Behavioral;