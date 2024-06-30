# HDR ISP
## Introduction
* This is the final project of Advanced SOC Design at NTHU, Spring 2024.
* Author: NTHU Team 7.
  * Team Leader: 張傑閔
  * Team Member: 蔡宗頴
## Brief description about the project
* HDR ISP is an image signal processor for HDR camera.
  * The original algorithm C model is [Image Signal Process For HDR CMOS Image Sensor](https://github.com/JokerEyeAdas/HDR-ISP).
  * It contains 17 modules for ISP pipeline.
  * Pixels are flowed from one module to another through the ISP pipeline without any additional memory to store them.
* HDR ISP Pipeline:
  ![image](https://github.com/roy-tsai-tw/Advanced_SOC_Design/blob/main/Lab5_6_Final_Project/doc/HDRISPpipeline.png)
* Development steps: 
  * Rewrite the algorithm C model to suit the Catapult implementation flow (from XXX.cpp to XXX.h).
  * Mapping algorithms to architectures for every modules. (Done.)
  * Unit C-sim, and C/RTL co-sim test for individual module. (Done.)
  * Integrate C-sim, and C/RTL co-sim test for top module.
  * Integrate RTL into FSIC user project.
  * FSIC-FPGA Simualtion and Validation.
  * Synopsys Flow.
## Folder structure
* doc/
  * final-project-presentation_Team7.pdf (Presentation slides)
  * report_Team7.pdf (Report)
  * (Reference papers)
  * HDRISPpipeline.png (Figures)
* src/
  * HLS/
    * bin/ (executable folder for top module)
    * cmodel/ (algorithm C model)
    * data/ (test data)
    * hls_c/ (HLS C model)
      * bin/ (executable folder for single module)
      * inc/ (HLS C model modules)
      * scripts/ (Catapult HLS C model directives)
      * src/ (C TB for unit C-sim, C/RTL co-simulation test)
  * RTL/
  * TB/
  * Jupyter_notebook/
* test/
  * 1920x1080_Raw10.raw
  * connan_raw14.raw
  * DSC_1339_768x512_rggb.raw
  * input.raw
  * input_xkISP.raw
  * test.RAW
* catapult.tcsh
## Build Setup – how to rebuild the result
### Environment variables settings
```
source catapult.tcsh
```
### Tool versions
* HLS Tool:
  * Catapult HLS: 2024.1
* FSIC-FPGA Related Tool:
  * Ubuntu 20.04+
  * Xilinx Vitis 2022.1
  * GTKWave v3.3.103
  * RISC-V GCC Toolchains rv32i-4.0.0
* Synopsys Flow Tool:
  * Design Compiler:
  * IC Compiler II:
  * IC Validator:
  * Formality:
  * PrimeTime:
  * StarRC:
### Steps to build/download test data, configuration
* N/A
### Steps for FPGA bitstream generation
* N/A
## Run test
### Unit test
```
cd src/HLS/hls_c
(change Makefile to set the module you want to test)
make
cd bin
./run_tb.sh
```
### Integration test 
```
cd src/HLS/hls_c
(change Makefile to set the top module)
make
cd bin
./run_tb.sh
```
