
library IEEE;
use IEEE.std_logic_1164.all;


entity fullAdder is

port (
	a, b, cin : in std_logic;
	s, cout : out std_logic
);

end fullAdder;

architecture hardware of fullAdder is
begin
	s <= a xor b xor cin;
	cout <= (b and cin) or (a and cin) or (a and b);
end hardware;

