----------------------------------------------------------------------------------
-- Company: UnB/PUCPR
-- Engineers: Daniel Munoz e Helon Ayala
-- 
-- Create Date: 07-May-2016 | 11h37min54.532sec
-- Module name:   entities
-- Description:   package defining IO of the components
-- Automatically generated using the entities_gen.m 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.fpupack.all;

package Entities is

component voter3
    port (clk : in  STD_LOGIC;
      reset : in  STD_LOGIC;
      in1 :  in std_logic_vector(FP_WIDTH-1 downto 0);
      in2 :  in std_logic_vector(FP_WIDTH-1 downto 0);
      in3 :  in std_logic_vector(FP_WIDTH-1 downto 0);
      out_vote : out std_logic_vector(FP_WIDTH-1 downto 0));
end component;

component voter5
    Port ( clk : in  STD_LOGIC;
       reset : in  STD_LOGIC;
       in1 : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
       in2 : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
       in3 : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
       in4 : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
       in5 : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
       out_vote : out STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0));
end component;

component voter7
    Port ( clk : in  STD_LOGIC;
       reset : in  STD_LOGIC;
       in1 : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
       in2 : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
       in3 : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
       in4 : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
       in5 : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
       in6 : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
       in7 : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
       out_vote : out STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0));
end component;

component voter9
    Port ( clk : in  STD_LOGIC;
       reset : in  STD_LOGIC;
       in1 : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
       in2 : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
       in3 : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
       in4 : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
       in5 : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
       in6 : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
       in7 : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
       in8 : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
       in9 : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
       out_vote : out STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0));
end component;

component neuron_rbf_v4
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           start : in  STD_LOGIC;
           x1 : in  STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
           x2 : in  STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
           x3 : in  STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
           x4 : in  STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
           x5 : in  STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
           x6 : in  STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
           c1 : in  STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
           c2 : in  STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
           c3 : in  STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
           c4 : in  STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
           c5 : in  STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
           c6 : in  STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
           delta : in  STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0); -- espalhamento -> delta = 1/sigma^2
           phi : out  STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0); -- saida do neuronio
           ready : out  STD_LOGIC);
end component;

component lfsr_fixtofloat_20bits	is
port (reset     :  in std_logic;
      clk       :  in std_logic;
      start     :  in std_logic;
      istart    :  in std_logic;
      init      :  in std_logic_vector(15 downto 0);
      lfsr_out  : out std_logic_vector(FP_WIDTH-1 downto 0);
      ready     : out std_logic);
end component;

component regFF is
port (reset      :  in std_logic;
      clk        :  in std_logic;
      start  	 :  in std_logic;
      iport1  	 :  in std_logic_vector(FP_WIDTH-1 downto 0);    
      oport1     : out std_logic_vector(FP_WIDTH-1 downto 0);
      ready      : out std_logic);
end component;

component sub1 is
port (reset   :  in std_logic;
      clk     :  in std_logic;
      iport1  :  in std_logic_vector(FP_WIDTH-1 downto 0);
      iport2  :  in std_logic_vector(FP_WIDTH-1 downto 0);
      start   :  in std_logic;
      oport1  : out std_logic_vector(FP_WIDTH-1 downto 0);
      ready   : out std_logic);
end component;

component add is
port (reset   :  in std_logic;
      clk     :  in std_logic;
      iport1  :  in std_logic_vector(FP_WIDTH-1 downto 0);
      iport2  :  in std_logic_vector(FP_WIDTH-1 downto 0);
      start   :  in std_logic;
      oport1  : out std_logic_vector(FP_WIDTH-1 downto 0);
      ready   : out std_logic);
end component;

component addsubfsm_v6 is
port (reset     :  in std_logic;
      clk       :  in std_logic;
      op        :  in std_logic;
      op_a    	 :  in std_logic_vector(FP_WIDTH-1 downto 0);
      op_b    	 :  in std_logic_vector(FP_WIDTH-1 downto 0);
      start_i	 :  in std_logic;
      addsub_out : out std_logic_vector(FP_WIDTH-1 downto 0);
      ready_as  : out std_logic);
end component;

component mul is
port (reset 	 :  in std_logic; 
      clk        :  in std_logic;          
      iport1     :  in std_logic_vector(FP_WIDTH-1 downto 0);
      iport2     :  in std_logic_vector(FP_WIDTH-1 downto 0);
      start      :  in std_logic;
      oport1     : out std_logic_vector(FP_WIDTH-1 downto 0);
      ready      : out std_logic);
end component;

component multiplierfsm_v2 is
port (reset     :  in std_logic;
      clk       :  in std_logic;
      op_a    	 :  in std_logic_vector(FP_WIDTH-1 downto 0);
      op_b    	 :  in std_logic_vector(FP_WIDTH-1 downto 0);
      start_i	 :  in std_logic;
      mul_out   : out std_logic_vector(FP_WIDTH-1 downto 0);
      ready_mul : out std_logic);
end component;

component cordic_exp
	port(reset	:  in std_logic;
	     clk	:  in std_logic;
		 start	:  in std_logic;
		 Ain	:  in std_logic_vector(FP_WIDTH-1 downto 0);
		 exp    : out std_logic_vector(FP_WIDTH-1 downto 0);
		 ready  : out std_logic);
end component;

component decFP is
port (reset    :  in std_logic;
      start	   :  in std_logic;
      clk      :  in std_logic;
      Xin      :  in std_logic_vector(FP_WIDTH-1 downto 0);
      intX     : out std_logic_vector(EXP_WIDTH-1 downto 0);
      decX     : out std_logic_vector(FP_WIDTH-1 downto 0);
      ready    : out std_logic);
end component;

component serialcom
port( reset		:  in std_logic;
	   clk 			:  in std_logic;
	   start   	  	:  in std_logic;
        d1          :  in std_logic_vector(FP_WIDTH-1 downto 0);
		din     	:  in std_logic;
		data        : out std_logic_vector(7 downto 0);
		rdy_data    : out std_logic;
		dout        : out std_logic);
end component;

component matrix_element_mult is
port ( clk : in STD_LOGIC;
	   reset : in STD_LOGIC;
	   start : in STD_LOGIC;
	   a1 : in std_logic_vector(FP_WIDTH-1 downto 0);
	   a2 : in std_logic_vector(FP_WIDTH-1 downto 0);
	   b1 : in std_logic_vector(FP_WIDTH-1 downto 0);
	   b2 : in std_logic_vector(FP_WIDTH-1 downto 0);
	   ready : out STD_LOGIC; 
	   y : out std_logic_vector(FP_WIDTH-1 downto 0));
end component matrix_element_mult;

component matrix2x2_mult is
port ( clk : in STD_LOGIC;
	   reset : in STD_LOGIC;
	   start : in STD_LOGIC;
	   ready : out STD_LOGIC;
	   matrix1_a11 : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
	   matrix1_a12 : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
	   matrix1_a21 : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
	   matrix1_a22 : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
	   matrix2_a11 : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
	   matrix2_a12 : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
	   matrix2_a21 : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
	   matrix2_a22 : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
	   matrixout_a11 : out STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
	   matrixout_a12 : out STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
	   matrixout_a21 : out STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
	   matrixout_a22 : out STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0));
end component matrix2x2_mult;

end Entities;
