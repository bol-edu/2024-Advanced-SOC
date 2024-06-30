###### EECS24 109020014 Cheng-Hao, Lee

## 1. Catapult HLS
### Modify the control signal
#### In Catapult_HLS/hls_c/src/EdgeDetect_tb.cpp 
      EdgeDetect_tb(94) : To modify ctrl signal of Denoise Filter 
      EdgeDetect_tb(95) : To modify ctrl signal of EdgeDetect Filter 

### Modify the testing image
#### In Catapult_HLS/bin/run.sh 
      run(1) : ./image/$(change the image you want).bmp 


### Simulation 
```shell
cd Catapult_HLS
make
cd bin/
sh run.sh
```



## 2. FSIC-SIM
### 1. Spec
* #### IP port

| IP port                                  | Connected Wire | BitWidth | I/O | Description |
| ---------------------------------------- | -------------- | -------- | --- | ----------- |
| clk                                      |                | [0:0]    | I   |             |
| rst                                      |                | [0:0]    | I   |             |
| arst_n                                   |                | [0:0]    | I   | not used    |
| dat_in_rsc_dat                           |                | [7:0]    | I   |             |
| dat_in_rsc_vld                           |                | [0:0]    | I   |             |
| dat_in_rsc_rdy                           |                | [0:0]    | O   |             |
| widthIn                                  |                | [10:0]   | I   |             |
| heightIn                                 |                | [9:0]    | I   |             |
| dat_out_rsc_dat                          |                | [7:0]    | O   |             |
| dat_out_rsc_vld                          |                | [0:0]    | O   |             |
| dat_out_rsc_rdy                          |                | [0:0]    | I   |             |
| ctrl_denoise_rsc_dat                     |                | [1:0]    | I   |             |
| ctrl_denoise_triosy_lz                   |                | [0:0]    | O   |             |
| ctrl_edgedect_rsc_dat                    |                | [1:0]    | I   |             |
| ctrl_edgedect_triosy_lz                  |                | [0:0]    | O   |             |
| line_buf0_rsc_Denoise_inst_en            |                | [0:0]    | O   |             |
| line_buf0_rsc_Denoise_inst_q             |                | [15:0]   | I   |             |
| line_buf0_rsc_Denoise_inst_we            |                | [0:0]    | O   |             |
| line_buf0_rsc_Denoise_inst_d             |                | [15:0]   | O   |             |
| line_buf0_rsc_Denoise_inst_adr           |                | [9:0]    | O   |             |
| line_buf1_rsc_Denoise_inst_en            |                | [0:0]    | O   |             |
| line_buf1_rsc_Denoise_inst_q             |                | [15:0]   | I   |             |
| line_buf1_rsc_Denoise_inst_we            |                | [0:0]    | O   |             |
| line_buf1_rsc_Denoise_inst_d             |                | [15:0]   | O   |             |
| line_buf1_rsc_Denoise_inst_adr           |                | [9:0]    | O   |             |
| line_buf0_rsc_EdgeDetect_Filter_inst_en  |                | [0:0]    | O   |             |
| line_buf0_rsc_EdgeDetect_Filter_inst_q   |                | [15:0]   | I   |             |
| line_buf0_rsc_EdgeDetect_Filter_inst_we  |                | [0:0]    | O   |             |
| line_buf0_rsc_EdgeDetect_Filter_inst_d   |                | [15:0]   | O   |             |
| line_buf0_rsc_EdgeDetect_Filter_inst_adr |                | [9:0]    | O   |             |
| line_buf1_rsc_EdgeDetect_Filter_inst_en  |                | [0:0]    | O   |             |
| line_buf1_rsc_EdgeDetect_Filter_inst_q   |                | [15:0]   | I   |             |
| line_buf1_rsc_EdgeDetect_Filter_inst_we  |                | [0:0]    | O   |             |
| line_buf1_rsc_EdgeDetect_Filter_inst_d   |                | [15:0]   | O   |             |
| line_buf1_rsc_EdgeDetect_Filter_inst_adr |                | [9:0]    | O   |             |

* #### Register Map
| Register          | WordOffset | StartBit | Length | ResetVal | Access | HADDRS | description                                                                |     |
| ----------------- | ---------- | -------- | ------ | -------- | ------ | ------ | -------------------------------------------------------------------------- | --- |
| reg_rst           | 0          | 0        | [0:0]  | 0        | R/W    | 00     | 1: reset edgedetect IP                                                     |     |
| reg_widthIn       | 1          | 0        | [10:0] | 640      | R/W    | 04     | frame width                                                                |     |
| reg_heightIn      | 2          | 0        | [9:0]  | 480      | R/W    | 08     | frame height                                                               |     |
| reg_ctrl_denoise  | 3          | 0        | [1:0]  | 0        | R/W    | 0C     | 0: Bypass Mode <br/>1: Gaussion Filter<br/>2:Median Filter                 |     |
| reg_ctrl_edgedect | 4          | 0        | [1:0]  | 0        | R/W    | 10     | 0: Bypass Mode <br/>1: Laplacian Filter<br/>2: Sobel Filter                |     |
| reg_IP_done       | 5          | 0        | [0:0]  | 0        | R/W    | 14     | Read it for checking if a frame is done. Write it for clearing this signal |     |

### 2. Simulation

We simulate FSIC-SIM using the same repo as  [lab2-2](https://github.com/bol-edu/caravel-soc_fpga-lab/tree/main/fsic-sim/fsic_fpga).

```shell
# Prepare test pattern
cd final

rm -f fsic_sim/rtl/user/testbench/tc/pattern/*
cp misc/PATTERN/*.hex fsic_sim/rtl/user/testbench/tc/pattern/
```

```shell
# Create a clean fsic_sim folder
cd final && rm -rf fsic_sim

git clone --filter=blob:none --no-checkout https://github.com/bol-edu/caravel-soc_fpga-lab
cd caravel-soc_fpga-lab/
git sparse-checkout set --cone
git checkout main
git sparse-checkout set fsic-sim/fsic_fpga
cd ../ && mv caravel-soc_fpga-lab/fsic-sim/fsic_fpga fsic_sim && rm -rf caravel-soc_fpga-lab

# copy the rtl design from catapult/
rm -f fsic_sim/rtl/user/user_subsys/user_prj/user_prj0/rtl/* 
cp catapult/rtl/concat_rtl.v misc/FSICSIM/rtl.f misc/FSICSIM/spram.v misc/FSICSIM/user_prj0.v fsic_sim/rtl/user/user_subsys/user_prj/user_prj0/rtl/

# copy the testbench from misc/
cp misc/FSICSIM/tb_fsic.v fsic_sim/rtl/user/testbench/tb_fsic.v && cp misc/FSICSIM/filelist fsic_sim/rtl/user/testbench/tc/filelist

# run simulation
cd fsic_sim/rtl/user/testbench/tc/
bash ./run_xsim
cd ../../../../../



```


## 4. FSIC-FPGA

```shell
# Prepare test pattern
cd final

mkdir fsic_fpga/vivado/pattern
cp misc/PATTERN/*.hex fsic_fpga/vivado/pattern
```

```shell
# Generate the rtl design of hls_userdma
cp misc/FSICFPGA/userdma.h misc/FSICFPGA/userdma.cpp misc/FSICFPGA/script.tcl fsic_fpga/vivado/vitis_prj/hls_userdma

# Run vitis_hls
cd fsic_fpga/vivado/vitis_prj/hls_userdma 
vitis_hls -f script.tcl
cd ../../../../
```

```shell
# Create a clean fsic_sim folder
rm -rf fsic_fpga
git clone https://github.com/bol-edu/fsic_fpga

# copy the rtl design from catapult/
rm -f fsic_fpga/vivado/vvd_srcs/caravel_soc/rtl/user/user_subsys/user_prj/user_prj0/rtl/* 
cp catapult/rtl/concat_rtl.v misc/FSICFPGA/rtl.f misc/FSICFPGA/spram.v misc/FSICFPGA/user_prj0.v fsic_fpga/vivado/vvd_srcs/caravel_soc/rtl/user/user_subsys/user_prj/user_prj0/rtl/

# copy the testbench from misc/
cp misc/FSICFPGA/fsic_tb.sv fsic_fpga/vivado

# copy the TCL file
cp misc/FSICFPGA/vvd_caravel_fpga_fsic_sim.tcl fsic_fpga/vivado

# run simulation
cd fsic_fpga/vivado
bash ./run_vivado_fsic_sim
cd ../../

# view waveform
cd fsic_fpga/vivado
bash ./open_wave
cd ../../

```

## 5. FSIC-FPGA impl

```shell
# copy the TCL file
cd final
cp misc/FSICFPGA/vvd_caravel_fpga_fsic.tcl fsic_fpga/vivado

# run implementation
cd fsic_fpga/vivado
bash ./run_vivado_fsic
cd ../../

# copy runtime files
cp misc/FSICFPGA/caravel_fpga_fsic.ipynb fsic_fpga/testbench/fsic/fsic.hex fsic_fpga/vivado/jupyter_notebook
mkdir fsic_fpga/vivado/jupyter_notebook/pattern
cp misc/PATTERN/*.hex fsic_fpga/vivado/jupyter_notebook/pattern
```
Then you should upload files in `final/fsic_fpga/vivado/jupyter_notebook` to jupyter notebook, containing `caravel_fpga_fsic.ipynb`,  `caravel_fpga.bit`, `caravel_fpga.hwh`, `fsic.hex` and the folder `pattern`.

Note that, you can modify the image size and ctrl signal in `caravel_fpga_fsic.ipynb`
