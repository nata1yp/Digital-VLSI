library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;
use STD.textio.all;
use ieee.std_logic_textio.all;

entity debayering_filter_tb is
generic (
    N : integer := 8               
    );
end debayering_filter_tb;

architecture Bench of debayering_filter_tb is
    component debayering_filter is
        Port ( clk : in STD_LOGIC;
               rst_n : in STD_LOGIC;
               new_image : in STD_LOGIC;
               valid_in : in STD_LOGIC;
               pixel : in STD_LOGIC_VECTOR (7 downto 0);
              image_finished : out STD_LOGIC;
              valid_out : out STD_LOGIC;
              R : out STD_LOGIC_VECTOR (7 downto 0);
              G : out STD_LOGIC_VECTOR (7 downto 0);
              B : out STD_LOGIC_VECTOR (7 downto 0));
              ----------------------------------------
--             total_valid:out std_logic_vector(14 downto 0);
--              read: out STD_LOGIC;
--             write: out std_logic;
--              line_count : out STD_LOGIC_VECTOR(7 DOWNTO 0);
--              valid_count : out STD_LOGIC_VECTOR(7 DOWNTO 0);
--              flag: out STD_LOGIC_VECTOR(2 DOWNTO 0);
--              valid_out_pixels : out STD_LOGIC;
--              out_00 : out STD_LOGIC_VECTOR(7 DOWNTO 0);
--             out_01 : out STD_LOGIC_VECTOR(7 DOWNTO 0);
--             out_02 : out STD_LOGIC_VECTOR(7 DOWNTO 0);
--             out_10 : out STD_LOGIC_VECTOR(7 DOWNTO 0);
--             out_11 : out STD_LOGIC_VECTOR(7 DOWNTO 0);
--             out_12 : out STD_LOGIC_VECTOR(7 DOWNTO 0);
--             out_20 : out STD_LOGIC_VECTOR(7 DOWNTO 0);
--             out_21 : out STD_LOGIC_VECTOR(7 DOWNTO 0);
--             out_22 : out STD_LOGIC_VECTOR(7 DOWNTO 0));
      end component;
      
file file_input : text;

signal clk,rst_n,new_image,valid_in: std_logic;
signal pixel:std_logic_vector(7 downto 0);
---------------------------------
--signal total_valid: std_logic_vector(14 downto 0);
--signal read,write: std_logic;
--signal line_count,valid_count, out_00,out_01,out_02,out_10,out_11,out_12,out_20,out_21,out_22:std_logic_vector(7 downto 0);
--signal flag: std_logic_Vector(2 downto 0);
-------------------------
signal image_finished,valid_out : std_logic;
signal R,G,B:std_logic_vector(7 downto 0);



constant period: time:=10ns;
    
begin

uut: debayering_filter
    port map(clk=>clk, rst_n=>rst_n, valid_in=>valid_in,new_image=>new_image,
             pixel=>pixel,
             ------------------------------
--             total_valid=>total_valid, read=>read,write=>write,line_count=>line_count,valid_count=>valid_count,flag=>flag,
--             out_00 => out_00,
--                             out_01 => out_01,
--                             out_02 => out_02,
--                             out_10 => out_10,
--                             out_11 => out_11,
--                             out_12 => out_12,
--                             out_20 => out_20,
--                             out_21 => out_21,
--                             out_22 => out_22,
             ---------------------------------
             image_finished=>image_finished,valid_out=>valid_out,R=>R, G=>G, B=>B); 

generate_clock : process
    begin
         --clock every period
           clk <= '0';
           wait for period;
           clk <= '1';
           wait for period;
     end process;
                     
generate_reset :process
     begin
         rst_n <= '0';
         wait for period;
         rst_n <= '1';
         wait for period*100000;
     end process;
     
generate_new_image :process
          begin
              new_image <= '0';
              wait for period;
              new_image <= '1';
              wait for period;
              new_image <= '0';
              wait for period*100000;
          end process; 

generate_valid_in :process
          begin
              valid_in <= '0';
              wait for period;
              valid_in <= '1';
              wait;
          end process; 
          
input_din: process
--        variable v_ILINE: line;
--        variable pix : std_logic_vector(7 downto 0);
--       begin 
--       file_open(file_input, "C:\Users\User\lab4 - final\bayer6x6.txt",  read_mode);
--       while not endfile(file_input) loop
--            readline(file_input, v_ILINE);
--            read(v_ILINE, pix);
--            pixel <= pix;
--            wait for period*2;
--          end loop;
       
--          file_close(file_input);   


--begin
--        for j in 0 to N-1 loop
--          for i in 0 to N-1 loop
--               pixel <= std_logic_vector(to_unsigned(i, 8));
--               wait for period*2;
--          end loop;
--        end loop;
--       end process;

begin
-- X= 1
pixel <= "01100111";
wait for PERIOD*2;

-- X= 2
pixel<= "11000110";
wait for PERIOD*2;

-- X= 3
pixel <= "00000000";
wait for PERIOD*2;

-- X= 4
pixel <= "01110011";
wait for PERIOD*2;

-- X= 5
pixel <= "01010001";
wait for PERIOD*2;

-- X= 6
pixel <= "11111111";
wait for PERIOD*2;

-- X= 7
pixel <= "01001010";
wait for PERIOD*2;

-- X= 8
pixel <= "11101100";
wait for PERIOD*2;

-- X= 9
pixel <= "00101001";
wait for PERIOD*2;

-- X= 10
pixel <= "11001101";
wait for PERIOD*2;

-- X= 11
pixel <= "10111010";
wait for PERIOD*2;

-- X= 12
pixel <= "00000000";
wait for PERIOD*2;

-- X= 13
pixel <= "11110010";
wait for PERIOD*2;

-- X= 14
pixel <= "00000000";
wait for PERIOD*2;

-- X= 15
pixel <= "11100011";
wait for PERIOD*2;

-- X= 16
pixel <= "01000110";
wait for PERIOD*2;

-- X= 17
pixel <= "01111100";
wait for PERIOD*2;

-- X= 18
pixel <= "11000010";
wait for PERIOD*2;

-- X= 19
pixel <= "01010100";
wait for PERIOD*2;

-- X= 20
pixel <= "11111000";
wait for PERIOD*2;

-- X= 21
pixel <= "00011011";
wait for PERIOD*2;

-- X= 22
pixel <= "11101000";
wait for PERIOD*2;

-- X= 23
pixel <= "11100111";
wait for PERIOD*2;

-- X= 24
pixel <= "10001101";
wait for PERIOD*2;

-- X= 25
pixel <= "00001011";
wait for PERIOD*2;

-- X= 26
pixel <= "01011010";
wait for PERIOD*2;

-- X= 27
pixel <= "00101110";
wait for PERIOD*2;

-- X= 28
pixel <= "01100011";
wait for PERIOD*2;

-- X= 29
pixel <= "00110011";
wait for PERIOD*2;

-- X= 30
pixel <= "10011111";
wait for PERIOD*2;

-- X= 31
pixel <= "11001001";
wait for PERIOD*2;

-- X= 32
pixel <= "00000000";
wait for PERIOD*2;

-- X= 33
pixel <= "01100110";
wait for PERIOD*2;

-- X= 34
pixel <= "00110010";
wait for PERIOD*2;

-- X= 35
pixel <= "00001101";
wait for PERIOD*2;

-- X= 36
pixel <= "10110111";
wait for PERIOD*2;

-- X= 37
pixel <= "00110001";
wait for PERIOD*2;

-- X= 38
pixel <= "01011000";
wait for PERIOD*2;

-- X= 39
pixel <= "10100011";
wait for PERIOD*2;

-- X= 40
pixel <= "01011010";
wait for PERIOD*2;

-- X= 41
pixel <= "00100101";
wait for PERIOD*2;

-- X= 42
pixel <= "01011101";
wait for PERIOD*2;

-- X= 43
pixel <= "00000101";
wait for PERIOD*2;

-- X= 44
pixel <= "00010111";
wait for PERIOD*2;

-- X= 45
pixel <= "01011000";
wait for PERIOD*2;

-- X= 46
pixel <= "11101001";
wait for PERIOD*2;

-- X= 47
pixel <= "01011110";
wait for PERIOD*2;

-- X= 48
pixel <= "11010100";
wait for PERIOD*2;

-- X= 49
pixel <= "10101011";
wait for PERIOD*2;

-- X= 50
pixel <= "10110010";
wait for PERIOD*2;

-- X= 51
pixel <= "11001101";
wait for PERIOD*2;

-- X= 52
pixel <= "11000110";
wait for PERIOD*2;

-- X= 53
pixel <= "10011011";
wait for PERIOD*2;

-- X= 54
pixel <= "10110100";
wait for PERIOD*2;

-- X= 55
pixel <= "01010100";
wait for PERIOD*2;

-- X= 56
pixel <= "00010001";
wait for PERIOD*2;

-- X= 57
pixel <= "00001110";
wait for PERIOD*2;

-- X= 58
pixel <= "10000010";
wait for PERIOD*2;

-- X= 59
pixel <= "00000000";
wait for PERIOD*2;

-- X= 60
pixel <= "01000001";
wait for PERIOD*2;

-- X= 61
pixel <= "00100001";
wait for PERIOD*2;

-- X= 62
pixel <= "00111101";
wait for PERIOD*2;

-- X= 63
pixel <= "11011100";
wait for PERIOD*2;

-- X= 64
pixel <= "10000111";
wait for PERIOD*2;



end process;


end Bench;
