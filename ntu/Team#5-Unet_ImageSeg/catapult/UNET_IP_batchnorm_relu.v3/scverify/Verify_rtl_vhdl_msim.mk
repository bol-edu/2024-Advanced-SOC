# ----------------------------------------------------------------------------
# RTL VHDL output 'rtl.vhdl' vs Untimed C++
#
#    HLS version: 2023.2/1059873 Production Release
#       HLS date: Mon Aug  7 10:54:31 PDT 2023
#  Flow Packages: HDL_Tcl 8.0a, SCVerify 10.4
#
#   Generated by: r12016@cad40
# Generated date: Thu Jun 13 03:09:36 CST 2024
#
# ----------------------------------------------------------------------------
# ===================================================
# DEFAULT GOAL is the help target
.PHONY: all
all: help

# ===================================================
# Directories (at the time this makefile was created)
#   MGC_HOME      /home/raid7_4/raid1_1/linux/mentor/Catapult/2023.2/Mgc_home
#   PROJECT_HOME  /home/raid7_2/user12/r12016/asoc/final/catapult2
#   SOLUTION_DIR  /home/raid7_2/user12/r12016/asoc/final/catapult2/Catapult/UNET_IP_batchnorm_relu.v3
#   WORKING_DIR   /home/raid7_2/user12/r12016/asoc/final/catapult2/Catapult/UNET_IP_batchnorm_relu.v3/.

# ===================================================
# VARIABLES
# 
MGC_HOME          = /home/raid7_4/raid1_1/linux/mentor/Catapult/2023.2/Mgc_home
export MGC_HOME

WORK_DIR  = $(CURDIR)
WORK2PROJ = ../..
WORK2SOLN = .
PROJ2WORK = ./Catapult/UNET_IP_batchnorm_relu.v3
PROJ2SOLN = ./Catapult/UNET_IP_batchnorm_relu.v3
export WORK_DIR
export WORK2PROJ
export WORK2SOLN
export PROJ2WORK
export PROJ2SOLN

# Variables that can be overridden from the make command line
ifeq "$(INCL_DIRS)" ""
INCL_DIRS                   = ./scverify . ../.. /home/raid7_2/user12/r12016/asoc/final/hls
endif
export INCL_DIRS
ifeq "$(STAGE)" ""
STAGE                       = rtl
endif
export STAGE
ifeq "$(NETLIST_LEAF)" ""
NETLIST_LEAF                = rtl
endif
export NETLIST_LEAF
ifeq "$(SIMTOOL)" ""
SIMTOOL                     = msim
endif
export SIMTOOL
ifeq "$(NETLIST)" ""
NETLIST                     = vhdl
endif
export NETLIST
ifeq "$(RTL_NETLIST_FNAME)" ""
RTL_NETLIST_FNAME           = /home/raid7_2/user12/r12016/asoc/final/catapult2/Catapult/UNET_IP_batchnorm_relu.v3/rtl.vhdl
endif
export RTL_NETLIST_FNAME
ifeq "$(INVOKE_ARGS)" ""
INVOKE_ARGS                 = 
endif
export INVOKE_ARGS
ifeq "$(FAMILY)" ""
FAMILY                      = zynq
endif
export FAMILY
export SCVLIBS
export MODELSIM
TOP_HDL_ENTITY           := UNET_IP_batchnorm_relu
TOP_DU                   := scverify_top
CXX_TYPE                 := gcc
MSIM_SCRIPT              := ./Catapult/UNET_IP_batchnorm_relu.v3/scverify_msim.tcl
TARGET                   := scverify/$(NETLIST_LEAF)_$(NETLIST)_$(SIMTOOL)
export TOP_HDL_ENTITY
export TARGET

ifeq ($(RECUR),)
ifeq ($(STAGE),mapped)
ifeq ($(RTLTOOL),)
   $(error This makefile requires specifying the RTLTOOL variable on the make command line)
endif
endif
endif
# ===================================================
# Include environment variables set by flow options
include ./ccs_env.mk

# ===================================================
# Include makefile for default commands and variables
include $(MGC_HOME)/shared/include/mkfiles/ccs_default_cmds.mk

SYNTHESIS_FLOWPKG := Vivado
SYN_FLOW          := Vivado
# ===================================================
# SOURCES
# 
# Specify list of Questa SIM libraries to create
HDL_LIB_NAMES = mgc_hls work
# ===================================================
# Simulation libraries required by loaded Catapult libraries or gate simulation
SIMLIBS_V   += 
SIMLIBS_VHD += 
# 
# 
# Specify list of source files - MUST be ordered properly
ifeq ($(STAGE),gate)
ifeq ($(RTLTOOL),)
# Unless overridden on make command line, GATE_*_DEP is the last item in the netlist dependency list
ifeq ($(GATE_VHDL_DEP),)
GATE_VHDL_DEP = ./rtl.vhdl/rtl.vhdl_10.vhdlts
endif
ifeq ($(GATE_VLOG_DEP),)
GATE_VLOG_DEP = 
endif
endif
VHDL_SRC += $(MGC_HOME)/pkgs/siflibs/mgc_io_sync_v2.vhd/mgc_io_sync_v2.vhd.vhdlts $(MGC_HOME)/pkgs/hls_pkgs/src/funcs.vhd/funcs.vhd.vhdlts $(MGC_HOME)/pkgs/hls_pkgs/mgc_comps_src/mgc_comps.vhd/mgc_comps.vhd.vhdlts $(MGC_HOME)/pkgs/hls_pkgs/mgc_comps_src/mgc_div_beh.vhd/mgc_div_beh.vhd.vhdlts $(MGC_HOME)/pkgs/siflibs/mgc_shift_comps_v5.vhd/mgc_shift_comps_v5.vhd.vhdlts $(MGC_HOME)/pkgs/siflibs/mgc_shift_bl_beh_v5.vhd/mgc_shift_bl_beh_v5.vhd.vhdlts ../td_ccore_solutions/leading_sign_22_0_dc00658b4b4575636e73bb7f99c473ff6c07_0/rtl.vhdl/rtl.vhdl.vhdlts $(MGC_HOME)/pkgs/siflibs/mgc_shift_l_beh_v5.vhd/mgc_shift_l_beh_v5.vhd.vhdlts ./rtl_UNET_IP_batchnorm_relumgc_rom_11_736_5_1.vhdl/rtl_UNET_IP_batchnorm_relumgc_rom_11_736_5_1.vhdl.vhdlts ./rtl_UNET_IP_batchnorm_relumgc_rom_12_736_4_1.vhdl/rtl_UNET_IP_batchnorm_relumgc_rom_12_736_4_1.vhdl.vhdlts $(GATE_VHDL_DEP) ./scverify/ccs_wrapper_UNET_IP_batchnorm_relu.vhdl/ccs_wrapper_UNET_IP_batchnorm_relu.vhdl.vhdlts
VLOG_SRC +=  $(GATE_VLOG_DEP) 
else
VHDL_SRC += $(MGC_HOME)/pkgs/siflibs/mgc_io_sync_v2.vhd/mgc_io_sync_v2.vhd.vhdlts $(MGC_HOME)/pkgs/hls_pkgs/src/funcs.vhd/funcs.vhd.vhdlts $(MGC_HOME)/pkgs/hls_pkgs/mgc_comps_src/mgc_comps.vhd/mgc_comps.vhd.vhdlts $(MGC_HOME)/pkgs/hls_pkgs/mgc_comps_src/mgc_div_beh.vhd/mgc_div_beh.vhd.vhdlts $(MGC_HOME)/pkgs/siflibs/mgc_shift_comps_v5.vhd/mgc_shift_comps_v5.vhd.vhdlts $(MGC_HOME)/pkgs/siflibs/mgc_shift_bl_beh_v5.vhd/mgc_shift_bl_beh_v5.vhd.vhdlts ../td_ccore_solutions/leading_sign_22_0_dc00658b4b4575636e73bb7f99c473ff6c07_0/rtl.vhdl/rtl.vhdl.vhdlts $(MGC_HOME)/pkgs/siflibs/mgc_shift_l_beh_v5.vhd/mgc_shift_l_beh_v5.vhd.vhdlts ./rtl_UNET_IP_batchnorm_relumgc_rom_11_736_5_1.vhdl/rtl_UNET_IP_batchnorm_relumgc_rom_11_736_5_1.vhdl.vhdlts ./rtl_UNET_IP_batchnorm_relumgc_rom_12_736_4_1.vhdl/rtl_UNET_IP_batchnorm_relumgc_rom_12_736_4_1.vhdl.vhdlts ./rtl.vhdl/rtl.vhdl_10.vhdlts ./scverify/ccs_wrapper_UNET_IP_batchnorm_relu.vhdl/ccs_wrapper_UNET_IP_batchnorm_relu.vhdl.vhdlts
VLOG_SRC += 
endif
CXX_SRC  = ./scverify/mc_testbench.cpp/mc_testbench.cpp.cxxts ./scverify/scverify_top.cpp/scverify_top.cpp.cxxts
# Specify RTL synthesis scripts (if any)
RTL_SCRIPT = 

# Specify hold time file name (for verifying synthesized netlists)
HLD_CONSTRAINT_FNAME = top_gate_constraints.cpp

# ===================================================
# GLOBAL OPTIONS
# 
# CXXFLAGS - global C++ options (apply to all C++ compilations) except for include file search paths
CXXFLAGS += $(COMPILERFLAGS) -DCCS_SCVERIFY -DSC_INCLUDE_DYNAMIC_PROCESSES -DSC_USE_STD_STRING -DTOP_HDL_ENTITY=$(TOP_HDL_ENTITY) -DCCS_DESIGN_FUNC_UNET_IP_batchnorm_relu_run_batch -DCCS_DESIGN_TOP_$(TOP_HDL_ENTITY) -DCCS_MISMATCHED_OUTPUTS_ONLY $(F_WRAP_OPT)
# 
# If the make command line includes a definition of the special variable MC_DEFAULT_TRANSACTOR_LOG
# then define that value for all compilations as well
ifneq "$(MC_DEFAULT_TRANSACTOR_LOG)" ""
CXXFLAGS += -DMC_DEFAULT_TRANSACTOR_LOG=$(MC_DEFAULT_TRANSACTOR_LOG)
endif
# 
# CXX_INCLUDES - include file search paths
CXX_INCLUDES = ./scverify . ../.. /home/raid7_2/user12/r12016/asoc/final/hls
# 
# TCL shell
TCLSH_CMD = /home/raid7_4/raid1_1/linux/mentor/Catapult/2023.2/Mgc_home/bin/tclsh8.5

# Pass along SCVerify_DEADLOCK_DETECTION option
ifneq "$(SCVerify_DEADLOCK_DETECTION)" "false"
CXXFLAGS += -DDEADLOCK_DETECTION
endif
# ===================================================
# PER SOURCE FILE SPECIALIZATIONS
# 
# Specify source file paths
$(TARGET)/mgc_io_sync_v2.vhd.vhdlts: $(MGC_HOME)/pkgs/siflibs/mgc_io_sync_v2.vhd
$(TARGET)/funcs.vhd.vhdlts: $(MGC_HOME)/pkgs/hls_pkgs/src/funcs.vhd
$(TARGET)/mgc_comps.vhd.vhdlts: $(MGC_HOME)/pkgs/hls_pkgs/mgc_comps_src/mgc_comps.vhd
$(TARGET)/mgc_div_beh.vhd.vhdlts: $(MGC_HOME)/pkgs/hls_pkgs/mgc_comps_src/mgc_div_beh.vhd
$(TARGET)/mgc_shift_comps_v5.vhd.vhdlts: $(MGC_HOME)/pkgs/siflibs/mgc_shift_comps_v5.vhd
$(TARGET)/mgc_shift_bl_beh_v5.vhd.vhdlts: $(MGC_HOME)/pkgs/siflibs/mgc_shift_bl_beh_v5.vhd
$(TARGET)/rtl.vhdl.vhdlts: ../td_ccore_solutions/leading_sign_22_0_dc00658b4b4575636e73bb7f99c473ff6c07_0/rtl.vhdl
$(TARGET)/mgc_shift_l_beh_v5.vhd.vhdlts: $(MGC_HOME)/pkgs/siflibs/mgc_shift_l_beh_v5.vhd
$(TARGET)/rtl_UNET_IP_batchnorm_relumgc_rom_11_736_5_1.vhdl.vhdlts: ./rtl_UNET_IP_batchnorm_relumgc_rom_11_736_5_1.vhdl
$(TARGET)/rtl_UNET_IP_batchnorm_relumgc_rom_12_736_4_1.vhdl.vhdlts: ./rtl_UNET_IP_batchnorm_relumgc_rom_12_736_4_1.vhdl
$(TARGET)/rtl.vhdl_10.vhdlts: ./rtl.vhdl
$(TARGET)/ccs_wrapper_UNET_IP_batchnorm_relu.vhdl.vhdlts: ./scverify/ccs_wrapper_UNET_IP_batchnorm_relu.vhdl
ifeq ($(STAGE),gate)
ifneq ($(GATE_VHDL_DEP),)
$(TARGET)/$(notdir $(GATE_VHDL_DEP)): $(dir $(GATE_VHDL_DEP))
endif
ifneq ($(GATE_VLOG_DEP),)
$(TARGET)/$(notdir $(GATE_VLOG_DEP)): $(dir $(GATE_VLOG_DEP))
endif
endif
$(TARGET)/mc_testbench.cpp.cxxts: ./scverify/mc_testbench.cpp
$(TARGET)/scverify_top.cpp.cxxts: ./scverify/scverify_top.cpp
# 
# Specify additional C++ options per C++ source by setting CXX_OPTS
$(TARGET)/scverify_top.cpp.cxxts: CXX_OPTS=
$(TARGET)/mc_testbench.cpp.cxxts: CXX_OPTS=$(F_WRAP_OPT)
# 
# Specify dependencies
$(TARGET)/mc_testbench.cpp.cxxts: .ccs_env_opts/SCVerify_USE_CCS_BLOCK.ts
$(TARGET)/scverify_top.cpp.cxxts: .ccs_env_opts/SCVerify_USE_CCS_BLOCK.ts .ccs_env_opts/SCVerify_DEADLOCK_DETECTION.ts
# 
# Specify compilation library for HDL source
$(TARGET)/funcs.vhd.vhdlts: HDL_LIB=mgc_hls
$(TARGET)/mgc_comps.vhd.vhdlts: HDL_LIB=mgc_hls
$(TARGET)/mgc_shift_comps_v5.vhd.vhdlts: HDL_LIB=mgc_hls
$(TARGET)/rtl.vhdl.vhdlts: HDL_LIB=work
$(TARGET)/mgc_shift_l_beh_v5.vhd.vhdlts: HDL_LIB=mgc_hls
$(TARGET)/mgc_io_sync_v2.vhd.vhdlts: HDL_LIB=mgc_hls
$(TARGET)/mgc_shift_bl_beh_v5.vhd.vhdlts: HDL_LIB=mgc_hls
$(TARGET)/rtl_UNET_IP_batchnorm_relumgc_rom_11_736_5_1.vhdl.vhdlts: HDL_LIB=mgc_hls
$(TARGET)/rtl_UNET_IP_batchnorm_relumgc_rom_12_736_4_1.vhdl.vhdlts: HDL_LIB=mgc_hls
$(TARGET)/ccs_wrapper_UNET_IP_batchnorm_relu.vhdl.vhdlts: HDL_LIB=work
$(TARGET)/rtl.vhdl_10.vhdlts: HDL_LIB=work
$(TARGET)/mgc_div_beh.vhd.vhdlts: HDL_LIB=mgc_hls
ifeq ($(STAGE),gate)
ifneq ($(GATE_VHDL_DEP),)
$(TARGET)/$(notdir $(GATE_VHDL_DEP)): HDL_LIB=work
$(TARGET)/$(notdir $(GATE_VHDL_DEP)): DUT_E=leading_sign_22_0
endif
ifneq ($(GATE_VLOG_DEP),)
$(TARGET)/$(notdir $(GATE_VLOG_DEP)): HDL_LIB=work
$(TARGET)/$(notdir $(GATE_VLOG_DEP)): DUT_E=leading_sign_22_0
endif
endif
# 
# Specify additional HDL source compilation options if any
$(TARGET)/funcs.vhd.vhdlts: VHDL_F_OPTS=
$(TARGET)/mgc_comps.vhd.vhdlts: VHDL_F_OPTS=
$(TARGET)/mgc_shift_comps_v5.vhd.vhdlts: VHDL_F_OPTS=
$(TARGET)/rtl.vhdl.vhdlts: VHDL_F_OPTS=
$(TARGET)/mgc_shift_l_beh_v5.vhd.vhdlts: VHDL_F_OPTS=
$(TARGET)/mgc_io_sync_v2.vhd.vhdlts: VHDL_F_OPTS=
$(TARGET)/mgc_shift_bl_beh_v5.vhd.vhdlts: VHDL_F_OPTS=
$(TARGET)/rtl_UNET_IP_batchnorm_relumgc_rom_11_736_5_1.vhdl.vhdlts: VHDL_F_OPTS=
$(TARGET)/rtl_UNET_IP_batchnorm_relumgc_rom_12_736_4_1.vhdl.vhdlts: VHDL_F_OPTS=
$(TARGET)/ccs_wrapper_UNET_IP_batchnorm_relu.vhdl.vhdlts: VHDL_F_OPTS=
$(TARGET)/rtl.vhdl_10.vhdlts: VHDL_F_OPTS=
$(TARGET)/mgc_div_beh.vhd.vhdlts: VHDL_F_OPTS=
# 
# Specify top design unit for HDL source
$(TARGET)/ccs_wrapper_UNET_IP_batchnorm_relu.vhdl.vhdlts: DUT_E=ccs_wrapper
$(TARGET)/rtl.vhdl.vhdlts: DUT_E=leading_sign_22_0
$(TARGET)/rtl.vhdl_10.vhdlts: DUT_E=UNET_IP_batchnorm_relu

# Specify top design unit
$(TARGET)/ccs_wrapper_UNET_IP_batchnorm_relu.vhdl.vhdlts: VHDL_TOP=1

ifneq "$(RTLTOOL)" ""
# ===================================================
# Include makefile for RTL synthesis
include $(MGC_HOME)/shared/include/mkfiles/ccs_$(RTLTOOL).mk
else
# ===================================================
# Include makefile for simulator
include $(MGC_HOME)/shared/include/mkfiles/ccs_questasim.mk
endif

