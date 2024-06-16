# written for flow package Vivado 
set sdc_version 1.7 

create_clock -name clk -period 10.0 -waveform { 0.0 5.0 } [get_ports {clk}]
set_clock_uncertainty 0.0 [get_clocks {clk}]

create_clock -name virtual_io_clk -period 10.0
## IO TIMING CONSTRAINTS
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {rst}]
set_max_delay 10.0 -from [all_inputs] -to [all_outputs]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {input_rsc_radr[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {input_rsc_re}]
set_input_delay -clock [get_clocks {clk}] 0.66 [get_ports {input_rsc_q[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {input_rsc_clken}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {input_triosy_lz}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {padded_input_rsc_wadr[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {padded_input_rsc_d[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {padded_input_rsc_we}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {padded_input_rsc_radr[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {padded_input_rsc_re}]
set_input_delay -clock [get_clocks {clk}] 3.06 [get_ports {padded_input_rsc_q[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {padded_input_rsc_clken}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {padded_input_triosy_lz}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {output_rsc_wadr[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {output_rsc_d[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {output_rsc_we}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {output_rsc_clken}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {output_triosy_lz}]
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {height[*]}]
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {width[*]}]
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {kernel_size[*]}]
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {padding[*]}]
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {filter_offset[*]}]
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {in_channels[*]}]
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {out_channels[*]}]

