`timescale 1 ns / 1 ps

module AESL_deadlock_kernel_monitor_top ( 
    input wire kernel_monitor_clock,
    input wire kernel_monitor_reset
);
wire [1:0] axis_block_sigs;
wire [9:0] inst_idle_sigs;
wire [4:0] inst_block_sigs;
wire kernel_block;

assign axis_block_sigs[0] = ~AESL_inst_userdma.getinstream_U0.grp_getinstream_Pipeline_VITIS_LOOP_48_1_fu_132.inStreamTop_TDATA_blk_n;
assign axis_block_sigs[1] = ~AESL_inst_userdma.sendoutstream_U0.grp_sendoutstream_Pipeline_VITIS_LOOP_149_2_fu_101.outStreamTop_TDATA_blk_n;

assign inst_idle_sigs[0] = AESL_inst_userdma.entry_proc_U0.ap_idle;
assign inst_block_sigs[0] = (AESL_inst_userdma.entry_proc_U0.ap_done & ~AESL_inst_userdma.entry_proc_U0.ap_continue) | ~AESL_inst_userdma.entry_proc_U0.s2m_sts_clear_c_blk_n | ~AESL_inst_userdma.entry_proc_U0.s2mbuf_c_blk_n | ~AESL_inst_userdma.entry_proc_U0.m2s_sts_clear_c_blk_n;
assign inst_idle_sigs[1] = AESL_inst_userdma.getinstream_U0.ap_idle;
assign inst_block_sigs[1] = (AESL_inst_userdma.getinstream_U0.ap_done & ~AESL_inst_userdma.getinstream_U0.ap_continue) | ~AESL_inst_userdma.getinstream_U0.grp_getinstream_Pipeline_VITIS_LOOP_48_1_fu_132.inbuf_blk_n | ~AESL_inst_userdma.getinstream_U0.grp_getinstream_Pipeline_VITIS_LOOP_48_1_fu_132.incount47_blk_n | ~AESL_inst_userdma.getinstream_U0.s2m_len_c_blk_n | ~AESL_inst_userdma.getinstream_U0.s2m_enb_clrsts_c_blk_n;
assign inst_idle_sigs[2] = AESL_inst_userdma.streamtoparallelwithburst_U0.ap_idle;
assign inst_block_sigs[2] = (AESL_inst_userdma.streamtoparallelwithburst_U0.ap_done & ~AESL_inst_userdma.streamtoparallelwithburst_U0.ap_continue) | ~AESL_inst_userdma.streamtoparallelwithburst_U0.grp_streamtoparallelwithburst_Pipeline_VITIS_LOOP_23_2_fu_148.inbuf_blk_n | ~AESL_inst_userdma.streamtoparallelwithburst_U0.incount47_blk_n | ~AESL_inst_userdma.streamtoparallelwithburst_U0.in_en_clrsts_blk_n | ~AESL_inst_userdma.streamtoparallelwithburst_U0.sts_clear_blk_n | ~AESL_inst_userdma.streamtoparallelwithburst_U0.in_s2m_len_blk_n | ~AESL_inst_userdma.streamtoparallelwithburst_U0.out_memory_blk_n;
assign inst_idle_sigs[3] = AESL_inst_userdma.paralleltostreamwithburst_U0.ap_idle;
assign inst_block_sigs[3] = (AESL_inst_userdma.paralleltostreamwithburst_U0.ap_done & ~AESL_inst_userdma.paralleltostreamwithburst_U0.ap_continue) | ~AESL_inst_userdma.paralleltostreamwithburst_U0.grp_paralleltostreamwithburst_Pipeline_VITIS_LOOP_106_2_fu_173.outbuf_blk_n | ~AESL_inst_userdma.paralleltostreamwithburst_U0.outcount48_blk_n | ~AESL_inst_userdma.paralleltostreamwithburst_U0.m2s_enb_clrsts_c_blk_n;
assign inst_idle_sigs[4] = AESL_inst_userdma.sendoutstream_U0.ap_idle;
assign inst_block_sigs[4] = (AESL_inst_userdma.sendoutstream_U0.ap_done & ~AESL_inst_userdma.sendoutstream_U0.ap_continue) | ~AESL_inst_userdma.sendoutstream_U0.grp_sendoutstream_Pipeline_VITIS_LOOP_149_2_fu_101.outbuf_blk_n | ~AESL_inst_userdma.sendoutstream_U0.outcount48_blk_n | ~AESL_inst_userdma.sendoutstream_U0.in_en_clrsts_blk_n | ~AESL_inst_userdma.sendoutstream_U0.sts_clear_blk_n;

assign inst_idle_sigs[5] = 1'b0;
assign inst_idle_sigs[6] = AESL_inst_userdma.getinstream_U0.ap_idle;
assign inst_idle_sigs[7] = AESL_inst_userdma.getinstream_U0.grp_getinstream_Pipeline_VITIS_LOOP_48_1_fu_132.ap_idle;
assign inst_idle_sigs[8] = AESL_inst_userdma.sendoutstream_U0.ap_idle;
assign inst_idle_sigs[9] = AESL_inst_userdma.sendoutstream_U0.grp_sendoutstream_Pipeline_VITIS_LOOP_149_2_fu_101.ap_idle;

AESL_deadlock_idx0_monitor AESL_deadlock_idx0_monitor_U (
    .clock(kernel_monitor_clock),
    .reset(kernel_monitor_reset),
    .axis_block_sigs(axis_block_sigs),
    .inst_idle_sigs(inst_idle_sigs),
    .inst_block_sigs(inst_block_sigs),
    .block(kernel_block)
);

initial begin
reg block_delay = 0;
    while(1) begin
        @(posedge kernel_monitor_clock);
    if (kernel_block == 1'b1 && block_delay == 1'b0)
    $display("find kernel block.");
    block_delay = kernel_block;
    end
end

endmodule
