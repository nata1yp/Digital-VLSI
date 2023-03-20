library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

entity exercise8_tb is
end exercise8_tb;

architecture Bench of exercise8_tb is
component exercise8 is
     Port ( clk : in STD_LOGIC;
          reset : in STD_LOGIC;
          enable : in STD_LOGIC;
          up_down : in STD_LOGIC;          --if up_down =1 then up counting, else down counting
          data_in_enable: in STD_LOGIC;
          data_in : in STD_LOGIC_VECTOR(31 DOWNTO 0);
          counter : out STD_LOGIC_VECTOR (31 downto 0));
end component;

signal clk,reset,enable,up_down,data_in_enable:std_logic;
signal data_in,counter:std_logic_vector(31 downto 0);

constant period:time:=5ns;

begin
uut: exercise8
 port map( clk=>clk,
            reset=>reset,
            enable=>enable,
            up_down=>up_down,
            data_in_enable=>data_in_enable,
            data_in=>data_in,
            counter=>counter);

clock: process
begin
    clk<='0';
    wait for period;
    clk<='1';
    wait for period;
end process;

generate_reset: process
begin
    reset<='1';
    wait for period;
    reset<='0';
    wait for period*19;

end process;


generate_enable: process
begin
    enable<='0';
    wait for period*2;
    enable<='1';
    wait for period*2;
end process;

generate_updown: process
begin 
    up_down<='1';
    wait for period*10;
    up_down<='0';
    wait for period*10;
end process;


data_enable: process
begin
    data_in_enable<='1';
    wait for period*2;
    data_in_enable<='0';
    wait for period*20;

end process;


generate_datain: process
begin
    for i in 0 to 2**16 loop
               data_in <= std_logic_vector(to_unsigned(i, 32));
               wait for period;
          end loop;
end process;
end Bench;