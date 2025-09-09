library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity LogicalStep_Lab2_top is port (
   clkin_50			: in	std_logic;
	pb_n				: in	std_logic_vector(3 downto 0);
 	sw   				: in  std_logic_vector(7 downto 0); -- The switch inputs
   leds				: out std_logic_vector(3 downto 0); -- for displaying the switch content
   seg7_data 		: out std_logic_vector(6 downto 0); -- 7-bit outputs to a 7-segment
	seg7_char1  	: out 	std_logic;				    		-- seg7 digit1 selector
	seg7_char2  	: out	std_logic				    		-- seg7 digit2 selector
	
); 
end LogicalStep_Lab2_top;



architecture SimpleCircuit of LogicalStep_Lab2_top is

--
-- Components Used ---
------------------------------------------------------------------- 
  component SevenSegment port (
   hex   		:  in  std_logic_vector(3 downto 0);   -- The 4 bit data to be displayed
   sevenseg 	:  out std_logic_vector(6 downto 0)    -- 7-bit outputs to a 7-segment
   ); 
   end component;
	
	component segment7_mux port (
    clk  : in  std_logic := '0';
    DIN2 : in  std_logic_vector(6 downto 0);
    DIN1 : in  std_logic_vector(6 downto 0);
    DOUT : out std_logic_vector(6 downto 0);
    DIG2 : out std_logic;
    DIG1 : out std_logic
);
end component;

	component PB_Inverters port (
			pb_n	: 	in std_logic_vector(3 downto 0);
			pb		: out std_logic_vector(3 downto 0)
		);
	end component;
	
	component Logic_Processor port (
		logic_in0: in  std_logic_vector(3 downto 0);
		logic_in1: in std_logic_vector(3 downto 0);
		select_n: in std_logic_vector(1 downto 0);
		logic_out: out std_logic_vector(3 downto 0)
	);
	end component;
	
	component full_adder_4bit port (
		A_in :IN std_logic_vector(3 downto 0);
		B_in :IN std_logic_vector(3 downto 0);
		carry_in_4b : IN std_logic;
		sum_4: OUT std_logic_vector(3 downto 0);
		carry_out: OUT std_logic
	);
	end component;
	

-- Create any signals, or temporary variables to be used
--
--  std_logic_vector is a signal which can be used for logic operations such as OR, AND, NOT, XOR
--
	signal hex_A		: std_logic_vector(3 downto 0);
	signal hex_B		: std_logic_vector(3 downto 0);

	signal seg7_A		: std_logic_vector(6 downto 0);
	signal seg7_B	, seg7_sum , seg7_mux_out	: std_logic_vector(6 downto 0);
	
	signal pb			: std_logic_vector(3 downto 0);
	
	signal logic_result	: std_logic_vector(3 downto 0);
	
	signal adder_sum		: std_logic_vector(3 downto 0);
	signal adder_carry		: std_logic;
   signal concat		: std_logic_vector(3 downto 0);
	
	signal seg7_muxdin1 : std_logic_vector(6 downto 0);
	signal seg7_muxdin : std_logic_vector(6 downto 0);
	signal seg7_b_inst7 : std_logic_vector(6 downto 0);
	signal sum_high_digit, sum_low_digit : std_logic_vector(3 downto 0);
	
	



	
		
	
-- Here the circuit begins

begin
hex_A <= SW(3 downto 0);
hex_B <= SW(7 downto 4);

--COMPONENT HOOKUP
-- generate the seven segment coding 

--INST1: SevenSegment port map(hex_A, seg7_A);
--INST2: SevenSegment port map(hex_B, seg7_B);

--generate the seven segment multipexer \





INST4 : PB_Inverters port map(pb_n, pb);


sum_low_digit <= adder_sum;
sum_high_digit <= "000" & adder_carry;


INST1: SevenSegment port map(hex_A, seg7_A);
INST2: SevenSegment port map(hex_B, seg7_B);


INST5:  Logic_Processor port map(
					logic_in0 => hex_A,
					logic_in1 => hex_B,
					select_n => pb(1 downto 0),
					logic_out => logic_result
					);
					


--concat <= "000"& adder_carry;



--INST7: SevenSegment port map (concat, seg7_b_inst7);

INST8: SevenSegment port map (sum_low_digit, seg7_sum);
INST9: SevenSegment port map (sum_high_digit, seg7_B);


INST3: segment7_mux port map(clkin_50,seg7_sum,seg7_B,seg7_mux_out,seg7_char1,seg7_char2);


INST6: full_adder_4bit port map (
		A_in => hex_A,
		B_in => hex_B,
		carry_in_4b => '0',
		sum_4 => adder_sum,
		carry_out => adder_carry
);

seg7_data <= seg7_mux_out;
					
					
leds <= seg7_sum;

 
end SimpleCircuit;

