library ieee;
use ieee.std_logic_1164.all;

entity KeyboardReader_TB is 
end KeyboardReader_TB;

architecture behavioral of KeyboardReader_TB is

component KeyboardReader is 
port
	(
		-- Input ports
		Kack      		: in std_logic;
		Clk    	 		: in std_logic;
		Reset     		: in std_logic;
		ButtonLine  	: in std_logic_vector(3 downto 0);

		-- Output ports
		Kval      		: out std_logic;
		K	    			: out std_logic_vector(3 downto 0);
		ButtonColumn  	: out std_logic_vector(2 downto 0)
);
end component;

--UUT signals
constant MClk_PERIOD : time := 20 ns;
constant MClk_HALF_PERIOD : time := MClk_PERIOD /2 ;

signal Kack_tb, Kval_tb, Clk_tb, Reset_tb	: std_logic;
signal ButtonLine_tb, Kexit_tb				: std_logic_vector (3 downto 0);
signal ButtonColumn_tb							: std_logic_vector (2 downto 0);

begin

 --UNIT UNDER TEST
UUT: KeyboardReader port map (Clk => Clk_tb, Reset => Reset_tb, Kack => Kack_tb, ButtonLine => ButtonLine_tb,
										ButtonColumn => ButtonColumn_tb, K => Kexit_tb, Kval => Kval_tb);

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

Reset_tb <= '1';

wait for MClk_PERIOD;

Reset_tb <= '0';

wait for MClk_PERIOD;

ButtonLine_tb <= "0000";
Kack_tb <= '1';

wait for MClk_PERIOD;

ButtonLine_tb <= "1111";
Kack_tb <= '0';

wait for MClk_PERIOD;

ButtonLine_tb <= "0001";
Kack_tb <= '1';

wait for MClk_PERIOD;

ButtonLine_tb <= "1111";
Kack_tb <= '0';

wait for MClk_PERIOD;

ButtonLine_tb <= "0100";
Kack_tb <= '1';

wait for MClk_PERIOD;

ButtonLine_tb <= "1111";
Kack_tb <= '0';

--wait for MClk_PERIOD;
--
--ButtonLine_tb <= "1000";
--
--wait for MClk_PERIOD;
--
--Kack_tb <= '1';
--
--wait for MClk_PERIOD;
--
--Kack_tb <= '0';
--
--wait for MClk_PERIOD;
--
--ButtonLine_tb <= "0001";
--
--wait for MClk_PERIOD;
--
--Kack_tb <= '1';
--
--wait for MClk_PERIOD;
--
--Kack_tb <= '0';
--
--wait for MClk_PERIOD;
--
--ButtonLine_tb <= "0101";
--
--wait for MClk_PERIOD;
--
--Kack_tb <= '1';
--
--wait for MClk_PERIOD;
--
--Kack_tb <= '0';
--
--wait for MClk_PERIOD;
--
--ButtonLine_tb <= "1001";
--
--wait for MClk_PERIOD;
--
--Kack_tb <= '1';
--
--wait for MClk_PERIOD;
--
--Kack_tb <= '0';
--
--wait for MClk_PERIOD;
--
--ButtonLine_tb <= "0010";
--
--wait for MClk_PERIOD;
--
--Kack_tb <= '1';
--
--wait for MClk_PERIOD;
--
--Kack_tb <= '0';
--
--wait for MClk_PERIOD;
--
--ButtonLine_tb <= "0110";
--
--wait for MClk_PERIOD;
--
--Kack_tb <= '1';
--
--wait for MClk_PERIOD;
--
--Kack_tb <= '0';
--
--wait for MClk_PERIOD;
--
--ButtonLine_tb <= "1010";
--
--wait for MClk_PERIOD;
--
--Kack_tb <= '1';
--
--wait for MClk_PERIOD;
--
--Kack_tb <= '0';
--
--wait for MClk_PERIOD;
--
--ButtonLine_tb <= "0011";
--
--wait for MClk_PERIOD;
--
--Kack_tb <= '1';
--
--wait for MClk_PERIOD;
--
--Kack_tb <= '0';
--
--wait for MClk_PERIOD;
--
--ButtonLine_tb <= "0111";
--
--wait for MClk_PERIOD;
--
--Kack_tb <= '1';
--
--wait for MClk_PERIOD;
--
--Kack_tb <= '0';
--
--wait for MClk_PERIOD;
--
--ButtonLine_tb <= "1011";
--
--wait for MClk_PERIOD;

wait;

end process;

end behavioral;