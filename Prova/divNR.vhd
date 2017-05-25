-------------------------------------------------
-- Company:       GRACO-UnB
-- Engineer:      DANIEL MAURICIO MUÑOZ ARBOLEDA
-- 
-- Create Date:   22-Oct-2012 
-- Design name:   divNR 
-- Module name:   divNR - behavioral
-- Description:   floating-point division using Newton-Raphson
--                modified from Diego F. Sanchez Master Thesis
-- Automatically generated using the vFPUgen.m v1.0
-------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.fpupack.all;
use work.entities.all;

entity divNR is
	port (reset      :  in std_logic;
		  clk        :  in std_logic;
		  op_a 		 :  in std_logic_vector(FP_WIDTH-1 downto 0);
		  op_b 		 :  in std_logic_vector(FP_WIDTH-1 downto 0);
		  start_i    :  in std_logic;
		  div_out    : out std_logic_vector(FP_WIDTH-1 downto 0);
		  ready_div  : out std_logic);
end divNR;

architecture Behavioral of divNR is

type RAM is array(FRAC_WIDTH-2 downto 0) of std_logic;
type RRAM is array(TSed downto 0) of RAM;
signal MEM : RRAM := ("00000111010100000",--1
                      "00001111000011101",--2
                      "00010111010001011",--3
                      "00011111111111111",--4
                      "00101001010010100",--5
                      "00110011001100110",--6
                      "00111101110010101",--7
                      "01001001001001001",--8
                      "01010101010101010",--9
                      "01100010011101100",--10
                      "01110000101000111",--11
                      "01111111111111111",--12
                      "10010000101100100",--13
                      "10100010111010001",--14
                      "10110110110110110",--15
                      "11100101000011010");--16

signal SgnNumer	: std_logic := '0';
signal ExpNumer	: std_logic_vector(EXP_WIDTH-1 downto 0) := (others => '0');
signal MntNumer	: std_logic_vector(FRAC_WIDTH downto 0)  := (others => '0');
signal SgnDnmnd	: std_logic := '0';
signal ExpDnmnd	: std_logic_vector(EXP_WIDTH-1 downto 0) := (others => '0');
signal MntDnmnd	: std_logic_vector(FRAC_WIDTH downto 0)  := (others => '0');
signal MntResul	: std_logic_vector(FRAC_WIDTH downto 0)  := (others => '0');
signal Expoente	: std_logic_vector(EXP_WIDTH-1 downto 0) := (others => '0');
signal CpiaResul	: std_logic_vector(FP_WIDTH-1 downto 0)  := (others => '0');
signal CalDiv		: std_logic := '0';
signal FinDiv		: std_logic := '0';
signal SAddr     	: integer range 0 TO TSed;
signal SDOut     	: std_logic_vector(FRAC_WIDTH-2 downto 0);
signal Ea        	: std_logic_vector(FRAC_WIDTH downto 0) := (others => '0');
signal opA_mul		: std_logic_vector(FRAC_WIDTH downto 0) := (others => '0');
signal opB_mul		: std_logic_vector(FRAC_WIDTH downto 0) := (others => '0');
signal out_mul		: std_logic_vector(FRAC_WIDTH*2+1 downto 0) := (others => '0');
signal start_mul	: std_logic := '0';

type State_Type is (Start,NewtonRaphson,Result,ResultEc);
signal State : State_Type := Start;

type   t_state is (waiting,selseed,mul1,compl);
signal pr_state, nx_state : t_state := waiting;

begin

process(op_b)
begin
	if op_b(FRAC_WIDTH-1 downto 0) <= "011000111000111001" then
       if op_b(FRAC_WIDTH-1 downto 0) <= "000011100011100011" then SAddr <= 0;
		elsif op_b(FRAC_WIDTH-1 downto 0) < "000111000111000111" then SAddr <= 1;
		elsif op_b(FRAC_WIDTH-1 downto 0) < "001010101010101010" then SAddr <= 2;
		elsif op_b(FRAC_WIDTH-1 downto 0) < "001110001110001110" then SAddr <= 3;
		elsif op_b(FRAC_WIDTH-1 downto 0) < "010001110001110001" then SAddr <= 4;
		elsif op_b(FRAC_WIDTH-1 downto 0) < "010101010101010101" then SAddr <= 5;
		elsif op_b(FRAC_WIDTH-1 downto 0) < "011000111000111001" then SAddr <= 6;
		else SAddr <= 7;
		end if;
	else
       if op_b(FRAC_WIDTH-1 downto 0) <= "011100011100011100" then SAddr <= 8;
		elsif op_b(FRAC_WIDTH-1 downto 0) < "100000000000000000" then SAddr <= 9;
		elsif op_b(FRAC_WIDTH-1 downto 0) < "100011100011100011" then SAddr <= 10;
		elsif op_b(FRAC_WIDTH-1 downto 0) < "100111000111000111" then SAddr <= 11;
		elsif op_b(FRAC_WIDTH-1 downto 0) < "101010101010101011" then SAddr <= 12;
		elsif op_b(FRAC_WIDTH-1 downto 0) < "101110001110001110" then SAddr <= 13;
		elsif op_b(FRAC_WIDTH-1 downto 0) < "110001110001110010" then SAddr <= 14;
		elsif op_b(FRAC_WIDTH-1 downto 0) < "110101010101010101" then SAddr <= 15;
		else SAddr <= 15;
		end if;
	end if;
end process;

Expoente <= ExpNumer - ExpDnmnd + bias;

SgnNumer <= op_a(FP_WIDTH-1);
SgnDnmnd <= op_b(FP_WIDTH-1);
ExpNumer <= op_a(FP_WIDTH-2 downto FRAC_WIDTH);
ExpDnmnd <= op_b(FP_WIDTH-2 downto FRAC_WIDTH);
MntNumer <= ('1' & op_a(FRAC_WIDTH-1 downto 0));
MntDnmnd <= ('1' & op_b(FRAC_WIDTH-1 downto 0));

FMul1 : fixMul
port map (op_a    => opA_mul,
			 op_b    => opB_mul,
			 mul_out => out_mul);

process(reset,clk)
variable P		: std_logic_vector(FRAC_WIDTH downto 0) := (others => '0');
variable Vax 	: std_logic_vector(FRAC_WIDTH downto 0) := (others => '0');
variable cont  : integer range 0 to Niter;
begin
	if rising_edge(clk)	then
		if reset='1' then
			nx_state <= waiting;
			P			:= (others => '0');
			Vax		:= (others => '0');
			Ea 		<= (others => '0');
			opA_mul  <= (others => '0');
			opB_mul  <= (others => '0');
			cont     := 0;
			FinDiv	<= '0';
		else
			case nx_state is
				when waiting =>
					P		:= (others => '0');
					Vax		:= (others => '0');
					FinDiv	<= '0';
					cont     := 0;
					SDOut <= std_logic_vector((MEM(SAddr)));
					if CalDiv = '1' then
						nx_state <= selseed;
					else
						nx_state <= waiting;
					end if;

				when selseed =>
					Ea 		<= ("01" & SDOut);
					opA_mul  <= MntDnmnd;
					opB_mul  <= ("01" & SDOut);
					nx_state <= mul1;

				when mul1 =>
					P  		:= out_mul(FRAC_WIDTH*2 downto FRAC_WIDTH);
					Vax 		:= not(P) + '1';
					opA_mul  <= Ea;
					opB_mul  <= Vax;
					FinDiv	<= '0';
					nx_state <= compl;

				when compl =>
					Ea 		<= out_mul(FRAC_WIDTH*2 downto FRAC_WIDTH);
					cont     := cont + 1;
					if cont = Niter then
						opA_mul  <= MntNumer;
						opB_mul  <= out_mul(FRAC_WIDTH*2 downto FRAC_WIDTH);
						FinDiv   <= '1';
						nx_state <= waiting;
					else
						opA_mul  <= MntDnmnd;
						opB_mul  <= out_mul(FRAC_WIDTH*2 downto FRAC_WIDTH);
						FinDiv   <= '0';
						nx_state <= mul1;
					end if;

				when others =>
					nx_state <= waiting;
			end case;
		end if;
	end if;
end process;

CntrlGral: process(clk,reset)
variable ExpoenteR	: std_logic_vector(EXP_WIDTH -1  downto 0) := (others => '0');
begin
	if rising_edge(clk) then
		if reset = '1' then
			State	<= Start;
			CalDiv	<= '0';
			ExpoenteR	:= (others => '0');
			CpiaResul	<= (others => '0');
			MntResul		<= (others => '0');
		else
 			case State is
 				when Start=>
 					if start_i = '1' then
 						if op_a = Zero AND op_b = Zero then
 							CpiaResul <= Inf; --Infinito Positivo
 							State <= ResultEc;
 							CalDiv <= '0';
 						elsif op_a = op_b then
 							CpiaResul <= s_one;
 							State <= ResultEc;
 							CalDiv <= '0';
 						elsif op_a = Zero then
 							CpiaResul <= Zero;
 							State <= ResultEc;
 							CalDiv <= '0';
 						elsif op_b = Zero then
 							CpiaResul <= Inf; --Infinito Positivo
 							State <= ResultEc;
 							CalDiv <= '0';
						elsif op_a(FRAC_WIDTH-1 downto 0) = op_b(FRAC_WIDTH-1 downto 0) then
 							MntResul <= OneM;
 							State <= Result;
 							CalDiv <= '0';
 						else
 							State <= NewtonRaphson;
 							CalDiv <= '1';
 						end if;
					else
					   CalDiv <= '0';
					   State	<= Start;
                  ready_div <= '0';
 					end if;

 				when NewtonRaphson=>
					CalDiv <= '0';
 					if FinDiv = '1' then
						MntResul <= out_mul(FRAC_WIDTH*2 downto FRAC_WIDTH);
						State <= Result;
 					end if;
 					ready_div <= '0';

 				when Result=>
 					CpiaResul(FP_WIDTH-1) <= SgnNumer XOR SgnDnmnd;
 					if MntResul(FRAC_WIDTH) = '0' then
 						ExpoenteR := Expoente - 1;
 						CpiaResul(FRAC_WIDTH-1 downto 0) <= (MntResul(FRAC_WIDTH-2 downto 0) & '0');
 					else
 						ExpoenteR := Expoente;
 						CpiaResul(FRAC_WIDTH-1 downto 0) <= MntResul(FRAC_WIDTH-1 downto 0);
 					end if;
 					CpiaResul(FP_WIDTH-2 downto FRAC_WIDTH) <= ExpoenteR;
 					ready_div <= '1';
 					State <= Start;

 				when ResultEc=>
 					ready_div <= '1';
 					State <= Start;

				when others => null;
 			end case;
		end if;
	end if;
end process;

div_out <= CpiaResul;

end Behavioral;
