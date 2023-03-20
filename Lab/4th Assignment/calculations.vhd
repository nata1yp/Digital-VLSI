library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;


entity calculations is
    generic (
		N : integer := 8  				
	 );
    Port ( clk : in STD_LOGIC;
           rst_n : in STD_LOGIC;
           flag: in STD_LOGIC_VECTOR(2 DOWNTO 0); 
           valid_count: in std_logic_vector(7 downto 0);
           line_count : in std_logic_Vector(7 downto 0);
           --valid_in_pixels: in STD_LOGIC;
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
end calculations;

architecture Behavioral of calculations is

 
begin

process(clk,rst_n)
begin
    if rst_n ='0' then
        RED<=(others=>'0');
        GREEN<=(others=>'0');
        BLUE<=(others=>'0');
        valid_out<='0';
        image_finished<='0';
    elsif rising_edge(clk) then
        if line_count ="00000001" then                                                          --stin prwti grammi
            if valid_count="00000001" then  --sto prwto stoixeio den xriazete mesos oros giati exume ena blue ena red kai ena green
                RED<=std_logic_vector(unsigned('0'&'0'&in01)/2);                    
                GREEN<='0'&'0'&(in11);
                BLUE<=std_logic_vector(unsigned('0'&'0'&in10)/2);
                valid_out<='1';
            elsif valid_count>"00000001" and valid_count<N then --an ine endiamesa stin prwti grammi
                if flag=4 then              --an ine blue
                    RED<=std_logic_vector((unsigned('0'&'0'&in02)+unsigned('0'&'0'&in00))/4);                   --mesos oros mono dio red 
                    GREEN<=std_logic_vector(((unsigned('0'&'0'&in12)+unsigned('0'&'0'&in10))+unsigned('0'&'0'&in01))/4);    --mesos oros mono 3 green
                    BLUE<='0'&'0'&in11;                                                                --to mesaio ine to blue
                 elsif flag=2 then          --an ine green  
                    RED<=std_logic_vector(unsigned('0'&'0'&in01)/2);                
                    GREEN<='0'&'0'&in11;                --mesaio to prasino
                    BLUE<=std_logic_vector((unsigned('0'&'0'&in12)+unsigned('0'&'0'&in10))/2);   --dio plaina mple
                end if;
            elsif valid_count=N then        --an ine sto telos tiw prwtis grammis
                if flag=4 then      --an to teleutaio stixeio mple              
                    RED<=std_logic_vector(unsigned('0'&'0'&in02)/4);
                    GREEN<=std_logic_vector((unsigned('0'&'0'&in12)+unsigned('0'&'0'&in01))/4);
                    BLUE<='0'&'0'&in11;
                 elsif flag=2 then      --an to teleutaio stoixeio green
                    RED<=std_logic_vector(unsigned('0'&'0'&in01)/2);
                    GREEN<='0'&'0'&in11;
                    BLUE<=std_logic_vector(unsigned('0'&'0'&in12)/2);
                end if;
            end if;
        elsif line_count>"00000001" and line_count<N and valid_count="00000001" then         --an imaste stin prwti stili alla oxi stin prwti i teleutaia grammi
            if flag=3 then  --an ine kokkino
                RED<='0'&'0'&in11;
                GREEN<=std_logic_vector((unsigned('0'&'0'&in21)+unsigned('0'&'0'&in10)+unsigned('0'&'0'&in01))/4);
                BLUE<=std_logic_vector((unsigned('0'&'0'&in20)+unsigned('0'&'0'&in00))/4);
            elsif flag=2 then   --an ine prasino
                RED<=std_logic_vector((unsigned('0'&'0'&in21)+unsigned('0'&'0'&in01))/2);
                GREEN<='0'&'0'&in11;
                BLUE<=std_logic_vector(unsigned('0'&'0'&in10)/2);
            end if;
        elsif line_count>"00000001" and line_count<N and valid_count=N then             --an imaste stin teluetaia stili alla oxi stin prwti i teltutaia grammi
            if flag=4 then      --an to teleutaio stixeio mple              
                RED<=std_logic_vector((unsigned('0'&'0'&in02)+unsigned('0'&'0'&in22))/4);
                GREEN<=std_logic_vector((unsigned('0'&'0'&in21)+unsigned('0'&'0'&in12)+unsigned('0'&'0'&in01))/4);
                BLUE<='0'&'0'&in11;
             elsif flag=2 then      --an to teleutaio stoixeio green me panw katw red
                RED<=std_logic_vector(unsigned('0'&'0'&in12)/2);
                GREEN<='0'&'0'&in11;
                BLUE<=std_logic_vector((unsigned('0'&'0'&in21)+unsigned('0'&'0'&in01))/2);
            elsif flag=3 then       --an teleutaio red
                RED<='0'&'0'&in11;
                GREEN<=std_logic_vector((unsigned('0'&'0'&in21)+unsigned('0'&'0'&in12)+unsigned('0'&'0'&in01))/4);
                BLUE<=std_logic_vector((unsigned('0'&'0'&in02)+unsigned('0'&'0'&in22))/4);
            elsif flag=1 then       --an teleutaio green me panw katw blue
                RED<=std_logic_vector(unsigned('0'&'0'&in12)/2);
                GREEN<='0'&'0'&in11;
                BLUE<=std_logic_vector((unsigned('0'&'0'&in01)+unsigned('0'&'0'&in21))/2);
            end if;
         elsif line_count=N then                                                        --teleutaia grammi
            if valid_count="00000001" then      --prwto stoixeio teleutaias grammis
               if flag=3 then  --an ine kokkino
                    RED<='0'&'0'&in11;
                    GREEN<=std_logic_vector((unsigned('0'&'0'&in21)+unsigned('0'&'0'&in10))/4);
                    BLUE<=std_logic_vector(unsigned('0'&'0'&in20)/4);
                elsif flag=2 then   --an ine prasino
                    RED<=std_logic_vector(unsigned('0'&'0'&in21)/2);
                    GREEN<='0'&'0'&in11;
                    BLUE<=std_logic_Vector(unsigned('0'&'0'&in10)/2);
                end if; 
            elsif valid_count>"00000001" and valid_count<N then     --endiamesa stoixeia teleutaias grammis
                if flag=4 then      --an mple              
                    RED<=std_logic_vector((unsigned('0'&'0'&in22)+unsigned('0'&'0'&in20))/4);
                    GREEN<=std_logic_vector((unsigned('0'&'0'&in21)+unsigned('0'&'0'&in12)+unsigned('0'&'0'&in10))/4);
                    BLUE<='0'&'0'&in11;
                 elsif flag=2 then      --an to teleutaio stoixeio green me panw katw red
                    RED<=std_logic_vector(unsigned('0'&'0'&in21)/2);
                    GREEN<='0'&'0'&in11;
                    BLUE<=std_logic_vector((unsigned('0'&'0'&in12)+unsigned('0'&'0'&in10))/2);
                elsif flag=3 then       --an teleutaio red
                    RED<='0'&'0'&in11;
                    GREEN<=std_logic_vector((unsigned('0'&'0'&in21)+unsigned('0'&'0'&in12)+unsigned('0'&'0'&in10))/4);
                    BLUE<=std_logic_vector((unsigned('0'&'0'&in22)+unsigned('0'&'0'&in20))/4);
                elsif flag=1 then       --an teleutaio green me panw katw blue
                    RED<=std_logic_vector((unsigned('0'&'0'&in12)+unsigned('0'&'0'&in10))/2);
                    GREEN<='0'&'0'&in11;
                    BLUE<=std_logic_vector(unsigned('0'&'0'&in21)/2);
                end if;
            elsif valid_count=N then                            --teleutaio stoixeio teleutaias grammis
                if flag=4 then      --an mple              
                    RED<=std_logic_vector(unsigned('0'&'0'&in22)/4);
                    GREEN<=std_logic_vector((unsigned('0'&'0'&in21)+unsigned('0'&'0'&in12))/4);
                    BLUE<='0'&'0'&in11;
                elsif flag=2 then      --an green me panw katw red
                    RED<=std_logic_vector(unsigned('0'&'0'&in21)/2);
                    GREEN<='0'&'0'&in11;
                    BLUE<=std_logic_vector(unsigned('0'&'0'&in12)/2);
                elsif flag=3 then       --an red
                    RED<='0'&'0'&in11;
                    GREEN<=std_logic_vector((unsigned('0'&'0'&in21)+unsigned('0'&'0'&in12))/4);
                    BLUE<=std_logic_vector(unsigned('0'&'0'&in22)/4);
                elsif flag=1 then       --an einai green me panw katw blue
                    RED<=std_logic_vector(unsigned('0'&'0'&in12)/2);
                    GREEN<='0'&'0'&in11;
                    BLUE<=std_logic_vector(unsigned('0'&'0'&in21)/2);
                end if;
                image_finished<='1';
            end if;
         else                                                --kapu eswterika
                if flag=4 then      --an mple              
                     RED<=std_logic_vector((unsigned('0'&'0'&in22)+unsigned('0'&'0'&in20)+unsigned('0'&'0'&in02)+unsigned('0'&'0'&in00))/4);
                     GREEN<=std_logic_vector((unsigned('0'&'0'&in21)+unsigned('0'&'0'&in12)+unsigned('0'&'0'&in10)+unsigned('0'&'0'&in01))/4);
                     BLUE<='0'&'0'&in11;
                 elsif flag=2 then      --an green me panw katw red
                     RED<=std_logic_vector((unsigned('0'&'0'&in21)+unsigned('0'&'0'&in01))/2);
                     GREEN<='0'&'0'&in11;
                     BLUE<=std_logic_vector((unsigned('0'&'0'&in12)+unsigned('0'&'0'&in10))/2);
                 elsif flag=3 then       --an red
                     RED<='0'&'0'&in11;
                     GREEN<=std_logic_vector((unsigned('0'&'0'&in21)+unsigned('0'&'0'&in12)+unsigned('0'&'0'&in10)+unsigned('0'&'0'&in01))/4);
                     BLUE<=std_logic_vector((unsigned('0'&'0'&in22)+unsigned('0'&'0'&in20)+unsigned('0'&'0'&in02)+unsigned('0'&'0'&in00))/4);
                 elsif flag=1 then       --an green me panw katw blue
                     RED<=std_logic_vector((unsigned('0'&'0'&in12)+unsigned('0'&'0'&in10))/2);
                     GREEN<='0'&'0'&in11;
                     BLUE<=std_logic_vector((unsigned('0'&'0'&in21)+unsigned('0'&'0'&in01))/2);
                 end if;
         end if;
    end if;
end process;
end Behavioral;
