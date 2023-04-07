library ieee;
use ieee.std_logic_1164.all;

entity SerialReceiverCounter_TB is 
end SerialReceiverCounter_TB;

architecture behavioral of SerialReceiverCounter_TB is

component SerialReceiverCounter is 
	port 
	(
		-- Input ports
		clk 	: in std_logic;
		ce  	: in std_logic;
		clr	: in std_logic;

      -- Output ports
      O   	: out std_logic_vector(3 downto 0)
    );
end component;

--UUT signals
constant MCLK_PERIOD 		: time := 20 ns;
constant MCLK_HALF_PERIOD	: time := MCLK_PERIOD /2 ;

signal clk_TB, ce_TB, clr_TB	: std_logic;
signal O_TB				: std_logic_vector (3 downto 0);

begin

-- UNIT UNDER TEST
UUT: SerialReceiverCounter port map (Clk => clk_TB, ce => ce_TB, clr => clr_TB,
												O => O_TB);

clk_gen : process 

begin

clk_TB <= '0';

wait for MCLK_HALF_PERIOD;

clk_TB <= '1';

wait for MCLK_HALF_PERIOD; 

end process;

stimulus : process

begin

-- reset
ce_TB <= '0';

wait for MCLK_PERIOD;

ce_TB <= '1';

wait for MCLK_PERIOD;
wait for MCLK_PERIOD;
wait for MCLK_PERIOD;
wait for MCLK_PERIOD;
wait for MCLK_PERIOD;
wait for MCLK_PERIOD;
wait for MCLK_PERIOD;
wait for MCLK_PERIOD;

clr_TB <= '1';

wait for MCLK_PERIOD;

clr_TB <= '0';

wait for MCLK_PERIOD;
wait for MCLK_PERIOD;
wait for MCLK_PERIOD;
wait for MCLK_PERIOD;
wait for MCLK_PERIOD;
wait for MCLK_PERIOD;
wait for MCLK_PERIOD;

ce_TB <= '0';

wait;

end process;

end behavioral;
