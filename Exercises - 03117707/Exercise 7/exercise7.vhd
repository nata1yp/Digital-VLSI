library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

entity exercise7 is
    Port ( clk : in STD_LOGIC;
           CE : in STD_LOGIC;
           r_w : in STD_LOGIC;
           addr : in STD_LOGIC_VECTOR (11 downto 0);
           data_in : in STD_LOGIC_VECTOR (7 downto 0);
           data_out : out STD_LOGIC_VECTOR (7 downto 0));
end exercise7;

architecture Behavioral of exercise7 is
type ram_type is array (0 to (2**addr'length)-1) of std_logic_vector(7 downto 0);
signal ram : ram_type;
signal ad:std_logic_Vector(11 downto 0);

begin

process(clk,CE)
begin
    if CE='1' then
        if r_w='1' then
            if rising_edge(clk) then
                ad<= addr;
            elsif falling_edge(clk) then
                ram(to_integer(unsigned(addr)))<=data_in;
            end if;
        else
           data_out<= ram(to_integer(unsigned(ad)));
        end if;
    end if;
end process;

end Behavioral;