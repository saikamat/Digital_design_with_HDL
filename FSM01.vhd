library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned;

entity FSM01 is
	port(
		reset, clk, k: in std_logic;
		q: out std_logic	
	);
end FSM01;

--output depends on current state and input, since Mealy machine
architecture behaviour of FSM01 is
type state_type is (E0, E1);
signal pres_st, next_st: state_type;
begin
	process(pres_st, k)
	begin
		case pres_st is
			when E0 =>
				if (k = '0') then
					next_st <= E1;
					q <= '1';
				else
					next_st <= E0;
					q <= '0';
				end if;
			when E1 =>
				if (k = '0') then
					next_st <= E1;
					q <= '1';
				else
					next_st <= E0;
					q <= '0';
				end if;
			when others =>
				next_st <= E0;
				q<= '0';
		end case;
	end process;
	
	process(clk, reset)
	begin
		if (reset = '1') then
			pres_st <= E0;
		elsif (rising_edge(clk)) then
			pres_st <= next_st;
		end if;
	end process;
end behaviour;

