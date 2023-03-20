library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BCD_4_PA is
    Port ( A : in STD_LOGIC_VECTOR (15 downto 0);
           B : in STD_LOGIC_VECTOR (15 downto 0);
           --Cin: in STD_LOGIC;
           s : out STD_LOGIC_VECTOR (15 downto 0);
           Cout : out STD_LOGIC);
end BCD_4_PA;

architecture Structural of BCD_4_PA is
    component BCD_full_adder is 
        Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Cin : in STD_LOGIC;
           Cout : out STD_LOGIC;
           sum : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    signal c1, c2, c3, c4: std_logic;

begin
    
    BCD_4_1: BCD_full_adder
    port map(
        A => A(3 downto 0),
        B => B(3 downto 0),
        Cin => '0',
        Cout => c1,
        sum => s(3 downto 0));

    BCD_4_2: BCD_full_adder
    port map(
        A => A(7 downto 4),
        B => B(7 downto 4),
        Cin => c1,
        Cout => c2,
        sum => s(7 downto 4));   

    BCD_4_3: BCD_full_adder
    port map(
        A => A(11 downto 8),
        B => B(11 downto 8),
        Cin => c2,
        Cout => c3,
        sum => s(11 downto 8));

    BCD_4_4: BCD_full_adder
    port map(
        A => A(15 downto 12),
        B => B(15 downto 12),
        Cin => c3,
        Cout => Cout,
        sum => s(15 downto 12)); 

end Structural;