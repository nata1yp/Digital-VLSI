library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BCD_full_adder is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Cin : in STD_LOGIC;
           Cout : out STD_LOGIC;
           sum : out STD_LOGIC_VECTOR (3 downto 0));
end BCD_full_adder;

architecture Structural of BCD_full_adder is
    component rca_4bits is 
        Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Cin : in STD_LOGIC;
           Cout : out STD_LOGIC;
           S : out STD_LOGIC_VECTOR (3 downto 0));
       end component;

    signal s, s1,k: std_logic_vector(3 downto 0);
    signal and0, and1, L, c: std_logic;
     
begin
    rca1: rca_4bits
        port map(
            A => A,
            B => B,
            Cin => Cin,
            Cout => c,
            S => s);

    rca2: rca_4bits
        port map(
            A => s,
            B => k,
            Cin => '0',
            Cout => open,
            S => s1);   
    
    k <= '0' & L & L & '0'; 
    and0 <= s(3) and s(1);
    and1 <= s(3) and s(2);
    
    L <= c or and0 or and1;  
    
    sum <= s1;

    Cout <= L;


end Structural;