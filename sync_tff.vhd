library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned;

entity sync_tff is
	port(
		clk, reset, d: in std_logic;
		q: out std_logic;
	);
end sync_tff;

architecture behave of sync_tff is
signal t: std_logic;
begin
	process(clk)
	begin
		if (rising_edge(clk))
				if (reset = '1')
					t <= '0';
				else
					t <= not t;
				end if;
		end if;
	end process;
	q <= t;
end behave;