library ieee;
use ieee.std_logic_1164.all;

entity ShiftRegister is
	port 
	(
		-- Input ports
      Data    : in  std_logic;
      Clk     : in  std_logic;
      Enable  : in  std_logic;
		Reset	  : in  std_logic;
		
		-- Output ports
      D       : out std_logic_vector(4 downto 0)
	);
end entity ShiftRegister;

architecture behavioral of ShiftRegister is

signal D_X: std_logic_vector(4 downto 0);

begin

	process(Clk, Reset, Enable)
	begin
		if (Reset = '1') then
			D_X <= "00000";

		elsif rising_edge(Clk) then

			if (Enable = '1') then
				D_X(0) <= Data;
				D_X(1) <= D_X(0);
				D_X(2) <= D_X(1);
				D_X(3) <= D_X(2);
				D_X(4) <= D_X(3);
			end if;
		end if;
	end process;
	
	D <= D_X;
end architecture behavioral;