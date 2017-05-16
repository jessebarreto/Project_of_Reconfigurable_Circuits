----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.04.2017 13:36:08
-- Design Name: 
-- Module Name: kernel_provider - Behavioral
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
use IEEE.std_logic_arith.all;
use ieee.std_logic_signed;
use work.sobel_parameters.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity kernel_provider is
    Port ( mask_out : out STD_LOGIC_VECTOR (KERNEL_SIZE*KERNEL_DEPTH - 1 downto 0);
    	   mask_tmask : out TMASK);
end kernel_provider;

architecture Behavioral of kernel_provider is

	signal sobel_tmask : TMASK;
	signal sobel_mask : STD_LOGIC_VECTOR (KERNEL_SIZE*KERNEL_DEPTH - 1 downto 0) := (others => '0');

--	function kernel_calculator_tmask return TMASK is
--		variable x : integer;
--		variable mascara : TMASK;
----		variable bin_mascara : STD_LOGIC_VECTOR (KERNEL_SIZE*KERNEL_DEPTH - 1 downto 0) := (others => '0'); 
--	begin
----		for i in 0 to KERNEL_WIDTH loop
----			x := 1;
----			for k in 0 to i loop
----				x := x * (i - k) / (k + 1);
----				if i = KERNEL_WIDTH then
----					x := 0;
----				end if;
----			end loop;
----		end loop;		
----		for i in 1 to KERNEL_SIZE loop
----			x := 1;
----		end loop;
--		mascara[1] = 0;
--		return mascara;
--	end kernel_calculator;

	--FUNCTION mem( signal addr: in std_logic_vector(13 downto 0);
	--				  constant f : in string;
	--				  constant w : in natural ) return std_logic_vector is
	--	file filemem 		: text open READ_MODE is f;
	--	variable dataline : line;
	--	variable aux 		: std_logic_vector(w-1 downto 0);
	--	variable x 			: boolean;
	--	variable linenumber : integer;
	
	--begin

	--	linenumber := conv_integer(addr);
	--	x := FALSE;
	--	for i in 0 to linenumber loop
	--		if not endfile(filemem) then
	--			readline(filemem,dataline);
	--		else
	--			x := TRUE;
	--		end if;
	--	end loop;
	--	read(dataline,aux);
	--	if x = TRUE then
	--		aux := (others => 'X');
	--	end if;
	--	return aux;
	--end mem;


begin	
	mask_tmask <= sobel_tmask;
	mask_out <= sobel_mask;
end Behavioral;

--int n,k,i,x;
--cout << "Enter a row number for Pascal's Triangle: ";
--cin >> n; //the number of raws
--for(i=0;i<=n;i++)
--{
--x=1;
--for(k=0;k<=i;k++)
--{
--cout << x << '\t';
--x = x * (i - k) / (k + 1);
--}
--cout << endl;
--}
--return 0;
--}

