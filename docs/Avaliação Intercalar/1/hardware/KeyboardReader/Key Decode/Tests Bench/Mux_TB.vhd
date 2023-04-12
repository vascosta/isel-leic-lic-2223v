library ieee;
use ieee.std_logic_1164.all;

entity Mux_TB is 
end Mux_TB;

architecture behavioral of Mux_TB is

component Mux is 
	port
	(
		-- Input ports
      		I	: in std_logic_vector(3 downto 0);
      		S	: in std_logic_vector(1 downto 0);

      		-- Output ports
      		O 	: out std_logic
    	);
end component;

--UUT signals
constant MCLK_PERIOD	: time := 20 ns;
constant MCLK_HALF_PERIOD	: time := MCLK_PERIOD /2 ;

signal I_TB	: std_logic_vector(3 downto 0);
signal S_TB	: std_logic_vector(1 downto 0);
signal O_TB	: std_logic;

begin

-- UNIT UNDER TEST
UUT: Mux port map (I(0) => I_TB(0), I(1) => I_TB(1), I(2) => I_TB(2), I(3) => I_TB(3), S(0) => S_TB(0), S(1) => S_TB(1), 
		   O => O_TB);

stimulus : process
begin

I_TB(0) <= '0';
I_TB(1) <= '0';
I_TB(2) <= '0';
I_TB(3) <= '0';
S_TB(0) <= '0';
s_TB(1) <= '0';

wait for MCLK_PERIOD;
wait for MCLK_PERIOD;

I_TB(0) <= '1';
I_TB(1) <= '1';
I_TB(2) <= '1';
I_TB(3) <= '1';
S_TB(0) <= '1';
s_TB(1) <= '1';

wait for MCLK_PERIOD;
wait for MCLK_PERIOD;

I_TB(0) <= '1';
I_TB(1) <= '1';
I_TB(2) <= '0';
I_TB(3) <= '0';
S_TB(0) <= '1';
s_TB(1) <= '0';

wait for MCLK_PERIOD;
wait for MCLK_PERIOD;

I_TB(0) <= '1';
I_TB(1) <= '1';
I_TB(2) <= '0';
I_TB(3) <= '0';
S_TB(0) <= '0';
s_TB(1) <= '1';

wait for MCLK_PERIOD;
wait for MCLK_PERIOD;

I_TB(0) <= '0';
I_TB(1) <= '0';
I_TB(2) <= '1';
I_TB(3) <= '1';
S_TB(0) <= '1';
s_TB(1) <= '0';

wait for MCLK_PERIOD;
wait for MCLK_PERIOD;

I_TB(0) <= '0';
I_TB(1) <= '0';
I_TB(2) <= '1';
I_TB(3) <= '1';
S_TB(0) <= '0';
s_TB(1) <= '1';

wait for MCLK_PERIOD;

wait;

end process;

end behavioral;
