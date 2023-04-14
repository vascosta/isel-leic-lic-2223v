library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
  
entity CLKDIV is
	generic(div: natural := 50000000);
	port 
	( 
		-- Input ports
		Clk_in: in std_logic;
		
		-- Output ports
		Clk_out: out std_logic
		);
end CLKDIV;
  
architecture bhv of CLKDIV is
  
signal count: integer:=1;
signal tmp : std_logic := '0';
  
begin

	process(Clk_in)
	begin
		if(Clk_in'event and Clk_in='1') then
			count <= count+1;
			if (count = div/2) then
				tmp <= not tmp;
				count <= 1;
			end if;
		end if;
	end process;

Clk_out <= tmp;

End bhv;