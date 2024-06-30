############################################################
## This file is generated automatically by Vitis HLS.
## Please DO NOT edit it.
## Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
## Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
############################################################
open_project hls_userdma
set_top userdma
add_files userdma.cpp
add_files userdma.h
open_solution "solution1" -flow_target vivado
set_part {xc7z020-clg400-1}
create_clock -period 10 -name default
config_export -format ip_catalog -output /home/ricky/asoc/final_project/fsic_fpga/vivado/vitis_prj/hls_userdma -rtl verilog -vivado_clock 10
source "./hls_userdma/solution1/directives.tcl"
#csim_design
csynth_design
#cosim_design
export_design -rtl verilog -format ip_catalog -output /home/ricky/asoc/final_project/fsic_fpga/vivado/vitis_prj/hls_userdma
