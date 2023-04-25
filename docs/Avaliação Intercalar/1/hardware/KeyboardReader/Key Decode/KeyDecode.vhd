library ieee;
use ieee.std_logic_1164.all;

entity KeyDecode is
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
end KeyDecode;

architecture structural of KeyDecode is

component KeyScan is
	port
	(  
		-- Input ports
      Kscan    		: in std_logic;
		Clk	  			: in std_logic;
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
      Kpress	: in std_logic;
      Kack     : in std_logic;
      Clk      : in std_logic;
      Reset    : in std_logic;

      -- Output ports
      Kscan    : out std_logic;
      Kval     : out std_logic
   );
end component;


signal Kscan_X, Kpress_X : std_logic;

begin

F1: KeyScan 	port map(Kscan => Kscan_X, Clk => Clk, ButtonLine => ButtonLine, 
								K => K, Kpress => Kpress_X, ButtonColumn => ButtonColumn);
								
F2: KeyControl port map(Kpress => Kpress_X, Kack => Kack, Clk => Clk, Reset => Reset,
								Kscan  => Kscan_X, Kval => Kval);

end structural;

