## 4-bit ALU (Quartus + ModelSim)

A simple FPGA project that reads two 4-bit operands from switches, performs addition (and includes a logic-ops block), and displays the result on a dual 7-segment display. Built with Intel Quartus Prime; optional simulation with ModelSim.

### Repository layout
- **4bit_ALU/**: All project sources and Quartus files
  - `LogicalStep_Lab2_top.vhd`: Top-level entity
  - `Logic_Processor.vhd`: Logical operations block (AND/OR/XOR/etc.)
  - `full_adder_1bit.vhd`, `full_adder_4bit .vhd`: Ripple-carry adder
  - `segment7_mux.vhd`, `SevenSegment.vhd`, `hex_mux.vhd`: Display encoder and mux
  - `PB_Inverters.vhd`: Inverts active-low pushbuttons
  - `LogicalStep_Lab2.qpf`, `LogicalStep_Lab2_top.qsf`, `LogicalStep_Lab2.tcl`: Quartus project files
  - `Waveform*.vwf`: Example waveform files (optional)

### Top-level overview
- **Entity**: `LogicalStep_Lab2_top`
- **Inputs**
  - `clkin_50`: 50 MHz clock
  - `sw[7:0]`: Board switches. `sw[3:0]` → operand A, `sw[7:4]` → operand B
  - `pb_n[3:0]`: Active-low pushbuttons
- **Outputs**
  - `seg7_data[6:0]`: 7-segment segments
  - `seg7_char1`, `seg7_char2`: Digit enables
  - `leds[3:0]`: LEDs (see note in Known quirks)

### What the design does
- Splits the 8 switches into two 4-bit operands: A = `sw[3:0]`, B = `sw[7:4]`.
- Adds A and B using a 4-bit adder. The sum is shown as two hex digits on the 7-seg:
  - Low digit = `sum[3:0]`
  - High digit = carry (`0` or `1`)
- `segment7_mux` time-multiplexes the two digits using `clkin_50`.
- `PB_Inverters` turns `pb_n` into active-high `pb`.
- `Logic_Processor` computes logic ops on A and B, selected by `pb(1 downto 0)` (not currently routed to outputs by default).

### Build (Quartus Prime)
1. Open Quartus and load the project: `4bit_ALU/LogicalStep_Lab2.qpf`.
2. Ensure the target device matches your board in `Assignments → Device`.
3. Compile the design: `Processing → Start Compilation`.
4. Programming: use the `.sof` in `output_files/` with the Programmer to configure the FPGA over JTAG.

### Simulate (ModelSim)
- Option A: Use Quartus NativeLink to launch ModelSim from the project.
- Option B: Manually create a ModelSim project and add the VHDL files in `4bit_ALU/`.
- Optional waveforms: `4bit_ALU/Waveform*.vwf` can be used with Quartus timing simulation.

### Switches, buttons, and display mapping
- Switches: `sw[3:0]` = A, `sw[7:4]` = B
- Buttons: `pb_n` are active-low; `PB_Inverters` exposes active-high `pb`
- Display: `seg7_data` drives segments; `seg7_char1` and `seg7_char2` select the digit

### Known quirks and suggestions
- In `LogicalStep_Lab2_top.vhd`, `seg7_B` was wired by two sources in the original draft (a conflict). The intended behavior is to use:
  - Low digit: `sum[3:0]` → `seg7_sum`
  - High digit: carry (0/1) → `seg7_B`
- `leds <= seg7_sum` assigns 7 bits to 4 LEDs. Consider mapping LEDs to something 4-bit (e.g., `adder_sum`) or selecting a subset of segments.
- The `Logic_Processor` result `logic_result` is computed but not displayed. Route it to LEDs or the 7-seg if you want to visualize logic ops (e.g., with a button-controlled mux).

### Git hygiene
- Binary/build outputs (Quartus databases, reports, simulation artifacts, `.sof/.pof`, etc.) are excluded from version control.
- Sources and project files are kept: VHDL (`*.vhd`), Quartus project files (`.qpf`, `.qsf`, `.tcl`), and README.

### License
Specify a license if you plan to share or reuse this design.
