library ieee;
use ieee.std_logic_1164.all;

entity DoorController is 
	port
	(
		-- Input ports
		Clk 		: in std_logic;
		Reset    : in std_logic;
		Dval 		: in std_logic;
		OC	 		: in std_logic_vector(4 downto 0);
		Sclose	: in std_logic;
		Sopen		: in std_logic; 
		Psensor 	: in std_logic;
	
		-- Output ports
		OnNOff	: out std_logic;
		Dout		: out std_logic_vector(4 downto 0);
		Done		: out std_logic
	);
end DoorController;

architecture behavioral of DoorController is

type STATE_TYPE is (STATE_WAITING, STATE_FECHO, STATE_ABERTURA, STATE_FECHO_INTERRUPT, STATE_DONE);

signal CurrentState, NextState: STATE_TYPE;

begin

--FLIP-FLOP'S
CurrentState <= STATE_WAITING when Reset = '1' else NextState when rising_edge(Clk);

--GENERATE NEXT STATE
GenerateNextState:

process (CurrentState, Dval, OC, Sclose, Sopen, Psensor)

begin

	case CurrentState is
		
		when STATE_WAITING  => 			if (Dval = '1' and OC(0) = '1') then
													NextState <= STATE_ABERTURA;
												elsif (Dval = '1' and OC(0) = '0') then
													NextState <= STATE_FECHO;
												else
													NextState <= STATE_WAITING;
												end if;									
											
		when STATE_FECHO  => 			if (Psensor = '1') then
													NextState <= STATE_ABERTURA;
												elsif (Psensor = '0' and Sclose = '0') then
													NextState <= STATE_FECHO;
												else
													NextState <= STATE_DONE;
												end if;
												
	   when STATE_ABERTURA  => 		if (Sopen = '1' and OC(0) = '1') then
													NextState <= STATE_DONE;
												elsif (Sopen = '1' and OC(0) = '0') then
													NextState <= STATE_FECHO_INTERRUPT;
												else
													NextState <= STATE_ABERTURA;
												end if;
												
		when STATE_FECHO_INTERRUPT   =>	if (Psensor = '1') then
														NextState <= STATE_ABERTURA;
													elsif (Psensor = '0' and Sclose = '0') then
														NextState <= STATE_FECHO_INTERRUPT;
													else
														NextState <= STATE_DONE;
													end if;																																
		
		when STATE_DONE         =>    if (Dval = '1') then
													NextState <= STATE_WAITING;													
												else
													NextState <= STATE_DONE;
												end if;
	end case;
	
end process;

-- GENERATE OUTPUTS
OnNOff 	<= '1'	when (CurrentState = STATE_FECHO or CurrentState = STATE_ABERTURA or CurrentState = STATE_FECHO_INTERRUPT) else '0';
Dout(0) 	<= '1'	when (CurrentState = STATE_ABERTURA) else OC(0);
Dout(4)  <=	OC(4);
Dout(3)	<= OC(3);
Dout(2)	<= OC(2);
Dout(1)  <=	OC(1);
Done		<= '1' 	when (CurrentState = STATE_DONE) else '0';

end behavioral;