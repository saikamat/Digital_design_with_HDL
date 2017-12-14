%%D flip flop - asynchronous reset
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity D_FF is
port(
	d, clock: in std_logic;
	q: out std_logic
	);
end D_FF;

architecture behaviorial of D_FF is
begin
process(clock)
begin
if (clock = '1' and clock'event) then
q<=d;
end if;
end process;
end behaviorial;


%%half adder
entity half_adder is 
port(
	a,b: in std_logic;
	sum, carry: out std_logic;
)
end half_adder;

%%structural flow of half adder
architecture structural_HA of half_adder is

component xor1
port(
	p,q: in std_logic;
	r: out std_logic;
)

