library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_BIT.ALL;


entity mul_pipeline is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           p : out STD_LOGIC_VECTOR (7 downto 0);
           clk : in STD_LOGIC);
end mul_pipeline;

architecture Structural of mul_pipeline is
    component rca_4bits is
     Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
            B : in STD_LOGIC_VECTOR (3 downto 0);
            Cin : in STD_LOGIC;
            Cout : out STD_LOGIC;
            S : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
	
    component bit_and_4bits is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
               B : in STD_LOGIC;
               Output: out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    signal Bin0, Bin1, Bin2, Bin3: std_logic_vector(3 downto 0);
    signal Cout: std_logic_vector(2 downto 0);
    signal s1, s2, s3: std_logic_vector(3 downto 0);
    --signal stage0: std_logic_vector(3 downto 0);
    signal stage1: std_logic_vector(5 downto 0);
    signal stage2: std_logic_vector(6 downto 0);
    signal stage3: std_logic_vector(7 downto 0);
    signal Output0, Output1, Output2, Output3, temp: std_logic_vector(3 downto 0);
    
begin
    and0: bit_and_4bits
    port map(
    A => A,
    B=> B(0),
    Output => Output0);   
    
    and1: bit_and_4bits
    port map(
    A => A,
    B=> B(1),
    Output => Output1);   
    
    rca1: rca_4bits
    port map(
        A => Bin0,
        B => Bin1,
        Cin => '0',
        Cout => Cout(0),
        S => s1);
        
    and2: bit_and_4bits
    port map(
    A => A,
    B=> B(2),
    Output => Output2);   
    
    rca2: rca_4bits
    port map(
        A => stage1(5 downto 2),
        B => Bin2,
        Cin => '0',
        Cout => Cout(1),
        S => s2);

    and3: bit_and_4bits
    port map(
    A => A,
    B=> B(3),
    Output => Output3);  
    
    rca3: rca_4bits
    port map(
        A => stage2(6 downto 3),
        B => Bin3,
        Cin => '0',
        Cout => Cout(2),
        S => s3);
        
        Bin0 <= '0' & Output0(3 downto 1);
        Bin1 <= Output1;
        
      process(clk)
         begin

             if (rising_edge(clk)) then
                 Bin2 <= Output2;
                 temp <= Output3;
                 Bin3 <= temp;
                 stage1 <= Cout(0) & s1 & Output0(0);
                 stage2 <= Cout(1) & s2 & stage1(1 downto 0);
                 stage3 <= Cout(2) & s3 & stage2(2 downto 0);
                 p <= stage3;
             end if;
         end process; 
        
end Structural;
