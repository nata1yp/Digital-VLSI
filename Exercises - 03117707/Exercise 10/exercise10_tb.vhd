library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity exercise10_tb is
end exercise10_tb;

architecture Bench of exercise10_tb is
component exercise10 is
   generic (
   max_space : integer := 7        --we set the maximum available space in the parking to be 1111111=>127 cars
   );
    Port (A : in STD_LOGIC;
           B : in STD_LOGIC;
           cars : out STD_LOGIC_VECTOR (max_space downto 0));
end component;

signal A,B:std_logic;
signal cars: std_logic_Vector(7 downto 0);

constant period : time:=10ns;

begin
uut : exercise10
    port map (
        A=>A,
        B=>B,
        cars=>cars);
        
generate_A : process
    begin
        A<='1';
        wait for period;
        A<='0';
        wait for period*2;
        A<='1';
        wait for period*2;
        A<='1';
        wait for period;
        A<='0';
        wait for period*2;
        A<='1';
        wait for period*2;
        A<='1';
        wait for period;
        A<='0';
        wait for period*2;
        A<='1';
        wait for period*2;
        A<='1';
        wait for period;
        A<='0';
        wait for period*2;
        A<='1';
        wait for period*2;
        A<='1';
        wait for period;
        A<='0';
        wait for period*2;
        A<='1';
        wait for period*2;
        A<='1';
        wait for period*2;
        A<='0';
        wait for period*2;
        A<='1';
        wait for period;
        A<='1';
        wait for period*2;
        A<='0';
        wait for period*2;
        A<='1';
        wait for period;
    end process;

generate_B : process
    begin
        B<='1';
        wait for period*2;
        B<='0';
        wait for period*2;
        B<='1';
        wait for period;
        B<='1';
        wait for period*2;
        B<='0';
        wait for period*2;
        B<='1';
        wait for period;
        B<='1';
        wait for period*2;
        B<='0';
        wait for period*2;
        B<='1';
        wait for period;
        B<='1';
        wait for period*2;
        B<='0';
        wait for period*2;
        B<='1';
        wait for period;
        B<='1';
        wait for period*2;
        B<='0';
        wait for period*2;
        B<='1';
        wait for period;
        B<='1';
        wait for period;
        B<='0';
        wait for period*2;
        B<='1';
        wait for period*2;
        B<='1';
        wait for period;
        B<='0';
        wait for period*2;
        B<='1';
        wait for period*2;
        
     
    end process;
end Bench;
