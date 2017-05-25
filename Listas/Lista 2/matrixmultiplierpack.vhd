----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.05.2017 18:06:02
-- Design Name: 
-- Module Name: matrixmultiplierpack - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.entities.all;
use work.fpupack.all;

package matrixmultiplierpack is

	-- Parameters
	constant MATRIXSIZE : integer := 3;
	
	-- Types
	type Matrix is array (1 to MATRIXSIZE*MATRIXSIZE) of STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
	type Matrices is array (1 to MATRIXSIZE*MATRIXSIZE*MATRIXSIZE) of STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
		

end matrixmultiplierpack;

package body matrixmultiplierpack is
end matrixmultiplierpack;
