----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.03.2017 12:08:27
-- Design Name: 
-- Module Name: ex2 - Behavioral
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



entity ex2 is
      Port ( address : in std_logic_vector (3 downto 0);
      		 rom_out : out std_logic_vector (3 downto 0));
end ex2;

architecture Behavioral of ex2 is
	-- TYPE ROM
	type rom_type is array (0 to 7) of std_logic_vector (3 downto 0);
	-- ROM as CONSTANT
	constant rom : rom_type := (0 => "0011", 
								1 => "0100",
								2 => "0101",
								3 => "0110",
								4 => "0111",
								5 => "1000",
								6 => "1001",
								7 => "1010");
begin
	process(address)
	begin
		case address is
			when "000" => rom_out <= rom(0);
			when "001" => rom_out <= rom(1);
			when "010" => rom_out <= rom(2);
			when "011" => rom_out <= rom(3);
			when "100" => rom_out <= rom(4);
			when "101" => rom_out <= rom(5);
			when "110" => rom_out <= rom(6);
			when "111" => rom_out <= rom(7);
			when others => rom_out <= "0000";
		end case; 
	end process;
end Behavioral;
