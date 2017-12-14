library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned;

entity sync_dff is
	port(
		clk, reset, d: in std_logic;
		q: out std_logic;
	);
end sync_dff;

architecture behave of sync_dff is
begin
	process(clk)
	begin
		if (rising_edge(clk))
				if (reset = '1')
					q <= '0';
				else
					q <= d;
				end if;
		end if;
	end process;
end behave;