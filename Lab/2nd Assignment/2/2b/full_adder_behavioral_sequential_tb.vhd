library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder_behavioral_sequential_tb is
end full_adder_behavioral_sequential_tb;

architecture Bench of full_adder_behavioral_sequential_tb is
    component full_adder_behavioral_sequential is
     Port (FA: in std_logic;
          FB: in std_logic;
          Cin : in STD_LOGIC;
          clk: in std_logic;
          rst: in std_logic;
          sum : out STD_LOGIC;
          Cout : out STD_LOGIC);
    end component;

signal FA, FB, Cin, clk, rst, sum, Cout: std_logic;
    
    constant period: time:=10ns;
begin

    uut: full_adder_behavioral_sequential
    port map(
        FA => FA,
        FB =>FB,
        Cin => Cin,
        clk => clk,
        rst => rst,
        sum => sum,
        Cout => Cout);
   
   input_FA: process
        begin
            FA <= '0';
            wait for period*2;
            FA <= '1';
            wait for period*2;
         end process;
         
      input_FB: process
         begin
             FB <= '0';
             wait for period*4;
             FB <= '1';
             wait for period*4;
          end process;
     
     input_Cin: process
          begin
              Cin <= '0';
              wait for period*8;
              Cin <= '1';
              wait for period*8;
           end process;

      input_clk: process
         begin
             clk <= '0';
             wait for period;
             clk <= '1';
             wait for period;
          end process;
     
     input_rst: process
          begin
              rst <= '1';
              wait for period*16;
              rst <= '0';
              wait for period*16;
           end process;               
            
end Bench;