library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_register is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           si : in STD_LOGIC;
           en : in STD_LOGIC;
           pl : in STD_LOGIC;
           left_right : in STD_LOGIC;
           din : in STD_LOGIC_VECTOR (3 downto 0);
           so : out STD_LOGIC);
end shift_register;

architecture Behavioral of shift_register is
    signal dff: std_logic_vector(3 downto 0);
    signal output: std_logic;
begin
    edge: process (clk,rst,left_right)
    begin
        if rst='0' then
            dff<=(others=>'0');
            output<=dff(0);
        elsif clk'event and clk='1' then
            if left_right='0' then --right shift
                if pl='1' then
                    dff<=din;    
                elsif en='1' then
                    dff<=si&dff(3 downto 1);
                end if;
                output <= dff(0);
            else                    --left shift
                if pl='1' then
                    dff<=din;
                elsif en='1' then
                    dff<=dff(2 downto 0)&si;
                end if;
                output <= dff(3);
            end if;    
        end if;

  end process;
  so <= output;

end Behavioral;

