
library IEEE;
use IEEE.std_logic_1164.all;

entity alu_labsland is 

port (
	-- t_X, t_Y : in std_logic_vector(3 downto 0); 				
	t_X_out, t_Y_out : inout std_logic_vector(3 downto 0);
	t_Sel : in std_logic_vector(2 downto 0);
	t_Z : buffer std_logic_vector(3 downto 0);
	t_NEG, t_ZERO, t_OVR : out std_logic;
	t_Cout : buffer std_logic;
	
	t_Reset : in std_logic;
	t_Clock : in std_logic;
	
	HEX4 : out std_logic_vector(6 downto 0);
	HEX3 : out std_logic_vector(6 downto 0);
	HEX1 : out std_logic_vector(6 downto 0)
	
);
end alu_labsland;

architecture hardware of alu_labsland is

-- Importação da ALU como componente
component alu is 
port(
	X, Y : in std_logic_vector(3 downto 0);
	Sel : in std_logic_vector(2 downto 0);
	Z : buffer std_logic_vector(3 downto 0);
	NEG, ZERO, OVR : out std_logic;
	Cout : buffer std_logic
);
end component;

component counter_8bits is
port(
	Reset : in std_logic;
	Clock : in std_logic;
	Counter_output : out std_logic_vector(7 downto 0)
);
end component;

component hex_to_display is 
port (
	
	hex : in std_logic_vector(3 downto 0);
	display : out std_logic_vector(6 downto 0)
	
);
end component;


signal alu_X : std_logic_vector(3 downto 0);
signal alu_y : std_logic_vector(3 downto 0);
signal t_Counter_output : std_logic_vector(7 downto 0);

begin

	alu_module : alu port map(X => alu_x, Y=> alu_y, Z => t_Z, Sel => t_Sel, NEG => t_NEG, ZERO => t_ZERO, OVR => t_OVR, Cout => t_Cout);
	counter_module : counter_8bits port map(Reset => t_Reset, Clock => t_Clock, Counter_output => t_Counter_output);

	displayX : hex_to_display port map(hex => t_X_out, display => HEX4);
	displayY : hex_to_display port map(hex => t_Y_out, display => HEX3);
	displayZ : hex_to_display port map(hex => t_Z, display => HEX1);
	 
	gen0: for i in 0 to 3 generate
		alu_y(i) <=  t_Counter_output(i);
	end generate;
	gen1: for i in 4 to 7 generate
		alu_x(i-4) <= t_Counter_output(i);
	end generate;
	
	-- É aqui que a saída do contador efetivamente é redirecionada para a entrada da ALu.
	t_X_out <= alu_x;
	t_Y_out <= alu_y;
	
end hardware;