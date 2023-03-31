library ieee;
use ieee.std_logic_1164.all;

entity SistemaControloAcessos is
	port
	(
		-- Input ports
		clk    	 		: in std_logic;
		reset     		: in std_logic;
		ButtonLine  	: in std_logic_vector(3 downto 0);

		-- Output ports
		ButtonColumn  	: out std_logic_vector(2 downto 0)
);
end SistemaControloAcessos;

architecture structural of SistemaControloAcessos is

component KeyboardReader is
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

component UsbPort is 
   port
	(
		inputPort		:  in  std_logic_vector(7 downto 0);
		outputPort 		:  out  std_logic_vector(7 downto 0)
);
end component;

signal inputPortX 	: std_logic_vector(7 downto 0);
signal KX				: std_logic_vector(3 downto 0);
signal KackX 			: std_logic;

begin

F1: UsbPort 			port map(inputPort(0) => KX(0), inputPort(1) => KX(1), inputPort(2) => KX(2), inputPort(3) => KX(3), 
										inputPort(4) => inputPortX(4), outputPort(0) => KackX);

F2: KeyboardReader 	port map(Kack => KackX, clk => clk, reset => reset, ButtonLine => ButtonLine,
										Kval => inputPortX(4), K(0) => KX(0), K(1) => KX(1), K(2) => KX(2),
										K(3) => KX(3),  ButtonColumn => ButtonColumn);

end structural;

