library ieee;
use ieee.std_logic_1164.all;

entity SerialDoorReceiver_TB is 
end SerialDoorReceiver_TB;

architecture behavioral of SerialDoorReceiver_TB is

component SerialReceiver is 
port
	(
		-- Input ports
		Clk		: in std_logic;
		SDX   	: in std_logic;
		SClk  	: in std_logic;
		nSS    	: in std_logic;
		Accept   : in std_logic;
		Reset    : in std_logic;
	
		-- Output ports
		D     	: out std_logic_vector(4 downto 0);
		DXval 	: out std_logic;
		Busy		: out std_logic
	);
end component;

--UUT signals
constant MClk_PERIOD 		: time := 20 ns;
constant MClk_HALF_PERIOD : time := MClk_PERIOD /2 ;

signal nSS_TB, Reset_TB, Accept_TB, DXval_TB, Clk_TB, SDX_TB, Busy_TB	: std_logic;
signal D_TB																					: std_logic_vector(4 downto 0);

begin

-- UNIT UNDER TEST
UUT: SerialReceiver port map (SDX => SDX_TB, SClk => Clk_TB, Clk => Clk_TB, Reset => Reset_TB, nSS => nSS_TB , 
										Accept => Accept_TB, DXval => DXval_TB, D => D_TB, Busy => Busy_TB);

Clk_gen : process 

begin

Clk_TB <= '0';

wait for MClk_HALF_PERIOD;

Clk_TB <= '1';

wait for MClk_HALF_PERIOD;

end process;

stimulus : process

begin
--First Case: Success
-- Reset

Reset_TB <= '1';

wait for MClk_PERIOD;

Reset_TB <= '0';

wait for MClk_PERIOD;

nSS_TB <= '0';
SDX_TB <= '1';

wait for MClk_PERIOD;

wait for MClk_PERIOD;

wait for MClk_PERIOD;

wait for MClk_PERIOD;

wait for MClk_PERIOD;

wait for MClk_PERIOD;

nSS_TB <= '1';

wait for MClk_PERIOD;

Accept_TB <= '1';

wait for MClk_PERIOD;

Accept_TB <= '0';

wait for MClk_PERIOD;
wait for MClk_PERIOD;
wait for MClk_PERIOD;

--Second Case: Changing SS and accept combinations
-- Reset

Reset_TB <= '1';

wait for MClk_PERIOD;

Reset_TB <= '0';

wait for MClk_PERIOD;

nSS_TB <= '1';

wait for MClk_PERIOD;

nSS_TB <= '0';
SDX_TB <= '1';

wait for MClk_PERIOD;

wait for MClk_PERIOD;

wait for MClk_PERIOD;

wait for MClk_PERIOD;

wait for MClk_PERIOD;

wait for MClk_PERIOD;

nSS_TB <= '1';

wait for MClk_PERIOD;

Accept_TB <= '0';

wait for MClk_PERIOD;

Accept_TB <= '1';

wait for MClk_PERIOD;

wait for MClk_PERIOD;

Accept_TB <= '0';

wait for MClk_PERIOD;

wait;

end process;

end behavioral;