library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity half_adder is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           carry : out STD_LOGIC;
           sum : out STD_LOGIC);
end half_adder;

architecture Dataflow of half_adder is

begin
    sum <= A XOR B;
    carry <= A AND B;

end Dataflow;