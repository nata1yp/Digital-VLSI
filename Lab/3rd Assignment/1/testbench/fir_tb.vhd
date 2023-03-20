library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

entity fir_tb is
end fir_tb;

architecture Bench of fir_tb is
    component fir is
     Port ( 
          clk : in STD_LOGIC;
          rst : in STD_LOGIC;
          valid_in : in STD_LOGIC;                                                                              
          x : in STD_LOGIC_VECTOR (7 downto 0);      
          xn : out STD_LOGIC_VECTOR(7 downto 0);
          --h : out STD_LOGIC_VECTOR(7 downto 0);
          valid_out: out std_logic; 
          y : out STD_LOGIC_VECTOR (18 downto 0));    
end component;

signal clk : std_logic;
signal rst : std_logic;
signal valid_in : std_logic;
signal x,xn : std_logic_vector(7 downto 0) := (others => '0');
signal valid_out: std_logic;
signal y : std_logic_vector(18 downto 0);

constant period : time := 10 ns;

begin
uut : fir
        port map (
                clk => clk,
                rst => rst,
                valid_in => valid_in,
                x => x,
                xn=>xn,
                --h=>h,
                valid_out=>valid_out,
                y => y);

generate_clock : process
    begin
         --clock every period
           clk <= '0';
           wait for period/2;
           clk <= '1';
           wait for period/2;

     end process;
     
generate_reset :process
     begin
         -- reset every 100ns
         rst <= '1';
         --din <= (others => '0');
         wait for period;
         rst <= '0';
         wait for period*50;
     end process;


generate_valid_in :process
     begin
         valid_in <= '0';
         wait for period;
         valid_in <= '1';
         wait for period;
         --valid_in <= '0';
--         wait for period;
--         valid_in <= '1';
--         wait for period*50;
      end process;
 
 
 input_x: process
             begin 
                for i in 0 to 2**8 loop
                     x <= std_logic_vector(to_unsigned(i, 8));
                     wait for period/2;
                end loop;
             end process;

end Bench;