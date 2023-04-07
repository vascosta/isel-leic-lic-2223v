LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity ShiftRegister_TB is 
end ShiftRegister_TB;

architecture behavioral of ShiftRegister_TB is

component ShiftRegister is 
	port 
	(
		-- Input ports
      data    : in  std_logic;
      clk     : in  std_logic;
      enable  : in  std_logic;
		reset	  : in  std_logic;
		
		-- Output ports
      D       : out std_logic_vector(4 downto 0)
	);
end component;

--UUT signals
constant MCLK_PERIOD : time := 20 ns;
constant MCLK_HALF_PERIOD : time := MCLK_PERIOD /2 ;

signal clk_TB, reset_TB, enable_TB, data_TB: std_logic;
signal D_TB: std_logic_vector (4 downto 0);

begin

-- UNIT UNDER TEST
UUT: ShiftRegister port map (clk => clk_TB, reset => reset_TB, enable => enable_TB, data => data_TB, 
										D => D_TB);

clk_gen : process 

begin

clk_TB <= '0';

wait for MCLK_HALF_PERIOD;

clk_TB <= '1';

wait for MCLK_HALF_PERIOD;

end process;

stimulus : process

begin

-- reset
reset_TB <= '1';
enable_TB <= '0';

wait for MCLK_PERIOD;

reset_TB <= '0';

wait for MCLK_PERIOD;

enable_TB <= '1';
data_TB <= '0';

wait for MCLK_PERIOD;

wait for MCLK_PERIOD;

data_TB <= '0';

wait for MCLK_PERIOD;

data_TB <= '0';

wait for MCLK_PERIOD;

data_TB <= '1';

wait for MCLK_PERIOD;

data_TB <= '1';

wait for MCLK_PERIOD;

enable_TB <= '0';


wait;

end process;

end behavioral;