library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder_combinational_tb is
end full_adder_combinational_tb;

architecture Bench of full_adder_combinational_tb is
    component full_adder_combinational is 
        Port ( FA : in STD_LOGIC;
               FB : in STD_LOGIC;
               Cin : in STD_LOGIC;
               Cout : out STD_LOGIC;
               sum : out STD_LOGIC);
    end component;

signal FA, FB, Cin, Cout, sum: std_logic;

constant period: time:=10ns; 
begin
   uut: full_adder_combinational port map(
   FA => FA,
   FB => FB,
   Cin => Cin,
   sum => sum,
   Cout => Cout
   );
   
   input_FA: process 
   begin
         FA <= '0';
         wait for period;
         FA <= '1';
         wait for period;
   end process;
   
   input_FB: process
   begin
         FB <= '0';
         wait for 2*period;
         FB <= '1';
         wait for 2*period;
   end process;
   
    input_Cin: process
    begin
        Cin <= '0';
        wait for 4*period;
        Cin <= '1';
        wait for 4*period;
    end process;
   
end Bench;
