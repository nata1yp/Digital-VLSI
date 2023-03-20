library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity exercise9_tb is
end exercise9_tb;

architecture Bench of exercise9_tb is
    component exercise9 is
        Port ( rst : in STD_LOGIC;
                inp : in STD_LOGIC;
                state : out STD_LOGIC_VECTOR (2 downto 0);
                outp : out STD_LOGIC_VECTOR (1 downto 0));
    end component;
    
    signal rst, inp: std_logic;
    signal outp:std_logic_vector(1 downto 0);
    signal state:std_logic_vector(2 downto 0);
    constant period: time:=5ns;
    
begin
    uut: exercise9
    port map(
        rst => rst,
        inp =>inp,
        state => state,
        outp => outp);
        
    input: process
    begin
        inp <= '0';
        wait for period;
        inp <= '1';
        wait for period;
     end process;
     
     reset: process
     begin
         rst <= '1';
         wait for period;
         rst <= '0';
         wait for 10*period;
      end process;

end Bench;