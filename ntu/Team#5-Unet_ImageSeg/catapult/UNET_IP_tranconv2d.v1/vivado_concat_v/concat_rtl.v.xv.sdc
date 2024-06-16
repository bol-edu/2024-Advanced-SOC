# written for flow package Vivado 
set sdc_version 1.7 

create_clock -name clk -period 10.0 -waveform { 0.0 5.0 } [get_ports {clk}]
set_clock_uncertainty 0.0 [get_clocks {clk}]

create_clock -name virtual_io_clk -period 10.0
## IO TIMING CONSTRAINTS
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {rst}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {input_rsc_radr[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {input_rsc_re}]
set_input_delay -clock [get_clocks {clk}] 3.06 [get_ports {input_rsc_q[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {input_triosy_lz}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {output_rsc_wadr[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {output_rsc_d[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {output_rsc_we}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {output_rsc_radr[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {output_rsc_re}]
set_input_delay -clock [get_clocks {clk}] 3.06 [get_ports {output_rsc_q[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {output_triosy_lz}]
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {height_rsc_dat[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {height_triosy_lz}]
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {width_rsc_dat[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {width_triosy_lz}]
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {kernel_size_rsc_dat[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {kernel_size_triosy_lz}]
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {filter_offset_rsc_dat[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {filter_offset_triosy_lz}]
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {in_channels_rsc_dat[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {in_channels_triosy_lz}]
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {out_channels_rsc_dat[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {out_channels_triosy_lz}]
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {stride_rsc_dat[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {stride_triosy_lz}]

