----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.05.2017 13:41:54
-- Design Name: 
-- Module Name: DistanceCalculator - Behavioral
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

entity DistanceCalculator is
	Port
		(
			clk			: in	std_logic;
			reset		: in	std_logic;
			start 		: in	std_logic;
			yUl			: in	std_logic_vector (FP_WIDTH-1 downto 0);
			yIr			: in	std_logic_vector (FP_WIDTH-1 downto 0);
			xUl			: out	std_logic_vector (FP_WIDTH-1 downto 0);
			xIr			: out	std_logic_vector (FP_WIDTH-1 downto 0);
			ready		: out	std_logic
		);
end DistanceCalculator;

architecture Behavioral of DistanceCalculator is
	-- Distance Equations Parameters
	constant AIR : std_logic_vector (FP_WIDTH-1 downto 0) := "001110101001110101001001010"; -- 0.0012
	constant BIR : std_logic_vector (FP_WIDTH-1 downto 0) := "101111110110001111010111000"; -- -0.89
	constant CIR : std_logic_vector (FP_WIDTH-1 downto 0) := "010000101111111000000000000"; -- 127
	constant AUL : std_logic_vector (FP_WIDTH-1 downto 0) := "001111111010011001100110011"; -- 1.3
	constant BUL : std_logic_vector (FP_WIDTH-1 downto 0) := "010000000000000000000000000"; -- 2
	
	-- Signals
	signal sigResMulUl : std_logic_vector (FP_WIDTH-1 downto 0) := (others => '0');
	signal sigResUl : std_logic_vector (FP_WIDTH-1 downto 0) := (others => '0');
	signal sigReadyMulUl : std_logic := '0';
	signal sigReadyUl : std_logic := '0';
	
	signal sigResMul1x1Ir : std_logic_vector (FP_WIDTH-1 downto 0) := (others => '0');
	signal sigReadyMul1x1Ir : std_logic := '0';
	signal sigResMul2x1Ir : std_logic_vector (FP_WIDTH-1 downto 0) := (others => '0');
	signal sigReadyMul2x1Ir : std_logic := '0';
	signal sigResMul1x2Ir : std_logic_vector (FP_WIDTH-1 downto 0) := (others => '0');
	signal sigReadyMul1x2Ir : std_logic := '0';
	signal sigResAdd1x3Ir : std_logic_vector (FP_WIDTH-1 downto 0) := (others => '0');
	signal sigReadyAdd1x3Ir : std_logic := '0'; 
	signal sigResIr : std_logic_vector (FP_WIDTH-1 downto 0) := (others => '0');
	signal sigReadyIr : std_logic := '0';
	 
begin
	---------------------------------------------
	-- Linear Equation for Ul
	MultLinear_Ul: multiplierfsm_v2
		port map 
			(
				reset     => reset,
				clk       => clk,
				op_a      => yUl,
				op_b      => AUL,
				start_i	  => start,
				mul_out   => sigResMulUl,
				ready_mul => sigReadyMulUl 
			);
			
	AddLinear_Ul: addsubfsm_v6
		port map
			(
				reset     => reset,
				clk       => clk,
				op		  => '0',
				op_a      => sigResMulUl,
				op_b      => BUL,
				start_i	  => sigReadyMulUl,
				addsub_out   => sigResUl,
				ready_as => sigReadyUl 
			);
	xUl <= sigResUl;
	----------------------------------------------
	-- Quadratic Equation
	Mult1x1Quad_Ir: multiplierfsm_v2
		port map 
			(
				reset     => reset,
				clk       => clk,
				op_a      => yIr,
				op_b      => yIr,
				start_i	  => start,
				mul_out   => sigResMul1x1Ir,
				ready_mul => sigReadyMul1x1Ir 
			);
	
	Mult2x1Quad_Ir: multiplierfsm_v2
		port map 
			(
				reset     => reset,
				clk       => clk,
				op_a      => yIr,
				op_b      => BIR,
				start_i	  => start,
				mul_out   => sigResMul2x1Ir,
				ready_mul => sigReadyMul2x1Ir 
			);
			
	Mult1x2Quad_Ir: multiplierfsm_v2
		port map 
			(
				reset     => reset,
				clk       => clk,
				op_a      => AIR,
				op_b      => sigResMul1x1Ir,
				start_i	  => sigReadyMul1x1Ir,
				mul_out   => sigResMul1x2Ir,
				ready_mul => sigReadyMul1x2Ir 
			);
	
	Add1x3Quad_Ir: addsubfsm_v6
		port map
			(
				reset     => reset,
				clk       => clk,
				op		  => '0',
				op_a      => sigResMul1x2Ir,
				op_b      => sigResMul2x1Ir,
				start_i	  => sigReadyMul1x2Ir,
				addsub_out   => sigResAdd1x3Ir,
				ready_as => sigReadyAdd1x3Ir 
			);
	
	Add1x4Quad_Ir: addsubfsm_v6 port map
		(
			reset     => reset,
			clk       => clk,
			op		  => '0',
			op_a      => CIR,
			op_b      => sigResAdd1x3Ir,
			start_i	  => sigReadyAdd1x3Ir,
			addsub_out   => sigResIr,
			ready_as => sigReadyIr 
		);
	xIr <= sigResIr;
	ready <= sigReadyIr;

end Behavioral;
