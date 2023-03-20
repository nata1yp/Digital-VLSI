library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity mac is
    Port ( clk : in STD_LOGIC;
           mac_init : in STD_LOGIC;
           rom_out : in STD_LOGIC_VECTOR (7 downto 0);
           ram_out : in STD_LOGIC_VECTOR (7 downto 0);
           valid_out : out STD_LOGIC;
           y : out STD_LOGIC_VECTOR (18 downto 0));
end mac;

architecture Behavioral of mac is

    signal output: std_logic_vector(18 downto 0) := (others => '0');
begin
    process(clk)
    begin
        if clk'event and clk='1' then
            if (mac_init = '1') then
               output<= (others => '0');
               valid_out<='0';
            else
            output<= output + rom_out * ram_out; 
            if rom_out=8 then
                y<=output;
                valid_out<='1';
            else 
                valid_out<='0';
           end if;
        end if;
    end if;
    end process;


end Behavioral;