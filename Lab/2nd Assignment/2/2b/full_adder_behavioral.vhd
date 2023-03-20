library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.all;


entity full_adder_behavioral is
    Port ( FA: in std_logic;
           FB: in std_logic;
           Cin : in STD_LOGIC;
           sum : out STD_LOGIC;
           Cout : out STD_LOGIC);
end full_adder_behavioral;



architecture Behavioral of full_adder_behavioral is
signal s: std_logic_vector(1 downto 0);
begin
    s <= ('0'& FA) + ('0'& FB) + ('0' & Cin);
    sum <= s(0);
    Cout <= s(1);
end Behavioral;
