LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity Mux is 
    port
    (
        -- Input ports
        I	: in std_logic_vector(3 downto 0);
        S	: in std_logic_vector(1 downto 0);

        -- Output ports
        O : out std_logic
    );
end Mux;

architecture structural of Mux is
begin

o <= ((NOT S(0) AND NOT S(1) AND I(0)) OR (S(0) AND NOT S(1) AND I(1)) OR 
        (NOT S(0) AND S(1) AND I(2)) OR (S(0) AND S(1) AND I(3)));

end structural;