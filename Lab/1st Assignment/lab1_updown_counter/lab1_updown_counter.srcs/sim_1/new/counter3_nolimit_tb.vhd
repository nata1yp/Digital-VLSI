library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity counter3_nolimit_tb is
--  Port ( );
end counter3_nolimit_tb;

architecture Bench of counter3_nolimit_tb is
component counter3_nolimit is
        port(
            clk : in std_logic;
            resetn : in std_logic;
            count_en : in std_logic;
            up_down : in std_logic;
            sum : out std_logic_vector(2 downto 0);
            cout : out std_logic);
    end component;
    
signal clk : std_logic;
signal resetn : std_logic;
signal count_en : std_logic;
signal up_down : std_logic; 
signal sum : std_logic_vector(2 downto 0);
signal cout : std_logic;


constant period : time := 10ns;
   
begin
uut : counter3_nolimit
        port map (
                clk => clk,
                resetn => resetn,
                count_en => count_en,
                up_down => up_down,
                sum => sum,
                cout => cout);

generate_reset :process
    begin
        -- reset every 100ns
        resetn <= '0';
        wait for period*20;
        resetn <= '1';
        wait for period*50;
    end process;
    
        
    generate_count_en : process
     begin
           --si every 100ns
           count_en <= '0';
           wait for period*10;
           count_en <= '1';
           wait for period*40;
    end process;
    
generate_clock : process
        begin
             --clock every period
               clk <= '0';
               wait for period;
               clk <= '1';
               wait for period;
         end process;
         
generate_up_down : process
              begin
                    --si every 100ns
                    up_down <= '0';
                    wait for period*20;
                    up_down <= '1';
                    wait for period*20;
             end process;


end Bench;
