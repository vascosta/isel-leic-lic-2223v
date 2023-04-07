library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SerialReceiverCounter is 
	port 
	(
		-- Input ports
		clk 	: in std_logic;
		Ce  	: in std_logic;
		clr	: in std_logic;

      -- Output ports
      O   	: out std_logic_vector(3 downto 0)
    	);
end SerialReceiverCounter;

architecture behavioral of SerialReceiverCounter is

signal count: integer := 0;
	 
begin

	process(clk)
   begin
		if rising_edge(clk) then
			if	(clr = '1')	then
				count <= 0;
         if (Ce = '1') then
            if (count = 15) then
					count <= 0;
            else
               count <= count + 1;
            end if;
         end if;
			end if;
       end if;
	end process;

   O <= std_logic_vector(to_signed(count, O'length));
end architecture behavioral;