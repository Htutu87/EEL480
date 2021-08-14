library IEEE;
use IEEE.std_logic_1164.all;

entity decoder_3_to_8 is
port (
	code : in std_logic_vector(2 downto 0);
	O : out std_logic_vector(7 downto 0)
);
end decoder_3_to_8;

architecture hardware of decoder_3_to_8 is

begin

	O(0) <= (not code(2)) and (not code(1)) and (not code (0)); -- code = 000
	O(1) <= (not code(2) and (not code(1)) and ( code (0)));		-- code = 001
	O(2) <= (not code(2) and ( code(1)) and (not code (0)));    -- code = 010
	O(3) <= (not code(2) and ( code(1)) and ( code (0)));       -- code = 011
	O(4) <= ( code(2) and (not code(1)) and (not code (0)));    -- code = 100
	O(5) <= ( code(2) and (not code(1)) and ( code (0)));       -- code = 101
	O(6) <= ( code(2) and ( code(1)) and (not code (0)));       -- code = 110
	O(7) <= ( code(2) and ( code(1)) and ( code (0)));          -- code = 111

end hardware;