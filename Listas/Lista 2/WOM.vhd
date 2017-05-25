--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:    15:54:21 01/27/09
-- Design Name:    
-- Module Name:    WOM - Behavioral
-- Project Name:   
-- Target Device:  
-- Tool versions:  
-- Description:
--
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use std.textio.all;
use IEEE.std_logic_textio.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--use IEEE.numeric_std.all
use work.sobelpack.all;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity WOM is
generic(n_addrlines : natural; -- # addresslines
		  file_name   : string   -- file name of test vectors
		  );
port(data : in std_logic_vector(WOMDEPTH-1 downto 0);	  
	  en	 : in std_logic;
	  clk   : in std_logic
	 );
end WOM;

architecture Behavioral of WOM is

	procedure mem(data		 : in std_logic_vector(WOMDEPTH-1 downto 0); 
					  constant f : in string) is
		file 		filemem 	: text open APPEND_MODE is f; --APPEND_MODE organiza os pixels de saida em uma linha embaixo da anterior
		variable dataline : line;	
	
	begin

		write(dataline, data);
		writeline(filemem, dataline);

	end mem;

begin

	process(clk)
	begin
		if clk='1' and clk'event and en='1' then
			mem(data,file_name);
		end if;
	end process;

end Behavioral;