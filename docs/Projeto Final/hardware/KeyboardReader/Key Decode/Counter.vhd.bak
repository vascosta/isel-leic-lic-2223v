library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Counter is 
	port 
	(
		-- Input ports
		Clk : in std_logic;
		Ce  : in std_logic;

      -- Output ports
      O   : out std_logic_vector(3 downto 0)
    	);
end Counter;

architecture behavioral of Counter is

signal Count: integer := 0;
	 
begin

    process(Clk)
    begin
        if rising_edge(Clk) then
            if (Ce = '1') then
                if (Count = 15) then
                    Count <= 0;
                else
                    Count <= Count + 1;
                end if;
            end if;
        end if;
    end process;

    O <= std_logic_vector(to_signed(Count, O'length));
end architecture behavioral;