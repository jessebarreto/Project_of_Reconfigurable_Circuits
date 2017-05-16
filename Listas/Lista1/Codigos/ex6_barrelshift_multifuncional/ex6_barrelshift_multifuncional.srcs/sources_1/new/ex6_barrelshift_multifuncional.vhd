----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.03.2017 18:22:19
-- Design Name: 
-- Module Name: ex6_barrelshift_multifuncional - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ex6_barrelshift_multifuncional is
    Port ( data : in STD_LOGIC_VECTOR (7 downto 0);
    	   lr : in STD_LOGIC;
           output : out STD_LOGIC_VECTOR (7 downto 0));
end ex6_barrelshift_multifuncional;

architecture Behavioral of ex6_barrelshift_multifuncional is
	component ex6_barrelshift_dir is
    Port ( data : in STD_LOGIC_VECTOR (7 downto 0);
           output : out STD_LOGIC_VECTOR (7 downto 0));
	end component ex6_barrelshift_dir;
	
	component ex6_barrelshift_esq is
	    Port ( data : in STD_LOGIC_VECTOR (7 downto 0);
	           output : out STD_LOGIC_VECTOR (7 downto 0));
	end component ex6_barrelshift_esq;
	
	signal bs_esq, bs_dir : std_logic_vector (7 downto 0);
begin
	barrelshift_dir : ex6_barrelshift_dir port map( data => data, output => bs_dir);
	barrelshift_esq : ex6_barrelshift_esq port map( data => data, output => bs_esq);
	
	process(lr, bs_dir, bs_esq)
	begin
		if (lr = '1') then
			output <= bs_esq;
		else
			output <= bs_dir;
		end if;
	end process;
end Behavioral;
