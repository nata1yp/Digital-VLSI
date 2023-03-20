library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity rca_4bits_tb is
end rca_4bits_tb;

architecture Bench of rca_4bits_tb is
    component rca_4bits is
        Port (A : in STD_LOGIC_VECTOR (3 downto 0);
              B : in STD_LOGIC_VECTOR (3 downto 0);
              Cin : in STD_LOGIC;
              Cout : out STD_LOGIC;
              S : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    signal A, B: std_logic_vector(3 downto 0);
    signal Cin: std_logic;
    signal S: std_logic_vector(3 downto 0);
    signal Cout: std_logic;
    
    constant period: time:=10ns;
    
begin
    uut: rca_4bits
    port map(
       A => A,
       B => B,
       Cin => Cin,
       S => S,
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
          A <= "1010";
          wait for period*2;
          A <= "1011";
          wait for period*2;
          A <= "1100";
          wait for period*2;
          A <= "1101";
          wait for period*2;
          A <= "1110";
          wait for period*2;
          A <= "1111";
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
        B <= "1010";
        wait for period*4;
        B <= "1011";
        wait for period*4;
        B <= "1100";
        wait for period*4;
        B <= "1101";
        wait for period*4;
        B <= "1110";
        wait for period*4;
        B <= "1111";
        wait for period*4;
      end process;
    
    input_Cin: process
         begin
             Cin <= '0';
             wait for period*8;
             Cin <= '1';
             wait for period*8;
          end process;

  
end Bench;