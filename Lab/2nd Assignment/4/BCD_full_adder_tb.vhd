library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BCD_full_adder_tb is
end BCD_full_adder_tb;

architecture Bench of BCD_full_adder_tb is
    component BCD_full_adder is
        Port (A : in STD_LOGIC_VECTOR (3 downto 0);
              B : in STD_LOGIC_VECTOR (3 downto 0);
              Cin : in STD_LOGIC;
              Cout : out STD_LOGIC;
              sum : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    signal A, B: std_logic_vector(3 downto 0);
    signal Cin: std_logic;
    signal sum: std_logic_vector(3 downto 0);
    signal Cout: std_logic;
    
    constant period: time:=10ns;
    
begin
    uut: BCD_full_adder
    port map(
       A => A,
       B => B,
       Cin => Cin,
       sum => sum,
       Cout => Cout);
  
  input_A: process
        begin        
          A <= "0000";
          wait for period*2;
          A <= "0001";
          wait for period*2;
          A <= "0010";
          wait for period*2;
          A <= "0011";
          wait for period*2;
          A <= "0100";
          wait for period*2;
          A <= "0101";
          wait for period*2;
          A <= "0110";
          wait for period*2;
          A <= "0111";
          wait for period*2;
          A <= "1000";
          wait for period*2;
          A <= "1001";
          wait for period*2;
       end process;
        
  input_B: process
      begin        
        B <= "0000";
        wait for period*4;
        B <= "0001";
        wait for period*4;
        B <= "0010";
        wait for period*4;
        B <= "0011";
        wait for period*4;
        B <= "0100";
        wait for period*4;
        B <= "0101";
        wait for period*4;
        B <= "0110";
        wait for period*4;
        B <= "0111";
        wait for period*4;
        B <= "1000";
        wait for period*4;
        B <= "1001";
        wait for period*4;
      end process;
    
    input_Cin: process
         begin
             Cin <= '0';
             wait for period;
          end process;

end Bench;