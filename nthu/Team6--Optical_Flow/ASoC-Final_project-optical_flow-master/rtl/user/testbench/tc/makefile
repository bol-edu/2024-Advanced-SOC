.PHONY: all
# to run optical flow simulation using xsim (modified from /bol-edu/fsic_fpga/rtl/user/testbench/tc/makefile)
all:
#	xvlog -sv -i ../ ../tb_fsic.v -f filelist \
#      -d USE_skywater_SRAM \
#      -d USE_OPTICAL_FLOW_IP \
#      -d USER_PROJECT_SIDEBAND_SUPPORT 
	xvlog -sv -i ../ ../tb_fsic.v -f filelist \
      -d USE_skywater_SRAM \
      -d USE_EDGEDETECT_IP \
      -d USER_PROJECT_SIDEBAND_SUPPORT 
	xelab tb_fsic -debug typical --snapshot tb_fsic_xelab --timescale 1ns/1ns
	xsim tb_fsic_xelab --tclbatch log_wave.tcl

.PHONY: vsim
# to run optical flow simulation using vsim (modified from /ZheChen-Bill/ASoC_catapult/lab2_edgedetect/fsic/testbench/vsim/run_vsim)
vsim:
	rm -rf work
	# Compile Verilog files using Questa's vlog
	vlog +define+USER_PROJECT_SIDEBAND_SUPPORT +define+USE_EDGEDETECT_IP -sv -work work ../tb_fsic.v -f filelist
	
	#vopt opt is created
	#vopt tb_fsic -o opt +acc
	vopt tb_fsic -o opt +acc -debug +designfile

	# rum vsim
	#vsim opt -do log_wave.tcl
	vsim opt -c -qwavedb=+signal+memory=4096,1

	#quit
	#quit -sim

	#view wave form
	#vsim vsim.wlf

.PHONY: clean
clean:	
	- rm *.log *.jou *.wdb
	- rm -rf xsim.dir



