## hls_userdma
See [vivado/vitis_prj/hls_userdma/userdma.cpp](vivado/vitis_prj/hls_userdma/userdma.cpp) 

## firmware code
### build steps
> [!NOTE]
> RISC-V GCC Toolchain is needed.
```bash
cd testbench/fsic
./run_fw
```
generated files:
- fsic.coe
    - Firmware file used for simulation
- fsic.hex
    - Firmware file used for JupyterNotebook firmware loading
## Caravel-FSIC FPGA Simulation
```bash
cd vivado
./run_vivado_fsic_sim
```

## Caravel-FSIC FPGA Validation
### building .bit & .hwh
```bash
cd vivado
./run_vivado_fsic
```
### files needed for running jupyter notebook
- vivado/jupyter_notebook/caravel_fpga_fsic.ipynb
- vivado/jupyter_notebook/caravel_fpga.bit
- vivado/jupyter_notebook/caravel_fpga.hwh
- vivado/p.txt
- testbench/fsic/fsic.hex




## Reference
See https://github.com/bol-edu/fsic_fpga for more information.

