library ieee;
use ieee.std_logic_1164.all;

entity full_adder_1bit is
    port(
        input_A  : in  std_logic;
        input_B  : in  std_logic;
        carry_in   : in  std_logic;
       
			sum	 : out std_logic;
			carry_out	 : out std_logic
    );
end full_adder_1bit;


architecture behaviour of full_adder_1bit is

Begin

sum<= input_A XOR input_B XOR carry_in;

carry_out<= ( input_A AND input_B) OR (carry_in  AND (input_A XOR  input_B));


End behaviour;