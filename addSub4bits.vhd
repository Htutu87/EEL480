
library IEEE;
use IEEE.std_logic_1164.all;

entity addSub4bits is
port (
	A, Bin : in std_logic_vector(3 downto 0);
	S : 		out std_logic_vector(3 downto 0);
	CIN : 	in std_logic;
	COUT : 	out std_logic
);

end addSub4bits;

architecture hardware of addSub4bits is

-- Instanciação do componente fulladder para uso do somator/subtrator de 4 bits.
-- Descreve a interface deste submódulo para uso externo a ele

component fullAdder is 

port (
	a, b, cin : in std_logic;
	s, cout : out std_logic
);

end component;
	
	-- Declaração de sinais.
	-- C é um vetor que descreve todos os carrys do componente.
	-- Bout é a saída da entrada
	
	signal C : std_logic_vector (4 downto 0);
	signal Bout : std_logic_vector (3 downto 0);

begin

gen: for i in 0 to 3 generate

	Bout(i) <= Bin(i) XOR CIN;

	FA: fullAdder port map(a=>A(i), b => Bout(i), cin => C(i), s => S(i), cout => C(i+1)); 

end generate;

C(0) <= CIN;
COUT <= C(4);
	
end hardware;