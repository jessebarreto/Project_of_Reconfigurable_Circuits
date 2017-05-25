----------------------------------------------------------------------------------
-- Company: Universidade de Brasilia
-- Engineer: Jesse Barreto de Barros - 17/0067033
-- 
-- Create Date: 06.05.2017 00:57:36
-- Design Name: Lista 2
-- Module Name: lista2_sobel - Behavioral
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
use work.sobelpack.all;

entity lista2_sobel is
    Port	(	reset	:	in	STD_LOGIC;
			   	clk		:	in	STD_LOGIC;
			   	pixin	:	in	STD_LOGIC_VECTOR (PIXELDEPTH-1 downto 0);
			   	pixout	:	out	STD_LOGIC_VECTOR (MULTDEPTH-1 downto 0);
			   	enable	:	out	STD_LOGIC;
			   	ready	:	out	STD_LOGIC 
			);
end entity lista2_sobel;

architecture Behavioral of lista2_sobel is

-- Components
component lista2_sobel_conv is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           kernelval : in STD_LOGIC_VECTOR (TEMPLATEDEPTH-1 downto 0);
           neighval : in STD_LOGIC_VECTOR (PIXELDEPTH-1 downto 0);
           multres : out STD_LOGIC_VECTOR (MULTDEPTH-1 downto 0));
end component lista2_sobel_conv;

-- Types
type NEIGHBOURHOOD is array (1 to TEMPLATESIZE*TEMPLATESIZE) of STD_LOGIC_VECTOR (PIXELDEPTH-1 downto 0);
type MULTIPLIERS is array (1 to TEMPLATESIZE*TEMPLATESIZE) of STD_LOGIC_VECTOR (MULTDEPTH-1 downto 0);

-- Constants
constant BLACKPIXEL : STD_LOGIC_VECTOR (PIXELDEPTH-1 downto 0) := (others => '0');
constant ZEROMULTIPLIER : STD_LOGIC_VECTOR (MULTDEPTH-1 downto 0) := (others => '0');

-- Registrador de Deslocamento
-- Melhorar utilizando BRAM da Xilinx
signal regNeighbours : STD_LOGIC_VECTOR (((((TEMPLATESIZE-1)*IMAGEWIDTH + TEMPLATESIZE) * PIXELDEPTH)-1) downto 0) := (others => '0');

-- 								SIGNALS
-- Neighbours
signal sigNeighbours : NEIGHBOURHOOD := (others => BLACKPIXEL);
-- Multipliers 
signal sigMultipliers : MULTIPLIERS := (others => ZEROMULTIPLIER);
-- Sum
signal sigSum : STD_LOGIC_VECTOR (MULTDEPTH-1 downto 0) := (others => '0');
-- PixelOut
signal sigPixOut : STD_LOGIC_VECTOR (PIXELDEPTH-1 downto 0) := BLACKPIXEL;
-- Counter for Enable
signal cntEnable	: integer range 1 to ((1 + TEMPLATESIZE / 2) * IMAGEWIDTH + (3 * TEMPLATESIZE / 2));
signal sigEnable	: STD_LOGIC := '0';
-- Counter for Ready
signal cntReady		: integer range 1 to IMAGEWIDTH*IMAGEHEIGHT;

begin
	-- Enable Counter Process
	process(clk, reset)
	begin
		if rising_edge(clk) then
			if reset = '1' then
				cntEnable <= 1;
				sigEnable <= '0';
			elsif cntEnable = ((1 + TEMPLATESIZE / 2) * IMAGEWIDTH + (3 * TEMPLATESIZE / 2)) then
				cntEnable <= 1;
				sigEnable <= '1';
			else
				cntEnable <= cntEnable + 1;
			end if;
		end if;
	end process;
	enable <= sigEnable;

	-- Ready Counter Process
	process(clk, reset)
	begin
		if rising_edge(clk) then
			if reset = '1' then
				cntReady <= 1;
				ready <= '0';
			elsif cntReady = IMAGEWIDTH*IMAGEHEIGHT then
				cntReady <= 1;
				ready <= '1';
			else
				cntReady <= cntReady + 1;
			end if;
		end if;
	end process;
	
	-- Shift Register Filler Process
	process(clk, reset)
	begin
		if rising_edge(clk) then
			if reset = '1' then
				regNeighbours <= (others => '0');
			else
				regNeighbours <= pixin & regNeighbours(((((TEMPLATESIZE-1)*IMAGEWIDTH + TEMPLATESIZE) * PIXELDEPTH)-1) downto PIXELDEPTH);
			end if;
		end if;
	end process;
	
	-- Windowing
	WindowingGenRow : for i in 1 to TEMPLATESIZE generate
		WindowingGenCol : for j in 1 to TEMPLATESIZE generate
			sigNeighbours((i-1)*TEMPLATESIZE + j) <= regNeighbours((((i-1)*IMAGEWIDTH + j)*PIXELDEPTH)-1 downto ((i-1)*IMAGEWIDTH + (j-1))*PIXELDEPTH);
		end generate;
	end generate;
	
	-- Convolution Operation
	ConvGenRow : for i in 1 to TEMPLATESIZE generate
		ConvGenCol : for j in 1 to TEMPLATESIZE generate
			CONVX :  lista2_sobel_conv port map(
						clk => clk,
						reset => reset,
			           	kernelval => K((i-1)*TEMPLATESIZE + j),
			           	neighval => sigNeighbours((i-1)*TEMPLATESIZE + j),
			           	multres => sigMultipliers((i-1)*TEMPLATESIZE + j)
					);
		end generate;
	end generate;
	
	-- Convolution Output
	process(clk, reset)
		variable varSum : STD_LOGIC_VECTOR (MULTDEPTH-1 downto 0) := ZEROMULTIPLIER;
	begin
		if rising_edge(clk) then
			if reset = '1' then
				sigSum <= (others => '0');
			else
				varSum := ZEROMULTIPLIER;
				for i in 1 to TEMPLATESIZE loop
					for j in 1 to TEMPLATESIZE loop
						varSum := varSum + sigMultipliers((i -1)*TEMPLATESIZE + j);
					end loop;
				end loop;
				sigSum <= varSum;
			end if;
		end if;
	end process;
	
	-- Output
	pixout <= sigSum;
	
end Behavioral;
