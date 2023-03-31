LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity Counter_TB is 
end Counter_TB;

architecture behavioral of COUNTER_TB is

component Counter is 
	port
	(
		-- Input ports
		CLK : in std_logic;
		CE	 : in std_logic;
		
		-- Output ports
		O : out std_logic_vector(3 downto 0)
	);
end component;

--UUT signals
constant MCLK_PERIOD : time := 20 ns;
constant MCLK_HALF_PERIOD : time := MCLK_PERIOD /2 ;

signal CLK_tb, CE_TB: std_logic;
signal O_TB: std_logic_vector (3 downto 0);

begin

-- UNIT UNDER TEST
UUT: Counter port map (CLK => CLK_TB, CE => CE_TB,
								O => O_TB);

clk_gen : process 

begin

CLK_TB <= '0';

wait for MCLK_HALF_PERIOD;

CLK_TB <= '1';

wait for MCLK_HALF_PERIOD; 

end process;

stimulus : process

begin

-- reset
CE_TB <= '0';

wait for MCLK_PERIOD;

CE_TB <= '1';

wait for MCLK_PERIOD;
wait for MCLK_PERIOD;
wait for MCLK_PERIOD;
wait for MCLK_PERIOD;
wait for MCLK_PERIOD;
wait for MCLK_PERIOD;
wait for MCLK_PERIOD;
wait for MCLK_PERIOD;
wait for MCLK_PERIOD;
wait for MCLK_PERIOD;
wait for MCLK_PERIOD;
wait for MCLK_PERIOD;
wait for MCLK_PERIOD;
wait for MCLK_PERIOD;
wait for MCLK_PERIOD;
wait for MCLK_PERIOD;

CE_tb <= '0';

wait;

end process;

end behavioral;