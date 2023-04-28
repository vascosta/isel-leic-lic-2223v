library ieee;
use ieee.std_logic_1164.all;

entity SerialDoorControl is 
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
end SerialDoorControl;

architecture behavioral of SerialControl is

type STATE_TYPE is (STATE_WAITING, STATE_START, STATE_RECEIVING, STATE_END);

signal CurrentState, NextState: STATE_TYPE;

begin

--FLIP-FLOP'S
CurrentState <= STATE_WAITING when reset = '1' else NextState when rising_edge(clk);

--GENERATE NEXT STATE
GenerateNextState:

process (CurrentState, eq5, accept, enRx)

begin

	case CurrentState is
		when STATE_WAITING		=> if (enRx = '1') then
												if (enRx = '0') then
													NextState <= STATE_START;
												else
													NextState <= STATE_WAITING;
												end if;
											else
												NextState <= STATE_WAITING;
											end if;
											
		when STATE_START			=> NextState <= STATE_RECEIVING;
											
		when STATE_RECEIVING    => if (eq5 = '0') then
												NextState <= STATE_RECEIVING;
											else
                                    NextState <= STATE_END;
                                 end if;													
													 
      when STATE_END          => if (accept = '0') then
												NextState <= STATE_END;
                                 else
                                    NextState <= STATE_WAITING;
											end if;
	end case;
	
end process;

-- GENERATE OUTPUTS
clr 	<= '1' when (CurrentState = STATE_START) else '0';
wr   	<= '1' when (CurrentState = STATE_RECEIVING) else '0';
DXval	<= '1' when (CurrentState = STATE_END) else '0';

end behavioral;
