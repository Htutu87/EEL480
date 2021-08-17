
library IEEE;
use IEEE.std_logic_1164.all;

entity or4bits is

port (
	a, b : in std_logic_vector(3 downto 0);
	s : out std_logic_vector(3 downto 0)
);

end or4bits;

architecture hardware of or4bits is
begin
	s <= a or b;
end hardware;