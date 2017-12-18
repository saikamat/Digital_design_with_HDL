-- block diagram to VHDL code

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity BSM is
	port(
		A, B: in std_logic_vector(3 downto 0);
		clk, reset: in std_logic;
		P: out std_logic
	);
end BSM;

architecture behaviour of BSM is
signal count : std_logic_vector(1 downto 0);
signal Cout, Cin, prod: std_logic_vector(3 downto 0);

-- procedure - VIMP for full adder
	procedure FA (
		a, b, cin: in std_logic;
		cout, sum: out std_logic) is
	begin
		sum <= a xor b xor cin;
		cout <= (a and b) or (b and cin) or (cin and a);
	end FA;
	
	begin
	process (clk, reset)
	begin
		-- external asynchronous master reset
		if (reset = '1') then
			count <= "00";
		elsif (rising_edge(clk)) then
			count <= count + 1;
			if (count = 3) then
				prod <= (others => '0');
				count <= (others => '0');	-- reset the counter.
			end if;
		end if;
	end process;
		
	-- synchronous reset for the 4 D flip flops
	process (clk)
	variable qAND: std_logic := '0';
	begin
		if (rising_edge(clk)) then
			for i in 0 downto 3 loop
				qAND := A(i) and B(count);
				if (i = 3) then
					FA('0', qAND, Cin(i), Cout(i), prod(i));
				else
					FA(prod(i-1), qAND, Cin(i), Cout(i), prod(i));
				end if;
			end loop;
		end if;
	end process;
	
	P <= prod(0);
end behaviour;