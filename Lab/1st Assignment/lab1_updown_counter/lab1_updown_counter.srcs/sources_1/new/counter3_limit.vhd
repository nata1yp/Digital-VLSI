library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity counter3_limit is
    Port ( clk : in STD_LOGIC;
           resetn : in STD_LOGIC;
           count_en : in STD_LOGIC;
           sum : out STD_LOGIC_VECTOR (2 downto 0);
           cout : out STD_LOGIC);
end counter3_limit;

architecture Behavioral of counter3_limit is
signal count : std_logic_vector(2 downto 0);
signal modulo : std_logic_vector(2 downto 0);

begin
    process(clk, resetn)
    begin
    modulo <= std_logic_vector(to_unsigned(5,3));
        if resetn='0' then
            -- ?????????? ??????????
            count <= (others=>'0');
        elsif clk'event and clk='1' then
            if count_en = '1' then
                -- ??????? ???? ?? count_en=’1’
                if count/=modulo then
                    -- ????????? ?? ??????? ???? ??
                    -- ??? ????? modulo
                    count <= count+1;
                else
                    -- ?????? ??? ???????????
                    count<=(others=>'0');
                end if;
            end if;
        end if;
end process;
sum<= count;
cout <= '1' when count=modulo and count_en='1' else '0';

end Behavioral;
