library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned;

entity comp_cond is
	port(
		clk, a,b,c,d: in std_logic;
		q: out std_logic;
		p: out std_logic_vector(1 downto 0)
	);
end comp_cond;

architecture behave of comp_cond is
signal next_q: std_logic;
signal select0, next_p: std_logic_vector(1 downto 0);
begin
	process(select0,a,b,c)
	begin
		if (select0(0)='1') then
			next_q<=a;
		elsif (select0(1)='1') then
			next_q<=b;
			next_p<=select0;
		-- compound conditional test here
		elsif (select0(0)='0' or select0(1)='0') then
			next_q<=c;
			next_p<="00";
		else
			next_q<=c;
			next_p<="00";
		end if;
	end process;
	
	process(clk)
	begin
		if (rising_edge(clk)) then
			q <= next_q;
			p <= next_p;
		end if;
	end process;
end behave;