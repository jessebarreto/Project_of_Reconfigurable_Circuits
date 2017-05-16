----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/12/2017 03:29:07 PM
-- Design Name: 
-- Module Name: tb_sobel_hexim - Behavioral
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
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use work.sobel_parameters.all;

entity kernel_provider_tb is
--    port(
--        --clk     : in    std_logic;
--        --enable  : in    std_logic;
--        eof     : out   std_logic;
--        valid   : out   std_logic;
--        image   : out   std_logic_vector(DATA_WIDTH-1 downto 0));
end kernel_provider_tb;

architecture Behavioral of kernel_provider_tb is


signal mask_out : STD_LOGIC_VECTOR (KERNEL_SIZE*KERNEL_DEPTH - 1 downto 0);
signal mask_out_tmask : TMASK;

component kernel_provider is
    Port ( mask_out : out STD_LOGIC_VECTOR (KERNEL_SIZE*KERNEL_DEPTH - 1 downto 0);
    	   mask_tmask : out TMASK);
end component kernel_provider;

begin

	uut_kernel_provider : kernel_provider port map( mask_out => mask_out, mask_tmask => mask_out_tmask);
	
end Behavioral;
