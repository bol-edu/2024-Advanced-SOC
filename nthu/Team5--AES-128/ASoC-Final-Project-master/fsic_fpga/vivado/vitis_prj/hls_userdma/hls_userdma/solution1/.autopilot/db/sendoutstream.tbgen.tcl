set moduleName sendoutstream
set isTopModule 0
set isCombinational 0
set isDatapathOnly 0
set isPipelined 0
set pipeline_type none
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set hasInterrupt 0
set DLRegFirstOffset 0
set DLRegItemOffset 0
set C_modelName {sendoutstream}
set C_modelType { void 0 }
set C_modelArgList {
	{ outbuf int 33 regular {fifo 0 volatile }  }
	{ in_en_clrsts int 1 regular {fifo 0}  }
	{ m2s_buf_sts int 1 regular {pointer 1}  }
	{ outStreamTop_V_data_V int 32 regular {axi_s 1 volatile  { outStreamTop Data } }  }
	{ outStreamTop_V_keep_V int 4 regular {axi_s 1 volatile  { outStreamTop Keep } }  }
	{ outStreamTop_V_strb_V int 4 regular {axi_s 1 volatile  { outStreamTop Strb } }  }
	{ outStreamTop_V_user_V int 7 regular {axi_s 1 volatile  { outStreamTop User } }  }
	{ outStreamTop_V_last_V int 1 regular {axi_s 1 volatile  { outStreamTop Last } }  }
}
set hasAXIMCache 0
set AXIMCacheInstList { }
set C_modelArgMapList {[ 
	{ "Name" : "outbuf", "interface" : "fifo", "bitwidth" : 33, "direction" : "READONLY"} , 
 	{ "Name" : "in_en_clrsts", "interface" : "fifo", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "m2s_buf_sts", "interface" : "wire", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "outStreamTop_V_data_V", "interface" : "axis", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "outStreamTop_V_keep_V", "interface" : "axis", "bitwidth" : 4, "direction" : "WRITEONLY"} , 
 	{ "Name" : "outStreamTop_V_strb_V", "interface" : "axis", "bitwidth" : 4, "direction" : "WRITEONLY"} , 
 	{ "Name" : "outStreamTop_V_user_V", "interface" : "axis", "bitwidth" : 7, "direction" : "WRITEONLY"} , 
 	{ "Name" : "outStreamTop_V_last_V", "interface" : "axis", "bitwidth" : 1, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 26
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_continue sc_in sc_logic 1 continue -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ outbuf_dout sc_in sc_lv 33 signal 0 } 
	{ outbuf_num_data_valid sc_in sc_lv 7 signal 0 } 
	{ outbuf_fifo_cap sc_in sc_lv 7 signal 0 } 
	{ outbuf_empty_n sc_in sc_logic 1 signal 0 } 
	{ outbuf_read sc_out sc_logic 1 signal 0 } 
	{ in_en_clrsts_dout sc_in sc_lv 1 signal 1 } 
	{ in_en_clrsts_num_data_valid sc_in sc_lv 3 signal 1 } 
	{ in_en_clrsts_fifo_cap sc_in sc_lv 3 signal 1 } 
	{ in_en_clrsts_empty_n sc_in sc_logic 1 signal 1 } 
	{ in_en_clrsts_read sc_out sc_logic 1 signal 1 } 
	{ m2s_buf_sts sc_out sc_lv 1 signal 2 } 
	{ m2s_buf_sts_ap_vld sc_out sc_logic 1 outvld 2 } 
	{ outStreamTop_TDATA sc_out sc_lv 32 signal 3 } 
	{ outStreamTop_TVALID sc_out sc_logic 1 outvld 7 } 
	{ outStreamTop_TREADY sc_in sc_logic 1 outacc 7 } 
	{ outStreamTop_TKEEP sc_out sc_lv 4 signal 4 } 
	{ outStreamTop_TSTRB sc_out sc_lv 4 signal 5 } 
	{ outStreamTop_TUSER sc_out sc_lv 7 signal 6 } 
	{ outStreamTop_TLAST sc_out sc_lv 1 signal 7 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_continue", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "continue", "bundle":{"name": "ap_continue", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "outbuf_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":33, "type": "signal", "bundle":{"name": "outbuf", "role": "dout" }} , 
 	{ "name": "outbuf_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":7, "type": "signal", "bundle":{"name": "outbuf", "role": "num_data_valid" }} , 
 	{ "name": "outbuf_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":7, "type": "signal", "bundle":{"name": "outbuf", "role": "fifo_cap" }} , 
 	{ "name": "outbuf_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "outbuf", "role": "empty_n" }} , 
 	{ "name": "outbuf_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "outbuf", "role": "read" }} , 
 	{ "name": "in_en_clrsts_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "in_en_clrsts", "role": "dout" }} , 
 	{ "name": "in_en_clrsts_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "in_en_clrsts", "role": "num_data_valid" }} , 
 	{ "name": "in_en_clrsts_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "in_en_clrsts", "role": "fifo_cap" }} , 
 	{ "name": "in_en_clrsts_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "in_en_clrsts", "role": "empty_n" }} , 
 	{ "name": "in_en_clrsts_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "in_en_clrsts", "role": "read" }} , 
 	{ "name": "m2s_buf_sts", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "m2s_buf_sts", "role": "default" }} , 
 	{ "name": "m2s_buf_sts_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "m2s_buf_sts", "role": "ap_vld" }} , 
 	{ "name": "outStreamTop_TDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "outStreamTop_V_data_V", "role": "default" }} , 
 	{ "name": "outStreamTop_TVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "outStreamTop_V_last_V", "role": "default" }} , 
 	{ "name": "outStreamTop_TREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "outacc", "bundle":{"name": "outStreamTop_V_last_V", "role": "default" }} , 
 	{ "name": "outStreamTop_TKEEP", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "outStreamTop_V_keep_V", "role": "default" }} , 
 	{ "name": "outStreamTop_TSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "outStreamTop_V_strb_V", "role": "default" }} , 
 	{ "name": "outStreamTop_TUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":7, "type": "signal", "bundle":{"name": "outStreamTop_V_user_V", "role": "default" }} , 
 	{ "name": "outStreamTop_TLAST", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "outStreamTop_V_last_V", "role": "default" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1", "3", "4", "5", "6", "7"],
		"CDFG" : "sendoutstream",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "-1", "EstimateLatencyMax" : "-1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "outbuf", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["0"], "DependentChan" : "0", "DependentChanDepth" : "64", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_sendoutstream_Pipeline_VITIS_LOOP_128_1_fu_71", "Port" : "outbuf", "Inst_start_state" : "2", "Inst_end_state" : "3"}]},
			{"Name" : "in_en_clrsts", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["0"], "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "in_en_clrsts_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "m2s_buf_sts", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "outStreamTop_V_data_V", "Type" : "Axis", "Direction" : "O", "BaseName" : "outStreamTop",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_sendoutstream_Pipeline_VITIS_LOOP_128_1_fu_71", "Port" : "outStreamTop_V_data_V", "Inst_start_state" : "2", "Inst_end_state" : "3"}]},
			{"Name" : "outStreamTop_V_keep_V", "Type" : "Axis", "Direction" : "O", "BaseName" : "outStreamTop",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_sendoutstream_Pipeline_VITIS_LOOP_128_1_fu_71", "Port" : "outStreamTop_V_keep_V", "Inst_start_state" : "2", "Inst_end_state" : "3"}]},
			{"Name" : "outStreamTop_V_strb_V", "Type" : "Axis", "Direction" : "O", "BaseName" : "outStreamTop",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_sendoutstream_Pipeline_VITIS_LOOP_128_1_fu_71", "Port" : "outStreamTop_V_strb_V", "Inst_start_state" : "2", "Inst_end_state" : "3"}]},
			{"Name" : "outStreamTop_V_user_V", "Type" : "Axis", "Direction" : "O", "BaseName" : "outStreamTop",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_sendoutstream_Pipeline_VITIS_LOOP_128_1_fu_71", "Port" : "outStreamTop_V_user_V", "Inst_start_state" : "2", "Inst_end_state" : "3"}]},
			{"Name" : "outStreamTop_V_last_V", "Type" : "Axis", "Direction" : "O", "BaseName" : "outStreamTop",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_sendoutstream_Pipeline_VITIS_LOOP_128_1_fu_71", "Port" : "outStreamTop_V_last_V", "Inst_start_state" : "2", "Inst_end_state" : "3"}]}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.grp_sendoutstream_Pipeline_VITIS_LOOP_128_1_fu_71", "Parent" : "0", "Child" : ["2"],
		"CDFG" : "sendoutstream_Pipeline_VITIS_LOOP_128_1",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "-1", "EstimateLatencyMax" : "-1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "outbuf", "Type" : "Fifo", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "outbuf_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "outStreamTop_V_data_V", "Type" : "Axis", "Direction" : "O", "BaseName" : "outStreamTop",
				"BlockSignal" : [
					{"Name" : "outStreamTop_TDATA_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "outStreamTop_V_keep_V", "Type" : "Axis", "Direction" : "O", "BaseName" : "outStreamTop"},
			{"Name" : "outStreamTop_V_strb_V", "Type" : "Axis", "Direction" : "O", "BaseName" : "outStreamTop"},
			{"Name" : "outStreamTop_V_user_V", "Type" : "Axis", "Direction" : "O", "BaseName" : "outStreamTop"},
			{"Name" : "outStreamTop_V_last_V", "Type" : "Axis", "Direction" : "O", "BaseName" : "outStreamTop"}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_128_1", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "1", "FirstState" : "ap_ST_fsm_state1", "FirstStateIter" : "", "FirstStateBlock" : "ap_ST_fsm_state1_blk", "LastState" : "ap_ST_fsm_state1", "LastStateIter" : "", "LastStateBlock" : "ap_ST_fsm_state1_blk", "QuitState" : "ap_ST_fsm_state1", "QuitStateIter" : "", "QuitStateBlock" : "ap_ST_fsm_state1_blk", "OneDepthLoop" : "1", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "2", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_sendoutstream_Pipeline_VITIS_LOOP_128_1_fu_71.flow_control_loop_pipe_sequential_init_U", "Parent" : "1"},
	{"ID" : "3", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.regslice_both_outStreamTop_V_data_V_U", "Parent" : "0"},
	{"ID" : "4", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.regslice_both_outStreamTop_V_keep_V_U", "Parent" : "0"},
	{"ID" : "5", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.regslice_both_outStreamTop_V_strb_V_U", "Parent" : "0"},
	{"ID" : "6", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.regslice_both_outStreamTop_V_user_V_U", "Parent" : "0"},
	{"ID" : "7", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.regslice_both_outStreamTop_V_last_V_U", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
	sendoutstream {
		outbuf {Type I LastRead 0 FirstWrite -1}
		in_en_clrsts {Type I LastRead 0 FirstWrite -1}
		m2s_buf_sts {Type O LastRead -1 FirstWrite 1}
		outStreamTop_V_data_V {Type O LastRead -1 FirstWrite 0}
		outStreamTop_V_keep_V {Type O LastRead -1 FirstWrite 0}
		outStreamTop_V_strb_V {Type O LastRead -1 FirstWrite 0}
		outStreamTop_V_user_V {Type O LastRead -1 FirstWrite 0}
		outStreamTop_V_last_V {Type O LastRead -1 FirstWrite 0}}
	sendoutstream_Pipeline_VITIS_LOOP_128_1 {
		outbuf {Type I LastRead 0 FirstWrite -1}
		outStreamTop_V_data_V {Type O LastRead -1 FirstWrite 0}
		outStreamTop_V_keep_V {Type O LastRead -1 FirstWrite 0}
		outStreamTop_V_strb_V {Type O LastRead -1 FirstWrite 0}
		outStreamTop_V_user_V {Type O LastRead -1 FirstWrite 0}
		outStreamTop_V_last_V {Type O LastRead -1 FirstWrite 0}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "-1", "Max" : "-1"}
	, {"Name" : "Interval", "Min" : "-1", "Max" : "-1"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	outbuf { ap_fifo {  { outbuf_dout fifo_data_in 0 33 }  { outbuf_num_data_valid fifo_status_num_data_valid 0 7 }  { outbuf_fifo_cap fifo_update 0 7 }  { outbuf_empty_n fifo_status 0 1 }  { outbuf_read fifo_port_we 1 1 } } }
	in_en_clrsts { ap_fifo {  { in_en_clrsts_dout fifo_data_in 0 1 }  { in_en_clrsts_num_data_valid fifo_status_num_data_valid 0 3 }  { in_en_clrsts_fifo_cap fifo_update 0 3 }  { in_en_clrsts_empty_n fifo_status 0 1 }  { in_en_clrsts_read fifo_port_we 1 1 } } }
	m2s_buf_sts { ap_vld {  { m2s_buf_sts out_data 1 1 }  { m2s_buf_sts_ap_vld out_vld 1 1 } } }
	outStreamTop_V_data_V { axis {  { outStreamTop_TDATA out_data 1 32 } } }
	outStreamTop_V_keep_V { axis {  { outStreamTop_TKEEP out_data 1 4 } } }
	outStreamTop_V_strb_V { axis {  { outStreamTop_TSTRB out_data 1 4 } } }
	outStreamTop_V_user_V { axis {  { outStreamTop_TUSER out_data 1 7 } } }
	outStreamTop_V_last_V { axis {  { outStreamTop_TVALID out_vld 1 1 }  { outStreamTop_TREADY out_acc 0 1 }  { outStreamTop_TLAST out_data 1 1 } } }
}
