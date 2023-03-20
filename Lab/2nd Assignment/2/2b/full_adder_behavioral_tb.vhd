library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder_behavioral_tb is
end full_adder_behavioral_tb;

architecture Bench of full_adder_behavioral_tb is
    component full_adder_behavioral is
         Port (-- FAB : in STD_LOGIC_VECTOR(1 DOWNTO 0);
              FA: in std_logic;
              FB: in std_logic;
              Cin : in STD_LOGIC;
              sum : out STD_LOGIC;
              Cout : out STD_LOGIC);
    end component;
    
    --signal FAB: std_logic_vector(1 downto 0);
    signal FA, FB, Cin, sum, Cout: std_logic;
    
    constant period: time:=10ns;
begin

    uut: full_adder_behavioral
    port map(
        FA => FA,
        FB =>FB,
        Cin => Cin,
        sum => sum,
        Cout => Cout);
   
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
             wait for period*2;
             FB <= '1';
             wait for period*2;
          end process;
     input_Cin: process
          begin
              Cin <= '0';
              wait for period*4;
              Cin <= '1';
              wait for period*4;
           end process;
            
            
end Bench;
