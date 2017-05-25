----------------------------------------------------------------------------------
-- Company: Universidade de Brasilia
-- Engineer: Jesse Barreto de Barros - 17/0067033
-- 
-- Create Date: 06.05.2017 00:57:36
-- Design Name: Lista 2
-- Module Name: sobelpack - Behavioral
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
use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

package sobelpack is
	-- Parameters
	constant IMAGEWIDTH		:	integer := 250;	-- IMAGE WIDTH
	constant IMAGEHEIGHT	:	integer := 250;	-- IMAGE HEIGHT
	constant PIXELDEPTH 	: 	integer := 10;	-- IMAGE PIXEL DEPTH
	constant TEMPLATESIZE	:	integer := 5;	-- TEMPLATE WINDOW SIZE 3x3, 5x5
	constant TEMPLATEDEPTH	:	integer := 4;	-- TEMPLATE PIXEL DEPTH
	constant MULTDEPTH 		:	integer := 14;			-- MULTIPLIER PIXEL DEPTH 
	
	constant ROMWOMADDRWIDTH:	integer := 14;
	constant ROMDEPTH 		:	integer := PIXELDEPTH;
	constant WOMDEPTH		:	integer := MULTDEPTH;
	
	-- THRESHOLD
	constant THRESHOLD : STD_LOGIC_VECTOR (MULTDEPTH-1 downto 0) := (0 => '0', others => '1');
	
	-- KERNEL TYPE
	type KERNEL is array (1 to TEMPLATESIZE*TEMPLATESIZE) of STD_LOGIC_VECTOR (TEMPLATEDEPTH-1 downto 0);
	
--	constant K : KERNEL := (1 => "001",  -- 1
--							2 => "010",  -- 2
--							3 => "001",  -- 1
--							4 => "000",  -- 0
--							5 => "000",  -- 0
--							6 => "000",  -- 0
--							7 => "111",  -- -1
--							8 => "110",  -- -2
--							9 => "111"); -- -1 
	
	-- KERNEL VALUES 5x5 Y-direction
--	constant K : KERNEL := ( -- ROW 1
--							 1 => "0001", -- 1
--							 2 => "0001", -- 1
--							 3 => "0010", -- 2
--							 4 => "0001", -- 1
--							 5 => "0001", -- 1
--							 -- ROW 2
--							 6 => "0001", -- 1
--							 7 => "0001", -- 1
--							 8 => "0010", -- 2
--							 9 => "0001", -- 1
--							 10 => "0001", -- 1
--							 -- ROW 3
--							 11 => "0000", -- 0			
--							 12 => "0000", -- 0
--							 13 => "0000", -- 0
--							 14 => "0000", -- 0
--							 15 => "0000", -- 0
--							 -- ROW 4
--							 16 => "1111", -- -1
--							 17 => "1111", -- -1
--							 18 => "1110", -- -2
--							 19 => "1111", -- -1
--							 20 => "1111", -- -1
--							 -- ROW 5
--							 21 => "1111", -- -1
--							 22 => "1111", -- -1
--							 23 => "1110", -- -2
--							 24 => "1111", -- -1
--							 25 => "1111"); -- -1
							 
	-- KERNEL VALUES 5x5 X-direction
	 constant K : KERNEL := ( -- ROW 1
							 1 => "0001", -- 1
							 2 => "0001", -- 1
							 3 => "0000", -- 0
							 4 => "1111", -- -1
							 5 => "1111", -- -1
							 -- ROW 2
							 6 => "0001", -- 1
							 7 => "0001", -- 1
							 8 => "0000", -- 0
							 9 => "1111", -- -1
							 10 => "1111", -- -1
							 -- ROW 3
							 11 => "0010", -- 2			
							 12 => "0010", -- 2
							 13 => "0000", -- 0
							 14 => "1110", -- -2
							 15 => "1110", -- -2
							 -- ROW 4
							 16 => "0001", -- 1
							 17 => "0001", -- 1
							 18 => "0000", -- 0
							 19 => "1111", -- -1
							 20 => "1111", -- -1
							 -- ROW 5
							 21 => "0001", -- 1
							 22 => "0001", -- 1
							 23 => "0000", -- 0
							 24 => "1111", -- -1
							 25 => "1111"); -- -1

end package sobelpack;

package body sobelpack is
end sobelpack;