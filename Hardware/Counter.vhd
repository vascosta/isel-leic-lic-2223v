LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity Counter is 
    port 
	 (
        -- Input ports
        CLK : in std_logic;
        CE  : in std_logic;

        -- Output ports
        O   : out std_logic_vector(3 downto 0)
    );
end Counter;

architecture behavioral of Counter is
    signal count: integer := 0;
begin
    process(CLK)
    begin
        if rising_edge(CLK) then
            if (CE = '1') then
                if (count = 15) then
                    count <= 0;
                else
                    count <= count + 1;
                end if;
            end if;
        end if;
    end process;

    O <= std_logic_vector(to_signed(count, O'length));
end architecture behavioral;