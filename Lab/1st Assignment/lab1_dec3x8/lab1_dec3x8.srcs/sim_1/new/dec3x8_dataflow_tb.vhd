library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dec3x8_dataflow_tb is

end dec3x8_dataflow_tb;

architecture Bench of dec3x8_dataflow_tb is
    component dec3x8_dataflow is
    port (
            enc: in std_logic_vector(2 downto 0);
            dec: out std_logic_vector(7 downto 0));
    end component;
signal enc: std_logic_vector(2 downto 0) := (others => '0');
signal dec: std_logic_vector(7 downto 0);

constant delay : time := 5 ns;

begin
 uut : dec3x8_dataflow
       port map (
                   enc => enc,
                   dec => dec);
stimulus : process

   begin
       enc <= (others => '0');
       wait for delay;
       enc <= "000";
       wait for delay;
       enc <= "001";
       wait for delay;
       enc <= "010";
       wait for delay;
       enc <= "011";
       wait for delay;
       enc <= "100";
       wait for delay;
       enc <= "101";
       wait for delay;
       enc <= "110";
       wait for delay;
       enc <= "111";
       wait for delay;       
end process;                   
end Bench;
