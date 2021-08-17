
library IEEE;
use IEEE.std_logic_1164.all;

entity not4bits is

port (
	a : in std_logic_vector(3 downto 0);
	s : out std_logic_vector(3 downto 0)
);

end not4bits;

architecture hardware of not4bits is
begin
	s <= not a;
end hardware;