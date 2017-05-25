----------------------------------------------------------------------------------
-- Company: Universidade de Brasilia
-- Engineer: Jesse Barreto de Barros - 17/0067033
-- 
-- Create Date: 06.05.2017 00:57:36
-- Design Name: Lista 2
-- Module Name: tb_matrix_mult - Behavioral
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
use std.textio.all;
use IEEE.std_logic_textio.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.entities.all;
use work.fpupack.all;
use work.matrixmultiplierpack.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_matrix_mult is
end tb_matrix_mult;

architecture Behavioral of tb_matrix_mult is
	
	-- Components
	component lista2_matrix_mult is
	  Port	(
				clk		: in	STD_LOGIC;
				reset	: in	STD_LOGIC;
				start	: in	STD_LOGIC;
				matrixA	: in 	Matrix;
				matrixB	: in 	Matrix;
				matrixZ : out	Matrix;
				ready	: out	STD_LOGIC
			);
	end component lista2_matrix_mult;
	 
	-- Signals
	signal reset	:	STD_LOGIC := '0';
	signal start	:	STD_LOGIC := '0';
	signal clk		:	STD_LOGIC := '0';
	signal matrixA	:	Matrix := (others => (others => '0'));
	signal matrixB	:	Matrix := (others => (others => '0'));
	signal matrixZ	:	Matrix := (others => (others => '0'));
	signal ready	:	STD_LOGIC := '0';
	signal sigStart	:	STD_LOGIC := '0';
	signal WOMenable:	STD_LOGIC := '0';
	
begin
	-- clock generator
	clk <= not clk after 5 ns;
	
	-- reset generator
	reset <= '0', '1' after 15 ns, '0' after 25 ns;
	
	-- sigStart generator
	sigStart <= '0', '1' after 55 ns, '0' after 65 ns;
	
	-- start generator
    process(clk)
    	variable count : integer range 0 to 100; -- number of samples
    begin
        if rising_edge(clk) then
            if reset='1' then
                count := 1;
                start <= '0';
            elsif ready = '1' then
                if count = 100 then -- number of samples
                    count := 0;
                    start <= '0';
                else
                    count := count + 1;
                    start <= '1';
                end if;
            elsif sigStart = '1' then
                count := count + 1;
                start <= '1';
            else
                start <= '0';
            end if;
        end if;
    end process;
	
	 -- Component
	 DUT : lista2_matrix_mult
		 port map(
			 reset => reset,
			 start => start,
			 clk => clk,
			 matrixA => matrixA,
			 matrixB => matrixB,
			 matrixZ => matrixZ,
			 ready => ready
		 );
		
	 -- Read Matrix A
	 MatrixGenARow : for i in 1 to MATRIXSIZE generate
		 MatrixGenACol : for j in 1 to MATRIXSIZE generate
			 read_file_AX: process
				 file infile : text open read_mode is "binA" & integer'image(i) & integer'image(j) & ".txt";
				 variable inline : line; -- line number declaration
				 variable dataf  : std_logic_vector(FP_WIDTH-1 downto 0); 
			 begin
				 while (not endfile(infile)) loop
					 wait until rising_edge(clk);
						 if ready='1' or sigStart = '1' then
							 readline(infile, inline);
							 read(inline,dataf);
							 matrixA((i-1)*MATRIXSIZE + j) <= dataf;
						 end if;
				 end loop;
				 assert not endfile(infile) report "FIM DA LEITURA" severity warning;
				 wait;        
			 end process;
		 end generate;
	 end generate;
	
	 -- Read Matrix B
	 MatrixGenBRow : for i in 1 to MATRIXSIZE generate
		 MatrixGenBCol : for j in 1 to MATRIXSIZE generate
			 read_file_BX: process
				 file infile : text open read_mode is "binB" & integer'image(i) & integer'image(j) & ".txt";
				 variable inline : line; -- line number declaration
				 variable dataf  : std_logic_vector(FP_WIDTH-1 downto 0); 
			 begin
				
				 while (not endfile(infile)) loop
					 wait until rising_edge(clk);
						 if ready='1' or sigStart = '1' then
							 readline(infile, inline);
							 read(inline,dataf);
							 matrixB((i-1)*MATRIXSIZE + j) <= dataf;
						 end if;
				 end loop;
				 assert not endfile(infile) report "FIM DA LEITURA" severity warning;
				 wait;        
			 end process;
		 end generate;
	 end generate;
	
	--	Write WOMenable
	WOMenable <= ready;
	
	
	-- Write Matrix Z
	MatrixGenZRow : for i in 1 to MATRIXSIZE generate
		 MatrixGenZCol : for j in 1 to MATRIXSIZE generate
			write_file_ZX: process(clk) 
				variable out_line : line;
				file out_file     : text is out "binZ" & integer'image(i) & integer'image(j) & ".txt";
			begin
				-- write line to file every clock
				if (rising_edge(clk)) then
					if WOMenable = '1' then
						write (out_line, matrixZ((i-1)*MATRIXSIZE + j));
						writeline (out_file, out_line);
					end if; 
				end if;  
			end process;
		 end generate;
	 end generate;
		
	
end Behavioral;
