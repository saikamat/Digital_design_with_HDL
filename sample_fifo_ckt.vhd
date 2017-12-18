library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity sample_fifo_ckt is
	port(
		A,B,clk, reset: in std_logic;
		--Q: out std_logic_vector(3 downto 0)
		Q: out std_logic
	);
end sample_fifo_ckt;

architecture behavior of sample_fifo_ckt is
--declare signals
-- let's have a sample signal of 4 bytes called fifo
--signal fifo: std_logic_vector(3 downto 0);
signal fifo: std_logic_vector(4 downto 0);
begin
	process(clk, reset)
	begin
		if (reset = '1') then
			--Q <= (others => '0');
			fifo <= (others => '0');
		elsif (rising_edge(clk)) then
			-- real shit starts here
			fifo(0) <= fifo(3);
			fifo(1) <= B xor (A xor fifo(0));
			fifo(2) <= fifo(1);
			fifo(3) <= fifo(2); -- added later
			--fifo(3) <= fifo(2) xor fifo(0);
			fifo(4) <= fifo(3) xor fifo(0);
		end if;
	end process;
	--q <= fifo;
	Q <= fifo(1);
end behavior;