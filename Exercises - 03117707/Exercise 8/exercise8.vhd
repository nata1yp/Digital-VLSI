library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity exercise8 is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           enable : in STD_LOGIC;
           up_down : in STD_LOGIC;          
           data_in_enable: in STD_LOGIC;    
           data_in : in STD_LOGIC_VECTOR(31 DOWNTO 0);
           counter : out STD_LOGIC_VECTOR (31 downto 0));
end exercise8;

architecture Behavioral of exercise8 is
signal rst:std_logic;
signal count:std_logic_vector(31 downto 0);

begin

process(clk)
begin


    if reset='1' then       
        count<=(others=>'0');      
        counter<=(others=>'0');     
    elsif data_in_enable = '1' then
            count <= data_in;
    elsif rising_edge(clk) then
        if enable='1' then            
            if up_down='1' then     
                count<= count+1;
            else
                count<=count-1;     
            end if;
        end if; 
    counter<=count;             
    end if;
       
end process;

end Behavioral;