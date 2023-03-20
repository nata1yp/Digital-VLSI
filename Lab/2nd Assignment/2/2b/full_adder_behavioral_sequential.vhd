library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.all;

entity full_adder_behavioral_sequential is
    Port ( FA : in STD_LOGIC;
           FB : in STD_LOGIC;
           Cin : in STD_LOGIC;
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           sum : out STD_LOGIC;
           Cout : out STD_LOGIC);

end full_adder_behavioral_sequential;

architecture Behavioral of full_adder_behavioral_sequential is
signal s: std_logic_vector(1 downto 0);
begin
    s <= ('0'& FA) + ('0'& FB) + ('0' & Cin);
    process(clk, rst)
        begin
            if (rst='1') then
                sum <= '0';
                Cout <= '0';
            elsif (rising_edge(clk)) then   
                sum <= s(0);
                Cout <= s(1);
            end if;
        end process;

end Behavioral;