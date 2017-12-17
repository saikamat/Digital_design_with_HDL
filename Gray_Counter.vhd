--Write VHDL Code for a Synchronous 4-bit Gray counter. The counter should be able to count both upwards and downwards, controlled by the input Up_nDown (1=Up, 0=Down). The counter should have an asynchronous Reset that sets the counter to 0. The counter should also have an active low Count Enable signal (CE). When Count Enable is active, the counter increases its value with one. When Count Enable is not active, it holds its present value.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity gray_counter is
	port(
		reset, clk, CE, Up_nDown: in std_logic;
		q: out std_logic_vector(3 downto 0)
	);
end gray_counter;

architecture behavior of gray_counter is
-- declare counter of width 4 bits
signal counter : std_logic_vector(3 downto 0);

-- initialize an array...IMPORTANT DECLARATION
type gray_counter_vector is array (natural range<>) of std_logic_vector(3 downto 0); -- set the array size

-- declaring constants:
--constant <user_defined_name>: type_of_constant (optional size range) := <values>
-- fill with values, from truth table
constant gray_code: gray_counter_vector(0 to 15) := ( 							
"0000",
"0001",
"0011",
"0010",
"0110",
"0111",
"0101",
"0100",
"1100",
"1101",
"1111",
"1110",
"1010",
"1011",
"1001",
"1000"
);

begin
	process(clk, reset)
	begin
		-- asynchronous reset, resets the counter to 0
		if (reset = '1') then
			counter <= (others => '0');
		elsif (clk'event and clk = '1') then
			-- count enable is active low, and hence active
			if (CE = '0') then
				if (Up_nDown = '1') then
					counter <= counter + 1;
				else
					counter <= counter - 1;
				end if;
			end if;
		end if;
	end process;
	
	--whatever value of counter is, at this instance, be assigned to the output, with appropriate conversions, of course.
	q <= gray_code.conv_integer(counter);
end behavior;			
			