library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity fir_filter_pipeline_sum is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           x : in STD_LOGIC_VECTOR (7 downto 0);
           valid_in : in STD_LOGIC;
           valid_out : out STD_LOGIC;
           y : out STD_LOGIC_VECTOR(18 downto 0));
end fir_filter_pipeline_sum;

architecture Behavioral of fir_filter_pipeline_sum is
    type xn_array is array (0 to 7) of std_logic_vector(7 downto 0);
    type prod is array (0 to 7) of std_logic_vector(15 downto 0);
    type coefficient is array (7 downto 0) of std_logic_vector (7 downto 0);      
    signal coeff  : coefficient:= ("00001000", "00000111", "00000110", "00000101", 
                                 "00000100", "00000011", "00000010", "00000001");                
    
    signal xn : xn_array;
    signal product : prod;
  
    signal zeros : std_logic_vector(18 downto 0) := (others => '0');
    signal output: std_logic_vector(18 downto 0) := (others => '0');

begin
    
pipelined_input : process (rst,clk)

begin
  if(rst='1') then
    xn <= (others=>(others=>'0'));
    product <= (others =>( others=>'0'));
    y<=(others=>'0');
    output<=(others=>'0');
    valid_out<='0';
  elsif(rising_edge(clk) and valid_in='1') then
    xn <= x & xn(0 to 6);
    for i in 0 to 7 loop
        product(i)<=xn(i)*coeff(i);
    end loop;
    output <=zeros + product(0)+product(1)+product(2)+product(3)+product(4)+product(5)+product(6)+product(7);
    y <= output;
    if (output /= 0) then
        valid_out <= '1';
    end if;
  end if;
       
end process pipelined_input;
end Behavioral;