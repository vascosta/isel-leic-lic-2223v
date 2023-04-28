LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity SerialDoorReceiver is 
port
	(
		-- Input ports
		SDX   	: in std_logic;
		SCLK  	: in std_logic;
		nSS    	: in std_logic;
		accept   : in std_logic;
		reset    : in std_logic;
	
		-- Output ports
		D     	: out std_logic_vector(4 downto 0);
		DXval 	: out std_logic;
		Busy		: out std_logic
	);
end SerialDoorReceiver;

architecture structural of SerialReceiver is

component SerialDoorControl is 
	port
	(
		-- Input ports
		clk 		: in std_logic;
		enRx 		: in std_logic;
		accept 	: in std_logic;
		eq5	 	: in std_logic;
		reset    : in std_logic;
	
		-- Output ports
		clr		: out std_logic;
		wr			: out std_logic;
		DXval		: out std_logic;
		Busy		: out std_logic
	);
end component;

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

component SerialReceiverCounter IS
port 
	(
		-- Input ports
		clk 	: in std_logic;
		Ce  	: in std_logic;
		clr	: in std_logic;

      -- Output ports
      O   	: out std_logic_vector(3 downto 0)
    	);
end component;


signal clr_X, wr_X, eq5_X: std_logic;
signal O_X : std_logic_vector(3 downto 0);

begin

eq5_X <= not O_X(3) and O_X(2) and not O_X(1) and O_X(0);

U0: SerialDoorControl 		port map (clk => SCLK, enRx => nSS, eq5 => eq5_X, accept => accept, reset => reset, 
													wr => wr_X, clr => clr_X, DXval => DXval, Busy => Busy);
													
U1: ShiftRegister      		port map (clk => SCLK, reset => reset, data => SDX, enable => wr_X, 
												D => D);

U2: SerialReceiverCounter	port map (clk => SCLK , clr => clr_X, Ce => SDX, 
												O => O_X);

end structural;