library ieee;
use ieee.std_logic_1164.all;

entity KeyControl_TB is 
end KeyControl_TB;

architecture behavioral of KeyControl_TB is

component KeyControl is 
	port
	(
		-- Input ports
      Kpress		: in std_logic;
      Kack      : in std_logic;
      Clk       : in std_logic;
      Reset    	: in std_logic;

      -- Output ports
      Kscan     : out std_logic;
      Kval      : out std_logic

	);
end component;

--UUT signals
constant MClk_PERIOD 		: time := 20 ns;
constant MClk_HALF_PERIOD	: time := MClk_PERIOD /2 ;

signal Kpress_TB, Kack_TB, Clk_TB, Reset_TB, Ksacn_TB, Kval_TB: std_logic;

begin

-- UNIT UNDER TEST
UUT: KeyControl port map (Kpress => Kpress_TB, Kack => Kack_TB, Clk => Clk_TB, Reset => Reset_TB, 
								  Kscan => Ksacn_TB, Kval => Kval_TB);

Clk_gen : process 

begin

Clk_tb <= '0';

wait for MClk_HALF_PERIOD;

Clk_tb <= '1';

wait for MClk_HALF_PERIOD;

end process;

stimulus : process
begin

-- Reset
Reset_TB <= '1';
Kpress_TB <= '0';
Kack_TB <= '0';

wait for MClk_PERIOD;

Reset_TB <= '0';

wait for MClk_PERIOD;

Kpress_TB <= '1';

wait for MClk_PERIOD;
wait for MClk_PERIOD;

Kack_TB <= '0';

wait for MClk_PERIOD;
wait for MClk_PERIOD;

Kack_TB <= '1';

wait for MClk_PERIOD;
wait for MClk_PERIOD;

Kpress_TB <= '0';

wait for MClk_PERIOD;
wait for MClk_PERIOD;

wait;

end process;

end behavioral;