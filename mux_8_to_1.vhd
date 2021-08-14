
library IEEE;
use IEEE.std_logic_1164.all;

entity mux_8_to_1 is

port (
	a : in std_logic_vector(7 downto 0);
	s : in std_logic_vector(2 downto 0);
	o : out std_logic
);
end mux_8_to_1;

architecture hardware of mux_8_to_1 is
begin
process(a,s)
begin

	o <= '0';
	
	case s is
		when "000" => o <= a (0);
		when "001" => o <= a (1);
		when "010" => o <= a (2);
		when "011" => o <= a (3);
		when "100" => o <= a (4);
		when "101" => o <= a (5);
		when "110" => o <= a (6);
		when "111" => o <= a (7);
		when others => o <= '0';
	end case;

end process;
end hardware;