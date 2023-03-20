library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder_sequential is
    Port ( FA : in STD_LOGIC;
           FB : in STD_LOGIC;
           Cin: in STD_LOGIC;
           clk: in STD_LOGIC;
           reset: in STD_LOGIC;
           sum : out STD_LOGIC;
           Cout : out STD_LOGIC);     
end full_adder_sequential;

architecture Structural of full_adder_sequential is
    component half_adder is
    Port( 
       A : in STD_LOGIC;
       B : in STD_LOGIC;
       carry : out STD_LOGIC;
       sum : out STD_LOGIC);
    end component;
    
    signal s0, c0, c1, c, s: std_logic;
    
    begin
        u1: half_adder port map(
            A => FA,
            B => FB,                       
            sum => s0,
            carry => c0);
                
        u2: half_adder port map(
            A => Cin,
            B => s0,                       
            sum => s,
            carry => c1);
       
        c <= c0 or c1;
        
        process(clk)
        begin
            if (reset='1') then
                 Cout <= '0';
                 sum <= '0';
            elsif (rising_edge(clk)) then
                Cout<=c;
                sum<=s;
            end if;
        end process;

end Structural;