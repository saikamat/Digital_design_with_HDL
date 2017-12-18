-- block diagram to VHDL code

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity some_str is
	port (
		A, B: in std_logic;
		Sum: out std_logic
	);
end some_str;

architecture behaviour of some_str is
signal cin, cout: std_logic;
signal count, inv_mux : std_logic_vector(3 downto 0);

procedure FA (
	a,b, cin: in std_logic;
	cout, sum: out std_logic) is
begin
	sum <= a xor b xor cin;
	cout <= (a and b) or (b and cin) or (cin or a);
end FA;
	
begin
	process(clk, reset)
	--variable temp : std_logic_vector(3 downto 0);
	begin
		if (reset = '1') then
			Sum <= '0';
		elsif (rising_edge(clk)) then
			if (inp_mux = '0') then
				cin <= '0';
				FA(A, B, cin, sum);
			else
				--count <= count + 1 mod 3;
				cin <= cout;
				FA(A, B, cin, sum);
			end if;
		end if;
	end process;
	Sum <= sum;
	
	process (clk)
	begin
		if (rising_edge(clk)) then
			if (count = '0') then
				inp_mux <= count;
			else
				count <= count + 1;
			end if;
		end if;
	end process;
			
end behaviour;