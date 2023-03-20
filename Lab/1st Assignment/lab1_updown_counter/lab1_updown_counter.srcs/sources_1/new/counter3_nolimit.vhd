library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;


entity counter3_nolimit is
    Port ( clk : in STD_LOGIC;
           resetn : in STD_LOGIC;
           count_en : in STD_LOGIC;
           sum : out STD_LOGIC_VECTOR (2 downto 0);
           cout : out STD_LOGIC;
           up_down : in STD_LOGIC);
end counter3_nolimit;

architecture Behavioral of counter3_nolimit is
    signal count: std_logic_vector(2 downto 0);
    signal output: std_logic;
begin
    process(clk, resetn, up_down)
    begin
    if resetn='0' then -- ??????? ??? ??? ????????? ??? reset (?????? ??????)
        count <= (others=>'0');
        output<= '0';
    elsif clk'event and clk='1' then
        case up_down is
            when '1' => --up counting
            if count_en='1' then 
                count<=count+1;
               if count=7 then
                output<='1';
               else
                output<='0'; 
            end if;
            end if;
            
            when others => --down counting
            if count_en='1' then 
                count<=count-1;
                 if count=0 then
                   output<='1';
                  else
                   output<='0'; 
                end if;
            end if;
        end case;
    end if;
    end process;
    
    sum <= count; -- ??????? ????? ??? ?????? ??????
    cout<=output;

end Behavioral;
