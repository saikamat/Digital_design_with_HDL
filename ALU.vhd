library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity FourBitALU is
	port (
		A, B: in std_ulogic_vector(3 downto 0);
		Q: out std_logic_vector(3 downto 0);
		CTRL: in std_logic_vector(2 downto 0);
		cin, reset, Clk: in std_logic;
		Cout: out std_logic
	);
end FourBitALU;

architecture behaviour of FourBitALU is
signal tmp: std_logic_vector(4 downto 0);
-- signal CTRL: std_logic_vector(2 downto 0);
begin
	process (reset, Clk)
	--variable tmp: std_logic_vector(4 downto 0) := (others => '0');
	begin
	if (reset = '0') then -- active low
		Q <= (others => '0');
	elsif (rising_edge(clk)) then
	--process(A,B,CTRL)
	--begin
		case CTRL is
			when "000" =>
				Q <= A(2 downto 0) & cin;
				Cout <=  
			when "001" =>
				Q <= cin & A(3 dowto 1);
				Cout <= 
			when "010" =>
				Q <= A(2 downto 0) & '0';
				Cout <= '0';
			when "011" =>
				Q <= '0' & A(3 dowto 1);
				Cout <= '0';
			when "100" =>
				tmp <= ('0' & A) + ('0' & B) + ("0000" & cin);
				Cout <= tmp(4);
			when "101" =>
				tmp <= ('0' & A) - ('0' & B) - not("0000" & cin);
				Cout <= tmp(4);
			when "110" =>
				tmp <= ('0' & A) + ('0' & B);
				Cout <= '0';	
			when "111" =>
				tmp <= ('0' & A) - ('0' & B);
				Cout <= '0';
			when others =>
				tmp <= (others => '0');
				Cout <= '0';
		end case;
	end if;
	--Q <= tmp(4 downto 0);
	end process;
	Q <= tmp(4 downto 0);
end behaviour