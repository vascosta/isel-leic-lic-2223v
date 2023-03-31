library ieee;
use ieee.std_logic_1164.all;

entity KeyDecode is
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
end KeyDecode;

architecture structural of KeyDecode is

component KeyScan is
	port
	(  
		 -- Input ports
       Kscan    		: in std_logic;
		 CLK_in	  		: in std_logic;
		 ButtonLine		: in std_logic_vector(3 downto 0);

		 -- Output ports
       K        		: out std_logic_vector(3 downto 0);
       Kpress   		: out std_logic;
		 ButtonColumn	: out std_logic_vector(2 downto 0)
	);
end component;

component KeyControl is 
    port
    (
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

component ClkDiv is 
	generic (div: natural := 50000000);

	port 
	( 
		clk_in	: in std_logic;
	
		clk_out	: out std_logic
	);

end component;

signal KscanX, KpressX, CLKX : std_logic;

begin

F1: KeyScan 	port map(Kscan => KscanX, CLK_in => CLKX, ButtonLine => ButtonLine, 
								K => K, Kpress => KpressX, ButtonColumn => ButtonColumn);
								
F2: KeyControl port map(Kpress => KpressX, Kack => Kack, clk => CLKX, reset => reset,
								Kscan  => KscanX, Kval => Kval);
									
F3: ClkDiv  	generic map(1000) port map (clk_in => clk, clk_out => CLKX);

end structural;

