library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity half_adder_tb is

end half_adder_tb;

architecture Bench of half_adder_tb is
    component half_adder is 
    Port ( A : in STD_LOGIC;
               B : in STD_LOGIC;
               carry : out STD_LOGIC;
               sum : out STD_LOGIC);
    end component;

signal A, B, carry, sum: std_logic;

constant period: time:=10ns; 
begin
   uut: half_adder port map(
   A=>A,
   B=>B,
   carry=>carry,
   sum=>sum
   );
   
   input_A: process 
   begin
         A <= '0';
         wait for period;
         A <= '1';
         wait for period;
   end process;
   
   input_B: process
   begin
         B <= '0';
         wait for 2*period;
         B <= '1';
         wait for 2*period;
   end process;
   
end Bench;