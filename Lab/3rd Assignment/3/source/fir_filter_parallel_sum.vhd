library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity fir_filter_parallel_sum is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           x0 : in STD_LOGIC_VECTOR (7 downto 0);
           x1 : in STD_LOGIC_VECTOR (7 downto 0);
           valid_in : in STD_LOGIC;
           valid_out : out STD_LOGIC;
           y0 : out STD_LOGIC_VECTOR(18 downto 0);
           y1 : out STD_LOGIC_VECTOR(18 downto 0));
end fir_filter_parallel_sum;

architecture Behavioral of fir_filter_parallel_sum is
    --type xn_array is array (0 to 7) of std_logic_vector(7 downto 0);
    type prod is array (0 to 7) of std_logic_vector(15 downto 0);
    type coefficient is array (7 downto 0) of std_logic_vector (7 downto 0);      
    signal coeff  : coefficient:= ("00001000", "00000111", "00000110", "00000101", 
                                 "00000100", "00000011", "00000010", "00000001");                
    signal in0,in1,in2,in3,in4,in5,in6,in7,in8: STD_LOGIC_VECTOR (7 downto 0);
    signal product0, product1 : prod;
  
    signal zeros : std_logic_vector(18 downto 0) := (others => '0');
    signal output0, output1: std_logic_vector(18 downto 0) := (others => '0');

begin
    
pipelined_input : process (rst,clk)

begin
  if(rst='1') then
      in8 <= (others=>'0');
      in7 <= (others=>'0');
      in6 <= (others=>'0');
      in5 <= (others=>'0');
      in4 <= (others=>'0');
      in3 <= (others=>'0');
      in2 <= (others=>'0');
      in1 <= (others=>'0');
      in0 <= (others=>'0');
    product0 <= (others =>( others=>'0'));
    product1 <= (others =>( others=>'0'));
    y0<=(others=>'0');
    y1<=(others=>'0');
    output0<=(others=>'0');
    output1<=(others=>'0');
    valid_out<='0';
  elsif(rising_edge(clk) and valid_in='1') then
    in8 <= in6;
    in7 <= in5;
    in6 <= in4;
    in5 <= in3;
    in4 <= in2;
    in3 <= in1;
    in2 <= in0;
    in1 <= x0;
    in0 <= x1;
    product0(0)<=in1*coeff(0);
    product0(1)<=in2*coeff(1);
    product0(2)<=in3*coeff(2);
    product0(3)<=in4*coeff(3);
    product0(4)<=in5*coeff(4);
    product0(5)<=in6*coeff(5);
    product0(6)<=in7*coeff(6);
    product0(7)<=in8*coeff(7);
    
    product1(0)<=in0*coeff(0);
    product1(1)<=in1*coeff(1);
    product1(2)<=in2*coeff(2);
    product1(3)<=in3*coeff(3);
    product1(4)<=in4*coeff(4);
    product1(5)<=in5*coeff(5);
    product1(6)<=in6*coeff(6);
    product1(7)<=in7*coeff(7);
    output0 <= zeros + product0(0)+product0(1)+product0(2)+product0(3)+product0(4)+product0(5)+product0(6)+product0(7);
    output1 <=zeros + product1(0)+product1(1)+product1(2)+product1(3)+product1(4)+product1(5)+product1(6)+product1(7);
    y0 <= output0;
    y1 <= output1;
    if (output0 /= 0 or output1 /= 0) then
            valid_out <= '1';
        end if;
    
    end if;
       
end process pipelined_input;