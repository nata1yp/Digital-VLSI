library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity control_unit is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           valid_in : in std_logic;
           enable_rom: out std_logic;
           enable_ram: out std_logic;
           we_ram: out std_logic;
           mac_init : out STD_LOGIC;
           rom_address : out STD_LOGIC_VECTOR(2 DOWNTO 0);
           ram_address : out STD_LOGIC_VECTOR(2 DOWNTO 0));
end control_unit;

architecture Behavioral of control_unit is
signal count,output,count2 : std_logic_vector(2 downto 0);
signal mac,previous_valid, valid : std_logic;
begin

process(clk,rst)
--    variable k : natural range 1 to 100000;
--    variable i : natural range 1 to 8;
begin

    if rst = '1' then
        count<=(others=>'0');
        mac_init<='1';
        we_ram<='0';
        enable_rom<='0';
        enable_ram<='0';
        valid<='0';
    elsif clk'event and clk='1' then     
        if valid_in = '1' and valid='0' and (count="000" or count=8) then
            valid<='1';
            rom_address<= count;
            ram_address<= count;
            enable_rom<='1';
            enable_ram<='1';  
            mac_init<='1';
            we_ram<='1';
            count<=count+1;
        end if;    
            
        if valid = '1'  then
                mac_init<='0';
                we_ram<='0';
                rom_address<= count;
                ram_address<= count;    
            count2<=count; 
            count<=count+1;        
        end if;
        
        if count2=7 then
            count<="000";
            valid<='0';
            enable_rom<='0';
            enable_ram<='0';
        end if;
    end if;
