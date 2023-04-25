library ieee;
USE ieee.std_logic_1164.all;

entity KeyScan_TB is 
end KeyScan_TB;

architecture behavioral of KeyScan_TB is

component KeyScan is 
	port
	(  
		-- Input ports
      Kscan    		: in std_logic;
		Clk	  		: in std_logic;
		ButtonLine		: in std_logic_vector(3 downto 0);

		-- Output ports
      K        		: out std_logic_vector(3 downto 0);
      Kpress   		: out std_logic;
		ButtonColumn	: out std_logic_vector(2 downto 0)
	);
end component;

--UUT signals
constant MCLK_PERIOD 		: time := 20 ns;
constant MCLK_HALF_PERIOD	: time := MCLK_PERIOD /2 ;

signal Kscan_TB, Clk_TB, Kpress_TB	: std_logic;
signal ButtonLine_TB, K_TB 			: std_logic_vector (3 downto 0);
signal ButtonColumn_TB 					: std_logic_vector (2 downto 0);

begin

-- UNIT UNDER TEST
UUT: KeyScan port map (Kscan => Kscan_TB, Clk => Clk_TB, ButtonLine => ButtonLine_TB, 
							  K => K_TB, Kpress => Kpress_TB, ButtonColumn => ButtonColumn_TB);

clk_gen : process 

begin

Clk_TB <= '0';

wait for MCLK_HALF_PERIOD;

Clk_TB <= '1';

wait for MCLK_HALF_PERIOD;

end process;

stimulus : process

begin

-- reset
Kscan_TB <= '0';

wait for MCLK_PERIOD;

Kscan_TB 		<= '1';
ButtonLine_TB	<= "0000";

wait for MCLK_PERIOD;

ButtonLine_TB <= "0001";

wait for MCLK_PERIOD;

ButtonLine_TB <= "0010";

wait for MCLK_PERIOD;

ButtonLine_TB <= "0011";

wait for MCLK_PERIOD;

ButtonLine_TB <= "0100";

wait for MCLK_PERIOD;

ButtonLine_TB <= "0101";

wait for MCLK_PERIOD;

ButtonLine_TB <= "0110";

wait for MCLK_PERIOD;

ButtonLine_TB <= "0111";

wait for MCLK_PERIOD;

ButtonLine_TB <= "1000";

wait for MCLK_PERIOD;

ButtonLine_TB <= "1001";

wait for MCLK_PERIOD;

ButtonLine_TB <= "1010";

wait for MCLK_PERIOD;

ButtonLine_TB <= "1011";

wait for MCLK_PERIOD;

wait;

end process;

end behavioral;