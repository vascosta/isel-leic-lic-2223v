library ieee;
use ieee.std_logic_1164.all;

entity SistemaControloAcessos is
	port
	(
		-- Input ports
		Clk    	 		: in std_logic;
		Reset     		: in std_logic;
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

--component SerialDoorController is 
--	port
--	(
--		-- Input ports
--		nSDCsel	: in std_logic;
--		SClk  	: in std_logic;
--		Clk		: in std_logic;
--		SDX    	: in std_logic;
--		Reset  	: in std_logic;
--		Sclose	: in std_logic;
--		Sopen		: in std_logic;
--		Psensor	: in std_logic;
--	
--		-- Output ports
--		D     	: out std_logic_vector(4 downto 0);
--		OnNOff	: out std_logic;
--		Busy		: out std_logic
--	);
--end component;

component UsbPort is 
	port
	(
		-- Input ports
		inputPort		:  in  std_logic_vector(7 downto 0);
		
		-- Output ports
		outputPort 		:  out  std_logic_vector(7 downto 0)
	);
end component;



signal QX_X					: std_logic_vector(3 downto 0);
signal ACK_X, Dval_X		: std_logic;

signal SDX_X, SClk_X, nSDCsel_X, Busy_X	: std_logic;

begin

F1: UsbPort 					port map(inputPort(0) => QX_X(0), inputPort(1) => QX_X(1), inputPort(2) => QX_X(2),
												inputPort(3) => QX_X(3), inputPort(4) => Dval_X, --inputPort(6) => Busy_X,
--												outputPort(1) => SClk_X, outputPort(2) => SDX_X, outputPort(3) => nSDCsel_X,
												outputPort(7) => ACK_X);
												
F2: KeyboardReader			port map(ACK => ACK_X, Clk => Clk, Reset => Reset, ButtonLine => ButtonLine,
												Dval => Dval_X, Q => QX_X,  ButtonColumn => ButtonColumn);												

--F3: SerialDoorController	port map(Clk => Clk, SDX => SDX_X, SClk => SClk_X, nSDCsel => nSDCsel_X, Reset => Reset,
--												Sclose => Sclose, Sopen => Sopen, Psensor => Psensor,
--												D => D, OnNOff => OnNOff, Busy => Busy_X);									

end structural;

