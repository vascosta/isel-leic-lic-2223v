library ieee;
use ieee.std_logic_1164.all;

entity KeyScan is
	port
	(  
		-- Input ports
		Kscan    		: in std_logic;
		Clk	  			: in std_logic;
		Reset				: in std_logic;
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
		Clk 	: in std_logic;
		Ce  	: in std_logic;
		Clr   : in std_logic;
		Limit	: in integer;

      -- Output ports
      O   	: out std_logic_vector(3 downto 0)
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


signal OCounter_X, BL_X	: std_logic_vector(3 downto 0);
signal BC_X					: std_logic_vector(2 downto 0);
signal OMux_X 				: std_logic;

begin

K(3) <= OCounter_X(3);
K(2) <= OCounter_X(2);
K(1) <= OCounter_X(1);
K(0) <= OCounter_X(0);

Kpress <= not OMux_X;

ButtonColumn(0) <= not BC_X(0);
ButtonColumn(1) <= not BC_X(1);
ButtonColumn(2) <= not BC_X(2);

BL_X(0) <= ButtonLine(0);
BL_X(1) <= ButtonLine(1);
BL_X(2) <= ButtonLine(2);
BL_X(3) <= ButtonLine(3);

T1: Counter	port map (Clk => Clk , Ce => Kscan, Limit => 15, Clr => Reset,
							 O(3) => OCounter_X(3), O(2) => OCounter_X(2), O(1) => OCounter_X(1), O(0) => OCounter_X(0));
								
T2: Mux 		port map (I(3) => BL_X(3), I(2) => BL_X(2), I(1) => BL_X(1), I(0) => BL_X(0), 
							 S(1) => OCounter_X(1), S(0) => OCounter_X(0), 
							 O => OMux_X);
			
T3: Decoder port map (I(1) => OCounter_X(3), I(0) => OCounter_X(2), 
							 O(2) => BC_X(2), O(1) => BC_X(1), O(0) => BC_X(0));
									

end structural;
