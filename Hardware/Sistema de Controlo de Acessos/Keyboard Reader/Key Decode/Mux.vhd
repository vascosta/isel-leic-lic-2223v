LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity Mux is 
    port
    (
        -- Input ports
        I	: in std_logic_vector(3 downto 0);
        S	: in std_logic_vector(1 downto 0);

        -- Output ports
        O   : out std_logic
    );
end Mux;

architecture structural of Mux is
begin

o <= ((not S(0) and not S(1) and I(0)) or (S(0) and not S(1) and I(1)) or 
        (not S(0) and S(1) and I(2)) or (S(0) and S(1) and I(3)));

end structural;
