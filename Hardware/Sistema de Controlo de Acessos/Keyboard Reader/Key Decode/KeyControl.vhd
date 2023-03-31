LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity KeyControl is 
	port
	(
		-- Input ports
		Kpress 	: in std_logic;
		Kack 		: in std_logic;
		clk   	: in std_logic;
		reset    : in std_logic;
	
		-- Output ports
		Kscan		: out std_logic;
		Kval		: out std_logic
	);
end KeyControl;

architecture behavioral of KeyControl is

type STATE_TYPE is (STATE_DETETAR_TECLA, STATE_TECLA_PREMIDA, STATE_ESPERAR_TECLA);

signal CurrentState, NextState: STATE_TYPE;

begin

--FLIP-FLOP'S
CurrentState <= STATE_DETETAR_TECLA when reset = '1' else NextState when rising_edge(clk);

--GENERATE NEXT STATE
GenerateNextState:

process (CurrentState, Kpress, Kack)

begin

	case CurrentState is
		when STATE_DETETAR_TECLA	=> if (Kpress = '1') then
													NextState <= STATE_TECLA_PREMIDA;
												else
												    NextState <= STATE_DETETAR_TECLA;
											   end if;
											
		when STATE_TECLA_PREMIDA	=> if ((Kack = '1' and Kpress = '1') or Kack = '0') then
													NextState <= STATE_TECLA_PREMIDA;
												else
													NextState <= STATE_ESPERAR_TECLA;
                                    end if;
												
		when STATE_ESPERAR_TECLA  => if (Kack = '1') then
													NextState <= STATE_ESPERAR_TECLA;
											  else
													NextState <= STATE_DETETAR_TECLA;
											  end if;

	end case;
	
end process;

-- GENERATE OUTPUTS
Kscan	<= '1' when (CurrentState = STATE_DETETAR_TECLA and Kpress = '0')   else '0';
Kval  <= '1' when (CurrentState = STATE_TECLA_PREMIDA)	else '0';

end behavioral;
