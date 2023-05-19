library ieee;
use ieee.std_logic_1164.all;

entity SistemaControloAcessos is
	port
	(
		-- Input ports
		Clk    	 		: in std_logic;
		ButtonLine  	: in std_logic_vector(3 downto 0);

		-- Output ports
		Pswitch			: out std_logic;
		HEX0				: out std_logic_vector(7 downto 0);
		HEX1				: out std_logic_vector(7 downto 0);
		HEX2				: out std_logic_vector(7 downto 0);
		HEX3				: out std_logic_vector(7 downto 0);
		HEX4				: out std_logic_vector(7 downto 0);
		HEX5				: out std_logic_vector(7 downto 0);
		ButtonColumn  	: out std_logic_vector(2 downto 0)
);
end SistemaControloAcessos;

architecture structural of SistemaControloAcessos is

component KeyboardReader is
	port
	(
		-- Input ports
		ACK      		: in std_logic;
		Clk    	 		: in std_logic;
		Reset     		: in std_logic;
		ButtonLine  	: in std_logic_vector(3 downto 0);

		-- Output ports
		Dval      		: out std_logic;
		Q	    			: out std_logic_vector(3 downto 0);
		ButtonColumn  	: out std_logic_vector(2 downto 0)
	);
end component;

component SerialDoorController is 
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
end component;

component door_mecanism is
	port
	(	
		-- Input ports
		MCLK 			: in std_logic;
		RST			: in std_logic;
		onOff			: in std_logic;
		openClose	: in std_logic;
		v				: in std_logic_vector(3 downto 0);
		Pswitch		: in std_logic;
		
		-- Output ports
		Sopen			: out std_logic;
		Sclose		: out std_logic;
		Pdetector	: out std_logic;
		HEX0			: out std_logic_vector(7 downto 0);
		HEX1			: out std_logic_vector(7 downto 0);
		HEX2			: out std_logic_vector(7 downto 0);
		HEX3			: out std_logic_vector(7 downto 0);
		HEX4			: out std_logic_vector(7 downto 0);
		HEX5			: out std_logic_vector(7 downto 0)
		);
end component;

component UsbPort is 
	port
	(
		-- Input ports
		inputPort		:  in  std_logic_vector(7 downto 0);
		
		-- Output ports
		outputPort 		:  out  std_logic_vector(7 downto 0)
	);
end component;



signal Q_X					: std_logic_vector(3 downto 0);
signal ACK_X, Dval_X		: std_logic;

signal SDX_X, SClk_X, nSDCsel_X, Busy_X, Sopen_X, Sclose_X, Psensor_X, OnNOff_X, D_X	: std_logic;

begin

F1: UsbPort 					port map(inputPort(0) => Q_X(0), inputPort(1) => Q_X(1), inputPort(2) => Q_X(2),
												inputPort(3) => Q_X(3), inputPort(4) => Dval_X, inputPort(6) => Busy_X,
												outputPort(1) => nSDCsel_X, outputPort(3) => SDX_X, outputPort(4) => SClk_X,
												outputPort(7) => ACK_X);
												
F2: KeyboardReader			port map(ACK => ACK_X, Clk => Clk, Reset => Reset, ButtonLine => ButtonLine,
												Dval => Dval_X, Q => Q_X,  ButtonColumn => ButtonColumn);												

F3: SerialDoorController	port map(Clk => Clk, SDX => SDX_X, SClk => SClk_X, nSDCsel => nSDCsel_X, Reset => Reset,
												Sclose => Sclose_X, Sopen => Sopen_X, Psensor => Psensor_X,
												D => D_X, OnNOff => OnNOff_X, Busy => Busy_X);	
												
F4: door_mecanism				port map(MCKL => Clk, RST => Reset, onOff => OnNOff_X, openClose => D_X(0), 
												v(0) => D_X(1), v(1) => D_X(2), v(2) => D_X(3), v(3) => D_X(4), Pswitch => Pswitch, 
												Sopen => Sopen_X, Sclose => Sclose_X, Pdetector => Psensor_X,
												HEX0 => HEX0, HEX1 => HEX1, HEX2 => HEX2, HEX3 => HEX3, HEX4 => HEX4,
												HEX5 => HEX5)

end structural;

