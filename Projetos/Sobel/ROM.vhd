--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:    15:18:40 01/27/09
-- Design Name:    
-- Module Name:    ROM - Behavioral
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

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ROM is
generic ( width_word : natural; -- width of memory word in bits
			 n_addrlines: natural; -- # addresslines
			 file_name  : string   -- file name of test vectors
			);
port ( address : in  std_logic_vector (13 downto 0) ;
		 data    : out std_logic_vector (7 downto 0)
		);
end ROM;

architecture Behavioral of ROM is

	FUNCTION mem( signal addr: in std_logic_vector(13 downto 0);
					  constant f : in string;
					  constant w : in natural ) return std_logic_vector is
		file filemem 		: text open READ_MODE is f;
		variable dataline : line;
		variable aux 		: std_logic_vector(w-1 downto 0);
		variable x 			: boolean;
		variable linenumber : integer;
	
	begin

		linenumber := conv_integer(addr);
		x := FALSE;
		for i in 0 to linenumber loop
			if not endfile(filemem) then
				readline(filemem,dataline);
			else
				x := TRUE;
			end if;
		end loop;
		read(dataline,aux);
		if x = TRUE then
			aux := (others => 'X');
		end if;
		return aux;
	end mem;

begin

	process(address)
	begin
		data <= mem(address,file_name,width_word);
	end process;

end Behavioral;