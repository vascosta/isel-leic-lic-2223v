library ieee;
use ieee.std_logic_1164.all;

entity KeyboardReader is
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
end KeyboardReader;

architecture structural of KeyboardReader is

component KeyDecode is
	port
	(
		-- Input ports
		Kack      		: in std_logic;
		Clk    	 		: in std_logic;
		Reset     		: in std_logic;
		ButtonLine  	: in std_logic_vector(3 downto 0);

		-- Output ports
		Kval      		: out std_logic;
		K	    			: out std_logic_vector(3 downto 0);
		ButtonColumn  	: out std_logic_vector(2 downto 0)
	);
end component;

component OutputBuffer is
	port
	(
		-- Input ports
		Clk		: in std_logic;
		Load		: in std_logic;
		Ack   	: in std_logic;
		Reset		: in std_logic;
		D			: in std_logic_vector(3 downto 0);
	
		-- Output ports
		Q     	: out std_logic_vector(3 downto 0);
		Dval 		: out std_logic;
		OBfree	: out std_logic
	);
end component;

component RingBuffer is
	port
	(
		-- Input ports
		Clk		: in std_logic;
		Reset		: in std_logic;
		D			: in std_logic_vector(3 downto 0);
		DAV		: in std_logic;
		CTS		: in std_logic;
	
		-- Output ports
		Q     	: out std_logic_vector(3 downto 0);
		Wreg 		: out std_logic;
		DAC		: out std_logic
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

signal Clk_X, Kval_X, Kack_X, CTS_X, Wreg_X : std_logic;
signal Q_X, D_X 													: std_logic_vector (3 downto 0);

begin

F1: KeyDecode 				port map (Kack => Kack_X, Clk => Clk_X, Reset => Reset, ButtonLine => ButtonLine, 
											 Kval => Kval_X, K => D_X, ButtonColumn => ButtonColumn);
														 
F2: RingBuffer 			port map (Clk => Clk, Reset => Reset, CTS => CTS_X, DAV => Kval_X, D => D_X,
											 Q => Q_X, Wreg => Wreg_X, DAC => Kack_X);

F3: OutputBuffer 			port map (Load => Wreg_X, Clk => Clk, Reset => Reset, D => Q_X, 
											 ACK => ACK, OBfree => CTS_X, Dval => Dval, Q => Q);														 
									
F4: ClkDiv  	generic map(1000) port map (Clk_in => Clk, Clk_out => Clk_X);						

end structural;

