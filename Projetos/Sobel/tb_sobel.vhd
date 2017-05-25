----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.04.2017 09:33:21
-- Design Name: 
-- Module Name: tb_sobel2 - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--use IEEE.numeric_std.all

entity tb_sobel is
--  Port ( );
end tb_sobel;

architecture Behavioral of tb_sobel is

--FILE input_file  : text OPEN read_mode IS sim_file;
signal reset : std_logic := '0';
signal clk : std_logic := '0';
signal pixin : std_logic_vector(7 downto 0) := (others=>'0');
signal pixout : std_logic_vector(10 downto 0) := (others=>'0');
signal enable : std_logic := '0';
signal ready : std_logic := '0';
-- conter for WOMenable
signal WOMenable : std_logic := '0';
signal cnt_ena : integer range 1 to 205 := 1;

component sobel is
    Port ( reset : in STD_LOGIC;
       clk : in STD_LOGIC;
       pixin : in STD_LOGIC_VECTOR (7 downto 0);
       pixout : out STD_LOGIC_VECTOR (10 downto 0);
       enable : out std_logic;
       ready : out STD_LOGIC);
end component;

component ROM is
generic(width_word : natural; -- width o f memory word in bits
         n_addrlines: natural; -- # addresslines
         file_name  : string);   -- file name of test vectors			
port(address : in  std_logic_vector (13 downto 0);
     data    : out std_logic_vector (7 downto 0));
end component;

component WOM is
generic(n_addrlines : natural; -- # addresslines
         file_name   : string);   -- file name of test vectors		  
port(data: in std_logic_vector(10 downto 0);
     en  : in std_logic;
     clk : in std_logic);
end component;

-- enderecamento das memorias ROM e WOM
signal ROMaddress : std_logic_vector(13 downto 0) := (others=>'0');

begin
   
    -- reset generator
    reset <= '0', '1' after 15 ns, '0' after 25 ns;
    
    -- clock generator
    clk <= not clk after 5 ns; 

    -- sobel architecture intanciation                    
    uut: sobel port map(
        reset => reset,
        clk => clk,
        pixin => pixin,
        pixout => pixout,
        enable => enable,
        ready => ready); 

    read_from_file: process
    file infile	: text is in "unb.txt"; -- input file declaration
    variable inline : line; -- line number declaration
    variable dataf  : std_logic_vector(7 downto 0); 
    begin
        while (not endfile(infile)) loop
            wait until rising_edge(clk);
            readline(infile, inline);
            read(inline,dataf);
            pixin <= dataf;
        end loop;
        assert not endfile(infile) report "FIM DA LEITURA" severity warning;
        wait;        
    end process;
    
    WOMenable <= enable xor ready;
    
    write_to_file : process(clk) 
    variable out_line : line;
    file out_file     : text is out "res_unb.txt";
    begin
        -- write line to file every clock
        if (rising_edge(clk)) then
            if WOMenable = '1' then
                write (out_line, pixout);
                writeline (out_file, out_line);
            end if; 
        end if;  
    end process ;

end Behavioral;
