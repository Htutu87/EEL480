
library IEEE;
use IEEE.std_logic_1164.all;

-----------------------------------
-- Descrição da interface da ALU -- 
-----------------------------------
entity ALU is 
port (

	vector8 : in std_logic_vector(7 downto 0);
	X, Y : in std_logic_vector(3 downto 0);
	Sel : in std_logic_vector(2 downto 0);
	Z : buffer std_logic_vector(3 downto 0);
	NEG, ZERO, OVR : out std_logic;
	Cout : buffer std_logic
);

end ALU;

-------------------------------------
-- Descrição da arquitetura da ALU -- 
-------------------------------------
architecture hardware of ALU is

----------------------------------------
-- Importação de componentes externos --
----------------------------------------

------------------------------------------
-- Módulo de adição/subtração de 4 bits --
------------------------------------------
component addSub4bits is 
port (
	A, Bin : in std_logic_vector(3 downto 0);
	S : 		out std_logic_vector(3 downto 0);
	CIN : 	in std_logic;
	COUT : 	out std_logic
);
end component;

--------------------------
-- Módulo AND de 4 bits --
--------------------------
component and4bits is 
port(
	a, b : in std_logic_vector(3 downto 0);
	s : out std_logic_vector(3 downto 0)
);
end component;

-------------------------
-- Módulo OR de 4 bits --
-------------------------
component or4bits is 
port(
	a, b : in std_logic_vector(3 downto 0);
	s : out std_logic_vector(3 downto 0)
);
end component;

--------------------------
-- Módulo XOR de 4 bits --
--------------------------
component xor4bits is 
port(
	a, b : in std_logic_vector(3 downto 0);
	s : out std_logic_vector(3 downto 0)
);
end component;

--------------------------
-- Módulo NOT de 4 bits --
--------------------------
component not4bits is
port (
	a : in std_logic_vector(3 downto 0);
	s : out std_logic_vector(3 downto 0)
);
end component;

--------------------------
-- Módulo multiplexador -- 
--------------------------
component mux_8_to_1 is
port (
	a : in std_logic_vector(7 downto 0);
	s : in std_logic_vector(2 downto 0);
	o : out std_logic
);
end component;
	
	signal res_reset : std_logic_vector(3 downto 0);
	signal res_addSub : std_logic_vector(3 downto 0); 
	signal res_and: std_logic_vector(3 downto 0);
	signal res_or:	std_logic_vector(3 downto 0);
	signal res_xor: std_logic_vector(3 downto 0);
	signal res_not: std_logic_vector(3 downto 0);
	signal res_preset : std_logic_vector(3 downto 0);

begin
	
	opAddSub: addSub4bits port map(A => X, Bin => Y, CIN =>Sel(1), S=>res_addSub, COUT=> Cout);
	opAnd: and4bits port map(a=>X, b=>Y, s=>res_and);
	opOr: or4bits port map(a=>X, b=>Y, s=>res_or);
	opXor: xor4bits port map(a=>X, b=>Y, s=>res_xor);
	opNot: not4bits port map(a=>X, s=>res_not);
	
	-- Nesse caso, i representa o número do mux, que dão as saídas da
	-- ALU. O mux zero emite a saída z0, LSB, e assim por diante.
	
	gen: for i in 0 to 3 generate
		mux: mux_8_to_1 port map(
				a(0) => res_reset(i),
				a(1) => res_addSub(i),
				a(2) => res_addSub(i),
				a(3) => res_and(i),
				a(4) => res_or(i),
				a(5) => res_xor(i),
				a(6) => res_not(i),
				a(7) => res_preset(i),
				s=>Sel,'
				o=>Z(i)
			);
	end generate;
	
	res_reset <= "0000";
	res_preset <= "1111";
	
	ZERO <= Z(0) or Z(1) or Z(2) or Z(3);
	NEG <=  (not Sel(2)) and Sel(1) and (not Sel(0)) and (not Cout);
	OVR <= Cout; --Dúvida: é realmente isso?? Por que são flags diferentes então?
	
end architecture;