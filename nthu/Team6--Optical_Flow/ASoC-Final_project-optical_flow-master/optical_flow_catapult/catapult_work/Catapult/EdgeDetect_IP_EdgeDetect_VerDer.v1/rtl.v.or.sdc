# written for flow package OasysRTL 
set sdc_version 1.7 

set_operating_conditions typical
set_load 11.40290 [all_outputs]
## driver/slew constraints on inputs
set data_inputs [list dat_in_rsc_vld {dat_in_rsc_dat[*]} dat_out_rsc_rdy dy_rsc_rdy {widthIn[*]} {heightIn[*]} {line_buf0_rsc_q[*]} {line_buf1_rsc_q[*]}]
set_driving_cell -no_design_rule -library NangateOpenCellLibrary -lib_cell DFF_X1 -pin Q $data_inputs
set_units -time ns
# time_factor: 1.0

create_clock -name clk -period 10.0 -waveform { 0.0 5.0 } [get_ports {clk}]
set_clock_uncertainty 0.0 [get_clocks {clk}]

create_clock -name virtual_io_clk -period 10.0
## IO TIMING CONSTRAINTS
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {rst}]
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {dat_in_rsc_dat[*]}]
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {dat_in_rsc_vld}]
set_max_delay 10.0 -from [all_inputs] -to [all_outputs]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {dat_in_rsc_rdy}]
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {widthIn[*]}]
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {heightIn[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {dat_out_rsc_dat[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {dat_out_rsc_vld}]
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {dat_out_rsc_rdy}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {dy_rsc_dat[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {dy_rsc_vld}]
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {dy_rsc_rdy}]
set_output_delay -clock [get_clocks {clk}] 0.01 [get_ports {line_buf0_rsc_en}]
set_input_delay -clock [get_clocks {clk}] 0.5 [get_ports {line_buf0_rsc_q[*]}]
set_output_delay -clock [get_clocks {clk}] 0.01 [get_ports {line_buf0_rsc_we}]
set_output_delay -clock [get_clocks {clk}] 0.01 [get_ports {line_buf0_rsc_d[*]}]
set_output_delay -clock [get_clocks {clk}] 0.01 [get_ports {line_buf0_rsc_adr[*]}]
set_output_delay -clock [get_clocks {clk}] 0.01 [get_ports {line_buf1_rsc_en}]
set_input_delay -clock [get_clocks {clk}] 0.5 [get_ports {line_buf1_rsc_q[*]}]
set_output_delay -clock [get_clocks {clk}] 0.01 [get_ports {line_buf1_rsc_we}]
set_output_delay -clock [get_clocks {clk}] 0.01 [get_ports {line_buf1_rsc_d[*]}]
set_output_delay -clock [get_clocks {clk}] 0.01 [get_ports {line_buf1_rsc_adr[*]}]

