library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity exercise9 is
    Port ( rst : in STD_LOGIC;
           inp : in STD_LOGIC;
           state : out STD_LOGIC_VECTOR (2 downto 0);
           outp : out STD_LOGIC_VECTOR (1 downto 0));
end exercise9;

architecture Behavioral of exercise9 is
signal stt:std_logic_vector(2 downto 0):="001";
signal output: std_logic_vector(1 downto 0):="00";

begin
process(rst,inp)
begin
    if rst='1' then
        outp<="00";
        state<="001";
    elsif inp='0' then
        if stt="001" then
            stt<="001";
            output<="00";
        elsif stt="010" then
            stt<="011";
            output<="10";
        elsif stt="011" then
            stt<="011";
            output<="10";
        else
            stt<="010";
            output<="01";
        end if;
        state<=stt;
        outp<=output;
    elsif inp='1' then
     if stt="001" then
           stt<="010";
           output<="01";
       elsif stt="010" then
           stt<="100";
           output<="11";
       elsif stt="011" then
           stt<="100";
           output<="11";
       else
           stt<="001";
           output<="00";
       end if;
       state<=stt;
       outp<=output;
    end if;
   
end process;

end Behavioral;