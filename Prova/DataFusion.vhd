----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.05.2017 22:22:08
-- Design Name: 
-- Module Name: DataFusion - Behavioral
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
use work.fpupack.all;
use work.entities.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DataFusion is
    Port ( reset 	: in 	STD_LOGIC;
           clk 		: in 	STD_LOGIC;
           start 	: in 	STD_LOGIC;
           xUl		: in	std_logic_vector (FP_WIDTH-1 downto 0);
           xIr		: in	std_logic_vector (FP_WIDTH-1 downto 0);
           gainK	: in	std_logic_vector (FP_WIDTH-1 downto 0);
           xFusion	: out	std_logic_vector (FP_WIDTH-1 downto 0);
           ready	: out	std_logic);
end DataFusion;

architecture Behavioral of DataFusion is

	-- Signals
	signal sigSubRes : std_logic_vector (FP_WIDTH-1 downto 0) := (others => '0');
	signal sigSubReady : std_logic := '0';
	
	signal sigMulRes : std_logic_vector (FP_WIDTH-1 downto 0) := (others => '0');
	signal sigMulReady : std_logic := '0';
begin
	
	-- Subtract
	Sub: addsubfsm_v6
		port map
			(
				reset     => reset,
				clk       => clk,
				op		  => '1',
				op_a      => xIr,
				op_b      => xUl,
				start_i	  => start,
				addsub_out   => sigSubRes,
				ready_as => sigSubReady 
			);
			
	-- Multiplier
	Mult: multiplierfsm_v2
		port map 
			(
				reset     => reset,
				clk       => clk,
				op_a      => gainK,
				op_b      => sigSubRes,
				start_i	  => sigSubReady,
				mul_out   => sigMulRes,
				ready_mul => sigMulReady 
			);
	
	-- Adder
	Adder: addsubfsm_v6
		port map
			(
				reset     => reset,
				clk       => clk,
				op		  => '0',
				op_a      => sigMulRes,
				op_b      => xUl,
				start_i	  => sigMulReady,
				addsub_out   => xFusion,
				ready_as => ready 
			);
	
end Behavioral;
