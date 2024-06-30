set SynModuleInfo {
  {SRCNAME entry_proc MODELNAME entry_proc RTLNAME userdma_entry_proc}
  {SRCNAME getinstream_Pipeline_VITIS_LOOP_49_1 MODELNAME getinstream_Pipeline_VITIS_LOOP_49_1 RTLNAME userdma_getinstream_Pipeline_VITIS_LOOP_49_1
    SUBMODULES {
      {MODELNAME userdma_flow_control_loop_pipe_sequential_init RTLNAME userdma_flow_control_loop_pipe_sequential_init BINDTYPE interface TYPE internal_upc_flow_control INSTNAME userdma_flow_control_loop_pipe_sequential_init_U}
    }
  }
  {SRCNAME getinstream MODELNAME getinstream RTLNAME userdma_getinstream
    SUBMODULES {
      {MODELNAME userdma_regslice_both RTLNAME userdma_regslice_both BINDTYPE interface TYPE interface_regslice INSTNAME userdma_regslice_both_U}
    }
  }
  {SRCNAME streamtoparallelwithburst_Pipeline_VITIS_LOOP_21_2 MODELNAME streamtoparallelwithburst_Pipeline_VITIS_LOOP_21_2 RTLNAME userdma_streamtoparallelwithburst_Pipeline_VITIS_LOOP_21_2}
  {SRCNAME streamtoparallelwithburst MODELNAME streamtoparallelwithburst RTLNAME userdma_streamtoparallelwithburst}
  {SRCNAME paralleltostreamwithburst_Pipeline_VITIS_LOOP_100_2 MODELNAME paralleltostreamwithburst_Pipeline_VITIS_LOOP_100_2 RTLNAME userdma_paralleltostreamwithburst_Pipeline_VITIS_LOOP_100_2}
  {SRCNAME paralleltostreamwithburst MODELNAME paralleltostreamwithburst RTLNAME userdma_paralleltostreamwithburst}
  {SRCNAME sendoutstream_Pipeline_VITIS_LOOP_128_1 MODELNAME sendoutstream_Pipeline_VITIS_LOOP_128_1 RTLNAME userdma_sendoutstream_Pipeline_VITIS_LOOP_128_1}
  {SRCNAME sendoutstream MODELNAME sendoutstream RTLNAME userdma_sendoutstream}
  {SRCNAME userdma MODELNAME userdma RTLNAME userdma IS_TOP 1
    SUBMODULES {
      {MODELNAME userdma_fifo_w64_d3_S RTLNAME userdma_fifo_w64_d3_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME s2mbuf_c_U}
      {MODELNAME userdma_fifo_w33_d64_A RTLNAME userdma_fifo_w33_d64_A BINDTYPE storage TYPE fifo IMPL memory ALLOW_PRAGMA 1 INSTNAME inbuf_U}
      {MODELNAME userdma_fifo_w32_d4_S RTLNAME userdma_fifo_w32_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME incount_U}
      {MODELNAME userdma_fifo_w32_d2_S RTLNAME userdma_fifo_w32_d2_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME s2m_len_c_U}
      {MODELNAME userdma_fifo_w1_d2_S RTLNAME userdma_fifo_w1_d2_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME s2m_enb_clrsts_c_U}
      {MODELNAME userdma_fifo_w33_d64_A RTLNAME userdma_fifo_w33_d64_A BINDTYPE storage TYPE fifo IMPL memory ALLOW_PRAGMA 1 INSTNAME outbuf_U}
      {MODELNAME userdma_fifo_w1_d2_S RTLNAME userdma_fifo_w1_d2_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME m2s_enb_clrsts_c_U}
      {MODELNAME userdma_start_for_streamtoparallelwithburst_U0 RTLNAME userdma_start_for_streamtoparallelwithburst_U0 BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_streamtoparallelwithburst_U0_U}
      {MODELNAME userdma_start_for_sendoutstream_U0 RTLNAME userdma_start_for_sendoutstream_U0 BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_sendoutstream_U0_U}
      {MODELNAME userdma_gmem0_m_axi RTLNAME userdma_gmem0_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME userdma_gmem1_m_axi RTLNAME userdma_gmem1_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME userdma_control_s_axi RTLNAME userdma_control_s_axi BINDTYPE interface TYPE interface_s_axilite}
    }
  }
}
