--Write VHDL Code for a 1-digit Synchronous BCD counter. The counter
--should be able to count both upwards and downwards, controlled by the input
--Up_nDown (1=Up, 0=Down). The counter should have an asynchronous Reset
--(active high) that sets the counter to 0. The counter should also have an (active
--high) Count Enable signal (CE). When Count Enable is active, the counter
--increases its value with one. When Count Enable is not active, it should hold its
--present value. The counter should also have an (active high) Load Enable signal,
--to load new values from the Din input. In case the loaded value is out of range, it
--should load the value zero instead. Load enable should have priority over Count
--Enable.


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity BitBCD is
	port(
		clk, reset, Up_nDown, CE, LE: in std_logic;
		din: in std_logic_vector(3 downto 0); -- since BCD is from 0000 to 1001.
		--q: out std_logic;
		q: out std_logic_vector(3 downto 0)
	);
end BitBCD;

architecture behaviour of BitBCD is
signal count: std_logic_vector(3 downto 0);
begin
process(clk, reset)
	begin
		if (reset = '1') then
			--Q <= (others => '0');
			count <= (others => '0');
		elsif (rising_edge(clk)) then
			if (LE = '1') then -- since LE has higher priority than CE
				--count <= din + 1 mod 3;
				-- how to load zero, when overflow?
				-- since BCD ranges from 0000B to 1001B then
				if (din > 9) then
					count <= (others => '0');
				else
					count <= din;
			-- what's the else for LE? -- handled by elsif of CE
				end if;
			--if (CE = '1') then
			elsif (CE = '1') then		
				if (Up_nDown = '1') then
					if (count = 9) then
						count <= (others => '0');
					else
						count <= count + 1;
					end if;
				else
					if (count = 0) then
						count <= "1001"; -- counter down counts from 9
					else
						count <= count - 1;
					end if;
				end if;
			--else
				--count <= count; -- hold onto value
			end if;
		end if;
	end process;
	q <= count;
			
end behaviour;