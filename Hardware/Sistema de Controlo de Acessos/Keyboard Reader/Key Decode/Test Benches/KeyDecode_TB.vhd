LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity KeyDecode_TB is 
end KeyDecode_TB;

architecture behavioral of KeyDecode_TB is

component KeyDecode is
	port
	(
		-- Input ports
		Kack      		: in std_logic;
		clk    	 		: in std_logic;
		reset     		: in std_logic;
		ButtonLine  	: in std_logic_vector(3 downto 0);

		-- Output ports
		Kval      		: out std_logic;
		K	    			: out std_logic_vector(3 downto 0);
		ButtonColumn  	: out std_logic_vector(2 downto 0)
);
end component;

--UUT signals
constant MCLK_PERIOD : time := 20 ns;
constant MCLK_HALF_PERIOD : time := MCLK_PERIOD /2 ;

signal Kack_tb, clk_tb, reset_tb, Kval_TB: std_logic;
signal ButtonLine_tb, Kexit_tb: std_logic_vector (3 downto 0);
signal ButtonColumn_TB: std_logic_vector (2 downto 0);

begin

 --UNIT UNDER TEST
UUT: KeyDecode port map (CLK => CLK_tb, reset => reset_tb, Kack => Kack_tb,
 Kval => Kval_tb, ButtonLine => ButtonLine_tb, K => Kexit_tb, ButtonColumn => ButtonColumn_TB);

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

reset_tb <= '1';
Kack_tb <= '1';

wait for MCLK_PERIOD;

ButtonLine_tb <= "0000";
reset_tb <= '0';

wait for MCLK_PERIOD;

ButtonLine_tb <= "0100";

wait for MCLK_PERIOD;

ButtonLine_tb <= "1000";

wait for MCLK_PERIOD;

ButtonLine_tb <= "0001";

wait for MCLK_PERIOD;

ButtonLine_tb <= "0101";

wait for MCLK_PERIOD;

ButtonLine_tb <= "1001";

wait for MCLK_PERIOD;

ButtonLine_tb <= "0010";

wait for MCLK_PERIOD;

ButtonLine_tb <= "0110";

wait for MCLK_PERIOD;

ButtonLine_tb <= "1010";

wait for MCLK_PERIOD;

ButtonLine_tb <= "0011";

wait for MCLK_PERIOD;

ButtonLine_tb <= "0111";

wait for MCLK_PERIOD;

ButtonLine_tb <= "1011";

wait for MCLK_PERIOD;

wait;

end process;

end behavioral;
