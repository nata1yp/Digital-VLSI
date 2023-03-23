library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ram is
	 generic (
		data_width : integer :=8  				--- width of data (bits)
	 );
    port (clk  : in std_logic;
          rst: in std_logic;
          valid_in: in std_logic;
          we   : in std_logic;						--- memory write enable
		  en   : in std_logic;				--- operation enable
          addr : in std_logic_vector(2 downto 0);			-- memory address
          di   : in std_logic_vector(data_width-1 downto 0);		-- input data
          do   : out std_logic_vector(data_width-1 downto 0));		-- output data
end ram;

architecture Behavioral of ram is

    type ram_type is array (7 downto 0) of std_logic_vector (data_width-1 downto 0);
    signal RAM : ram_type := (others => (others => '0'));
	--signal output: std_logic_vector(7 downto 0); 
begin


    process (clk)
    variable i : natural range 0 to 8;
    begin
        if rst='1' then
            RAM <= (others=> (others=>'0'));
            do<=(others=>'0');
            i:=0;
        elsif clk'event and clk = '1' then
            if en = '1' then
                if we = '1'  then				-- write operation
                        do <= di;
                        RAM<= RAM(6 DOWNTO 0) & di;     
                else						-- read operation
                    do <= RAM(conv_integer(addr));
                end if;   
                i := i+1;
                if i=8 then
                    i:=0;
                end if;
            end if; 
        end if;     
    end process;

    
end Behavioral;