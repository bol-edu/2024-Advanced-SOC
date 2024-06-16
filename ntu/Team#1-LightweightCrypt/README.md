# Advanced-SoC-Design Final Project

## Introduction
This is the ASoC Final project ASCON Encryption accelerator on PYNQ-Z2.

## Folder structure

```shell
Final/
|--README.md                        # Overview of this project
|--doc/                             # Documentation files
|----report.pdf
|----slides.pptx
|--src/                             # Source files
|----Encrypt.h
|----Encrypt_tb.cpp                 # HLS files
|----concat_rtl.v
|----fsic_tb.sv
|----user_prj0.v
|----vvd_caravel_fpga_fsic.tcl
|----vvd_caravel_fpga_fsic_sim.tcl  # FPGA simulation and synthesis files
|----caravel_fpga.bit
|----caravel_fpga.hwh
|----caravel_fpga_fsic.ipynb        # Jupyter notebook files
```

## Build setup
+ Tool version : Vitis HLS 2022.1, Vivado 2022.1
+ Build step:
  + Run Catapult to generate the concat_rtl.v from Encrypt.h and Encrypt_tb.cpp
  + Clone the fsic_fpga repository from [bol-edu/fsic_fpga](https://github.com/bol-edu/fsic_fpga), and put the user_prj0.v, concat_rtl.v and fsicv_tb.sv
  + Get the caravel_fpga.bit and caravel_fpga.hwh after synthesis, then put them on to PYNQ-Z2 with caravel_fpga_fsic.ipynb
