library ieee;
use ieee.std_logic_1164.all;

entity KeyDecode_TB is 
end KeyDecode_TB;

architecture behavioral of KeyDecode_TB is

component KeyDecode is
	port
	(
		-- Input ports
		Kack   		: in std_logic;
		Clk    	 	: in std_logic;
		reset     	: in std_logic;
		ButtonLine  	: in std_logic_vector(3 downto 0);

		-- Output ports
		Kval    	: out std_logic;
		K		: out std_logic_vector(3 downto 0);
		ButtonColumn	: out std_logic_vector(2 downto 0)
	);
end component;

--UUT signals
constant MClk_PERIOD : time := 20 ns;
constant MClk_HALF_PERIOD : time := MClk_PERIOD /2 ;

signal Kack_TB, Clk_TB, reset_TB, Kval_TB	: std_logic;
signal ButtonLine_TB, K_TB			: std_logic_vector (3 downto 0);
signal ButtonColumn_TB				: std_logic_vector (2 downto 0);

begin

 --UNIT UNDER TEST
UUT: KeyDecode port map (Kack => Kack_TB, Clk => Clk_TB, reset => reset_TB, ButtonLine => ButtonLine_TB,
			 Kval => Kval_TB,  K => K_TB, ButtonColumn => ButtonColumn_TB);

Clk_gen : process 

begin

Clk_TB <= '0';

wait for MClk_HALF_PERIOD;

Clk_TB <= '1';

wait for MClk_HALF_PERIOD;

end process;

stimulus : process

begin
-- reset

reset_TB <= '1';
Kack_TB  <= '1';

wait for MClk_PERIOD;

ButtonLine_TB <= "0000";
reset_TB <= '0';

wait for MClk_PERIOD;

ButtonLine_TB <= "0100";

wait for MClk_PERIOD;

ButtonLine_TB <= "1000";

wait for MClk_PERIOD;

ButtonLine_TB <= "0001";

wait for MClk_PERIOD;

ButtonLine_TB <= "0101";

wait for MClk_PERIOD;

ButtonLine_TB <= "1001";

wait for MClk_PERIOD;

ButtonLine_TB <= "0010";

wait for MClk_PERIOD;

ButtonLine_TB <= "0110";

wait for MClk_PERIOD;

ButtonLine_TB <= "1010";

wait for MClk_PERIOD;

ButtonLine_TB <= "0011";

wait for MClk_PERIOD;

ButtonLine_TB <= "0111";

wait for MClk_PERIOD;

ButtonLine_TB <= "1011";

wait for MClk_PERIOD;

wait;

end process;

end behavioral;
