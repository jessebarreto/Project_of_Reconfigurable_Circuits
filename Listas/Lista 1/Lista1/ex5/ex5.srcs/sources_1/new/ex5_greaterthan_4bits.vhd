----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.03.2017 06:05:59
-- Design Name: 
-- Module Name: ex5_greaterthan_4bits - Behavioral
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

entity ex5_greaterthan_4bits is
    Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
           b : in STD_LOGIC_VECTOR (3 downto 0);
           z : out STD_LOGIC);
end ex5_greaterthan_4bits;

architecture Behavioral of ex5_greaterthan_4bits is
	component ex5_greaterthan_2bits is
    Port ( a : in STD_LOGIC_VECTOR (1 downto 0);
           b : in STD_LOGIC_VECTOR (1 downto 0);
           z : out STD_LOGIC);
	end component ex5_greaterthan_2bits;
	
	signal msbAmaiorquemsbB, msbAigualmsbB, lsbAmaiorquelsbB : std_logic;
	signal msbA, msbB : std_logic_vector (1 downto 0);
begin
	gt_msbits : ex5_greaterthan_2bits port map(	a => a(3 downto 2),
												b => b(3 downto 2),
												z => msbAmaiorquemsbB);
	gt_lsbits : ex5_greaterthan_2bits port map(	a => a(1 downto 0),
												b => b(1 downto 0),
												z => lsbAmaiorquelsbB);												
	
--	comparador : process(a, b, asgtb, abgtb)
--	begin
--		if (abgtb = '1') then
--			z <= '1';
--		elsif ((a(3 downto 0) = b(3 downto 0)) and asgtb = '1') then
--			z <= '1';
--		else
--			z <= '0';
--		end if;
--	end process;
	msbA <= a(3 downto 2);
	msbB <= b(3 downto 2);
	comparador_2bits : process(msbA, msbB)
	begin
		if msbA = msbB then
			msbAigualmsbB <= '1';
		else
			msbAigualmsbB <= '0';
		end if;
	end process comparador_2bits;
	
	z <= msbAmaiorquemsbB or (msbAigualmsbB and lsbAmaiorquelsbB);

end Behavioral;
