**4-bit ALU (Quartus )**

An FPGA project that takes two 4-bit operands from board switches, performs addition and simple logic operations, and shows the result on a dual 7-segment display. Built with Intel Quartus Prime and optionally simulated in ModelSim.

Repository Contents

LogicalStep_Lab2_top.vhd: Top-level entity

Logic_Processor.vhd: Logic operations (AND/OR/XOR/etc.)

full_adder_1bit.vhd, full_adder_4bit.vhd: Ripple-carry adder

segment7_mux.vhd, SevenSegment.vhd, hex_mux.vhd: Display drivers

PB_Inverters.vhd: Converts active-low pushbuttons

Quartus project files (.qpf, .qsf, .tcl)

Example waveform files (Waveform*.vwf)

**How It Works**

Switches provide two 4-bit inputs (A and B).

A ripple-carry adder computes A + B.

Sum and carry are displayed on two 7-segment digits.

Logic operations can also be applied using pushbuttons.
