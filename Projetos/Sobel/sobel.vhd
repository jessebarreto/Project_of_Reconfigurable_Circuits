----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/11/2017 08:52:07 AM
-- Design Name: 
-- Module Name: sobel - Behavioral
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
use IEEE.STD_LOGIC_signed.ALL;
use IEEE.STD_LOGIC_arith.ALL;

entity sobel is
    Port ( reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           pixin : in STD_LOGIC_VECTOR (7 downto 0);
           pixout : out STD_LOGIC_VECTOR (10 downto 0);
           enable : out std_logic;
           ready : out STD_LOGIC);
end sobel;

architecture Behavioral of sobel is

-- registrador de deslocamento
signal reg_neigh : std_logic_vector(203*8-1 downto 0):= (others=>'0');

-- vizinhança
signal neigh11 : std_logic_vector(7 downto 0):= (others=>'0');
signal neigh12 : std_logic_vector(7 downto 0):= (others=>'0');
signal neigh13 : std_logic_vector(7 downto 0):= (others=>'0');
signal neigh21 : std_logic_vector(7 downto 0):= (others=>'0');
signal neigh22 : std_logic_vector(7 downto 0):= (others=>'0');
signal neigh23 : std_logic_vector(7 downto 0):= (others=>'0');
signal neigh31 : std_logic_vector(7 downto 0):= (others=>'0');
signal neigh32 : std_logic_vector(7 downto 0):= (others=>'0');
signal neigh33 : std_logic_vector(7 downto 0):= (others=>'0');

-- out multiplier
signal m11 : std_logic_vector(10 downto 0):= (others=>'0');
signal m12 : std_logic_vector(10 downto 0):= (others=>'0');
signal m13 : std_logic_vector(10 downto 0):= (others=>'0');
signal m21 : std_logic_vector(10 downto 0):= (others=>'0');
signal m22 : std_logic_vector(10 downto 0):= (others=>'0');
signal m23 : std_logic_vector(10 downto 0):= (others=>'0');
signal m31 : std_logic_vector(10 downto 0):= (others=>'0');
signal m32 : std_logic_vector(10 downto 0):= (others=>'0');
signal m33 : std_logic_vector(10 downto 0):= (others=>'0');

-- out soma
signal s_soma : std_logic_vector(10 downto 0):= (others=>'0');

-- threshold
constant thres : std_logic_vector(10 downto 0):= "01111111111";

-- pixel output 
signal s_pixout : std_logic_vector(10 downto 0):= (others=>'0');

-- conter for enable
signal cnt_ena : integer range 1 to 205 := 1;
signal s_enable : std_logic := '0';

-- conter for ready
signal cnt_rdy : integer range 1 to 10000 := 1;

-- kernel
constant k11 : std_logic_vector(2 downto 0) := "001";-- 1
constant k12 : std_logic_vector(2 downto 0) := "010";-- 2
constant k13 : std_logic_vector(2 downto 0) := "001";-- 1
constant k21 : std_logic_vector(2 downto 0) := "000";-- 0
constant k22 : std_logic_vector(2 downto 0) := "000";-- 0
constant k23 : std_logic_vector(2 downto 0) := "000";-- 0
constant k31 : std_logic_vector(2 downto 0) := "111";-- -1
constant k32 : std_logic_vector(2 downto 0) := "110";-- -2
constant k33 : std_logic_vector(2 downto 0) := "111";-- -1

begin

-- process for enable 
process(clk,reset)
begin
    if rising_edge(clk) then
        if reset='1' then
            cnt_ena <= 1;
            s_enable <= '0';
        elsif cnt_ena = 203+2 then
            cnt_ena <= 1;
            s_enable <= '1';
        else
            cnt_ena <= cnt_ena + 1;
        end if;   
    end if;
end process;

enable <= s_enable;

-- process for ready 
process(clk,reset)
begin
    if rising_edge(clk) then
        if reset='1' then
            cnt_rdy <= 1;
            ready <= '0';
        --elsif s_enable='1' then
        elsif cnt_rdy = 10000 then
            cnt_rdy <= 1;
            ready <= '1';
        else
            cnt_rdy <= cnt_rdy + 1;
        end if;
        --end if;
    end if;
end process;

-- shift register 100x100 + 3 pixels
process(clk,reset)
begin
    if rising_edge(clk) then
        if reset='1' then
            reg_neigh <= (others=>'0');
        else
            reg_neigh <= pixin & reg_neigh(203*8-1 downto 8);
        end if;   
    end if;
end process;

-- windowing allowing
neigh13 <= reg_neigh(23 downto 16);
neigh12 <= reg_neigh(15 downto 8);
neigh11 <= reg_neigh(7 downto 0);

neigh21 <= reg_neigh(101*8-1 downto 101*8-8);
neigh22 <= reg_neigh(102*8-1 downto 102*8-8);
neigh23 <= reg_neigh(103*8-1 downto 103*8-8);

neigh31 <= reg_neigh(201*8-1 downto 201*8-8);
neigh32 <= reg_neigh(202*8-1 downto 202*8-8);
neigh33 <= reg_neigh(203*8-1 downto 203*8-8);

-- convolution operation
process(clk,reset)
begin
    if rising_edge(clk) then
		if reset ='1' then
        	m11 <= (others => '0');
		else
			m11 <= neigh11*k11;
		end if;
    end if;
end process;

-- convolution operation
process(clk,reset)
begin
    if rising_edge(clk) then
		if reset ='1' then
        	m12 <= (others => '0');
		else
			m12 <= neigh12*k12;
		end if;
    end if;
end process;

-- convolution operation
process(clk,reset)
begin
    if rising_edge(clk) then
		if reset ='1' then
        	m13 <= (others => '0');
		else
			m13 <= neigh13*k13;
		end if;
    end if;
end process;

-- convolution operation
process(clk,reset)
begin
    if rising_edge(clk) then
		if reset ='1' then
        	m21 <= (others => '0');
		else
			m21 <= neigh21*k21;
		end if;
    end if;
end process;

-- convolution operation
process(clk,reset)
begin
    if rising_edge(clk) then
		if reset ='1' then
        	m22 <= (others => '0');
		else
			m22 <= neigh22*k22;
		end if;
    end if;
end process;

-- convolution operation
process(clk,reset)
begin
    if rising_edge(clk) then
		if reset ='1' then
        	m23 <= (others => '0');
		else
			m23 <= neigh23*k23;
		end if;
    end if;
end process;

-- convolution operation
process(clk,reset)
begin
    if rising_edge(clk) then
		if reset ='1' then
        	m31 <= (others => '0');
		else
			m31 <= neigh31*k31;
		end if;
    end if;
end process;

-- convolution operation
process(clk,reset)
begin
    if rising_edge(clk) then
		if reset ='1' then
        	m32 <= (others => '0');
		else
			m32 <= neigh32*k32;
		end if;
    end if;
end process;

-- convolution operation
process(clk,reset)
begin
    if rising_edge(clk) then
		if reset ='1' then
        	m33 <= (others => '0');
		else
			m33 <= neigh33*k33;
		end if;
    end if;
end process;

-- convolution output
process(clk,reset)
begin
    if rising_edge(clk) then
        if reset = '1' then
            s_soma <= (others=>'0');
        else
            s_soma <= m11 + m12 + m13 + m21 + m22 + m23 + m31 + m32 + m33;
        end if;
    end if;
end process;

pixout <= s_soma;

---- threshold and mux output
--process(clk,reset)
--begin
--    if rising_edge(clk) then
--        if reset='1' then
--            s_pixout <= (others=>'0');
--        elsif s_soma >= thres then
--            s_pixout <= "11111111111";
--        else
--            s_pixout <= s_soma;
--        end if;
--    end if;
--end process;

--pixout <= s_pixout;

end Behavioral;
