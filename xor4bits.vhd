
library IEEE;
use IEEE.std_logic_1164.all;

entity xor4bits is

port ( 
	a, b : in std_logic_vector(3 downto 0);
	s : out std_logic_vector(3 downto 0)
);

end xor4bits;

architecture hardware of xor4bits is
begin
	s <= a xor b;
end hardware;