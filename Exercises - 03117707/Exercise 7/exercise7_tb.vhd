library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

entity exercise7_tb is
end exercise7_tb;

architecture Bench of exercise7_tb is
component exercise7 is
Port ( clk : in STD_LOGIC;
           CE : in STD_LOGIC;
           r_w : in STD_LOGIC;
           addr : in STD_LOGIC_VECTOR (11 downto 0);
           data_in : in STD_LOGIC_VECTOR (7 downto 0);
           data_out : out STD_LOGIC_VECTOR (7 downto 0));
end component;

signal clk,CE,r_w: std_logic;
signal addr: std_logic_vector(11 downto 0);
signal data_in,data_out:std_logic_vector(7 downto 0);

constant period: time:=10ns;

begin
uut: exercise7
 port map(clk=>clk,
            CE=>CE,
            r_w=>r_w,
            addr=>addr,
            data_in=>data_in,
            data_out=>data_out);
 
gen_clock: process
begin
    clk<='0';
    wait for period;
    clk<='1';
    wait for period;
end process;

gen_ce: process
begin
    CE<='0';
    wait for period*5;
    CE<='1';
    wait for period*10;
end process;

gen_r_w: process
begin
    r_w<='0';
    wait for period*5;
    r_w<='1';
    wait for period*5;
end process;

gen_addr: process
begin
    for j in 0 to 11 loop
      for i in 0 to 4095 loop
           addr <= std_logic_vector(to_unsigned(i, 12));
           wait for period*4;
      end loop;
    end loop;
end process;

gen_data_in: process
begin
    for j in 0 to 7 loop
          for i in 0 to 255 loop
               data_in <= std_logic_vector(to_unsigned(i, 8));
               wait for period*4;
          end loop;
    end loop;
end process;


end Bench;
