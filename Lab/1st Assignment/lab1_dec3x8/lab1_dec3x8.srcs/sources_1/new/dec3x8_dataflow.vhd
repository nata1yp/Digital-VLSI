library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dec3x8_dataflow is
    Port ( enc : in STD_LOGIC_VECTOR (2 downto 0);
           dec : out STD_LOGIC_VECTOR (7 downto 0));
end dec3x8_dataflow;

architecture Dataflow of dec3x8_dataflow is

begin
    with enc select
        dec <=  "00000001" when "000", --dec(0) ON
                "00000010" when "001", --dec(1) ON
                "00000100" when "010", --dec(2) ON 
                "00001000" when "011", --dec(3) ON
                "00010000" when "100", --dec(4) ON
                "00100000" when "101", --dec(5) ON
                "01000000" when "110", --dec(6) ON
                "10000000" when "111", --dec(7) ON
                "00000000" when others; --in other situation dec<=0
      
end Dataflow;
