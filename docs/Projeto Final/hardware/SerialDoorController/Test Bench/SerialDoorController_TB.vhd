library ieee;
use ieee.std_logic_1164.all;

entity SerialDoorController_TB is 
end SerialDoorController_TB;

architecture behavioral of SerialDoorController_TB is

component SerialDoorController is
port
	(
		-- Input ports
		nSDCsel	: in std_logic;
		SClk  	: in std_logic;
		Clk		: in std_logic;
		SDX    	: in std_logic;
		Reset  	: in std_logic;
		Sclose	: in std_logic;
		Sopen		: in std_logic;
		Psensor	: in std_logic;
	
		-- Output ports
		D     	: out std_logic_vector(4 downto 0);
		OnNOff	: out std_logic;
		Busy		: out std_logic
	);
end component;

--UUT signals
constant MClk_PERIOD 		: time := 20 ns;
constant MClk_HALF_PERIOD	: time := MClk_PERIOD /2 ;

signal nSDCsel_TB, Clk_TB, Reset_TB, Sclose_TB, Sopen_TB, Psensor_TB, SClk_TB, SDX_TB, OnNOff_TB, Busy_TB : std_logic;
signal D_X: std_logic_vector(4 downto 0);

begin


-- UNIT UNDER TEST
UUT: SerialDoorController port map (nSDCsel => nSDCsel_TB, Clk => Clk_TB, Reset => Reset_TB, SDX => SDX_TB, 
Sclose => Sclose_TB, Sopen => Sopen_TB ,Psensor => Psensor_TB, OnNOff => OnNOff_TB, 
SClk => SClk_TB, D => D_X);

											 
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

wait for MClk_PERIOD;

Reset_TB <= '0';

wait for MClk_PERIOD;

nSDCsel_TB <= '0' ;

wait for MClk_PERIOD;
SClk_TB <= '0' ;

SDX_TB <= '0' ; 

wait for MClk_PERIOD;

SClk_TB <= '1' ;

wait for MClk_PERIOD;

SClk_TB <= '0' ;
SDX_TB <= '1' ;

wait for MClk_PERIOD;

SClk_TB <= '1' ;

wait for MClk_PERIOD;

SClk_TB <= '0' ;
SDX_TB <= '0' ;

wait for MClk_PERIOD;

SClk_TB <= '1' ;

wait for MClk_PERIOD;

SClk_TB <= '0' ;
SDX_TB <= '1' ;

wait for MClk_PERIOD;

SClk_TB <= '1' ;

wait for MClk_PERIOD;

SClk_TB <= '0' ;
SDX_TB <= '0' ;

wait for MClk_PERIOD;

SClk_TB <= '1' ;

wait for MClk_PERIOD;

wait for MClk_PERIOD;
wait for MClk_PERIOD;

Sclose_TB <= '0' ;

Psensor_TB <= '0' ;

wait for MClk_PERIOD;

Sclose_TB <= '1' ;


wait for MClk_PERIOD;

Sopen_TB <= '1' ;
Psensor_TB <= '0' ;
Sclose_TB <= '0' ;
 
wait for MClk_PERIOD;

Sclose_TB <= '1' ;

wait for MClk_PERIOD;

wait for MClk_PERIOD;
wait for MClk_PERIOD;
wait for MClk_PERIOD;

end process;

end behavioral;
