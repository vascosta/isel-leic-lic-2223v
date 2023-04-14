library ieee;
use ieee.std_logic_1164.all;

entity SerialReCeiverCounter_TB is 
end SerialReCeiverCounter_TB;

architecture behavioral of SerialReCeiverCounter_TB is

component SerialReCeiverCounter is 
	port 
	(
		-- Input ports
		Clk 	: in std_logic;
		Ce  	: in std_logic;
		Clr	: in std_logic;

      -- Output ports
      O   	: out std_logic_vector(3 downto 0)
    );
end component;

--UUT signals
constant MClk_PERIOD 		: time := 20 ns;
constant MClk_HALF_PERIOD	: time := MClk_PERIOD /2 ;

signal Clk_TB, Ce_TB, Clr_TB	: std_logic;
signal O_TB							: std_logic_vector (3 downto 0);

begin

-- UNIT UNDER TEST
UUT: SerialReCeiverCounter port map (Clk => Clk_TB, Ce => Ce_TB, Clr => Clr_TB,
												 O => O_TB);

Clk_gen : proCess 

begin

Clk_TB <= '0';

wait for MClk_HALF_PERIOD;

Clk_TB <= '1';

wait for MClk_HALF_PERIOD; 

end proCess;

stimulus : proCess

begin

-- reset
Ce_TB <= '0';

wait for MClk_PERIOD;

Ce_TB <= '1';
Clr_TB <= '0';

wait for MClk_PERIOD;
wait for MClk_PERIOD;
wait for MClk_PERIOD;
wait for MClk_PERIOD;
wait for MClk_PERIOD;
wait for MClk_PERIOD;
wait for MClk_PERIOD;
wait for MClk_PERIOD;

Clr_TB <= '1';

wait for MClk_PERIOD;

Clr_TB <= '0';

wait for MClk_PERIOD;
wait for MClk_PERIOD;
wait for MClk_PERIOD;
wait for MClk_PERIOD;
wait for MClk_PERIOD;
wait for MClk_PERIOD;
wait for MClk_PERIOD;

Ce_TB <= '0';

wait;

end proCess;

end behavioral;