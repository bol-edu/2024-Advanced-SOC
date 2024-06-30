# ASoC_final

Build step:

1.gen rtl :

Run Catapult to generate the concat_rtl.v(we named it concat_rtl_less_lat.v) from catapult.h and tb.c (aes_enc)

2.integrate fsic and fpga sim:

Clone the fsic_fpga repository from bol-edu/fsic_fpga, and put the user_prj0.v, concat_rtl.v(we named it concat_rtl_less_lat.v) and fsic_tb.sv

3.fpga vali:
Get the caravel_fpga.bit and caravel_fpga.hwh after synthesis, then put them on to PYNQ-Z2 with caravel_fpga_fsic.ipynb
