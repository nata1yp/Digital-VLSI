library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bit_and_4bits is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC;
           Output: out STD_LOGIC_VECTOR (3 downto 0));
end bit_and_4bits;

architecture Behavioral of bit_and_4bits is

begin
    Output <= (A(3) and B)&(A(2) and B)&(A(1) and B)&(A(0) and B);

end Behavioral;