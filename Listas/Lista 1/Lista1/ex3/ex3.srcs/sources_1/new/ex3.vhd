----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.03.2017 14:53:35
-- Design Name: 
-- Module Name: ex3 - Behavioral
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

entity ex3 is
    Port ( a : in STD_LOGIC;
    	   b : in STD_LOGIC;
    	   c : in STD_LOGIC;
    	   d : in STD_LOGIC;
    	   e : in STD_LOGIC;
    	   f : in STD_LOGIC;
    	   g : in STD_LOGIC;
    	   h : in STD_LOGIC;
    	   y : out std_logic);
end ex3;

architecture Behavioral of ex3 is
begin
	y <= not ((a and b and c and d) or (e and f and g and h));
end Behavioral;
