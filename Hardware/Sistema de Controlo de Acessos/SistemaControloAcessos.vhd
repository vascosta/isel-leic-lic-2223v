library ieee;
use ieee.std_logic_1164.all;

entity SistemaControloAcessos is
	port
	(
		-- Input ports
		Clk    	 		: in std_logic;
		Reset     		: in std_logic;
		Sclose			: in std_logic;
		Sopen				: in std_logic;
		Psensor			: in std_logic;
--		ButtonLine  	: in std_logic_vector(3 downto 0);

		-- Output ports
		D     			: out std_logic_vector(4 downto 0);
		OnNOff			: out std_logic
--		ButtonColumn  	: out std_logic_vector(2 downto 0);
--		LCD_Rs  			: out std_logic;
--		LCD_E  			: out std_logic;
--		LCD_D  			: out std_logic_vector(3 downto 0)
);
end SistemaControloAcessos;

architecture structural of SistemaControloAcessos is

--component KeyboardReader is
--	port
--	(
--		-- Input ports
--		Kack      		: in std_logic;
--		Clk    	 		: in std_logic;
--		Reset     		: in std_logic;
--		ButtonLine  	: in std_logic_vector(3 downto 0);
--
--		-- Output ports
--		Kval      		: out std_logic;
--		K	    			: out std_logic_vector(3 downto 0);
--		ButtonColumn  	: out std_logic_vector(2 downto 0)
--);
--end component;

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

component UsbPort is 
	port
	(
		-- Input ports
		inputPort		:  in  std_logic_vector(7 downto 0);
		
		-- Output ports
		outputPort 		:  out  std_logic_vector(7 downto 0)
	);
end component;



signal inputPort_X 		: std_logic_vector(7 downto 0);
--signal KX_X					: std_logic_vector(3 downto 0);
--signal Kack_X				: std_logic;

signal SDX_X, SClk_X, nSDCsel_X, Busy_X	: std_logic;


begin

--F1: UsbPort 			port map(inputPort(0) => KX_X(0), inputPort(1) => KX_X(1), inputPort(2) => KX_X(2), inputPort(3) => KX_X(3), 
--										inputPort(4) => inputPort_X(4),
--										outputPort(0) => LCD_D(0),	outputPort(1) => LCD_D(1), outputPort(2) => LCD_D(2), outputPort(3) => LCD_D(3),
--										outputPort(4) => LCD_Rs, outputPort(5) => LCD_E, outputPort(7) => Kack_X);

--F2: KeyboardReader	port map(Kack => Kack_X, Clk => Clk, Reset => Reset, ButtonLine => ButtonLine,
--										Kval => inputPort_X(4), K(0) => KX_X(0), K(1) => KX_X(1), K(2) => KX_X(2),
--										K(3) => KX_X(3),  ButtonColumn => ButtonColumn);

F1: UsbPort 					port map(inputPort(5) => Busy_X,
												outputPort(3) => nSDCsel_X, outputPort(1) => SClk_X, outputPort(2) => SDX_X);

F2: SerialDoorController	port map(Clk => Clk, SDX => SDX_X, SClk => SClk_X, nSDCsel => nSDCsel_X, Reset => Reset,
												Sclose => Sclose, Sopen => Sopen, Psensor => Psensor,
												D => D, OnNOff => OnNOff, Busy => Busy_X);									

end structural;

