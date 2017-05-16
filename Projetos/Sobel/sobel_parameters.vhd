----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.04.2017 08:44:32
-- Design Name: 
-- Module Name: sobel_parameters - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

PACKAGE sobel_parameters IS
	constant IMAGE_WIDTH : integer := 100;
	constant IMAGE_HEIGTH : integer := 100;
	constant IMAGE_SIZE : integer := IMAGE_WIDTH*IMAGE_HEIGTH;
	constant PIXEL_DEPTH : integer := 8;
	constant KERNEL_DEPTH : integer := 3;
	constant KERNEL_WIDTH : integer := 3;
	constant KERNEL_SIZE : integer := KERNEL_WIDTH*KERNEL_WIDTH;

	type TMASK is array (1 to KERNEL_SIZE) of integer;

END sobel_parameters;
