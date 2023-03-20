library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;


entity ser_to_par is
    generic (
		N : integer := 8 				
	 );
    Port ( clk : in STD_LOGIC;
           rst_n : in STD_LOGIC;
           new_image: in STD_LOGIC;
           read: out STD_LOGIC;
           write: out std_logic;
           pixel: in STD_LOGIC_VECTOR(7 DOWNTO 0);
           valid_out_pixels : out STD_LOGIC;
           out_00 : out STD_LOGIC_VECTOR(7 DOWNTO 0);
           out_01 : out STD_LOGIC_VECTOR(7 DOWNTO 0);
           out_02 : out STD_LOGIC_VECTOR(7 DOWNTO 0);
           out_10 : out STD_LOGIC_VECTOR(7 DOWNTO 0);
           out_11 : out STD_LOGIC_VECTOR(7 DOWNTO 0);
           out_12 : out STD_LOGIC_VECTOR(7 DOWNTO 0);
           out_20 : out STD_LOGIC_VECTOR(7 DOWNTO 0);
           out_21 : out STD_LOGIC_VECTOR(7 DOWNTO 0);
           out_22 : out STD_LOGIC_VECTOR(7 DOWNTO 0)
           );
           
end ser_to_par;

architecture Behavioral of ser_to_par is

type arrayof3 is array (2 downto 0) of std_logic_vector(7 downto 0);
signal array0,array1,array2 : arrayof3 :=(others=>(others=> '0'));
signal in_pix0,out_pix0,in_pix1,out_pix1,in_pix2,out_pix2,  bet00,bet01,bet02,bet000,bet001,bet002,bet10,bet11,bet12: std_logic_vector(7 downto 0);
signal valid_out0,valid_out1,valid_out2 ,wr_en,rd_en, new_im:std_logic;
signal counter,valid_counter:std_logic_vector(14 downto 0);
signal rst_fifo: std_logic;

COMPONENT fifo_0
  PORT (
    clk : IN STD_LOGIC;
    srst : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    rd_en : IN STD_LOGIC;
    dout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    full : OUT STD_LOGIC;
    empty : OUT STD_LOGIC;
    valid : OUT STD_LOGIC
  );
END COMPONENT;

begin
rst_fifo <= not rst_n;

fifo_line_0 : fifo_0
  PORT MAP (
    clk => clk,
    srst => rst_fifo,
    din => in_pix0,
    wr_en => wr_en,
    rd_en => rd_en,
    dout => out_pix0,
    full => open,
    empty => open,
    valid => valid_out0
  );

fifo_line_1 : fifo_0
  PORT MAP (
    clk => clk,
    srst => rst_fifo,
    din => out_pix0,
    wr_en => wr_en,
    rd_en => rd_en,
    dout => out_pix1,
    full => open,
    empty => open,
    valid => valid_out1
  );

fifo_line_2 : fifo_0
  PORT MAP (
    clk => clk,
    srst => rst_fifo,
    din => out_pix1,
    wr_en => wr_en,
    rd_en => rd_en,
    dout => out_pix2,
    full => open,
    empty => open,
    valid => valid_out2
  );


process(clk)
    variable valid_count : natural range 1 to N**2 ;
   begin
        if rst_n ='0' then --make everything zero and make the counters start over
            out_00 <=(others=>'0');
            out_01 <=(others=>'0');
            out_02 <=(others=>'0');
            out_10 <=(others=>'0');
            out_11 <=(others=>'0');
            out_12 <=(others=>'0');
            out_20 <=(others=>'0');
            out_21 <=(others=>'0');
            out_22 <=(others=>'0');
            array0<=(others=>(others=>'0'));
            array1<=(others=>(others=>'0'));
            array2<=(others=>(others=>'0'));
            valid_out_pixels<='0'; 
            valid_count:=1;
            wr_en<='0';
            write<='0';
            rd_en<='0';
            read<='0';
            counter<=(others=>'0');
            new_im<='0';
            
        elsif rising_edge(clk) then
--            if total_valid<=N then
              if new_image='1' then
                new_im<='1';
                wr_en<='1';
                write<='1';
                in_pix0<=pixel;
                valid_count:=valid_count+1;
              end if;
              if new_im='1' then
                if valid_count<=N**2  then
                    in_pix0<=pixel;
                else
                    in_pix0<=(others=>'0');
                end if;
                wr_en<='1';
                write<='1'; --just a signal so we can see when the write in the first fifo starts
                
                if valid_count > N then
                    rd_en<='1';
                    read<='1'; --just a signal so we can see when the read in the first fifo starts
                end if;
                valid_count := valid_count+1;
                
                if valid_out0 ='1' then
                    array0<= array0(1 downto 0) & out_pix0;
                end if;
                if valid_out1 ='1' then
                    array1<= array1(1 downto 0) & out_pix1;
                end if;
                if valid_out2 ='1' then
                    array2<= array2(1 downto 0) & out_pix2;
                end if;
                if counter>=2*N+2+1 then  --2*N to fill first and second fifo +2 to go in the middle +2 for fifo read latency
                    bet00<=array0(0);
                    bet01<=array0(1);
                    bet02<=array0(2);
               end if;
               if counter>=2*N+2+2 then --pipeline so the latency of every fifo doesnt effect the output
                    bet000<=bet00;
                    bet001<=bet01;
                    bet002<=bet02;
                    bet10<=array1(0);
                    bet11<=array1(1);
                    bet12<=array1(2);
                    valid_out_pixels<='1';
    
                end if;
                if counter>=2*N+2+3 then --the output comes out after two cycles in order for every fifo to read simultaneously
                    out_00 <=bet000;
                    out_01 <=bet001;
                    out_02 <=bet002;
                    out_10 <=bet10;
                    out_11 <=bet11;
                    out_12 <=bet12;
                    out_20 <=array2(0);
                    out_21 <=array2(1);
                    out_22 <=array2(2);
--                    valid_out_pixels<='1';
                end if;
                counter<= counter+1; --just a cycle counter
               end if; 
--            end if;
            
     end if;  
              
end process; 



end Behavioral;
