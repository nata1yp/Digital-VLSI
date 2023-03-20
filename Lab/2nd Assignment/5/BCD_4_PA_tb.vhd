library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity BCD_4_PA_tb is
end BCD_4_PA_tb;

architecture Bench of BCD_4_PA_tb is
    component BCD_4_PA is
    Port ( A : in STD_LOGIC_VECTOR (15 downto 0);
           B : in STD_LOGIC_VECTOR (15 downto 0);
           --Cin: in STD_LOGIC;
           s : out STD_LOGIC_VECTOR (15 downto 0);
           Cout : out STD_LOGIC);
    end component;
    
    signal A, B: std_logic_vector(15 downto 0);
    --signal Cin: std_logic;
    signal s: std_logic_vector(15 downto 0);
    signal Cout: std_logic;
    
    constant period: time:=100ps;
    
begin
    uut: BCD_4_PA
    port map(
    A => A,
    B => B,
    --Cin => Cin,
    s => s,
    Cout => Cout
    );

    input_A: process
        begin 
            for i in 0 to 9 loop
                A(15 downto 12) <= std_logic_vector(to_unsigned(i, 4));
                for i in 0 to 9 loop
                    A(11 downto 8) <= std_logic_vector(to_unsigned(i, 4));
                    for i in 0 to 9 loop
                        A(7 downto 4) <= std_logic_vector(to_unsigned(i, 4));
                        for i in 0 to 9 loop
                            A(3 downto 0) <= std_logic_vector(to_unsigned(i, 4));
                            wait for period;
                        end loop;
                    end loop;
                end loop;
            end loop;
        end process;
        
      
     input_B: process
               begin 
                   for i in 0 to 9 loop
                       B(15 downto 12) <= std_logic_vector(to_unsigned(i, 4));
                       for i in 0 to 9 loop
                           B(11 downto 8) <= std_logic_vector(to_unsigned(i, 4));
                           for i in 0 to 9 loop
                               B(7 downto 4) <= std_logic_vector(to_unsigned(i, 4));
                               for i in 0 to 9 loop
                                   B(3 downto 0) <= std_logic_vector(to_unsigned(i, 4));
                                   wait for period*0.5;
                               end loop;
                           end loop;
                       end loop;
                   end loop;
               end process;

--    input_Cin: process
--         begin
--             Cin <= '0';
--             wait for period;
--          end process;
    
        
end Bench;