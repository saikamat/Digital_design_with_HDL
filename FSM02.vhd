entity FSM02 is
	port(
		i, clk, reset: in std_logic;
		q: std_logic
	);
end FSM02;

architecture behave of FSM02 is
--declare states first
type state_type is (E0, E10, E11, E20, E21);
signal pres_st, next_st: state_type;


begin
	process(pres_st)
	begin
		case pres_st is
			when E0 =>
				if (i = '0') then
					q <= '0';
					next_st <= E10;
				else
					q <= '1';
					next_st <= E21;
			when E10 =>
				if (i = '0') then
					q <= '1';
					next_st <= E0;
				else
					q <= '1';
					next_st <= E20;
			when E11 =>
				if (i = '0') then
					q <= '1';
					next_st <= E0;
				else
					q <= '1';
					next_st <= E21;
			when E20 =>
				if (i = '0') then
					q <= '0';
					next_st <= E10;
				else
					q <= '0';
					next_st <= E0;
			when E21 =>
				if (i = '0') then
					q <= '0';
					next_st <= E11;
				else
					q <= '0';
					next_st <= E0;
			when others
					q <= '0';
					next_st <= E0;
		end case;
	end process;
	
	process(clk, reset)
	begin
		if (reset = '1') then
			pres_st <= E0;
		elsif (clk'event and clk = '1') then
			pres_st <= next_st;
		end if;
	end process;
end behave;