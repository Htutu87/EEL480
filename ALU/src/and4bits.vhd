
library IEEE;
use IEEE.std_logic_1164.all;

entity and4bits is

port (
	a, b : in std_logic_vector(3 downto 0);
	s : out std_logic_vector(3 downto 0)
);

end and4bits;

architecture hardware of and4bits is
begin
	s <= a and b;
end hardware;