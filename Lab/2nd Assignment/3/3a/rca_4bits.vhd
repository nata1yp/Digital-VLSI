library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity rca_4bits is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Cin : in STD_LOGIC;
           Cout : out STD_LOGIC;
           S : out STD_LOGIC_VECTOR (3 downto 0));
end rca_4bits;

architecture Structural of rca_4bits is
    component full_adder_combinational is
      Port ( FA : in STD_LOGIC;
           FB : in STD_LOGIC;
           Cin : in STD_LOGIC;
           sum : out STD_LOGIC;
           Cout : out STD_LOGIC);
     end component;
     
     signal c1, c2, c3: std_logic;
     
begin
    fa1: full_adder_combinational 
        port map(
                Cin => Cin,
                FA => A(0),
                FB => B(0),                       
                sum => S(0),
                Cout => c1);
    
    fa2: full_adder_combinational 
        port map(
                Cin => c1,
                FA => A(1),
                FB => B(1),                       
                sum => S(1),
                Cout => c2);
  
    fa3: full_adder_combinational 
        port map(
                Cin => c2,
                FA => A(2),
                FB => B(2),                       
                sum => S(2),
                Cout => c3);

fa4: full_adder_combinational 
        port map(
                Cin => c3,
                FA => A(3),
                FB => B(3),                       
                sum => S(3),
                Cout => Cout);
end Structural;
