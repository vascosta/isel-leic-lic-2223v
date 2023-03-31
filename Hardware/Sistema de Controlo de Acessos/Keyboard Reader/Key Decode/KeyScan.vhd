library ieee;
use ieee.std_logic_1164.all;

entity KeyScan is
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
end KeyScan;

architecture structural of KeyScan is

component Counter is 
	port 
	(
        -- Input ports
        CLK : in std_logic;
        CE	: in std_logic;

        -- Output ports
        O   : out std_logic_vector(3 downto 0)
    );
end component;

component Mux is 
    port
    (
        -- Input ports
        I	: in std_logic_vector(3 downto 0);
        S	: in std_logic_vector(1 downto 0);

        -- Output ports
        O	: out std_logic
    );
end component;

component Decoder is 
	port
	(
		-- Input ports
		I	: in std_logic_vector(1 downto 0);
	
		-- Output ports
		O	: out std_logic_vector(2 downto 0)
	);
end component;


signal OCounterX, BLX	: std_logic_vector(3 downto 0);
signal BCX					: std_logic_vector(2 downto 0);
signal OMuxX 		: std_logic;

begin

K(3) <= OCounterX(3);
K(2) <= OCounterX(2);
K(1) <= OCounterX(1);
K(0) <= OCounterX(0);

Kpress <= not OMuxX;

ButtonColumn(0) <= not BCX(0);
ButtonColumn(1) <= not BCX(1);
ButtonColumn(2) <= not BCX(2);

BLX(0) <= ButtonLine(0);
BLX(1) <= ButtonLine(1);
BLX(2) <= ButtonLine(2);
BLX(3) <= ButtonLine(3);

T1: Counter	port map (CLK => CLK_in , CE => Kscan, O(3) => OCounterX(3), O(2) => OCounterX(2), O(1) => OCounterX(1), O(0) => OCounterX(0));
								
T2: Mux 		port map (I(3) => BLX(3), I(2) => BLX(2), I(1) => BLX(1), I(0) => BLX(0), 
								S(1) => OCounterX(1), S(0) => OCounterX(0), O => OMuxX);
			
T3: Decoder port map (I(1) => OCounterX(3), I(0) => OCounterX(2), O(2) => BCX(2), O(1) => BCX(1), O(0) => BCX(0));
									

end structural;
