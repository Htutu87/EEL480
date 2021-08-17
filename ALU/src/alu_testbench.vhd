
library IEEE;
use IEEE.std_logic_1164.all;

entity alu_testbench is
port(
	HEX4 : out std_logic_vector(6 downto 0);
   HEX3 : out std_logic_vector(6 downto 0);
	HEX1 : out std_logic_vector(6 downto 0);
	SW: in std_logic_vector(17 downto 0);
	LEDG: out std_logic_vector(17 downto 0);
	CLOCK_50: in std_logic
);
end alu_testbench;

architecture hardware of alu_testbench is

component alu is
port (
	X, Y : in std_logic_vector(3 downto 0);
	Sel : in std_logic_vector(2 downto 0);
	Z : buffer std_logic_vector(3 downto 0);
	NEG, ZERO, OVR : out std_logic;
	Cout : buffer std_logic
);
end component;

component counter_8bits is
port (
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

	signal t_X :  std_logic_vector(3 downto 0);
	signal t_Y :  std_logic_vector(3 downto 0);
	signal t_Sel :  std_logic_vector(2 downto 0);
	signal t_Z :  std_logic_vector(3 downto 0);
	signal t_NEG, t_ZERO, t_OVR, t_Cout : std_logic;
	
	
	signal in_decod_x : std_logic_vector(3 downto 0);
	signal out_decod_x : std_logic_vector(6 downto 0);
	
	signal in_decod_y : std_logic_vector(3 downto 0);
	signal out_decod_y : std_logic_vector(6 downto 0);
	
	signal in_decod_Z : std_logic_vector(3 downto 0);
	signal out_decod_Z : std_logic_vector(6 downto 0);
	
	signal t_reset : std_logic;
	signal t_Counter_output: std_logic_vector (7 downto 0);
	
begin

	alu_module: alu port map(X => t_X, Y => t_Y, Sel => t_Sel, Z => t_Z, NEG => t_NEG, ZERO => t_ZERO, OVR => t_OVR, Cout => t_Cout);
	display_decoder_x: hex_to_display port map(hex => t_X, display => out_decod_x);
	display_decoder_y: hex_to_display port map(hex => t_Y, display => out_decod_y);
	display_decoder_z: hex_to_display port map(hex => t_Z, display => out_decod_z);
	counter: counter_8bits port map(Reset => t_Reset, Clock => CLOCK_50, Counter_output => t_Counter_output);
	
	t_Sel (2) <= SW(2);
	t_Sel (1) <= SW(1);
	t_Sel (0) <= SW(0);
	
	gen0: for i in 0 to 3 generate
		t_X(i) <=  t_Counter_output(i);
	end generate;
	gen1: for i in 4 to 7 generate
		t_Y(i-4) <= t_Counter_output(i);
	end generate;
	
	in_decod_x <= t_X;
	in_decod_x <= t_Y;
	in_decod_x <= t_Z;
	
	HEX4 <= out_decod_x;
	HEX3 <= out_decod_y;
	HEX1 <= out_decod_z;
	
	LEDG(3) <= t_NEG;
	LEDG(2) <= t_ZERO;
	LEDG(1) <= t_OVR;
	LEDG(0) <= t_Cout;
	
	
end hardware; 