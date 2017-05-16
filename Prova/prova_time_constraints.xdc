# Time Constraints to Project Prova PCR
# Jessé Barreto de Barros
# Artix7 xdc
# define clock and period
create_clock -period 11.0 -name clk_pin -waveform {0.000 5.5} [get_ports clk]

# Create a virual clock for IO constraints
create_clock -period 11.0 -name virtual_clock

# input delay
set_input_delay -clock clk_pin 0 [get_ports reset]
set_input_delay -clock clk_pin -min -0.5 [get_ports reset]

set_input_delay -clock clk_pin 0 [get_ports start]
set_input_delay -clock clk_pin -min -0.5 [get_ports start]

set_input_delay -clock clk_pin 0 [get_ports fillCovs]
set_input_delay -clock clk_pin -min -0.5 [get_ports fillCovs]

set_input_delay -clock virtual_clock -max 0.0 [get_ports yUl[*]]
set_input_delay -clock virtual_clock -min -0.5 [get_ports yUl[*]]

set_input_delay -clock virtual_clock -max 0.0 [get_ports yIr[*]]
set_input_delay -clock virtual_clock -min -0.5 [get_ports yIr[*]]

set_input_delay -clock virtual_clock -max 0.0 [get_ports initCovK[*]]
set_input_delay -clock virtual_clock -min -0.3 [get_ports initCovZ[*]]

#output delay
set_output_delay -clock virtual_clock 0 [get_ports xFusion[*]]
set_output_delay -clock virtual_clock 0 [get_ports xUl[*]]
set_output_delay -clock virtual_clock 0 [get_ports xIr[*]]
set_output_delay -clock virtual_clock 0 [get_ports ready]