----------------------------------------------------------------------------------
-- Company: Universidade de Brasilia
-- Engineer: Jesse Barreto de Barros
-- 
-- Create Date: 
-- Design Name: Prova PCR
-- Module Name: tb_prova - Behavioral
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
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use std.textio.all;
use IEEE.std_logic_textio.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.entities.all;
use work.fpupack.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_prova is
end tb_prova;

architecture Behavioral of tb_prova is
	-- Components
	component prova_top_module is
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
	end component prova_top_module;
	 
	-- Signals
	signal reset	:	STD_LOGIC := '0';
	signal start	:	STD_LOGIC := '0';
	signal clk		:	STD_LOGIC := '0';
	signal fillCovs	: 	STD_LOGIC := '0';
	signal initCovK	: 	std_logic_vector (FP_WIDTH-1 downto 0) := (others => '0');
	signal initCovZ	: 	std_logic_vector (FP_WIDTH-1 downto 0) := (others => '0');
	signal yUl		:	std_logic_vector (FP_WIDTH-1 downto 0) := (others => '0');
	signal yIr		:	std_logic_vector (FP_WIDTH-1 downto 0) := (others => '0');
	signal xUl		:	std_logic_vector (FP_WIDTH-1 downto 0) := (others => '0');
	signal xIr		:	std_logic_vector (FP_WIDTH-1 downto 0) := (others => '0');
	signal xFusion	:	std_logic_vector (FP_WIDTH-1 downto 0) := (others => '0');
	signal ready	:	STD_LOGIC := '0';
	signal sigStart	:	STD_LOGIC := '0';
	signal sigReadCovs : STD_LOGIC := '0';
	signal WOMenable:	STD_LOGIC := '0';
	
begin
	-- clock generator
	clk <= not clk after 5 ns;
	
	-- reset generator
	reset <= '0', '1' after 15 ns, '0' after 25 ns;
	
	-- Start Initial Covariance
	sigReadCovs <= '0', '1' after 35 ns, '0' after 45 ns;
	fillCovs <= '0', '1' after 55 ns, '0' after 65 ns;
	
	-- sigStart generator
	sigStart <= '0', '1' after 85 ns, '0' after 95 ns;
	
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
	 DUT : prova_top_module
		 port map(
		 		clk => clk,
			 	reset 	=> reset,
				start 	=> start,
				fillCovs => fillCovs,
				initCovK => initCovK,
				initCovZ => initCovZ,
			 	yUl		=> yUl,
			 	yIr		=> yIr,
			 	xFusion	=> xFusion,
			 	xUl		=> xUl,
			 	xIr		=> xIr,
			 	ready => ready
		 );
		
	 -- Read yUl
	 read_file_yUl: process
		 file infile : text open read_mode is "binYUl.txt";
		 variable inline : line; -- line number declaration
		 variable dataf  : std_logic_vector(FP_WIDTH-1 downto 0); 
	 begin
		 while (not endfile(infile)) loop
			 wait until rising_edge(clk);
				 if ready='1' or sigStart = '1' then
					 readline(infile, inline);
					 read(inline,dataf);
					 yUl <= dataf;
				 end if;
		 end loop;
		 assert not endfile(infile) report "FIM DA LEITURA yUl" severity warning;
		 wait;        
	 end process;
	 
	 -- Read yIr
	 read_file_yIr: process
		 file infile : text open read_mode is "binYIr.txt";
		 variable inline : line; -- line number declaration
		 variable dataf  : std_logic_vector(FP_WIDTH-1 downto 0); 
	 begin
		 while (not endfile(infile)) loop
			 wait until rising_edge(clk);
				 if ready='1' or sigStart = '1' then
					 readline(infile, inline);
					 read(inline,dataf);
					 yIr <= dataf;
				 end if;
		 end loop;
		 assert not endfile(infile) report "FIM DA LEITURA yIr" severity warning;
		 wait;        
	 end process;
	
	-- Read initCovK
	 read_file_initCovK: process
		 file infile : text open read_mode is "binInitCovK.txt";
		 variable inline : line; -- line number declaration
		 variable dataf  : std_logic_vector(FP_WIDTH-1 downto 0); 
	 begin
		 while (not endfile(infile)) loop
			 wait until rising_edge(clk);
				 if sigReadCovs = '1' then
					 readline(infile, inline);
					 read(inline,dataf);
					 initCovK <= dataf;
				 end if;
		 end loop;
		 assert not endfile(infile) report "FIM DA LEITURA binInitCovK" severity warning;
		 wait;        
	 end process;
	
	-- Read initCovZ
	read_file_initCovZ: process
		file infile : text open read_mode is "binInitCovZ.txt";
		variable inline : line; -- line number declaration
		variable dataf  : std_logic_vector(FP_WIDTH-1 downto 0); 
	begin
		while (not endfile(infile)) loop
		wait until rising_edge(clk);
			if sigReadCovs = '1' then
				readline(infile, inline);
				read(inline,dataf);
				initCovZ <= dataf;
			end if;
		end loop;
		assert not endfile(infile) report "FIM DA LEITURA initCovZ" severity warning;
		wait;        
	end process;
	
	--	Write WOMenable
	WOMenable <= ready;
	
	-- Write xUl
	write_file_xUl: process(clk) 
		variable out_line : line;
		file out_file     : text is out "binXUl.txt";
	begin
		-- write line to file every clock
		if (rising_edge(clk)) then
			if WOMenable = '1' then
				write (out_line, xUl);
				writeline (out_file, out_line);
			end if; 
		end if;  
	end process;
	
	-- Write xIr
	write_file_xIr: process(clk) 
		variable out_line : line;
		file out_file     : text is out "binXIr.txt";
	begin
		-- write line to file every clock
		if (rising_edge(clk)) then
			if WOMenable = '1' then
				write (out_line, xIr);
				writeline (out_file, out_line);
			end if; 
		end if;  
	end process;	
	
	-- Write xFusao
	write_file_xFusao: process(clk) 
		variable out_line : line;
		file out_file     : text is out "binXFusao.txt";
	begin
		-- write line to file every clock
		if (rising_edge(clk)) then
			if WOMenable = '1' then
				write (out_line, xFusion);
				writeline (out_file, out_line);
			end if; 
		end if;  
	end process;
end Behavioral;
