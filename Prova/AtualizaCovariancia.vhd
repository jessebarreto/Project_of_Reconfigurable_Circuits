----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.05.2017 22:00:28
-- Design Name: 
-- Module Name: AtualizaCovariancia - Behavioral
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

entity AtualizaCovariancia is
    Port ( reset 	: in 	STD_LOGIC;
           clk 		: in 	STD_LOGIC;
           start 	: in 	STD_LOGIC;
           gainK	: in 	std_logic_vector (FP_WIDTH-1 downto 0);
           covK		: in 	std_logic_vector (FP_WIDTH-1 downto 0);
           covK_1	: out	std_logic_vector (FP_WIDTH-1 downto 0);
           ready	: out	std_logic);
end AtualizaCovariancia;

architecture Behavioral of AtualizaCovariancia is

	-- Signals
	signal sigMulReady : std_logic := '0';
	signal sigMulRes : std_logic_vector (FP_WIDTH-1 downto 0) := (others => '0');
	
begin
	-- Multiplier
	Mult: multiplierfsm_v2
		port map 
			(
				reset     => reset,
				clk       => clk,
				op_a      => gainK,
				op_b      => covK,
				start_i	  => start,
				mul_out   => sigMulRes,
				ready_mul => sigMulReady 
			);
	
	-- Subtract
	Sub: addsubfsm_v6
		port map
			(
				reset     => reset,
				clk       => clk,
				op		  => '1',
				op_a      => covK,
				op_b      => sigMulRes,
				start_i	  => sigMulReady,
				addsub_out   => covK_1,
				ready_as => ready 
			);

end Behavioral;
