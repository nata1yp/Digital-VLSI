library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity full_adder_combinational is
    Port ( FA : in STD_LOGIC;
           FB : in STD_LOGIC;
           Cin : in STD_LOGIC;
           sum : out STD_LOGIC;
           Cout : out STD_LOGIC);
end full_adder_combinational;

architecture Dataflow of full_adder_combinational is
    component half_adder is
    Port( A : in STD_LOGIC;
               B : in STD_LOGIC;
               carry : out STD_LOGIC;
               sum : out STD_LOGIC);
    end component;
    
    signal s0, c0, c1: std_logic;

    begin
        u1: half_adder port map(
            A => FA,
            B => FB,                       
            sum => s0,
            carry => c0);
            
        u2: half_adder port map(
            A => Cin,
            B => s0,                       
            sum => sum,
            carry => c1);
          
        Cout <= c0 or c1;

end Dataflow;