# Advanced-SoC-design Final project (Team6)
The goal of our final project is to develop a **hardware accelerator**, targeting at the application of **Lucas-Kanade (LK) optical-flow method**.  
- We use the C code in [rosetta](https://github.com/cornell-zhang/rosetta/tree/master/optical-flow) as our reference algorithm C, and develop our own HLS code to get a similar but much more real-time result.
- We use Catapult HLS to speed up the design process, and it gives us more flexibility to rearrange the resources.  
- The design process is as follows:
  1. Modify the reference C code into algorithm C
  2. Write HLS code of each module, corresponding to each function in the algorithm C
  3. Run **HLS simulation** to make sure that it has similar results with algorithm C
  4. Do HLS synthesis using Catapult tool, to get RTL code
  5. Integrate the RTL into user_project_2 in FSIC
  6. Run **FSIC simulation** (from Caravel SoC side, as well as from FPGA side)
  7. Run **FSIC-FPGA simulation**
  8. Run **FSIC-FPGA validation**, to get .bit & .hwh files
  9. Upload related files to onlineFPGA, and run on onlineFPGA

<br/>

## How to run simulation & validation
1. To run the **HLS simulation** of the testbench (like lab2), use the following commands:
   ```
   cd /optical_flow_catapult
   make
   cd bin
   source run.sh
   ```
2. To run the **FSIC simulation** of the testbench (like lab1), use the following commands:
   ```
   cd /rtl/user/testbench/tc
   make all
   ```
3. To run the **FSIC-FPGA simulation** of the testbench (like lab4), use the following commands:
   ```
   cd /vivado
   ./run_vivado_fsic_sim
   ```
4. To run the **FSIC-FPGA validation** (like lab4), please follow the following steps:
   1. ```
      cd /vivado
      ./run_vivado_fsic
      ```
   2. Open Vivado GUI, and open project in `/vivado/vvd_caravel_fpga` directory.
   3. 匯入 userDMA 的 Vitis project (已export成 Vivado IP) located in `/vivado/vitis_prj/hls_userdma` directory.
   4. 開啟block design並將 userDMA 加入
   5. 用[這個討論區](https://github.com/bol-edu/HLS-SOC-Discussions/discussions/221)所述的方式接線：「兩條instream跟outstream需要自己手動接到userdmaso跟userdmasir」
   6. Generate bistream
   7. 將產生的.bit及.hwh檔放置於`/vivado/jupyter_notebook_OpticalFlow`資料夾
   8. 上傳相關檔案至 onlineFPGA，如[Github協作repository](https://github.com/whywhytellmewhy/ASoC-Final_project-optical_flow/tree/master/vivado/jupyter_notebook_result)中的README.md的敘述

## References
[1] Reference algorithm C code from [rosetta](https://github.com/cornell-zhang/rosetta/tree/master/optical-flow)  
[2] Performance comparison with [Y. Gong *et al.*, "A Real-Time and Efficient Optical Flow Tracking Accelerator on FPGA Platform," in *IEEE Transactions on Circuits and Systems I: Regular Papers*, vol. 70, no. 12, pp. 4914-4927, Dec. 2023, doi: 10.1109/TCSI.2023.3298969](https://ieeexplore.ieee.org/document/10210198).

