library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fir is
    generic (
            data_width : integer :=8;  				                 --- width of data (bits)
            coeff_width : integer :=8  
         );
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           valid_in : in STD_LOGIC;
           wenable : out STD_LOGIC;
           x : in STD_LOGIC_VECTOR (7 downto 0);
           valid_out : out STD_LOGIC;
            xn : out STD_LOGIC_VECTOR(7 downto 0);
           h : out STD_LOGIC_VECTOR(7 downto 0);
           y : out STD_LOGIC_VECTOR(18 downto 0));
end fir;

architecture Structural of fir is

component ram is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           valid_in : in STD_LOGIC;                                 -- valid input x
           we : in STD_LOGIC;                                       --- memory write enable
           en : in STD_LOGIC;                                       --- operation enable
           addr : in STD_LOGIC_VECTOR (2 downto 0);                 -- memory address
           di : in STD_LOGIC_VECTOR (data_width-1 downto 0);        -- input data
           do : out STD_LOGIC_VECTOR (data_width-1 downto 0));      -- output data
end component;

component rom is
 Port ( clk : in STD_LOGIC;
        en : in STD_LOGIC;                                   --- operation enable
        addr : in STD_LOGIC_VECTOR (2 downto 0);             -- memory address
        rom_out : out STD_LOGIC_VECTOR (coeff_width-1 downto 0));        -- output data
end component;

component mac is
    Port ( clk : in STD_LOGIC;
           mac_init : in STD_LOGIC;
           rom_out : in STD_LOGIC_VECTOR (7 downto 0);
           ram_out : in STD_LOGIC_VECTOR (7 downto 0);
           valid_out : out STD_LOGIC;
           y : out STD_LOGIC_VECTOR (18 downto 0));  
end component;

component control_unit is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           valid_in : in std_logic;
           enable_rom: out std_logic;
           enable_ram: out std_logic;
           we_ram: out std_logic;
           mac_init : out STD_LOGIC;
           rom_address : out STD_LOGIC_VECTOR(2 DOWNTO 0);
           ram_address : out STD_LOGIC_VECTOR(2 DOWNTO 0));
end component;

signal mac_in, enable_rom, enable_ram, we_ram, wenable1: std_logic;
signal rom_in, ram_in: std_logic_vector(2 downto 0);
signal h1,xn1,x1 : STD_LOGIC_VECTOR (7 downto 0);
begin

control: control_unit
    port map(clk=>clk, rst=>rst, valid_in=>valid_in, enable_rom=> enable_rom, enable_ram=>enable_ram,
             we_ram=> wenable1, mac_init=>mac_in, rom_address=>rom_in, ram_address=>ram_in);

rom_unit: rom
    port map(clk=>clk, en=>enable_rom, addr=> rom_in, rom_out=>h1);

ram_unit: ram
    port map(clk=>clk, rst=>rst, valid_in=>valid_in, we=>wenable1 ,en=> enable_ram, addr=> ram_in, di=>x1, do=> xn1);

mac_unit: mac
    port map(clk=>clk, mac_init=> mac_in, rom_out=> h1, ram_out=> xn1,valid_out=>valid_out, y=> y);
process(clk)
    begin
    if rising_edge(clk) then
        x1<=x;
    end if;
end process;
xn<=xn1;
h<=h1; 

end Structural;