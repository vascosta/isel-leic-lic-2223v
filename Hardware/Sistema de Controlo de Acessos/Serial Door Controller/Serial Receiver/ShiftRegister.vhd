library ieee;
use ieee.std_logic_1164.all;

entity ShiftRegister is
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
end entity ShiftRegister;

architecture behavioral of ShiftRegister is

signal D_X: std_logic_vector(4 downto 0);

begin

	process(clk)
	begin
		if rising_edge(clk) then
			if (reset = '1') then
				D_X <= "00000";
			end if;
			if (enable = '1') then
				D_X(4) <= data;
				D_X(3) <= D_X(4);
				D_X(2) <= D_X(3);
				D_X(1) <= D_X(2);
				D_X(0) <= D_X(1);
			end if;
		end if;
	end process;
	
	D <= D_X;
end architecture behavioral;