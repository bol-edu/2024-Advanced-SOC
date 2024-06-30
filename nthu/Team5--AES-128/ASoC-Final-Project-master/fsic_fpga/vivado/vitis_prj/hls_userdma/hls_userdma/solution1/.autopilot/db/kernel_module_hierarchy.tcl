set ModuleHierarchy {[{
"Name" : "userdma","ID" : "0","Type" : "dataflow",
"SubInsts" : [
	{"Name" : "entry_proc_U0","ID" : "1","Type" : "sequential"},
	{"Name" : "getinstream_U0","ID" : "2","Type" : "sequential",
		"SubInsts" : [
		{"Name" : "grp_getinstream_Pipeline_VITIS_LOOP_49_1_fu_127","ID" : "3","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "VITIS_LOOP_49_1","ID" : "4","Type" : "pipeline"},]},]},
	{"Name" : "paralleltostreamwithburst_U0","ID" : "5","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "VITIS_LOOP_93_1","ID" : "6","Type" : "no",
		"SubInsts" : [
		{"Name" : "grp_paralleltostreamwithburst_Pipeline_VITIS_LOOP_100_2_fu_128","ID" : "7","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "VITIS_LOOP_100_2","ID" : "8","Type" : "pipeline"},]},]},]},
	{"Name" : "streamtoparallelwithburst_U0","ID" : "9","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "VITIS_LOOP_18_1","ID" : "10","Type" : "no",
		"SubInsts" : [
		{"Name" : "grp_streamtoparallelwithburst_Pipeline_VITIS_LOOP_21_2_fu_140","ID" : "11","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "VITIS_LOOP_21_2","ID" : "12","Type" : "pipeline"},]},]},]},
	{"Name" : "sendoutstream_U0","ID" : "13","Type" : "sequential",
		"SubInsts" : [
		{"Name" : "grp_sendoutstream_Pipeline_VITIS_LOOP_128_1_fu_71","ID" : "14","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "VITIS_LOOP_128_1","ID" : "15","Type" : "pipeline"},]},]},]
}]}