library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity shift_register_tb is

end shift_register_tb;

architecture Bench of shift_register_tb is

    component shift_register is
        port (
            clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            si : in STD_LOGIC;
            en : in STD_LOGIC;
            pl : in STD_LOGIC;
            left_right : in STD_LOGIC;
            din : in STD_LOGIC_VECTOR (3 downto 0);
            so : out STD_LOGIC);
    end component;

signal clk : std_logic;
signal rst : std_logic :='0';
signal si : std_logic;
signal en : std_logic;
signal pl : std_logic;
signal left_right : std_logic;
signal din : std_logic_vector(3 downto 0) := (others => '0');
signal so : std_logic;

constant period : time := 10 ns;

begin
    uut : shift_register
        port map (
                clk => clk,
                rst => rst,
                si => si,
                en => en,
                pl => pl,
                left_right => left_right,
                din => din,
                so => so);
    generate_reset :process
    begin
        -- reset every 100ns
        rst <= '0';
        --din <= (others => '0');
        wait for period*10;
        rst <= '1';
        wait for period*10;
    end process;
    
    generate_left_or_right_shift : process
    begin
        --left_right every 60ns
        left_right <= '0';
        wait for period*6;
        left_right <= '1';
        wait for period*6;
    end process;
    
    generate_si : process
     begin
           --si every 70ns
           si <= '0';
           wait for period*7;
           si <= '1';
           wait for period*7;
    end process;
    
    generate_enable : process
    begin
        --enable shift every 30ns
        en <= '0';
        wait for period*3;
        en <= '1';
        wait for period*3;
    end process;
    
    generate_parallel : process
    begin
        --parallel every 50ns
        pl <= '0';
        wait for period*5;
        pl <= '1';
        wait for period*5;
     end process;
     
     generate_din : process
     begin        
        din <= "0000";
        wait for period*2;
        din <= "0001";
        wait for period*2;
        din <= "0010";
        wait for period*2;
        din <= "0011";
        wait for period*2;
        din <= "0100";
        wait for period*2;
        din <= "0101";
        wait for period*2;
        din <= "0110";
        wait for period*2;
        din <= "0111";
        wait for period*2;
        din <= "1000";
        wait for period*2;
        din <= "1001";
        wait for period*2;
        din <= "1010";
        wait for period*2;
        din <= "1011";
        wait for period*2;
        din <= "1100";
        wait for period*2;
        din <= "1101";
        wait for period*2;
        din <= "1110";
        wait for period*2;
        din <= "1111";
        wait for period*2;
end process;
         
        
    generate_clock : process
    begin
         --clock every period
           clk <= '0';
           wait for period;
           clk <= '1';
           wait for period;
     end process;
        
        

end Bench;
