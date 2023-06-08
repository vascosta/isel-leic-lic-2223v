library ieee;
use ieee.std_logic_1164.all;

entity Decoder_TB is 
end Decoder_TB;

architecture behavioral of Decoder_TB is

component Decoder is 
	port
	(
		-- Input ports
		I	: in std_logic_vector(1 downto 0);
	
		-- Output ports
		O	: out std_logic_vector(2 downto 0)
	);
end component;

--UUT signals
constant MCLK_PERIOD 		: time := 20 ns;
constant MCLK_HALF_PERIOD	: time := MCLK_PERIOD /2 ;

signal I_TB: std_logic_vector (1 downto 0);
signal O_TB: std_logic_vector (2 downto 0);

begin

-- UNIT UNDER TEST
UUT: Decoder port map (I => I_TB, 
							  O => O_TB);

stimulus : process
begin

I_TB <= "00";

wait for MCLK_PERIOD;
wait for MCLK_PERIOD;

I_TB <= "01";

wait for MCLK_PERIOD;
wait for MCLK_PERIOD;

I_TB <= "10";

wait for MCLK_PERIOD;

wait;

end process;

end behavioral;