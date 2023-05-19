library ieee;
use ieee.std_logic_1164.all;

entity SerialDoorController is 
	port
	(
		-- Input ports
		nSDCsel	: in std_logic;
		SClk  	: in std_logic;
		Clk		: in std_logic;
		SDX    	: in std_logic;
		Reset  	: in std_logic;
		Sclose	: in std_logic;
		Sopen		: in std_logic;
		Psensor	: in std_logic;
	
		-- Output ports
		D     	: out std_logic_vector(4 downto 0);
		OnNOff	: out std_logic;
		Busy		: out std_logic
	);
end SerialDoorController;

architecture structural of SerialDoorController is

component SerialReceiver is 
	port
	(
		-- Input ports
		Clk		: in std_logic;
		SDX   	: in std_logic;
		SClk  	: in std_logic;
		nSS    	: in std_logic;
		Accept   : in std_logic;
		Reset    : in std_logic;
	
		-- Output ports
		D     	: out std_logic_vector(4 downto 0);
		DXval 	: out std_logic;
		Busy		: out std_logic
	);
end component;

component DoorController is 
	port
	(
		-- Input ports
		Clk 		: in std_logic;
		Reset    : in std_logic;
		Dval 		: in std_logic;
		OC		 	: in std_logic_vector(4 downto 0);
		Sclose	: in std_logic;
		Sopen		: in std_logic; 
		Psensor 	: in std_logic;
	
		-- Output ports
		OnNOff	: out std_logic;
		Dout		: out std_logic_vector(4 downto 0);
		Done		: out std_logic
	);
end component;

component ClkDiv is 
	generic (div: natural := 50000000);

	port 
	( 
		Clk_in	: in std_logic;
	
		Clk_out	: out std_logic
	);
end component;

signal Done_X, Dval_X, Clk_X, Busy_X	: std_logic;
signal OC_X 									: std_logic_vector(4 downto 0);

begin

U0: SerialReceiver 			port map (Clk => Clk, SDX => SDX, SClk => SClk, nSS => nSDCsel, Accept => Done_X, Reset => Reset, 
												 D => OC_X, DXval => Dval_X, Busy => Busy);
													
U1: DoorController     		port map (Clk => Clk, Reset => Reset, Dval => Dval_X, OC => OC_X, Sclose => Sclose, Sopen => Sopen,
												 Psensor => Psensor,
												 OnNOff => OnNOff, Dout => D, Done => Done_X);
												 
---U2: ClkDiv  	generic map(500) port map (Clk_in => Clk, Clk_out => Clk_X);												 

end structural;