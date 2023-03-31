LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity KeyControl_TB is 
end KeyControl_TB;

architecture behavioral of KeyControl_TB is

component KeyControl is 
port(
         -- Input ports
        Kpress		: in std_logic;
        Kack      : in std_logic;
        clk       : in std_logic;
        reset    	: in std_logic;

        -- Output ports
        Kscan     : out std_logic;
        Kval      : out std_logic

);
end component;

--UUT signals
constant MCLK_PERIOD : time := 20 ns;
constant MCLK_HALF_PERIOD : time := MCLK_PERIOD /2 ;

signal Kpress_TB, Kack_TB, clk_TB, reset_TB, Ksacn_TB, Kval_TB: std_logic;

begin

-- UNIT UNDER TEST
UUT: KeyControl port map (Kpress => Kpress_TB, clk => clk_TB, Kack => Kack_TB, reset => reset_TB, 
									Kscan => Ksacn_TB, Kval => Kval_TB);

clk_gen : process 

begin

clk_tb <= '0';

wait for MCLK_HALF_PERIOD;

clk_tb <= '1';

wait for MCLK_HALF_PERIOD;

end process;

stimulus : process
begin

-- reset
reset_TB <= '1';
Kpress_TB <= '0';
Kack_TB <= '0';

wait for MCLK_PERIOD;

reset_TB <= '0';

wait for MCLK_PERIOD;

Kpress_TB <= '1';

wait for MCLK_PERIOD;

wait for MCLK_PERIOD;

Kack_TB <= '0';

wait for MCLK_PERIOD;

wait for MCLK_PERIOD;

Kack_TB <= '1';

wait for MCLK_PERIOD;

wait for MCLK_PERIOD;

Kpress_TB <= '0';

wait for MCLK_PERIOD;

wait for MCLK_PERIOD;

wait;

end process;

end behavioral;
