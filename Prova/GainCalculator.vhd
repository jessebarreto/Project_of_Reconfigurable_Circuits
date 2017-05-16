----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.05.2017 22:22:08
-- Design Name: 
-- Module Name: GainCalculator - Behavioral
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

entity GainCalculator is
    Port ( reset 	: in	STD_LOGIC;
           clk 		: in	STD_LOGIC;
           start 	: in	STD_LOGIC;
           covK		: in	std_logic_vector (FP_WIDTH-1 downto 0);
           covZ		: in	std_logic_vector (FP_WIDTH-1 downto 0);
           gainK	: out	std_logic_vector (FP_WIDTH-1 downto 0);
           ready	: out	std_logic);
end GainCalculator;

architecture Behavioral of GainCalculator is
	-- Divisor
	component divNR is
	port (reset      :  in std_logic;
		  clk        :  in std_logic;
		  op_a 		 :  in std_logic_vector(FP_WIDTH-1 downto 0);
		  op_b 		 :  in std_logic_vector(FP_WIDTH-1 downto 0);
		  start_i    :  in std_logic;
		  div_out    : out std_logic_vector(FP_WIDTH-1 downto 0);
		  ready_div  : out std_logic);
	end component divNR;
	
	-- Signals
	signal resAdder : std_logic_vector(FP_WIDTH-1 downto 0) := (others => '0');
	signal readyAdder : std_logic := '0';
	signal resDiv : std_logic_vector(FP_WIDTH-1 downto 0) := (others => '0');
	signal readyDiv : std_logic := '0';
	
begin
	-- Adder
	Adder: addsubfsm_v6
		port map
			(
				reset     => reset,
				clk       => clk,
				op		  => '0',
				op_a      => covK,
				op_b      => covZ,
				start_i	  => start,
				addsub_out   => resAdder,
				ready_as => readyAdder 
			);
	
	-- Divider
	Divider : divNR
		port map
			(
				reset     => reset,
				clk       => clk,
				op_a      => covK,
				op_b      => resAdder,
				start_i	  => readyAdder,
				div_out   => resDiv,
				ready_div => readyDiv 
			);
	
	gainK <= resDiv;
	ready <= readyDiv;

end Behavioral;
