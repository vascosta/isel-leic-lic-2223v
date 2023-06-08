library ieee;
use ieee.std_logic_1164.all;

entity DoorController_TB is 
end DoorController_TB;

architecture behavioral of DoorController_TB is

component DoorController is 
port
	(
		-- Input ports
		Clk 		: in std_logic;
		Reset    : in std_logic;
		Dval 		: in std_logic;
		OC	 		: in std_logic_vector(4 downto 0);
		Sclose	: in std_logic;
		Sopen		: in std_logic; 
		Psensor 	: in std_logic;
	
		-- Output ports
		OnNOff	: out std_logic;
		Dout		: out std_logic_vector(4 downto 0);
		Done		: out std_logic
	);
end component;

--UUT signals
constant MClk_PERIOD 		: time := 20 ns;
constant MClk_HALF_PERIOD	: time := MClk_PERIOD /2 ;

signal Clk_TB, Reset_TB, Dval_TB, Sclose_TB, Sopen_TB, Psensor_TB, OnNOff_TB, Done_TB: std_logic;
signal OC_TB, Dout_TB : std_logic_vector(4 downto 0);

begin

-- UNIT UNDER TEST
UUT: DoorController port map (Clk => Clk_TB, Reset => Reset_TB, Dval => Dval_TB, OC => OC_TB, 
Sclose => Sclose_TB, Sopen => Sopen_TB, Psensor => Psensor_TB, OnNOff => OnNOff_TB, Dout => Dout_TB, Done => Done_TB);

clk_gen : process 

begin

clk_tb <= '0';

wait for MClk_HALF_PERIOD;

clk_tb <= '1';

wait for MClk_HALF_PERIOD;

end process;

stimulus : process
begin

-- Reset
Reset_TB <= '1';
SOpen_TB <= '0';

wait for MClk_PERIOD;

--Test opening door succesfully
Reset_TB <= '0';
Dval_TB <= '1';
OC_TB(0) <= '1';

wait for MClk_PERIOD;
wait for MClk_PERIOD;

SOpen_TB <= '1';

wait for MClk_PERIOD;

SOpen_TB <= '0';

wait for MClk_PERIOD;

--Test opening door, but close it right after

wait for MClk_PERIOD;

SOpen_TB <= '1';
OC_TB(0) <= '0';

wait for MClk_PERIOD;

PSensor_TB <= '0';
Sclose_TB <= '0';

wait for MClk_PERIOD;

Sclose_TB <= '1';

wait for MClk_PERIOD;
wait for MClk_PERIOD;

----Test opening door, closing it right after but a person as detected
OC_TB(0) <= '1';

wait for MClk_PERIOD;

SOpen_TB <= '1';
OC_TB(0) <= '0';
PSensor_TB <= '1';

wait for MClk_PERIOD;

wait for MClk_PERIOD;

OC_TB(0) <= '1';

wait for MClk_PERIOD;

Dval_TB <= '0';

wait for MClk_PERIOD;

--Test closing door successfully

Dval_TB <= '1';
OC_TB(0) <= '0';

wait for MClk_PERIOD;

Psensor_TB <= '0';

wait for MClk_PERIOD;
wait for MClk_PERIOD;
wait for MClk_PERIOD;

Dval_TB <= '0';

wait for MClk_PERIOD;


wait;

end process;

end behavioral;