library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_BIT.ALL;

entity rca_pipeline is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Cin : in STD_LOGIC;
           clk: in STD_LOGIC;
           
           S : out STD_LOGIC_VECTOR (3 downto 0);
           Cout : out STD_LOGIC);
end rca_pipeline;


architecture Structural of rca_pipeline is
    component full_adder_sequential is
      Port ( clk: in STD_LOGIC;
            reset: in STD_LOGIC; 
            FA : in STD_LOGIC;
           FB : in STD_LOGIC;
           Cin : in STD_LOGIC;
           sum : out STD_LOGIC;
           Cout : out STD_LOGIC);
     end component;
     
    signal temp1, temp2: std_logic_vector(3 downto 0);
    signal stage1: std_logic_vector(7 downto 0);
    signal stage2: std_logic_vector(6 downto 0);
    signal stage3: std_logic_vector(5 downto 0);
    signal stage4: std_logic_vector(4 downto 0);
     
begin

    
    fa1: full_adder_sequential 
        port map(
                clk => clk,
                reset => '0',
                Cin => Cin,
                FA => A(0),
                FB => B(0),                  
                sum => temp1(0),
                Cout => temp2(0));
    
    fa2: full_adder_sequential 
        port map(
                clk => clk,
                reset => '0',
                Cin => temp2(0),
                FA => stage1(2),
                FB => stage1(3),                        
                sum => temp1(1),
                Cout => temp2(1));
                
    fa3: full_adder_sequential 
       port map(
               clk => clk,
               reset => '0',
               Cin => temp2(1),
               FA => stage2(3),
               FB => stage2(4),                        
               sum => temp1(2),
               Cout => temp2(2));       
               
               
    fa4: full_adder_sequential 
      port map(
              clk => clk,
              reset => '0',
              Cin => temp2(2),
              FA => stage3(4),
              FB => stage3(5),                        
              sum => temp1(3),
              Cout => temp2(3));                  

   process(clk)
        begin
            if (rising_edge(clk)) then   
                stage1 <= B(3)&A(3)&B(2)&A(2)&B(1)&A(1)&temp2(0)&temp1(0);
                stage2 <= stage1(7 downto 4)&temp2(1)&temp1(1)&stage1(0);
                 stage3 <= stage2(6 downto 5)&temp2(2)&temp1(2)&stage2(1 downto 0);
                 stage4 <= temp2(3)&temp1(3)&stage3(2 downto 0);   
            end if;
        end process;     

        S <= stage4(3 downto 0);   
        Cout <= stage4(4);  
    
end Structural;