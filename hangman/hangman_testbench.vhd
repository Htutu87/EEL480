
library ieee;
use ieee.std_logic_1164.all;

entity hangman_testbench is

port(
	SW: in std_logic_vector(17 downto 0);
	LEDG: out std_logic_vector(2 downto 0);
	HEX0 : out std_logic_vector(6 downto 0);
	HEX1 : out std_logic_vector(6 downto 0);
	HEX2 : out std_logic_vector(6 downto 0);
	HEX3 : out std_logic_vector(6 downto 0);
	HEX4 : out std_logic_vector(6 downto 0);
	HEX5 : out std_logic_vector(6 downto 0);
	HEX6 : out std_logic_vector(6 downto 0);
	HEX7 : out std_logic_vector(6 downto 0);
	CLOCK_50: in std_logic
);

end hangman_testbench;

--
architecture behavioral of hangman_testbench is

type state_type is 
(
initial_state,
no_hits_two_lives,
no_hits_one_life,
hit_1_three_lives,
hit_1_two_lives,
hit_1_one_life,
hit_2_three_lives,
hit_2_two_lives,
hit_2_one_life,
hit_3_three_lives,
hit_3_two_lives,
hit_3_one_life,
hit_12_three_lives,
hit_12_two_lives,
hit_12_one_life,
hit_13_three_lives,
hit_13_two_lives,
hit_13_one_life,
hit_23_three_lives,
hit_23_two_lives,
hit_23_one_life,
win,
lost
);

signal pr_state, nx_state: state_type;
signal clk, rst: std_logic;
signal kbd: std_logic_vector(9 downto 0);
signal delayedKbd: std_logic_vector(9 downto 0);
signal kbdDiff: std_logic_vector(9 downto 0);
signal disp1: std_logic_vector(6 downto 0);

begin

	clk <= CLOCK_50;
	rst <= SW(17);
	kbd <= SW(9 downto 0);
	kbdDiff <= kbd XOR delayedKbd;
	
	process(clk, rst)
	
	begin
	
		if (rst = '1') then
			pr_state <= initial_state;
		elsif (clk'EVENT and clk = '1') then
			pr_state <= nx_state;
			delayedKbd <= kbd;
		end if;

	end process;
		
	-- State control
	process (kbdDiff, pr_state)
	begin

		case pr_state is
			when initial_state =>
					
				HEX0 <= "0000000";
				HEX1 <= "0111111";
				HEX2 <= "0111111";
				HEX3 <= "0111111";
				HEX4 <= "0111111";
				HEX5 <= "0111111";
				HEX6 <= "0111111";
				HEX7 <= "0000000";
				LEDG <= "111";
				
				if (kbdDiff(1) = '1') then
					nx_state <= hit_1_three_lives;
				elsif (kbdDiff(2) = '1') then
					nx_state <= hit_2_three_lives;
				elsif (kbdDiff(3) = '1') then
					nx_state <= hit_3_three_lives;
				elsif (kbdDiff = "0000000000") then
					nx_state <= pr_state;
				else
					nx_state <= no_hits_two_lives;
				end if;
					
			when no_hits_two_lives =>
				
				LEDG <= "011";
				
				if (kbdDiff(1) = '1') then
					nx_state <= hit_1_two_lives;
				elsif (kbdDiff(2) = '1') then
					nx_state <= hit_2_two_lives;
				elsif (kbdDiff(3) = '1') then
					nx_state <= hit_3_two_lives;
				elsif (kbdDiff = "0000000000") then
					nx_state <= pr_state;
				else
					nx_state <= no_hits_one_life;
				end if;	
				
			when no_hits_one_life =>
			
				LEDG <= "001";
				
				if (kbdDiff(1) = '1') then
					nx_state <= hit_1_one_life;
				elsif (kbdDiff(2) = '1') then
					nx_state <= hit_2_one_life;
				elsif (kbdDiff(3) = '1') then
					nx_state <= hit_3_one_life;
				elsif (kbdDiff = "0000000000") then
					nx_state <= pr_state;
				else
					nx_state <= lost;
				end if;
		-------------------------	
		-- OK!	
			when hit_1_three_lives =>
			
				HEX1 <= "1111001";
				HEX6 <= "1111001";
				LEDG <= "111";
				
				if (kbdDiff(2) = '1') then
					nx_state <= hit_12_three_lives;
				elsif (kbdDiff(3) = '1') then
					nx_state <= hit_13_three_lives;
				elsif (kbdDiff = "0000000000") then
					nx_state <= pr_state;
				else
					nx_state <= hit_1_two_lives;
				end if;
			
			when hit_1_two_lives =>
			
				HEX1 <= "1111001";
				HEX6 <= "1111001";
				LEDG <= "011";
		
				if (kbdDiff(2) = '1') then
					nx_state <= hit_12_two_lives;
				elsif (kbdDiff(3) = '1') then
					nx_state <= hit_13_two_lives;
				elsif (kbdDiff = "0000000000") then
					nx_state <= pr_state;
				else
					nx_state <= hit_1_one_life;
				end if;
	
							
			when hit_1_one_life =>

				HEX1 <= "1111001";
				HEX6 <= "1111001";
				LEDG <= "001";
			
				if (kbdDiff(2) = '1') then
					nx_state <= hit_12_one_life;
				elsif (kbdDiff(3) = '1') then
					nx_state <= hit_13_one_life;
				elsif (kbdDiff = "0000000000") then
					nx_state <= pr_state;
				else
					nx_state <= lost;
				end if;
			
			
			-----------------------
			-- OK!
			when hit_2_three_lives =>
			
				LEDG <= "111"; 
			
				HEX2 <= "0100100";
				HEX5 <= "0100100";
				
				if (kbdDiff(1) = '1') then
					nx_state <= hit_12_three_lives;
				elsif (kbdDiff(3) = '1') then
					nx_state <= hit_23_three_lives;
				elsif (kbdDiff = "0000000000") then
					nx_state <= pr_state;
				else
					nx_state <= hit_1_two_lives;
				end if;
			
			
			when hit_2_two_lives =>
			
				LEDG <= "011";
				
				HEX2 <= "0100100";
				HEX5 <= "0100100";
			
				if (kbdDiff(1) = '1') then
					nx_state <= hit_12_two_lives;
				elsif (kbdDiff(3) = '1') then
					nx_state <= hit_23_two_lives;
				elsif (kbdDiff = "0000000000") then
					nx_state <= pr_state;
				else
					nx_state <= hit_2_one_life;
				end if;
			
			when hit_2_one_life =>
				
				LEDG <= "001";

				HEX2 <= "0100100";
				HEX5 <= "0100100";
				
				if (kbdDiff(1) = '1') then
					nx_state <= hit_12_one_life;
				elsif (kbdDiff(3) = '1') then
					nx_state <= hit_23_one_life;
				elsif (kbdDiff = "0000000000") then
					nx_state <= pr_state;
				else
					nx_state <= lost;
				end if;			
					
			---
				
			when hit_3_three_lives =>

				LEDG <= "111";

				HEX3 <= "0110000";
				HEX4 <= "0110000";
				
				if (kbdDiff(1) = '1') then
					nx_state <= hit_13_three_lives;
				elsif (kbdDiff(2) = '1') then
					nx_state <= hit_23_three_lives;
				elsif (kbdDiff = "0000000000") then
					nx_state <= pr_state;
				else
					nx_state <= hit_3_two_lives;
				end if;
			
			when hit_3_two_lives =>
				
				LEDG <= "011";
				
				HEX3 <= "0110000";
				HEX4 <= "0110000";
				
				if (kbdDiff(1) = '1') then
					nx_state <= hit_13_two_lives;
				elsif (kbdDiff(2) = '1') then
					nx_state <= hit_23_two_lives;
				elsif (kbdDiff = "0000000000") then
					nx_state <= pr_state;
				else
					nx_state <= hit_3_one_life;
				end if;
				
			when hit_3_one_life =>
				
				LEDG <= "001";
				
				HEX3 <= "0110000";
				HEX4 <= "0110000";
				
				if (kbdDiff(1) = '1') then
					nx_state <= hit_13_one_life;
				elsif (kbdDiff(2) = '1') then
					nx_state <= hit_23_one_life;
				elsif (kbdDiff = "0000000000") then
					nx_state <= pr_state;
				else
					nx_state <= lost;
				end if;
				
			when hit_12_three_lives =>
			
				LEDG <= "111";
			
				HEX1 <= "1111001";
				HEX2 <= "0100100";
				HEX5 <= "0100100";
				HEX6 <= "1111001";
				
				if (kbdDiff(3) = '1') then
					nx_state <= win;
				elsif (kbdDiff = "0000000000") then
					nx_state <= pr_state;
				else
					nx_state <= hit_12_two_lives;
				end if;
		
				
			when hit_12_two_lives =>
				
				LEDG <= "011";

				HEX1 <= "1111001";
				HEX2 <= "0100100";
				HEX5 <= "0100100";
				HEX6 <= "1111001";
	
				if (kbdDiff(3) = '1') then
						nx_state <= win;
					elsif (kbdDiff = "0000000000") then
						nx_state <= pr_state;
					else
						nx_state <= hit_12_one_life;
				end if;
				
			when hit_12_one_life =>
				
				LEDG <= "001";
				
				HEX1 <= "1111001";
				HEX2 <= "0100100";
				HEX5 <= "0100100";
				HEX6 <= "1111001";
				
				if (kbdDiff(3) = '1') then
						nx_state <= win;
					elsif (kbdDiff = "0000000000") then
						nx_state <= pr_state;
					else
						nx_state <= lost;
				end if;
				
			when hit_13_three_lives =>
				
				LEDG <= "111";
				
				HEX1 <= "1111001";
				HEX3 <= "0110000";
				HEX4 <= "0110000";
				HEX6 <= "1111001";
				
				if (kbdDiff(2) = '1') then
						nx_state <= win;
					elsif (kbdDiff = "0000000000") then
						nx_state <= pr_state;
					else
						nx_state <= hit_13_two_lives;
				end if;
				
			when hit_13_two_lives =>
	
				LEDG <= "011";

				HEX1 <= "1111001";
				HEX3 <= "0110000";
				HEX4 <= "0110000";
				HEX6 <= "1111001";
				
				if (kbdDiff(2) = '1') then
						nx_state <= win;
					elsif (kbdDiff = "0000000000") then
						nx_state <= pr_state;
					else
						nx_state <= hit_13_one_life;
				end if;
		
			when hit_13_one_life =>
				
				LEDG <= "001";
				
				HEX1 <= "1111001";
				HEX3 <= "0110000";
				HEX4 <= "0110000";
				HEX6 <= "1111001";
				
				if (kbdDiff(2) = '1') then
						nx_state <= win;
					elsif (kbdDiff = "0000000000") then
						nx_state <= pr_state;
					else
						nx_state <= lost;
				end if;
				
			when hit_23_three_lives =>
				
				LEDG <= "111";
				
				HEX2 <= "0100100";
				HEX3 <= "0110000";
				HEX4 <= "0110000";
				HEX5 <= "0100100";
				
				if (kbdDiff(1) = '1') then
						nx_state <= win;
					elsif (kbdDiff = "0000000000") then
						nx_state <= pr_state;
					else
						nx_state <= hit_23_two_lives;
				end if;
				
			when hit_23_two_lives =>
				
				LEDG <= "011";

				HEX2 <= "0100100";
				HEX3 <= "0110000";
				HEX4 <= "0110000";
				HEX5 <= "0100100";
	
				if (kbdDiff(1) = '1') then
						nx_state <= win;
					elsif (kbdDiff = "0000000000") then
						nx_state <= pr_state;
					else
						nx_state <= hit_23_one_life;
				end if;
				
			when hit_23_one_life =>
				
				LEDG <= "001";
				
				HEX2 <= "0100100";
				HEX3 <= "0110000";
				HEX4 <= "0110000";
				HEX5 <= "0100100";
				
				if (kbdDiff(1) = '1') then
						nx_state <= win;
					elsif (kbdDiff = "0000000000") then
						nx_state <= pr_state;
					else
						nx_state <= lost;
				end if;
	
			when win => 
				
				LEDG <= "111";
				
				HEX0 <= "1111111";
				HEX1 <= "1111001";
				HEX2 <= "0100100";
				HEX3 <= "0110000";
				HEX4 <= "0110000";
				HEX5 <= "0100100";
				HEX6 <= "1111001";

				HEX7 <= "0000010";
				
				
			when lost =>
			
				LEDG <= "000";
			
				HEX0 <= "0111111";
				HEX1 <= "0111111";
				HEX2 <= "0111111";
				HEX3 <= "0111111";
				HEX4 <= "0111111";
				HEX5 <= "0111111";
				HEX6 <= "0111111";
				
				HEX7 <= "0000011";
				
				LEDG <= "000";
			
		end case;
		
	end process;
	
end behavioral;
