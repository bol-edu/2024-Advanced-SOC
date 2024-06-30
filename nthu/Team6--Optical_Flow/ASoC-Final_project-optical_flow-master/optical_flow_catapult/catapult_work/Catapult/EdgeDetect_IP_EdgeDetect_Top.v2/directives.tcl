//  Catapult Ultra Synthesis 2023.1/1033555 (Production Release) Mon Feb 13 11:32:25 PST 2023
//  
//          Copyright (c) Siemens EDA, 1996-2023, All Rights Reserved.
//                        UNPUBLISHED, LICENSED SOFTWARE.
//             CONFIDENTIAL AND PROPRIETARY INFORMATION WHICH IS THE
//                   PROPERTY OF SIEMENS EDA OR ITS LICENSORS.
//  
//  Running on Linux m111061545@ws41 3.10.0-1160.95.1.el7.x86_64 x86_64 aol
//  
//  Package information: SIFLIBS v26.1_0.0, HLS_PKGS v26.1_0.0, 
//                       SIF_TOOLKITS v26.1_0.0, SIF_XILINX v26.1_0.0, 
//                       SIF_ALTERA v26.1_0.0, CCS_LIBS v26.1_0.0, 
//                       CDS_PPRO v2022.1_1, CDS_DesigChecker v2023.1, 
//                       CDS_OASYS v21.1_2.5, CDS_PSR v22.2_0.9, 
//                       DesignPad v2.78_1.0
//  
solution new -state initial
solution options defaults
solution options set /Input/TargetPlatform x86_64
solution options set /Input/SearchPath {../hls_c/inc ../cmodel/inc ../bmpUtil/inc}
solution options set /Output/OutputVHDL false
solution options set /Output/GenerateCycleNetlist false
solution options set /Flows/SCVerify/INVOKE_ARGS {./image/people_gray.bmp out_algorithm.bmp out_hw.bmp}
solution options set /Flows/SCVerify/INCL_DIRS {../hls_c/inc ../cmodel/inc ../bmpUtil/inc}
solution options set /Flows/VSCode/INSTALL /bin
flow package require /VSCode
solution file add ../hls_c/inc/EdgeDetect.h -type CHEADER
solution file add ../hls_c/src/EdgeDetect_tb.cpp -type C++ -exclude true
solution file add ../bmpUtil/src/bmp_io.cpp -type C++ -exclude true
directive set -DESIGN_GOAL area
directive set -SPECULATE true
directive set -MERGEABLE true
directive set -REGISTER_THRESHOLD 256
directive set -MEM_MAP_THRESHOLD 32
directive set -LOGIC_OPT false
directive set -FSM_ENCODING none
directive set -FSM_BINARY_ENCODING_THRESHOLD 64
directive set -REG_MAX_FANOUT 0
directive set -NO_X_ASSIGNMENTS true
directive set -SAFE_FSM false
directive set -REGISTER_SHARING_MAX_WIDTH_DIFFERENCE 8
directive set -REGISTER_SHARING_LIMIT 0
directive set -ASSIGN_OVERHEAD 0
directive set -TIMING_CHECKS true
directive set -MUXPATH true
directive set -REALLOC true
directive set -UNROLL no
directive set -IO_MODE super
directive set -CHAN_IO_PROTOCOL use_library
directive set -ARRAY_SIZE 1024
directive set -IDLE_SIGNAL {}
directive set -STALL_FLAG_SV off
directive set -STALL_FLAG false
directive set -TRANSACTION_DONE_SIGNAL true
directive set -DONE_FLAG {}
directive set -READY_FLAG {}
directive set -START_FLAG {}
directive set -TRANSACTION_SYNC ready
directive set -RESET_CLEARS_ALL_REGS use_library
directive set -CLOCK_OVERHEAD 20.000000
directive set -ON_THE_FLY_PROTOTYPING false
directive set -OPT_CONST_MULTS use_library
directive set -CHARACTERIZE_ROM false
directive set -PROTOTYPE_ROM true
directive set -ROM_THRESHOLD 64
directive set -CLUSTER_ADDTREE_IN_WIDTH_THRESHOLD 0
directive set -CLUSTER_ADDTREE_IN_COUNT_THRESHOLD 0
directive set -CLUSTER_OPT_CONSTANT_INPUTS true
directive set -CLUSTER_RTL_SYN false
directive set -CLUSTER_FAST_MODE false
directive set -CLUSTER_TYPE combinational
directive set -PROTOTYPING_ENGINE oasys
directive set -PIPELINE_RAMP_UP true
go new
solution design set EdgeDetect_IP::EdgeDetect_VerDer -block
solution design set EdgeDetect_IP::EdgeDetect_Top -top
solution design set EdgeDetect_IP::EdgeDetect_HorDer -block
solution design set EdgeDetect_IP::EdgeDetect_MagAng -block
go analyze
solution design set EdgeDetect_IP::EdgeDetect_VerDer -block
solution design set EdgeDetect_IP::EdgeDetect_Top -top
solution design set EdgeDetect_IP::EdgeDetect_HorDer -block
solution design set EdgeDetect_IP::EdgeDetect_MagAng -block
go compile
solution library add mgc_Xilinx-ZYNQ-1_beh -- -rtlsyntool Vivado -manufacturer Xilinx -family ZYNQ -speed -1 -part xc7z020clg400-1
solution library add Xilinx_RAMS
solution library add Xilinx_FIFO
go libraries
go libraries