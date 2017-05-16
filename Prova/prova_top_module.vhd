----------------------------------------------------------------------------------
-- Company: Universidade de Brasilia
-- Engineer: Jesse Barreto de Barros
-- 
-- Create Date: 
-- Design Name: Prova PCR
-- Module Name: prova_top_module - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity prova_top_module is
	Port	(
				clk			: in	std_logic;
				reset		: in	std_logic;
				start 		: in	std_logic;
				fillCovs	: in	std_logic;
				initCovK	: in	std_logic_vector (FP_WIDTH-1 downto 0);
				initCovZ	: in	std_logic_vector (FP_WIDTH-1 downto 0);
				yUl			: in	std_logic_vector (FP_WIDTH-1 downto 0);
				yIr			: in	std_logic_vector (FP_WIDTH-1 downto 0);
				xFusion		: out	std_logic_vector (FP_WIDTH-1 downto 0);
				xUl			: out	std_logic_vector (FP_WIDTH-1 downto 0);
				xIr			: out	std_logic_vector (FP_WIDTH-1 downto 0);
				ready		: out	std_logic
			);
end prova_top_module;

architecture Behavioral of prova_top_module is
	-- Components
	component DistanceCalculator is
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
	end component DistanceCalculator;
	
	component GainCalculator is
	    Port ( reset 	: in	STD_LOGIC;
	           clk 		: in	STD_LOGIC;
	           start 	: in	STD_LOGIC;
	           covK		: in	std_logic_vector (FP_WIDTH-1 downto 0);
	           covZ		: in	std_logic_vector (FP_WIDTH-1 downto 0);
	           gainK	: out	std_logic_vector (FP_WIDTH-1 downto 0);
	           ready	: out	std_logic);
	end component GainCalculator;
	
	component DataFusion is
	    Port ( reset 	: in 	STD_LOGIC;
	           clk 		: in 	STD_LOGIC;
	           start 	: in 	STD_LOGIC;
	           xUl		: in	std_logic_vector (FP_WIDTH-1 downto 0);
	           xIr		: in	std_logic_vector (FP_WIDTH-1 downto 0);
	           gainK	: in	std_logic_vector (FP_WIDTH-1 downto 0);
	           xFusion	: out	std_logic_vector (FP_WIDTH-1 downto 0);
	           ready	: out	std_logic);
	end component DataFusion;
	
	component AtualizaCovariancia is
	    Port ( reset 	: in 	STD_LOGIC;
	           clk 		: in 	STD_LOGIC;
	           start 	: in 	STD_LOGIC;
	           gainK	: in 	std_logic_vector (FP_WIDTH-1 downto 0);
	           covK		: in 	std_logic_vector (FP_WIDTH-1 downto 0);
	           covK_1	: out	std_logic_vector (FP_WIDTH-1 downto 0);
	           ready	: out	std_logic);
	end component AtualizaCovariancia;
	
	-- Regristradores
	signal regCovK : std_logic_vector (FP_WIDTH-1 downto 0) := (others => '0');
	signal regCovZ : std_logic_vector (FP_WIDTH-1 downto 0) := (others => '0');
	
	-- Sinais	
	-- Dist Calc
	signal sigDistCalcReady : std_logic := '0';
	signal sigXUl : std_logic_vector (FP_WIDTH-1 downto 0) := (others => '0');
	signal sigXIr : std_logic_vector (FP_WIDTH-1 downto 0) := (others => '0');
	
	-- Gain Calc
	signal sigGainCalcReady : std_logic := '0';
	signal sigGainCalcRes : std_logic_vector (FP_WIDTH-1 downto 0) := (others => '0');
	
	-- Fusion
	signal sigXFusion	: std_logic_vector (FP_WIDTH-1 downto 0) := (others => '0');
	signal sigFusionReady : std_logic := '0';
	
	-- Cov Update
	signal sigNewCovK	: std_logic_vector (FP_WIDTH-1 downto 0) := (others => '0');
	signal sigNewCovKReady : std_logic := '0';
	 
begin
	--  Covariance Registers
	process(clk, reset, fillCovs)
	begin
		if rising_edge(clk) then
			if reset = '1' then
				regCovK <= (others => '0');
				regCovZ <= (others => '0');
			elsif fillCovs = '1' then
				regCovK <= initCovK;
				regCovZ <= initCovZ;
			elsif sigNewCovKReady = '1' then
				regCovK <= sigNewCovK;
			end if;
		end if;
	end process;
		
	
	-- Distance Calculator
	distCalc : DistanceCalculator port map
		(
			clk => clk,
			reset => reset,
			start => start,
			yUl => yUl,
			yIr => yIr,
			xUl => sigXUl,
			xIr => sigXIr,
			ready => sigDistCalcReady 		
		);
	xUl <= sigXUl;
	xIr <= sigXIr;
	
	-- Gain Calc
	gainCalc : GainCalculator port map
		(
			reset => reset,
			clk	=> clk,
			start => start,
			covK => regCovK,
			covZ => regCovZ,
			gainK => sigGainCalcRes,
			ready => sigGainCalcReady
		);
	
	-- Data Fusion
	fusion : DataFusion port map
		(
			reset 	=> reset,
			clk		=> clk,
			start 	=> sigGainCalcReady,
			xUl		=> sigXUl,
			xIr		=> sigXIr,
			gainK	=> sigGainCalcRes,
			xFusion	=> sigXFusion,
			ready	=> sigFusionReady
		);
	xFusion <= sigXFusion;
	ready <= sigFusionReady;
	
	-- Atualiza Covariancia
	updateCovs: AtualizaCovariancia port map
		(
			reset 	=> reset,
			clk 	=> clk,
			start 	=> sigGainCalcReady,
			gainK	=> sigGainCalcRes,
			covK	=> regCovK,
			covK_1	=> sigNewCovK,
			ready 	=> sigNewCovKReady
		);
	
end Behavioral;
