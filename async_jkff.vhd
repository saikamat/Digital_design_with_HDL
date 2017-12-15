library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned;
use ieee.std_log_arith;

entity async_jkff is
	port(
		clk, reset, j, k: in std_logic;
		q: out std_logic;
	);
end async_jkff;

architecture behave of async_jkff is
signal qsig: std_logic;
signal jksig: std_logic_vector(1 downto 0);
begin
	process(clk)
	begin
		if (reset = '1') then
			q <= '0';
		elsif (rising_edge(clk)) then
			case (jksig) is
				when "00" =>
					qsig <= qsig;
				when "01" =>
					qsig <= '0';
				when "10" =>
					qsig <= '1';
				when "11" =>
					qsig <= not qsig;
				when others =>
					qsig <= qsig;
			end case;
		end if;
	end process;
	q <= qsig;
end behave;