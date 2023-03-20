library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;


entity debayering_filter is
    Port ( clk : in STD_LOGIC;
           rst_n : in STD_LOGIC;
           new_image : in STD_LOGIC;
           valid_in : in STD_LOGIC;
           pixel : in STD_LOGIC_VECTOR (7 downto 0);
           ------------------------------------------
--           total_valid:out std_logic_vector(14 downto 0);
--           read: out STD_LOGIC;
--          write: out std_logic;
--           line_count : out STD_LOGIC_VECTOR(7 DOWNTO 0);
--           valid_count : out STD_LOGIC_VECTOR(7 DOWNTO 0);
--           flag: out STD_LOGIC_VECTOR(2 DOWNTO 0);
--           valid_out_pixels : out STD_LOGIC;
--           out_00 : out STD_LOGIC_VECTOR(7 DOWNTO 0);
--          out_01 : out STD_LOGIC_VECTOR(7 DOWNTO 0);
--          out_02 : out STD_LOGIC_VECTOR(7 DOWNTO 0);
--          out_10 : out STD_LOGIC_VECTOR(7 DOWNTO 0);
--          out_11 : out STD_LOGIC_VECTOR(7 DOWNTO 0);
--          out_12 : out STD_LOGIC_VECTOR(7 DOWNTO 0);
--          out_20 : out STD_LOGIC_VECTOR(7 DOWNTO 0);
--          out_21 : out STD_LOGIC_VECTOR(7 DOWNTO 0);
--          out_22 : out STD_LOGIC_VECTOR(7 DOWNTO 0);
          image_finished : out STD_LOGIC;
          valid_out : out STD_LOGIC;
          R : out STD_LOGIC_VECTOR (7 downto 0);
          G : out STD_LOGIC_VECTOR (7 downto 0);
          B : out STD_LOGIC_VECTOR (7 downto 0));
end debayering_filter;

architecture Behavioral of debayering_filter is
component control_unit is
    Port ( clk : in STD_LOGIC;
           rst_n : in STD_LOGIC;
           valid_in : in STD_LOGIC;
           new_image : in STD_LOGIC;
           valid_out_pixels: in std_logic;
           total_valid: out std_logic_vector(14 downto 0);
           line_count : out STD_LOGIC_VECTOR(7 DOWNTO 0);
           valid_count : out STD_LOGIC_VECTOR(7 DOWNTO 0);
           flag: out STD_LOGIC_VECTOR(2 DOWNTO 0));
end component;

component ser_to_par is
    Port ( clk : in STD_LOGIC;
           rst_n : in STD_LOGIC;
           new_image: in STD_LOGIC;
           --total_valid:in std_logic_vector(14 downto 0);
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
           
end component;

component calculations is
    Port ( clk : in STD_LOGIC;
           rst_n : in STD_LOGIC;
           flag: in STD_LOGIC_VECTOR(2 DOWNTO 0); 
           valid_count: in std_logic_vector(7 downto 0);
           line_count : in std_logic_Vector(7 downto 0);
           in00 : in STD_LOGIC_VECTOR(7 DOWNTO 0);
           in01 : in STD_LOGIC_VECTOR(7 DOWNTO 0);
           in02 : in STD_LOGIC_VECTOR(7 DOWNTO 0);
           in10 : in STD_LOGIC_VECTOR(7 DOWNTO 0);
           in11 : in STD_LOGIC_VECTOR(7 DOWNTO 0);
           in12 : in STD_LOGIC_VECTOR(7 DOWNTO 0);
           in20 : in STD_LOGIC_VECTOR(7 DOWNTO 0);
           in21 : in STD_LOGIC_VECTOR(7 DOWNTO 0);
           in22 : in STD_LOGIC_VECTOR(7 DOWNTO 0);
           image_finished : out STD_LOGIC;
           valid_out : out STD_LOGIC;
           RED : out STD_LOGIC_VECTOR(9 DOWNTO 0);
           GREEN : out STD_LOGIC_VECTOR(9 DOWNTO 0);
           BLUE : out STD_LOGIC_VECTOR(9 DOWNTO 0));
end component;

signal total:std_logic_vector(14 downto 0);
signal valid_out_pix:std_logic;
signal inflag: std_logic_vector(2 downto 0);
signal valid_counter,line_counter: std_logic_vector(7 downto 0);
signal in00,in01,in02,in10,in11,in12,in20,in21,in22:std_logic_vector(7 downto 0);
signal redout,greenout,blueout:std_logic_vector(9 downto 0);
begin

control : control_unit
    port map(clk=>clk,rst_n=>rst_n,valid_in=>valid_in,new_image=>new_image,valid_out_pixels=>valid_out_pix,
            total_valid=>total,line_count=>line_counter,valid_count=>valid_counter,flag=>inflag);
 
 
serial_to_parallel: ser_to_par
    port map(clk=>clk,rst_n=>rst_n,new_image=>new_image,read=>open, 
            write=>open,pixel=>pixel,valid_out_pixels=>valid_out_pix,
            out_00=>in00, out_01=>in01, out_02=>in02, out_10=>in10, 
            out_11=>in11, out_12=>in12, out_20=>in20, out_21=>in21, out_22=>in22);   

final_calculations: calculations
    port map(clk=>clk, rst_n=>rst_n, flag=>inflag,valid_count=>valid_counter,line_count=>line_counter,
                in00=>in00,in01=>in01,in02=>in02,in10=>in10,in11=>in11,
                in12=>in12,in20=>in20,in21=>in21,in22=>in22,
                image_finished=>image_finished,valid_out=>valid_out,
                RED=>redout, GREEN=>greenout, BLUE=>blueout);

R<=redout(7 downto 0);
G<=greenout(7 downto 0);
B<=blueout(7 downto 0);
--total_valid<=total;
--out_00 <=in00;
--out_01 <=in01;
--out_02 <=in02;
--out_10 <=in10;
--out_11 <=in11;
--out_12 <=in12;
--out_20 <=in20;
--out_21 <=in21;
--out_22 <=in22;
--valid_out_pixels<=valid_out_pix;
--valid_count<=valid_counter;
--line_count<=line_counter;
--flag<=inflag;
end Behavioral;
