library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity full_adder_sequential_tb is
end full_adder_sequential_tb;

architecture Bench of full_adder_sequential_tb is
    component full_adder_sequential is
        Port ( FA : in STD_LOGIC;
               FB : in STD_LOGIC;
               Cin: in STD_LOGIC;
               clk: in STD_LOGIC;
               reset: in STD_LOGIC;
               sum : out STD_LOGIC;
               Cout : out STD_LOGIC);     
    end component;
    
    signal FA, FB, Cin: std_logic;
    signal clk, reset, sum, Cout: std_logic;
    
    constant period: time:=10ns;
    
begin
    uut: full_adder_sequential port map(
        FA => FA,
        FB => FB,
        clk => clk,
        Cin => Cin,
        reset => reset,
        sum => sum,
        Cout => Cout
    );
    
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
          
    input_reset: process
              begin
                 reset <= '1';
                 wait for period*16;
                 reset <= '0';
                 wait for period*16; 
             end process;

end Bench;