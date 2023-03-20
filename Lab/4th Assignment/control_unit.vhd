library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

entity control_unit is
    generic (
    N : integer := 8               
    );
    Port ( clk : in STD_LOGIC;
           rst_n : in STD_LOGIC;
           valid_in : in STD_LOGIC;
           new_image : in STD_LOGIC;
           valid_out_pixels: in STD_LOGIC;
           total_valid: out std_logic_vector(14 downto 0);--in case of 128x128 we will have 16384 pixels so in binary it is 15bits(100000000000000)
           line_count : out STD_LOGIC_VECTOR(7 DOWNTO 0);
           valid_count : out STD_LOGIC_VECTOR(7 DOWNTO 0); 
           flag: out STD_LOGIC_VECTOR(2 DOWNTO 0));
end control_unit;

architecture Behavioral of control_unit is

signal new_im : std_logic;
signal line_counter, valid_in_counter : std_logic_vector(7 downto 0);
signal total:std_logic_vector(14 downto 0);
begin

process(clk)
    begin
        if rst_n ='0' then
            flag<="000";
            line_counter<="00000001";
            line_count<="00000000";
            valid_in_counter<="00000001";
            valid_count<="00000000";
            total_valid<=(others=>'0');
            total<=(others=>'0');
            new_im<='0';
        elsif rising_edge(clk) then
            if new_image='1' and valid_in='1' then
                line_counter<="00000001";
--                line_count<="00000001";
                valid_in_counter<= "00000001";
                total<="000000000000001";
--                valid_count<="00000001";
                new_im<='1';
            end if;
            if valid_out_pixels='1' then
                if valid_in='1' and new_im='1' then
                    if valid_in_counter<=N and line_counter<=N then  --if the line isnt completed yet
                        if valid_in_counter="00000001" and line_counter="00000001" then
                            line_count<="00000001";
                            valid_count<="00000001";
                            total<="000000000000001";
                        end if;
                        if line_counter(0) = '1' then --if we are in a odd number of line
                            if valid_in_counter(0) = '1' then 
                                flag<="010";   --in the odd number of valid_ins we have the second option(GREEN WITH RED ABOVE AND BELOW)
                            else
                                flag<="100";   --in the even number of valid_ins we have the blue option
                            end if;
                        else                        --else if we are in an even number of line
                            if valid_in_counter(0) = '1' then
                                flag<="011";    --the odd number of valid_ins is red
                            else
                            flag<="001";        --the even number of valid_ins are the first option(GREEN WITH BLUE ABOVE AND BELOW)    
                            end if;
                        end if;
                    valid_count<=valid_in_counter;
                    valid_in_counter<= valid_in_counter + 1; 
                    total_valid<=total; 
                    total<=total+1;
                    
                        if valid_in_counter = N then
                            valid_in_counter<=  "00000001";
                            line_counter<=line_counter + 1;  --if the line is completed increase the line_counter       
                        end if;
                    line_count<=line_counter;
                       
                    end if;
                    if line_counter=N+1 then
                        flag<="000";
                        valid_count<="00000000";
                        line_count<="00000000";
                        total_valid<=(others=>'0');
                        total<=(others=>'0');
                    end if;
                end if;  
            end if;
  
        end if;
end process;
end Behavioral;