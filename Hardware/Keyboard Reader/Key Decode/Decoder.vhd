LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity Decoder is 
	port
	(
		-- Input ports
		I	: in std_logic_vector(1 downto 0);
	
		-- Output ports
		O	: out std_logic_vector(2 downto 0)
	);
end Decoder;

architecture structural of Decoder is
begin

O(0) <= not I(1) and not I(0);
O(1) <= not I(1) and I(0);
O(2) <= I(1) and not I(0);

end structural;