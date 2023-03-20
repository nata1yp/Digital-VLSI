library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity exercise10 is
 generic (
   max_space : integer := 7        --we set the maximum available space in the parking to be 11111111=>127 cars
   );
    Port (A : in STD_LOGIC;
           B : in STD_LOGIC;
           cars : out STD_LOGIC_VECTOR (max_space downto 0));
end exercise10;

architecture Behavioral of exercise10 is
signal A1,B1,A2,B2,A3,B3,A4,B4:std_logic;       
signal num:std_logic_vector(max_space downto 0) :=(others=>'0');

begin
    process(A,B)
    begin
    A1<= A;
    B1<=B;
    A2<=A1;
    B2<=B1;
    A3<=A2;
    B3<=B2;
    A4<=A3;
    B4<=B3;
    if A4='1' and B4='1' then
        if A3='0' and B3='1' then
            if A2='0' and B2='0' then
                if A1='1' and B1='0' then
                    if A='1' and B='1' then
                        num<= num+1;
                    end if;
                end if;
            end if;
        end if;
    end if;
    if A4='1' and B4='1' then
        if A3='1' and B3='0' then
            if A2='0' and B2='0' then
                if A1='0' and B1='1' then
                    if A='1' and B='1' then
                        num <= num-1;
                    end if;
                end if;
            end if;
        end if;
    end if;
        cars<=num;
    end process;
end Behavioral;