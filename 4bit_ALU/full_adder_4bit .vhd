library ieee;
use ieee.std_logic_1164.all;

Entity full_adder_4bit is port(
						A_in :IN std_logic_vector(3 downto 0);
						B_in :IN std_logic_vector(3 downto 0);
						carry_in_4b : IN std_logic;
						sum_4: OUT std_logic_vector(3 downto 0);
						carry_out: OUT std_logic
						);
						
End full_adder_4bit;


architecture structural of full_adder_4bit is

 component full_adder_1bit
 port(
        input_A  : in  std_logic;
        input_B  : in  std_logic;
        carry_in   : in  std_logic;
       
			sum	 : out std_logic;
			carry_out	 : out std_logic
    );
						
end component ;


signal carry : std_logic_vector(3 downto 0);


begin 


INST1 : full_adder_1bit port map (
		input_A => A_in(0),
		input_B => B_in(0),
		carry_in => carry_in_4b,
		sum => sum_4(0),
		carry_out => carry(0)
);



INST2 : full_adder_1bit port map (
		input_A => A_in(1),
		input_B => B_in(1),
		carry_in => carry(0),
		sum => sum_4(1),
		carry_out => carry(1)
);




INST3 : full_adder_1bit port map (
		input_A => A_in(2),
		input_B => B_in(2),
		carry_in => carry(1),
		sum => sum_4(2),
		carry_out => carry(2)
);

INST4 : full_adder_1bit port map (
		input_A => A_in(3),
		input_B => B_in(3),
		carry_in => carry(1),
		sum => sum_4(3),
		carry_out => carry_out
);

end structural;

