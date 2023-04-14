library ieee;
use ieee.std_logic_1164.all;

entity SerialControl is 
	port
	(
		-- Input ports
		Clk 		: in std_logic;
		EnRx 		: in std_logic;
		Accept 	: in std_logic;
		Eq5	 	: in std_logic;
		Reset    : in std_logic;
	
		-- Output ports
		Clr		: out std_logic;
		Wr			: out std_logic;
		DXval		: out std_logic
	);
end SerialControl;

architecture behavioral of SerialControl is

type STATE_TYPE is (STATE_WAITING, STATE_START, STATE_RECEIVING, STATE_END);

signal CurrentState, NextState: STATE_TYPE;

begin

--FLIP-FLOP'S
CurrentState <= STATE_WAITING when Reset = '1' else NextState when rising_edge(Clk);

--GENERATE NEXT STATE
GenerateNextState:

process (CurrentState, Eq5, Accept, EnRx)

begin

	case CurrentState is
		when STATE_WAITING		=> if (EnRx = '1') then
												if (EnRx = '0') then
													NextState <= STATE_START;
												else
													NextState <= STATE_WAITING;
												end if;
											else
												NextState <= STATE_WAITING;
											end if;
											
		when STATE_START			=> NextState <= STATE_RECEIVING;
											
		when STATE_RECEIVING    => if (Eq5 = '0') then
												NextState <= STATE_RECEIVING;
											else
                                    NextState <= STATE_END;
                                 end if;													
													 
      when STATE_END          => if (Accept = '0') then
												NextState <= STATE_END;
                                 else
                                    NextState <= STATE_WAITING;
											end if;
	end case;
	
end process;

-- GENERATE OUTPUTS
Clr 	<= '1' when (CurrentState = STATE_START) 		else '0';
Wr   	<= '1' when (CurrentState = STATE_RECEIVING)	else '0';
DXval	<= '1' when (CurrentState = STATE_END) 		else '0';

end behavioral;
