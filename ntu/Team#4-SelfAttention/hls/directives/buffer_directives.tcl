//  Catapult Ultra Synthesis 2023.2/1059873 (Production Release) Mon Aug  7 10:54:31 PDT 2023
//  
//          Copyright (c) Siemens EDA, 1996-2023, All Rights Reserved.
//                        UNPUBLISHED, LICENSED SOFTWARE.
//             CONFIDENTIAL AND PROPRIETARY INFORMATION WHICH IS THE
//                   PROPERTY OF SIEMENS EDA OR ITS LICENSORS.
//  
//  Running on Linux b08092@cad29.ee.ntu.edu.tw 2.6.32-754.35.1.el6.x86_64 x86_64 aol
//  
//  Package information: SIFLIBS v26.2_0.0, HLS_PKGS v26.2_0.0, 
//                       SIF_TOOLKITS v26.2_0.0, SIF_XILINX v26.2_0.0, 
//                       SIF_ALTERA v26.2_0.0, CCS_LIBS v26.2_0.0, 
//                       CDS_PPRO v2023.1, CDS_DesignChecker v2023.2, 
//                       CDS_OASYS v21.1_3.1, CDS_PSR v23.1_1.18, 
//                       DesignPad v2.78_1.0
//  
solution new -state initial
solution options defaults
solution options set /OnTheFly/VthAttributeType cell_lib
solution options set /Input/TargetPlatform x86_64
solution options set /Input/SearchPath /home/raid7_2/userb08/b08092/asoc_final_v3/c_sourcecode
solution options set /Output/GenerateCycleNetlist false
solution options set /Flows/SCVerify/INVOKE_ARGS ./database/in_data.txt
solution file add ./c_sourcecode/attention.h -type CHEADER
solution file add ./c_testbench/attention_tb.cpp -type C++ -exclude true
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
go analyze
solution design set ATTENTION_IP::Attention_Top -block
solution design set ATTENTION_IP::Attention_Buffer -top
go compile
solution library add nangate-45nm_beh -- -rtlsyntool DesignCompiler -vendor Nangate -technology 045nm
solution library add ccs_sample_mem
go libraries
directive set -CLOCKS {clk {-CLOCK_PERIOD 10.0 -CLOCK_EDGE rising -CLOCK_UNCERTAINTY 0.0 -CLOCK_HIGH_TIME 5.0 -RESET_SYNC_NAME rst -RESET_ASYNC_NAME arst_n -RESET_KIND both -RESET_SYNC_ACTIVE high -RESET_ASYNC_ACTIVE low -ENABLE_ACTIVE high}}
go assembly
directive set /ATTENTION_IP::Attention_Buffer -RESET_CLEARS_ALL_REGS no
directive set /ATTENTION_IP::Attention_Buffer/head:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /ATTENTION_IP::Attention_Buffer/length:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /ATTENTION_IP::Attention_Buffer/dim:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /ATTENTION_IP::Attention_Buffer/din_chan:rsc -MAP_TO_MODULE ccs_ioport.ccs_in_wait_coupled
directive set /ATTENTION_IP::Attention_Buffer/q_chan1:rsc -MAP_TO_MODULE ccs_ioport.ccs_out_wait
directive set /ATTENTION_IP::Attention_Buffer/q_chan1:rsc -EXTERNAL_MEMORY true
directive set /ATTENTION_IP::Attention_Buffer/q_chan1:rsc -PACKING_MODE sidebyside
directive set /ATTENTION_IP::Attention_Buffer/q_chan1 -WORD_WIDTH 1024
directive set /ATTENTION_IP::Attention_Buffer/k_chan1:rsc -MAP_TO_MODULE ccs_ioport.ccs_out_wait
directive set /ATTENTION_IP::Attention_Buffer/k_chan1:rsc -EXTERNAL_MEMORY true
directive set /ATTENTION_IP::Attention_Buffer/k_chan1:rsc -PACKING_MODE sidebyside
directive set /ATTENTION_IP::Attention_Buffer/k_chan1 -WORD_WIDTH 1024
directive set /ATTENTION_IP::Attention_Buffer/v_chan1:rsc -MAP_TO_MODULE ccs_ioport.ccs_out_wait
directive set /ATTENTION_IP::Attention_Buffer/v_chan1:rsc -EXTERNAL_MEMORY true
directive set /ATTENTION_IP::Attention_Buffer/v_chan1:rsc -PACKING_MODE sidebyside
directive set /ATTENTION_IP::Attention_Buffer/v_chan1 -WORD_WIDTH 1024
directive set /ATTENTION_IP::Attention_Buffer/run/channel_in.data:rsc -MAP_TO_MODULE {[Register]}
go architect
go extract
