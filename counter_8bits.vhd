library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity counter_8bits is 
port (

	Reset : in std_logic;
	Clock : in std_logic;
	Counter_output : out std_logic_vector(7 downto 0)

);
end counter_8bits;

architecture hardware of counter_8bits is 

signal counter : std_logic_vector (7 downto 0);

begin

process(Reset, Clock)

variable clockCount : std_logic_vector (30 downto 0) := (others=>'0');

begin

	if Reset='1' then
		clockCount := (others=>'0');
	elsif (Clock'event and Clock = '1') then
		clockCount := clockCount + 1;
		
		if (clockCount = 100000000) then
			clockCount :=  (others=>'0');
			counter <= counter + 1;
		end if;
		
	end if;
	
end process;

-- Mude essa atribuição para revezar entre clock e contagem em segundos.
Counter_output <= counter; 

end hardware;