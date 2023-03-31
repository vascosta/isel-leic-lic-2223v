library ieee;
use ieee.std_logic_1164.all;

entity KeyboardReader is
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
end KeyboardReader;

architecture structural of KeyboardReader is

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


begin

F1: KeyDecode 	port map(Kack => Kack, clk => clk, reset => reset, ButtonLine => ButtonLine, 
									Kval => Kval, K => K, ButtonColumn => ButtonColumn);

end structural;

