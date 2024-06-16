/*
 * Created by 
   ../bin/Linux-x86_64-O/oasys 21.1-s001 on Sat Jun 15 02:48:07 2024
 * (C) Mentor Graphics Corporation
 */
/* CheckSum: 2430185381 */

module ccs_fifo_wait_core_v5(clk, en, arst, srst, din_vld, din_rdy, din, 
      dout_vld, dout_rdy, dout, sd, is_idle);
   input clk;
   input en;
   input arst;
   input srst;
   input din_vld;
   output din_rdy;
   input [8:0]din;
   output dout_vld;
   input dout_rdy;
   output [8:0]dout;
   output [0:0]sd;
   output is_idle;

   wire hs_init;
   wire HS_INIT_REG_n_0;
   wire GEN_REGS_1_BUFREG_n_0;
   wire GEN_REGS_0_BUFREG_n_0;
   wire stat;
   wire n_0_0;
   wire n_0_1;
   wire n_0_2;
   wire n_0_3;
   wire n_0_4;
   wire n_0_5;
   wire n_0_6;
   wire n_0_7;
   wire n_0_8;
   wire GEN_REGS_0_BUFREG_n_10;
   wire n_0_9;
   wire GEN_REGS_0_BUFREG_n_1;
   wire GEN_REGS_0_BUFREG_n_2;
   wire GEN_REGS_0_BUFREG_n_3;
   wire GEN_REGS_0_BUFREG_n_4;
   wire GEN_REGS_0_BUFREG_n_5;
   wire GEN_REGS_0_BUFREG_n_6;
   wire GEN_REGS_0_BUFREG_n_7;
   wire GEN_REGS_0_BUFREG_n_8;
   wire GEN_REGS_0_BUFREG_n_9;
   wire GEN_REGS_1_BUFREG_n_10;
   wire n_0_10;
   wire GEN_REGS_1_BUFREG_n_1;
   wire n_0_11;
   wire GEN_REGS_1_BUFREG_n_2;
   wire n_0_12;
   wire GEN_REGS_1_BUFREG_n_3;
   wire n_0_13;
   wire GEN_REGS_1_BUFREG_n_4;
   wire n_0_14;
   wire GEN_REGS_1_BUFREG_n_5;
   wire n_0_15;
   wire GEN_REGS_1_BUFREG_n_6;
   wire n_0_16;
   wire GEN_REGS_1_BUFREG_n_7;
   wire n_0_17;
   wire GEN_REGS_1_BUFREG_n_8;
   wire n_0_18;
   wire GEN_REGS_1_BUFREG_n_9;
   wire n_0_19;
   wire n_0_20;
   wire n_0_21;
   wire n_0_22;
   wire n_0_23;
   wire n_0_24;
   wire n_0_25;
   wire n_0_26;
   wire n_0_27;
   wire n_0_28;
   wire n_0_29;
   wire n_0_30;
   wire n_0_31;
   wire n_0_32;
   wire n_0_33;

   INV_X1 HS_INIT_REG_i_2 (.A(srst), .ZN(HS_INIT_REG_n_0));
   DFFR_X1 \HS_INIT_REG_z_reg[0]  (.D(HS_INIT_REG_n_0), .RN(arst), .CK(clk), 
      .Q(hs_init), .QN());
   INV_X1 i_0_66 (.A(srst), .ZN(n_0_33));
   INV_X1 i_0_63 (.A(dout_rdy), .ZN(n_0_30));
   NAND2_X1 i_0_62 (.A1(din_vld), .A2(hs_init), .ZN(n_0_29));
   INV_X1 i_0_61 (.A(n_0_29), .ZN(n_0_28));
   AOI211_X1 i_0_53 (.A(stat), .B(n_0_30), .C1(n_18), .C2(n_0_28), .ZN(n_0_23));
   NAND2_X1 i_0_52 (.A1(din_vld), .A2(din_rdy), .ZN(n_0_22));
   AOI211_X1 i_0_51 (.A(srst), .B(n_0_23), .C1(n_0_32), .C2(n_0_22), .ZN(n_19));
   DFFR_X1 \GEN_REGS_1_STATREG_z_reg[0]  (.D(n_19), .RN(arst), .CK(clk), 
      .Q(n_18), .QN());
   INV_X1 i_0_65 (.A(n_18), .ZN(n_0_32));
   INV_X1 i_0_64 (.A(stat), .ZN(n_0_31));
   AOI211_X1 i_0_59 (.A(n_0_32), .B(n_0_29), .C1(n_0_31), .C2(dout_rdy), 
      .ZN(n_0_27));
   NAND2_X1 i_0_60 (.A1(n_0_32), .A2(n_0_29), .ZN(dout_vld));
   OAI21_X1 i_0_57 (.A(n_0_26), .B1(n_0_31), .B2(dout_vld), .ZN(n_0_25));
   OAI21_X1 i_0_56 (.A(n_0_33), .B1(n_0_27), .B2(n_0_25), .ZN(n_0_24));
   INV_X1 i_0_55 (.A(n_0_24), .ZN(n_20));
   DFFR_X1 \GEN_REGS_0_STATREG_z_reg[0]  (.D(n_20), .RN(arst), .CK(clk), 
      .Q(stat), .QN());
   NAND2_X1 i_0_58 (.A1(stat), .A2(n_0_30), .ZN(n_0_26));
   AND2_X1 i_0_54 (.A1(hs_init), .A2(n_0_26), .ZN(din_rdy));
   AND2_X1 i_0_28 (.A1(n_0_33), .A2(din[8]), .ZN(GEN_REGS_0_BUFREG_n_9));
   AOI21_X1 i_0_19 (.A(srst), .B1(n_0_27), .B2(n_0_26), .ZN(n_0_9));
   INV_X1 i_0_18 (.A(n_0_9), .ZN(GEN_REGS_0_BUFREG_n_10));
   CLKGATE_X1 GEN_REGS_0_BUFREG_clk_gate_z_reg (.CK(clk), .E(
      GEN_REGS_0_BUFREG_n_10), .GCK(GEN_REGS_0_BUFREG_n_0));
   DFFR_X1 \GEN_REGS_0_BUFREG_z_reg[8]  (.D(GEN_REGS_0_BUFREG_n_9), .RN(arst), 
      .CK(GEN_REGS_0_BUFREG_n_0), .Q(n_9), .QN());
   NOR3_X1 i_0_50 (.A1(n_0_31), .A2(n_0_30), .A3(srst), .ZN(n_0_21));
   NOR2_X1 i_0_49 (.A1(srst), .A2(n_0_21), .ZN(n_0_20));
   AOI22_X1 i_0_48 (.A1(n_9), .A2(n_0_21), .B1(din[8]), .B2(n_0_20), .ZN(n_0_19));
   INV_X1 i_0_47 (.A(n_0_19), .ZN(GEN_REGS_1_BUFREG_n_9));
   AOI21_X1 i_0_30 (.A(dout_rdy), .B1(n_0_32), .B2(n_0_28), .ZN(n_0_10));
   OAI21_X1 i_0_29 (.A(n_0_33), .B1(n_0_23), .B2(n_0_10), .ZN(
      GEN_REGS_1_BUFREG_n_10));
   CLKGATE_X1 GEN_REGS_1_BUFREG_clk_gate_z_reg (.CK(clk), .E(
      GEN_REGS_1_BUFREG_n_10), .GCK(GEN_REGS_1_BUFREG_n_0));
   DFFR_X1 \GEN_REGS_1_BUFREG_z_reg[8]  (.D(GEN_REGS_1_BUFREG_n_9), .RN(arst), 
      .CK(GEN_REGS_1_BUFREG_n_0), .Q(n_0), .QN());
   AOI22_X1 i_0_17 (.A1(n_18), .A2(n_0), .B1(n_0_32), .B2(din[8]), .ZN(n_0_8));
   INV_X1 i_0_16 (.A(n_0_8), .ZN(dout[8]));
   AND2_X1 i_0_27 (.A1(n_0_33), .A2(din[7]), .ZN(GEN_REGS_0_BUFREG_n_8));
   DFFR_X1 \GEN_REGS_0_BUFREG_z_reg[7]  (.D(GEN_REGS_0_BUFREG_n_8), .RN(arst), 
      .CK(GEN_REGS_0_BUFREG_n_0), .Q(n_10), .QN());
   AOI22_X1 i_0_46 (.A1(n_10), .A2(n_0_21), .B1(din[7]), .B2(n_0_20), .ZN(n_0_18));
   INV_X1 i_0_45 (.A(n_0_18), .ZN(GEN_REGS_1_BUFREG_n_8));
   DFFR_X1 \GEN_REGS_1_BUFREG_z_reg[7]  (.D(GEN_REGS_1_BUFREG_n_8), .RN(arst), 
      .CK(GEN_REGS_1_BUFREG_n_0), .Q(n_1), .QN());
   AOI22_X1 i_0_15 (.A1(n_18), .A2(n_1), .B1(n_0_32), .B2(din[7]), .ZN(n_0_7));
   INV_X1 i_0_14 (.A(n_0_7), .ZN(dout[7]));
   AND2_X1 i_0_26 (.A1(n_0_33), .A2(din[6]), .ZN(GEN_REGS_0_BUFREG_n_7));
   DFFR_X1 \GEN_REGS_0_BUFREG_z_reg[6]  (.D(GEN_REGS_0_BUFREG_n_7), .RN(arst), 
      .CK(GEN_REGS_0_BUFREG_n_0), .Q(n_11), .QN());
   AOI22_X1 i_0_44 (.A1(n_11), .A2(n_0_21), .B1(din[6]), .B2(n_0_20), .ZN(n_0_17));
   INV_X1 i_0_43 (.A(n_0_17), .ZN(GEN_REGS_1_BUFREG_n_7));
   DFFR_X1 \GEN_REGS_1_BUFREG_z_reg[6]  (.D(GEN_REGS_1_BUFREG_n_7), .RN(arst), 
      .CK(GEN_REGS_1_BUFREG_n_0), .Q(n_2), .QN());
   AOI22_X1 i_0_13 (.A1(n_18), .A2(n_2), .B1(n_0_32), .B2(din[6]), .ZN(n_0_6));
   INV_X1 i_0_12 (.A(n_0_6), .ZN(dout[6]));
   AND2_X1 i_0_25 (.A1(n_0_33), .A2(din[5]), .ZN(GEN_REGS_0_BUFREG_n_6));
   DFFR_X1 \GEN_REGS_0_BUFREG_z_reg[5]  (.D(GEN_REGS_0_BUFREG_n_6), .RN(arst), 
      .CK(GEN_REGS_0_BUFREG_n_0), .Q(n_12), .QN());
   AOI22_X1 i_0_42 (.A1(n_12), .A2(n_0_21), .B1(din[5]), .B2(n_0_20), .ZN(n_0_16));
   INV_X1 i_0_41 (.A(n_0_16), .ZN(GEN_REGS_1_BUFREG_n_6));
   DFFR_X1 \GEN_REGS_1_BUFREG_z_reg[5]  (.D(GEN_REGS_1_BUFREG_n_6), .RN(arst), 
      .CK(GEN_REGS_1_BUFREG_n_0), .Q(n_3), .QN());
   AOI22_X1 i_0_11 (.A1(n_18), .A2(n_3), .B1(n_0_32), .B2(din[5]), .ZN(n_0_5));
   INV_X1 i_0_10 (.A(n_0_5), .ZN(dout[5]));
   AND2_X1 i_0_24 (.A1(n_0_33), .A2(din[4]), .ZN(GEN_REGS_0_BUFREG_n_5));
   DFFR_X1 \GEN_REGS_0_BUFREG_z_reg[4]  (.D(GEN_REGS_0_BUFREG_n_5), .RN(arst), 
      .CK(GEN_REGS_0_BUFREG_n_0), .Q(n_13), .QN());
   AOI22_X1 i_0_40 (.A1(n_13), .A2(n_0_21), .B1(din[4]), .B2(n_0_20), .ZN(n_0_15));
   INV_X1 i_0_39 (.A(n_0_15), .ZN(GEN_REGS_1_BUFREG_n_5));
   DFFR_X1 \GEN_REGS_1_BUFREG_z_reg[4]  (.D(GEN_REGS_1_BUFREG_n_5), .RN(arst), 
      .CK(GEN_REGS_1_BUFREG_n_0), .Q(n_4), .QN());
   AOI22_X1 i_0_9 (.A1(n_18), .A2(n_4), .B1(n_0_32), .B2(din[4]), .ZN(n_0_4));
   INV_X1 i_0_8 (.A(n_0_4), .ZN(dout[4]));
   AND2_X1 i_0_23 (.A1(n_0_33), .A2(din[3]), .ZN(GEN_REGS_0_BUFREG_n_4));
   DFFR_X1 \GEN_REGS_0_BUFREG_z_reg[3]  (.D(GEN_REGS_0_BUFREG_n_4), .RN(arst), 
      .CK(GEN_REGS_0_BUFREG_n_0), .Q(n_14), .QN());
   AOI22_X1 i_0_38 (.A1(n_14), .A2(n_0_21), .B1(din[3]), .B2(n_0_20), .ZN(n_0_14));
   INV_X1 i_0_37 (.A(n_0_14), .ZN(GEN_REGS_1_BUFREG_n_4));
   DFFR_X1 \GEN_REGS_1_BUFREG_z_reg[3]  (.D(GEN_REGS_1_BUFREG_n_4), .RN(arst), 
      .CK(GEN_REGS_1_BUFREG_n_0), .Q(n_5), .QN());
   AOI22_X1 i_0_7 (.A1(n_18), .A2(n_5), .B1(n_0_32), .B2(din[3]), .ZN(n_0_3));
   INV_X1 i_0_6 (.A(n_0_3), .ZN(dout[3]));
   AND2_X1 i_0_22 (.A1(n_0_33), .A2(din[2]), .ZN(GEN_REGS_0_BUFREG_n_3));
   DFFR_X1 \GEN_REGS_0_BUFREG_z_reg[2]  (.D(GEN_REGS_0_BUFREG_n_3), .RN(arst), 
      .CK(GEN_REGS_0_BUFREG_n_0), .Q(n_15), .QN());
   AOI22_X1 i_0_36 (.A1(n_15), .A2(n_0_21), .B1(din[2]), .B2(n_0_20), .ZN(n_0_13));
   INV_X1 i_0_35 (.A(n_0_13), .ZN(GEN_REGS_1_BUFREG_n_3));
   DFFR_X1 \GEN_REGS_1_BUFREG_z_reg[2]  (.D(GEN_REGS_1_BUFREG_n_3), .RN(arst), 
      .CK(GEN_REGS_1_BUFREG_n_0), .Q(n_6), .QN());
   AOI22_X1 i_0_5 (.A1(n_18), .A2(n_6), .B1(n_0_32), .B2(din[2]), .ZN(n_0_2));
   INV_X1 i_0_4 (.A(n_0_2), .ZN(dout[2]));
   AND2_X1 i_0_21 (.A1(n_0_33), .A2(din[1]), .ZN(GEN_REGS_0_BUFREG_n_2));
   DFFR_X1 \GEN_REGS_0_BUFREG_z_reg[1]  (.D(GEN_REGS_0_BUFREG_n_2), .RN(arst), 
      .CK(GEN_REGS_0_BUFREG_n_0), .Q(n_16), .QN());
   AOI22_X1 i_0_34 (.A1(n_16), .A2(n_0_21), .B1(din[1]), .B2(n_0_20), .ZN(n_0_12));
   INV_X1 i_0_33 (.A(n_0_12), .ZN(GEN_REGS_1_BUFREG_n_2));
   DFFR_X1 \GEN_REGS_1_BUFREG_z_reg[1]  (.D(GEN_REGS_1_BUFREG_n_2), .RN(arst), 
      .CK(GEN_REGS_1_BUFREG_n_0), .Q(n_7), .QN());
   AOI22_X1 i_0_3 (.A1(n_18), .A2(n_7), .B1(n_0_32), .B2(din[1]), .ZN(n_0_1));
   INV_X1 i_0_2 (.A(n_0_1), .ZN(dout[1]));
   AND2_X1 i_0_20 (.A1(n_0_33), .A2(din[0]), .ZN(GEN_REGS_0_BUFREG_n_1));
   DFFR_X1 \GEN_REGS_0_BUFREG_z_reg[0]  (.D(GEN_REGS_0_BUFREG_n_1), .RN(arst), 
      .CK(GEN_REGS_0_BUFREG_n_0), .Q(n_17), .QN());
   AOI22_X1 i_0_32 (.A1(n_17), .A2(n_0_21), .B1(din[0]), .B2(n_0_20), .ZN(n_0_11));
   INV_X1 i_0_31 (.A(n_0_11), .ZN(GEN_REGS_1_BUFREG_n_1));
   DFFR_X1 \GEN_REGS_1_BUFREG_z_reg[0]  (.D(GEN_REGS_1_BUFREG_n_1), .RN(arst), 
      .CK(GEN_REGS_1_BUFREG_n_0), .Q(n_8), .QN());
   AOI22_X1 i_0_1 (.A1(n_18), .A2(n_8), .B1(n_0_32), .B2(din[0]), .ZN(n_0_0));
   INV_X1 i_0_0 (.A(n_0_0), .ZN(dout[0]));
endmodule

module ccs_pipe_v6(clk, en, arst, srst, din_rdy, din_vld, din, dout_rdy, 
      dout_vld, dout, sz, sz_req, is_idle);
   input clk;
   input en;
   input arst;
   input srst;
   output din_rdy;
   input din_vld;
   input [8:0]din;
   input dout_rdy;
   output dout_vld;
   output [8:0]dout;
   output [0:0]sz;
   input sz_req;
   output is_idle;

   ccs_fifo_wait_core_v5 FIFO (.clk(clk), .en(), .arst(arst), .srst(srst), 
      .din_vld(din_vld), .din_rdy(din_rdy), .din(din), .dout_vld(dout_vld), 
      .dout_rdy(dout_rdy), .dout(dout), .sd(), .is_idle());
endmodule

module EdgeDetect_IP_Kmean_run_kmean_out_rsci(clk, rst, arst_n, 
      kmean_out_rsc_dat, kmean_out_rsc_vld, kmean_out_rsc_rdy, run_wen, 
      kmean_out_rsci_oswt, kmean_out_rsci_wen_comp, kmean_out_rsci_idat);
   input clk;
   input rst;
   input arst_n;
   output [23:0]kmean_out_rsc_dat;
   output kmean_out_rsc_vld;
   input kmean_out_rsc_rdy;
   input run_wen;
   input kmean_out_rsci_oswt;
   output kmean_out_rsci_wen_comp;
   input [23:0]kmean_out_rsci_idat;

   wire kmean_out_rsci_bcwt;
   wire EdgeDetect_IP_Kmean_run_kmean_out_rsci_kmean_out_wait_dp_inst_n_1;
   wire n_0_0_0;
   wire n_0_0_1;
   wire n_0_0_2;

   INV_X1 i_0_0_5 (.A(kmean_out_rsci_oswt), .ZN(n_0_0_2));
   AOI21_X1 i_0_0_1 (.A(kmean_out_rsci_bcwt), .B1(kmean_out_rsci_oswt), .B2(
      kmean_out_rsc_rdy), .ZN(n_0_0_0));
   AOI211_X1 i_0_0_0 (.A(rst), .B(n_0_0_0), .C1(kmean_out_rsci_oswt), .C2(
      run_wen), .ZN(
      EdgeDetect_IP_Kmean_run_kmean_out_rsci_kmean_out_wait_dp_inst_n_1));
   DFFR_X1 EdgeDetect_IP_Kmean_run_kmean_out_rsci_kmean_out_wait_dp_inst_kmean_out_rsci_bcwt_reg (
      .D(EdgeDetect_IP_Kmean_run_kmean_out_rsci_kmean_out_wait_dp_inst_n_1), 
      .RN(arst_n), .CK(clk), .Q(kmean_out_rsci_bcwt), .QN());
   NOR2_X1 i_0_0_3 (.A1(n_0_0_2), .A2(kmean_out_rsci_bcwt), .ZN(
      kmean_out_rsc_vld));
   INV_X1 i_0_0_4 (.A(kmean_out_rsc_rdy), .ZN(n_0_0_1));
   NAND2_X1 i_0_0_2 (.A1(kmean_out_rsc_vld), .A2(n_0_0_1), .ZN(
      kmean_out_rsci_wen_comp));
endmodule

module EdgeDetect_IP_Kmean_run_kmean_in_rsci_kmean_in_wait_dp(clk, rst, arst_n, 
      kmean_in_rsci_oswt, kmean_in_rsci_wen_comp, kmean_in_rsci_idat_mxwt, 
      kmean_in_rsci_biwt, kmean_in_rsci_bdwt, kmean_in_rsci_bcwt, 
      kmean_in_rsci_idat);
   input clk;
   input rst;
   input arst_n;
   input kmean_in_rsci_oswt;
   output kmean_in_rsci_wen_comp;
   output [23:0]kmean_in_rsci_idat_mxwt;
   input kmean_in_rsci_biwt;
   input kmean_in_rsci_bdwt;
   output kmean_in_rsci_bcwt;
   input [33:0]kmean_in_rsci_idat;

   wire [23:0]kmean_in_rsci_idat_bfwt_23_0;
   wire n_0_0;

   NOR3_X1 i_0_2 (.A1(n_0_0), .A2(rst), .A3(kmean_in_rsci_bdwt), .ZN(n_1));
   DFFR_X1 kmean_in_rsci_bcwt_reg (.D(n_1), .RN(arst_n), .CK(clk), .Q(
      kmean_in_rsci_bcwt), .QN());
   NOR2_X1 i_0_0 (.A1(kmean_in_rsci_biwt), .A2(kmean_in_rsci_bcwt), .ZN(n_0_0));
   NAND2_X1 i_0_1 (.A1(n_0_0), .A2(kmean_in_rsci_oswt), .ZN(
      kmean_in_rsci_wen_comp));
   CLKGATE_X1 clk_gate_kmean_in_rsci_idat_bfwt_23_0_reg (.CK(clk), .E(
      kmean_in_rsci_biwt), .GCK(n_0));
   DFF_X1 \kmean_in_rsci_idat_bfwt_23_0_reg[23]  (.D(kmean_in_rsci_idat[23]), 
      .CK(n_0), .Q(kmean_in_rsci_idat_bfwt_23_0[23]), .QN());
   MUX2_X1 i_0_26 (.A(kmean_in_rsci_idat[23]), .B(
      kmean_in_rsci_idat_bfwt_23_0[23]), .S(kmean_in_rsci_bcwt), .Z(
      kmean_in_rsci_idat_mxwt[23]));
   DFF_X1 \kmean_in_rsci_idat_bfwt_23_0_reg[22]  (.D(kmean_in_rsci_idat[22]), 
      .CK(n_0), .Q(kmean_in_rsci_idat_bfwt_23_0[22]), .QN());
   MUX2_X1 i_0_25 (.A(kmean_in_rsci_idat[22]), .B(
      kmean_in_rsci_idat_bfwt_23_0[22]), .S(kmean_in_rsci_bcwt), .Z(
      kmean_in_rsci_idat_mxwt[22]));
   DFF_X1 \kmean_in_rsci_idat_bfwt_23_0_reg[21]  (.D(kmean_in_rsci_idat[21]), 
      .CK(n_0), .Q(kmean_in_rsci_idat_bfwt_23_0[21]), .QN());
   MUX2_X1 i_0_24 (.A(kmean_in_rsci_idat[21]), .B(
      kmean_in_rsci_idat_bfwt_23_0[21]), .S(kmean_in_rsci_bcwt), .Z(
      kmean_in_rsci_idat_mxwt[21]));
   DFF_X1 \kmean_in_rsci_idat_bfwt_23_0_reg[20]  (.D(kmean_in_rsci_idat[20]), 
      .CK(n_0), .Q(kmean_in_rsci_idat_bfwt_23_0[20]), .QN());
   MUX2_X1 i_0_23 (.A(kmean_in_rsci_idat[20]), .B(
      kmean_in_rsci_idat_bfwt_23_0[20]), .S(kmean_in_rsci_bcwt), .Z(
      kmean_in_rsci_idat_mxwt[20]));
   DFF_X1 \kmean_in_rsci_idat_bfwt_23_0_reg[19]  (.D(kmean_in_rsci_idat[19]), 
      .CK(n_0), .Q(kmean_in_rsci_idat_bfwt_23_0[19]), .QN());
   MUX2_X1 i_0_22 (.A(kmean_in_rsci_idat[19]), .B(
      kmean_in_rsci_idat_bfwt_23_0[19]), .S(kmean_in_rsci_bcwt), .Z(
      kmean_in_rsci_idat_mxwt[19]));
   DFF_X1 \kmean_in_rsci_idat_bfwt_23_0_reg[18]  (.D(kmean_in_rsci_idat[18]), 
      .CK(n_0), .Q(kmean_in_rsci_idat_bfwt_23_0[18]), .QN());
   MUX2_X1 i_0_21 (.A(kmean_in_rsci_idat[18]), .B(
      kmean_in_rsci_idat_bfwt_23_0[18]), .S(kmean_in_rsci_bcwt), .Z(
      kmean_in_rsci_idat_mxwt[18]));
   DFF_X1 \kmean_in_rsci_idat_bfwt_23_0_reg[17]  (.D(kmean_in_rsci_idat[17]), 
      .CK(n_0), .Q(kmean_in_rsci_idat_bfwt_23_0[17]), .QN());
   MUX2_X1 i_0_20 (.A(kmean_in_rsci_idat[17]), .B(
      kmean_in_rsci_idat_bfwt_23_0[17]), .S(kmean_in_rsci_bcwt), .Z(
      kmean_in_rsci_idat_mxwt[17]));
   DFF_X1 \kmean_in_rsci_idat_bfwt_23_0_reg[16]  (.D(kmean_in_rsci_idat[16]), 
      .CK(n_0), .Q(kmean_in_rsci_idat_bfwt_23_0[16]), .QN());
   MUX2_X1 i_0_19 (.A(kmean_in_rsci_idat[16]), .B(
      kmean_in_rsci_idat_bfwt_23_0[16]), .S(kmean_in_rsci_bcwt), .Z(
      kmean_in_rsci_idat_mxwt[16]));
   DFF_X1 \kmean_in_rsci_idat_bfwt_23_0_reg[15]  (.D(kmean_in_rsci_idat[15]), 
      .CK(n_0), .Q(kmean_in_rsci_idat_bfwt_23_0[15]), .QN());
   MUX2_X1 i_0_18 (.A(kmean_in_rsci_idat[15]), .B(
      kmean_in_rsci_idat_bfwt_23_0[15]), .S(kmean_in_rsci_bcwt), .Z(
      kmean_in_rsci_idat_mxwt[15]));
   DFF_X1 \kmean_in_rsci_idat_bfwt_23_0_reg[14]  (.D(kmean_in_rsci_idat[14]), 
      .CK(n_0), .Q(kmean_in_rsci_idat_bfwt_23_0[14]), .QN());
   MUX2_X1 i_0_17 (.A(kmean_in_rsci_idat[14]), .B(
      kmean_in_rsci_idat_bfwt_23_0[14]), .S(kmean_in_rsci_bcwt), .Z(
      kmean_in_rsci_idat_mxwt[14]));
   DFF_X1 \kmean_in_rsci_idat_bfwt_23_0_reg[13]  (.D(kmean_in_rsci_idat[13]), 
      .CK(n_0), .Q(kmean_in_rsci_idat_bfwt_23_0[13]), .QN());
   MUX2_X1 i_0_16 (.A(kmean_in_rsci_idat[13]), .B(
      kmean_in_rsci_idat_bfwt_23_0[13]), .S(kmean_in_rsci_bcwt), .Z(
      kmean_in_rsci_idat_mxwt[13]));
   DFF_X1 \kmean_in_rsci_idat_bfwt_23_0_reg[12]  (.D(kmean_in_rsci_idat[12]), 
      .CK(n_0), .Q(kmean_in_rsci_idat_bfwt_23_0[12]), .QN());
   MUX2_X1 i_0_15 (.A(kmean_in_rsci_idat[12]), .B(
      kmean_in_rsci_idat_bfwt_23_0[12]), .S(kmean_in_rsci_bcwt), .Z(
      kmean_in_rsci_idat_mxwt[12]));
   DFF_X1 \kmean_in_rsci_idat_bfwt_23_0_reg[11]  (.D(kmean_in_rsci_idat[11]), 
      .CK(n_0), .Q(kmean_in_rsci_idat_bfwt_23_0[11]), .QN());
   MUX2_X1 i_0_14 (.A(kmean_in_rsci_idat[11]), .B(
      kmean_in_rsci_idat_bfwt_23_0[11]), .S(kmean_in_rsci_bcwt), .Z(
      kmean_in_rsci_idat_mxwt[11]));
   DFF_X1 \kmean_in_rsci_idat_bfwt_23_0_reg[10]  (.D(kmean_in_rsci_idat[10]), 
      .CK(n_0), .Q(kmean_in_rsci_idat_bfwt_23_0[10]), .QN());
   MUX2_X1 i_0_13 (.A(kmean_in_rsci_idat[10]), .B(
      kmean_in_rsci_idat_bfwt_23_0[10]), .S(kmean_in_rsci_bcwt), .Z(
      kmean_in_rsci_idat_mxwt[10]));
   DFF_X1 \kmean_in_rsci_idat_bfwt_23_0_reg[9]  (.D(kmean_in_rsci_idat[9]), 
      .CK(n_0), .Q(kmean_in_rsci_idat_bfwt_23_0[9]), .QN());
   MUX2_X1 i_0_12 (.A(kmean_in_rsci_idat[9]), .B(kmean_in_rsci_idat_bfwt_23_0[9]), 
      .S(kmean_in_rsci_bcwt), .Z(kmean_in_rsci_idat_mxwt[9]));
   DFF_X1 \kmean_in_rsci_idat_bfwt_23_0_reg[8]  (.D(kmean_in_rsci_idat[8]), 
      .CK(n_0), .Q(kmean_in_rsci_idat_bfwt_23_0[8]), .QN());
   MUX2_X1 i_0_11 (.A(kmean_in_rsci_idat[8]), .B(kmean_in_rsci_idat_bfwt_23_0[8]), 
      .S(kmean_in_rsci_bcwt), .Z(kmean_in_rsci_idat_mxwt[8]));
   DFF_X1 \kmean_in_rsci_idat_bfwt_23_0_reg[7]  (.D(kmean_in_rsci_idat[7]), 
      .CK(n_0), .Q(kmean_in_rsci_idat_bfwt_23_0[7]), .QN());
   MUX2_X1 i_0_10 (.A(kmean_in_rsci_idat[7]), .B(kmean_in_rsci_idat_bfwt_23_0[7]), 
      .S(kmean_in_rsci_bcwt), .Z(kmean_in_rsci_idat_mxwt[7]));
   DFF_X1 \kmean_in_rsci_idat_bfwt_23_0_reg[6]  (.D(kmean_in_rsci_idat[6]), 
      .CK(n_0), .Q(kmean_in_rsci_idat_bfwt_23_0[6]), .QN());
   MUX2_X1 i_0_9 (.A(kmean_in_rsci_idat[6]), .B(kmean_in_rsci_idat_bfwt_23_0[6]), 
      .S(kmean_in_rsci_bcwt), .Z(kmean_in_rsci_idat_mxwt[6]));
   DFF_X1 \kmean_in_rsci_idat_bfwt_23_0_reg[5]  (.D(kmean_in_rsci_idat[5]), 
      .CK(n_0), .Q(kmean_in_rsci_idat_bfwt_23_0[5]), .QN());
   MUX2_X1 i_0_8 (.A(kmean_in_rsci_idat[5]), .B(kmean_in_rsci_idat_bfwt_23_0[5]), 
      .S(kmean_in_rsci_bcwt), .Z(kmean_in_rsci_idat_mxwt[5]));
   DFF_X1 \kmean_in_rsci_idat_bfwt_23_0_reg[4]  (.D(kmean_in_rsci_idat[4]), 
      .CK(n_0), .Q(kmean_in_rsci_idat_bfwt_23_0[4]), .QN());
   MUX2_X1 i_0_7 (.A(kmean_in_rsci_idat[4]), .B(kmean_in_rsci_idat_bfwt_23_0[4]), 
      .S(kmean_in_rsci_bcwt), .Z(kmean_in_rsci_idat_mxwt[4]));
   DFF_X1 \kmean_in_rsci_idat_bfwt_23_0_reg[3]  (.D(kmean_in_rsci_idat[3]), 
      .CK(n_0), .Q(kmean_in_rsci_idat_bfwt_23_0[3]), .QN());
   MUX2_X1 i_0_6 (.A(kmean_in_rsci_idat[3]), .B(kmean_in_rsci_idat_bfwt_23_0[3]), 
      .S(kmean_in_rsci_bcwt), .Z(kmean_in_rsci_idat_mxwt[3]));
   DFF_X1 \kmean_in_rsci_idat_bfwt_23_0_reg[2]  (.D(kmean_in_rsci_idat[2]), 
      .CK(n_0), .Q(kmean_in_rsci_idat_bfwt_23_0[2]), .QN());
   MUX2_X1 i_0_5 (.A(kmean_in_rsci_idat[2]), .B(kmean_in_rsci_idat_bfwt_23_0[2]), 
      .S(kmean_in_rsci_bcwt), .Z(kmean_in_rsci_idat_mxwt[2]));
   DFF_X1 \kmean_in_rsci_idat_bfwt_23_0_reg[1]  (.D(kmean_in_rsci_idat[1]), 
      .CK(n_0), .Q(kmean_in_rsci_idat_bfwt_23_0[1]), .QN());
   MUX2_X1 i_0_4 (.A(kmean_in_rsci_idat[1]), .B(kmean_in_rsci_idat_bfwt_23_0[1]), 
      .S(kmean_in_rsci_bcwt), .Z(kmean_in_rsci_idat_mxwt[1]));
   DFF_X1 \kmean_in_rsci_idat_bfwt_23_0_reg[0]  (.D(kmean_in_rsci_idat[0]), 
      .CK(n_0), .Q(kmean_in_rsci_idat_bfwt_23_0[0]), .QN());
   MUX2_X1 i_0_3 (.A(kmean_in_rsci_idat[0]), .B(kmean_in_rsci_idat_bfwt_23_0[0]), 
      .S(kmean_in_rsci_bcwt), .Z(kmean_in_rsci_idat_mxwt[0]));
endmodule

module EdgeDetect_IP_Kmean_run_kmean_in_rsci(clk, rst, arst_n, kmean_in_rsc_dat, 
      kmean_in_rsc_vld, kmean_in_rsc_rdy, run_wen, kmean_in_rsci_oswt, 
      kmean_in_rsci_wen_comp, kmean_in_rsci_idat_mxwt);
   input clk;
   input rst;
   input arst_n;
   input [33:0]kmean_in_rsc_dat;
   input kmean_in_rsc_vld;
   output kmean_in_rsc_rdy;
   input run_wen;
   input kmean_in_rsci_oswt;
   output kmean_in_rsci_wen_comp;
   output [23:0]kmean_in_rsci_idat_mxwt;

   wire kmean_in_rsci_bcwt;
   wire EdgeDetect_IP_Kmean_run_kmean_in_rsci_kmean_in_wait_ctrl_inst_n_0_0;
   wire kmean_in_rsci_biwt;
   wire kmean_in_rsci_bdwt;

   INV_X1 i_0_0_0 (.A(kmean_in_rsci_oswt), .ZN(
      EdgeDetect_IP_Kmean_run_kmean_in_rsci_kmean_in_wait_ctrl_inst_n_0_0));
   AND2_X1 i_0_0_2 (.A1(kmean_in_rsc_rdy), .A2(kmean_in_rsc_vld), .ZN(
      kmean_in_rsci_biwt));
   AND2_X1 i_0_0_3 (.A1(kmean_in_rsci_oswt), .A2(run_wen), .ZN(
      kmean_in_rsci_bdwt));
   EdgeDetect_IP_Kmean_run_kmean_in_rsci_kmean_in_wait_dp EdgeDetect_IP_Kmean_run_kmean_in_rsci_kmean_in_wait_dp_inst (
      .clk(clk), .rst(rst), .arst_n(arst_n), .kmean_in_rsci_oswt(
      kmean_in_rsci_oswt), .kmean_in_rsci_wen_comp(kmean_in_rsci_wen_comp), 
      .kmean_in_rsci_idat_mxwt(kmean_in_rsci_idat_mxwt), .kmean_in_rsci_biwt(
      kmean_in_rsci_biwt), .kmean_in_rsci_bdwt(kmean_in_rsci_bdwt), 
      .kmean_in_rsci_bcwt(kmean_in_rsci_bcwt), .kmean_in_rsci_idat({1'b0, 1'b0, 
      1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, kmean_in_rsc_dat[23], 
      kmean_in_rsc_dat[22], kmean_in_rsc_dat[21], kmean_in_rsc_dat[20], 
      kmean_in_rsc_dat[19], kmean_in_rsc_dat[18], kmean_in_rsc_dat[17], 
      kmean_in_rsc_dat[16], kmean_in_rsc_dat[15], kmean_in_rsc_dat[14], 
      kmean_in_rsc_dat[13], kmean_in_rsc_dat[12], kmean_in_rsc_dat[11], 
      kmean_in_rsc_dat[10], kmean_in_rsc_dat[9], kmean_in_rsc_dat[8], 
      kmean_in_rsc_dat[7], kmean_in_rsc_dat[6], kmean_in_rsc_dat[5], 
      kmean_in_rsc_dat[4], kmean_in_rsc_dat[3], kmean_in_rsc_dat[2], 
      kmean_in_rsc_dat[1], kmean_in_rsc_dat[0]}));
   NOR2_X1 i_0_0_1 (.A1(
      EdgeDetect_IP_Kmean_run_kmean_in_rsci_kmean_in_wait_ctrl_inst_n_0_0), 
      .A2(kmean_in_rsci_bcwt), .ZN(kmean_in_rsc_rdy));
endmodule

module EdgeDetect_IP_Kmean_run(clk, rst, arst_n, kmean_in_rsc_dat, 
      kmean_in_rsc_vld, kmean_in_rsc_rdy, widthIn, heightIn, kmean_out_rsc_dat, 
      kmean_out_rsc_vld, kmean_out_rsc_rdy);
   input clk;
   input rst;
   input arst_n;
   input [33:0]kmean_in_rsc_dat;
   input kmean_in_rsc_vld;
   output kmean_in_rsc_rdy;
   input [10:0]widthIn;
   input [9:0]heightIn;
   output [23:0]kmean_out_rsc_dat;
   output kmean_out_rsc_vld;
   input kmean_out_rsc_rdy;

   wire kmean_out_rsci_wen_comp;
   wire [23:0]kmean_in_rsci_idat_mxwt;
   wire kmean_in_rsci_wen_comp;
   wire [1:0]EdgeDetect_IP_Kmean_run_run_fsm_inst_state_var;
   wire n_0_0;
   wire [23:0]kmean_in_crt_lpi_3_23_0;
   wire [2:0]KCOL_for_j_2_0_lpi_3;
   wire n_0_50;
   wire n_0_49;
   wire n_0_48;
   wire KCOL_asn_4_itm_1;
   wire KCOL_for_and_itm_1;
   wire [2:0]KCOL_for_j_2_0_lpi_3_dfm_st_1;
   wire reg_kmean_in_rsci_oswt_cse;
   wire reg_kmean_out_rsci_oswt_cse;
   wire KCOL_stage_0_2;
   wire KCOL_stage_0;
   wire exitL_exit_KCOL_for_sva;
   wire n_0_1;
   wire [9:0]KROW_y_sva;
   wire n_0_2;
   wire [10:0]KCOL_x_sva;
   wire [7:0]KROW_distance_pix_r_pixelType_lpi_3_dfm_1;
   wire [7:0]KROW_distance_pix_g_pixelType_lpi_3_dfm_1;
   wire [7:0]KROW_distance_pix_b_pixelType_lpi_3_dfm_1;
   wire [2:0]KCOL_for_KCOL_for_and_2_itm_1;
   wire [2:0]KCOL_for_KCOL_for_and_1_itm_1;
   wire [2:0]KCOL_for_KCOL_for_and_itm_1;
   wire n_0_3;
   wire n_0_4;
   wire n_0_5;
   wire n_0_6;
   wire n_0_7;
   wire n_0_8;
   wire n_0_1_172;
   wire n_0_1_173;
   wire n_0_1_174;
   wire n_0_1_0;
   wire n_0_1_175;
   wire n_0_1_1;
   wire n_0_1_176;
   wire n_0_1_2;
   wire n_0_1_177;
   wire n_0_1_3;
   wire n_0_1_178;
   wire n_0_1_4;
   wire n_0_1_179;
   wire n_0_1_5;
   wire n_0_1_180;
   wire n_0_1_6;
   wire n_0_1_181;
   wire n_0_1_7;
   wire n_0_1_182;
   wire n_0_1_8;
   wire n_0_1_9;
   wire n_0_1_10;
   wire n_0_1_11;
   wire n_0_1_12;
   wire n_0_1_13;
   wire n_0_1_14;
   wire n_0_1_15;
   wire n_0_1_16;
   wire n_0_1_17;
   wire n_0_1_18;
   wire n_0_1_19;
   wire n_0_1_20;
   wire n_0_1_21;
   wire n_0_1_22;
   wire n_0_1_23;
   wire n_0_1_24;
   wire n_0_1_25;
   wire n_0_1_26;
   wire n_0_1_27;
   wire n_0_1_28;
   wire n_0_1_29;
   wire n_0_1_30;
   wire n_0_1_31;
   wire n_0_1_32;
   wire n_0_1_33;
   wire n_0_1_34;
   wire n_0_1_35;
   wire n_0_1_36;
   wire n_0_1_37;
   wire n_0_1_38;
   wire n_0_1_39;
   wire n_0_1_40;
   wire n_0_1_41;
   wire n_0_1_42;
   wire n_0_1_43;
   wire n_0_1_44;
   wire n_0_1_183;
   wire n_0_1_45;
   wire n_0_1_46;
   wire n_0_1_47;
   wire n_0_1_48;
   wire n_0_1_49;
   wire n_0_1_50;
   wire n_0_1_51;
   wire n_0_1_52;
   wire n_0_1_53;
   wire n_0_1_54;
   wire n_0_1_55;
   wire n_0_1_184;
   wire n_0_1_56;
   wire n_0_1_185;
   wire n_0_1_57;
   wire n_0_1_186;
   wire n_0_1_58;
   wire n_0_1_187;
   wire n_0_1_59;
   wire n_0_1_188;
   wire n_0_1_60;
   wire n_0_1_61;
   wire n_0_1_62;
   wire n_0_1_63;
   wire n_0_1_64;
   wire n_0_1_65;
   wire n_0_1_66;
   wire n_0_1_67;
   wire n_0_1_68;
   wire n_0_1_69;
   wire n_0_1_70;
   wire n_0_1_71;
   wire n_0_1_72;
   wire n_0_1_73;
   wire n_0_1_74;
   wire n_0_1_189;
   wire n_0_1_75;
   wire n_0_1_76;
   wire n_0_1_77;
   wire n_0_1_78;
   wire n_0_1_79;
   wire n_0_1_80;
   wire n_0_1_81;
   wire n_0_1_82;
   wire n_0_1_83;
   wire n_0_1_84;
   wire n_0_1_85;
   wire n_0_1_190;
   wire n_0_1_86;
   wire n_0_1_191;
   wire n_0_1_87;
   wire n_0_1_192;
   wire n_0_1_88;
   wire n_0_1_193;
   wire n_0_1_89;
   wire n_0_1_194;
   wire n_0_1_90;
   wire n_0_1_91;
   wire n_0_1_92;
   wire n_0_1_93;
   wire n_0_1_94;
   wire n_0_1_95;
   wire n_0_1_96;
   wire n_0_1_97;
   wire n_0_1_98;
   wire n_0_1_99;
   wire n_0_1_100;
   wire n_0_1_101;
   wire n_0_1_102;
   wire n_0_1_103;
   wire n_0_1_104;
   wire n_0_1_105;
   wire n_0_1_106;
   wire n_0_1_107;
   wire n_0_1_108;
   wire n_0_1_109;
   wire n_0_1_110;
   wire n_0_1_111;
   wire n_0_1_112;
   wire n_0_1_113;
   wire n_0_1_114;
   wire n_0_1_115;
   wire n_0_1_116;
   wire n_0_1_117;
   wire n_0_1_118;
   wire n_0_1_195;
   wire n_0_1_119;
   wire n_0_1_120;
   wire n_0_1_121;
   wire n_0_1_122;
   wire n_0_1_123;
   wire n_0_1_124;
   wire n_0_1_125;
   wire n_0_1_126;
   wire n_0_1_127;
   wire n_0_1_128;
   wire n_0_1_129;
   wire n_0_1_196;
   wire n_0_1_130;
   wire n_0_1_197;
   wire n_0_1_131;
   wire n_0_1_198;
   wire n_0_1_132;
   wire n_0_1_199;
   wire n_0_1_133;
   wire n_0_1_200;
   wire n_0_1_134;
   wire n_0_1_135;
   wire n_0_1_136;
   wire n_0_1_137;
   wire n_0_1_138;
   wire n_0_1_139;
   wire n_0_1_140;
   wire n_0_1_141;
   wire n_0_1_142;
   wire n_0_1_143;
   wire n_0_1_144;
   wire n_0_1_145;
   wire n_0_1_146;
   wire n_0_1_147;
   wire n_0_1_148;
   wire n_0_1_149;
   wire n_0_1_150;
   wire n_0_1_151;
   wire n_0_1_152;
   wire n_0_1_153;
   wire n_0_1_154;
   wire n_0_1_155;
   wire n_0_1_156;
   wire n_0_1_157;
   wire n_0_1_158;
   wire n_0_1_159;
   wire n_0_1_160;
   wire n_0_1_161;
   wire n_0_1_162;
   wire KCOL_and_cse;
   wire n_0_47;
   wire n_0_1_201;
   wire n_0_1_202;
   wire EdgeDetect_IP_Kmean_run_run_fsm_inst_n_1;
   wire EdgeDetect_IP_Kmean_run_run_fsm_inst_n_3;
   wire n_0_1_203;
   wire n_0_1_204;
   wire n_0_1_205;
   wire n_0_1_206;
   wire n_0_1_207;
   wire n_0_1_208;
   wire n_0_1_210;
   wire n_0_1_211;
   wire n_0_1_212;
   wire n_0_1_213;
   wire n_0_1_214;
   wire n_0_1_215;
   wire n_0_1_216;
   wire n_0_1_217;
   wire n_0_1_218;
   wire n_0_1_219;
   wire EdgeDetect_IP_Kmean_run_run_fsm_inst_n_2;
   wire n_0_1_220;
   wire n_0_46;
   wire n_0_41;
   wire n_0_45;
   wire n_0_44;
   wire n_0_43;
   wire n_0_42;
   wire n_0_40;
   wire n_0_39;
   wire n_0_38;
   wire [2:0]MUX_v_3_2_2_return;
   wire n_0_37;
   wire n_0_36;
   wire n_0_1_221;
   wire n_0_35;
   wire n_0_1_222;
   wire n_0_34;
   wire n_0_1_223;
   wire n_0_1_224;
   wire n_0_1_225;
   wire n_0_1_226;
   wire n_0_1_227;
   wire n_0_1_231;
   wire n_0_1_232;
   wire n_0_1_233;
   wire n_0_1_234;
   wire n_0_1_243;
   wire n_0_1_244;
   wire n_0_1_245;
   wire n_0_1_246;
   wire n_0_1_247;
   wire n_0_1_248;
   wire n_0_1_249;
   wire n_0_1_250;
   wire n_0_1_251;
   wire n_0_1_252;
   wire n_0_1_253;
   wire n_0_1_254;
   wire n_0_1_255;
   wire n_0_1_256;
   wire n_0_1_257;
   wire n_0_1_258;
   wire n_0_1_266;
   wire n_0_33;
   wire n_0_1_285;
   wire n_0_32;
   wire n_0_1_286;
   wire n_0_1_287;
   wire n_0_1_288;
   wire n_0_1_289;
   wire n_0_1_290;
   wire n_0_1_291;
   wire n_0_1_292;
   wire n_0_1_293;
   wire n_0_1_294;
   wire n_0_1_295;
   wire n_0_1_296;
   wire n_0_1_297;
   wire n_0_1_298;
   wire n_0_1_299;
   wire n_0_1_300;
   wire [9:0]MUX_v_10_2_28_return;
   wire n_0_1_301;
   wire n_0_30;
   wire n_0_1_302;
   wire n_0_31;
   wire n_0_1_303;
   wire n_0_1_304;
   wire [10:0]MUX_v_11_2_24_return;
   wire n_0_1_305;
   wire n_0_1_306;
   wire n_0_1_307;
   wire n_0_1_308;
   wire n_0_1_309;
   wire n_0_1_310;
   wire [23:0]MUX_v_24_2_20_return;
   wire n_0_1_311;
   wire n_0_1_312;
   wire n_0_1_313;
   wire n_0_1_314;
   wire n_0_1_315;
   wire n_0_1_316;
   wire n_0_1_317;
   wire n_0_1_318;
   wire n_0_1_319;
   wire n_0_1_320;
   wire n_0_1_321;
   wire n_0_1_322;
   wire n_0_1_323;
   wire n_0_1_324;
   wire n_0_1_325;
   wire n_0_1_326;
   wire n_0_1_163;
   wire n_0_1_327;
   wire n_0_1_328;
   wire [7:0]MUX_v_8_2_218_return;
   wire n_0_1_329;
   wire n_0_1_330;
   wire n_0_1_331;
   wire n_0_1_332;
   wire n_0_1_333;
   wire n_0_1_334;
   wire n_0_1_335;
   wire n_0_1_336;
   wire n_0_1_337;
   wire n_0_1_338;
   wire n_0_1_339;
   wire n_0_1_340;
   wire n_0_1_341;
   wire n_0_1_342;
   wire n_0_1_343;
   wire n_0_1_344;
   wire n_0_1_345;
   wire n_0_1_346;
   wire n_0_1_347;
   wire n_0_1_348;
   wire n_0_1_349;
   wire n_0_1_350;
   wire n_0_1_351;
   wire n_0_1_164;
   wire n_0_1_352;
   wire n_0_1_353;
   wire [7:0]MUX_v_8_2_217_return;
   wire n_0_1_354;
   wire n_0_1_355;
   wire n_0_1_356;
   wire n_0_1_357;
   wire n_0_1_358;
   wire n_0_1_359;
   wire n_0_1_360;
   wire n_0_1_361;
   wire n_0_1_362;
   wire n_0_1_363;
   wire n_0_1_364;
   wire n_0_1_365;
   wire n_0_1_366;
   wire n_0_1_367;
   wire n_0_1_368;
   wire n_0_1_369;
   wire n_0_1_370;
   wire n_0_1_371;
   wire n_0_1_372;
   wire n_0_1_373;
   wire n_0_1_374;
   wire n_0_1_375;
   wire n_0_1_376;
   wire n_0_1_377;
   wire n_0_1_378;
   wire n_0_1_379;
   wire n_0_1_380;
   wire n_0_1_381;
   wire n_0_1_382;
   wire n_0_1_165;
   wire n_0_1_383;
   wire n_0_1_384;
   wire n_0_1_385;
   wire n_0_1_386;
   wire [7:0]MUX_v_8_2_216_return;
   wire n_0_1_387;
   wire n_0_1_388;
   wire n_0_1_389;
   wire n_0_1_390;
   wire n_0_1_391;
   wire n_0_1_166;
   wire n_0_1_392;
   wire n_0_1_393;
   wire n_0_1_167;
   wire n_0_1_394;
   wire n_0_29;
   wire [2:0]MUX_v_3_2_23_return;
   wire n_0_1_168;
   wire n_0_1_395;
   wire n_0_1_396;
   wire n_0_1_169;
   wire n_0_1_397;
   wire n_0_28;
   wire [2:0]MUX_v_3_2_24_return;
   wire n_0_1_170;
   wire n_0_1_398;
   wire n_0_1_399;
   wire n_0_1_171;
   wire n_0_1_400;
   wire n_0_1_401;
   wire n_0_1_402;
   wire n_0_1_403;
   wire n_0_1_404;
   wire n_0_1_405;
   wire n_0_1_406;
   wire n_0_27;
   wire n_0_1_407;
   wire run_wen;
   wire n_0_1_408;
   wire [2:0]MUX_v_3_2_25_return;
   wire n_0_25;
   wire n_0_23;
   wire n_0_1_409;
   wire n_0_24;
   wire n_0_22;
   wire n_0_21;
   wire n_0_26;
   wire n_0_1_410;
   wire n_0_19;
   wire n_0_17;
   wire n_0_1_411;
   wire n_0_18;
   wire n_0_16;
   wire n_0_15;
   wire n_0_20;
   wire n_0_1_412;
   wire n_0_13;
   wire n_0_11;
   wire n_0_1_413;
   wire n_0_12;
   wire n_0_10;
   wire n_0_9;
   wire n_0_14;
   wire n_0_1_414;
   wire [10:0]vector;
   wire n_0_1_415;
   wire n_0_1_416;
   wire n_0_1_417;
   wire n_0_1_418;
   wire n_0_1_419;
   wire n_0_1_420;
   wire n_0_1_421;
   wire n_0_1_422;
   wire n_0_1_423;
   wire n_0_1_424;
   wire n_0_1_425;
   wire n_0_1_426;
   wire n_0_1_427;
   wire n_0_1_428;
   wire n_0_1_429;
   wire n_0_1_430;
   wire n_0_1_431;
   wire n_0_1_432;
   wire n_0_1_433;
   wire n_0_1_434;
   wire n_0_1_435;
   wire n_0_1_436;
   wire n_0_1_438;
   wire n_0_1_439;
   wire n_0_1_440;
   wire n_0_1_441;
   wire n_0_1_442;
   wire n_0_1_443;
   wire n_0_1_444;
   wire n_0_1_446;
   wire n_0_1_447;
   wire n_0_1_449;
   wire n_0_1_450;
   wire n_0_1_451;
   wire n_0_1_452;
   wire n_0_1_453;
   wire n_0_1_454;
   wire n_0_1_455;
   wire n_0_1_456;
   wire n_0_1_457;
   wire n_0_1_458;
   wire n_0_1_459;
   wire n_0_1_460;
   wire n_0_1_209;
   wire n_0_1_228;
   wire n_0_1_229;
   wire n_0_1_230;
   wire n_0_1_235;
   wire n_0_1_236;
   wire n_0_1_237;
   wire n_0_1_238;
   wire n_0_1_239;
   wire n_0_1_240;
   wire n_0_1_241;
   wire n_0_1_242;
   wire n_0_1_259;
   wire n_0_1_260;
   wire n_0_1_261;
   wire n_0_1_262;
   wire n_0_1_263;
   wire n_0_1_264;
   wire n_0_1_265;
   wire n_0_1_267;
   wire n_0_1_268;
   wire n_0_1_269;
   wire n_0_1_270;
   wire n_0_1_271;
   wire n_0_1_272;
   wire n_0_1_273;
   wire n_0_1_274;
   wire n_0_1_275;
   wire n_0_1_276;
   wire n_0_1_277;
   wire n_0_1_278;
   wire n_0_1_279;
   wire n_0_1_280;
   wire n_0_1_281;
   wire n_0_1_282;
   wire n_0_1_283;
   wire n_0_1_284;
   wire n_0_1_437;
   wire n_0_1_445;
   wire n_0_1_448;

   assign kmean_out_rsc_dat[23] = kmean_out_rsc_dat[19];

   INV_X1 i_0_1_434 (.A(rst), .ZN(n_0_1_439));
   INV_X1 i_0_1_474 (.A(KCOL_stage_0), .ZN(n_0_1_438));
   NOR2_X1 i_0_1_201 (.A1(rst), .A2(n_0_1_438), .ZN(n_0_1_285));
   AND2_X1 i_0_1_200 (.A1(EdgeDetect_IP_Kmean_run_run_fsm_inst_state_var[0]), 
      .A2(n_0_1_285), .ZN(n_0_33));
   NAND2_X1 i_0_1_100 (.A1(n_0_1_439), .A2(n_0_1_408), .ZN(
      EdgeDetect_IP_Kmean_run_run_fsm_inst_n_1));
   CLKGATE_X1 clk_gate_reg_kmean_in_rsci_oswt_cse_reg (.CK(clk), .E(
      EdgeDetect_IP_Kmean_run_run_fsm_inst_n_1), .GCK(n_0_3));
   DFFR_X1 KCOL_stage_0_2_reg (.D(n_0_33), .RN(arst_n), .CK(n_0_3), .Q(
      KCOL_stage_0_2), .QN());
   NAND2_X1 i_0_1_325 (.A1(EdgeDetect_IP_Kmean_run_run_fsm_inst_state_var[0]), 
      .A2(n_0_1_446), .ZN(n_0_1_386));
   INV_X1 i_0_1_324 (.A(n_0_1_386), .ZN(n_0_1_385));
   AND2_X1 i_0_1_238 (.A1(EdgeDetect_IP_Kmean_run_run_fsm_inst_state_var[0]), 
      .A2(n_0_1_181), .ZN(MUX_v_11_2_24_return[8]));
   NOR2_X1 i_0_1_231 (.A1(EdgeDetect_IP_Kmean_run_run_fsm_inst_state_var[0]), 
      .A2(n_0_1_408), .ZN(n_0_31));
   AOI21_X1 i_0_1_230 (.A(n_0_31), .B1(run_wen), .B2(n_0_1_303), .ZN(n_0_1_302));
   INV_X1 i_0_1_229 (.A(n_0_1_302), .ZN(n_0_30));
   CLKGATE_X1 clk_gate_KCOL_x_sva_reg (.CK(clk), .E(n_0_30), .GCK(n_0_2));
   DFF_X1 \KCOL_x_sva_reg[8]  (.D(MUX_v_11_2_24_return[8]), .CK(n_0_2), .Q(
      KCOL_x_sva[8]), .QN());
   INV_X1 i_0_1_395 (.A(KCOL_x_sva[8]), .ZN(vector[8]));
   OAI22_X1 i_0_1_161 (.A1(n_0_1_440), .A2(n_0_1_385), .B1(vector[8]), .B2(
      n_0_1_386), .ZN(n_0_1_290));
   INV_X1 i_0_1_470 (.A(EdgeDetect_IP_Kmean_run_run_fsm_inst_state_var[0]), 
      .ZN(n_0_1_264));
   NAND2_X1 i_0_1_228 (.A1(n_0_1_264), .A2(n_0_1_446), .ZN(n_0_1_301));
   AND2_X1 i_0_1_220 (.A1(n_0_1_180), .A2(n_0_1_301), .ZN(
      MUX_v_10_2_28_return[7]));
   CLKGATE_X1 clk_gate_KROW_y_sva_reg (.CK(clk), .E(n_0_31), .GCK(n_0_1));
   DFF_X1 \KROW_y_sva_reg[7]  (.D(MUX_v_10_2_28_return[7]), .CK(n_0_1), .Q(
      KROW_y_sva[7]), .QN());
   NAND2_X1 i_0_1_163 (.A1(KROW_y_sva[7]), .A2(n_0_1_386), .ZN(n_0_1_292));
   AND2_X1 i_0_1_239 (.A1(EdgeDetect_IP_Kmean_run_run_fsm_inst_state_var[0]), 
      .A2(n_0_1_180), .ZN(MUX_v_11_2_24_return[7]));
   DFF_X1 \KCOL_x_sva_reg[7]  (.D(MUX_v_11_2_24_return[7]), .CK(n_0_2), .Q(
      KCOL_x_sva[7]), .QN());
   INV_X1 i_0_1_430 (.A(KCOL_x_sva[7]), .ZN(vector[7]));
   OAI21_X1 i_0_1_162 (.A(n_0_1_292), .B1(vector[7]), .B2(n_0_1_386), .ZN(
      n_0_1_291));
   AND2_X1 i_0_1_221 (.A1(n_0_1_179), .A2(n_0_1_301), .ZN(
      MUX_v_10_2_28_return[6]));
   DFF_X1 \KROW_y_sva_reg[6]  (.D(MUX_v_10_2_28_return[6]), .CK(n_0_1), .Q(
      KROW_y_sva[6]), .QN());
   INV_X1 i_0_1_436 (.A(KROW_y_sva[6]), .ZN(n_0_1_441));
   AND2_X1 i_0_1_240 (.A1(EdgeDetect_IP_Kmean_run_run_fsm_inst_state_var[0]), 
      .A2(n_0_1_179), .ZN(MUX_v_11_2_24_return[6]));
   DFF_X1 \KCOL_x_sva_reg[6]  (.D(MUX_v_11_2_24_return[6]), .CK(n_0_2), .Q(
      KCOL_x_sva[6]), .QN());
   INV_X1 i_0_1_432 (.A(KCOL_x_sva[6]), .ZN(vector[6]));
   OAI22_X1 i_0_1_164 (.A1(n_0_1_441), .A2(n_0_1_385), .B1(vector[6]), .B2(
      n_0_1_386), .ZN(n_0_1_293));
   AND2_X1 i_0_1_222 (.A1(n_0_1_178), .A2(n_0_1_301), .ZN(
      MUX_v_10_2_28_return[5]));
   DFF_X1 \KROW_y_sva_reg[5]  (.D(MUX_v_10_2_28_return[5]), .CK(n_0_1), .Q(
      KROW_y_sva[5]), .QN());
   NAND2_X1 i_0_1_166 (.A1(KROW_y_sva[5]), .A2(n_0_1_386), .ZN(n_0_1_295));
   AND2_X1 i_0_1_241 (.A1(EdgeDetect_IP_Kmean_run_run_fsm_inst_state_var[0]), 
      .A2(n_0_1_178), .ZN(MUX_v_11_2_24_return[5]));
   DFF_X1 \KCOL_x_sva_reg[5]  (.D(MUX_v_11_2_24_return[5]), .CK(n_0_2), .Q(
      KCOL_x_sva[5]), .QN());
   INV_X1 i_0_1_398 (.A(KCOL_x_sva[5]), .ZN(vector[5]));
   OAI21_X1 i_0_1_165 (.A(n_0_1_295), .B1(vector[5]), .B2(n_0_1_386), .ZN(
      n_0_1_294));
   AND2_X1 i_0_1_223 (.A1(n_0_1_177), .A2(n_0_1_301), .ZN(
      MUX_v_10_2_28_return[4]));
   DFF_X1 \KROW_y_sva_reg[4]  (.D(MUX_v_10_2_28_return[4]), .CK(n_0_1), .Q(
      KROW_y_sva[4]), .QN());
   INV_X1 i_0_1_437 (.A(KROW_y_sva[4]), .ZN(n_0_1_442));
   AND2_X1 i_0_1_242 (.A1(EdgeDetect_IP_Kmean_run_run_fsm_inst_state_var[0]), 
      .A2(n_0_1_177), .ZN(MUX_v_11_2_24_return[4]));
   DFF_X1 \KCOL_x_sva_reg[4]  (.D(MUX_v_11_2_24_return[4]), .CK(n_0_2), .Q(
      KCOL_x_sva[4]), .QN());
   INV_X1 i_0_1_399 (.A(KCOL_x_sva[4]), .ZN(vector[4]));
   OAI22_X1 i_0_1_167 (.A1(n_0_1_442), .A2(n_0_1_385), .B1(vector[4]), .B2(
      n_0_1_386), .ZN(n_0_1_296));
   AND2_X1 i_0_1_224 (.A1(n_0_1_176), .A2(n_0_1_301), .ZN(
      MUX_v_10_2_28_return[3]));
   DFF_X1 \KROW_y_sva_reg[3]  (.D(MUX_v_10_2_28_return[3]), .CK(n_0_1), .Q(
      KROW_y_sva[3]), .QN());
   INV_X1 i_0_1_438 (.A(KROW_y_sva[3]), .ZN(n_0_1_443));
   AND2_X1 i_0_1_243 (.A1(EdgeDetect_IP_Kmean_run_run_fsm_inst_state_var[0]), 
      .A2(n_0_1_176), .ZN(MUX_v_11_2_24_return[3]));
   DFF_X1 \KCOL_x_sva_reg[3]  (.D(MUX_v_11_2_24_return[3]), .CK(n_0_2), .Q(
      KCOL_x_sva[3]), .QN());
   INV_X1 i_0_1_400 (.A(KCOL_x_sva[3]), .ZN(vector[3]));
   OAI22_X1 i_0_1_168 (.A1(n_0_1_443), .A2(n_0_1_385), .B1(vector[3]), .B2(
      n_0_1_386), .ZN(n_0_1_297));
   AND2_X1 i_0_1_225 (.A1(n_0_1_175), .A2(n_0_1_301), .ZN(
      MUX_v_10_2_28_return[2]));
   DFF_X1 \KROW_y_sva_reg[2]  (.D(MUX_v_10_2_28_return[2]), .CK(n_0_1), .Q(
      KROW_y_sva[2]), .QN());
   INV_X1 i_0_1_439 (.A(KROW_y_sva[2]), .ZN(n_0_1_444));
   AND2_X1 i_0_1_244 (.A1(EdgeDetect_IP_Kmean_run_run_fsm_inst_state_var[0]), 
      .A2(n_0_1_175), .ZN(MUX_v_11_2_24_return[2]));
   DFF_X1 \KCOL_x_sva_reg[2]  (.D(MUX_v_11_2_24_return[2]), .CK(n_0_2), .Q(
      KCOL_x_sva[2]), .QN());
   INV_X1 i_0_1_472 (.A(KCOL_x_sva[2]), .ZN(vector[2]));
   OAI22_X1 i_0_1_174 (.A1(n_0_1_444), .A2(n_0_1_385), .B1(vector[2]), .B2(
      n_0_1_386), .ZN(n_0_1_298));
   AND2_X1 i_0_1_226 (.A1(n_0_1_174), .A2(n_0_1_301), .ZN(
      MUX_v_10_2_28_return[1]));
   DFF_X1 \KROW_y_sva_reg[1]  (.D(MUX_v_10_2_28_return[1]), .CK(n_0_1), .Q(
      KROW_y_sva[1]), .QN());
   NAND2_X1 i_0_1_176 (.A1(KROW_y_sva[1]), .A2(n_0_1_386), .ZN(n_0_1_300));
   AND2_X1 i_0_1_245 (.A1(EdgeDetect_IP_Kmean_run_run_fsm_inst_state_var[0]), 
      .A2(n_0_1_174), .ZN(MUX_v_11_2_24_return[1]));
   DFF_X1 \KCOL_x_sva_reg[1]  (.D(MUX_v_11_2_24_return[1]), .CK(n_0_2), .Q(
      KCOL_x_sva[1]), .QN());
   INV_X1 i_0_1_431 (.A(KCOL_x_sva[1]), .ZN(vector[1]));
   OAI21_X1 i_0_1_175 (.A(n_0_1_300), .B1(vector[1]), .B2(n_0_1_386), .ZN(
      n_0_1_299));
   AND2_X1 i_0_1_227 (.A1(n_0_1_308), .A2(n_0_1_301), .ZN(
      MUX_v_10_2_28_return[0]));
   DFF_X1 \KROW_y_sva_reg[0]  (.D(MUX_v_10_2_28_return[0]), .CK(n_0_1), .Q(
      KROW_y_sva[0]), .QN());
   NOR2_X1 i_0_1_246 (.A1(n_0_1_264), .A2(n_0_1_307), .ZN(
      MUX_v_11_2_24_return[0]));
   DFF_X1 \KCOL_x_sva_reg[0]  (.D(MUX_v_11_2_24_return[0]), .CK(n_0_2), .Q(
      KCOL_x_sva[0]), .QN());
   AOI22_X1 i_0_1_180 (.A1(KROW_y_sva[0]), .A2(n_0_1_386), .B1(KCOL_x_sva[0]), 
      .B2(n_0_1_385), .ZN(n_0_1_308));
   INV_X1 i_0_1_179 (.A(n_0_1_308), .ZN(n_0_1_307));
   HA_X1 i_0_1_1 (.A(n_0_1_299), .B(n_0_1_307), .CO(n_0_1_0), .S(n_0_1_174));
   HA_X1 i_0_1_2 (.A(n_0_1_298), .B(n_0_1_0), .CO(n_0_1_1), .S(n_0_1_175));
   HA_X1 i_0_1_3 (.A(n_0_1_297), .B(n_0_1_1), .CO(n_0_1_2), .S(n_0_1_176));
   HA_X1 i_0_1_4 (.A(n_0_1_296), .B(n_0_1_2), .CO(n_0_1_3), .S(n_0_1_177));
   HA_X1 i_0_1_5 (.A(n_0_1_294), .B(n_0_1_3), .CO(n_0_1_4), .S(n_0_1_178));
   HA_X1 i_0_1_6 (.A(n_0_1_293), .B(n_0_1_4), .CO(n_0_1_5), .S(n_0_1_179));
   HA_X1 i_0_1_7 (.A(n_0_1_291), .B(n_0_1_5), .CO(n_0_1_6), .S(n_0_1_180));
   HA_X1 i_0_1_8 (.A(n_0_1_290), .B(n_0_1_6), .CO(n_0_1_7), .S(n_0_1_181));
   AND2_X1 i_0_1_219 (.A1(n_0_1_181), .A2(n_0_1_301), .ZN(
      MUX_v_10_2_28_return[8]));
   DFF_X1 \KROW_y_sva_reg[8]  (.D(MUX_v_10_2_28_return[8]), .CK(n_0_1), .Q(
      KROW_y_sva[8]), .QN());
   INV_X1 i_0_1_435 (.A(KROW_y_sva[8]), .ZN(n_0_1_440));
   NAND2_X1 i_0_1_469 (.A1(n_0_1_264), .A2(
      EdgeDetect_IP_Kmean_run_run_fsm_inst_state_var[1]), .ZN(n_0_1_263));
   INV_X1 i_0_1_468 (.A(n_0_1_263), .ZN(n_0_1_262));
   OAI22_X1 i_0_1_465 (.A1(widthIn[1]), .A2(n_0_1_262), .B1(heightIn[1]), 
      .B2(n_0_1_263), .ZN(n_0_1_259));
   OAI22_X1 i_0_1_464 (.A1(widthIn[0]), .A2(n_0_1_262), .B1(heightIn[0]), 
      .B2(n_0_1_263), .ZN(n_0_1_242));
   NAND2_X1 i_0_1_463 (.A1(n_0_1_259), .A2(n_0_1_242), .ZN(n_0_1_241));
   OAI22_X1 i_0_1_467 (.A1(widthIn[2]), .A2(n_0_1_262), .B1(heightIn[2]), 
      .B2(n_0_1_263), .ZN(n_0_1_261));
   INV_X1 i_0_1_466 (.A(n_0_1_261), .ZN(n_0_1_260));
   NOR2_X1 i_0_1_494 (.A1(n_0_1_241), .A2(n_0_1_260), .ZN(n_0_1_437));
   AOI22_X1 i_0_1_493 (.A1(widthIn[3]), .A2(n_0_1_263), .B1(heightIn[3]), 
      .B2(n_0_1_262), .ZN(n_0_1_284));
   NAND2_X1 i_0_1_492 (.A1(n_0_1_437), .A2(n_0_1_284), .ZN(n_0_1_283));
   AOI22_X1 i_0_1_491 (.A1(n_0_1_263), .A2(widthIn[4]), .B1(n_0_1_262), .B2(
      heightIn[4]), .ZN(n_0_1_282));
   INV_X1 i_0_1_490 (.A(n_0_1_282), .ZN(n_0_1_281));
   NOR2_X1 i_0_1_489 (.A1(n_0_1_283), .A2(n_0_1_281), .ZN(n_0_1_280));
   AOI22_X1 i_0_1_488 (.A1(n_0_1_263), .A2(widthIn[5]), .B1(n_0_1_262), .B2(
      heightIn[5]), .ZN(n_0_1_279));
   NAND2_X1 i_0_1_487 (.A1(n_0_1_280), .A2(n_0_1_279), .ZN(n_0_1_278));
   AOI22_X1 i_0_1_486 (.A1(n_0_1_263), .A2(widthIn[6]), .B1(n_0_1_262), .B2(
      heightIn[6]), .ZN(n_0_1_277));
   INV_X1 i_0_1_485 (.A(n_0_1_277), .ZN(n_0_1_276));
   NOR2_X1 i_0_1_484 (.A1(n_0_1_278), .A2(n_0_1_276), .ZN(n_0_1_275));
   AOI22_X1 i_0_1_482 (.A1(n_0_1_263), .A2(widthIn[7]), .B1(n_0_1_262), .B2(
      heightIn[7]), .ZN(n_0_1_274));
   NAND2_X1 i_0_1_481 (.A1(n_0_1_275), .A2(n_0_1_274), .ZN(n_0_1_273));
   AOI22_X1 i_0_1_480 (.A1(n_0_1_263), .A2(widthIn[8]), .B1(n_0_1_262), .B2(
      heightIn[8]), .ZN(n_0_1_272));
   XNOR2_X1 i_0_1_141 (.A(n_0_1_273), .B(n_0_1_272), .ZN(n_0_1_227));
   XOR2_X1 i_0_1_116 (.A(n_0_1_440), .B(n_0_1_227), .Z(n_0_1_218));
   OAI21_X1 i_0_1_113 (.A(n_0_1_278), .B1(n_0_1_280), .B2(n_0_1_279), .ZN(
      n_0_1_215));
   XNOR2_X1 i_0_1_112 (.A(KROW_y_sva[5]), .B(n_0_1_215), .ZN(n_0_1_214));
   NOR2_X1 i_0_1_496 (.A1(KROW_y_sva[0]), .A2(heightIn[0]), .ZN(n_0_1_448));
   AOI211_X1 i_0_1_495 (.A(n_0_1_448), .B(n_0_1_263), .C1(KROW_y_sva[0]), 
      .C2(heightIn[0]), .ZN(n_0_1_445));
   OAI21_X1 i_0_1_108 (.A(n_0_1_241), .B1(n_0_1_242), .B2(n_0_1_259), .ZN(
      n_0_1_210));
   XNOR2_X1 i_0_1_107 (.A(KROW_y_sva[1]), .B(n_0_1_210), .ZN(n_0_1_208));
   AOI21_X1 i_0_1_110 (.A(n_0_1_437), .B1(n_0_1_241), .B2(n_0_1_260), .ZN(
      n_0_1_212));
   XNOR2_X1 i_0_1_109 (.A(n_0_1_444), .B(n_0_1_212), .ZN(n_0_1_211));
   OAI21_X1 i_0_1_143 (.A(n_0_1_283), .B1(n_0_1_437), .B2(n_0_1_284), .ZN(
      n_0_1_244));
   XOR2_X1 i_0_1_111 (.A(n_0_1_443), .B(n_0_1_244), .Z(n_0_1_213));
   NAND4_X1 i_0_1_106 (.A1(n_0_1_445), .A2(n_0_1_208), .A3(n_0_1_211), .A4(
      n_0_1_213), .ZN(n_0_1_207));
   AND2_X1 i_0_1_153 (.A1(n_0_1_283), .A2(n_0_1_281), .ZN(n_0_1_251));
   NOR2_X1 i_0_1_152 (.A1(n_0_1_280), .A2(n_0_1_251), .ZN(n_0_1_250));
   INV_X1 i_0_1_151 (.A(n_0_1_250), .ZN(n_0_1_249));
   AOI221_X1 i_0_1_105 (.A(n_0_1_207), .B1(n_0_1_442), .B2(n_0_1_249), .C1(
      KROW_y_sva[4]), .C2(n_0_1_250), .ZN(n_0_1_206));
   AOI21_X1 i_0_1_145 (.A(n_0_1_275), .B1(n_0_1_278), .B2(n_0_1_276), .ZN(
      n_0_1_247));
   INV_X1 i_0_1_144 (.A(n_0_1_247), .ZN(n_0_1_246));
   AOI22_X1 i_0_1_104 (.A1(KROW_y_sva[6]), .A2(n_0_1_247), .B1(n_0_1_441), 
      .B2(n_0_1_246), .ZN(n_0_1_205));
   OAI21_X1 i_0_1_115 (.A(n_0_1_273), .B1(n_0_1_275), .B2(n_0_1_274), .ZN(
      n_0_1_217));
   XNOR2_X1 i_0_1_114 (.A(KROW_y_sva[7]), .B(n_0_1_217), .ZN(n_0_1_216));
   NAND4_X1 i_0_1_103 (.A1(n_0_1_214), .A2(n_0_1_206), .A3(n_0_1_205), .A4(
      n_0_1_216), .ZN(n_0_1_204));
   NAND2_X1 i_0_1_159 (.A1(KROW_y_sva[9]), .A2(n_0_1_386), .ZN(n_0_1_289));
   INV_X1 i_0_1_433 (.A(KCOL_x_sva[9]), .ZN(vector[9]));
   OAI21_X1 i_0_1_158 (.A(n_0_1_289), .B1(vector[9]), .B2(n_0_1_386), .ZN(
      n_0_1_288));
   HA_X1 i_0_1_9 (.A(n_0_1_288), .B(n_0_1_7), .CO(n_0_1_8), .S(n_0_1_182));
   AND2_X1 i_0_1_218 (.A1(n_0_1_182), .A2(n_0_1_301), .ZN(
      MUX_v_10_2_28_return[9]));
   DFF_X1 \KROW_y_sva_reg[9]  (.D(MUX_v_10_2_28_return[9]), .CK(n_0_1), .Q(
      KROW_y_sva[9]), .QN());
   AOI22_X1 i_0_1_479 (.A1(n_0_1_263), .A2(widthIn[9]), .B1(n_0_1_262), .B2(
      heightIn[9]), .ZN(n_0_1_271));
   AND3_X1 i_0_1_478 (.A1(n_0_1_275), .A2(n_0_1_274), .A3(n_0_1_272), .ZN(
      n_0_1_270));
   NAND2_X1 i_0_1_477 (.A1(n_0_1_271), .A2(n_0_1_270), .ZN(n_0_1_269));
   OAI21_X1 i_0_1_475 (.A(n_0_1_269), .B1(n_0_1_271), .B2(n_0_1_270), .ZN(
      n_0_1_267));
   XOR2_X1 i_0_1_117 (.A(KROW_y_sva[9]), .B(n_0_1_267), .Z(n_0_1_219));
   OAI33_X1 i_0_1_102 (.A1(KCOL_stage_0), .A2(KCOL_stage_0_2), .A3(n_0_1_386), 
      .B1(n_0_1_218), .B2(n_0_1_204), .B3(n_0_1_219), .ZN(n_0_1_203));
   AND2_X1 i_0_1_101 (.A1(n_0_1_439), .A2(n_0_1_203), .ZN(
      EdgeDetect_IP_Kmean_run_run_fsm_inst_n_3));
   DFFR_X1 \EdgeDetect_IP_Kmean_run_run_fsm_inst_state_var_reg[1]  (.D(
      EdgeDetect_IP_Kmean_run_run_fsm_inst_n_3), .RN(arst_n), .CK(n_0_3), 
      .Q(EdgeDetect_IP_Kmean_run_run_fsm_inst_state_var[1]), .QN());
   INV_X1 i_0_1_440 (.A(EdgeDetect_IP_Kmean_run_run_fsm_inst_state_var[1]), 
      .ZN(n_0_1_446));
   OAI21_X1 i_0_1_119 (.A(n_0_1_446), .B1(KCOL_stage_0), .B2(KCOL_stage_0_2), 
      .ZN(n_0_1_220));
   AOI21_X1 i_0_1_118 (.A(rst), .B1(
      EdgeDetect_IP_Kmean_run_run_fsm_inst_state_var[0]), .B2(n_0_1_220), 
      .ZN(EdgeDetect_IP_Kmean_run_run_fsm_inst_n_2));
   DFFR_X1 \EdgeDetect_IP_Kmean_run_run_fsm_inst_state_var_reg[0]  (.D(
      EdgeDetect_IP_Kmean_run_run_fsm_inst_n_2), .RN(arst_n), .CK(n_0_3), 
      .Q(EdgeDetect_IP_Kmean_run_run_fsm_inst_state_var[0]), .QN());
   AND2_X1 i_0_1_237 (.A1(EdgeDetect_IP_Kmean_run_run_fsm_inst_state_var[0]), 
      .A2(n_0_1_182), .ZN(MUX_v_11_2_24_return[9]));
   DFF_X1 \KCOL_x_sva_reg[9]  (.D(MUX_v_11_2_24_return[9]), .CK(n_0_2), .Q(
      KCOL_x_sva[9]), .QN());
   XNOR2_X1 i_0_1_473 (.A(KCOL_x_sva[9]), .B(n_0_1_267), .ZN(n_0_1_265));
   XOR2_X1 i_0_1_134 (.A(KCOL_x_sva[8]), .B(n_0_1_227), .Z(n_0_1_226));
   XOR2_X1 i_0_1_142 (.A(vector[3]), .B(n_0_1_244), .Z(n_0_1_243));
   OR2_X1 i_0_1_460 (.A1(KCOL_x_sva[0]), .A2(n_0_1_259), .ZN(n_0_1_238));
   INV_X1 i_0_1_471 (.A(KCOL_x_sva[0]), .ZN(vector[0]));
   OAI211_X1 i_0_1_458 (.A(n_0_1_238), .B(n_0_1_241), .C1(vector[0]), .C2(
      n_0_1_242), .ZN(n_0_1_236));
   OAI22_X1 i_0_1_462 (.A1(KCOL_x_sva[2]), .A2(n_0_1_260), .B1(vector[2]), 
      .B2(n_0_1_261), .ZN(n_0_1_240));
   INV_X1 i_0_1_461 (.A(n_0_1_240), .ZN(n_0_1_239));
   NOR3_X1 i_0_1_457 (.A1(KCOL_x_sva[1]), .A2(n_0_1_236), .A3(n_0_1_239), 
      .ZN(n_0_1_235));
   OAI33_X1 i_0_1_459 (.A1(n_0_1_241), .A2(n_0_1_240), .A3(vector[0]), .B1(
      n_0_1_239), .B2(n_0_1_238), .B3(n_0_1_242), .ZN(n_0_1_237));
   AOI21_X1 i_0_1_456 (.A(n_0_1_235), .B1(KCOL_x_sva[1]), .B2(n_0_1_237), 
      .ZN(n_0_1_230));
   INV_X1 i_0_1_455 (.A(n_0_1_230), .ZN(n_0_1_229));
   XNOR2_X1 i_0_1_155 (.A(KCOL_x_sva[5]), .B(n_0_1_279), .ZN(n_0_1_253));
   INV_X1 i_0_1_154 (.A(n_0_1_253), .ZN(n_0_1_252));
   AOI21_X1 i_0_1_150 (.A(KCOL_x_sva[4]), .B1(n_0_1_252), .B2(n_0_1_250), 
      .ZN(n_0_1_248));
   AOI21_X1 i_0_1_148 (.A(n_0_1_248), .B1(vector[6]), .B2(n_0_1_246), .ZN(
      n_0_1_233));
   XOR2_X1 i_0_1_170 (.A(vector[7]), .B(n_0_1_274), .Z(n_0_1_255));
   AOI211_X1 i_0_1_169 (.A(vector[6]), .B(n_0_1_255), .C1(n_0_1_278), .C2(
      n_0_1_276), .ZN(n_0_1_254));
   AOI221_X1 i_0_1_160 (.A(vector[4]), .B1(n_0_1_252), .B2(n_0_1_251), .C1(
      n_0_1_280), .C2(n_0_1_253), .ZN(n_0_1_245));
   INV_X1 i_0_1_181 (.A(n_0_1_275), .ZN(n_0_1_266));
   AOI211_X1 i_0_1_149 (.A(n_0_1_254), .B(n_0_1_245), .C1(n_0_1_266), .C2(
      n_0_1_255), .ZN(n_0_1_234));
   NAND4_X1 i_0_1_147 (.A1(n_0_1_243), .A2(n_0_1_229), .A3(n_0_1_233), .A4(
      n_0_1_234), .ZN(n_0_1_232));
   INV_X1 i_0_1_483 (.A(n_0_1_8), .ZN(n_0_1_447));
   NAND2_X1 i_0_1_236 (.A1(n_0_1_446), .A2(KCOL_x_sva[10]), .ZN(n_0_1_306));
   INV_X1 i_0_1_235 (.A(n_0_1_306), .ZN(n_0_1_305));
   AOI221_X1 i_0_1_234 (.A(n_0_1_264), .B1(n_0_1_447), .B2(n_0_1_306), .C1(
      n_0_1_8), .C2(n_0_1_305), .ZN(MUX_v_11_2_24_return[10]));
   DFF_X1 \KCOL_x_sva_reg[10]  (.D(MUX_v_11_2_24_return[10]), .CK(n_0_2), 
      .Q(KCOL_x_sva[10]), .QN());
   INV_X1 i_0_1_393 (.A(KCOL_x_sva[10]), .ZN(vector[10]));
   AND2_X1 i_0_1_173 (.A1(widthIn[10]), .A2(n_0_1_263), .ZN(n_0_1_258));
   XNOR2_X1 i_0_1_172 (.A(vector[10]), .B(n_0_1_258), .ZN(n_0_1_257));
   INV_X1 i_0_1_476 (.A(n_0_1_269), .ZN(n_0_1_268));
   INV_X1 i_0_1_171 (.A(n_0_1_257), .ZN(n_0_1_256));
   AOI221_X1 i_0_1_146 (.A(n_0_1_232), .B1(n_0_1_269), .B2(n_0_1_257), .C1(
      n_0_1_268), .C2(n_0_1_256), .ZN(n_0_1_231));
   NAND4_X1 i_0_1_139 (.A1(n_0_1_265), .A2(n_0_1_226), .A3(n_0_1_231), .A4(
      n_0_1_303), .ZN(n_0_1_224));
   AOI22_X1 i_0_1_138 (.A1(n_0_1_285), .A2(n_0_1_224), .B1(n_0_1_264), .B2(
      n_0_1_439), .ZN(n_0_1_223));
   INV_X1 i_0_1_137 (.A(n_0_1_223), .ZN(n_0_34));
   DFFR_X1 KCOL_stage_0_reg (.D(n_0_34), .RN(arst_n), .CK(n_0_3), .Q(
      KCOL_stage_0), .QN());
   NAND2_X1 i_0_1_356 (.A1(KCOL_stage_0), .A2(run_wen), .ZN(n_0_1_407));
   OAI21_X1 i_0_1_120 (.A(n_0_1_439), .B1(n_0_1_407), .B2(n_0_1_303), .ZN(n_0_46));
   AND2_X1 i_0_1_125 (.A1(n_0_1_454), .A2(KCOL_for_j_2_0_lpi_3[1]), .ZN(
      MUX_v_3_2_2_return[1]));
   HA_X1 i_0_1_0 (.A(MUX_v_3_2_2_return[1]), .B(MUX_v_3_2_2_return[0]), .CO(
      n_0_1_173), .S(n_0_1_172));
   AND2_X1 i_0_1_123 (.A1(n_0_1_439), .A2(n_0_1_172), .ZN(n_0_44));
   MUX2_X1 i_0_0_1 (.A(KCOL_for_j_2_0_lpi_3[1]), .B(n_0_44), .S(n_0_46), 
      .Z(n_0_49));
   DFFR_X1 \KCOL_for_j_2_0_lpi_3_reg[1]  (.D(n_0_49), .RN(arst_n), .CK(clk), 
      .Q(KCOL_for_j_2_0_lpi_3[1]), .QN());
   NOR2_X1 i_0_1_124 (.A1(rst), .A2(MUX_v_3_2_2_return[0]), .ZN(n_0_43));
   MUX2_X1 i_0_0_0 (.A(KCOL_for_j_2_0_lpi_3[0]), .B(n_0_43), .S(n_0_46), 
      .Z(n_0_50));
   DFFR_X1 \KCOL_for_j_2_0_lpi_3_reg[0]  (.D(n_0_50), .RN(arst_n), .CK(clk), 
      .Q(KCOL_for_j_2_0_lpi_3[0]), .QN());
   AND2_X1 i_0_1_121 (.A1(n_0_1_439), .A2(n_0_1_173), .ZN(n_0_45));
   MUX2_X1 i_0_0_2 (.A(KCOL_for_j_2_0_lpi_3[2]), .B(n_0_45), .S(n_0_46), 
      .Z(n_0_48));
   DFFR_X1 \KCOL_for_j_2_0_lpi_3_reg[2]  (.D(n_0_48), .RN(arst_n), .CK(clk), 
      .Q(KCOL_for_j_2_0_lpi_3[2]), .QN());
   NAND2_X1 i_0_1_178 (.A1(n_0_1_454), .A2(KCOL_for_j_2_0_lpi_3[2]), .ZN(
      n_0_1_304));
   NOR3_X1 i_0_1_177 (.A1(KCOL_for_j_2_0_lpi_3[1]), .A2(KCOL_for_j_2_0_lpi_3[0]), 
      .A3(n_0_1_304), .ZN(n_0_1_303));
   NAND3_X1 i_0_1_140 (.A1(n_0_1_265), .A2(n_0_1_226), .A3(n_0_1_231), .ZN(
      n_0_1_225));
   NAND3_X1 i_0_1_136 (.A1(n_0_1_439), .A2(n_0_1_303), .A3(n_0_1_225), .ZN(
      n_0_1_222));
   OAI21_X1 i_0_1_135 (.A(n_0_1_222), .B1(
      EdgeDetect_IP_Kmean_run_run_fsm_inst_state_var[0]), .B2(rst), .ZN(n_0_35));
   DFFR_X1 exitL_exit_KCOL_for_sva_reg (.D(n_0_35), .RN(arst_n), .CK(n_0_3), 
      .Q(exitL_exit_KCOL_for_sva), .QN());
   INV_X1 i_0_1_446 (.A(exitL_exit_KCOL_for_sva), .ZN(n_0_1_454));
   AND2_X1 i_0_1_130 (.A1(n_0_1_454), .A2(KCOL_for_j_2_0_lpi_3[0]), .ZN(
      MUX_v_3_2_2_return[0]));
   AND2_X1 i_0_1_131 (.A1(n_0_1_439), .A2(MUX_v_3_2_2_return[0]), .ZN(n_0_37));
   NAND2_X1 i_0_1_122 (.A1(n_0_1_439), .A2(n_0_1_407), .ZN(n_0_41));
   CLKGATE_X1 clk_gate_KCOL_for_j_2_0_lpi_3_dfm_st_1_reg (.CK(clk), .E(n_0_41), 
      .GCK(n_0_5));
   DFFR_X1 \KCOL_for_j_2_0_lpi_3_dfm_st_1_reg[0]  (.D(n_0_37), .RN(arst_n), 
      .CK(n_0_5), .Q(KCOL_for_j_2_0_lpi_3_dfm_st_1[0]), .QN());
   AND2_X1 i_0_1_129 (.A1(n_0_1_439), .A2(MUX_v_3_2_2_return[1]), .ZN(n_0_38));
   DFFR_X1 \KCOL_for_j_2_0_lpi_3_dfm_st_1_reg[1]  (.D(n_0_38), .RN(arst_n), 
      .CK(n_0_5), .Q(KCOL_for_j_2_0_lpi_3_dfm_st_1[1]), .QN());
   NOR2_X1 i_0_1_128 (.A1(rst), .A2(n_0_1_304), .ZN(n_0_39));
   DFFR_X1 \KCOL_for_j_2_0_lpi_3_dfm_st_1_reg[2]  (.D(n_0_39), .RN(arst_n), 
      .CK(n_0_5), .Q(KCOL_for_j_2_0_lpi_3_dfm_st_1[2]), .QN());
   NAND2_X1 i_0_1_157 (.A1(KCOL_for_j_2_0_lpi_3_dfm_st_1[2]), .A2(KCOL_stage_0_2), 
      .ZN(n_0_1_287));
   NOR4_X1 i_0_1_156 (.A1(KCOL_for_j_2_0_lpi_3_dfm_st_1[0]), .A2(
      KCOL_for_j_2_0_lpi_3_dfm_st_1[1]), .A3(n_0_1_287), .A4(n_0_1_386), 
      .ZN(n_0_1_286));
   AND2_X1 i_0_1_202 (.A1(n_0_1_439), .A2(n_0_1_286), .ZN(n_0_32));
   DFFR_X1 reg_kmean_out_rsci_oswt_cse_reg (.D(n_0_32), .RN(arst_n), .CK(n_0_3), 
      .Q(reg_kmean_out_rsci_oswt_cse), .QN());
   EdgeDetect_IP_Kmean_run_kmean_out_rsci EdgeDetect_IP_Kmean_run_kmean_out_rsci_inst (
      .clk(clk), .rst(rst), .arst_n(arst_n), .kmean_out_rsc_dat(), 
      .kmean_out_rsc_vld(kmean_out_rsc_vld), .kmean_out_rsc_rdy(
      kmean_out_rsc_rdy), .run_wen(run_wen), .kmean_out_rsci_oswt(
      reg_kmean_out_rsci_oswt_cse), .kmean_out_rsci_wen_comp(
      kmean_out_rsci_wen_comp), .kmean_out_rsci_idat());
   NAND2_X1 i_0_1_358 (.A1(kmean_out_rsci_wen_comp), .A2(kmean_in_rsci_wen_comp), 
      .ZN(n_0_1_408));
   INV_X1 i_0_1_357 (.A(n_0_1_408), .ZN(run_wen));
   HA_X1 i_0_1_10 (.A(vector[0]), .B(widthIn[0]), .CO(n_0_1_10), .S(n_0_1_9));
   FA_X1 i_0_1_11 (.A(vector[1]), .B(widthIn[1]), .CI(n_0_1_10), .CO(n_0_1_12), 
      .S(n_0_1_11));
   FA_X1 i_0_1_12 (.A(vector[2]), .B(widthIn[2]), .CI(n_0_1_12), .CO(n_0_1_14), 
      .S(n_0_1_13));
   FA_X1 i_0_1_13 (.A(vector[3]), .B(widthIn[3]), .CI(n_0_1_14), .CO(n_0_1_16), 
      .S(n_0_1_15));
   FA_X1 i_0_1_14 (.A(vector[4]), .B(widthIn[4]), .CI(n_0_1_16), .CO(n_0_1_18), 
      .S(n_0_1_17));
   FA_X1 i_0_1_15 (.A(vector[5]), .B(widthIn[5]), .CI(n_0_1_18), .CO(n_0_1_20), 
      .S(n_0_1_19));
   FA_X1 i_0_1_16 (.A(vector[6]), .B(widthIn[6]), .CI(n_0_1_20), .CO(n_0_1_22), 
      .S(n_0_1_21));
   FA_X1 i_0_1_17 (.A(vector[7]), .B(widthIn[7]), .CI(n_0_1_22), .CO(n_0_1_24), 
      .S(n_0_1_23));
   FA_X1 i_0_1_18 (.A(vector[8]), .B(widthIn[8]), .CI(n_0_1_24), .CO(n_0_1_26), 
      .S(n_0_1_25));
   FA_X1 i_0_1_19 (.A(vector[9]), .B(widthIn[9]), .CI(n_0_1_26), .CO(n_0_1_28), 
      .S(n_0_1_27));
   FA_X1 i_0_1_20 (.A(vector[10]), .B(widthIn[10]), .CI(n_0_1_28), .CO(n_0_1_30), 
      .S(n_0_1_29));
   NAND2_X1 i_0_1_132 (.A1(exitL_exit_KCOL_for_sva), .A2(n_0_1_30), .ZN(
      n_0_1_221));
   NOR4_X1 i_0_1_133 (.A1(rst), .A2(n_0_1_438), .A3(n_0_1_386), .A4(n_0_1_221), 
      .ZN(n_0_36));
   DFFR_X1 reg_kmean_in_rsci_oswt_cse_reg (.D(n_0_36), .RN(arst_n), .CK(n_0_3), 
      .Q(reg_kmean_in_rsci_oswt_cse), .QN());
   EdgeDetect_IP_Kmean_run_kmean_in_rsci EdgeDetect_IP_Kmean_run_kmean_in_rsci_inst (
      .clk(clk), .rst(rst), .arst_n(arst_n), .kmean_in_rsc_dat({uc_0, uc_1, uc_2, 
      uc_3, uc_4, uc_5, uc_6, uc_7, uc_8, uc_9, kmean_in_rsc_dat[23], 
      kmean_in_rsc_dat[22], kmean_in_rsc_dat[21], kmean_in_rsc_dat[20], 
      kmean_in_rsc_dat[19], kmean_in_rsc_dat[18], kmean_in_rsc_dat[17], 
      kmean_in_rsc_dat[16], kmean_in_rsc_dat[15], kmean_in_rsc_dat[14], 
      kmean_in_rsc_dat[13], kmean_in_rsc_dat[12], kmean_in_rsc_dat[11], 
      kmean_in_rsc_dat[10], kmean_in_rsc_dat[9], kmean_in_rsc_dat[8], 
      kmean_in_rsc_dat[7], kmean_in_rsc_dat[6], kmean_in_rsc_dat[5], 
      kmean_in_rsc_dat[4], kmean_in_rsc_dat[3], kmean_in_rsc_dat[2], 
      kmean_in_rsc_dat[1], kmean_in_rsc_dat[0]}), .kmean_in_rsc_vld(
      kmean_in_rsc_vld), .kmean_in_rsc_rdy(kmean_in_rsc_rdy), .run_wen(run_wen), 
      .kmean_in_rsci_oswt(reg_kmean_in_rsci_oswt_cse), .kmean_in_rsci_wen_comp(
      kmean_in_rsci_wen_comp), .kmean_in_rsci_idat_mxwt(kmean_in_rsci_idat_mxwt));
   INV_X1 i_0_1_447 (.A(KCOL_for_j_2_0_lpi_3_dfm_st_1[1]), .ZN(n_0_1_455));
   INV_X1 i_0_1_444 (.A(KCOL_for_j_2_0_lpi_3_dfm_st_1[2]), .ZN(n_0_1_452));
   NAND2_X1 i_0_1_354 (.A1(n_0_1_455), .A2(n_0_1_452), .ZN(n_0_1_406));
   INV_X1 i_0_1_353 (.A(n_0_1_406), .ZN(n_0_1_405));
   INV_X1 i_0_1_448 (.A(KCOL_for_j_2_0_lpi_3_dfm_st_1[0]), .ZN(n_0_1_456));
   NAND2_X1 i_0_1_352 (.A1(n_0_1_456), .A2(n_0_1_452), .ZN(n_0_1_404));
   NAND2_X1 i_0_1_350 (.A1(n_0_1_406), .A2(n_0_1_404), .ZN(n_0_1_402));
   INV_X1 i_0_1_349 (.A(n_0_1_402), .ZN(n_0_1_401));
   NOR2_X1 i_0_1_127 (.A1(rst), .A2(n_0_1_221), .ZN(n_0_40));
   DFFR_X1 KCOL_for_and_itm_1_reg (.D(n_0_40), .RN(arst_n), .CK(n_0_5), .Q(
      KCOL_for_and_itm_1), .QN());
   INV_X1 i_0_1_441 (.A(KCOL_for_and_itm_1), .ZN(n_0_1_449));
   NAND4_X1 i_0_1_98 (.A1(KCOL_for_and_itm_1), .A2(KCOL_stage_0_2), .A3(run_wen), 
      .A4(n_0_1_385), .ZN(n_0_1_201));
   NOR2_X1 i_0_1_126 (.A1(rst), .A2(n_0_1_224), .ZN(n_0_42));
   DFFR_X1 KCOL_asn_4_itm_1_reg (.D(n_0_42), .RN(arst_n), .CK(n_0_5), .Q(
      KCOL_asn_4_itm_1), .QN());
   INV_X1 i_0_1_429 (.A(KCOL_asn_4_itm_1), .ZN(n_0_1_436));
   NAND2_X1 i_0_1_99 (.A1(n_0_1_436), .A2(n_0_1_221), .ZN(n_0_1_202));
   AOI21_X1 i_0_1_97 (.A(n_0_1_201), .B1(KCOL_stage_0), .B2(n_0_1_202), .ZN(
      n_0_47));
   CLKGATE_X1 clk_gate_kmean_in_crt_lpi_3_23_0_reg (.CK(clk), .E(n_0_47), 
      .GCK(n_0_0));
   DFF_X1 \kmean_in_crt_lpi_3_23_0_reg[23]  (.D(kmean_in_rsci_idat_mxwt[23]), 
      .CK(n_0_0), .Q(kmean_in_crt_lpi_3_23_0[23]), .QN());
   AOI22_X1 i_0_1_332 (.A1(n_0_1_449), .A2(kmean_in_crt_lpi_3_23_0[23]), 
      .B1(KCOL_for_and_itm_1), .B2(kmean_in_rsci_idat_mxwt[23]), .ZN(n_0_1_389));
   INV_X1 i_0_1_331 (.A(n_0_1_389), .ZN(MUX_v_24_2_20_return[23]));
   DFF_X1 \kmean_in_crt_lpi_3_23_0_reg[22]  (.D(kmean_in_rsci_idat_mxwt[22]), 
      .CK(n_0_0), .Q(kmean_in_crt_lpi_3_23_0[22]), .QN());
   AOI22_X1 i_0_1_294 (.A1(n_0_1_449), .A2(kmean_in_crt_lpi_3_23_0[22]), 
      .B1(KCOL_for_and_itm_1), .B2(kmean_in_rsci_idat_mxwt[22]), .ZN(n_0_1_361));
   INV_X1 i_0_1_293 (.A(n_0_1_361), .ZN(MUX_v_24_2_20_return[22]));
   AOI21_X1 i_0_1_304 (.A(KCOL_for_j_2_0_lpi_3_dfm_st_1[2]), .B1(
      KCOL_for_j_2_0_lpi_3_dfm_st_1[0]), .B2(n_0_1_455), .ZN(n_0_1_370));
   DFF_X1 \kmean_in_crt_lpi_3_23_0_reg[21]  (.D(kmean_in_rsci_idat_mxwt[21]), 
      .CK(n_0_0), .Q(kmean_in_crt_lpi_3_23_0[21]), .QN());
   AOI22_X1 i_0_1_298 (.A1(n_0_1_449), .A2(kmean_in_crt_lpi_3_23_0[21]), 
      .B1(KCOL_for_and_itm_1), .B2(kmean_in_rsci_idat_mxwt[21]), .ZN(n_0_1_364));
   INV_X1 i_0_1_297 (.A(n_0_1_364), .ZN(MUX_v_24_2_20_return[21]));
   INV_X1 i_0_1_303 (.A(n_0_1_370), .ZN(n_0_1_369));
   AOI21_X1 i_0_1_302 (.A(n_0_1_369), .B1(n_0_1_456), .B2(
      KCOL_for_j_2_0_lpi_3_dfm_st_1[1]), .ZN(n_0_1_368));
   DFF_X1 \kmean_in_crt_lpi_3_23_0_reg[20]  (.D(kmean_in_rsci_idat_mxwt[20]), 
      .CK(n_0_0), .Q(kmean_in_crt_lpi_3_23_0[20]), .QN());
   AOI22_X1 i_0_1_306 (.A1(n_0_1_449), .A2(kmean_in_crt_lpi_3_23_0[20]), 
      .B1(KCOL_for_and_itm_1), .B2(kmean_in_rsci_idat_mxwt[20]), .ZN(n_0_1_371));
   INV_X1 i_0_1_305 (.A(n_0_1_371), .ZN(MUX_v_24_2_20_return[20]));
   DFF_X1 \kmean_in_crt_lpi_3_23_0_reg[19]  (.D(kmean_in_rsci_idat_mxwt[19]), 
      .CK(n_0_0), .Q(kmean_in_crt_lpi_3_23_0[19]), .QN());
   AOI22_X1 i_0_1_310 (.A1(n_0_1_449), .A2(kmean_in_crt_lpi_3_23_0[19]), 
      .B1(KCOL_for_and_itm_1), .B2(kmean_in_rsci_idat_mxwt[19]), .ZN(n_0_1_374));
   INV_X1 i_0_1_309 (.A(n_0_1_374), .ZN(MUX_v_24_2_20_return[19]));
   INV_X1 i_0_1_351 (.A(n_0_1_404), .ZN(n_0_1_403));
   DFF_X1 \kmean_in_crt_lpi_3_23_0_reg[18]  (.D(kmean_in_rsci_idat_mxwt[18]), 
      .CK(n_0_0), .Q(kmean_in_crt_lpi_3_23_0[18]), .QN());
   AOI22_X1 i_0_1_314 (.A1(n_0_1_449), .A2(kmean_in_crt_lpi_3_23_0[18]), 
      .B1(KCOL_for_and_itm_1), .B2(kmean_in_rsci_idat_mxwt[18]), .ZN(n_0_1_377));
   INV_X1 i_0_1_313 (.A(n_0_1_377), .ZN(MUX_v_24_2_20_return[18]));
   AOI21_X1 i_0_1_318 (.A(KCOL_for_j_2_0_lpi_3_dfm_st_1[2]), .B1(n_0_1_456), 
      .B2(KCOL_for_j_2_0_lpi_3_dfm_st_1[1]), .ZN(n_0_1_381));
   DFF_X1 \kmean_in_crt_lpi_3_23_0_reg[17]  (.D(kmean_in_rsci_idat_mxwt[17]), 
      .CK(n_0_0), .Q(kmean_in_crt_lpi_3_23_0[17]), .QN());
   AOI22_X1 i_0_1_320 (.A1(n_0_1_449), .A2(kmean_in_crt_lpi_3_23_0[17]), 
      .B1(KCOL_for_and_itm_1), .B2(kmean_in_rsci_idat_mxwt[17]), .ZN(n_0_1_382));
   INV_X1 i_0_1_319 (.A(n_0_1_382), .ZN(MUX_v_24_2_20_return[17]));
   DFF_X1 \kmean_in_crt_lpi_3_23_0_reg[16]  (.D(kmean_in_rsci_idat_mxwt[16]), 
      .CK(n_0_0), .Q(kmean_in_crt_lpi_3_23_0[16]), .QN());
   AOI22_X1 i_0_1_338 (.A1(n_0_1_449), .A2(kmean_in_crt_lpi_3_23_0[16]), 
      .B1(KCOL_for_and_itm_1), .B2(kmean_in_rsci_idat_mxwt[16]), .ZN(n_0_1_394));
   NAND2_X1 i_0_1_337 (.A1(n_0_1_401), .A2(n_0_1_394), .ZN(n_0_1_167));
   FA_X1 i_0_1_21 (.A(n_0_1_381), .B(MUX_v_24_2_20_return[17]), .CI(n_0_1_167), 
      .CO(n_0_1_32), .S(n_0_1_31));
   FA_X1 i_0_1_22 (.A(n_0_1_403), .B(MUX_v_24_2_20_return[18]), .CI(n_0_1_32), 
      .CO(n_0_1_34), .S(n_0_1_33));
   FA_X1 i_0_1_23 (.A(n_0_1_405), .B(MUX_v_24_2_20_return[19]), .CI(n_0_1_34), 
      .CO(n_0_1_36), .S(n_0_1_35));
   FA_X1 i_0_1_24 (.A(n_0_1_368), .B(MUX_v_24_2_20_return[20]), .CI(n_0_1_36), 
      .CO(n_0_1_38), .S(n_0_1_37));
   FA_X1 i_0_1_25 (.A(n_0_1_370), .B(MUX_v_24_2_20_return[21]), .CI(n_0_1_38), 
      .CO(n_0_1_40), .S(n_0_1_39));
   FA_X1 i_0_1_26 (.A(n_0_1_402), .B(MUX_v_24_2_20_return[22]), .CI(n_0_1_40), 
      .CO(n_0_1_42), .S(n_0_1_41));
   FA_X1 i_0_1_27 (.A(n_0_1_405), .B(MUX_v_24_2_20_return[23]), .CI(n_0_1_42), 
      .CO(n_0_1_44), .S(n_0_1_43));
   NOR2_X1 i_0_1_323 (.A1(n_0_1_44), .A2(n_0_1_386), .ZN(n_0_1_384));
   INV_X1 i_0_1_322 (.A(n_0_1_384), .ZN(n_0_1_383));
   OAI22_X1 i_0_1_291 (.A1(n_0_1_401), .A2(n_0_1_384), .B1(n_0_1_383), .B2(
      MUX_v_24_2_20_return[22]), .ZN(n_0_1_359));
   OAI22_X1 i_0_1_292 (.A1(n_0_1_402), .A2(n_0_1_383), .B1(n_0_1_384), .B2(
      n_0_1_361), .ZN(n_0_1_360));
   HA_X1 i_0_1_33 (.A(n_0_1_359), .B(n_0_1_360), .CO(n_0_1_55), .S(n_0_1_54));
   AOI22_X1 i_0_1_295 (.A1(n_0_1_384), .A2(MUX_v_24_2_20_return[21]), .B1(
      n_0_1_383), .B2(n_0_1_369), .ZN(n_0_1_362));
   OAI22_X1 i_0_1_296 (.A1(n_0_1_384), .A2(n_0_1_364), .B1(n_0_1_383), .B2(
      n_0_1_370), .ZN(n_0_1_363));
   HA_X1 i_0_1_32 (.A(n_0_1_362), .B(n_0_1_363), .CO(n_0_1_53), .S(n_0_1_52));
   INV_X1 i_0_1_301 (.A(n_0_1_368), .ZN(n_0_1_367));
   OAI22_X1 i_0_1_299 (.A1(n_0_1_384), .A2(n_0_1_367), .B1(n_0_1_383), .B2(
      MUX_v_24_2_20_return[20]), .ZN(n_0_1_365));
   OAI22_X1 i_0_1_300 (.A1(n_0_1_384), .A2(n_0_1_371), .B1(n_0_1_383), .B2(
      n_0_1_368), .ZN(n_0_1_366));
   HA_X1 i_0_1_31 (.A(n_0_1_365), .B(n_0_1_366), .CO(n_0_1_51), .S(n_0_1_50));
   OAI22_X1 i_0_1_307 (.A1(n_0_1_406), .A2(n_0_1_384), .B1(n_0_1_383), .B2(
      MUX_v_24_2_20_return[19]), .ZN(n_0_1_372));
   OAI22_X1 i_0_1_308 (.A1(n_0_1_384), .A2(n_0_1_374), .B1(n_0_1_405), .B2(
      n_0_1_383), .ZN(n_0_1_373));
   HA_X1 i_0_1_30 (.A(n_0_1_372), .B(n_0_1_373), .CO(n_0_1_49), .S(n_0_1_48));
   OAI22_X1 i_0_1_311 (.A1(n_0_1_404), .A2(n_0_1_384), .B1(n_0_1_383), .B2(
      MUX_v_24_2_20_return[18]), .ZN(n_0_1_375));
   OAI22_X1 i_0_1_312 (.A1(n_0_1_403), .A2(n_0_1_383), .B1(n_0_1_384), .B2(
      n_0_1_377), .ZN(n_0_1_376));
   HA_X1 i_0_1_29 (.A(n_0_1_375), .B(n_0_1_376), .CO(n_0_1_47), .S(n_0_1_46));
   INV_X1 i_0_1_317 (.A(n_0_1_381), .ZN(n_0_1_380));
   OAI22_X1 i_0_1_315 (.A1(n_0_1_384), .A2(n_0_1_380), .B1(n_0_1_383), .B2(
      MUX_v_24_2_20_return[17]), .ZN(n_0_1_378));
   OAI22_X1 i_0_1_316 (.A1(n_0_1_384), .A2(n_0_1_382), .B1(n_0_1_383), .B2(
      n_0_1_381), .ZN(n_0_1_379));
   OAI21_X1 i_0_1_336 (.A(n_0_1_167), .B1(n_0_1_401), .B2(n_0_1_394), .ZN(
      n_0_1_393));
   OAI221_X1 i_0_1_321 (.A(n_0_1_393), .B1(n_0_1_401), .B2(n_0_1_384), .C1(
      n_0_1_402), .C2(n_0_1_383), .ZN(n_0_1_165));
   FA_X1 i_0_1_28 (.A(n_0_1_378), .B(n_0_1_379), .CI(n_0_1_165), .CO(n_0_1_45), 
      .S(n_0_1_183));
   HA_X1 i_0_1_34 (.A(n_0_1_46), .B(n_0_1_45), .CO(n_0_1_56), .S(n_0_1_184));
   FA_X1 i_0_1_35 (.A(n_0_1_47), .B(n_0_1_48), .CI(n_0_1_56), .CO(n_0_1_57), 
      .S(n_0_1_185));
   FA_X1 i_0_1_36 (.A(n_0_1_49), .B(n_0_1_50), .CI(n_0_1_57), .CO(n_0_1_58), 
      .S(n_0_1_186));
   FA_X1 i_0_1_37 (.A(n_0_1_51), .B(n_0_1_52), .CI(n_0_1_58), .CO(n_0_1_59), 
      .S(n_0_1_187));
   FA_X1 i_0_1_38 (.A(n_0_1_53), .B(n_0_1_54), .CI(n_0_1_59), .CO(n_0_1_60), 
      .S(n_0_1_188));
   XNOR2_X1 i_0_1_334 (.A(n_0_1_55), .B(n_0_1_60), .ZN(n_0_1_391));
   XOR2_X1 i_0_1_333 (.A(n_0_1_405), .B(n_0_1_391), .Z(n_0_1_390));
   XNOR2_X1 i_0_1_327 (.A(n_0_1_390), .B(n_0_1_389), .ZN(n_0_1_388));
   NAND2_X1 i_0_1_366 (.A1(n_0_1_454), .A2(n_0_1_388), .ZN(
      MUX_v_8_2_216_return[7]));
   AOI21_X1 i_0_1_385 (.A(n_0_1_407), .B1(n_0_1_454), .B2(n_0_1_162), .ZN(n_0_29));
   CLKGATE_X1 clk_gate_KCOL_for_KCOL_for_and_2_itm_1_reg (.CK(clk), .E(n_0_29), 
      .GCK(n_0_6));
   DFF_X1 \KROW_distance_pix_b_pixelType_lpi_3_dfm_1_reg[7]  (.D(
      MUX_v_8_2_216_return[7]), .CK(n_0_6), .Q(
      KROW_distance_pix_b_pixelType_lpi_3_dfm_1[7]), .QN());
   INV_X1 i_0_1_401 (.A(KROW_distance_pix_b_pixelType_lpi_3_dfm_1[7]), .ZN(
      n_0_1_415));
   INV_X1 i_0_1_326 (.A(n_0_1_388), .ZN(n_0_1_387));
   OR2_X1 i_0_1_373 (.A1(exitL_exit_KCOL_for_sva), .A2(n_0_1_188), .ZN(
      MUX_v_8_2_216_return[6]));
   DFF_X1 \KROW_distance_pix_b_pixelType_lpi_3_dfm_1_reg[6]  (.D(
      MUX_v_8_2_216_return[6]), .CK(n_0_6), .Q(
      KROW_distance_pix_b_pixelType_lpi_3_dfm_1[6]), .QN());
   INV_X1 i_0_1_402 (.A(KROW_distance_pix_b_pixelType_lpi_3_dfm_1[6]), .ZN(
      n_0_1_416));
   OR2_X1 i_0_1_374 (.A1(exitL_exit_KCOL_for_sva), .A2(n_0_1_187), .ZN(
      MUX_v_8_2_216_return[5]));
   DFF_X1 \KROW_distance_pix_b_pixelType_lpi_3_dfm_1_reg[5]  (.D(
      MUX_v_8_2_216_return[5]), .CK(n_0_6), .Q(
      KROW_distance_pix_b_pixelType_lpi_3_dfm_1[5]), .QN());
   INV_X1 i_0_1_403 (.A(KROW_distance_pix_b_pixelType_lpi_3_dfm_1[5]), .ZN(
      n_0_1_417));
   OR2_X1 i_0_1_375 (.A1(exitL_exit_KCOL_for_sva), .A2(n_0_1_186), .ZN(
      MUX_v_8_2_216_return[4]));
   DFF_X1 \KROW_distance_pix_b_pixelType_lpi_3_dfm_1_reg[4]  (.D(
      MUX_v_8_2_216_return[4]), .CK(n_0_6), .Q(
      KROW_distance_pix_b_pixelType_lpi_3_dfm_1[4]), .QN());
   INV_X1 i_0_1_404 (.A(KROW_distance_pix_b_pixelType_lpi_3_dfm_1[4]), .ZN(
      n_0_1_418));
   OR2_X1 i_0_1_376 (.A1(exitL_exit_KCOL_for_sva), .A2(n_0_1_185), .ZN(
      MUX_v_8_2_216_return[3]));
   DFF_X1 \KROW_distance_pix_b_pixelType_lpi_3_dfm_1_reg[3]  (.D(
      MUX_v_8_2_216_return[3]), .CK(n_0_6), .Q(
      KROW_distance_pix_b_pixelType_lpi_3_dfm_1[3]), .QN());
   INV_X1 i_0_1_405 (.A(KROW_distance_pix_b_pixelType_lpi_3_dfm_1[3]), .ZN(
      n_0_1_419));
   OR2_X1 i_0_1_377 (.A1(exitL_exit_KCOL_for_sva), .A2(n_0_1_184), .ZN(
      MUX_v_8_2_216_return[2]));
   DFF_X1 \KROW_distance_pix_b_pixelType_lpi_3_dfm_1_reg[2]  (.D(
      MUX_v_8_2_216_return[2]), .CK(n_0_6), .Q(
      KROW_distance_pix_b_pixelType_lpi_3_dfm_1[2]), .QN());
   INV_X1 i_0_1_406 (.A(KROW_distance_pix_b_pixelType_lpi_3_dfm_1[2]), .ZN(
      n_0_1_420));
   OR2_X1 i_0_1_378 (.A1(exitL_exit_KCOL_for_sva), .A2(n_0_1_183), .ZN(
      MUX_v_8_2_216_return[1]));
   DFF_X1 \KROW_distance_pix_b_pixelType_lpi_3_dfm_1_reg[1]  (.D(
      MUX_v_8_2_216_return[1]), .CK(n_0_6), .Q(
      KROW_distance_pix_b_pixelType_lpi_3_dfm_1[1]), .QN());
   INV_X1 i_0_1_407 (.A(KROW_distance_pix_b_pixelType_lpi_3_dfm_1[1]), .ZN(
      n_0_1_421));
   INV_X1 i_0_1_381 (.A(n_0_1_393), .ZN(n_0_1_392));
   NAND2_X1 i_0_1_379 (.A1(n_0_1_454), .A2(n_0_1_392), .ZN(
      MUX_v_8_2_216_return[0]));
   DFF_X1 \KROW_distance_pix_b_pixelType_lpi_3_dfm_1_reg[0]  (.D(
      MUX_v_8_2_216_return[0]), .CK(n_0_6), .Q(
      KROW_distance_pix_b_pixelType_lpi_3_dfm_1[0]), .QN());
   NAND2_X1 i_0_1_335 (.A1(KROW_distance_pix_b_pixelType_lpi_3_dfm_1[0]), 
      .A2(n_0_1_392), .ZN(n_0_1_166));
   FA_X1 i_0_1_89 (.A(n_0_1_421), .B(n_0_1_183), .CI(n_0_1_166), .CO(n_0_1_150), 
      .S(n_0_1_149));
   FA_X1 i_0_1_90 (.A(n_0_1_420), .B(n_0_1_184), .CI(n_0_1_150), .CO(n_0_1_152), 
      .S(n_0_1_151));
   FA_X1 i_0_1_91 (.A(n_0_1_419), .B(n_0_1_185), .CI(n_0_1_152), .CO(n_0_1_154), 
      .S(n_0_1_153));
   FA_X1 i_0_1_92 (.A(n_0_1_418), .B(n_0_1_186), .CI(n_0_1_154), .CO(n_0_1_156), 
      .S(n_0_1_155));
   FA_X1 i_0_1_93 (.A(n_0_1_417), .B(n_0_1_187), .CI(n_0_1_156), .CO(n_0_1_158), 
      .S(n_0_1_157));
   FA_X1 i_0_1_94 (.A(n_0_1_416), .B(n_0_1_188), .CI(n_0_1_158), .CO(n_0_1_160), 
      .S(n_0_1_159));
   FA_X1 i_0_1_95 (.A(n_0_1_415), .B(n_0_1_387), .CI(n_0_1_160), .CO(n_0_1_162), 
      .S(n_0_1_161));
   INV_X1 i_0_1_442 (.A(n_0_1_162), .ZN(n_0_1_450));
   OAI33_X1 i_0_1_387 (.A1(exitL_exit_KCOL_for_sva), .A2(n_0_1_450), .A3(
      n_0_1_228), .B1(exitL_exit_KCOL_for_sva), .B2(n_0_1_162), .B3(n_0_1_455), 
      .ZN(MUX_v_3_2_23_return[1]));
   DFF_X1 \KCOL_for_KCOL_for_and_2_itm_1_reg[1]  (.D(MUX_v_3_2_23_return[1]), 
      .CK(n_0_6), .Q(KCOL_for_KCOL_for_and_2_itm_1[1]), .QN());
   INV_X1 i_0_1_454 (.A(KCOL_for_KCOL_for_and_2_itm_1[1]), .ZN(n_0_1_228));
   AOI211_X1 i_0_1_386 (.A(exitL_exit_KCOL_for_sva), .B(n_0_1_414), .C1(
      n_0_1_452), .C2(n_0_1_450), .ZN(MUX_v_3_2_23_return[2]));
   DFF_X1 \KCOL_for_KCOL_for_and_2_itm_1_reg[2]  (.D(MUX_v_3_2_23_return[2]), 
      .CK(n_0_6), .Q(KCOL_for_KCOL_for_and_2_itm_1[2]), .QN());
   NOR2_X1 i_0_1_392 (.A1(n_0_1_450), .A2(KCOL_for_KCOL_for_and_2_itm_1[2]), 
      .ZN(n_0_1_414));
   NAND2_X1 i_0_1_391 (.A1(n_0_1_228), .A2(n_0_1_414), .ZN(n_0_14));
   AND2_X1 i_0_1_96 (.A1(run_wen), .A2(n_0_1_286), .ZN(KCOL_and_cse));
   CLKGATE_X1 clk_gate_kmean_out_rsci_idat_23_16_reg (.CK(clk), .E(KCOL_and_cse), 
      .GCK(n_0_4));
   DFF_X1 \kmean_out_rsci_idat_23_16_reg[7]  (.D(n_0_14), .CK(n_0_4), .Q(
      kmean_out_rsc_dat[19]), .QN());
   OAI33_X1 i_0_1_388 (.A1(exitL_exit_KCOL_for_sva), .A2(n_0_1_450), .A3(
      n_0_1_209), .B1(exitL_exit_KCOL_for_sva), .B2(n_0_1_162), .B3(n_0_1_456), 
      .ZN(MUX_v_3_2_23_return[0]));
   DFF_X1 \KCOL_for_KCOL_for_and_2_itm_1_reg[0]  (.D(MUX_v_3_2_23_return[0]), 
      .CK(n_0_6), .Q(KCOL_for_KCOL_for_and_2_itm_1[0]), .QN());
   INV_X1 i_0_1_453 (.A(KCOL_for_KCOL_for_and_2_itm_1[0]), .ZN(n_0_1_209));
   NAND2_X1 i_0_1_384 (.A1(n_0_1_209), .A2(n_0_1_414), .ZN(n_0_10));
   AND2_X1 i_0_1_372 (.A1(n_0_14), .A2(n_0_10), .ZN(n_0_13));
   DFF_X1 \kmean_out_rsci_idat_23_16_reg[6]  (.D(n_0_13), .CK(n_0_4), .Q(
      kmean_out_rsc_dat[22]), .QN());
   OAI21_X1 i_0_1_383 (.A(n_0_1_414), .B1(KCOL_for_KCOL_for_and_2_itm_1[1]), 
      .B2(n_0_1_209), .ZN(n_0_12));
   DFF_X1 \kmean_out_rsci_idat_23_16_reg[5]  (.D(n_0_12), .CK(n_0_4), .Q(
      kmean_out_rsc_dat[21]), .QN());
   OAI21_X1 i_0_1_389 (.A(n_0_1_414), .B1(n_0_1_228), .B2(
      KCOL_for_KCOL_for_and_2_itm_1[0]), .ZN(n_0_9));
   AOI21_X1 i_0_1_382 (.A(n_0_9), .B1(n_0_1_228), .B2(
      KCOL_for_KCOL_for_and_2_itm_1[0]), .ZN(n_0_1_413));
   INV_X1 i_0_1_380 (.A(n_0_1_413), .ZN(n_0_11));
   DFF_X1 \kmean_out_rsci_idat_23_16_reg[4]  (.D(n_0_11), .CK(n_0_4), .Q(
      kmean_out_rsc_dat[20]), .QN());
   DFF_X1 \kmean_out_rsci_idat_23_16_reg[2]  (.D(n_0_10), .CK(n_0_4), .Q(
      kmean_out_rsc_dat[18]), .QN());
   DFF_X1 \kmean_out_rsci_idat_23_16_reg[1]  (.D(n_0_9), .CK(n_0_4), .Q(
      kmean_out_rsc_dat[17]), .QN());
   DFF_X1 \kmean_in_crt_lpi_3_23_0_reg[15]  (.D(kmean_in_rsci_idat_mxwt[15]), 
      .CK(n_0_0), .Q(kmean_in_crt_lpi_3_23_0[15]), .QN());
   AOI22_X1 i_0_1_280 (.A1(n_0_1_449), .A2(kmean_in_crt_lpi_3_23_0[15]), 
      .B1(KCOL_for_and_itm_1), .B2(kmean_in_rsci_idat_mxwt[15]), .ZN(n_0_1_356));
   INV_X1 i_0_1_279 (.A(n_0_1_356), .ZN(MUX_v_24_2_20_return[15]));
   DFF_X1 \kmean_in_crt_lpi_3_23_0_reg[14]  (.D(kmean_in_rsci_idat_mxwt[14]), 
      .CK(n_0_0), .Q(kmean_in_crt_lpi_3_23_0[14]), .QN());
   AOI22_X1 i_0_1_251 (.A1(n_0_1_449), .A2(kmean_in_crt_lpi_3_23_0[14]), 
      .B1(KCOL_for_and_itm_1), .B2(kmean_in_rsci_idat_mxwt[14]), .ZN(n_0_1_336));
   INV_X1 i_0_1_250 (.A(n_0_1_336), .ZN(MUX_v_24_2_20_return[14]));
   DFF_X1 \kmean_in_crt_lpi_3_23_0_reg[13]  (.D(kmean_in_rsci_idat_mxwt[13]), 
      .CK(n_0_0), .Q(kmean_in_crt_lpi_3_23_0[13]), .QN());
   AOI22_X1 i_0_1_255 (.A1(n_0_1_449), .A2(kmean_in_crt_lpi_3_23_0[13]), 
      .B1(KCOL_for_and_itm_1), .B2(kmean_in_rsci_idat_mxwt[13]), .ZN(n_0_1_339));
   INV_X1 i_0_1_254 (.A(n_0_1_339), .ZN(MUX_v_24_2_20_return[13]));
   DFF_X1 \kmean_in_crt_lpi_3_23_0_reg[12]  (.D(kmean_in_rsci_idat_mxwt[12]), 
      .CK(n_0_0), .Q(kmean_in_crt_lpi_3_23_0[12]), .QN());
   AOI22_X1 i_0_1_259 (.A1(n_0_1_449), .A2(kmean_in_crt_lpi_3_23_0[12]), 
      .B1(KCOL_for_and_itm_1), .B2(kmean_in_rsci_idat_mxwt[12]), .ZN(n_0_1_342));
   INV_X1 i_0_1_258 (.A(n_0_1_342), .ZN(MUX_v_24_2_20_return[12]));
   DFF_X1 \kmean_in_crt_lpi_3_23_0_reg[11]  (.D(kmean_in_rsci_idat_mxwt[11]), 
      .CK(n_0_0), .Q(kmean_in_crt_lpi_3_23_0[11]), .QN());
   AOI22_X1 i_0_1_263 (.A1(n_0_1_449), .A2(kmean_in_crt_lpi_3_23_0[11]), 
      .B1(KCOL_for_and_itm_1), .B2(kmean_in_rsci_idat_mxwt[11]), .ZN(n_0_1_345));
   INV_X1 i_0_1_262 (.A(n_0_1_345), .ZN(MUX_v_24_2_20_return[11]));
   DFF_X1 \kmean_in_crt_lpi_3_23_0_reg[10]  (.D(kmean_in_rsci_idat_mxwt[10]), 
      .CK(n_0_0), .Q(kmean_in_crt_lpi_3_23_0[10]), .QN());
   AOI22_X1 i_0_1_267 (.A1(n_0_1_449), .A2(kmean_in_crt_lpi_3_23_0[10]), 
      .B1(KCOL_for_and_itm_1), .B2(kmean_in_rsci_idat_mxwt[10]), .ZN(n_0_1_348));
   INV_X1 i_0_1_266 (.A(n_0_1_348), .ZN(MUX_v_24_2_20_return[10]));
   DFF_X1 \kmean_in_crt_lpi_3_23_0_reg[9]  (.D(kmean_in_rsci_idat_mxwt[9]), 
      .CK(n_0_0), .Q(kmean_in_crt_lpi_3_23_0[9]), .QN());
   AOI22_X1 i_0_1_271 (.A1(n_0_1_449), .A2(kmean_in_crt_lpi_3_23_0[9]), .B1(
      KCOL_for_and_itm_1), .B2(kmean_in_rsci_idat_mxwt[9]), .ZN(n_0_1_351));
   INV_X1 i_0_1_270 (.A(n_0_1_351), .ZN(MUX_v_24_2_20_return[9]));
   DFF_X1 \kmean_in_crt_lpi_3_23_0_reg[8]  (.D(kmean_in_rsci_idat_mxwt[8]), 
      .CK(n_0_0), .Q(kmean_in_crt_lpi_3_23_0[8]), .QN());
   AOI22_X1 i_0_1_342 (.A1(n_0_1_449), .A2(kmean_in_crt_lpi_3_23_0[8]), .B1(
      KCOL_for_and_itm_1), .B2(kmean_in_rsci_idat_mxwt[8]), .ZN(n_0_1_397));
   NAND2_X1 i_0_1_341 (.A1(n_0_1_401), .A2(n_0_1_397), .ZN(n_0_1_169));
   FA_X1 i_0_1_39 (.A(n_0_1_381), .B(MUX_v_24_2_20_return[9]), .CI(n_0_1_169), 
      .CO(n_0_1_62), .S(n_0_1_61));
   FA_X1 i_0_1_40 (.A(n_0_1_403), .B(MUX_v_24_2_20_return[10]), .CI(n_0_1_62), 
      .CO(n_0_1_64), .S(n_0_1_63));
   FA_X1 i_0_1_41 (.A(n_0_1_405), .B(MUX_v_24_2_20_return[11]), .CI(n_0_1_64), 
      .CO(n_0_1_66), .S(n_0_1_65));
   FA_X1 i_0_1_42 (.A(n_0_1_368), .B(MUX_v_24_2_20_return[12]), .CI(n_0_1_66), 
      .CO(n_0_1_68), .S(n_0_1_67));
   FA_X1 i_0_1_43 (.A(n_0_1_370), .B(MUX_v_24_2_20_return[13]), .CI(n_0_1_68), 
      .CO(n_0_1_70), .S(n_0_1_69));
   FA_X1 i_0_1_44 (.A(n_0_1_402), .B(MUX_v_24_2_20_return[14]), .CI(n_0_1_70), 
      .CO(n_0_1_72), .S(n_0_1_71));
   FA_X1 i_0_1_45 (.A(n_0_1_405), .B(MUX_v_24_2_20_return[15]), .CI(n_0_1_72), 
      .CO(n_0_1_74), .S(n_0_1_73));
   NOR2_X1 i_0_1_274 (.A1(n_0_1_74), .A2(n_0_1_386), .ZN(n_0_1_353));
   INV_X1 i_0_1_273 (.A(n_0_1_353), .ZN(n_0_1_352));
   OAI22_X1 i_0_1_248 (.A1(n_0_1_401), .A2(n_0_1_353), .B1(n_0_1_352), .B2(
      MUX_v_24_2_20_return[14]), .ZN(n_0_1_334));
   OAI22_X1 i_0_1_249 (.A1(n_0_1_402), .A2(n_0_1_352), .B1(n_0_1_353), .B2(
      n_0_1_336), .ZN(n_0_1_335));
   HA_X1 i_0_1_51 (.A(n_0_1_334), .B(n_0_1_335), .CO(n_0_1_85), .S(n_0_1_84));
   AOI22_X1 i_0_1_252 (.A1(n_0_1_369), .A2(n_0_1_352), .B1(n_0_1_353), .B2(
      MUX_v_24_2_20_return[13]), .ZN(n_0_1_337));
   OAI22_X1 i_0_1_253 (.A1(n_0_1_353), .A2(n_0_1_339), .B1(n_0_1_370), .B2(
      n_0_1_352), .ZN(n_0_1_338));
   HA_X1 i_0_1_50 (.A(n_0_1_337), .B(n_0_1_338), .CO(n_0_1_83), .S(n_0_1_82));
   OAI22_X1 i_0_1_256 (.A1(n_0_1_367), .A2(n_0_1_353), .B1(n_0_1_352), .B2(
      MUX_v_24_2_20_return[12]), .ZN(n_0_1_340));
   OAI22_X1 i_0_1_257 (.A1(n_0_1_353), .A2(n_0_1_342), .B1(n_0_1_368), .B2(
      n_0_1_352), .ZN(n_0_1_341));
   HA_X1 i_0_1_49 (.A(n_0_1_340), .B(n_0_1_341), .CO(n_0_1_81), .S(n_0_1_80));
   OAI22_X1 i_0_1_260 (.A1(n_0_1_406), .A2(n_0_1_353), .B1(n_0_1_352), .B2(
      MUX_v_24_2_20_return[11]), .ZN(n_0_1_343));
   OAI22_X1 i_0_1_261 (.A1(n_0_1_353), .A2(n_0_1_345), .B1(n_0_1_405), .B2(
      n_0_1_352), .ZN(n_0_1_344));
   HA_X1 i_0_1_48 (.A(n_0_1_343), .B(n_0_1_344), .CO(n_0_1_79), .S(n_0_1_78));
   OAI22_X1 i_0_1_264 (.A1(n_0_1_404), .A2(n_0_1_353), .B1(n_0_1_352), .B2(
      MUX_v_24_2_20_return[10]), .ZN(n_0_1_346));
   OAI22_X1 i_0_1_265 (.A1(n_0_1_403), .A2(n_0_1_352), .B1(n_0_1_353), .B2(
      n_0_1_348), .ZN(n_0_1_347));
   HA_X1 i_0_1_47 (.A(n_0_1_346), .B(n_0_1_347), .CO(n_0_1_77), .S(n_0_1_76));
   OAI22_X1 i_0_1_268 (.A1(n_0_1_380), .A2(n_0_1_353), .B1(n_0_1_352), .B2(
      MUX_v_24_2_20_return[9]), .ZN(n_0_1_349));
   OAI22_X1 i_0_1_269 (.A1(n_0_1_353), .A2(n_0_1_351), .B1(n_0_1_381), .B2(
      n_0_1_352), .ZN(n_0_1_350));
   OAI21_X1 i_0_1_340 (.A(n_0_1_169), .B1(n_0_1_401), .B2(n_0_1_397), .ZN(
      n_0_1_396));
   OAI221_X1 i_0_1_272 (.A(n_0_1_396), .B1(n_0_1_401), .B2(n_0_1_353), .C1(
      n_0_1_402), .C2(n_0_1_352), .ZN(n_0_1_164));
   FA_X1 i_0_1_46 (.A(n_0_1_349), .B(n_0_1_350), .CI(n_0_1_164), .CO(n_0_1_75), 
      .S(n_0_1_189));
   HA_X1 i_0_1_52 (.A(n_0_1_76), .B(n_0_1_75), .CO(n_0_1_86), .S(n_0_1_190));
   FA_X1 i_0_1_53 (.A(n_0_1_77), .B(n_0_1_78), .CI(n_0_1_86), .CO(n_0_1_87), 
      .S(n_0_1_191));
   FA_X1 i_0_1_54 (.A(n_0_1_79), .B(n_0_1_80), .CI(n_0_1_87), .CO(n_0_1_88), 
      .S(n_0_1_192));
   FA_X1 i_0_1_55 (.A(n_0_1_81), .B(n_0_1_82), .CI(n_0_1_88), .CO(n_0_1_89), 
      .S(n_0_1_193));
   FA_X1 i_0_1_56 (.A(n_0_1_83), .B(n_0_1_84), .CI(n_0_1_89), .CO(n_0_1_90), 
      .S(n_0_1_194));
   XNOR2_X1 i_0_1_282 (.A(n_0_1_85), .B(n_0_1_90), .ZN(n_0_1_358));
   XOR2_X1 i_0_1_281 (.A(n_0_1_405), .B(n_0_1_358), .Z(n_0_1_357));
   XNOR2_X1 i_0_1_278 (.A(n_0_1_357), .B(n_0_1_356), .ZN(n_0_1_355));
   NAND2_X1 i_0_1_275 (.A1(n_0_1_454), .A2(n_0_1_355), .ZN(
      MUX_v_8_2_217_return[7]));
   AOI21_X1 i_0_1_394 (.A(n_0_1_407), .B1(n_0_1_454), .B2(n_0_1_104), .ZN(n_0_28));
   CLKGATE_X1 clk_gate_KCOL_for_KCOL_for_and_1_itm_1_reg (.CK(clk), .E(n_0_28), 
      .GCK(n_0_7));
   DFF_X1 \KROW_distance_pix_g_pixelType_lpi_3_dfm_1_reg[7]  (.D(
      MUX_v_8_2_217_return[7]), .CK(n_0_7), .Q(
      KROW_distance_pix_g_pixelType_lpi_3_dfm_1[7]), .QN());
   INV_X1 i_0_1_408 (.A(KROW_distance_pix_g_pixelType_lpi_3_dfm_1[7]), .ZN(
      n_0_1_422));
   INV_X1 i_0_1_277 (.A(n_0_1_355), .ZN(n_0_1_354));
   OR2_X1 i_0_1_287 (.A1(exitL_exit_KCOL_for_sva), .A2(n_0_1_194), .ZN(
      MUX_v_8_2_217_return[6]));
   DFF_X1 \KROW_distance_pix_g_pixelType_lpi_3_dfm_1_reg[6]  (.D(
      MUX_v_8_2_217_return[6]), .CK(n_0_7), .Q(
      KROW_distance_pix_g_pixelType_lpi_3_dfm_1[6]), .QN());
   INV_X1 i_0_1_409 (.A(KROW_distance_pix_g_pixelType_lpi_3_dfm_1[6]), .ZN(
      n_0_1_423));
   OR2_X1 i_0_1_288 (.A1(exitL_exit_KCOL_for_sva), .A2(n_0_1_193), .ZN(
      MUX_v_8_2_217_return[5]));
   DFF_X1 \KROW_distance_pix_g_pixelType_lpi_3_dfm_1_reg[5]  (.D(
      MUX_v_8_2_217_return[5]), .CK(n_0_7), .Q(
      KROW_distance_pix_g_pixelType_lpi_3_dfm_1[5]), .QN());
   INV_X1 i_0_1_410 (.A(KROW_distance_pix_g_pixelType_lpi_3_dfm_1[5]), .ZN(
      n_0_1_424));
   OR2_X1 i_0_1_289 (.A1(exitL_exit_KCOL_for_sva), .A2(n_0_1_192), .ZN(
      MUX_v_8_2_217_return[4]));
   DFF_X1 \KROW_distance_pix_g_pixelType_lpi_3_dfm_1_reg[4]  (.D(
      MUX_v_8_2_217_return[4]), .CK(n_0_7), .Q(
      KROW_distance_pix_g_pixelType_lpi_3_dfm_1[4]), .QN());
   INV_X1 i_0_1_411 (.A(KROW_distance_pix_g_pixelType_lpi_3_dfm_1[4]), .ZN(
      n_0_1_425));
   OR2_X1 i_0_1_290 (.A1(exitL_exit_KCOL_for_sva), .A2(n_0_1_191), .ZN(
      MUX_v_8_2_217_return[3]));
   DFF_X1 \KROW_distance_pix_g_pixelType_lpi_3_dfm_1_reg[3]  (.D(
      MUX_v_8_2_217_return[3]), .CK(n_0_7), .Q(
      KROW_distance_pix_g_pixelType_lpi_3_dfm_1[3]), .QN());
   INV_X1 i_0_1_412 (.A(KROW_distance_pix_g_pixelType_lpi_3_dfm_1[3]), .ZN(
      n_0_1_426));
   OR2_X1 i_0_1_328 (.A1(exitL_exit_KCOL_for_sva), .A2(n_0_1_190), .ZN(
      MUX_v_8_2_217_return[2]));
   DFF_X1 \KROW_distance_pix_g_pixelType_lpi_3_dfm_1_reg[2]  (.D(
      MUX_v_8_2_217_return[2]), .CK(n_0_7), .Q(
      KROW_distance_pix_g_pixelType_lpi_3_dfm_1[2]), .QN());
   INV_X1 i_0_1_413 (.A(KROW_distance_pix_g_pixelType_lpi_3_dfm_1[2]), .ZN(
      n_0_1_427));
   OR2_X1 i_0_1_329 (.A1(exitL_exit_KCOL_for_sva), .A2(n_0_1_189), .ZN(
      MUX_v_8_2_217_return[1]));
   DFF_X1 \KROW_distance_pix_g_pixelType_lpi_3_dfm_1_reg[1]  (.D(
      MUX_v_8_2_217_return[1]), .CK(n_0_7), .Q(
      KROW_distance_pix_g_pixelType_lpi_3_dfm_1[1]), .QN());
   INV_X1 i_0_1_414 (.A(KROW_distance_pix_g_pixelType_lpi_3_dfm_1[1]), .ZN(
      n_0_1_428));
   INV_X1 i_0_1_390 (.A(n_0_1_396), .ZN(n_0_1_395));
   NAND2_X1 i_0_1_330 (.A1(n_0_1_454), .A2(n_0_1_395), .ZN(
      MUX_v_8_2_217_return[0]));
   DFF_X1 \KROW_distance_pix_g_pixelType_lpi_3_dfm_1_reg[0]  (.D(
      MUX_v_8_2_217_return[0]), .CK(n_0_7), .Q(
      KROW_distance_pix_g_pixelType_lpi_3_dfm_1[0]), .QN());
   NAND2_X1 i_0_1_339 (.A1(KROW_distance_pix_g_pixelType_lpi_3_dfm_1[0]), 
      .A2(n_0_1_395), .ZN(n_0_1_168));
   FA_X1 i_0_1_57 (.A(n_0_1_428), .B(n_0_1_189), .CI(n_0_1_168), .CO(n_0_1_92), 
      .S(n_0_1_91));
   FA_X1 i_0_1_58 (.A(n_0_1_427), .B(n_0_1_190), .CI(n_0_1_92), .CO(n_0_1_94), 
      .S(n_0_1_93));
   FA_X1 i_0_1_59 (.A(n_0_1_426), .B(n_0_1_191), .CI(n_0_1_94), .CO(n_0_1_96), 
      .S(n_0_1_95));
   FA_X1 i_0_1_60 (.A(n_0_1_425), .B(n_0_1_192), .CI(n_0_1_96), .CO(n_0_1_98), 
      .S(n_0_1_97));
   FA_X1 i_0_1_61 (.A(n_0_1_424), .B(n_0_1_193), .CI(n_0_1_98), .CO(n_0_1_100), 
      .S(n_0_1_99));
   FA_X1 i_0_1_62 (.A(n_0_1_423), .B(n_0_1_194), .CI(n_0_1_100), .CO(n_0_1_102), 
      .S(n_0_1_101));
   FA_X1 i_0_1_63 (.A(n_0_1_422), .B(n_0_1_354), .CI(n_0_1_102), .CO(n_0_1_104), 
      .S(n_0_1_103));
   INV_X1 i_0_1_443 (.A(n_0_1_104), .ZN(n_0_1_451));
   OAI33_X1 i_0_1_396 (.A1(exitL_exit_KCOL_for_sva), .A2(n_0_1_451), .A3(
      n_0_1_460), .B1(exitL_exit_KCOL_for_sva), .B2(n_0_1_104), .B3(n_0_1_455), 
      .ZN(MUX_v_3_2_24_return[1]));
   DFF_X1 \KCOL_for_KCOL_for_and_1_itm_1_reg[1]  (.D(MUX_v_3_2_24_return[1]), 
      .CK(n_0_7), .Q(KCOL_for_KCOL_for_and_1_itm_1[1]), .QN());
   INV_X1 i_0_1_452 (.A(KCOL_for_KCOL_for_and_1_itm_1[1]), .ZN(n_0_1_460));
   AOI211_X1 i_0_1_343 (.A(exitL_exit_KCOL_for_sva), .B(n_0_1_412), .C1(
      n_0_1_452), .C2(n_0_1_451), .ZN(MUX_v_3_2_24_return[2]));
   DFF_X1 \KCOL_for_KCOL_for_and_1_itm_1_reg[2]  (.D(MUX_v_3_2_24_return[2]), 
      .CK(n_0_7), .Q(KCOL_for_KCOL_for_and_1_itm_1[2]), .QN());
   NOR2_X1 i_0_1_371 (.A1(n_0_1_451), .A2(KCOL_for_KCOL_for_and_1_itm_1[2]), 
      .ZN(n_0_1_412));
   NAND2_X1 i_0_1_370 (.A1(n_0_1_460), .A2(n_0_1_412), .ZN(n_0_20));
   DFF_X1 \kmean_out_rsci_idat_15_8_reg[7]  (.D(n_0_20), .CK(n_0_4), .Q(
      kmean_out_rsc_dat[15]), .QN());
   OAI33_X1 i_0_1_397 (.A1(exitL_exit_KCOL_for_sva), .A2(n_0_1_451), .A3(
      n_0_1_459), .B1(exitL_exit_KCOL_for_sva), .B2(n_0_1_104), .B3(n_0_1_456), 
      .ZN(MUX_v_3_2_24_return[0]));
   DFF_X1 \KCOL_for_KCOL_for_and_1_itm_1_reg[0]  (.D(MUX_v_3_2_24_return[0]), 
      .CK(n_0_7), .Q(KCOL_for_KCOL_for_and_1_itm_1[0]), .QN());
   INV_X1 i_0_1_451 (.A(KCOL_for_KCOL_for_and_1_itm_1[0]), .ZN(n_0_1_459));
   NAND2_X1 i_0_1_368 (.A1(n_0_1_459), .A2(n_0_1_412), .ZN(n_0_16));
   AND2_X1 i_0_1_363 (.A1(n_0_20), .A2(n_0_16), .ZN(n_0_19));
   DFF_X1 \kmean_out_rsci_idat_15_8_reg[6]  (.D(n_0_19), .CK(n_0_4), .Q(
      kmean_out_rsc_dat[14]), .QN());
   OAI21_X1 i_0_1_367 (.A(n_0_1_412), .B1(KCOL_for_KCOL_for_and_1_itm_1[1]), 
      .B2(n_0_1_459), .ZN(n_0_18));
   DFF_X1 \kmean_out_rsci_idat_15_8_reg[5]  (.D(n_0_18), .CK(n_0_4), .Q(
      kmean_out_rsc_dat[13]), .QN());
   OAI21_X1 i_0_1_369 (.A(n_0_1_412), .B1(n_0_1_460), .B2(
      KCOL_for_KCOL_for_and_1_itm_1[0]), .ZN(n_0_15));
   AOI21_X1 i_0_1_365 (.A(n_0_15), .B1(n_0_1_460), .B2(
      KCOL_for_KCOL_for_and_1_itm_1[0]), .ZN(n_0_1_411));
   INV_X1 i_0_1_364 (.A(n_0_1_411), .ZN(n_0_17));
   DFF_X1 \kmean_out_rsci_idat_15_8_reg[4]  (.D(n_0_17), .CK(n_0_4), .Q(
      kmean_out_rsc_dat[12]), .QN());
   DFF_X1 \kmean_out_rsci_idat_15_8_reg[2]  (.D(n_0_16), .CK(n_0_4), .Q(
      kmean_out_rsc_dat[10]), .QN());
   DFF_X1 \kmean_out_rsci_idat_15_8_reg[1]  (.D(n_0_15), .CK(n_0_4), .Q(
      kmean_out_rsc_dat[9]), .QN());
   DFF_X1 \kmean_in_crt_lpi_3_23_0_reg[7]  (.D(kmean_in_rsci_idat_mxwt[7]), 
      .CK(n_0_0), .Q(kmean_in_crt_lpi_3_23_0[7]), .QN());
   AOI22_X1 i_0_1_215 (.A1(n_0_1_449), .A2(kmean_in_crt_lpi_3_23_0[7]), .B1(
      KCOL_for_and_itm_1), .B2(kmean_in_rsci_idat_mxwt[7]), .ZN(n_0_1_331));
   INV_X1 i_0_1_214 (.A(n_0_1_331), .ZN(MUX_v_24_2_20_return[7]));
   DFF_X1 \kmean_in_crt_lpi_3_23_0_reg[6]  (.D(kmean_in_rsci_idat_mxwt[6]), 
      .CK(n_0_0), .Q(kmean_in_crt_lpi_3_23_0[6]), .QN());
   AOI22_X1 i_0_1_185 (.A1(n_0_1_449), .A2(kmean_in_crt_lpi_3_23_0[6]), .B1(
      KCOL_for_and_itm_1), .B2(kmean_in_rsci_idat_mxwt[6]), .ZN(n_0_1_311));
   INV_X1 i_0_1_184 (.A(n_0_1_311), .ZN(MUX_v_24_2_20_return[6]));
   DFF_X1 \kmean_in_crt_lpi_3_23_0_reg[5]  (.D(kmean_in_rsci_idat_mxwt[5]), 
      .CK(n_0_0), .Q(kmean_in_crt_lpi_3_23_0[5]), .QN());
   AOI22_X1 i_0_1_189 (.A1(n_0_1_449), .A2(kmean_in_crt_lpi_3_23_0[5]), .B1(
      KCOL_for_and_itm_1), .B2(kmean_in_rsci_idat_mxwt[5]), .ZN(n_0_1_314));
   INV_X1 i_0_1_188 (.A(n_0_1_314), .ZN(MUX_v_24_2_20_return[5]));
   DFF_X1 \kmean_in_crt_lpi_3_23_0_reg[4]  (.D(kmean_in_rsci_idat_mxwt[4]), 
      .CK(n_0_0), .Q(kmean_in_crt_lpi_3_23_0[4]), .QN());
   AOI22_X1 i_0_1_193 (.A1(n_0_1_449), .A2(kmean_in_crt_lpi_3_23_0[4]), .B1(
      KCOL_for_and_itm_1), .B2(kmean_in_rsci_idat_mxwt[4]), .ZN(n_0_1_317));
   INV_X1 i_0_1_192 (.A(n_0_1_317), .ZN(MUX_v_24_2_20_return[4]));
   DFF_X1 \kmean_in_crt_lpi_3_23_0_reg[3]  (.D(kmean_in_rsci_idat_mxwt[3]), 
      .CK(n_0_0), .Q(kmean_in_crt_lpi_3_23_0[3]), .QN());
   AOI22_X1 i_0_1_197 (.A1(n_0_1_449), .A2(kmean_in_crt_lpi_3_23_0[3]), .B1(
      KCOL_for_and_itm_1), .B2(kmean_in_rsci_idat_mxwt[3]), .ZN(n_0_1_320));
   INV_X1 i_0_1_196 (.A(n_0_1_320), .ZN(MUX_v_24_2_20_return[3]));
   DFF_X1 \kmean_in_crt_lpi_3_23_0_reg[2]  (.D(kmean_in_rsci_idat_mxwt[2]), 
      .CK(n_0_0), .Q(kmean_in_crt_lpi_3_23_0[2]), .QN());
   AOI22_X1 i_0_1_204 (.A1(n_0_1_449), .A2(kmean_in_crt_lpi_3_23_0[2]), .B1(
      KCOL_for_and_itm_1), .B2(kmean_in_rsci_idat_mxwt[2]), .ZN(n_0_1_323));
   INV_X1 i_0_1_203 (.A(n_0_1_323), .ZN(MUX_v_24_2_20_return[2]));
   DFF_X1 \kmean_in_crt_lpi_3_23_0_reg[1]  (.D(kmean_in_rsci_idat_mxwt[1]), 
      .CK(n_0_0), .Q(kmean_in_crt_lpi_3_23_0[1]), .QN());
   AOI22_X1 i_0_1_208 (.A1(n_0_1_449), .A2(kmean_in_crt_lpi_3_23_0[1]), .B1(
      KCOL_for_and_itm_1), .B2(kmean_in_rsci_idat_mxwt[1]), .ZN(n_0_1_326));
   INV_X1 i_0_1_207 (.A(n_0_1_326), .ZN(MUX_v_24_2_20_return[1]));
   DFF_X1 \kmean_in_crt_lpi_3_23_0_reg[0]  (.D(kmean_in_rsci_idat_mxwt[0]), 
      .CK(n_0_0), .Q(kmean_in_crt_lpi_3_23_0[0]), .QN());
   AOI22_X1 i_0_1_348 (.A1(n_0_1_449), .A2(kmean_in_crt_lpi_3_23_0[0]), .B1(
      KCOL_for_and_itm_1), .B2(kmean_in_rsci_idat_mxwt[0]), .ZN(n_0_1_400));
   NAND2_X1 i_0_1_347 (.A1(n_0_1_401), .A2(n_0_1_400), .ZN(n_0_1_171));
   FA_X1 i_0_1_64 (.A(n_0_1_381), .B(MUX_v_24_2_20_return[1]), .CI(n_0_1_171), 
      .CO(n_0_1_106), .S(n_0_1_105));
   FA_X1 i_0_1_65 (.A(n_0_1_403), .B(MUX_v_24_2_20_return[2]), .CI(n_0_1_106), 
      .CO(n_0_1_108), .S(n_0_1_107));
   FA_X1 i_0_1_66 (.A(n_0_1_405), .B(MUX_v_24_2_20_return[3]), .CI(n_0_1_108), 
      .CO(n_0_1_110), .S(n_0_1_109));
   FA_X1 i_0_1_67 (.A(n_0_1_368), .B(MUX_v_24_2_20_return[4]), .CI(n_0_1_110), 
      .CO(n_0_1_112), .S(n_0_1_111));
   FA_X1 i_0_1_68 (.A(n_0_1_370), .B(MUX_v_24_2_20_return[5]), .CI(n_0_1_112), 
      .CO(n_0_1_114), .S(n_0_1_113));
   FA_X1 i_0_1_69 (.A(n_0_1_402), .B(MUX_v_24_2_20_return[6]), .CI(n_0_1_114), 
      .CO(n_0_1_116), .S(n_0_1_115));
   FA_X1 i_0_1_70 (.A(n_0_1_405), .B(MUX_v_24_2_20_return[7]), .CI(n_0_1_116), 
      .CO(n_0_1_118), .S(n_0_1_117));
   NOR2_X1 i_0_1_211 (.A1(n_0_1_118), .A2(n_0_1_386), .ZN(n_0_1_328));
   INV_X1 i_0_1_210 (.A(n_0_1_328), .ZN(n_0_1_327));
   OAI22_X1 i_0_1_182 (.A1(n_0_1_401), .A2(n_0_1_328), .B1(n_0_1_327), .B2(
      MUX_v_24_2_20_return[6]), .ZN(n_0_1_309));
   OAI22_X1 i_0_1_183 (.A1(n_0_1_402), .A2(n_0_1_327), .B1(n_0_1_328), .B2(
      n_0_1_311), .ZN(n_0_1_310));
   HA_X1 i_0_1_76 (.A(n_0_1_309), .B(n_0_1_310), .CO(n_0_1_129), .S(n_0_1_128));
   AOI22_X1 i_0_1_186 (.A1(n_0_1_369), .A2(n_0_1_327), .B1(n_0_1_328), .B2(
      MUX_v_24_2_20_return[5]), .ZN(n_0_1_312));
   OAI22_X1 i_0_1_187 (.A1(n_0_1_328), .A2(n_0_1_314), .B1(n_0_1_370), .B2(
      n_0_1_327), .ZN(n_0_1_313));
   HA_X1 i_0_1_75 (.A(n_0_1_312), .B(n_0_1_313), .CO(n_0_1_127), .S(n_0_1_126));
   OAI22_X1 i_0_1_190 (.A1(n_0_1_367), .A2(n_0_1_328), .B1(n_0_1_327), .B2(
      MUX_v_24_2_20_return[4]), .ZN(n_0_1_315));
   OAI22_X1 i_0_1_191 (.A1(n_0_1_328), .A2(n_0_1_317), .B1(n_0_1_368), .B2(
      n_0_1_327), .ZN(n_0_1_316));
   HA_X1 i_0_1_74 (.A(n_0_1_315), .B(n_0_1_316), .CO(n_0_1_125), .S(n_0_1_124));
   OAI22_X1 i_0_1_194 (.A1(n_0_1_406), .A2(n_0_1_328), .B1(n_0_1_327), .B2(
      MUX_v_24_2_20_return[3]), .ZN(n_0_1_318));
   OAI22_X1 i_0_1_195 (.A1(n_0_1_328), .A2(n_0_1_320), .B1(n_0_1_405), .B2(
      n_0_1_327), .ZN(n_0_1_319));
   HA_X1 i_0_1_73 (.A(n_0_1_318), .B(n_0_1_319), .CO(n_0_1_123), .S(n_0_1_122));
   OAI22_X1 i_0_1_198 (.A1(n_0_1_404), .A2(n_0_1_328), .B1(n_0_1_327), .B2(
      MUX_v_24_2_20_return[2]), .ZN(n_0_1_321));
   OAI22_X1 i_0_1_199 (.A1(n_0_1_403), .A2(n_0_1_327), .B1(n_0_1_328), .B2(
      n_0_1_323), .ZN(n_0_1_322));
   HA_X1 i_0_1_72 (.A(n_0_1_321), .B(n_0_1_322), .CO(n_0_1_121), .S(n_0_1_120));
   OAI22_X1 i_0_1_205 (.A1(n_0_1_380), .A2(n_0_1_328), .B1(n_0_1_327), .B2(
      MUX_v_24_2_20_return[1]), .ZN(n_0_1_324));
   OAI22_X1 i_0_1_206 (.A1(n_0_1_328), .A2(n_0_1_326), .B1(n_0_1_381), .B2(
      n_0_1_327), .ZN(n_0_1_325));
   OAI21_X1 i_0_1_346 (.A(n_0_1_171), .B1(n_0_1_401), .B2(n_0_1_400), .ZN(
      n_0_1_399));
   OAI221_X1 i_0_1_209 (.A(n_0_1_399), .B1(n_0_1_401), .B2(n_0_1_328), .C1(
      n_0_1_402), .C2(n_0_1_327), .ZN(n_0_1_163));
   FA_X1 i_0_1_71 (.A(n_0_1_324), .B(n_0_1_325), .CI(n_0_1_163), .CO(n_0_1_119), 
      .S(n_0_1_195));
   HA_X1 i_0_1_77 (.A(n_0_1_120), .B(n_0_1_119), .CO(n_0_1_130), .S(n_0_1_196));
   FA_X1 i_0_1_78 (.A(n_0_1_121), .B(n_0_1_122), .CI(n_0_1_130), .CO(n_0_1_131), 
      .S(n_0_1_197));
   FA_X1 i_0_1_79 (.A(n_0_1_123), .B(n_0_1_124), .CI(n_0_1_131), .CO(n_0_1_132), 
      .S(n_0_1_198));
   FA_X1 i_0_1_80 (.A(n_0_1_125), .B(n_0_1_126), .CI(n_0_1_132), .CO(n_0_1_133), 
      .S(n_0_1_199));
   FA_X1 i_0_1_81 (.A(n_0_1_127), .B(n_0_1_128), .CI(n_0_1_133), .CO(n_0_1_134), 
      .S(n_0_1_200));
   XNOR2_X1 i_0_1_217 (.A(n_0_1_129), .B(n_0_1_134), .ZN(n_0_1_333));
   XOR2_X1 i_0_1_216 (.A(n_0_1_405), .B(n_0_1_333), .Z(n_0_1_332));
   XNOR2_X1 i_0_1_213 (.A(n_0_1_332), .B(n_0_1_331), .ZN(n_0_1_330));
   NAND2_X1 i_0_1_276 (.A1(n_0_1_454), .A2(n_0_1_330), .ZN(
      MUX_v_8_2_218_return[7]));
   AOI21_X1 i_0_1_355 (.A(n_0_1_407), .B1(n_0_1_454), .B2(n_0_1_148), .ZN(n_0_27));
   CLKGATE_X1 clk_gate_KCOL_for_KCOL_for_and_itm_1_reg (.CK(clk), .E(n_0_27), 
      .GCK(n_0_8));
   DFF_X1 \KROW_distance_pix_r_pixelType_lpi_3_dfm_1_reg[7]  (.D(
      MUX_v_8_2_218_return[7]), .CK(n_0_8), .Q(
      KROW_distance_pix_r_pixelType_lpi_3_dfm_1[7]), .QN());
   INV_X1 i_0_1_415 (.A(KROW_distance_pix_r_pixelType_lpi_3_dfm_1[7]), .ZN(
      n_0_1_429));
   INV_X1 i_0_1_212 (.A(n_0_1_330), .ZN(n_0_1_329));
   OR2_X1 i_0_1_283 (.A1(exitL_exit_KCOL_for_sva), .A2(n_0_1_200), .ZN(
      MUX_v_8_2_218_return[6]));
   DFF_X1 \KROW_distance_pix_r_pixelType_lpi_3_dfm_1_reg[6]  (.D(
      MUX_v_8_2_218_return[6]), .CK(n_0_8), .Q(
      KROW_distance_pix_r_pixelType_lpi_3_dfm_1[6]), .QN());
   INV_X1 i_0_1_423 (.A(KROW_distance_pix_r_pixelType_lpi_3_dfm_1[6]), .ZN(
      n_0_1_430));
   OR2_X1 i_0_1_284 (.A1(exitL_exit_KCOL_for_sva), .A2(n_0_1_199), .ZN(
      MUX_v_8_2_218_return[5]));
   DFF_X1 \KROW_distance_pix_r_pixelType_lpi_3_dfm_1_reg[5]  (.D(
      MUX_v_8_2_218_return[5]), .CK(n_0_8), .Q(
      KROW_distance_pix_r_pixelType_lpi_3_dfm_1[5]), .QN());
   INV_X1 i_0_1_424 (.A(KROW_distance_pix_r_pixelType_lpi_3_dfm_1[5]), .ZN(
      n_0_1_431));
   OR2_X1 i_0_1_285 (.A1(exitL_exit_KCOL_for_sva), .A2(n_0_1_198), .ZN(
      MUX_v_8_2_218_return[4]));
   DFF_X1 \KROW_distance_pix_r_pixelType_lpi_3_dfm_1_reg[4]  (.D(
      MUX_v_8_2_218_return[4]), .CK(n_0_8), .Q(
      KROW_distance_pix_r_pixelType_lpi_3_dfm_1[4]), .QN());
   INV_X1 i_0_1_425 (.A(KROW_distance_pix_r_pixelType_lpi_3_dfm_1[4]), .ZN(
      n_0_1_432));
   OR2_X1 i_0_1_286 (.A1(exitL_exit_KCOL_for_sva), .A2(n_0_1_197), .ZN(
      MUX_v_8_2_218_return[3]));
   DFF_X1 \KROW_distance_pix_r_pixelType_lpi_3_dfm_1_reg[3]  (.D(
      MUX_v_8_2_218_return[3]), .CK(n_0_8), .Q(
      KROW_distance_pix_r_pixelType_lpi_3_dfm_1[3]), .QN());
   INV_X1 i_0_1_426 (.A(KROW_distance_pix_r_pixelType_lpi_3_dfm_1[3]), .ZN(
      n_0_1_433));
   OR2_X1 i_0_1_232 (.A1(exitL_exit_KCOL_for_sva), .A2(n_0_1_196), .ZN(
      MUX_v_8_2_218_return[2]));
   DFF_X1 \KROW_distance_pix_r_pixelType_lpi_3_dfm_1_reg[2]  (.D(
      MUX_v_8_2_218_return[2]), .CK(n_0_8), .Q(
      KROW_distance_pix_r_pixelType_lpi_3_dfm_1[2]), .QN());
   INV_X1 i_0_1_427 (.A(KROW_distance_pix_r_pixelType_lpi_3_dfm_1[2]), .ZN(
      n_0_1_434));
   OR2_X1 i_0_1_233 (.A1(exitL_exit_KCOL_for_sva), .A2(n_0_1_195), .ZN(
      MUX_v_8_2_218_return[1]));
   DFF_X1 \KROW_distance_pix_r_pixelType_lpi_3_dfm_1_reg[1]  (.D(
      MUX_v_8_2_218_return[1]), .CK(n_0_8), .Q(
      KROW_distance_pix_r_pixelType_lpi_3_dfm_1[1]), .QN());
   INV_X1 i_0_1_428 (.A(KROW_distance_pix_r_pixelType_lpi_3_dfm_1[1]), .ZN(
      n_0_1_435));
   INV_X1 i_0_1_345 (.A(n_0_1_399), .ZN(n_0_1_398));
   NAND2_X1 i_0_1_247 (.A1(n_0_1_454), .A2(n_0_1_398), .ZN(
      MUX_v_8_2_218_return[0]));
   DFF_X1 \KROW_distance_pix_r_pixelType_lpi_3_dfm_1_reg[0]  (.D(
      MUX_v_8_2_218_return[0]), .CK(n_0_8), .Q(
      KROW_distance_pix_r_pixelType_lpi_3_dfm_1[0]), .QN());
   NAND2_X1 i_0_1_344 (.A1(KROW_distance_pix_r_pixelType_lpi_3_dfm_1[0]), 
      .A2(n_0_1_398), .ZN(n_0_1_170));
   FA_X1 i_0_1_82 (.A(n_0_1_435), .B(n_0_1_195), .CI(n_0_1_170), .CO(n_0_1_136), 
      .S(n_0_1_135));
   FA_X1 i_0_1_83 (.A(n_0_1_434), .B(n_0_1_196), .CI(n_0_1_136), .CO(n_0_1_138), 
      .S(n_0_1_137));
   FA_X1 i_0_1_84 (.A(n_0_1_433), .B(n_0_1_197), .CI(n_0_1_138), .CO(n_0_1_140), 
      .S(n_0_1_139));
   FA_X1 i_0_1_85 (.A(n_0_1_432), .B(n_0_1_198), .CI(n_0_1_140), .CO(n_0_1_142), 
      .S(n_0_1_141));
   FA_X1 i_0_1_86 (.A(n_0_1_431), .B(n_0_1_199), .CI(n_0_1_142), .CO(n_0_1_144), 
      .S(n_0_1_143));
   FA_X1 i_0_1_87 (.A(n_0_1_430), .B(n_0_1_200), .CI(n_0_1_144), .CO(n_0_1_146), 
      .S(n_0_1_145));
   FA_X1 i_0_1_88 (.A(n_0_1_429), .B(n_0_1_329), .CI(n_0_1_146), .CO(n_0_1_148), 
      .S(n_0_1_147));
   INV_X1 i_0_1_445 (.A(n_0_1_148), .ZN(n_0_1_453));
   OAI33_X1 i_0_1_360 (.A1(exitL_exit_KCOL_for_sva), .A2(n_0_1_453), .A3(
      n_0_1_458), .B1(exitL_exit_KCOL_for_sva), .B2(n_0_1_148), .B3(n_0_1_455), 
      .ZN(MUX_v_3_2_25_return[1]));
   DFF_X1 \KCOL_for_KCOL_for_and_itm_1_reg[1]  (.D(MUX_v_3_2_25_return[1]), 
      .CK(n_0_8), .Q(KCOL_for_KCOL_for_and_itm_1[1]), .QN());
   INV_X1 i_0_1_450 (.A(KCOL_for_KCOL_for_and_itm_1[1]), .ZN(n_0_1_458));
   AOI211_X1 i_0_1_359 (.A(exitL_exit_KCOL_for_sva), .B(n_0_1_410), .C1(
      n_0_1_453), .C2(n_0_1_452), .ZN(MUX_v_3_2_25_return[2]));
   DFF_X1 \KCOL_for_KCOL_for_and_itm_1_reg[2]  (.D(MUX_v_3_2_25_return[2]), 
      .CK(n_0_8), .Q(KCOL_for_KCOL_for_and_itm_1[2]), .QN());
   NOR2_X1 i_0_1_362 (.A1(n_0_1_453), .A2(KCOL_for_KCOL_for_and_itm_1[2]), 
      .ZN(n_0_1_410));
   NAND2_X1 i_0_1_422 (.A1(n_0_1_458), .A2(n_0_1_410), .ZN(n_0_26));
   DFF_X1 \kmean_out_rsci_idat_7_0_reg[7]  (.D(n_0_26), .CK(n_0_4), .Q(
      kmean_out_rsc_dat[7]), .QN());
   OAI33_X1 i_0_1_361 (.A1(exitL_exit_KCOL_for_sva), .A2(n_0_1_453), .A3(
      n_0_1_457), .B1(exitL_exit_KCOL_for_sva), .B2(n_0_1_148), .B3(n_0_1_456), 
      .ZN(MUX_v_3_2_25_return[0]));
   DFF_X1 \KCOL_for_KCOL_for_and_itm_1_reg[0]  (.D(MUX_v_3_2_25_return[0]), 
      .CK(n_0_8), .Q(KCOL_for_KCOL_for_and_itm_1[0]), .QN());
   INV_X1 i_0_1_449 (.A(KCOL_for_KCOL_for_and_itm_1[0]), .ZN(n_0_1_457));
   NAND2_X1 i_0_1_420 (.A1(n_0_1_457), .A2(n_0_1_410), .ZN(n_0_22));
   AND2_X1 i_0_1_416 (.A1(n_0_26), .A2(n_0_22), .ZN(n_0_25));
   DFF_X1 \kmean_out_rsci_idat_7_0_reg[6]  (.D(n_0_25), .CK(n_0_4), .Q(
      kmean_out_rsc_dat[6]), .QN());
   OAI21_X1 i_0_1_419 (.A(n_0_1_410), .B1(KCOL_for_KCOL_for_and_itm_1[1]), 
      .B2(n_0_1_457), .ZN(n_0_24));
   DFF_X1 \kmean_out_rsci_idat_7_0_reg[5]  (.D(n_0_24), .CK(n_0_4), .Q(
      kmean_out_rsc_dat[5]), .QN());
   OAI21_X1 i_0_1_421 (.A(n_0_1_410), .B1(n_0_1_458), .B2(
      KCOL_for_KCOL_for_and_itm_1[0]), .ZN(n_0_21));
   AOI21_X1 i_0_1_418 (.A(n_0_21), .B1(n_0_1_458), .B2(
      KCOL_for_KCOL_for_and_itm_1[0]), .ZN(n_0_1_409));
   INV_X1 i_0_1_417 (.A(n_0_1_409), .ZN(n_0_23));
   DFF_X1 \kmean_out_rsci_idat_7_0_reg[4]  (.D(n_0_23), .CK(n_0_4), .Q(
      kmean_out_rsc_dat[4]), .QN());
   DFF_X1 \kmean_out_rsci_idat_7_0_reg[2]  (.D(n_0_22), .CK(n_0_4), .Q(
      kmean_out_rsc_dat[2]), .QN());
   DFF_X1 \kmean_out_rsci_idat_7_0_reg[1]  (.D(n_0_21), .CK(n_0_4), .Q(
      kmean_out_rsc_dat[1]), .QN());
endmodule

module EdgeDetect_IP_Kmean_struct(clk, rst, arst_n, kmean_in_rsc_dat_eol, 
      kmean_in_rsc_dat_sof, kmean_in_rsc_dat_dummy, kmean_in_rsc_dat_b_pixelType, 
      kmean_in_rsc_dat_g_pixelType, kmean_in_rsc_dat_r_pixelType, 
      kmean_in_rsc_vld, kmean_in_rsc_rdy, widthIn, heightIn, 
      kmean_out_rsc_dat_b_pixelType, kmean_out_rsc_dat_g_pixelType, 
      kmean_out_rsc_dat_r_pixelType, kmean_out_rsc_vld, kmean_out_rsc_rdy);
   input clk;
   input rst;
   input arst_n;
   input kmean_in_rsc_dat_eol;
   input kmean_in_rsc_dat_sof;
   input [7:0]kmean_in_rsc_dat_dummy;
   input [7:0]kmean_in_rsc_dat_b_pixelType;
   input [7:0]kmean_in_rsc_dat_g_pixelType;
   input [7:0]kmean_in_rsc_dat_r_pixelType;
   input kmean_in_rsc_vld;
   output kmean_in_rsc_rdy;
   input [10:0]widthIn;
   input [9:0]heightIn;
   output [7:0]kmean_out_rsc_dat_b_pixelType;
   output [7:0]kmean_out_rsc_dat_g_pixelType;
   output [7:0]kmean_out_rsc_dat_r_pixelType;
   output kmean_out_rsc_vld;
   input kmean_out_rsc_rdy;

   EdgeDetect_IP_Kmean_run EdgeDetect_IP_Kmean_run_inst (.clk(clk), .rst(rst), 
      .arst_n(arst_n), .kmean_in_rsc_dat({uc_0, uc_1, uc_2, uc_3, uc_4, uc_5, 
      uc_6, uc_7, uc_8, uc_9, kmean_in_rsc_dat_b_pixelType[7], 
      kmean_in_rsc_dat_b_pixelType[6], kmean_in_rsc_dat_b_pixelType[5], 
      kmean_in_rsc_dat_b_pixelType[4], kmean_in_rsc_dat_b_pixelType[3], 
      kmean_in_rsc_dat_b_pixelType[2], kmean_in_rsc_dat_b_pixelType[1], 
      kmean_in_rsc_dat_b_pixelType[0], kmean_in_rsc_dat_g_pixelType[7], 
      kmean_in_rsc_dat_g_pixelType[6], kmean_in_rsc_dat_g_pixelType[5], 
      kmean_in_rsc_dat_g_pixelType[4], kmean_in_rsc_dat_g_pixelType[3], 
      kmean_in_rsc_dat_g_pixelType[2], kmean_in_rsc_dat_g_pixelType[1], 
      kmean_in_rsc_dat_g_pixelType[0], kmean_in_rsc_dat_r_pixelType[7], 
      kmean_in_rsc_dat_r_pixelType[6], kmean_in_rsc_dat_r_pixelType[5], 
      kmean_in_rsc_dat_r_pixelType[4], kmean_in_rsc_dat_r_pixelType[3], 
      kmean_in_rsc_dat_r_pixelType[2], kmean_in_rsc_dat_r_pixelType[1], 
      kmean_in_rsc_dat_r_pixelType[0]}), .kmean_in_rsc_vld(kmean_in_rsc_vld), 
      .kmean_in_rsc_rdy(kmean_in_rsc_rdy), .widthIn(widthIn), .heightIn(heightIn), 
      .kmean_out_rsc_dat({kmean_out_rsc_dat_b_pixelType[7], 
      kmean_out_rsc_dat_b_pixelType[6], kmean_out_rsc_dat_b_pixelType[5], 
      kmean_out_rsc_dat_b_pixelType[4], kmean_out_rsc_dat_b_pixelType[3], 
      kmean_out_rsc_dat_b_pixelType[2], kmean_out_rsc_dat_b_pixelType[1], uc_10, 
      kmean_out_rsc_dat_g_pixelType[7], kmean_out_rsc_dat_g_pixelType[6], 
      kmean_out_rsc_dat_g_pixelType[5], kmean_out_rsc_dat_g_pixelType[4], uc_11, 
      kmean_out_rsc_dat_g_pixelType[2], kmean_out_rsc_dat_g_pixelType[1], uc_12, 
      kmean_out_rsc_dat_r_pixelType[7], kmean_out_rsc_dat_r_pixelType[6], 
      kmean_out_rsc_dat_r_pixelType[5], kmean_out_rsc_dat_r_pixelType[4], uc_13, 
      kmean_out_rsc_dat_r_pixelType[2], kmean_out_rsc_dat_r_pixelType[1], uc_14}), 
      .kmean_out_rsc_vld(kmean_out_rsc_vld), .kmean_out_rsc_rdy(
      kmean_out_rsc_rdy));
endmodule

module EdgeDetect_IP_Kmean(clk, rst, arst_n, kmean_in_rsc_dat, kmean_in_rsc_vld, 
      kmean_in_rsc_rdy, widthIn, heightIn, kmean_out_rsc_dat, kmean_out_rsc_vld, 
      kmean_out_rsc_rdy);
   input clk;
   input rst;
   input arst_n;
   input [33:0]kmean_in_rsc_dat;
   input kmean_in_rsc_vld;
   output kmean_in_rsc_rdy;
   input [10:0]widthIn;
   input [9:0]heightIn;
   output [23:0]kmean_out_rsc_dat;
   output kmean_out_rsc_vld;
   input kmean_out_rsc_rdy;

   EdgeDetect_IP_Kmean_struct EdgeDetect_IP_Kmean_struct_inst (.clk(clk), 
      .rst(rst), .arst_n(arst_n), .kmean_in_rsc_dat_eol(), .kmean_in_rsc_dat_sof(), 
      .kmean_in_rsc_dat_dummy(), .kmean_in_rsc_dat_b_pixelType({
      kmean_in_rsc_dat[23], kmean_in_rsc_dat[22], kmean_in_rsc_dat[21], 
      kmean_in_rsc_dat[20], kmean_in_rsc_dat[19], kmean_in_rsc_dat[18], 
      kmean_in_rsc_dat[17], kmean_in_rsc_dat[16]}), 
      .kmean_in_rsc_dat_g_pixelType({kmean_in_rsc_dat[15], kmean_in_rsc_dat[14], 
      kmean_in_rsc_dat[13], kmean_in_rsc_dat[12], kmean_in_rsc_dat[11], 
      kmean_in_rsc_dat[10], kmean_in_rsc_dat[9], kmean_in_rsc_dat[8]}), 
      .kmean_in_rsc_dat_r_pixelType({kmean_in_rsc_dat[7], kmean_in_rsc_dat[6], 
      kmean_in_rsc_dat[5], kmean_in_rsc_dat[4], kmean_in_rsc_dat[3], 
      kmean_in_rsc_dat[2], kmean_in_rsc_dat[1], kmean_in_rsc_dat[0]}), 
      .kmean_in_rsc_vld(kmean_in_rsc_vld), .kmean_in_rsc_rdy(kmean_in_rsc_rdy), 
      .widthIn(widthIn), .heightIn(heightIn), .kmean_out_rsc_dat_b_pixelType({
      kmean_out_rsc_dat[23], kmean_out_rsc_dat[22], kmean_out_rsc_dat[21], 
      kmean_out_rsc_dat[20], kmean_out_rsc_dat[19], kmean_out_rsc_dat[18], 
      kmean_out_rsc_dat[17], uc_0}), .kmean_out_rsc_dat_g_pixelType({
      kmean_out_rsc_dat[15], kmean_out_rsc_dat[14], kmean_out_rsc_dat[13], 
      kmean_out_rsc_dat[12], uc_1, kmean_out_rsc_dat[10], kmean_out_rsc_dat[9], 
      uc_2}), .kmean_out_rsc_dat_r_pixelType({kmean_out_rsc_dat[7], 
      kmean_out_rsc_dat[6], kmean_out_rsc_dat[5], kmean_out_rsc_dat[4], uc_3, 
      kmean_out_rsc_dat[2], kmean_out_rsc_dat[1], uc_4}), .kmean_out_rsc_vld(
      kmean_out_rsc_vld), .kmean_out_rsc_rdy(kmean_out_rsc_rdy));
endmodule

module EdgeDetect_IP_Mix_run_magn_rsci(clk, rst, arst_n, magn_rsc_dat, 
      magn_rsc_vld, magn_rsc_rdy, run_wen, magn_rsci_oswt, magn_rsci_wen_comp, 
      magn_rsci_idat_mxwt);
   input clk;
   input rst;
   input arst_n;
   input [7:0]magn_rsc_dat;
   input magn_rsc_vld;
   output magn_rsc_rdy;
   input run_wen;
   input magn_rsci_oswt;
   output magn_rsci_wen_comp;
   output [7:0]magn_rsci_idat_mxwt;

   wire magn_rsci_bcwt;
   wire [7:0]
   EdgeDetect_IP_Mix_run_magn_rsci_magn_wait_dp_inst_magn_rsci_idat_bfwt;
   wire n_0_0;
   wire EdgeDetect_IP_Mix_run_magn_rsci_magn_wait_dp_inst_n_0_0;
   wire EdgeDetect_IP_Mix_run_magn_rsci_magn_wait_dp_inst_n_1;
   wire EdgeDetect_IP_Mix_run_magn_rsci_magn_wait_ctrl_inst_n_0_0;
   wire magn_rsci_biwt;
   wire magn_rsci_bdwt;

   INV_X1 i_0_0_0 (.A(magn_rsci_oswt), .ZN(
      EdgeDetect_IP_Mix_run_magn_rsci_magn_wait_ctrl_inst_n_0_0));
   AND2_X1 i_0_0_2 (.A1(magn_rsc_rdy), .A2(magn_rsc_vld), .ZN(magn_rsci_biwt));
   NOR2_X1 EdgeDetect_IP_Mix_run_magn_rsci_magn_wait_dp_inst_i_0_0 (.A1(
      magn_rsci_biwt), .A2(magn_rsci_bcwt), .ZN(
      EdgeDetect_IP_Mix_run_magn_rsci_magn_wait_dp_inst_n_0_0));
   AND2_X1 i_0_0_3 (.A1(magn_rsci_oswt), .A2(run_wen), .ZN(magn_rsci_bdwt));
   NOR3_X1 EdgeDetect_IP_Mix_run_magn_rsci_magn_wait_dp_inst_i_0_2 (.A1(
      EdgeDetect_IP_Mix_run_magn_rsci_magn_wait_dp_inst_n_0_0), .A2(rst), 
      .A3(magn_rsci_bdwt), .ZN(
      EdgeDetect_IP_Mix_run_magn_rsci_magn_wait_dp_inst_n_1));
   DFFR_X1 EdgeDetect_IP_Mix_run_magn_rsci_magn_wait_dp_inst_magn_rsci_bcwt_reg (
      .D(EdgeDetect_IP_Mix_run_magn_rsci_magn_wait_dp_inst_n_1), .RN(arst_n), 
      .CK(clk), .Q(magn_rsci_bcwt), .QN());
   NOR2_X1 i_0_0_1 (.A1(
      EdgeDetect_IP_Mix_run_magn_rsci_magn_wait_ctrl_inst_n_0_0), .A2(
      magn_rsci_bcwt), .ZN(magn_rsc_rdy));
   NAND2_X1 EdgeDetect_IP_Mix_run_magn_rsci_magn_wait_dp_inst_i_0_1 (.A1(
      EdgeDetect_IP_Mix_run_magn_rsci_magn_wait_dp_inst_n_0_0), .A2(
      magn_rsci_oswt), .ZN(magn_rsci_wen_comp));
   MUX2_X1 \EdgeDetect_IP_Mix_run_magn_rsci_magn_wait_dp_inst_magn_rsci_idat_bfwt_reg[7]_enable_mux_0  (
      .A(
      EdgeDetect_IP_Mix_run_magn_rsci_magn_wait_dp_inst_magn_rsci_idat_bfwt[7]), 
      .B(magn_rsc_dat[7]), .S(magn_rsci_biwt), .Z(n_0_0));
   DFF_X1 \EdgeDetect_IP_Mix_run_magn_rsci_magn_wait_dp_inst_magn_rsci_idat_bfwt_reg[7]  (
      .D(n_0_0), .CK(clk), .Q(
      EdgeDetect_IP_Mix_run_magn_rsci_magn_wait_dp_inst_magn_rsci_idat_bfwt[7]), 
      .QN());
   MUX2_X1 EdgeDetect_IP_Mix_run_magn_rsci_magn_wait_dp_inst_i_0_10 (.A(
      magn_rsc_dat[7]), .B(
      EdgeDetect_IP_Mix_run_magn_rsci_magn_wait_dp_inst_magn_rsci_idat_bfwt[7]), 
      .S(magn_rsci_bcwt), .Z(magn_rsci_idat_mxwt[7]));
endmodule

module EdgeDetect_IP_Mix_run_rgb_out_rsci(clk, rst, arst_n, rgb_out_rsc_dat, 
      rgb_out_rsc_vld, rgb_out_rsc_rdy, run_wen, rgb_out_rsci_oswt, 
      rgb_out_rsci_wen_comp, rgb_out_rsci_idat);
   input clk;
   input rst;
   input arst_n;
   output [33:0]rgb_out_rsc_dat;
   output rgb_out_rsc_vld;
   input rgb_out_rsc_rdy;
   input run_wen;
   input rgb_out_rsci_oswt;
   output rgb_out_rsci_wen_comp;
   input [33:0]rgb_out_rsci_idat;

   wire rgb_out_rsci_bcwt;
   wire EdgeDetect_IP_Mix_run_rgb_out_rsci_rgb_out_wait_dp_inst_n_1;
   wire n_0_0_0;
   wire n_0_0_1;
   wire n_0_0_2;

   INV_X1 i_0_0_5 (.A(rgb_out_rsci_oswt), .ZN(n_0_0_2));
   AOI21_X1 i_0_0_1 (.A(rgb_out_rsci_bcwt), .B1(rgb_out_rsci_oswt), .B2(
      rgb_out_rsc_rdy), .ZN(n_0_0_0));
   AOI211_X1 i_0_0_0 (.A(rst), .B(n_0_0_0), .C1(rgb_out_rsci_oswt), .C2(run_wen), 
      .ZN(EdgeDetect_IP_Mix_run_rgb_out_rsci_rgb_out_wait_dp_inst_n_1));
   DFFR_X1 EdgeDetect_IP_Mix_run_rgb_out_rsci_rgb_out_wait_dp_inst_rgb_out_rsci_bcwt_reg (
      .D(EdgeDetect_IP_Mix_run_rgb_out_rsci_rgb_out_wait_dp_inst_n_1), .RN(
      arst_n), .CK(clk), .Q(rgb_out_rsci_bcwt), .QN());
   NOR2_X1 i_0_0_3 (.A1(n_0_0_2), .A2(rgb_out_rsci_bcwt), .ZN(rgb_out_rsc_vld));
   INV_X1 i_0_0_4 (.A(rgb_out_rsc_rdy), .ZN(n_0_0_1));
   NAND2_X1 i_0_0_2 (.A1(rgb_out_rsc_vld), .A2(n_0_0_1), .ZN(
      rgb_out_rsci_wen_comp));
endmodule

module EdgeDetect_IP_Mix_run_grb_in_rsci_grb_in_wait_dp(clk, rst, arst_n, 
      grb_in_rsci_oswt, grb_in_rsci_wen_comp, grb_in_rsci_idat_mxwt, 
      grb_in_rsci_biwt, grb_in_rsci_bdwt, grb_in_rsci_bcwt, grb_in_rsci_idat);
   input clk;
   input rst;
   input arst_n;
   input grb_in_rsci_oswt;
   output grb_in_rsci_wen_comp;
   output [23:0]grb_in_rsci_idat_mxwt;
   input grb_in_rsci_biwt;
   input grb_in_rsci_bdwt;
   output grb_in_rsci_bcwt;
   input [23:0]grb_in_rsci_idat;

   wire [23:0]grb_in_rsci_idat_bfwt;
   wire n_0_0;

   NOR3_X1 i_0_2 (.A1(n_0_0), .A2(rst), .A3(grb_in_rsci_bdwt), .ZN(n_1));
   DFFR_X1 grb_in_rsci_bcwt_reg (.D(n_1), .RN(arst_n), .CK(clk), .Q(
      grb_in_rsci_bcwt), .QN());
   NOR2_X1 i_0_0 (.A1(grb_in_rsci_biwt), .A2(grb_in_rsci_bcwt), .ZN(n_0_0));
   NAND2_X1 i_0_1 (.A1(n_0_0), .A2(grb_in_rsci_oswt), .ZN(grb_in_rsci_wen_comp));
   CLKGATE_X1 clk_gate_grb_in_rsci_idat_bfwt_reg (.CK(clk), .E(grb_in_rsci_biwt), 
      .GCK(n_0));
   DFF_X1 \grb_in_rsci_idat_bfwt_reg[23]  (.D(grb_in_rsci_idat[23]), .CK(n_0), 
      .Q(grb_in_rsci_idat_bfwt[23]), .QN());
   MUX2_X1 i_0_26 (.A(grb_in_rsci_idat[23]), .B(grb_in_rsci_idat_bfwt[23]), 
      .S(grb_in_rsci_bcwt), .Z(grb_in_rsci_idat_mxwt[23]));
   DFF_X1 \grb_in_rsci_idat_bfwt_reg[22]  (.D(grb_in_rsci_idat[22]), .CK(n_0), 
      .Q(grb_in_rsci_idat_bfwt[22]), .QN());
   MUX2_X1 i_0_25 (.A(grb_in_rsci_idat[22]), .B(grb_in_rsci_idat_bfwt[22]), 
      .S(grb_in_rsci_bcwt), .Z(grb_in_rsci_idat_mxwt[22]));
   DFF_X1 \grb_in_rsci_idat_bfwt_reg[21]  (.D(grb_in_rsci_idat[21]), .CK(n_0), 
      .Q(grb_in_rsci_idat_bfwt[21]), .QN());
   MUX2_X1 i_0_24 (.A(grb_in_rsci_idat[21]), .B(grb_in_rsci_idat_bfwt[21]), 
      .S(grb_in_rsci_bcwt), .Z(grb_in_rsci_idat_mxwt[21]));
   DFF_X1 \grb_in_rsci_idat_bfwt_reg[20]  (.D(grb_in_rsci_idat[20]), .CK(n_0), 
      .Q(grb_in_rsci_idat_bfwt[20]), .QN());
   MUX2_X1 i_0_23 (.A(grb_in_rsci_idat[20]), .B(grb_in_rsci_idat_bfwt[20]), 
      .S(grb_in_rsci_bcwt), .Z(grb_in_rsci_idat_mxwt[20]));
   DFF_X1 \grb_in_rsci_idat_bfwt_reg[19]  (.D(grb_in_rsci_idat[19]), .CK(n_0), 
      .Q(grb_in_rsci_idat_bfwt[19]), .QN());
   MUX2_X1 i_0_22 (.A(grb_in_rsci_idat[19]), .B(grb_in_rsci_idat_bfwt[19]), 
      .S(grb_in_rsci_bcwt), .Z(grb_in_rsci_idat_mxwt[19]));
   DFF_X1 \grb_in_rsci_idat_bfwt_reg[18]  (.D(grb_in_rsci_idat[18]), .CK(n_0), 
      .Q(grb_in_rsci_idat_bfwt[18]), .QN());
   MUX2_X1 i_0_21 (.A(grb_in_rsci_idat[18]), .B(grb_in_rsci_idat_bfwt[18]), 
      .S(grb_in_rsci_bcwt), .Z(grb_in_rsci_idat_mxwt[18]));
   DFF_X1 \grb_in_rsci_idat_bfwt_reg[17]  (.D(grb_in_rsci_idat[17]), .CK(n_0), 
      .Q(grb_in_rsci_idat_bfwt[17]), .QN());
   MUX2_X1 i_0_20 (.A(grb_in_rsci_idat[17]), .B(grb_in_rsci_idat_bfwt[17]), 
      .S(grb_in_rsci_bcwt), .Z(grb_in_rsci_idat_mxwt[17]));
   DFF_X1 \grb_in_rsci_idat_bfwt_reg[15]  (.D(grb_in_rsci_idat[15]), .CK(n_0), 
      .Q(grb_in_rsci_idat_bfwt[15]), .QN());
   MUX2_X1 i_0_18 (.A(grb_in_rsci_idat[15]), .B(grb_in_rsci_idat_bfwt[15]), 
      .S(grb_in_rsci_bcwt), .Z(grb_in_rsci_idat_mxwt[15]));
   DFF_X1 \grb_in_rsci_idat_bfwt_reg[14]  (.D(grb_in_rsci_idat[14]), .CK(n_0), 
      .Q(grb_in_rsci_idat_bfwt[14]), .QN());
   MUX2_X1 i_0_17 (.A(grb_in_rsci_idat[14]), .B(grb_in_rsci_idat_bfwt[14]), 
      .S(grb_in_rsci_bcwt), .Z(grb_in_rsci_idat_mxwt[14]));
   DFF_X1 \grb_in_rsci_idat_bfwt_reg[13]  (.D(grb_in_rsci_idat[13]), .CK(n_0), 
      .Q(grb_in_rsci_idat_bfwt[13]), .QN());
   MUX2_X1 i_0_16 (.A(grb_in_rsci_idat[13]), .B(grb_in_rsci_idat_bfwt[13]), 
      .S(grb_in_rsci_bcwt), .Z(grb_in_rsci_idat_mxwt[13]));
   DFF_X1 \grb_in_rsci_idat_bfwt_reg[12]  (.D(grb_in_rsci_idat[12]), .CK(n_0), 
      .Q(grb_in_rsci_idat_bfwt[12]), .QN());
   MUX2_X1 i_0_15 (.A(grb_in_rsci_idat[12]), .B(grb_in_rsci_idat_bfwt[12]), 
      .S(grb_in_rsci_bcwt), .Z(grb_in_rsci_idat_mxwt[12]));
   DFF_X1 \grb_in_rsci_idat_bfwt_reg[10]  (.D(grb_in_rsci_idat[10]), .CK(n_0), 
      .Q(grb_in_rsci_idat_bfwt[10]), .QN());
   MUX2_X1 i_0_13 (.A(grb_in_rsci_idat[10]), .B(grb_in_rsci_idat_bfwt[10]), 
      .S(grb_in_rsci_bcwt), .Z(grb_in_rsci_idat_mxwt[10]));
   DFF_X1 \grb_in_rsci_idat_bfwt_reg[9]  (.D(grb_in_rsci_idat[9]), .CK(n_0), 
      .Q(grb_in_rsci_idat_bfwt[9]), .QN());
   MUX2_X1 i_0_12 (.A(grb_in_rsci_idat[9]), .B(grb_in_rsci_idat_bfwt[9]), 
      .S(grb_in_rsci_bcwt), .Z(grb_in_rsci_idat_mxwt[9]));
   DFF_X1 \grb_in_rsci_idat_bfwt_reg[7]  (.D(grb_in_rsci_idat[7]), .CK(n_0), 
      .Q(grb_in_rsci_idat_bfwt[7]), .QN());
   MUX2_X1 i_0_10 (.A(grb_in_rsci_idat[7]), .B(grb_in_rsci_idat_bfwt[7]), 
      .S(grb_in_rsci_bcwt), .Z(grb_in_rsci_idat_mxwt[7]));
   DFF_X1 \grb_in_rsci_idat_bfwt_reg[6]  (.D(grb_in_rsci_idat[6]), .CK(n_0), 
      .Q(grb_in_rsci_idat_bfwt[6]), .QN());
   MUX2_X1 i_0_9 (.A(grb_in_rsci_idat[6]), .B(grb_in_rsci_idat_bfwt[6]), 
      .S(grb_in_rsci_bcwt), .Z(grb_in_rsci_idat_mxwt[6]));
   DFF_X1 \grb_in_rsci_idat_bfwt_reg[5]  (.D(grb_in_rsci_idat[5]), .CK(n_0), 
      .Q(grb_in_rsci_idat_bfwt[5]), .QN());
   MUX2_X1 i_0_8 (.A(grb_in_rsci_idat[5]), .B(grb_in_rsci_idat_bfwt[5]), 
      .S(grb_in_rsci_bcwt), .Z(grb_in_rsci_idat_mxwt[5]));
   DFF_X1 \grb_in_rsci_idat_bfwt_reg[4]  (.D(grb_in_rsci_idat[4]), .CK(n_0), 
      .Q(grb_in_rsci_idat_bfwt[4]), .QN());
   MUX2_X1 i_0_7 (.A(grb_in_rsci_idat[4]), .B(grb_in_rsci_idat_bfwt[4]), 
      .S(grb_in_rsci_bcwt), .Z(grb_in_rsci_idat_mxwt[4]));
   DFF_X1 \grb_in_rsci_idat_bfwt_reg[2]  (.D(grb_in_rsci_idat[2]), .CK(n_0), 
      .Q(grb_in_rsci_idat_bfwt[2]), .QN());
   MUX2_X1 i_0_5 (.A(grb_in_rsci_idat[2]), .B(grb_in_rsci_idat_bfwt[2]), 
      .S(grb_in_rsci_bcwt), .Z(grb_in_rsci_idat_mxwt[2]));
   DFF_X1 \grb_in_rsci_idat_bfwt_reg[1]  (.D(grb_in_rsci_idat[1]), .CK(n_0), 
      .Q(grb_in_rsci_idat_bfwt[1]), .QN());
   MUX2_X1 i_0_4 (.A(grb_in_rsci_idat[1]), .B(grb_in_rsci_idat_bfwt[1]), 
      .S(grb_in_rsci_bcwt), .Z(grb_in_rsci_idat_mxwt[1]));
endmodule

module EdgeDetect_IP_Mix_run_grb_in_rsci(clk, rst, arst_n, grb_in_rsc_dat, 
      grb_in_rsc_vld, grb_in_rsc_rdy, run_wen, grb_in_rsci_oswt, 
      grb_in_rsci_wen_comp, grb_in_rsci_idat_mxwt);
   input clk;
   input rst;
   input arst_n;
   input [23:0]grb_in_rsc_dat;
   input grb_in_rsc_vld;
   output grb_in_rsc_rdy;
   input run_wen;
   input grb_in_rsci_oswt;
   output grb_in_rsci_wen_comp;
   output [23:0]grb_in_rsci_idat_mxwt;

   wire grb_in_rsci_bcwt;
   wire EdgeDetect_IP_Mix_run_grb_in_rsci_grb_in_wait_ctrl_inst_n_0_0;
   wire grb_in_rsci_biwt;
   wire grb_in_rsci_bdwt;

   INV_X1 i_0_0_0 (.A(grb_in_rsci_oswt), .ZN(
      EdgeDetect_IP_Mix_run_grb_in_rsci_grb_in_wait_ctrl_inst_n_0_0));
   AND2_X1 i_0_0_2 (.A1(grb_in_rsc_rdy), .A2(grb_in_rsc_vld), .ZN(
      grb_in_rsci_biwt));
   AND2_X1 i_0_0_3 (.A1(grb_in_rsci_oswt), .A2(run_wen), .ZN(grb_in_rsci_bdwt));
   EdgeDetect_IP_Mix_run_grb_in_rsci_grb_in_wait_dp EdgeDetect_IP_Mix_run_grb_in_rsci_grb_in_wait_dp_inst (
      .clk(clk), .rst(rst), .arst_n(arst_n), .grb_in_rsci_oswt(grb_in_rsci_oswt), 
      .grb_in_rsci_wen_comp(grb_in_rsci_wen_comp), .grb_in_rsci_idat_mxwt({
      grb_in_rsci_idat_mxwt[23], grb_in_rsci_idat_mxwt[22], 
      grb_in_rsci_idat_mxwt[21], grb_in_rsci_idat_mxwt[20], 
      grb_in_rsci_idat_mxwt[19], grb_in_rsci_idat_mxwt[18], 
      grb_in_rsci_idat_mxwt[17], uc_0, grb_in_rsci_idat_mxwt[15], 
      grb_in_rsci_idat_mxwt[14], grb_in_rsci_idat_mxwt[13], 
      grb_in_rsci_idat_mxwt[12], uc_1, grb_in_rsci_idat_mxwt[10], 
      grb_in_rsci_idat_mxwt[9], uc_2, grb_in_rsci_idat_mxwt[7], 
      grb_in_rsci_idat_mxwt[6], grb_in_rsci_idat_mxwt[5], 
      grb_in_rsci_idat_mxwt[4], uc_3, grb_in_rsci_idat_mxwt[2], 
      grb_in_rsci_idat_mxwt[1], uc_4}), .grb_in_rsci_biwt(grb_in_rsci_biwt), 
      .grb_in_rsci_bdwt(grb_in_rsci_bdwt), .grb_in_rsci_bcwt(grb_in_rsci_bcwt), 
      .grb_in_rsci_idat({grb_in_rsc_dat[23], grb_in_rsc_dat[22], 
      grb_in_rsc_dat[21], grb_in_rsc_dat[20], grb_in_rsc_dat[19], 
      grb_in_rsc_dat[18], grb_in_rsc_dat[17], uc_5, grb_in_rsc_dat[15], 
      grb_in_rsc_dat[14], grb_in_rsc_dat[13], grb_in_rsc_dat[12], uc_6, 
      grb_in_rsc_dat[10], grb_in_rsc_dat[9], uc_7, grb_in_rsc_dat[7], 
      grb_in_rsc_dat[6], grb_in_rsc_dat[5], grb_in_rsc_dat[4], uc_8, 
      grb_in_rsc_dat[2], grb_in_rsc_dat[1], uc_9}));
   NOR2_X1 i_0_0_1 (.A1(
      EdgeDetect_IP_Mix_run_grb_in_rsci_grb_in_wait_ctrl_inst_n_0_0), .A2(
      grb_in_rsci_bcwt), .ZN(grb_in_rsc_rdy));
endmodule

module EdgeDetect_IP_Mix_run(clk, rst, arst_n, grb_in_rsc_dat, grb_in_rsc_vld, 
      grb_in_rsc_rdy, widthIn, heightIn, magn_rsc_dat, magn_rsc_vld, 
      magn_rsc_rdy, rgb_out_rsc_dat, rgb_out_rsc_vld, rgb_out_rsc_rdy);
   input clk;
   input rst;
   input arst_n;
   input [23:0]grb_in_rsc_dat;
   input grb_in_rsc_vld;
   output grb_in_rsc_rdy;
   input [10:0]widthIn;
   input [9:0]heightIn;
   input [7:0]magn_rsc_dat;
   input magn_rsc_vld;
   output magn_rsc_rdy;
   output [33:0]rgb_out_rsc_dat;
   output rgb_out_rsc_vld;
   input rgb_out_rsc_rdy;

   wire [7:0]magn_rsci_idat_mxwt;
   wire magn_rsci_wen_comp;
   wire rgb_out_rsci_wen_comp;
   wire [23:0]grb_in_rsci_idat_mxwt;
   wire grb_in_rsci_wen_comp;
   wire [1:0]EdgeDetect_IP_Mix_run_run_fsm_inst_state_var;
   wire reg_rgb_out_rsci_oswt_cse;
   wire reg_magn_rsci_oswt_cse;
   wire MCOL_stage_0;
   wire n_0_0;
   wire [9:0]MROW_y_sva;
   wire n_0_1;
   wire [10:0]MCOL_x_sva;
   wire n_0_2;
   wire n_0_3;
   wire n_0_0_9;
   wire n_0_0_0;
   wire n_0_0_10;
   wire n_0_0_1;
   wire n_0_0_11;
   wire n_0_0_2;
   wire n_0_0_12;
   wire n_0_0_3;
   wire n_0_0_13;
   wire n_0_0_4;
   wire n_0_0_14;
   wire n_0_0_5;
   wire n_0_0_15;
   wire n_0_0_6;
   wire n_0_0_16;
   wire n_0_0_7;
   wire n_0_0_17;
   wire n_0_0_8;
   wire [10:0]MUX_v_11_2_25_return;
   wire n_0_0_18;
   wire n_0_0_19;
   wire n_0_4;
   wire [9:0]MUX_v_10_2_211_return;
   wire n_0_0_22;
   wire n_0_0_23;
   wire n_0_0_24;
   wire n_0_0_25;
   wire n_0_0_26;
   wire n_0_0_27;
   wire n_0_0_28;
   wire n_0_0_29;
   wire n_0_0_30;
   wire n_0_0_31;
   wire n_0_5;
   wire n_0_9;
   wire n_0_10;
   wire n_0_11;
   wire n_0_12;
   wire n_0_13;
   wire n_0_14;
   wire n_0_15;
   wire n_0_17;
   wire n_0_18;
   wire n_0_20;
   wire n_0_21;
   wire n_0_22;
   wire n_0_23;
   wire n_0_25;
   wire n_0_26;
   wire n_0_28;
   wire n_0_29;
   wire n_0_8;
   wire n_0_16;
   wire n_0_19;
   wire n_0_0_39;
   wire n_0_0_40;
   wire n_0_24;
   wire n_0_27;
   wire EdgeDetect_IP_Mix_run_run_fsm_inst_n_2;
   wire n_0_0_41;
   wire EdgeDetect_IP_Mix_run_run_fsm_inst_n_3;
   wire n_0_0_42;
   wire n_0_0_75;
   wire EdgeDetect_IP_Mix_run_run_fsm_inst_n_1;
   wire MCOL_and_3_cse;
   wire n_0_0_76;
   wire n_0_0_77;
   wire run_wen;
   wire n_0_0_78;
   wire n_0_0_116;
   wire n_0_0_117;
   wire n_0_0_118;
   wire n_0_0_20;
   wire n_0_0_21;
   wire n_0_6;
   wire n_0_0_32;
   wire n_0_0_33;
   wire n_0_0_34;
   wire n_0_0_35;
   wire n_0_0_36;
   wire n_0_0_37;
   wire n_0_7;
   wire n_0_0_38;
   wire n_0_0_43;
   wire n_0_0_44;
   wire n_0_0_45;
   wire n_0_0_46;
   wire n_0_0_47;
   wire n_0_0_48;
   wire n_0_0_49;
   wire n_0_0_50;
   wire n_0_0_51;
   wire n_0_0_52;
   wire n_0_0_53;
   wire n_0_0_54;
   wire n_0_0_55;
   wire n_0_0_56;
   wire n_0_0_57;
   wire n_0_0_58;
   wire n_0_0_59;
   wire n_0_0_60;
   wire n_0_0_61;
   wire n_0_0_62;
   wire n_0_0_63;
   wire n_0_0_64;
   wire n_0_0_65;
   wire n_0_0_66;
   wire n_0_0_67;
   wire n_0_0_68;
   wire n_0_0_69;
   wire n_0_0_70;
   wire n_0_0_71;
   wire n_0_0_72;
   wire n_0_0_73;
   wire n_0_0_74;
   wire n_0_0_79;
   wire n_0_0_80;
   wire n_0_0_81;
   wire n_0_0_82;
   wire n_0_0_83;
   wire n_0_0_84;
   wire n_0_0_85;
   wire MCOL_equal_1_tmp;
   wire n_0_0_86;
   wire n_0_0_87;
   wire n_0_0_88;
   wire n_0_0_89;
   wire n_0_0_90;
   wire n_0_0_91;
   wire n_0_0_92;
   wire n_0_0_93;
   wire n_0_0_94;
   wire n_0_0_95;
   wire n_0_0_96;
   wire n_0_0_97;
   wire n_0_0_98;
   wire n_0_0_99;
   wire n_0_0_100;
   wire n_0_0_101;
   wire n_0_0_102;
   wire n_0_0_103;
   wire n_0_0_104;
   wire n_0_0_105;
   wire n_0_0_106;
   wire n_0_0_107;
   wire n_0_0_108;
   wire n_0_0_109;
   wire n_0_0_110;
   wire n_0_0_111;
   wire n_0_0_112;
   wire n_0_0_113;
   wire n_0_0_114;
   wire n_0_0_115;
   wire n_0_0_119;
   wire n_0_0_120;
   wire n_0_0_121;
   wire n_0_0_122;
   wire n_0_0_123;
   wire n_0_0_124;
   wire n_0_0_125;
   wire n_0_0_126;
   wire n_0_0_127;
   wire n_0_0_128;
   wire n_0_0_129;
   wire n_0_0_130;
   wire n_0_0_131;
   wire n_0_0_132;

   INV_X1 i_0_0_173 (.A(widthIn[8]), .ZN(n_0_0_129));
   INV_X1 i_0_0_175 (.A(widthIn[6]), .ZN(n_0_0_131));
   INV_X1 i_0_0_176 (.A(widthIn[4]), .ZN(n_0_0_132));
   OR2_X1 i_0_0_168 (.A1(widthIn[1]), .A2(widthIn[0]), .ZN(n_0_0_124));
   NOR3_X1 i_0_0_167 (.A1(widthIn[2]), .A2(widthIn[3]), .A3(n_0_0_124), .ZN(
      n_0_0_123));
   NAND2_X1 i_0_0_164 (.A1(n_0_0_132), .A2(n_0_0_123), .ZN(n_0_0_120));
   NOR2_X1 i_0_0_150 (.A1(widthIn[5]), .A2(n_0_0_120), .ZN(n_0_0_103));
   NAND2_X1 i_0_0_149 (.A1(n_0_0_131), .A2(n_0_0_103), .ZN(n_0_0_102));
   NOR2_X1 i_0_0_146 (.A1(widthIn[7]), .A2(n_0_0_102), .ZN(n_0_0_99));
   NAND2_X1 i_0_0_143 (.A1(n_0_0_129), .A2(n_0_0_99), .ZN(n_0_0_96));
   NOR2_X1 i_0_0_139 (.A1(widthIn[9]), .A2(n_0_0_96), .ZN(n_0_0_92));
   NAND2_X1 i_0_0_21 (.A1(MCOL_x_sva[10]), .A2(n_0_0_77), .ZN(n_0_0_19));
   NOR2_X1 i_0_0_81 (.A1(EdgeDetect_IP_Mix_run_run_fsm_inst_state_var[1]), 
      .A2(EdgeDetect_IP_Mix_run_run_fsm_inst_state_var[0]), .ZN(n_0_0_21));
   INV_X1 i_0_0_80 (.A(n_0_0_21), .ZN(n_0_0_20));
   AND2_X1 i_0_0_32 (.A1(n_0_0_20), .A2(n_0_0_17), .ZN(MUX_v_10_2_211_return[9]));
   NOR2_X1 i_0_0_45 (.A1(n_0_0_78), .A2(
      EdgeDetect_IP_Mix_run_run_fsm_inst_state_var[0]), .ZN(n_0_5));
   CLKGATE_X1 clk_gate_MROW_y_sva_reg (.CK(clk), .E(n_0_5), .GCK(n_0_0));
   DFF_X1 \MROW_y_sva_reg[9]  (.D(MUX_v_10_2_211_return[9]), .CK(n_0_0), 
      .Q(MROW_y_sva[9]), .QN());
   AND2_X1 i_0_0_18 (.A1(EdgeDetect_IP_Mix_run_run_fsm_inst_state_var[0]), 
      .A2(n_0_0_17), .ZN(MUX_v_11_2_25_return[9]));
   NOR2_X1 i_0_0_22 (.A1(n_0_0_41), .A2(n_0_0_78), .ZN(n_0_4));
   CLKGATE_X1 clk_gate_MCOL_x_sva_reg (.CK(clk), .E(n_0_4), .GCK(n_0_1));
   DFF_X1 \MCOL_x_sva_reg[9]  (.D(MUX_v_11_2_25_return[9]), .CK(n_0_1), .Q(
      MCOL_x_sva[9]), .QN());
   MUX2_X1 i_0_0_42 (.A(MROW_y_sva[9]), .B(MCOL_x_sva[9]), .S(n_0_0_77), 
      .Z(n_0_0_31));
   AND2_X1 i_0_0_31 (.A1(n_0_0_20), .A2(n_0_0_16), .ZN(MUX_v_10_2_211_return[8]));
   DFF_X1 \MROW_y_sva_reg[8]  (.D(MUX_v_10_2_211_return[8]), .CK(n_0_0), 
      .Q(MROW_y_sva[8]), .QN());
   AND2_X1 i_0_0_17 (.A1(EdgeDetect_IP_Mix_run_run_fsm_inst_state_var[0]), 
      .A2(n_0_0_16), .ZN(MUX_v_11_2_25_return[8]));
   DFF_X1 \MCOL_x_sva_reg[8]  (.D(MUX_v_11_2_25_return[8]), .CK(n_0_1), .Q(
      MCOL_x_sva[8]), .QN());
   MUX2_X1 i_0_0_41 (.A(MROW_y_sva[8]), .B(MCOL_x_sva[8]), .S(n_0_0_77), 
      .Z(n_0_0_30));
   AND2_X1 i_0_0_30 (.A1(n_0_0_20), .A2(n_0_0_15), .ZN(MUX_v_10_2_211_return[7]));
   DFF_X1 \MROW_y_sva_reg[7]  (.D(MUX_v_10_2_211_return[7]), .CK(n_0_0), 
      .Q(MROW_y_sva[7]), .QN());
   AND2_X1 i_0_0_16 (.A1(EdgeDetect_IP_Mix_run_run_fsm_inst_state_var[0]), 
      .A2(n_0_0_15), .ZN(MUX_v_11_2_25_return[7]));
   DFF_X1 \MCOL_x_sva_reg[7]  (.D(MUX_v_11_2_25_return[7]), .CK(n_0_1), .Q(
      MCOL_x_sva[7]), .QN());
   MUX2_X1 i_0_0_40 (.A(MROW_y_sva[7]), .B(MCOL_x_sva[7]), .S(n_0_0_77), 
      .Z(n_0_0_29));
   AND2_X1 i_0_0_29 (.A1(n_0_0_20), .A2(n_0_0_14), .ZN(MUX_v_10_2_211_return[6]));
   DFF_X1 \MROW_y_sva_reg[6]  (.D(MUX_v_10_2_211_return[6]), .CK(n_0_0), 
      .Q(MROW_y_sva[6]), .QN());
   AND2_X1 i_0_0_15 (.A1(EdgeDetect_IP_Mix_run_run_fsm_inst_state_var[0]), 
      .A2(n_0_0_14), .ZN(MUX_v_11_2_25_return[6]));
   DFF_X1 \MCOL_x_sva_reg[6]  (.D(MUX_v_11_2_25_return[6]), .CK(n_0_1), .Q(
      MCOL_x_sva[6]), .QN());
   MUX2_X1 i_0_0_39 (.A(MROW_y_sva[6]), .B(MCOL_x_sva[6]), .S(n_0_0_77), 
      .Z(n_0_0_28));
   AND2_X1 i_0_0_28 (.A1(n_0_0_20), .A2(n_0_0_13), .ZN(MUX_v_10_2_211_return[5]));
   DFF_X1 \MROW_y_sva_reg[5]  (.D(MUX_v_10_2_211_return[5]), .CK(n_0_0), 
      .Q(MROW_y_sva[5]), .QN());
   AND2_X1 i_0_0_14 (.A1(EdgeDetect_IP_Mix_run_run_fsm_inst_state_var[0]), 
      .A2(n_0_0_13), .ZN(MUX_v_11_2_25_return[5]));
   DFF_X1 \MCOL_x_sva_reg[5]  (.D(MUX_v_11_2_25_return[5]), .CK(n_0_1), .Q(
      MCOL_x_sva[5]), .QN());
   MUX2_X1 i_0_0_38 (.A(MROW_y_sva[5]), .B(MCOL_x_sva[5]), .S(n_0_0_77), 
      .Z(n_0_0_27));
   AND2_X1 i_0_0_27 (.A1(n_0_0_20), .A2(n_0_0_12), .ZN(MUX_v_10_2_211_return[4]));
   DFF_X1 \MROW_y_sva_reg[4]  (.D(MUX_v_10_2_211_return[4]), .CK(n_0_0), 
      .Q(MROW_y_sva[4]), .QN());
   AND2_X1 i_0_0_13 (.A1(EdgeDetect_IP_Mix_run_run_fsm_inst_state_var[0]), 
      .A2(n_0_0_12), .ZN(MUX_v_11_2_25_return[4]));
   DFF_X1 \MCOL_x_sva_reg[4]  (.D(MUX_v_11_2_25_return[4]), .CK(n_0_1), .Q(
      MCOL_x_sva[4]), .QN());
   MUX2_X1 i_0_0_37 (.A(MROW_y_sva[4]), .B(MCOL_x_sva[4]), .S(n_0_0_77), 
      .Z(n_0_0_26));
   AND2_X1 i_0_0_26 (.A1(n_0_0_20), .A2(n_0_0_11), .ZN(MUX_v_10_2_211_return[3]));
   DFF_X1 \MROW_y_sva_reg[3]  (.D(MUX_v_10_2_211_return[3]), .CK(n_0_0), 
      .Q(MROW_y_sva[3]), .QN());
   AND2_X1 i_0_0_12 (.A1(EdgeDetect_IP_Mix_run_run_fsm_inst_state_var[0]), 
      .A2(n_0_0_11), .ZN(MUX_v_11_2_25_return[3]));
   DFF_X1 \MCOL_x_sva_reg[3]  (.D(MUX_v_11_2_25_return[3]), .CK(n_0_1), .Q(
      MCOL_x_sva[3]), .QN());
   MUX2_X1 i_0_0_36 (.A(MROW_y_sva[3]), .B(MCOL_x_sva[3]), .S(n_0_0_77), 
      .Z(n_0_0_25));
   AND2_X1 i_0_0_25 (.A1(n_0_0_20), .A2(n_0_0_10), .ZN(MUX_v_10_2_211_return[2]));
   DFF_X1 \MROW_y_sva_reg[2]  (.D(MUX_v_10_2_211_return[2]), .CK(n_0_0), 
      .Q(MROW_y_sva[2]), .QN());
   AND2_X1 i_0_0_11 (.A1(EdgeDetect_IP_Mix_run_run_fsm_inst_state_var[0]), 
      .A2(n_0_0_10), .ZN(MUX_v_11_2_25_return[2]));
   DFF_X1 \MCOL_x_sva_reg[2]  (.D(MUX_v_11_2_25_return[2]), .CK(n_0_1), .Q(
      MCOL_x_sva[2]), .QN());
   MUX2_X1 i_0_0_35 (.A(MROW_y_sva[2]), .B(MCOL_x_sva[2]), .S(n_0_0_77), 
      .Z(n_0_0_24));
   AND2_X1 i_0_0_24 (.A1(n_0_0_20), .A2(n_0_0_9), .ZN(MUX_v_10_2_211_return[1]));
   DFF_X1 \MROW_y_sva_reg[1]  (.D(MUX_v_10_2_211_return[1]), .CK(n_0_0), 
      .Q(MROW_y_sva[1]), .QN());
   AND2_X1 i_0_0_10 (.A1(EdgeDetect_IP_Mix_run_run_fsm_inst_state_var[0]), 
      .A2(n_0_0_9), .ZN(MUX_v_11_2_25_return[1]));
   DFF_X1 \MCOL_x_sva_reg[1]  (.D(MUX_v_11_2_25_return[1]), .CK(n_0_1), .Q(
      MCOL_x_sva[1]), .QN());
   MUX2_X1 i_0_0_34 (.A(MROW_y_sva[1]), .B(MCOL_x_sva[1]), .S(n_0_0_77), 
      .Z(n_0_0_23));
   NOR2_X1 i_0_0_23 (.A1(n_0_0_22), .A2(n_0_0_21), .ZN(MUX_v_10_2_211_return[0]));
   DFF_X1 \MROW_y_sva_reg[0]  (.D(MUX_v_10_2_211_return[0]), .CK(n_0_0), 
      .Q(MROW_y_sva[0]), .QN());
   NOR2_X1 i_0_0_9 (.A1(n_0_0_22), .A2(n_0_0_118), .ZN(MUX_v_11_2_25_return[0]));
   DFF_X1 \MCOL_x_sva_reg[0]  (.D(MUX_v_11_2_25_return[0]), .CK(n_0_1), .Q(
      MCOL_x_sva[0]), .QN());
   MUX2_X1 i_0_0_33 (.A(MROW_y_sva[0]), .B(MCOL_x_sva[0]), .S(n_0_0_77), 
      .Z(n_0_0_22));
   HA_X1 i_0_0_0 (.A(n_0_0_23), .B(n_0_0_22), .CO(n_0_0_0), .S(n_0_0_9));
   HA_X1 i_0_0_1 (.A(n_0_0_24), .B(n_0_0_0), .CO(n_0_0_1), .S(n_0_0_10));
   HA_X1 i_0_0_2 (.A(n_0_0_25), .B(n_0_0_1), .CO(n_0_0_2), .S(n_0_0_11));
   HA_X1 i_0_0_3 (.A(n_0_0_26), .B(n_0_0_2), .CO(n_0_0_3), .S(n_0_0_12));
   HA_X1 i_0_0_4 (.A(n_0_0_27), .B(n_0_0_3), .CO(n_0_0_4), .S(n_0_0_13));
   HA_X1 i_0_0_5 (.A(n_0_0_28), .B(n_0_0_4), .CO(n_0_0_5), .S(n_0_0_14));
   HA_X1 i_0_0_6 (.A(n_0_0_29), .B(n_0_0_5), .CO(n_0_0_6), .S(n_0_0_15));
   HA_X1 i_0_0_7 (.A(n_0_0_30), .B(n_0_0_6), .CO(n_0_0_7), .S(n_0_0_16));
   HA_X1 i_0_0_8 (.A(n_0_0_31), .B(n_0_0_7), .CO(n_0_0_8), .S(n_0_0_17));
   NAND3_X1 i_0_0_20 (.A1(n_0_0_19), .A2(n_0_0_8), .A3(
      EdgeDetect_IP_Mix_run_run_fsm_inst_state_var[0]), .ZN(n_0_0_18));
   OAI21_X1 i_0_0_19 (.A(n_0_0_18), .B1(n_0_0_19), .B2(n_0_0_8), .ZN(
      MUX_v_11_2_25_return[10]));
   DFF_X1 \MCOL_x_sva_reg[10]  (.D(MUX_v_11_2_25_return[10]), .CK(n_0_1), 
      .Q(MCOL_x_sva[10]), .QN());
   XNOR2_X1 i_0_0_136 (.A(widthIn[10]), .B(MCOL_x_sva[10]), .ZN(n_0_0_89));
   NOR2_X1 i_0_0_135 (.A1(n_0_0_92), .A2(n_0_0_89), .ZN(n_0_0_88));
   INV_X1 i_0_0_172 (.A(MCOL_x_sva[9]), .ZN(n_0_0_128));
   AOI21_X1 i_0_0_138 (.A(n_0_0_92), .B1(widthIn[9]), .B2(n_0_0_96), .ZN(
      n_0_0_91));
   INV_X1 i_0_0_137 (.A(n_0_0_91), .ZN(n_0_0_90));
   AOI221_X1 i_0_0_134 (.A(n_0_0_88), .B1(n_0_0_92), .B2(n_0_0_89), .C1(
      n_0_0_128), .C2(n_0_0_90), .ZN(n_0_0_87));
   NOR2_X1 i_0_0_160 (.A1(widthIn[2]), .A2(n_0_0_124), .ZN(n_0_0_113));
   AOI21_X1 i_0_0_159 (.A(n_0_0_113), .B1(widthIn[2]), .B2(n_0_0_124), .ZN(
      n_0_0_112));
   XNOR2_X1 i_0_0_158 (.A(MCOL_x_sva[2]), .B(n_0_0_112), .ZN(n_0_0_111));
   XOR2_X1 i_0_0_154 (.A(widthIn[3]), .B(MCOL_x_sva[3]), .Z(n_0_0_107));
   XNOR2_X1 i_0_0_153 (.A(n_0_0_113), .B(n_0_0_107), .ZN(n_0_0_106));
   XOR2_X1 i_0_0_157 (.A(widthIn[1]), .B(MCOL_x_sva[1]), .Z(n_0_0_110));
   NOR2_X1 i_0_0_156 (.A1(widthIn[0]), .A2(n_0_0_110), .ZN(n_0_0_109));
   INV_X1 i_0_0_174 (.A(MCOL_x_sva[0]), .ZN(n_0_0_130));
   AOI221_X1 i_0_0_155 (.A(n_0_0_109), .B1(widthIn[0]), .B2(MCOL_x_sva[0]), 
      .C1(n_0_0_130), .C2(n_0_0_110), .ZN(n_0_0_108));
   XNOR2_X1 i_0_0_166 (.A(widthIn[5]), .B(MCOL_x_sva[5]), .ZN(n_0_0_122));
   INV_X1 i_0_0_163 (.A(n_0_0_120), .ZN(n_0_0_119));
   OAI211_X1 i_0_0_152 (.A(n_0_0_106), .B(n_0_0_108), .C1(n_0_0_122), .C2(
      n_0_0_119), .ZN(n_0_0_105));
   OAI21_X1 i_0_0_165 (.A(n_0_0_122), .B1(n_0_0_132), .B2(n_0_0_123), .ZN(
      n_0_0_121));
   NOR3_X1 i_0_0_162 (.A1(MCOL_x_sva[4]), .A2(n_0_0_119), .A3(n_0_0_121), 
      .ZN(n_0_0_115));
   AOI21_X1 i_0_0_161 (.A(n_0_0_115), .B1(MCOL_x_sva[4]), .B2(n_0_0_121), 
      .ZN(n_0_0_114));
   OR3_X1 i_0_0_151 (.A1(n_0_0_111), .A2(n_0_0_105), .A3(n_0_0_114), .ZN(
      n_0_0_104));
   OAI21_X1 i_0_0_148 (.A(n_0_0_102), .B1(n_0_0_131), .B2(n_0_0_103), .ZN(
      n_0_0_101));
   XOR2_X1 i_0_0_147 (.A(MCOL_x_sva[6]), .B(n_0_0_101), .Z(n_0_0_100));
   AOI21_X1 i_0_0_145 (.A(n_0_0_99), .B1(widthIn[7]), .B2(n_0_0_102), .ZN(
      n_0_0_98));
   XNOR2_X1 i_0_0_144 (.A(MCOL_x_sva[7]), .B(n_0_0_98), .ZN(n_0_0_97));
   OAI21_X1 i_0_0_142 (.A(n_0_0_96), .B1(n_0_0_129), .B2(n_0_0_99), .ZN(n_0_0_95));
   XOR2_X1 i_0_0_141 (.A(MCOL_x_sva[8]), .B(n_0_0_95), .Z(n_0_0_94));
   NOR4_X1 i_0_0_140 (.A1(n_0_0_104), .A2(n_0_0_100), .A3(n_0_0_97), .A4(
      n_0_0_94), .ZN(n_0_0_93));
   OAI211_X1 i_0_0_133 (.A(n_0_0_87), .B(n_0_0_93), .C1(n_0_0_128), .C2(n_0_0_90), 
      .ZN(n_0_0_86));
   INV_X1 i_0_0_132 (.A(n_0_0_86), .ZN(MCOL_equal_1_tmp));
   AOI211_X1 i_0_0_47 (.A(rst), .B(n_0_0_41), .C1(MCOL_equal_1_tmp), .C2(
      EdgeDetect_IP_Mix_run_run_fsm_inst_state_var[0]), .ZN(n_0_24));
   INV_X1 i_0_0_71 (.A(rst), .ZN(n_0_0_116));
   NAND2_X1 i_0_0_53 (.A1(n_0_0_116), .A2(n_0_0_78), .ZN(
      EdgeDetect_IP_Mix_run_run_fsm_inst_n_1));
   CLKGATE_X1 clk_gate_reg_rgb_out_rsci_oswt_cse_reg (.CK(clk), .E(
      EdgeDetect_IP_Mix_run_run_fsm_inst_n_1), .GCK(n_0_2));
   DFFR_X1 MCOL_stage_0_reg (.D(n_0_24), .RN(arst_n), .CK(n_0_2), .Q(
      MCOL_stage_0), .QN());
   NOR2_X1 i_0_0_49 (.A1(n_0_0_118), .A2(MCOL_stage_0), .ZN(n_0_0_41));
   AOI211_X1 i_0_0_84 (.A(rst), .B(n_0_0_41), .C1(
      EdgeDetect_IP_Mix_run_run_fsm_inst_state_var[1]), .C2(
      EdgeDetect_IP_Mix_run_run_fsm_inst_state_var[0]), .ZN(
      EdgeDetect_IP_Mix_run_run_fsm_inst_n_2));
   DFFR_X1 \EdgeDetect_IP_Mix_run_run_fsm_inst_state_var_reg[0]  (.D(
      EdgeDetect_IP_Mix_run_run_fsm_inst_n_2), .RN(arst_n), .CK(n_0_2), .Q(
      EdgeDetect_IP_Mix_run_run_fsm_inst_state_var[0]), .QN());
   INV_X1 i_0_0_79 (.A(EdgeDetect_IP_Mix_run_run_fsm_inst_state_var[0]), 
      .ZN(n_0_0_118));
   NOR2_X1 i_0_0_63 (.A1(n_0_0_118), .A2(
      EdgeDetect_IP_Mix_run_run_fsm_inst_state_var[1]), .ZN(n_0_0_77));
   INV_X1 i_0_0_74 (.A(MCOL_stage_0), .ZN(n_0_0_117));
   NAND2_X1 i_0_0_52 (.A1(n_0_0_77), .A2(n_0_0_117), .ZN(n_0_0_75));
   INV_X1 i_0_0_170 (.A(heightIn[2]), .ZN(n_0_0_126));
   NOR2_X1 i_0_0_131 (.A1(heightIn[1]), .A2(heightIn[0]), .ZN(n_0_0_85));
   NAND2_X1 i_0_0_130 (.A1(n_0_0_126), .A2(n_0_0_85), .ZN(n_0_0_84));
   NOR2_X1 i_0_0_129 (.A1(heightIn[3]), .A2(n_0_0_84), .ZN(n_0_0_83));
   INV_X1 i_0_0_128 (.A(n_0_0_83), .ZN(n_0_0_82));
   NOR2_X1 i_0_0_127 (.A1(heightIn[4]), .A2(n_0_0_82), .ZN(n_0_0_81));
   INV_X1 i_0_0_126 (.A(n_0_0_81), .ZN(n_0_0_80));
   NOR2_X1 i_0_0_124 (.A1(heightIn[5]), .A2(n_0_0_80), .ZN(n_0_0_79));
   INV_X1 i_0_0_123 (.A(n_0_0_79), .ZN(n_0_0_74));
   NOR2_X1 i_0_0_122 (.A1(heightIn[6]), .A2(n_0_0_74), .ZN(n_0_0_73));
   INV_X1 i_0_0_121 (.A(n_0_0_73), .ZN(n_0_0_72));
   NOR2_X1 i_0_0_120 (.A1(heightIn[7]), .A2(n_0_0_72), .ZN(n_0_0_71));
   INV_X1 i_0_0_119 (.A(n_0_0_71), .ZN(n_0_0_70));
   NOR2_X1 i_0_0_118 (.A1(heightIn[8]), .A2(n_0_0_70), .ZN(n_0_0_69));
   AOI21_X1 i_0_0_116 (.A(n_0_0_69), .B1(heightIn[8]), .B2(n_0_0_70), .ZN(
      n_0_0_67));
   NOR2_X1 i_0_0_115 (.A1(MROW_y_sva[8]), .A2(n_0_0_67), .ZN(n_0_0_66));
   AOI21_X1 i_0_0_101 (.A(n_0_0_79), .B1(heightIn[5]), .B2(n_0_0_80), .ZN(
      n_0_0_52));
   NOR2_X1 i_0_0_100 (.A1(MROW_y_sva[5]), .A2(n_0_0_52), .ZN(n_0_0_51));
   OAI21_X1 i_0_0_110 (.A(n_0_0_84), .B1(n_0_0_126), .B2(n_0_0_85), .ZN(n_0_0_61));
   XOR2_X1 i_0_0_109 (.A(MROW_y_sva[2]), .B(n_0_0_61), .Z(n_0_0_60));
   AOI21_X1 i_0_0_108 (.A(n_0_0_85), .B1(heightIn[1]), .B2(heightIn[0]), 
      .ZN(n_0_0_59));
   NOR2_X1 i_0_0_107 (.A1(MROW_y_sva[1]), .A2(n_0_0_59), .ZN(n_0_0_58));
   AOI21_X1 i_0_0_112 (.A(n_0_0_83), .B1(heightIn[3]), .B2(n_0_0_84), .ZN(
      n_0_0_63));
   XNOR2_X1 i_0_0_111 (.A(MROW_y_sva[3]), .B(n_0_0_63), .ZN(n_0_0_62));
   AOI211_X1 i_0_0_106 (.A(n_0_0_58), .B(n_0_0_62), .C1(MROW_y_sva[1]), .C2(
      n_0_0_59), .ZN(n_0_0_57));
   INV_X1 i_0_0_171 (.A(heightIn[0]), .ZN(n_0_0_127));
   INV_X1 i_0_0_169 (.A(MROW_y_sva[0]), .ZN(n_0_0_125));
   OAI221_X1 i_0_0_105 (.A(n_0_0_57), .B1(heightIn[0]), .B2(MROW_y_sva[0]), 
      .C1(n_0_0_127), .C2(n_0_0_125), .ZN(n_0_0_56));
   AOI21_X1 i_0_0_104 (.A(n_0_0_81), .B1(heightIn[4]), .B2(n_0_0_82), .ZN(
      n_0_0_55));
   XNOR2_X1 i_0_0_103 (.A(MROW_y_sva[4]), .B(n_0_0_55), .ZN(n_0_0_54));
   OR3_X1 i_0_0_102 (.A1(n_0_0_60), .A2(n_0_0_56), .A3(n_0_0_54), .ZN(n_0_0_53));
   AOI211_X1 i_0_0_99 (.A(n_0_0_51), .B(n_0_0_53), .C1(MROW_y_sva[5]), .C2(
      n_0_0_52), .ZN(n_0_0_50));
   AOI21_X1 i_0_0_95 (.A(n_0_0_71), .B1(heightIn[7]), .B2(n_0_0_72), .ZN(
      n_0_0_46));
   NOR2_X1 i_0_0_94 (.A1(MROW_y_sva[7]), .A2(n_0_0_46), .ZN(n_0_0_45));
   AOI21_X1 i_0_0_98 (.A(n_0_0_73), .B1(heightIn[6]), .B2(n_0_0_74), .ZN(
      n_0_0_49));
   XOR2_X1 i_0_0_97 (.A(MROW_y_sva[6]), .B(n_0_0_49), .Z(n_0_0_48));
   INV_X1 i_0_0_117 (.A(n_0_0_69), .ZN(n_0_0_68));
   XOR2_X1 i_0_0_114 (.A(heightIn[9]), .B(MROW_y_sva[9]), .Z(n_0_0_65));
   OAI21_X1 i_0_0_96 (.A(n_0_0_48), .B1(n_0_0_68), .B2(n_0_0_65), .ZN(n_0_0_47));
   AOI211_X1 i_0_0_93 (.A(n_0_0_45), .B(n_0_0_47), .C1(MROW_y_sva[7]), .C2(
      n_0_0_46), .ZN(n_0_0_44));
   INV_X1 i_0_0_113 (.A(n_0_0_65), .ZN(n_0_0_64));
   OAI211_X1 i_0_0_92 (.A(n_0_0_50), .B(n_0_0_44), .C1(n_0_0_69), .C2(n_0_0_64), 
      .ZN(n_0_0_43));
   AOI211_X1 i_0_0_91 (.A(n_0_0_66), .B(n_0_0_43), .C1(MROW_y_sva[8]), .C2(
      n_0_0_67), .ZN(n_0_0_38));
   NAND3_X1 i_0_0_51 (.A1(EdgeDetect_IP_Mix_run_run_fsm_inst_state_var[1]), 
      .A2(n_0_0_38), .A3(n_0_0_118), .ZN(n_0_0_42));
   AOI21_X1 i_0_0_50 (.A(rst), .B1(n_0_0_75), .B2(n_0_0_42), .ZN(
      EdgeDetect_IP_Mix_run_run_fsm_inst_n_3));
   DFFR_X1 \EdgeDetect_IP_Mix_run_run_fsm_inst_state_var_reg[1]  (.D(
      EdgeDetect_IP_Mix_run_run_fsm_inst_n_3), .RN(arst_n), .CK(n_0_2), .Q(
      EdgeDetect_IP_Mix_run_run_fsm_inst_state_var[1]), .QN());
   INV_X1 i_0_0_46 (.A(n_0_24), .ZN(n_0_0_40));
   NAND2_X1 i_0_0_44 (.A1(n_0_0_118), .A2(n_0_0_116), .ZN(n_0_0_39));
   OAI22_X1 i_0_0_43 (.A1(EdgeDetect_IP_Mix_run_run_fsm_inst_state_var[1]), 
      .A2(n_0_0_40), .B1(n_0_0_39), .B2(n_0_0_38), .ZN(n_0_19));
   DFFR_X1 reg_magn_rsci_oswt_cse_reg (.D(n_0_19), .RN(arst_n), .CK(n_0_2), 
      .Q(reg_magn_rsci_oswt_cse), .QN());
   EdgeDetect_IP_Mix_run_magn_rsci EdgeDetect_IP_Mix_run_magn_rsci_inst (
      .clk(clk), .rst(rst), .arst_n(arst_n), .magn_rsc_dat({magn_rsc_dat[7], 
      uc_0, uc_1, uc_2, uc_3, uc_4, uc_5, uc_6}), .magn_rsc_vld(magn_rsc_vld), 
      .magn_rsc_rdy(magn_rsc_rdy), .run_wen(run_wen), .magn_rsci_oswt(
      reg_magn_rsci_oswt_cse), .magn_rsci_wen_comp(magn_rsci_wen_comp), 
      .magn_rsci_idat_mxwt({magn_rsci_idat_mxwt[7], uc_7, uc_8, uc_9, uc_10, 
      uc_11, uc_12, uc_13}));
   NAND2_X1 i_0_0_55 (.A1(MCOL_stage_0), .A2(n_0_0_77), .ZN(n_0_0_76));
   NOR2_X1 i_0_0_48 (.A1(n_0_0_76), .A2(rst), .ZN(n_0_27));
   DFFR_X1 reg_rgb_out_rsci_oswt_cse_reg (.D(n_0_27), .RN(arst_n), .CK(n_0_2), 
      .Q(reg_rgb_out_rsci_oswt_cse), .QN());
   EdgeDetect_IP_Mix_run_rgb_out_rsci EdgeDetect_IP_Mix_run_rgb_out_rsci_inst (
      .clk(clk), .rst(rst), .arst_n(arst_n), .rgb_out_rsc_dat(), 
      .rgb_out_rsc_vld(rgb_out_rsc_vld), .rgb_out_rsc_rdy(rgb_out_rsc_rdy), 
      .run_wen(run_wen), .rgb_out_rsci_oswt(reg_rgb_out_rsci_oswt_cse), 
      .rgb_out_rsci_wen_comp(rgb_out_rsci_wen_comp), .rgb_out_rsci_idat({uc_14, 
      uc_15, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, uc_16, uc_17, uc_18, 
      uc_19, uc_20, uc_21, uc_22, uc_23, uc_24, uc_25, uc_26, uc_27, uc_28, 
      uc_29, uc_30, uc_31, uc_32, uc_33, uc_34, uc_35, uc_36, uc_37, uc_38, 
      uc_39, uc_40}));
   NAND3_X1 i_0_0_66 (.A1(magn_rsci_wen_comp), .A2(rgb_out_rsci_wen_comp), 
      .A3(grb_in_rsci_wen_comp), .ZN(n_0_0_78));
   INV_X1 i_0_0_125 (.A(n_0_0_78), .ZN(run_wen));
   EdgeDetect_IP_Mix_run_grb_in_rsci EdgeDetect_IP_Mix_run_grb_in_rsci_inst (
      .clk(clk), .rst(rst), .arst_n(arst_n), .grb_in_rsc_dat({grb_in_rsc_dat[23], 
      grb_in_rsc_dat[22], grb_in_rsc_dat[21], grb_in_rsc_dat[20], 
      grb_in_rsc_dat[19], grb_in_rsc_dat[18], grb_in_rsc_dat[17], uc_41, 
      grb_in_rsc_dat[15], grb_in_rsc_dat[14], grb_in_rsc_dat[13], 
      grb_in_rsc_dat[12], uc_42, grb_in_rsc_dat[10], grb_in_rsc_dat[9], uc_43, 
      grb_in_rsc_dat[7], grb_in_rsc_dat[6], grb_in_rsc_dat[5], grb_in_rsc_dat[4], 
      uc_44, grb_in_rsc_dat[2], grb_in_rsc_dat[1], uc_45}), .grb_in_rsc_vld(
      grb_in_rsc_vld), .grb_in_rsc_rdy(grb_in_rsc_rdy), .run_wen(run_wen), 
      .grb_in_rsci_oswt(reg_magn_rsci_oswt_cse), .grb_in_rsci_wen_comp(
      grb_in_rsci_wen_comp), .grb_in_rsci_idat_mxwt({grb_in_rsci_idat_mxwt[23], 
      grb_in_rsci_idat_mxwt[22], grb_in_rsci_idat_mxwt[21], 
      grb_in_rsci_idat_mxwt[20], grb_in_rsci_idat_mxwt[19], 
      grb_in_rsci_idat_mxwt[18], grb_in_rsci_idat_mxwt[17], uc_46, 
      grb_in_rsci_idat_mxwt[15], grb_in_rsci_idat_mxwt[14], 
      grb_in_rsci_idat_mxwt[13], grb_in_rsci_idat_mxwt[12], uc_47, 
      grb_in_rsci_idat_mxwt[10], grb_in_rsci_idat_mxwt[9], uc_48, 
      grb_in_rsci_idat_mxwt[7], grb_in_rsci_idat_mxwt[6], 
      grb_in_rsci_idat_mxwt[5], grb_in_rsci_idat_mxwt[4], uc_49, 
      grb_in_rsci_idat_mxwt[2], grb_in_rsci_idat_mxwt[1], uc_50}));
   NOR2_X1 i_0_0_54 (.A1(n_0_0_78), .A2(n_0_0_76), .ZN(MCOL_and_3_cse));
   CLKGATE_X1 clk_gate_rgb_out_rsci_idat_33_reg (.CK(clk), .E(MCOL_and_3_cse), 
      .GCK(n_0_3));
   DFF_X1 rgb_out_rsci_idat_33_reg (.D(MCOL_equal_1_tmp), .CK(n_0_3), .Q(
      rgb_out_rsc_dat[33]), .QN());
   OR4_X1 i_0_0_89 (.A1(MROW_y_sva[0]), .A2(MROW_y_sva[9]), .A3(MROW_y_sva[8]), 
      .A4(MROW_y_sva[7]), .ZN(n_0_0_37));
   NOR4_X1 i_0_0_88 (.A1(MROW_y_sva[1]), .A2(MCOL_x_sva[4]), .A3(MCOL_x_sva[3]), 
      .A4(MCOL_x_sva[2]), .ZN(n_0_0_36));
   NOR4_X1 i_0_0_87 (.A1(MROW_y_sva[6]), .A2(MCOL_x_sva[0]), .A3(MROW_y_sva[3]), 
      .A4(MROW_y_sva[2]), .ZN(n_0_0_35));
   NOR3_X1 i_0_0_86 (.A1(MCOL_x_sva[5]), .A2(MCOL_x_sva[6]), .A3(MCOL_x_sva[7]), 
      .ZN(n_0_0_34));
   NOR4_X1 i_0_0_85 (.A1(MCOL_x_sva[1]), .A2(MCOL_x_sva[10]), .A3(MCOL_x_sva[9]), 
      .A4(MCOL_x_sva[8]), .ZN(n_0_0_33));
   NAND4_X1 i_0_0_83 (.A1(n_0_0_36), .A2(n_0_0_35), .A3(n_0_0_34), .A4(n_0_0_33), 
      .ZN(n_0_0_32));
   NOR4_X1 i_0_0_82 (.A1(MROW_y_sva[4]), .A2(n_0_0_37), .A3(MROW_y_sva[5]), 
      .A4(n_0_0_32), .ZN(n_0_6));
   DFF_X1 rgb_out_rsci_idat_32_reg (.D(n_0_6), .CK(n_0_3), .Q(
      rgb_out_rsc_dat[32]), .QN());
   AND2_X1 i_0_0_90 (.A1(MCOL_equal_1_tmp), .A2(n_0_0_38), .ZN(n_0_7));
   DFF_X1 rgb_out_rsci_idat_24_reg (.D(n_0_7), .CK(n_0_3), .Q(
      rgb_out_rsc_dat[24]), .QN());
   AND2_X1 i_0_0_62 (.A1(magn_rsci_idat_mxwt[7]), .A2(grb_in_rsci_idat_mxwt[23]), 
      .ZN(n_0_15));
   DFF_X1 \rgb_out_rsci_idat_23_16_reg[7]  (.D(n_0_15), .CK(n_0_3), .Q(
      rgb_out_rsc_dat[23]), .QN());
   AND2_X1 i_0_0_61 (.A1(magn_rsci_idat_mxwt[7]), .A2(grb_in_rsci_idat_mxwt[22]), 
      .ZN(n_0_14));
   DFF_X1 \rgb_out_rsci_idat_23_16_reg[6]  (.D(n_0_14), .CK(n_0_3), .Q(
      rgb_out_rsc_dat[22]), .QN());
   AND2_X1 i_0_0_60 (.A1(magn_rsci_idat_mxwt[7]), .A2(grb_in_rsci_idat_mxwt[21]), 
      .ZN(n_0_13));
   DFF_X1 \rgb_out_rsci_idat_23_16_reg[5]  (.D(n_0_13), .CK(n_0_3), .Q(
      rgb_out_rsc_dat[21]), .QN());
   AND2_X1 i_0_0_59 (.A1(magn_rsci_idat_mxwt[7]), .A2(grb_in_rsci_idat_mxwt[20]), 
      .ZN(n_0_12));
   DFF_X1 \rgb_out_rsci_idat_23_16_reg[4]  (.D(n_0_12), .CK(n_0_3), .Q(
      rgb_out_rsc_dat[20]), .QN());
   AND2_X1 i_0_0_58 (.A1(magn_rsci_idat_mxwt[7]), .A2(grb_in_rsci_idat_mxwt[19]), 
      .ZN(n_0_11));
   DFF_X1 \rgb_out_rsci_idat_23_16_reg[3]  (.D(n_0_11), .CK(n_0_3), .Q(
      rgb_out_rsc_dat[19]), .QN());
   AND2_X1 i_0_0_57 (.A1(magn_rsci_idat_mxwt[7]), .A2(grb_in_rsci_idat_mxwt[18]), 
      .ZN(n_0_10));
   DFF_X1 \rgb_out_rsci_idat_23_16_reg[2]  (.D(n_0_10), .CK(n_0_3), .Q(
      rgb_out_rsc_dat[18]), .QN());
   AND2_X1 i_0_0_56 (.A1(magn_rsci_idat_mxwt[7]), .A2(grb_in_rsci_idat_mxwt[17]), 
      .ZN(n_0_9));
   DFF_X1 \rgb_out_rsci_idat_23_16_reg[1]  (.D(n_0_9), .CK(n_0_3), .Q(
      rgb_out_rsc_dat[17]), .QN());
   AND2_X1 i_0_0_70 (.A1(magn_rsci_idat_mxwt[7]), .A2(grb_in_rsci_idat_mxwt[15]), 
      .ZN(n_0_23));
   DFF_X1 \rgb_out_rsci_idat_15_8_reg[7]  (.D(n_0_23), .CK(n_0_3), .Q(
      rgb_out_rsc_dat[15]), .QN());
   AND2_X1 i_0_0_69 (.A1(magn_rsci_idat_mxwt[7]), .A2(grb_in_rsci_idat_mxwt[14]), 
      .ZN(n_0_22));
   DFF_X1 \rgb_out_rsci_idat_15_8_reg[6]  (.D(n_0_22), .CK(n_0_3), .Q(
      rgb_out_rsc_dat[14]), .QN());
   AND2_X1 i_0_0_68 (.A1(magn_rsci_idat_mxwt[7]), .A2(grb_in_rsci_idat_mxwt[13]), 
      .ZN(n_0_21));
   DFF_X1 \rgb_out_rsci_idat_15_8_reg[5]  (.D(n_0_21), .CK(n_0_3), .Q(
      rgb_out_rsc_dat[13]), .QN());
   AND2_X1 i_0_0_67 (.A1(magn_rsci_idat_mxwt[7]), .A2(grb_in_rsci_idat_mxwt[12]), 
      .ZN(n_0_20));
   DFF_X1 \rgb_out_rsci_idat_15_8_reg[4]  (.D(n_0_20), .CK(n_0_3), .Q(
      rgb_out_rsc_dat[12]), .QN());
   AND2_X1 i_0_0_65 (.A1(magn_rsci_idat_mxwt[7]), .A2(grb_in_rsci_idat_mxwt[10]), 
      .ZN(n_0_18));
   DFF_X1 \rgb_out_rsci_idat_15_8_reg[2]  (.D(n_0_18), .CK(n_0_3), .Q(
      rgb_out_rsc_dat[10]), .QN());
   AND2_X1 i_0_0_64 (.A1(magn_rsci_idat_mxwt[7]), .A2(grb_in_rsci_idat_mxwt[9]), 
      .ZN(n_0_17));
   DFF_X1 \rgb_out_rsci_idat_15_8_reg[1]  (.D(n_0_17), .CK(n_0_3), .Q(
      rgb_out_rsc_dat[9]), .QN());
   AND2_X1 i_0_0_78 (.A1(magn_rsci_idat_mxwt[7]), .A2(grb_in_rsci_idat_mxwt[7]), 
      .ZN(n_0_16));
   DFF_X1 \rgb_out_rsci_idat_7_0_reg[7]  (.D(n_0_16), .CK(n_0_3), .Q(
      rgb_out_rsc_dat[7]), .QN());
   AND2_X1 i_0_0_77 (.A1(magn_rsci_idat_mxwt[7]), .A2(grb_in_rsci_idat_mxwt[6]), 
      .ZN(n_0_8));
   DFF_X1 \rgb_out_rsci_idat_7_0_reg[6]  (.D(n_0_8), .CK(n_0_3), .Q(
      rgb_out_rsc_dat[6]), .QN());
   AND2_X1 i_0_0_76 (.A1(magn_rsci_idat_mxwt[7]), .A2(grb_in_rsci_idat_mxwt[5]), 
      .ZN(n_0_29));
   DFF_X1 \rgb_out_rsci_idat_7_0_reg[5]  (.D(n_0_29), .CK(n_0_3), .Q(
      rgb_out_rsc_dat[5]), .QN());
   AND2_X1 i_0_0_75 (.A1(magn_rsci_idat_mxwt[7]), .A2(grb_in_rsci_idat_mxwt[4]), 
      .ZN(n_0_28));
   DFF_X1 \rgb_out_rsci_idat_7_0_reg[4]  (.D(n_0_28), .CK(n_0_3), .Q(
      rgb_out_rsc_dat[4]), .QN());
   AND2_X1 i_0_0_73 (.A1(magn_rsci_idat_mxwt[7]), .A2(grb_in_rsci_idat_mxwt[2]), 
      .ZN(n_0_26));
   DFF_X1 \rgb_out_rsci_idat_7_0_reg[2]  (.D(n_0_26), .CK(n_0_3), .Q(
      rgb_out_rsc_dat[2]), .QN());
   AND2_X1 i_0_0_72 (.A1(magn_rsci_idat_mxwt[7]), .A2(grb_in_rsci_idat_mxwt[1]), 
      .ZN(n_0_25));
   DFF_X1 \rgb_out_rsci_idat_7_0_reg[1]  (.D(n_0_25), .CK(n_0_3), .Q(
      rgb_out_rsc_dat[1]), .QN());
endmodule

module EdgeDetect_IP_Mix_struct(clk, rst, arst_n, grb_in_rsc_dat_b_pixelType, 
      grb_in_rsc_dat_g_pixelType, grb_in_rsc_dat_r_pixelType, grb_in_rsc_vld, 
      grb_in_rsc_rdy, widthIn, heightIn, magn_rsc_dat, magn_rsc_vld, 
      magn_rsc_rdy, rgb_out_rsc_dat_eol, rgb_out_rsc_dat_sof, 
      rgb_out_rsc_dat_dummy, rgb_out_rsc_dat_b_pixelType, 
      rgb_out_rsc_dat_g_pixelType, rgb_out_rsc_dat_r_pixelType, rgb_out_rsc_vld, 
      rgb_out_rsc_rdy);
   input clk;
   input rst;
   input arst_n;
   input [7:0]grb_in_rsc_dat_b_pixelType;
   input [7:0]grb_in_rsc_dat_g_pixelType;
   input [7:0]grb_in_rsc_dat_r_pixelType;
   input grb_in_rsc_vld;
   output grb_in_rsc_rdy;
   input [10:0]widthIn;
   input [9:0]heightIn;
   input [7:0]magn_rsc_dat;
   input magn_rsc_vld;
   output magn_rsc_rdy;
   output rgb_out_rsc_dat_eol;
   output rgb_out_rsc_dat_sof;
   output [7:0]rgb_out_rsc_dat_dummy;
   output [7:0]rgb_out_rsc_dat_b_pixelType;
   output [7:0]rgb_out_rsc_dat_g_pixelType;
   output [7:0]rgb_out_rsc_dat_r_pixelType;
   output rgb_out_rsc_vld;
   input rgb_out_rsc_rdy;

   EdgeDetect_IP_Mix_run EdgeDetect_IP_Mix_run_inst (.clk(clk), .rst(rst), 
      .arst_n(arst_n), .grb_in_rsc_dat({grb_in_rsc_dat_b_pixelType[7], 
      grb_in_rsc_dat_b_pixelType[6], grb_in_rsc_dat_b_pixelType[5], 
      grb_in_rsc_dat_b_pixelType[4], grb_in_rsc_dat_b_pixelType[3], 
      grb_in_rsc_dat_b_pixelType[2], grb_in_rsc_dat_b_pixelType[1], uc_0, 
      grb_in_rsc_dat_g_pixelType[7], grb_in_rsc_dat_g_pixelType[6], 
      grb_in_rsc_dat_g_pixelType[5], grb_in_rsc_dat_g_pixelType[4], uc_1, 
      grb_in_rsc_dat_g_pixelType[2], grb_in_rsc_dat_g_pixelType[1], uc_2, 
      grb_in_rsc_dat_r_pixelType[7], grb_in_rsc_dat_r_pixelType[6], 
      grb_in_rsc_dat_r_pixelType[5], grb_in_rsc_dat_r_pixelType[4], uc_3, 
      grb_in_rsc_dat_r_pixelType[2], grb_in_rsc_dat_r_pixelType[1], uc_4}), 
      .grb_in_rsc_vld(grb_in_rsc_vld), .grb_in_rsc_rdy(grb_in_rsc_rdy), .widthIn(
      widthIn), .heightIn(heightIn), .magn_rsc_dat({magn_rsc_dat[7], uc_5, uc_6, 
      uc_7, uc_8, uc_9, uc_10, uc_11}), .magn_rsc_vld(magn_rsc_vld), 
      .magn_rsc_rdy(magn_rsc_rdy), .rgb_out_rsc_dat({rgb_out_rsc_dat_eol, 
      rgb_out_rsc_dat_sof, uc_12, uc_13, uc_14, uc_15, uc_16, uc_17, uc_18, 
      rgb_out_rsc_dat_dummy[0], rgb_out_rsc_dat_b_pixelType[7], 
      rgb_out_rsc_dat_b_pixelType[6], rgb_out_rsc_dat_b_pixelType[5], 
      rgb_out_rsc_dat_b_pixelType[4], rgb_out_rsc_dat_b_pixelType[3], 
      rgb_out_rsc_dat_b_pixelType[2], rgb_out_rsc_dat_b_pixelType[1], uc_19, 
      rgb_out_rsc_dat_g_pixelType[7], rgb_out_rsc_dat_g_pixelType[6], 
      rgb_out_rsc_dat_g_pixelType[5], rgb_out_rsc_dat_g_pixelType[4], uc_20, 
      rgb_out_rsc_dat_g_pixelType[2], rgb_out_rsc_dat_g_pixelType[1], uc_21, 
      rgb_out_rsc_dat_r_pixelType[7], rgb_out_rsc_dat_r_pixelType[6], 
      rgb_out_rsc_dat_r_pixelType[5], rgb_out_rsc_dat_r_pixelType[4], uc_22, 
      rgb_out_rsc_dat_r_pixelType[2], rgb_out_rsc_dat_r_pixelType[1], uc_23}), 
      .rgb_out_rsc_vld(rgb_out_rsc_vld), .rgb_out_rsc_rdy(rgb_out_rsc_rdy));
endmodule

module EdgeDetect_IP_Mix(clk, rst, arst_n, grb_in_rsc_dat, grb_in_rsc_vld, 
      grb_in_rsc_rdy, widthIn, heightIn, magn_rsc_dat, magn_rsc_vld, 
      magn_rsc_rdy, rgb_out_rsc_dat, rgb_out_rsc_vld, rgb_out_rsc_rdy);
   input clk;
   input rst;
   input arst_n;
   input [23:0]grb_in_rsc_dat;
   input grb_in_rsc_vld;
   output grb_in_rsc_rdy;
   input [10:0]widthIn;
   input [9:0]heightIn;
   input [7:0]magn_rsc_dat;
   input magn_rsc_vld;
   output magn_rsc_rdy;
   output [33:0]rgb_out_rsc_dat;
   output rgb_out_rsc_vld;
   input rgb_out_rsc_rdy;

   EdgeDetect_IP_Mix_struct EdgeDetect_IP_Mix_struct_inst (.clk(clk), .rst(rst), 
      .arst_n(arst_n), .grb_in_rsc_dat_b_pixelType({grb_in_rsc_dat[23], 
      grb_in_rsc_dat[22], grb_in_rsc_dat[21], grb_in_rsc_dat[20], 
      grb_in_rsc_dat[19], grb_in_rsc_dat[18], grb_in_rsc_dat[17], uc_0}), 
      .grb_in_rsc_dat_g_pixelType({grb_in_rsc_dat[15], grb_in_rsc_dat[14], 
      grb_in_rsc_dat[13], grb_in_rsc_dat[12], uc_1, grb_in_rsc_dat[10], 
      grb_in_rsc_dat[9], uc_2}), .grb_in_rsc_dat_r_pixelType({grb_in_rsc_dat[7], 
      grb_in_rsc_dat[6], grb_in_rsc_dat[5], grb_in_rsc_dat[4], uc_3, 
      grb_in_rsc_dat[2], grb_in_rsc_dat[1], uc_4}), .grb_in_rsc_vld(
      grb_in_rsc_vld), .grb_in_rsc_rdy(grb_in_rsc_rdy), .widthIn(widthIn), 
      .heightIn(heightIn), .magn_rsc_dat({magn_rsc_dat[7], uc_5, uc_6, uc_7, 
      uc_8, uc_9, uc_10, uc_11}), .magn_rsc_vld(magn_rsc_vld), .magn_rsc_rdy(
      magn_rsc_rdy), .rgb_out_rsc_dat_eol(rgb_out_rsc_dat[33]), 
      .rgb_out_rsc_dat_sof(rgb_out_rsc_dat[32]), .rgb_out_rsc_dat_dummy({uc_12, 
      uc_13, uc_14, uc_15, uc_16, uc_17, uc_18, rgb_out_rsc_dat[24]}), 
      .rgb_out_rsc_dat_b_pixelType({rgb_out_rsc_dat[23], rgb_out_rsc_dat[22], 
      rgb_out_rsc_dat[21], rgb_out_rsc_dat[20], rgb_out_rsc_dat[19], 
      rgb_out_rsc_dat[18], rgb_out_rsc_dat[17], uc_19}), 
      .rgb_out_rsc_dat_g_pixelType({rgb_out_rsc_dat[15], rgb_out_rsc_dat[14], 
      rgb_out_rsc_dat[13], rgb_out_rsc_dat[12], uc_20, rgb_out_rsc_dat[10], 
      rgb_out_rsc_dat[9], uc_21}), .rgb_out_rsc_dat_r_pixelType({
      rgb_out_rsc_dat[7], rgb_out_rsc_dat[6], rgb_out_rsc_dat[5], 
      rgb_out_rsc_dat[4], uc_22, rgb_out_rsc_dat[2], rgb_out_rsc_dat[1], uc_23}), 
      .rgb_out_rsc_vld(rgb_out_rsc_vld), .rgb_out_rsc_rdy(rgb_out_rsc_rdy));
endmodule

module ccs_fifo_wait_core_v5__parameterized0(clk, en, arst, srst, din_vld, 
      din_rdy, din, dout_vld, dout_rdy, dout, sd, is_idle);
   input clk;
   input en;
   input arst;
   input srst;
   input din_vld;
   output din_rdy;
   input [7:0]din;
   output dout_vld;
   input dout_rdy;
   output [7:0]dout;
   output [0:0]sd;
   output is_idle;

   wire hs_init;
   wire HS_INIT_REG_n_0;
   wire stat;
   wire n_0_0;
   wire n_0_1;
   wire n_0_3;
   wire n_0_4;
   wire n_0_5;
   wire n_0_8;
   wire n_0_9;
   wire n_0_25;
   wire n_0_26;
   wire n_0_2;
   wire n_0_6;
   wire n_0_7;
   wire n_0_10;
   wire n_0_11;
   wire n_0_12;
   wire n_0_13;
   wire n_0_14;
   wire n_0_15;
   wire n_0_16;
   wire n_0_17;
   wire n_0_18;
   wire n_0_19;
   wire n_0_20;
   wire n_0_21;
   wire n_0_22;
   wire n_0_23;
   wire n_0_24;
   wire n_0_27;
   wire n_0_28;
   wire n_0_29;
   wire n_0_30;

   INV_X1 HS_INIT_REG_i_2 (.A(srst), .ZN(HS_INIT_REG_n_0));
   DFFR_X1 \HS_INIT_REG_z_reg[0]  (.D(HS_INIT_REG_n_0), .RN(arst), .CK(clk), 
      .Q(hs_init), .QN());
   INV_X1 i_0_25 (.A(hs_init), .ZN(n_0_16));
   INV_X1 i_0_26 (.A(dout_rdy), .ZN(n_0_17));
   INV_X1 i_0_12 (.A(stat), .ZN(n_0_25));
   INV_X1 i_0_24 (.A(srst), .ZN(n_0_15));
   NAND2_X1 i_0_20 (.A1(din_vld), .A2(din_rdy), .ZN(n_0_12));
   NOR2_X1 i_0_18 (.A1(dout_rdy), .A2(n_0_14), .ZN(n_0_10));
   INV_X1 i_0_17 (.A(n_0_10), .ZN(n_0_7));
   NOR2_X1 i_0_4 (.A1(n_0_14), .A2(srst), .ZN(n_0_1));
   NAND2_X1 i_0_21 (.A1(hs_init), .A2(din_vld), .ZN(n_0_13));
   OAI21_X1 i_0_7 (.A(n_0_25), .B1(n_0_13), .B2(dout_rdy), .ZN(n_0_4));
   INV_X1 i_0_35 (.A(n_4), .ZN(n_0_27));
   AOI21_X1 i_0_8 (.A(n_0_27), .B1(n_0_13), .B2(dout_rdy), .ZN(n_0_5));
   OAI211_X1 i_0_3 (.A(n_0_11), .B(n_0_1), .C1(n_0_4), .C2(n_0_5), .ZN(n_0_0));
   OAI21_X1 i_0_2 (.A(n_0_0), .B1(n_0_11), .B2(n_0_27), .ZN(n_5));
   DFFR_X1 \GEN_REGS_1_STATREG_z_reg[0]  (.D(n_5), .RN(arst), .CK(clk), .Q(n_4), 
      .QN());
   AOI211_X1 i_0_16 (.A(n_0_13), .B(n_0_10), .C1(dout_rdy), .C2(n_0_14), 
      .ZN(n_0_6));
   OAI21_X1 i_0_15 (.A(n_0_11), .B1(n_4), .B2(n_0_6), .ZN(n_0_2));
   AOI21_X1 i_0_14 (.A(srst), .B1(n_0_7), .B2(n_0_2), .ZN(n_8));
   DFFR_X1 \GEN_REGS_2_STATREG_z_reg[0]  (.D(n_8), .RN(arst), .CK(clk), .Q(n_3), 
      .QN());
   INV_X1 i_0_23 (.A(n_3), .ZN(n_0_14));
   OAI211_X1 i_0_19 (.A(n_0_15), .B(n_0_12), .C1(n_0_17), .C2(n_0_14), .ZN(
      n_0_11));
   NAND2_X1 i_0_6 (.A1(n_0_4), .A2(n_0_5), .ZN(n_0_3));
   OAI22_X1 i_0_5 (.A1(n_0_25), .A2(n_0_11), .B1(n_0_3), .B2(srst), .ZN(n_6));
   DFFR_X1 \GEN_REGS_0_STATREG_z_reg[0]  (.D(n_6), .RN(arst), .CK(clk), .Q(stat), 
      .QN());
   AOI21_X1 i_0_22 (.A(n_0_16), .B1(n_0_17), .B2(stat), .ZN(din_rdy));
   NAND2_X1 i_0_1 (.A1(n_0_14), .A2(n_0_13), .ZN(dout_vld));
   NAND2_X1 i_0_34 (.A1(dout_rdy), .A2(n_4), .ZN(n_0_24));
   AOI211_X1 i_0_11 (.A(n_0_27), .B(n_0_12), .C1(n_0_25), .C2(dout_rdy), 
      .ZN(n_0_9));
   NOR2_X1 i_0_10 (.A1(n_2), .A2(n_0_9), .ZN(n_0_8));
   INV_X1 i_0_13 (.A(din[7]), .ZN(n_0_26));
   AOI211_X1 i_0_9 (.A(srst), .B(n_0_8), .C1(n_0_9), .C2(n_0_26), .ZN(n_7));
   DFFR_X1 \GEN_REGS_0_BUFREG_z_reg[7]  (.D(n_7), .RN(arst), .CK(clk), .Q(n_2), 
      .QN());
   NAND2_X1 i_0_30 (.A1(dout_rdy), .A2(stat), .ZN(n_0_20));
   NOR2_X1 i_0_28 (.A1(n_2), .A2(n_0_20), .ZN(n_0_18));
   NAND2_X1 i_0_33 (.A1(n_0_27), .A2(n_0_17), .ZN(n_0_23));
   AOI211_X1 i_0_32 (.A(n_0_13), .B(n_0_14), .C1(n_0_24), .C2(n_0_23), .ZN(
      n_0_22));
   INV_X1 i_0_31 (.A(n_0_22), .ZN(n_0_21));
   AOI22_X1 i_0_29 (.A1(n_1), .A2(n_0_21), .B1(din[7]), .B2(n_0_22), .ZN(n_0_19));
   AOI211_X1 i_0_27 (.A(n_0_18), .B(srst), .C1(n_0_20), .C2(n_0_19), .ZN(n_9));
   DFFR_X1 \GEN_REGS_1_BUFREG_z_reg[7]  (.D(n_9), .RN(arst), .CK(clk), .Q(n_1), 
      .QN());
   NOR2_X1 i_0_37 (.A1(n_0_24), .A2(n_1), .ZN(n_0_28));
   INV_X1 i_0_39 (.A(n_0_6), .ZN(n_0_30));
   OAI22_X1 i_0_38 (.A1(n_0_6), .A2(n_0), .B1(n_0_30), .B2(din[7]), .ZN(n_0_29));
   AOI211_X1 i_0_36 (.A(n_0_28), .B(srst), .C1(n_0_24), .C2(n_0_29), .ZN(n_10));
   DFFR_X1 \GEN_REGS_2_BUFREG_z_reg[7]  (.D(n_10), .RN(arst), .CK(clk), .Q(n_0), 
      .QN());
   MUX2_X1 i_0_0 (.A(din[7]), .B(n_0), .S(n_3), .Z(dout[7]));
endmodule

module ccs_pipe_v6__parameterized0(clk, en, arst, srst, din_rdy, din_vld, din, 
      dout_rdy, dout_vld, dout, sz, sz_req, is_idle);
   input clk;
   input en;
   input arst;
   input srst;
   output din_rdy;
   input din_vld;
   input [7:0]din;
   input dout_rdy;
   output dout_vld;
   output [7:0]dout;
   output [0:0]sz;
   input sz_req;
   output is_idle;

   ccs_fifo_wait_core_v5__parameterized0 FIFO (.clk(clk), .en(), .arst(arst), 
      .srst(srst), .din_vld(din_vld), .din_rdy(din_rdy), .din({din[7], uc_0, 
      uc_1, uc_2, uc_3, uc_4, uc_5, uc_6}), .dout_vld(dout_vld), .dout_rdy(
      dout_rdy), .dout({dout[7], uc_7, uc_8, uc_9, uc_10, uc_11, uc_12, uc_13}), 
      .sd(), .is_idle());
endmodule

module EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci(clk, rst, arst_n, 
      dy_in_rsc_dat, dy_in_rsc_vld, dy_in_rsc_rdy, run_wen, dy_in_rsci_oswt, 
      dy_in_rsci_wen_comp, dy_in_rsci_idat_mxwt);
   input clk;
   input rst;
   input arst_n;
   input [8:0]dy_in_rsc_dat;
   input dy_in_rsc_vld;
   output dy_in_rsc_rdy;
   input run_wen;
   input dy_in_rsci_oswt;
   output dy_in_rsci_wen_comp;
   output [8:0]dy_in_rsci_idat_mxwt;

   wire dy_in_rsci_bcwt;
   wire EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_n_0;
   wire [8:0]
   EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_dy_in_rsci_idat_bfwt;
   wire EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_n_0_0;
   wire EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_n_1;
   wire EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_ctrl_inst_n_0_0;
   wire dy_in_rsci_biwt;
   wire dy_in_rsci_bdwt;

   INV_X1 i_0_0_0 (.A(dy_in_rsci_oswt), .ZN(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_ctrl_inst_n_0_0));
   AND2_X1 i_0_0_2 (.A1(dy_in_rsc_rdy), .A2(dy_in_rsc_vld), .ZN(dy_in_rsci_biwt));
   NOR2_X1 EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_i_0_0 (
      .A1(dy_in_rsci_biwt), .A2(dy_in_rsci_bcwt), .ZN(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_n_0_0));
   AND2_X1 i_0_0_3 (.A1(dy_in_rsci_oswt), .A2(run_wen), .ZN(dy_in_rsci_bdwt));
   NOR3_X1 EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_i_0_2 (
      .A1(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_n_0_0), 
      .A2(rst), .A3(dy_in_rsci_bdwt), .ZN(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_n_1));
   DFFR_X1 EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_dy_in_rsci_bcwt_reg (
      .D(EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_n_1), 
      .RN(arst_n), .CK(clk), .Q(dy_in_rsci_bcwt), .QN());
   NOR2_X1 i_0_0_1 (.A1(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_ctrl_inst_n_0_0), 
      .A2(dy_in_rsci_bcwt), .ZN(dy_in_rsc_rdy));
   NAND2_X1 EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_i_0_1 (
      .A1(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_n_0_0), 
      .A2(dy_in_rsci_oswt), .ZN(dy_in_rsci_wen_comp));
   CLKGATE_X1 EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_clk_gate_dy_in_rsci_idat_bfwt_reg (
      .CK(clk), .E(dy_in_rsci_biwt), .GCK(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_n_0));
   DFF_X1 \EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_dy_in_rsci_idat_bfwt_reg[8]  (
      .D(dy_in_rsc_dat[8]), .CK(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_n_0), 
      .Q(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_dy_in_rsci_idat_bfwt[8]), 
      .QN());
   MUX2_X1 EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_i_0_11 (
      .A(dy_in_rsc_dat[8]), .B(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_dy_in_rsci_idat_bfwt[8]), 
      .S(dy_in_rsci_bcwt), .Z(dy_in_rsci_idat_mxwt[8]));
   DFF_X1 \EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_dy_in_rsci_idat_bfwt_reg[7]  (
      .D(dy_in_rsc_dat[7]), .CK(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_n_0), 
      .Q(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_dy_in_rsci_idat_bfwt[7]), 
      .QN());
   MUX2_X1 EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_i_0_10 (
      .A(dy_in_rsc_dat[7]), .B(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_dy_in_rsci_idat_bfwt[7]), 
      .S(dy_in_rsci_bcwt), .Z(dy_in_rsci_idat_mxwt[7]));
   DFF_X1 \EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_dy_in_rsci_idat_bfwt_reg[6]  (
      .D(dy_in_rsc_dat[6]), .CK(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_n_0), 
      .Q(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_dy_in_rsci_idat_bfwt[6]), 
      .QN());
   MUX2_X1 EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_i_0_9 (
      .A(dy_in_rsc_dat[6]), .B(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_dy_in_rsci_idat_bfwt[6]), 
      .S(dy_in_rsci_bcwt), .Z(dy_in_rsci_idat_mxwt[6]));
   DFF_X1 \EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_dy_in_rsci_idat_bfwt_reg[5]  (
      .D(dy_in_rsc_dat[5]), .CK(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_n_0), 
      .Q(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_dy_in_rsci_idat_bfwt[5]), 
      .QN());
   MUX2_X1 EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_i_0_8 (
      .A(dy_in_rsc_dat[5]), .B(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_dy_in_rsci_idat_bfwt[5]), 
      .S(dy_in_rsci_bcwt), .Z(dy_in_rsci_idat_mxwt[5]));
   DFF_X1 \EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_dy_in_rsci_idat_bfwt_reg[4]  (
      .D(dy_in_rsc_dat[4]), .CK(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_n_0), 
      .Q(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_dy_in_rsci_idat_bfwt[4]), 
      .QN());
   MUX2_X1 EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_i_0_7 (
      .A(dy_in_rsc_dat[4]), .B(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_dy_in_rsci_idat_bfwt[4]), 
      .S(dy_in_rsci_bcwt), .Z(dy_in_rsci_idat_mxwt[4]));
   DFF_X1 \EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_dy_in_rsci_idat_bfwt_reg[3]  (
      .D(dy_in_rsc_dat[3]), .CK(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_n_0), 
      .Q(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_dy_in_rsci_idat_bfwt[3]), 
      .QN());
   MUX2_X1 EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_i_0_6 (
      .A(dy_in_rsc_dat[3]), .B(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_dy_in_rsci_idat_bfwt[3]), 
      .S(dy_in_rsci_bcwt), .Z(dy_in_rsci_idat_mxwt[3]));
   DFF_X1 \EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_dy_in_rsci_idat_bfwt_reg[2]  (
      .D(dy_in_rsc_dat[2]), .CK(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_n_0), 
      .Q(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_dy_in_rsci_idat_bfwt[2]), 
      .QN());
   MUX2_X1 EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_i_0_5 (
      .A(dy_in_rsc_dat[2]), .B(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_dy_in_rsci_idat_bfwt[2]), 
      .S(dy_in_rsci_bcwt), .Z(dy_in_rsci_idat_mxwt[2]));
   DFF_X1 \EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_dy_in_rsci_idat_bfwt_reg[1]  (
      .D(dy_in_rsc_dat[1]), .CK(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_n_0), 
      .Q(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_dy_in_rsci_idat_bfwt[1]), 
      .QN());
   MUX2_X1 EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_i_0_4 (
      .A(dy_in_rsc_dat[1]), .B(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_dy_in_rsci_idat_bfwt[1]), 
      .S(dy_in_rsci_bcwt), .Z(dy_in_rsci_idat_mxwt[1]));
   DFF_X1 \EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_dy_in_rsci_idat_bfwt_reg[0]  (
      .D(dy_in_rsc_dat[0]), .CK(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_n_0), 
      .Q(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_dy_in_rsci_idat_bfwt[0]), 
      .QN());
   MUX2_X1 EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_i_0_3 (
      .A(dy_in_rsc_dat[0]), .B(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst_dy_in_rsci_idat_bfwt[0]), 
      .S(dy_in_rsci_bcwt), .Z(dy_in_rsci_idat_mxwt[0]));
endmodule

module EdgeDetect_IP_EdgeDetect_MagAng_run_magn_rsci(clk, rst, arst_n, 
      magn_rsc_dat, magn_rsc_vld, magn_rsc_rdy, run_wen, magn_rsci_oswt, 
      magn_rsci_wen_comp, magn_rsci_idat);
   input clk;
   input rst;
   input arst_n;
   output [7:0]magn_rsc_dat;
   output magn_rsc_vld;
   input magn_rsc_rdy;
   input run_wen;
   input magn_rsci_oswt;
   output magn_rsci_wen_comp;
   input [7:0]magn_rsci_idat;

   wire magn_rsci_bcwt;
   wire EdgeDetect_IP_EdgeDetect_MagAng_run_magn_rsci_magn_wait_dp_inst_n_1;
   wire n_0_0_0;
   wire n_0_0_1;
   wire n_0_0_2;

   INV_X1 i_0_0_5 (.A(magn_rsci_oswt), .ZN(n_0_0_2));
   AOI21_X1 i_0_0_1 (.A(magn_rsci_bcwt), .B1(magn_rsci_oswt), .B2(magn_rsc_rdy), 
      .ZN(n_0_0_0));
   AOI211_X1 i_0_0_0 (.A(rst), .B(n_0_0_0), .C1(magn_rsci_oswt), .C2(run_wen), 
      .ZN(EdgeDetect_IP_EdgeDetect_MagAng_run_magn_rsci_magn_wait_dp_inst_n_1));
   DFFR_X1 EdgeDetect_IP_EdgeDetect_MagAng_run_magn_rsci_magn_wait_dp_inst_magn_rsci_bcwt_reg (
      .D(EdgeDetect_IP_EdgeDetect_MagAng_run_magn_rsci_magn_wait_dp_inst_n_1), 
      .RN(arst_n), .CK(clk), .Q(magn_rsci_bcwt), .QN());
   NOR2_X1 i_0_0_3 (.A1(n_0_0_2), .A2(magn_rsci_bcwt), .ZN(magn_rsc_vld));
   INV_X1 i_0_0_4 (.A(magn_rsc_rdy), .ZN(n_0_0_1));
   NAND2_X1 i_0_0_2 (.A1(magn_rsc_vld), .A2(n_0_0_1), .ZN(magn_rsci_wen_comp));
endmodule

module EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci(clk, rst, arst_n, 
      dx_in_rsc_dat, dx_in_rsc_vld, dx_in_rsc_rdy, run_wen, dx_in_rsci_oswt, 
      dx_in_rsci_wen_comp, dx_in_rsci_idat_mxwt);
   input clk;
   input rst;
   input arst_n;
   input [8:0]dx_in_rsc_dat;
   input dx_in_rsc_vld;
   output dx_in_rsc_rdy;
   input run_wen;
   input dx_in_rsci_oswt;
   output dx_in_rsci_wen_comp;
   output [8:0]dx_in_rsci_idat_mxwt;

   wire dx_in_rsci_bcwt;
   wire EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_n_0;
   wire [8:0]
   EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_dx_in_rsci_idat_bfwt;
   wire EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_n_0_0;
   wire EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_n_1;
   wire EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_ctrl_inst_n_0_0;
   wire dx_in_rsci_biwt;
   wire dx_in_rsci_bdwt;

   INV_X1 i_0_0_0 (.A(dx_in_rsci_oswt), .ZN(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_ctrl_inst_n_0_0));
   AND2_X1 i_0_0_2 (.A1(dx_in_rsc_rdy), .A2(dx_in_rsc_vld), .ZN(dx_in_rsci_biwt));
   NOR2_X1 EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_i_0_0 (
      .A1(dx_in_rsci_biwt), .A2(dx_in_rsci_bcwt), .ZN(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_n_0_0));
   AND2_X1 i_0_0_3 (.A1(dx_in_rsci_oswt), .A2(run_wen), .ZN(dx_in_rsci_bdwt));
   NOR3_X1 EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_i_0_2 (
      .A1(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_n_0_0), 
      .A2(rst), .A3(dx_in_rsci_bdwt), .ZN(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_n_1));
   DFFR_X1 EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_dx_in_rsci_bcwt_reg (
      .D(EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_n_1), 
      .RN(arst_n), .CK(clk), .Q(dx_in_rsci_bcwt), .QN());
   NOR2_X1 i_0_0_1 (.A1(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_ctrl_inst_n_0_0), 
      .A2(dx_in_rsci_bcwt), .ZN(dx_in_rsc_rdy));
   NAND2_X1 EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_i_0_1 (
      .A1(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_n_0_0), 
      .A2(dx_in_rsci_oswt), .ZN(dx_in_rsci_wen_comp));
   CLKGATE_X1 EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_clk_gate_dx_in_rsci_idat_bfwt_reg (
      .CK(clk), .E(dx_in_rsci_biwt), .GCK(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_n_0));
   DFF_X1 \EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_dx_in_rsci_idat_bfwt_reg[8]  (
      .D(dx_in_rsc_dat[8]), .CK(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_n_0), 
      .Q(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_dx_in_rsci_idat_bfwt[8]), 
      .QN());
   MUX2_X1 EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_i_0_11 (
      .A(dx_in_rsc_dat[8]), .B(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_dx_in_rsci_idat_bfwt[8]), 
      .S(dx_in_rsci_bcwt), .Z(dx_in_rsci_idat_mxwt[8]));
   DFF_X1 \EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_dx_in_rsci_idat_bfwt_reg[7]  (
      .D(dx_in_rsc_dat[7]), .CK(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_n_0), 
      .Q(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_dx_in_rsci_idat_bfwt[7]), 
      .QN());
   MUX2_X1 EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_i_0_10 (
      .A(dx_in_rsc_dat[7]), .B(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_dx_in_rsci_idat_bfwt[7]), 
      .S(dx_in_rsci_bcwt), .Z(dx_in_rsci_idat_mxwt[7]));
   DFF_X1 \EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_dx_in_rsci_idat_bfwt_reg[6]  (
      .D(dx_in_rsc_dat[6]), .CK(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_n_0), 
      .Q(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_dx_in_rsci_idat_bfwt[6]), 
      .QN());
   MUX2_X1 EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_i_0_9 (
      .A(dx_in_rsc_dat[6]), .B(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_dx_in_rsci_idat_bfwt[6]), 
      .S(dx_in_rsci_bcwt), .Z(dx_in_rsci_idat_mxwt[6]));
   DFF_X1 \EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_dx_in_rsci_idat_bfwt_reg[5]  (
      .D(dx_in_rsc_dat[5]), .CK(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_n_0), 
      .Q(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_dx_in_rsci_idat_bfwt[5]), 
      .QN());
   MUX2_X1 EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_i_0_8 (
      .A(dx_in_rsc_dat[5]), .B(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_dx_in_rsci_idat_bfwt[5]), 
      .S(dx_in_rsci_bcwt), .Z(dx_in_rsci_idat_mxwt[5]));
   DFF_X1 \EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_dx_in_rsci_idat_bfwt_reg[4]  (
      .D(dx_in_rsc_dat[4]), .CK(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_n_0), 
      .Q(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_dx_in_rsci_idat_bfwt[4]), 
      .QN());
   MUX2_X1 EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_i_0_7 (
      .A(dx_in_rsc_dat[4]), .B(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_dx_in_rsci_idat_bfwt[4]), 
      .S(dx_in_rsci_bcwt), .Z(dx_in_rsci_idat_mxwt[4]));
   DFF_X1 \EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_dx_in_rsci_idat_bfwt_reg[3]  (
      .D(dx_in_rsc_dat[3]), .CK(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_n_0), 
      .Q(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_dx_in_rsci_idat_bfwt[3]), 
      .QN());
   MUX2_X1 EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_i_0_6 (
      .A(dx_in_rsc_dat[3]), .B(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_dx_in_rsci_idat_bfwt[3]), 
      .S(dx_in_rsci_bcwt), .Z(dx_in_rsci_idat_mxwt[3]));
   DFF_X1 \EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_dx_in_rsci_idat_bfwt_reg[2]  (
      .D(dx_in_rsc_dat[2]), .CK(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_n_0), 
      .Q(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_dx_in_rsci_idat_bfwt[2]), 
      .QN());
   MUX2_X1 EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_i_0_5 (
      .A(dx_in_rsc_dat[2]), .B(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_dx_in_rsci_idat_bfwt[2]), 
      .S(dx_in_rsci_bcwt), .Z(dx_in_rsci_idat_mxwt[2]));
   DFF_X1 \EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_dx_in_rsci_idat_bfwt_reg[1]  (
      .D(dx_in_rsc_dat[1]), .CK(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_n_0), 
      .Q(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_dx_in_rsci_idat_bfwt[1]), 
      .QN());
   MUX2_X1 EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_i_0_4 (
      .A(dx_in_rsc_dat[1]), .B(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_dx_in_rsci_idat_bfwt[1]), 
      .S(dx_in_rsci_bcwt), .Z(dx_in_rsci_idat_mxwt[1]));
   DFF_X1 \EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_dx_in_rsci_idat_bfwt_reg[0]  (
      .D(dx_in_rsc_dat[0]), .CK(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_n_0), 
      .Q(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_dx_in_rsci_idat_bfwt[0]), 
      .QN());
   MUX2_X1 EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_i_0_3 (
      .A(dx_in_rsc_dat[0]), .B(
      EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst_dx_in_rsci_idat_bfwt[0]), 
      .S(dx_in_rsci_bcwt), .Z(dx_in_rsci_idat_mxwt[0]));
endmodule

module EdgeDetect_IP_EdgeDetect_MagAng_run(clk, rst, arst_n, dx_in_rsc_dat, 
      dx_in_rsc_vld, dx_in_rsc_rdy, dy_in_rsc_dat, dy_in_rsc_vld, dy_in_rsc_rdy, 
      widthIn_rsc_dat, widthIn_triosy_lz, heightIn_rsc_dat, heightIn_triosy_lz, 
      magn_rsc_dat, magn_rsc_vld, magn_rsc_rdy);
   input clk;
   input rst;
   input arst_n;
   input [8:0]dx_in_rsc_dat;
   input dx_in_rsc_vld;
   output dx_in_rsc_rdy;
   input [8:0]dy_in_rsc_dat;
   input dy_in_rsc_vld;
   output dy_in_rsc_rdy;
   input [10:0]widthIn_rsc_dat;
   output widthIn_triosy_lz;
   input [9:0]heightIn_rsc_dat;
   output heightIn_triosy_lz;
   output [7:0]magn_rsc_dat;
   output magn_rsc_vld;
   input magn_rsc_rdy;

   wire [8:0]dy_in_rsci_idat_mxwt;
   wire dy_in_rsci_wen_comp;
   wire magn_rsci_wen_comp;
   wire [8:0]dx_in_rsci_idat_mxwt;
   wire dx_in_rsci_wen_comp;
   wire [1:0]EdgeDetect_IP_EdgeDetect_MagAng_run_run_fsm_inst_state_var;
   wire reg_magn_rsci_oswt_cse;
   wire reg_dy_in_rsci_oswt_cse;
   wire MCOL_stage_0;
   wire n_0_0;
   wire n_0_1;
   wire [10:0]MCOL_x_sva;
   wire n_0_2;
   wire [9:0]MROW_y_sva;
   wire n_0_3;
   wire n_0_2_41;
   wire n_0_2_0;
   wire n_0_2_42;
   wire n_0_2_1;
   wire n_0_2_43;
   wire n_0_2_2;
   wire n_0_2_44;
   wire n_0_2_3;
   wire n_0_2_45;
   wire n_0_2_4;
   wire n_0_2_46;
   wire n_0_2_5;
   wire n_0_2_47;
   wire n_0_2_6;
   wire n_0_2_48;
   wire n_0_2_7;
   wire n_0_2_49;
   wire n_0_2_8;
   wire n_0_2_50;
   wire n_0_2_9;
   wire n_0_2_51;
   wire n_0_2_10;
   wire n_0_2_52;
   wire n_0_2_11;
   wire n_0_2_53;
   wire n_0_2_12;
   wire n_0_2_54;
   wire n_0_2_13;
   wire n_0_2_55;
   wire n_0_2_14;
   wire n_0_2_56;
   wire n_0_2_15;
   wire z_out;
   wire n_0_2_16;
   wire n_0_2_57;
   wire n_0_2_17;
   wire n_0_2_58;
   wire n_0_2_18;
   wire n_0_2_59;
   wire n_0_2_19;
   wire n_0_2_20;
   wire n_0_2_21;
   wire n_0_2_22;
   wire n_0_2_23;
   wire n_0_2_24;
   wire n_0_2_25;
   wire n_0_2_26;
   wire n_0_2_27;
   wire n_0_2_28;
   wire n_0_2_29;
   wire n_0_2_30;
   wire n_0_2_31;
   wire n_0_2_32;
   wire n_0_2_33;
   wire n_0_2_34;
   wire n_0_2_35;
   wire n_0_2_36;
   wire n_0_2_37;
   wire [9:0]MUX_v_10_2_25_return;
   wire n_0_2_60;
   wire n_0_2_61;
   wire n_0_2_62;
   wire n_0_2_63;
   wire n_0_4;
   wire [10:0]MUX_v_11_2_23_return;
   wire n_0_2_64;
   wire n_0_5;
   wire n_0_6;
   wire n_0_2_65;
   wire n_0_2_66;
   wire n_0_2_131;
   wire n_0_2_67;
   wire [6:0]MUX_v_7_2_2_return;
   wire n_0_2_68;
   wire n_0_2_129;
   wire n_0_2_128;
   wire n_0_2_69;
   wire n_0_2_127;
   wire n_0_2_126;
   wire n_0_2_125;
   wire n_0_2_124;
   wire n_0_2_123;
   wire n_0_2_122;
   wire n_0_2_117;
   wire n_0_2_70;
   wire n_0_2_71;
   wire n_0_2_72;
   wire MCOL_if_EdgeDetect_IP_EdgeDetect_MagAng_abs_nand_nl;
   wire n_0_2_73;
   wire n_0_2_74;
   wire n_0_2_75;
   wire [9:0]MUX_v_10_2_26_return;
   wire n_0_2_76;
   wire n_0_2_77;
   wire n_0_2_78;
   wire n_0_2_79;
   wire n_0_2_80;
   wire n_0_2_81;
   wire n_0_2_82;
   wire n_0_2_83;
   wire n_0_2_40;
   wire n_0_2_104;
   wire n_0_2_84;
   wire n_0_2_85;
   wire n_0_2_109;
   wire n_0_2_86;
   wire n_0_2_87;
   wire n_0_2_89;
   wire n_0_2_91;
   wire n_0_2_39;
   wire n_0_2_93;
   wire n_0_2_94;
   wire n_0_2_95;
   wire n_0_2_96;
   wire n_0_2_92;
   wire n_0_2_97;
   wire n_0_2_90;
   wire n_0_2_98;
   wire n_0_2_88;
   wire n_0_2_99;
   wire n_0_2_100;
   wire n_0_2_101;
   wire n_0_2_102;
   wire n_0_2_103;
   wire n_0_7;
   wire n_0_8;
   wire n_0_9;
   wire n_0_2_105;
   wire n_0_2_106;
   wire n_0_2_107;
   wire n_0_2_108;
   wire n_0_2_110;
   wire n_0_10;
   wire n_0_2_111;
   wire EdgeDetect_IP_EdgeDetect_MagAng_run_run_fsm_inst_n_2;
   wire n_0_2_112;
   wire EdgeDetect_IP_EdgeDetect_MagAng_run_run_fsm_inst_n_3;
   wire n_0_2_113;
   wire n_0_2_114;
   wire n_0_2_115;
   wire n_0_2_116;
   wire n_0_2_118;
   wire n_0_2_119;
   wire n_0_2_120;
   wire EdgeDetect_IP_EdgeDetect_MagAng_run_run_fsm_inst_n_1;
   wire run_wen;
   wire n_0_2_121;
   wire n_0_2_130;
   wire n_0_2_132;
   wire n_0_2_133;
   wire n_0_2_134;
   wire n_0_2_38;
   wire n_0_2_135;
   wire n_0_2_136;
   wire n_0_2_137;
   wire n_0_2_138;

   INV_X1 i_0_2_153 (.A(rst), .ZN(n_0_2_138));
   AND2_X1 i_0_2_48 (.A1(
      EdgeDetect_IP_EdgeDetect_MagAng_run_run_fsm_inst_state_var[0]), .A2(
      n_0_2_44), .ZN(MUX_v_11_2_23_return[4]));
   AOI21_X1 i_0_2_56 (.A(n_0_2_121), .B1(n_0_2_135), .B2(
      EdgeDetect_IP_EdgeDetect_MagAng_run_run_fsm_inst_state_var[0]), .ZN(n_0_5));
   CLKGATE_X1 clk_gate_MCOL_x_sva_reg (.CK(clk), .E(n_0_5), .GCK(n_0_1));
   DFF_X1 \MCOL_x_sva_reg[4]  (.D(MUX_v_11_2_23_return[4]), .CK(n_0_1), .Q(
      MCOL_x_sva[4]), .QN());
   AND2_X1 i_0_2_47 (.A1(
      EdgeDetect_IP_EdgeDetect_MagAng_run_run_fsm_inst_state_var[0]), .A2(
      n_0_2_43), .ZN(MUX_v_11_2_23_return[3]));
   DFF_X1 \MCOL_x_sva_reg[3]  (.D(MUX_v_11_2_23_return[3]), .CK(n_0_1), .Q(
      MCOL_x_sva[3]), .QN());
   AND2_X1 i_0_2_46 (.A1(
      EdgeDetect_IP_EdgeDetect_MagAng_run_run_fsm_inst_state_var[0]), .A2(
      n_0_2_42), .ZN(MUX_v_11_2_23_return[2]));
   DFF_X1 \MCOL_x_sva_reg[2]  (.D(MUX_v_11_2_23_return[2]), .CK(n_0_1), .Q(
      MCOL_x_sva[2]), .QN());
   AND2_X1 i_0_2_45 (.A1(
      EdgeDetect_IP_EdgeDetect_MagAng_run_run_fsm_inst_state_var[0]), .A2(
      n_0_2_41), .ZN(MUX_v_11_2_23_return[1]));
   DFF_X1 \MCOL_x_sva_reg[1]  (.D(MUX_v_11_2_23_return[1]), .CK(n_0_1), .Q(
      MCOL_x_sva[1]), .QN());
   NOR2_X1 i_0_2_44 (.A1(n_0_2_137), .A2(MCOL_x_sva[0]), .ZN(
      MUX_v_11_2_23_return[0]));
   DFF_X1 \MCOL_x_sva_reg[0]  (.D(MUX_v_11_2_23_return[0]), .CK(n_0_1), .Q(
      MCOL_x_sva[0]), .QN());
   HA_X1 i_0_2_0 (.A(MCOL_x_sva[1]), .B(MCOL_x_sva[0]), .CO(n_0_2_0), .S(
      n_0_2_41));
   HA_X1 i_0_2_1 (.A(MCOL_x_sva[2]), .B(n_0_2_0), .CO(n_0_2_1), .S(n_0_2_42));
   HA_X1 i_0_2_2 (.A(MCOL_x_sva[3]), .B(n_0_2_1), .CO(n_0_2_2), .S(n_0_2_43));
   HA_X1 i_0_2_3 (.A(MCOL_x_sva[4]), .B(n_0_2_2), .CO(n_0_2_3), .S(n_0_2_44));
   HA_X1 i_0_2_4 (.A(MCOL_x_sva[5]), .B(n_0_2_3), .CO(n_0_2_4), .S(n_0_2_45));
   AND2_X1 i_0_2_49 (.A1(
      EdgeDetect_IP_EdgeDetect_MagAng_run_run_fsm_inst_state_var[0]), .A2(
      n_0_2_45), .ZN(MUX_v_11_2_23_return[5]));
   DFF_X1 \MCOL_x_sva_reg[5]  (.D(MUX_v_11_2_23_return[5]), .CK(n_0_1), .Q(
      MCOL_x_sva[5]), .QN());
   NAND3_X1 i_0_2_129 (.A1(MCOL_x_sva[5]), .A2(MCOL_x_sva[4]), .A3(MCOL_x_sva[3]), 
      .ZN(n_0_2_110));
   AND2_X1 i_0_2_53 (.A1(
      EdgeDetect_IP_EdgeDetect_MagAng_run_run_fsm_inst_state_var[0]), .A2(
      n_0_2_49), .ZN(MUX_v_11_2_23_return[9]));
   DFF_X1 \MCOL_x_sva_reg[9]  (.D(MUX_v_11_2_23_return[9]), .CK(n_0_1), .Q(
      MCOL_x_sva[9]), .QN());
   AND2_X1 i_0_2_52 (.A1(
      EdgeDetect_IP_EdgeDetect_MagAng_run_run_fsm_inst_state_var[0]), .A2(
      n_0_2_48), .ZN(MUX_v_11_2_23_return[8]));
   DFF_X1 \MCOL_x_sva_reg[8]  (.D(MUX_v_11_2_23_return[8]), .CK(n_0_1), .Q(
      MCOL_x_sva[8]), .QN());
   AND2_X1 i_0_2_51 (.A1(
      EdgeDetect_IP_EdgeDetect_MagAng_run_run_fsm_inst_state_var[0]), .A2(
      n_0_2_47), .ZN(MUX_v_11_2_23_return[7]));
   DFF_X1 \MCOL_x_sva_reg[7]  (.D(MUX_v_11_2_23_return[7]), .CK(n_0_1), .Q(
      MCOL_x_sva[7]), .QN());
   AND2_X1 i_0_2_50 (.A1(
      EdgeDetect_IP_EdgeDetect_MagAng_run_run_fsm_inst_state_var[0]), .A2(
      n_0_2_46), .ZN(MUX_v_11_2_23_return[6]));
   DFF_X1 \MCOL_x_sva_reg[6]  (.D(MUX_v_11_2_23_return[6]), .CK(n_0_1), .Q(
      MCOL_x_sva[6]), .QN());
   HA_X1 i_0_2_5 (.A(MCOL_x_sva[6]), .B(n_0_2_4), .CO(n_0_2_5), .S(n_0_2_46));
   HA_X1 i_0_2_6 (.A(MCOL_x_sva[7]), .B(n_0_2_5), .CO(n_0_2_6), .S(n_0_2_47));
   HA_X1 i_0_2_7 (.A(MCOL_x_sva[8]), .B(n_0_2_6), .CO(n_0_2_7), .S(n_0_2_48));
   HA_X1 i_0_2_8 (.A(MCOL_x_sva[9]), .B(n_0_2_7), .CO(n_0_2_8), .S(n_0_2_49));
   OAI21_X1 i_0_2_55 (.A(
      EdgeDetect_IP_EdgeDetect_MagAng_run_run_fsm_inst_state_var[0]), .B1(
      MCOL_x_sva[10]), .B2(n_0_2_8), .ZN(n_0_2_64));
   AOI21_X1 i_0_2_54 (.A(n_0_2_64), .B1(n_0_2_8), .B2(MCOL_x_sva[10]), .ZN(
      MUX_v_11_2_23_return[10]));
   DFF_X1 \MCOL_x_sva_reg[10]  (.D(MUX_v_11_2_23_return[10]), .CK(n_0_1), 
      .Q(MCOL_x_sva[10]), .QN());
   NAND4_X1 i_0_2_128 (.A1(MCOL_x_sva[2]), .A2(MCOL_x_sva[1]), .A3(
      MCOL_x_sva[10]), .A4(MCOL_x_sva[0]), .ZN(n_0_2_108));
   NAND4_X1 i_0_2_127 (.A1(MCOL_x_sva[9]), .A2(MCOL_x_sva[8]), .A3(MCOL_x_sva[7]), 
      .A4(MCOL_x_sva[6]), .ZN(n_0_2_107));
   NOR3_X1 i_0_2_126 (.A1(n_0_2_110), .A2(n_0_2_108), .A3(n_0_2_107), .ZN(
      n_0_2_106));
   OAI21_X1 i_0_2_125 (.A(
      EdgeDetect_IP_EdgeDetect_MagAng_run_run_fsm_inst_state_var[0]), .B1(
      n_0_2_106), .B2(n_0_2_135), .ZN(n_0_2_105));
   AND2_X1 i_0_2_124 (.A1(n_0_2_138), .A2(n_0_2_105), .ZN(n_0_9));
   NAND2_X1 i_0_2_142 (.A1(n_0_2_138), .A2(n_0_2_121), .ZN(
      EdgeDetect_IP_EdgeDetect_MagAng_run_run_fsm_inst_n_1));
   CLKGATE_X1 clk_gate_reg_widthIn_triosy_obj_iswt0_cse_reg (.CK(clk), .E(
      EdgeDetect_IP_EdgeDetect_MagAng_run_run_fsm_inst_n_1), .GCK(n_0_3));
   DFFR_X1 MCOL_stage_0_reg (.D(n_0_9), .RN(arst_n), .CK(n_0_3), .Q(MCOL_stage_0), 
      .QN());
   INV_X1 i_0_2_150 (.A(MCOL_stage_0), .ZN(n_0_2_135));
   NAND3_X1 i_0_2_141 (.A1(n_0_2_138), .A2(n_0_2_135), .A3(
      EdgeDetect_IP_EdgeDetect_MagAng_run_run_fsm_inst_state_var[0]), .ZN(
      n_0_2_120));
   OAI21_X1 i_0_2_134 (.A(n_0_2_113), .B1(n_0_2_120), .B2(
      EdgeDetect_IP_EdgeDetect_MagAng_run_run_fsm_inst_state_var[1]), .ZN(
      EdgeDetect_IP_EdgeDetect_MagAng_run_run_fsm_inst_n_3));
   DFFR_X1 \EdgeDetect_IP_EdgeDetect_MagAng_run_run_fsm_inst_state_var_reg[1]  (
      .D(EdgeDetect_IP_EdgeDetect_MagAng_run_run_fsm_inst_n_3), .RN(arst_n), 
      .CK(n_0_3), .Q(
      EdgeDetect_IP_EdgeDetect_MagAng_run_run_fsm_inst_state_var[1]), .QN());
   INV_X1 i_0_2_151 (.A(
      EdgeDetect_IP_EdgeDetect_MagAng_run_run_fsm_inst_state_var[1]), .ZN(
      n_0_2_136));
   NAND2_X1 i_0_2_133 (.A1(n_0_2_136), .A2(MCOL_stage_0), .ZN(n_0_2_112));
   AOI21_X1 i_0_2_132 (.A(rst), .B1(n_0_2_112), .B2(
      EdgeDetect_IP_EdgeDetect_MagAng_run_run_fsm_inst_state_var[0]), .ZN(
      EdgeDetect_IP_EdgeDetect_MagAng_run_run_fsm_inst_n_2));
   DFFR_X1 \EdgeDetect_IP_EdgeDetect_MagAng_run_run_fsm_inst_state_var_reg[0]  (
      .D(EdgeDetect_IP_EdgeDetect_MagAng_run_run_fsm_inst_n_2), .RN(arst_n), 
      .CK(n_0_3), .Q(
      EdgeDetect_IP_EdgeDetect_MagAng_run_run_fsm_inst_state_var[0]), .QN());
   INV_X1 i_0_2_152 (.A(
      EdgeDetect_IP_EdgeDetect_MagAng_run_run_fsm_inst_state_var[0]), .ZN(
      n_0_2_137));
   NAND2_X1 i_0_2_40 (.A1(n_0_2_137), .A2(n_0_2_136), .ZN(n_0_2_61));
   NOR2_X1 i_0_2_139 (.A1(n_0_2_136), .A2(
      EdgeDetect_IP_EdgeDetect_MagAng_run_run_fsm_inst_state_var[0]), .ZN(
      n_0_2_118));
   NAND2_X1 i_0_2_94 (.A1(MROW_y_sva[6]), .A2(n_0_2_118), .ZN(n_0_2_82));
   OAI21_X1 i_0_2_93 (.A(n_0_2_82), .B1(n_0_2_118), .B2(dx_in_rsci_idat_mxwt[6]), 
      .ZN(MUX_v_10_2_26_return[6]));
   AND2_X1 i_0_2_34 (.A1(n_0_2_61), .A2(n_0_2_54), .ZN(MUX_v_10_2_25_return[5]));
   NOR2_X1 i_0_2_43 (.A1(n_0_2_121), .A2(
      EdgeDetect_IP_EdgeDetect_MagAng_run_run_fsm_inst_state_var[0]), .ZN(n_0_4));
   CLKGATE_X1 clk_gate_MROW_y_sva_reg (.CK(clk), .E(n_0_4), .GCK(n_0_2));
   DFF_X1 \MROW_y_sva_reg[5]  (.D(MUX_v_10_2_25_return[5]), .CK(n_0_2), .Q(
      MROW_y_sva[5]), .QN());
   NAND2_X1 i_0_2_92 (.A1(MROW_y_sva[5]), .A2(n_0_2_118), .ZN(n_0_2_81));
   OAI21_X1 i_0_2_91 (.A(n_0_2_81), .B1(n_0_2_118), .B2(dx_in_rsci_idat_mxwt[5]), 
      .ZN(MUX_v_10_2_26_return[5]));
   AND2_X1 i_0_2_33 (.A1(n_0_2_61), .A2(n_0_2_53), .ZN(MUX_v_10_2_25_return[4]));
   DFF_X1 \MROW_y_sva_reg[4]  (.D(MUX_v_10_2_25_return[4]), .CK(n_0_2), .Q(
      MROW_y_sva[4]), .QN());
   NAND2_X1 i_0_2_90 (.A1(MROW_y_sva[4]), .A2(n_0_2_118), .ZN(n_0_2_80));
   OAI21_X1 i_0_2_89 (.A(n_0_2_80), .B1(n_0_2_118), .B2(dx_in_rsci_idat_mxwt[4]), 
      .ZN(MUX_v_10_2_26_return[4]));
   AND2_X1 i_0_2_32 (.A1(n_0_2_61), .A2(n_0_2_52), .ZN(MUX_v_10_2_25_return[3]));
   DFF_X1 \MROW_y_sva_reg[3]  (.D(MUX_v_10_2_25_return[3]), .CK(n_0_2), .Q(
      MROW_y_sva[3]), .QN());
   NAND2_X1 i_0_2_88 (.A1(MROW_y_sva[3]), .A2(n_0_2_118), .ZN(n_0_2_79));
   OAI21_X1 i_0_2_87 (.A(n_0_2_79), .B1(n_0_2_118), .B2(dx_in_rsci_idat_mxwt[3]), 
      .ZN(MUX_v_10_2_26_return[3]));
   AND2_X1 i_0_2_31 (.A1(n_0_2_61), .A2(n_0_2_51), .ZN(MUX_v_10_2_25_return[2]));
   DFF_X1 \MROW_y_sva_reg[2]  (.D(MUX_v_10_2_25_return[2]), .CK(n_0_2), .Q(
      MROW_y_sva[2]), .QN());
   NAND2_X1 i_0_2_86 (.A1(MROW_y_sva[2]), .A2(n_0_2_118), .ZN(n_0_2_78));
   OAI21_X1 i_0_2_85 (.A(n_0_2_78), .B1(n_0_2_118), .B2(dx_in_rsci_idat_mxwt[2]), 
      .ZN(MUX_v_10_2_26_return[2]));
   AND2_X1 i_0_2_30 (.A1(n_0_2_61), .A2(n_0_2_50), .ZN(MUX_v_10_2_25_return[1]));
   DFF_X1 \MROW_y_sva_reg[1]  (.D(MUX_v_10_2_25_return[1]), .CK(n_0_2), .Q(
      MROW_y_sva[1]), .QN());
   NAND2_X1 i_0_2_84 (.A1(MROW_y_sva[1]), .A2(n_0_2_118), .ZN(n_0_2_77));
   OAI21_X1 i_0_2_83 (.A(n_0_2_77), .B1(n_0_2_118), .B2(dx_in_rsci_idat_mxwt[1]), 
      .ZN(MUX_v_10_2_26_return[1]));
   AOI21_X1 i_0_2_29 (.A(MUX_v_10_2_26_return[0]), .B1(n_0_2_136), .B2(n_0_2_137), 
      .ZN(MUX_v_10_2_25_return[0]));
   DFF_X1 \MROW_y_sva_reg[0]  (.D(MUX_v_10_2_25_return[0]), .CK(n_0_2), .Q(
      MROW_y_sva[0]), .QN());
   NAND2_X1 i_0_2_82 (.A1(MROW_y_sva[0]), .A2(n_0_2_118), .ZN(n_0_2_76));
   OAI21_X1 i_0_2_81 (.A(n_0_2_76), .B1(n_0_2_118), .B2(dx_in_rsci_idat_mxwt[0]), 
      .ZN(MUX_v_10_2_26_return[0]));
   HA_X1 i_0_2_9 (.A(MUX_v_10_2_26_return[1]), .B(MUX_v_10_2_26_return[0]), 
      .CO(n_0_2_9), .S(n_0_2_50));
   HA_X1 i_0_2_10 (.A(MUX_v_10_2_26_return[2]), .B(n_0_2_9), .CO(n_0_2_10), 
      .S(n_0_2_51));
   HA_X1 i_0_2_11 (.A(MUX_v_10_2_26_return[3]), .B(n_0_2_10), .CO(n_0_2_11), 
      .S(n_0_2_52));
   HA_X1 i_0_2_12 (.A(MUX_v_10_2_26_return[4]), .B(n_0_2_11), .CO(n_0_2_12), 
      .S(n_0_2_53));
   HA_X1 i_0_2_13 (.A(MUX_v_10_2_26_return[5]), .B(n_0_2_12), .CO(n_0_2_13), 
      .S(n_0_2_54));
   HA_X1 i_0_2_14 (.A(MUX_v_10_2_26_return[6]), .B(n_0_2_13), .CO(n_0_2_14), 
      .S(n_0_2_55));
   AND2_X1 i_0_2_35 (.A1(n_0_2_61), .A2(n_0_2_55), .ZN(MUX_v_10_2_25_return[6]));
   DFF_X1 \MROW_y_sva_reg[6]  (.D(MUX_v_10_2_25_return[6]), .CK(n_0_2), .Q(
      MROW_y_sva[6]), .QN());
   NAND2_X1 i_0_2_97 (.A1(MROW_y_sva[8]), .A2(n_0_2_118), .ZN(n_0_2_83));
   OAI21_X1 i_0_2_96 (.A(n_0_2_83), .B1(n_0_2_118), .B2(dx_in_rsci_idat_mxwt[8]), 
      .ZN(MUX_v_10_2_26_return[8]));
   AND2_X1 i_0_2_36 (.A1(n_0_2_61), .A2(n_0_2_56), .ZN(MUX_v_10_2_25_return[7]));
   DFF_X1 \MROW_y_sva_reg[7]  (.D(MUX_v_10_2_25_return[7]), .CK(n_0_2), .Q(
      MROW_y_sva[7]), .QN());
   NAND2_X1 i_0_2_138 (.A1(MROW_y_sva[7]), .A2(n_0_2_118), .ZN(n_0_2_116));
   OAI21_X1 i_0_2_95 (.A(n_0_2_116), .B1(n_0_2_118), .B2(dx_in_rsci_idat_mxwt[7]), 
      .ZN(MUX_v_10_2_26_return[7]));
   HA_X1 i_0_2_15 (.A(MUX_v_10_2_26_return[7]), .B(n_0_2_14), .CO(n_0_2_15), 
      .S(n_0_2_56));
   HA_X1 i_0_2_16 (.A(MUX_v_10_2_26_return[8]), .B(n_0_2_15), .CO(n_0_2_16), 
      .S(z_out));
   AND2_X1 i_0_2_37 (.A1(n_0_2_61), .A2(z_out), .ZN(MUX_v_10_2_25_return[8]));
   DFF_X1 \MROW_y_sva_reg[8]  (.D(MUX_v_10_2_25_return[8]), .CK(n_0_2), .Q(
      MROW_y_sva[8]), .QN());
   AND4_X1 i_0_2_140 (.A1(MROW_y_sva[8]), .A2(MROW_y_sva[5]), .A3(MROW_y_sva[4]), 
      .A4(MROW_y_sva[3]), .ZN(n_0_2_119));
   NAND2_X1 i_0_2_42 (.A1(MROW_y_sva[9]), .A2(n_0_2_118), .ZN(n_0_2_63));
   OAI21_X1 i_0_2_41 (.A(n_0_2_63), .B1(n_0_2_118), .B2(dx_in_rsci_idat_mxwt[8]), 
      .ZN(n_0_2_62));
   OAI21_X1 i_0_2_39 (.A(n_0_2_61), .B1(n_0_2_62), .B2(n_0_2_16), .ZN(n_0_2_60));
   AOI21_X1 i_0_2_38 (.A(n_0_2_60), .B1(n_0_2_62), .B2(n_0_2_16), .ZN(
      MUX_v_10_2_25_return[9]));
   DFF_X1 \MROW_y_sva_reg[9]  (.D(MUX_v_10_2_25_return[9]), .CK(n_0_2), .Q(
      MROW_y_sva[9]), .QN());
   NAND4_X1 i_0_2_137 (.A1(MROW_y_sva[2]), .A2(MROW_y_sva[1]), .A3(MROW_y_sva[0]), 
      .A4(MROW_y_sva[9]), .ZN(n_0_2_115));
   NOR2_X1 i_0_2_136 (.A1(n_0_2_116), .A2(n_0_2_115), .ZN(n_0_2_114));
   NAND4_X1 i_0_2_135 (.A1(MROW_y_sva[6]), .A2(n_0_2_119), .A3(n_0_2_114), 
      .A4(n_0_2_138), .ZN(n_0_2_113));
   AND3_X1 i_0_2_123 (.A1(n_0_2_113), .A2(
      EdgeDetect_IP_EdgeDetect_MagAng_run_run_fsm_inst_n_2), .A3(n_0_2_105), 
      .ZN(n_0_8));
   DFFR_X1 reg_dy_in_rsci_oswt_cse_reg (.D(n_0_8), .RN(arst_n), .CK(n_0_3), 
      .Q(reg_dy_in_rsci_oswt_cse), .QN());
   EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_inst (
      .clk(clk), .rst(rst), .arst_n(arst_n), .dy_in_rsc_dat(dy_in_rsc_dat), 
      .dy_in_rsc_vld(dy_in_rsc_vld), .dy_in_rsc_rdy(dy_in_rsc_rdy), .run_wen(
      run_wen), .dy_in_rsci_oswt(reg_dy_in_rsci_oswt_cse), .dy_in_rsci_wen_comp(
      dy_in_rsci_wen_comp), .dy_in_rsci_idat_mxwt(dy_in_rsci_idat_mxwt));
   NAND3_X1 i_0_2_131 (.A1(n_0_2_136), .A2(MCOL_stage_0), .A3(
      EdgeDetect_IP_EdgeDetect_MagAng_run_run_fsm_inst_state_var[0]), .ZN(
      n_0_2_111));
   NOR2_X1 i_0_2_130 (.A1(n_0_2_111), .A2(rst), .ZN(n_0_10));
   DFFR_X1 reg_magn_rsci_oswt_cse_reg (.D(n_0_10), .RN(arst_n), .CK(n_0_3), 
      .Q(reg_magn_rsci_oswt_cse), .QN());
   EdgeDetect_IP_EdgeDetect_MagAng_run_magn_rsci EdgeDetect_IP_EdgeDetect_MagAng_run_magn_rsci_inst (
      .clk(clk), .rst(rst), .arst_n(arst_n), .magn_rsc_dat(), .magn_rsc_vld(
      magn_rsc_vld), .magn_rsc_rdy(magn_rsc_rdy), .run_wen(run_wen), 
      .magn_rsci_oswt(reg_magn_rsci_oswt_cse), .magn_rsci_wen_comp(
      magn_rsci_wen_comp), .magn_rsci_idat());
   NAND3_X1 i_0_2_144 (.A1(dy_in_rsci_wen_comp), .A2(magn_rsci_wen_comp), 
      .A3(dx_in_rsci_wen_comp), .ZN(n_0_2_121));
   INV_X1 i_0_2_143 (.A(n_0_2_121), .ZN(run_wen));
   EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_inst (
      .clk(clk), .rst(rst), .arst_n(arst_n), .dx_in_rsc_dat(dx_in_rsc_dat), 
      .dx_in_rsc_vld(dx_in_rsc_vld), .dx_in_rsc_rdy(dx_in_rsc_rdy), .run_wen(
      run_wen), .dx_in_rsci_oswt(reg_dy_in_rsci_oswt_cse), .dx_in_rsci_wen_comp(
      dx_in_rsci_wen_comp), .dx_in_rsci_idat_mxwt(dx_in_rsci_idat_mxwt));
   NOR2_X1 i_0_2_122 (.A1(n_0_2_121), .A2(n_0_2_111), .ZN(n_0_7));
   INV_X1 i_0_2_145 (.A(dx_in_rsci_idat_mxwt[8]), .ZN(n_0_2_130));
   OR4_X1 i_0_2_80 (.A1(dx_in_rsci_idat_mxwt[3]), .A2(dx_in_rsci_idat_mxwt[2]), 
      .A3(dx_in_rsci_idat_mxwt[1]), .A4(dx_in_rsci_idat_mxwt[0]), .ZN(n_0_2_75));
   OR4_X1 i_0_2_79 (.A1(n_0_2_75), .A2(dx_in_rsci_idat_mxwt[5]), .A3(
      dx_in_rsci_idat_mxwt[6]), .A4(dx_in_rsci_idat_mxwt[7]), .ZN(n_0_2_74));
   OAI21_X1 i_0_2_78 (.A(n_0_2_130), .B1(n_0_2_74), .B2(dx_in_rsci_idat_mxwt[4]), 
      .ZN(n_0_2_73));
   NAND2_X1 i_0_2_77 (.A1(n_0_2_73), .A2(z_out), .ZN(
      MCOL_if_EdgeDetect_IP_EdgeDetect_MagAng_abs_nand_nl));
   INV_X1 i_0_2_149 (.A(dy_in_rsci_idat_mxwt[0]), .ZN(n_0_2_38));
   INV_X1 i_0_2_148 (.A(dy_in_rsci_idat_mxwt[1]), .ZN(n_0_2_134));
   NAND2_X1 i_0_2_121 (.A1(n_0_2_38), .A2(n_0_2_134), .ZN(n_0_2_103));
   OR2_X1 i_0_2_120 (.A1(n_0_2_103), .A2(dy_in_rsci_idat_mxwt[2]), .ZN(n_0_2_102));
   OR3_X1 i_0_2_119 (.A1(n_0_2_102), .A2(dy_in_rsci_idat_mxwt[4]), .A3(
      dy_in_rsci_idat_mxwt[3]), .ZN(n_0_2_101));
   OR3_X1 i_0_2_118 (.A1(n_0_2_101), .A2(dy_in_rsci_idat_mxwt[6]), .A3(
      dy_in_rsci_idat_mxwt[5]), .ZN(n_0_2_100));
   NAND2_X1 i_0_2_117 (.A1(n_0_2_100), .A2(dy_in_rsci_idat_mxwt[8]), .ZN(
      n_0_2_99));
   XOR2_X1 i_0_2_116 (.A(dy_in_rsci_idat_mxwt[7]), .B(n_0_2_99), .Z(n_0_2_88));
   OAI21_X1 i_0_2_115 (.A(dy_in_rsci_idat_mxwt[8]), .B1(n_0_2_102), .B2(
      dy_in_rsci_idat_mxwt[3]), .ZN(n_0_2_98));
   XOR2_X1 i_0_2_114 (.A(dy_in_rsci_idat_mxwt[4]), .B(n_0_2_98), .Z(n_0_2_90));
   NAND2_X1 i_0_2_113 (.A1(n_0_2_102), .A2(dy_in_rsci_idat_mxwt[8]), .ZN(
      n_0_2_97));
   XOR2_X1 i_0_2_112 (.A(dy_in_rsci_idat_mxwt[3]), .B(n_0_2_97), .Z(n_0_2_92));
   OAI21_X1 i_0_2_108 (.A(dy_in_rsci_idat_mxwt[2]), .B1(n_0_2_134), .B2(
      dy_in_rsci_idat_mxwt[8]), .ZN(n_0_2_93));
   NOR2_X1 i_0_2_111 (.A1(n_0_2_100), .A2(dy_in_rsci_idat_mxwt[7]), .ZN(n_0_2_96));
   NOR2_X1 i_0_2_110 (.A1(dy_in_rsci_idat_mxwt[8]), .A2(n_0_2_96), .ZN(n_0_2_95));
   AOI21_X1 i_0_2_109 (.A(n_0_2_95), .B1(dy_in_rsci_idat_mxwt[1]), .B2(
      dy_in_rsci_idat_mxwt[0]), .ZN(n_0_2_94));
   OAI211_X1 i_0_2_107 (.A(n_0_2_103), .B(n_0_2_93), .C1(n_0_2_94), .C2(
      dy_in_rsci_idat_mxwt[2]), .ZN(n_0_2_39));
   HA_X1 i_0_2_17 (.A(n_0_2_92), .B(n_0_2_39), .CO(n_0_2_17), .S(n_0_2_57));
   HA_X1 i_0_2_18 (.A(n_0_2_90), .B(n_0_2_17), .CO(n_0_2_18), .S(n_0_2_58));
   INV_X1 i_0_2_146 (.A(n_0_2_18), .ZN(n_0_2_132));
   NAND2_X1 i_0_2_106 (.A1(dy_in_rsci_idat_mxwt[8]), .A2(n_0_2_18), .ZN(n_0_2_91));
   INV_X1 i_0_2_147 (.A(dy_in_rsci_idat_mxwt[5]), .ZN(n_0_2_133));
   OAI21_X1 i_0_2_105 (.A(n_0_2_91), .B1(n_0_2_18), .B2(n_0_2_133), .ZN(n_0_2_89));
   OAI21_X1 i_0_2_104 (.A(dy_in_rsci_idat_mxwt[8]), .B1(n_0_2_132), .B2(
      n_0_2_133), .ZN(n_0_2_87));
   OAI21_X1 i_0_2_103 (.A(n_0_2_89), .B1(n_0_2_87), .B2(n_0_2_101), .ZN(n_0_2_86));
   XOR2_X1 i_0_2_102 (.A(dy_in_rsci_idat_mxwt[6]), .B(n_0_2_86), .Z(n_0_2_109));
   XNOR2_X1 i_0_2_101 (.A(n_0_2_133), .B(n_0_2_18), .ZN(n_0_2_85));
   NAND2_X1 i_0_2_100 (.A1(n_0_2_101), .A2(dy_in_rsci_idat_mxwt[8]), .ZN(
      n_0_2_84));
   XNOR2_X1 i_0_2_99 (.A(n_0_2_85), .B(n_0_2_84), .ZN(n_0_2_104));
   NAND3_X1 i_0_2_98 (.A1(n_0_2_132), .A2(n_0_2_109), .A3(n_0_2_104), .ZN(
      n_0_2_40));
   HA_X1 i_0_2_19 (.A(n_0_2_88), .B(n_0_2_40), .CO(n_0_2_19), .S(n_0_2_59));
   AOI21_X1 i_0_2_76 (.A(n_0_2_19), .B1(n_0_2_96), .B2(dy_in_rsci_idat_mxwt[8]), 
      .ZN(n_0_2_72));
   INV_X1 i_0_2_75 (.A(n_0_2_72), .ZN(n_0_2_71));
   NAND3_X1 i_0_2_74 (.A1(dy_in_rsci_idat_mxwt[8]), .A2(n_0_2_19), .A3(n_0_2_96), 
      .ZN(n_0_2_70));
   NAND2_X1 i_0_2_73 (.A1(n_0_2_71), .A2(n_0_2_70), .ZN(n_0_2_117));
   AOI22_X1 i_0_2_72 (.A1(n_0_2_73), .A2(n_0_2_56), .B1(n_0_2_130), .B2(
      dx_in_rsci_idat_mxwt[7]), .ZN(n_0_2_122));
   AOI22_X1 i_0_2_71 (.A1(n_0_2_73), .A2(n_0_2_55), .B1(n_0_2_130), .B2(
      dx_in_rsci_idat_mxwt[6]), .ZN(n_0_2_123));
   AOI22_X1 i_0_2_70 (.A1(n_0_2_73), .A2(n_0_2_54), .B1(n_0_2_130), .B2(
      dx_in_rsci_idat_mxwt[5]), .ZN(n_0_2_124));
   AOI22_X1 i_0_2_69 (.A1(n_0_2_73), .A2(n_0_2_53), .B1(n_0_2_130), .B2(
      dx_in_rsci_idat_mxwt[4]), .ZN(n_0_2_125));
   AOI22_X1 i_0_2_68 (.A1(n_0_2_73), .A2(n_0_2_52), .B1(n_0_2_130), .B2(
      dx_in_rsci_idat_mxwt[3]), .ZN(n_0_2_126));
   AOI22_X1 i_0_2_67 (.A1(n_0_2_73), .A2(n_0_2_51), .B1(n_0_2_130), .B2(
      dx_in_rsci_idat_mxwt[2]), .ZN(n_0_2_127));
   AOI21_X1 i_0_2_66 (.A(n_0_2_134), .B1(dy_in_rsci_idat_mxwt[8]), .B2(n_0_2_38), 
      .ZN(n_0_2_69));
   XNOR2_X1 i_0_2_65 (.A(dy_in_rsci_idat_mxwt[2]), .B(n_0_2_69), .ZN(n_0_2_128));
   AOI22_X1 i_0_2_64 (.A1(n_0_2_73), .A2(n_0_2_50), .B1(n_0_2_130), .B2(
      dx_in_rsci_idat_mxwt[1]), .ZN(n_0_2_129));
   NAND2_X1 i_0_2_63 (.A1(dy_in_rsci_idat_mxwt[0]), .A2(dy_in_rsci_idat_mxwt[8]), 
      .ZN(n_0_2_68));
   XNOR2_X1 i_0_2_62 (.A(dy_in_rsci_idat_mxwt[1]), .B(n_0_2_68), .ZN(
      MUX_v_7_2_2_return[0]));
   NAND2_X1 i_0_2_61 (.A1(n_0_2_73), .A2(MUX_v_10_2_26_return[0]), .ZN(n_0_2_67));
   OAI21_X1 i_0_2_60 (.A(n_0_2_67), .B1(n_0_2_73), .B2(dx_in_rsci_idat_mxwt[0]), 
      .ZN(n_0_2_131));
   HA_X1 i_0_2_20 (.A(n_0_2_131), .B(n_0_2_38), .CO(n_0_2_21), .S(n_0_2_20));
   FA_X1 i_0_2_21 (.A(n_0_2_129), .B(MUX_v_7_2_2_return[0]), .CI(n_0_2_21), 
      .CO(n_0_2_23), .S(n_0_2_22));
   FA_X1 i_0_2_22 (.A(n_0_2_127), .B(n_0_2_128), .CI(n_0_2_23), .CO(n_0_2_25), 
      .S(n_0_2_24));
   FA_X1 i_0_2_23 (.A(n_0_2_126), .B(n_0_2_57), .CI(n_0_2_25), .CO(n_0_2_27), 
      .S(n_0_2_26));
   FA_X1 i_0_2_24 (.A(n_0_2_125), .B(n_0_2_58), .CI(n_0_2_27), .CO(n_0_2_29), 
      .S(n_0_2_28));
   FA_X1 i_0_2_25 (.A(n_0_2_124), .B(n_0_2_104), .CI(n_0_2_29), .CO(n_0_2_31), 
      .S(n_0_2_30));
   FA_X1 i_0_2_26 (.A(n_0_2_123), .B(n_0_2_109), .CI(n_0_2_31), .CO(n_0_2_33), 
      .S(n_0_2_32));
   FA_X1 i_0_2_27 (.A(n_0_2_122), .B(n_0_2_59), .CI(n_0_2_33), .CO(n_0_2_35), 
      .S(n_0_2_34));
   FA_X1 i_0_2_28 (.A(MCOL_if_EdgeDetect_IP_EdgeDetect_MagAng_abs_nand_nl), 
      .B(n_0_2_117), .CI(n_0_2_35), .CO(n_0_2_37), .S(n_0_2_36));
   AOI21_X1 i_0_2_58 (.A(n_0_2_37), .B1(n_0_2_73), .B2(z_out), .ZN(n_0_2_65));
   NAND3_X1 i_0_2_59 (.A1(n_0_2_73), .A2(n_0_2_37), .A3(z_out), .ZN(n_0_2_66));
   AOI21_X1 i_0_2_57 (.A(n_0_2_65), .B1(n_0_2_72), .B2(n_0_2_66), .ZN(n_0_6));
   MUX2_X1 magn_rsci_idat_0_reg_enable_mux_0 (.A(magn_rsc_dat[7]), .B(n_0_6), 
      .S(n_0_7), .Z(n_0_0));
   DFF_X1 magn_rsci_idat_0_reg (.D(n_0_0), .CK(clk), .Q(magn_rsc_dat[7]), .QN());
endmodule

module EdgeDetect_IP_EdgeDetect_MagAng(clk, rst, arst_n, dx_in_rsc_dat, 
      dx_in_rsc_vld, dx_in_rsc_rdy, dy_in_rsc_dat, dy_in_rsc_vld, dy_in_rsc_rdy, 
      widthIn_rsc_dat, widthIn_triosy_lz, heightIn_rsc_dat, heightIn_triosy_lz, 
      magn_rsc_dat, magn_rsc_vld, magn_rsc_rdy);
   input clk;
   input rst;
   input arst_n;
   input [8:0]dx_in_rsc_dat;
   input dx_in_rsc_vld;
   output dx_in_rsc_rdy;
   input [8:0]dy_in_rsc_dat;
   input dy_in_rsc_vld;
   output dy_in_rsc_rdy;
   input [10:0]widthIn_rsc_dat;
   output widthIn_triosy_lz;
   input [9:0]heightIn_rsc_dat;
   output heightIn_triosy_lz;
   output [7:0]magn_rsc_dat;
   output magn_rsc_vld;
   input magn_rsc_rdy;

   EdgeDetect_IP_EdgeDetect_MagAng_run EdgeDetect_IP_EdgeDetect_MagAng_run_inst (
      .clk(clk), .rst(rst), .arst_n(arst_n), .dx_in_rsc_dat(dx_in_rsc_dat), 
      .dx_in_rsc_vld(dx_in_rsc_vld), .dx_in_rsc_rdy(dx_in_rsc_rdy), 
      .dy_in_rsc_dat(dy_in_rsc_dat), .dy_in_rsc_vld(dy_in_rsc_vld), 
      .dy_in_rsc_rdy(dy_in_rsc_rdy), .widthIn_rsc_dat(), .widthIn_triosy_lz(), 
      .heightIn_rsc_dat(), .heightIn_triosy_lz(), .magn_rsc_dat({magn_rsc_dat[7], 
      uc_0, uc_1, uc_2, uc_3, uc_4, uc_5, uc_6}), .magn_rsc_vld(magn_rsc_vld), 
      .magn_rsc_rdy(magn_rsc_rdy));
endmodule

module EdgeDetect_IP_EdgeDetect_HorDer_run_dx_rsci(clk, rst, arst_n, dx_rsc_dat, 
      dx_rsc_vld, dx_rsc_rdy, run_wen, dx_rsci_oswt, dx_rsci_wen_comp, 
      dx_rsci_idat);
   input clk;
   input rst;
   input arst_n;
   output [8:0]dx_rsc_dat;
   output dx_rsc_vld;
   input dx_rsc_rdy;
   input run_wen;
   input dx_rsci_oswt;
   output dx_rsci_wen_comp;
   input [8:0]dx_rsci_idat;

   wire dx_rsci_bcwt;
   wire EdgeDetect_IP_EdgeDetect_HorDer_run_dx_rsci_dx_wait_dp_inst_n_1;
   wire n_0_0_0;
   wire n_0_0_1;
   wire n_0_0_2;

   INV_X1 i_0_0_5 (.A(dx_rsci_oswt), .ZN(n_0_0_2));
   AOI21_X1 i_0_0_1 (.A(dx_rsci_bcwt), .B1(dx_rsci_oswt), .B2(dx_rsc_rdy), 
      .ZN(n_0_0_0));
   AOI211_X1 i_0_0_0 (.A(rst), .B(n_0_0_0), .C1(dx_rsci_oswt), .C2(run_wen), 
      .ZN(EdgeDetect_IP_EdgeDetect_HorDer_run_dx_rsci_dx_wait_dp_inst_n_1));
   DFFR_X1 EdgeDetect_IP_EdgeDetect_HorDer_run_dx_rsci_dx_wait_dp_inst_dx_rsci_bcwt_reg (
      .D(EdgeDetect_IP_EdgeDetect_HorDer_run_dx_rsci_dx_wait_dp_inst_n_1), 
      .RN(arst_n), .CK(clk), .Q(dx_rsci_bcwt), .QN());
   NOR2_X1 i_0_0_3 (.A1(n_0_0_2), .A2(dx_rsci_bcwt), .ZN(dx_rsc_vld));
   INV_X1 i_0_0_4 (.A(dx_rsc_rdy), .ZN(n_0_0_1));
   NAND2_X1 i_0_0_2 (.A1(dx_rsc_vld), .A2(n_0_0_1), .ZN(dx_rsci_wen_comp));
endmodule

module EdgeDetect_IP_EdgeDetect_HorDer_run_dat_in_rsci(dat_in_rsc_dat, 
      dat_in_rsc_vld, dat_in_rsc_rdy, run_wen, dat_in_rsci_oswt, 
      dat_in_rsci_wen_comp, dat_in_rsci_idat_mxwt);
   input [7:0]dat_in_rsc_dat;
   input dat_in_rsc_vld;
   output dat_in_rsc_rdy;
   input run_wen;
   input dat_in_rsci_oswt;
   output dat_in_rsci_wen_comp;
   output [7:0]dat_in_rsci_idat_mxwt;

   wire n_0_0_0;

   AND2_X1 i_0_0_0 (.A1(dat_in_rsci_oswt), .A2(run_wen), .ZN(dat_in_rsc_rdy));
   INV_X1 i_0_0_1 (.A(dat_in_rsc_vld), .ZN(n_0_0_0));
   NAND2_X1 i_0_0_2 (.A1(n_0_0_0), .A2(dat_in_rsci_oswt), .ZN(
      dat_in_rsci_wen_comp));
endmodule

module EdgeDetect_IP_EdgeDetect_HorDer_run(clk, rst, arst_n, dat_in_rsc_dat, 
      dat_in_rsc_vld, dat_in_rsc_rdy, widthIn, heightIn, dx_rsc_dat, dx_rsc_vld, 
      dx_rsc_rdy);
   input clk;
   input rst;
   input arst_n;
   input [7:0]dat_in_rsc_dat;
   input dat_in_rsc_vld;
   output dat_in_rsc_rdy;
   input [10:0]widthIn;
   input [9:0]heightIn;
   output [8:0]dx_rsc_dat;
   output dx_rsc_vld;
   input dx_rsc_rdy;

   wire dx_rsci_wen_comp;
   wire dat_in_rsci_wen_comp;
   wire [1:0]EdgeDetect_IP_EdgeDetect_HorDer_run_run_fsm_inst_state_var;
   wire n_0_44;
   wire [7:0]pix_buf1_lpi_3;
   wire n_0_48;
   wire reg_dat_in_rsci_oswt_cse;
   wire reg_dx_rsci_oswt_cse;
   wire HCOL_stage_0_2;
   wire HCOL_stage_0_1;
   wire [10:0]HCOL_asn_1_itm_1;
   wire HCOL_if_slc_HCOL_acc_11_svs_1;
   wire n_0_5;
   wire HCOL_nor_1_itm_1;
   wire n_0_6;
   wire n_0_0;
   wire HCOL_x_sva5;
   wire n_0_7;
   wire n_0_8;
   wire n_0_9;
   wire n_0_10;
   wire n_0_11;
   wire n_0_12;
   wire n_0_13;
   wire n_0_14;
   wire n_0_15;
   wire n_0_16;
   wire n_0_1;
   wire [9:0]HROW_y_sva;
   wire n_0_2;
   wire [7:0]pix0_lpi_3;
   wire n_0_3;
   wire [7:0]pix_buf0_lpi_3;
   wire n_0_4;
   wire n_0_2_9;
   wire n_0_2_10;
   wire n_0_2_11;
   wire n_0_2_12;
   wire n_0_2_13;
   wire n_0_2_14;
   wire n_0_2_15;
   wire n_0_2_16;
   wire n_0_2_17;
   wire n_0_2_18;
   wire n_0_2_19;
   wire n_0_2_20;
   wire n_0_2_21;
   wire n_0_2_22;
   wire n_0_2_23;
   wire n_0_2_24;
   wire n_0_2_25;
   wire n_0_2_26;
   wire n_0_2_27;
   wire n_0_2_28;
   wire n_0_2_29;
   wire n_0_2_30;
   wire [7:0]MUX_v_8_2_212_return;
   wire n_0_2_49;
   wire n_0_2_50;
   wire n_0_2_51;
   wire n_0_2_52;
   wire n_0_2_53;
   wire n_0_2_54;
   wire n_0_2_55;
   wire n_0_2_56;
   wire n_0_2_57;
   wire [7:0]MUX_v_8_2_211_return;
   wire [9:0]MUX_v_10_2_23_return;
   wire n_0_20;
   wire n_0_21;
   wire n_0_22;
   wire n_0_23;
   wire n_0_24;
   wire n_0_25;
   wire n_0_35;
   wire n_0_36;
   wire n_0_37;
   wire n_0_38;
   wire n_0_39;
   wire n_0_40;
   wire n_0_17;
   wire n_0_19;
   wire n_0_43;
   wire n_0_45;
   wire n_0_46;
   wire n_0_47;
   wire n_0_49;
   wire n_0_50;
   wire n_0_51;
   wire n_0_52;
   wire n_0_53;
   wire n_0_54;
   wire n_0_55;
   wire n_0_56;
   wire n_0_57;
   wire n_0_58;
   wire n_0_60;
   wire n_0_61;
   wire n_0_59;
   wire n_0_2_71;
   wire n_0_2_72;
   wire [10:0]vector;
   wire n_0_2_73;
   wire EdgeDetect_IP_EdgeDetect_HorDer_run_run_fsm_inst_n_2;
   wire n_0_2_74;
   wire EdgeDetect_IP_EdgeDetect_HorDer_run_run_fsm_inst_n_1;
   wire n_0_62;
   wire n_0_2_91;
   wire n_0_2_92;
   wire n_0_2_93;
   wire n_0_2_94;
   wire n_0_2_95;
   wire n_0_63;
   wire n_0_2_97;
   wire n_0_2_111;
   wire n_0_2_112;
   wire n_0_2_113;
   wire n_0_2_116;
   wire run_wen;
   wire n_0_2_45;
   wire n_0_2_46;
   wire n_0_2_185;
   wire n_0_2_58;
   wire n_0_18;
   wire n_0_2_59;
   wire n_0_2_60;
   wire n_0_2_61;
   wire n_0_2_62;
   wire n_0_2_63;
   wire n_0_2_64;
   wire n_0_2_65;
   wire n_0_2_66;
   wire n_0_2_67;
   wire n_0_2_68;
   wire n_0_2_69;
   wire n_0_2_70;
   wire n_0_2_75;
   wire n_0_2_76;
   wire n_0_2_77;
   wire n_0_2_78;
   wire n_0_2_79;
   wire n_0_2_80;
   wire n_0_2_81;
   wire n_0_2_82;
   wire n_0_2_83;
   wire n_0_2_84;
   wire n_0_2_42;
   wire n_0_2_2;
   wire n_0_2_43;
   wire n_0_2_3;
   wire n_0_2_44;
   wire n_0_2_4;
   wire n_0_2_85;
   wire n_0_2_5;
   wire n_0_2_86;
   wire n_0_2_6;
   wire n_0_2_47;
   wire n_0_2_7;
   wire n_0_2_48;
   wire n_0_2_8;
   wire n_0_2_40;
   wire n_0_2_0;
   wire n_0_2_41;
   wire n_0_2_1;
   wire n_0_2_87;
   wire n_0_2_88;
   wire n_0_2_89;
   wire n_0_2_90;
   wire n_0_2_96;
   wire n_0_2_98;
   wire n_0_2_99;
   wire n_0_2_100;
   wire n_0_2_101;
   wire n_0_41;
   wire n_0_2_102;
   wire n_0_2_103;
   wire [9:0]MUX_v_10_2_24_return;
   wire n_0_2_104;
   wire n_0_2_105;
   wire n_0_2_106;
   wire n_0_2_107;
   wire n_0_2_108;
   wire n_0_2_109;
   wire n_0_2_110;
   wire n_0_2_114;
   wire n_0_2_115;
   wire n_0_2_117;
   wire n_0_2_118;
   wire n_0_2_120;
   wire n_0_2_122;
   wire n_0_2_124;
   wire n_0_2_126;
   wire n_0_2_128;
   wire n_0_2_130;
   wire n_0_2_132;
   wire n_0_42;
   wire n_0_2_134;
   wire n_0_2_136;
   wire n_0_2_138;
   wire n_0_2_140;
   wire n_0_2_142;
   wire n_0_2_144;
   wire n_0_2_146;
   wire n_0_2_148;
   wire n_0_2_149;
   wire n_0_2_151;
   wire n_0_2_152;
   wire n_0_26;
   wire n_0_2_31;
   wire n_0_28;
   wire n_0_2_33;
   wire n_0_29;
   wire n_0_2_34;
   wire n_0_30;
   wire n_0_2_35;
   wire n_0_31;
   wire n_0_2_36;
   wire n_0_32;
   wire n_0_2_37;
   wire n_0_33;
   wire n_0_2_38;
   wire n_0_34;
   wire n_0_2_39;
   wire n_0_27;
   wire n_0_2_32;
   wire operator_8_false_2_or_1_nl;
   wire n_0_2_153;
   wire n_0_2_154;
   wire n_0_2_155;
   wire n_0_2_156;
   wire n_0_2_157;
   wire n_0_2_158;
   wire n_0_2_159;
   wire n_0_2_160;
   wire n_0_2_161;
   wire n_0_2_162;
   wire n_0_2_163;
   wire n_0_2_164;
   wire n_0_2_165;
   wire sel;
   wire n_0_2_166;
   wire n_0_2_167;
   wire n_0_2_168;
   wire n_0_2_170;
   wire n_0_2_171;
   wire n_0_2_172;
   wire EdgeDetect_IP_EdgeDetect_HorDer_run_run_fsm_inst_n_3;
   wire n_0_2_173;
   wire n_0_2_174;
   wire n_0_2_175;
   wire n_0_2_176;
   wire n_0_2_119;
   wire n_0_2_177;
   wire n_0_2_121;
   wire n_0_2_178;
   wire n_0_2_179;
   wire n_0_2_123;
   wire n_0_2_125;
   wire n_0_2_180;
   wire n_0_2_181;
   wire n_0_2_127;
   wire n_0_2_129;
   wire n_0_2_182;
   wire n_0_2_131;
   wire n_0_2_133;
   wire n_0_2_183;
   wire n_0_2_184;
   wire n_0_2_135;
   wire n_0_2_186;
   wire n_0_2_137;
   wire n_0_2_187;
   wire n_0_2_188;
   wire n_0_2_139;
   wire n_0_2_141;
   wire n_0_2_189;
   wire n_0_2_190;
   wire n_0_2_143;
   wire n_0_2_145;
   wire n_0_2_191;
   wire n_0_2_192;
   wire n_0_2_147;
   wire n_0_2_150;
   wire n_0_2_169;
   wire n_0_2_193;
   wire n_0_2_194;
   wire n_0_2_195;
   wire n_0_2_196;
   wire n_0_2_197;
   wire n_0_2_198;

   INV_X1 i_0_2_118 (.A(
      EdgeDetect_IP_EdgeDetect_HorDer_run_run_fsm_inst_state_var[1]), .ZN(
      n_0_2_84));
   OAI21_X1 i_0_2_71 (.A(n_0_2_84), .B1(HCOL_stage_0_2), .B2(HCOL_stage_0_1), 
      .ZN(n_0_2_74));
   AOI21_X1 i_0_2_70 (.A(rst), .B1(n_0_2_74), .B2(
      EdgeDetect_IP_EdgeDetect_HorDer_run_run_fsm_inst_state_var[0]), .ZN(
      EdgeDetect_IP_EdgeDetect_HorDer_run_run_fsm_inst_n_2));
   INV_X1 i_0_2_128 (.A(rst), .ZN(n_0_2_87));
   NAND2_X1 i_0_2_134 (.A1(n_0_2_87), .A2(n_0_2_82), .ZN(
      EdgeDetect_IP_EdgeDetect_HorDer_run_run_fsm_inst_n_1));
   CLKGATE_X1 clk_gate_reg_dat_in_rsci_oswt_cse_reg (.CK(clk), .E(
      EdgeDetect_IP_EdgeDetect_HorDer_run_run_fsm_inst_n_1), .GCK(n_0_4));
   DFFR_X1 \EdgeDetect_IP_EdgeDetect_HorDer_run_run_fsm_inst_state_var_reg[0]  (
      .D(EdgeDetect_IP_EdgeDetect_HorDer_run_run_fsm_inst_n_2), .RN(arst_n), 
      .CK(n_0_4), .Q(
      EdgeDetect_IP_EdgeDetect_HorDer_run_run_fsm_inst_state_var[0]), .QN());
   AOI21_X1 i_0_2_63 (.A(rst), .B1(n_0_2_72), .B2(
      EdgeDetect_IP_EdgeDetect_HorDer_run_run_fsm_inst_state_var[0]), .ZN(n_0_60));
   DFFR_X1 HCOL_stage_0_1_reg (.D(n_0_60), .RN(arst_n), .CK(n_0_4), .Q(
      HCOL_stage_0_1), .QN());
   INV_X1 i_0_2_173 (.A(n_0_2_43), .ZN(n_0_2_122));
   INV_X1 i_0_2_117 (.A(
      EdgeDetect_IP_EdgeDetect_HorDer_run_run_fsm_inst_state_var[0]), .ZN(
      n_0_2_83));
   AOI21_X1 i_0_2_19 (.A(n_0_2_122), .B1(n_0_2_83), .B2(n_0_2_84), .ZN(
      MUX_v_10_2_23_return[4]));
   NOR2_X1 i_0_2_80 (.A1(n_0_2_82), .A2(
      EdgeDetect_IP_EdgeDetect_HorDer_run_run_fsm_inst_state_var[0]), .ZN(n_0_19));
   CLKGATE_X1 clk_gate_HROW_y_sva_reg (.CK(clk), .E(n_0_19), .GCK(n_0_1));
   DFF_X1 \HROW_y_sva_reg[4]  (.D(MUX_v_10_2_23_return[4]), .CK(n_0_1), .Q(
      HROW_y_sva[4]), .QN());
   OAI22_X1 i_0_2_160 (.A1(n_0_2_102), .A2(n_0_12), .B1(HROW_y_sva[4]), .B2(
      n_0_2_60), .ZN(n_0_2_108));
   INV_X1 i_0_2_161 (.A(n_0_2_108), .ZN(MUX_v_10_2_24_return[4]));
   AOI22_X1 i_0_2_138 (.A1(n_0_2_96), .A2(n_0_13), .B1(HCOL_stage_0_2), .B2(
      n_0_2_42), .ZN(vector[3]));
   NAND2_X1 i_0_2_66 (.A1(n_0_2_87), .A2(
      EdgeDetect_IP_EdgeDetect_HorDer_run_run_fsm_inst_state_var[0]), .ZN(
      n_0_2_71));
   NOR2_X1 i_0_2_28 (.A1(vector[3]), .A2(n_0_2_71), .ZN(n_0_23));
   INV_X1 i_0_2_190 (.A(HCOL_stage_0_2), .ZN(n_0_2_152));
   AOI21_X1 i_0_2_58 (.A(n_0_2_82), .B1(n_0_2_152), .B2(
      EdgeDetect_IP_EdgeDetect_HorDer_run_run_fsm_inst_state_var[0]), .ZN(n_0_17));
   OR2_X1 i_0_2_57 (.A1(rst), .A2(n_0_17), .ZN(n_0_40));
   CLKGATE_X1 clk_gate_HCOL_x_sva_reg (.CK(clk), .E(n_0_40), .GCK(n_0_0));
   DFFR_X1 \HCOL_x_sva_reg[3]  (.D(n_0_23), .RN(arst_n), .CK(n_0_0), .Q(n_0_13), 
      .QN());
   INV_X1 i_0_2_172 (.A(n_0_2_42), .ZN(n_0_2_120));
   AOI21_X1 i_0_2_18 (.A(n_0_2_120), .B1(n_0_2_83), .B2(n_0_2_84), .ZN(
      MUX_v_10_2_23_return[3]));
   DFF_X1 \HROW_y_sva_reg[3]  (.D(MUX_v_10_2_23_return[3]), .CK(n_0_1), .Q(
      HROW_y_sva[3]), .QN());
   OAI22_X1 i_0_2_158 (.A1(n_0_2_102), .A2(n_0_13), .B1(HROW_y_sva[3]), .B2(
      n_0_2_60), .ZN(n_0_2_107));
   INV_X1 i_0_2_159 (.A(n_0_2_107), .ZN(MUX_v_10_2_24_return[3]));
   AOI22_X1 i_0_2_143 (.A1(n_0_2_96), .A2(n_0_14), .B1(HCOL_stage_0_2), .B2(
      n_0_2_41), .ZN(vector[2]));
   NOR2_X1 i_0_2_27 (.A1(vector[2]), .A2(n_0_2_71), .ZN(n_0_22));
   DFFR_X1 \HCOL_x_sva_reg[2]  (.D(n_0_22), .RN(arst_n), .CK(n_0_0), .Q(n_0_14), 
      .QN());
   INV_X1 i_0_2_171 (.A(n_0_2_41), .ZN(n_0_2_118));
   AOI21_X1 i_0_2_17 (.A(n_0_2_118), .B1(n_0_2_83), .B2(n_0_2_84), .ZN(
      MUX_v_10_2_23_return[2]));
   DFF_X1 \HROW_y_sva_reg[2]  (.D(MUX_v_10_2_23_return[2]), .CK(n_0_1), .Q(
      HROW_y_sva[2]), .QN());
   OAI22_X1 i_0_2_156 (.A1(n_0_2_102), .A2(n_0_14), .B1(HROW_y_sva[2]), .B2(
      n_0_2_60), .ZN(n_0_2_106));
   INV_X1 i_0_2_157 (.A(n_0_2_106), .ZN(MUX_v_10_2_24_return[2]));
   AOI22_X1 i_0_2_139 (.A1(n_0_2_96), .A2(n_0_15), .B1(HCOL_stage_0_2), .B2(
      n_0_2_40), .ZN(vector[1]));
   NOR2_X1 i_0_2_26 (.A1(vector[1]), .A2(n_0_2_71), .ZN(n_0_21));
   DFFR_X1 \HCOL_x_sva_reg[1]  (.D(n_0_21), .RN(arst_n), .CK(n_0_0), .Q(n_0_15), 
      .QN());
   INV_X1 i_0_2_170 (.A(n_0_2_40), .ZN(n_0_2_117));
   AOI21_X1 i_0_2_16 (.A(n_0_2_117), .B1(n_0_2_83), .B2(n_0_2_84), .ZN(
      MUX_v_10_2_23_return[1]));
   DFF_X1 \HROW_y_sva_reg[1]  (.D(MUX_v_10_2_23_return[1]), .CK(n_0_1), .Q(
      HROW_y_sva[1]), .QN());
   OAI22_X1 i_0_2_154 (.A1(n_0_2_102), .A2(n_0_15), .B1(HROW_y_sva[1]), .B2(
      n_0_2_60), .ZN(n_0_2_105));
   INV_X1 i_0_2_155 (.A(n_0_2_105), .ZN(MUX_v_10_2_24_return[1]));
   HA_X1 i_0_2_126 (.A(MUX_v_10_2_24_return[1]), .B(MUX_v_10_2_24_return[0]), 
      .CO(n_0_2_0), .S(n_0_2_40));
   HA_X1 i_0_2_127 (.A(MUX_v_10_2_24_return[2]), .B(n_0_2_0), .CO(n_0_2_1), 
      .S(n_0_2_41));
   HA_X1 i_0_2_119 (.A(MUX_v_10_2_24_return[3]), .B(n_0_2_1), .CO(n_0_2_2), 
      .S(n_0_2_42));
   HA_X1 i_0_2_120 (.A(MUX_v_10_2_24_return[4]), .B(n_0_2_2), .CO(n_0_2_3), 
      .S(n_0_2_43));
   AOI22_X1 i_0_2_136 (.A1(n_0_2_96), .A2(n_0_12), .B1(HCOL_stage_0_2), .B2(
      n_0_2_43), .ZN(vector[4]));
   NOR2_X1 i_0_2_29 (.A1(vector[4]), .A2(n_0_2_71), .ZN(n_0_24));
   DFFR_X1 \HCOL_x_sva_reg[4]  (.D(n_0_24), .RN(arst_n), .CK(n_0_0), .Q(n_0_12), 
      .QN());
   XOR2_X1 i_0_2_112 (.A(n_0_12), .B(widthIn[4]), .Z(n_0_2_78));
   XOR2_X1 i_0_2_111 (.A(n_0_8), .B(widthIn[8]), .Z(n_0_2_77));
   INV_X1 i_0_2_178 (.A(n_0_2_48), .ZN(n_0_2_132));
   AOI21_X1 i_0_2_24 (.A(n_0_2_132), .B1(n_0_2_83), .B2(n_0_2_84), .ZN(
      MUX_v_10_2_23_return[9]));
   DFF_X1 \HROW_y_sva_reg[9]  (.D(MUX_v_10_2_23_return[9]), .CK(n_0_1), .Q(
      HROW_y_sva[9]), .QN());
   OAI22_X1 i_0_2_150 (.A1(n_0_2_102), .A2(n_0_7), .B1(HROW_y_sva[9]), .B2(
      n_0_2_60), .ZN(n_0_2_103));
   INV_X1 i_0_2_151 (.A(n_0_2_103), .ZN(MUX_v_10_2_24_return[9]));
   HA_X1 i_0_2_125 (.A(MUX_v_10_2_24_return[9]), .B(n_0_2_7), .CO(n_0_2_8), 
      .S(n_0_2_48));
   AOI22_X1 i_0_2_140 (.A1(n_0_2_96), .A2(n_0_7), .B1(HCOL_stage_0_2), .B2(
      n_0_2_48), .ZN(vector[9]));
   NOR2_X1 i_0_2_55 (.A1(vector[9]), .A2(n_0_2_71), .ZN(n_0_38));
   DFFR_X1 \HCOL_x_sva_reg[9]  (.D(n_0_38), .RN(arst_n), .CK(n_0_0), .Q(n_0_7), 
      .QN());
   XOR2_X1 i_0_2_97 (.A(n_0_7), .B(widthIn[9]), .Z(n_0_2_69));
   NOR3_X1 i_0_2_93 (.A1(n_0_2_78), .A2(n_0_2_77), .A3(n_0_2_69), .ZN(n_0_2_65));
   INV_X1 i_0_2_175 (.A(n_0_2_85), .ZN(n_0_2_126));
   AOI21_X1 i_0_2_21 (.A(n_0_2_126), .B1(n_0_2_83), .B2(n_0_2_84), .ZN(
      MUX_v_10_2_23_return[6]));
   DFF_X1 \HROW_y_sva_reg[6]  (.D(MUX_v_10_2_23_return[6]), .CK(n_0_1), .Q(
      HROW_y_sva[6]), .QN());
   OAI22_X1 i_0_2_164 (.A1(n_0_2_102), .A2(n_0_10), .B1(HROW_y_sva[6]), .B2(
      n_0_2_60), .ZN(n_0_2_110));
   INV_X1 i_0_2_165 (.A(n_0_2_110), .ZN(MUX_v_10_2_24_return[6]));
   AOI22_X1 i_0_2_135 (.A1(n_0_2_96), .A2(n_0_11), .B1(HCOL_stage_0_2), .B2(
      n_0_2_44), .ZN(vector[5]));
   NOR2_X1 i_0_2_30 (.A1(vector[5]), .A2(n_0_2_71), .ZN(n_0_25));
   DFFR_X1 \HCOL_x_sva_reg[5]  (.D(n_0_25), .RN(arst_n), .CK(n_0_0), .Q(n_0_11), 
      .QN());
   INV_X1 i_0_2_174 (.A(n_0_2_44), .ZN(n_0_2_124));
   AOI21_X1 i_0_2_20 (.A(n_0_2_124), .B1(n_0_2_83), .B2(n_0_2_84), .ZN(
      MUX_v_10_2_23_return[5]));
   DFF_X1 \HROW_y_sva_reg[5]  (.D(MUX_v_10_2_23_return[5]), .CK(n_0_1), .Q(
      HROW_y_sva[5]), .QN());
   OAI22_X1 i_0_2_162 (.A1(n_0_2_102), .A2(n_0_11), .B1(HROW_y_sva[5]), .B2(
      n_0_2_60), .ZN(n_0_2_109));
   INV_X1 i_0_2_163 (.A(n_0_2_109), .ZN(MUX_v_10_2_24_return[5]));
   HA_X1 i_0_2_121 (.A(MUX_v_10_2_24_return[5]), .B(n_0_2_3), .CO(n_0_2_4), 
      .S(n_0_2_44));
   HA_X1 i_0_2_122 (.A(MUX_v_10_2_24_return[6]), .B(n_0_2_4), .CO(n_0_2_5), 
      .S(n_0_2_85));
   AOI22_X1 i_0_2_141 (.A1(n_0_2_96), .A2(n_0_10), .B1(HCOL_stage_0_2), .B2(
      n_0_2_85), .ZN(vector[6]));
   NOR2_X1 i_0_2_45 (.A1(vector[6]), .A2(n_0_2_71), .ZN(n_0_35));
   DFFR_X1 \HCOL_x_sva_reg[6]  (.D(n_0_35), .RN(arst_n), .CK(n_0_0), .Q(n_0_10), 
      .QN());
   XOR2_X1 i_0_2_115 (.A(n_0_10), .B(widthIn[6]), .Z(n_0_2_81));
   XOR2_X1 i_0_2_96 (.A(n_0_11), .B(widthIn[5]), .Z(n_0_2_68));
   XOR2_X1 i_0_2_110 (.A(n_0_13), .B(widthIn[3]), .Z(n_0_2_76));
   NOR2_X1 i_0_2_25 (.A1(vector[0]), .A2(n_0_2_71), .ZN(n_0_20));
   DFFR_X1 \HCOL_x_sva_reg[0]  (.D(n_0_20), .RN(arst_n), .CK(n_0_0), .Q(n_0_16), 
      .QN());
   XOR2_X1 i_0_2_108 (.A(n_0_16), .B(widthIn[0]), .Z(n_0_2_70));
   NOR4_X1 i_0_2_92 (.A1(n_0_2_81), .A2(n_0_2_68), .A3(n_0_2_76), .A4(n_0_2_70), 
      .ZN(n_0_2_64));
   XOR2_X1 i_0_2_114 (.A(n_0_14), .B(widthIn[2]), .Z(n_0_2_80));
   XOR2_X1 i_0_2_109 (.A(n_0_15), .B(widthIn[1]), .Z(n_0_2_75));
   INV_X1 i_0_2_176 (.A(n_0_2_86), .ZN(n_0_2_128));
   AOI21_X1 i_0_2_22 (.A(n_0_2_128), .B1(n_0_2_83), .B2(n_0_2_84), .ZN(
      MUX_v_10_2_23_return[7]));
   DFF_X1 \HROW_y_sva_reg[7]  (.D(MUX_v_10_2_23_return[7]), .CK(n_0_1), .Q(
      HROW_y_sva[7]), .QN());
   OAI22_X1 i_0_2_166 (.A1(n_0_2_102), .A2(n_0_9), .B1(HROW_y_sva[7]), .B2(
      n_0_2_60), .ZN(n_0_2_114));
   INV_X1 i_0_2_167 (.A(n_0_2_114), .ZN(MUX_v_10_2_24_return[7]));
   HA_X1 i_0_2_123 (.A(MUX_v_10_2_24_return[7]), .B(n_0_2_5), .CO(n_0_2_6), 
      .S(n_0_2_86));
   AOI22_X1 i_0_2_142 (.A1(n_0_2_96), .A2(n_0_9), .B1(HCOL_stage_0_2), .B2(
      n_0_2_86), .ZN(vector[7]));
   NOR2_X1 i_0_2_46 (.A1(vector[7]), .A2(n_0_2_71), .ZN(n_0_36));
   DFFR_X1 \HCOL_x_sva_reg[7]  (.D(n_0_36), .RN(arst_n), .CK(n_0_0), .Q(n_0_9), 
      .QN());
   XOR2_X1 i_0_2_113 (.A(n_0_9), .B(widthIn[7]), .Z(n_0_2_79));
   NAND2_X1 i_0_2_129 (.A1(HCOL_x_sva5), .A2(n_0_2_60), .ZN(n_0_2_88));
   XNOR2_X1 i_0_2_130 (.A(n_0_2_88), .B(n_0_2_8), .ZN(n_0_2_89));
   AOI22_X1 i_0_2_133 (.A1(n_0_2_89), .A2(HCOL_stage_0_2), .B1(HCOL_x_sva5), 
      .B2(n_0_2_96), .ZN(vector[10]));
   NOR2_X1 i_0_2_56 (.A1(vector[10]), .A2(n_0_2_71), .ZN(n_0_39));
   DFFR_X1 \HCOL_x_sva_reg[10]  (.D(n_0_39), .RN(arst_n), .CK(n_0_0), .Q(
      HCOL_x_sva5), .QN());
   XOR2_X1 i_0_2_95 (.A(HCOL_x_sva5), .B(widthIn[10]), .Z(n_0_2_67));
   NOR4_X1 i_0_2_94 (.A1(n_0_2_80), .A2(n_0_2_75), .A3(n_0_2_79), .A4(n_0_2_67), 
      .ZN(n_0_2_66));
   NAND3_X1 i_0_2_91 (.A1(n_0_2_65), .A2(n_0_2_64), .A3(n_0_2_66), .ZN(n_0_2_63));
   OAI21_X1 i_0_2_67 (.A(HCOL_stage_0_1), .B1(n_0_2_63), .B2(n_0_2_152), 
      .ZN(n_0_2_72));
   NOR2_X1 i_0_2_65 (.A1(n_0_2_72), .A2(n_0_2_71), .ZN(n_0_59));
   DFFR_X1 HCOL_stage_0_2_reg (.D(n_0_59), .RN(arst_n), .CK(n_0_4), .Q(
      HCOL_stage_0_2), .QN());
   INV_X1 i_0_2_132 (.A(HCOL_stage_0_2), .ZN(n_0_2_96));
   AOI22_X1 i_0_2_137 (.A1(n_0_2_96), .A2(n_0_8), .B1(HCOL_stage_0_2), .B2(
      n_0_2_47), .ZN(vector[8]));
   NOR2_X1 i_0_2_54 (.A1(vector[8]), .A2(n_0_2_71), .ZN(n_0_37));
   DFFR_X1 \HCOL_x_sva_reg[8]  (.D(n_0_37), .RN(arst_n), .CK(n_0_0), .Q(n_0_8), 
      .QN());
   OAI22_X1 i_0_2_168 (.A1(n_0_2_102), .A2(n_0_8), .B1(n_0_2_60), .B2(
      HROW_y_sva[8]), .ZN(n_0_2_115));
   INV_X1 i_0_2_169 (.A(n_0_2_115), .ZN(MUX_v_10_2_24_return[8]));
   HA_X1 i_0_2_124 (.A(MUX_v_10_2_24_return[8]), .B(n_0_2_6), .CO(n_0_2_7), 
      .S(n_0_2_47));
   INV_X1 i_0_2_177 (.A(n_0_2_47), .ZN(n_0_2_130));
   AOI21_X1 i_0_2_23 (.A(n_0_2_130), .B1(n_0_2_83), .B2(n_0_2_84), .ZN(
      MUX_v_10_2_23_return[8]));
   DFF_X1 \HROW_y_sva_reg[8]  (.D(MUX_v_10_2_23_return[8]), .CK(n_0_1), .Q(
      HROW_y_sva[8]), .QN());
   NAND2_X1 i_0_2_202 (.A1(n_0_2_83), .A2(
      EdgeDetect_IP_EdgeDetect_HorDer_run_run_fsm_inst_state_var[1]), .ZN(
      operator_8_false_2_or_1_nl));
   OR2_X1 i_0_2_261 (.A1(operator_8_false_2_or_1_nl), .A2(heightIn[8]), .ZN(
      n_0_2_169));
   INV_X1 i_0_2_216 (.A(operator_8_false_2_or_1_nl), .ZN(sel));
   OAI21_X1 i_0_2_60 (.A(n_0_2_87), .B1(n_0_2_82), .B2(n_0_2_72), .ZN(n_0_45));
   HA_X1 i_0_2_0 (.A(vector[0]), .B(widthIn[0]), .CO(n_0_2_10), .S(n_0_2_9));
   FA_X1 i_0_2_1 (.A(vector[1]), .B(widthIn[1]), .CI(n_0_2_10), .CO(n_0_2_12), 
      .S(n_0_2_11));
   FA_X1 i_0_2_2 (.A(vector[2]), .B(widthIn[2]), .CI(n_0_2_12), .CO(n_0_2_14), 
      .S(n_0_2_13));
   FA_X1 i_0_2_3 (.A(vector[3]), .B(widthIn[3]), .CI(n_0_2_14), .CO(n_0_2_16), 
      .S(n_0_2_15));
   FA_X1 i_0_2_4 (.A(vector[4]), .B(widthIn[4]), .CI(n_0_2_16), .CO(n_0_2_18), 
      .S(n_0_2_17));
   FA_X1 i_0_2_5 (.A(vector[5]), .B(widthIn[5]), .CI(n_0_2_18), .CO(n_0_2_20), 
      .S(n_0_2_19));
   FA_X1 i_0_2_6 (.A(vector[6]), .B(widthIn[6]), .CI(n_0_2_20), .CO(n_0_2_22), 
      .S(n_0_2_21));
   FA_X1 i_0_2_7 (.A(vector[7]), .B(widthIn[7]), .CI(n_0_2_22), .CO(n_0_2_24), 
      .S(n_0_2_23));
   FA_X1 i_0_2_8 (.A(vector[8]), .B(widthIn[8]), .CI(n_0_2_24), .CO(n_0_2_26), 
      .S(n_0_2_25));
   FA_X1 i_0_2_9 (.A(vector[9]), .B(widthIn[9]), .CI(n_0_2_26), .CO(n_0_2_28), 
      .S(n_0_2_27));
   FA_X1 i_0_2_10 (.A(vector[10]), .B(widthIn[10]), .CI(n_0_2_28), .CO(n_0_2_30), 
      .S(n_0_2_29));
   NOR2_X1 i_0_2_59 (.A1(rst), .A2(n_0_2_30), .ZN(n_0_43));
   MUX2_X1 HCOL_if_slc_HCOL_acc_11_svs_1_reg_enable_mux_0 (.A(
      HCOL_if_slc_HCOL_acc_11_svs_1), .B(n_0_43), .S(n_0_45), .Z(n_0_5));
   DFFR_X1 HCOL_if_slc_HCOL_acc_11_svs_1_reg (.D(n_0_5), .RN(arst_n), .CK(clk), 
      .Q(HCOL_if_slc_HCOL_acc_11_svs_1), .QN());
   INV_X1 i_0_2_90 (.A(n_0_2_63), .ZN(n_0_2_62));
   NOR2_X1 i_0_2_89 (.A1(HCOL_if_slc_HCOL_acc_11_svs_1), .A2(n_0_2_62), .ZN(
      n_0_2_61));
   INV_X1 i_0_2_266 (.A(dat_in_rsc_dat[7]), .ZN(n_0_2_197));
   AOI21_X1 i_0_2_53 (.A(n_0_2_197), .B1(n_0_2_83), .B2(n_0_2_84), .ZN(
      MUX_v_8_2_211_return[7]));
   AOI21_X1 i_0_2_87 (.A(n_0_2_83), .B1(HCOL_stage_0_2), .B2(n_0_2_61), .ZN(
      n_0_2_59));
   NOR3_X1 i_0_2_86 (.A1(
      EdgeDetect_IP_EdgeDetect_HorDer_run_run_fsm_inst_state_var[1]), .A2(
      n_0_2_59), .A3(n_0_2_82), .ZN(n_0_18));
   CLKGATE_X1 clk_gate_pix0_lpi_3_reg (.CK(clk), .E(n_0_18), .GCK(n_0_2));
   DFF_X1 \pix0_lpi_3_reg[7]  (.D(MUX_v_8_2_211_return[7]), .CK(n_0_2), .Q(
      pix0_lpi_3[7]), .QN());
   INV_X1 i_0_2_229 (.A(n_0_2_61), .ZN(n_0_2_177));
   OAI221_X1 i_0_2_260 (.A(operator_8_false_2_or_1_nl), .B1(n_0_2_61), .B2(
      pix0_lpi_3[7]), .C1(n_0_2_177), .C2(dat_in_rsc_dat[7]), .ZN(n_0_2_150));
   NOR2_X1 i_0_2_257 (.A1(operator_8_false_2_or_1_nl), .A2(heightIn[7]), 
      .ZN(n_0_2_191));
   NAND4_X1 i_0_2_188 (.A1(n_0_7), .A2(HCOL_x_sva5), .A3(n_0_16), .A4(n_0_2_60), 
      .ZN(n_0_2_149));
   NAND4_X1 i_0_2_187 (.A1(MUX_v_10_2_24_return[3]), .A2(MUX_v_10_2_24_return[2]), 
      .A3(MUX_v_10_2_24_return[1]), .A4(MUX_v_10_2_24_return[4]), .ZN(n_0_2_148));
   NAND4_X1 i_0_2_189 (.A1(MUX_v_10_2_24_return[5]), .A2(MUX_v_10_2_24_return[6]), 
      .A3(MUX_v_10_2_24_return[7]), .A4(MUX_v_10_2_24_return[8]), .ZN(n_0_2_151));
   NOR3_X1 i_0_2_186 (.A1(n_0_2_149), .A2(n_0_2_148), .A3(n_0_2_151), .ZN(
      n_0_2_146));
   OAI21_X1 i_0_2_185 (.A(HCOL_stage_0_2), .B1(n_0_2_62), .B2(n_0_2_146), 
      .ZN(n_0_2_144));
   OR4_X1 i_0_2_184 (.A1(n_0_13), .A2(HCOL_x_sva5), .A3(n_0_12), .A4(n_0_9), 
      .ZN(n_0_2_142));
   NOR3_X1 i_0_2_183 (.A1(n_0_14), .A2(n_0_15), .A3(n_0_16), .ZN(n_0_2_140));
   NOR4_X1 i_0_2_182 (.A1(n_0_7), .A2(n_0_8), .A3(n_0_10), .A4(n_0_11), .ZN(
      n_0_2_138));
   NAND3_X1 i_0_2_181 (.A1(n_0_2_152), .A2(n_0_2_140), .A3(n_0_2_138), .ZN(
      n_0_2_136));
   OAI211_X1 i_0_2_180 (.A(n_0_2_144), .B(HCOL_stage_0_1), .C1(n_0_2_142), 
      .C2(n_0_2_136), .ZN(n_0_2_134));
   OAI21_X1 i_0_2_179 (.A(n_0_2_87), .B1(n_0_2_82), .B2(n_0_2_134), .ZN(n_0_42));
   NAND4_X1 i_0_2_144 (.A1(vector[9]), .A2(vector[6]), .A3(vector[7]), .A4(
      vector[2]), .ZN(n_0_2_98));
   NAND3_X1 i_0_2_145 (.A1(vector[8]), .A2(vector[3]), .A3(vector[1]), .ZN(
      n_0_2_99));
   NAND2_X1 i_0_2_146 (.A1(vector[5]), .A2(vector[4]), .ZN(n_0_2_100));
   NOR3_X1 i_0_2_147 (.A1(n_0_2_98), .A2(n_0_2_99), .A3(n_0_2_100), .ZN(
      n_0_2_101));
   AND3_X1 i_0_2_148 (.A1(vector[10]), .A2(n_0_2_101), .A3(n_0_2_87), .ZN(n_0_41));
   MUX2_X1 HCOL_nor_1_itm_1_reg_enable_mux_0 (.A(HCOL_nor_1_itm_1), .B(n_0_41), 
      .S(n_0_42), .Z(n_0_6));
   DFFR_X1 HCOL_nor_1_itm_1_reg (.D(n_0_6), .RN(arst_n), .CK(clk), .Q(
      HCOL_nor_1_itm_1), .QN());
   NAND2_X1 i_0_2_224 (.A1(n_0_16), .A2(HCOL_nor_1_itm_1), .ZN(n_0_2_173));
   INV_X1 i_0_2_226 (.A(n_0_2_173), .ZN(n_0_2_175));
   OR3_X1 i_0_2_13 (.A1(n_0_2_83), .A2(n_0_2_152), .A3(
      HCOL_if_slc_HCOL_acc_11_svs_1), .ZN(n_0_2_57));
   NAND2_X1 i_0_2_44 (.A1(n_0_2_57), .A2(pix0_lpi_3[7]), .ZN(n_0_2_56));
   OAI21_X1 i_0_2_43 (.A(n_0_2_56), .B1(n_0_2_57), .B2(n_0_2_197), .ZN(
      MUX_v_8_2_212_return[7]));
   CLKGATE_X1 clk_gate_pix_buf0_lpi_3_reg (.CK(clk), .E(n_0_17), .GCK(n_0_3));
   DFF_X1 \pix_buf0_lpi_3_reg[7]  (.D(MUX_v_8_2_212_return[7]), .CK(n_0_3), 
      .Q(pix_buf0_lpi_3[7]), .QN());
   NAND4_X1 i_0_2_84 (.A1(n_0_2_63), .A2(run_wen), .A3(HCOL_stage_0_2), .A4(
      HCOL_stage_0_1), .ZN(n_0_2_116));
   INV_X1 i_0_2_131 (.A(n_0_2_89), .ZN(n_0_2_90));
   NAND4_X1 i_0_2_82 (.A1(n_0_2_120), .A2(n_0_2_122), .A3(n_0_2_124), .A4(
      n_0_2_130), .ZN(n_0_2_112));
   NAND3_X1 i_0_2_83 (.A1(n_0_2_132), .A2(n_0_2_117), .A3(n_0_2_118), .ZN(
      n_0_2_113));
   NOR4_X1 i_0_2_81 (.A1(n_0_2_112), .A2(n_0_2_85), .A3(n_0_2_113), .A4(n_0_2_86), 
      .ZN(n_0_2_111));
   MUX2_X1 i_0_2_79 (.A(n_0_2_101), .B(n_0_2_111), .S(MUX_v_10_2_24_return[0]), 
      .Z(n_0_2_97));
   AOI21_X1 i_0_2_78 (.A(n_0_2_116), .B1(n_0_2_90), .B2(n_0_2_97), .ZN(n_0_63));
   CLKGATE_X1 clk_gate_pix_buf1_lpi_3_reg (.CK(clk), .E(n_0_63), .GCK(n_0_44));
   DFF_X1 \pix_buf1_lpi_3_reg[7]  (.D(pix_buf0_lpi_3[7]), .CK(n_0_44), .Q(
      pix_buf1_lpi_3[7]), .QN());
   OAI22_X1 i_0_2_258 (.A1(n_0_2_175), .A2(pix_buf1_lpi_3[7]), .B1(n_0_2_173), 
      .B2(pix0_lpi_3[7]), .ZN(n_0_2_192));
   AOI21_X1 i_0_2_259 (.A(n_0_2_191), .B1(n_0_2_192), .B2(
      operator_8_false_2_or_1_nl), .ZN(n_0_2_147));
   INV_X1 i_0_2_265 (.A(dat_in_rsc_dat[6]), .ZN(n_0_2_196));
   AOI21_X1 i_0_2_52 (.A(n_0_2_196), .B1(n_0_2_83), .B2(n_0_2_84), .ZN(
      MUX_v_8_2_211_return[6]));
   DFF_X1 \pix0_lpi_3_reg[6]  (.D(MUX_v_8_2_211_return[6]), .CK(n_0_2), .Q(
      pix0_lpi_3[6]), .QN());
   OAI221_X1 i_0_2_256 (.A(operator_8_false_2_or_1_nl), .B1(pix0_lpi_3[6]), 
      .B2(n_0_2_61), .C1(n_0_2_177), .C2(dat_in_rsc_dat[6]), .ZN(n_0_2_145));
   NOR2_X1 i_0_2_251 (.A1(operator_8_false_2_or_1_nl), .A2(heightIn[6]), 
      .ZN(n_0_2_189));
   NAND2_X1 i_0_2_42 (.A1(n_0_2_57), .A2(pix0_lpi_3[6]), .ZN(n_0_2_55));
   OAI21_X1 i_0_2_41 (.A(n_0_2_55), .B1(n_0_2_57), .B2(n_0_2_196), .ZN(
      MUX_v_8_2_212_return[6]));
   DFF_X1 \pix_buf0_lpi_3_reg[6]  (.D(MUX_v_8_2_212_return[6]), .CK(n_0_3), 
      .Q(pix_buf0_lpi_3[6]), .QN());
   DFF_X1 \pix_buf1_lpi_3_reg[6]  (.D(pix_buf0_lpi_3[6]), .CK(n_0_44), .Q(
      pix_buf1_lpi_3[6]), .QN());
   OAI22_X1 i_0_2_252 (.A1(n_0_2_175), .A2(pix_buf1_lpi_3[6]), .B1(n_0_2_173), 
      .B2(pix0_lpi_3[6]), .ZN(n_0_2_190));
   AOI21_X1 i_0_2_253 (.A(n_0_2_189), .B1(n_0_2_190), .B2(
      operator_8_false_2_or_1_nl), .ZN(n_0_2_143));
   INV_X1 i_0_2_264 (.A(dat_in_rsc_dat[5]), .ZN(n_0_2_195));
   AOI21_X1 i_0_2_51 (.A(n_0_2_195), .B1(n_0_2_83), .B2(n_0_2_84), .ZN(
      MUX_v_8_2_211_return[5]));
   DFF_X1 \pix0_lpi_3_reg[5]  (.D(MUX_v_8_2_211_return[5]), .CK(n_0_2), .Q(
      pix0_lpi_3[5]), .QN());
   OAI221_X1 i_0_2_250 (.A(operator_8_false_2_or_1_nl), .B1(pix0_lpi_3[5]), 
      .B2(n_0_2_61), .C1(n_0_2_177), .C2(dat_in_rsc_dat[5]), .ZN(n_0_2_141));
   NOR2_X1 i_0_2_247 (.A1(operator_8_false_2_or_1_nl), .A2(heightIn[5]), 
      .ZN(n_0_2_187));
   NAND2_X1 i_0_2_40 (.A1(n_0_2_57), .A2(pix0_lpi_3[5]), .ZN(n_0_2_54));
   OAI21_X1 i_0_2_39 (.A(n_0_2_54), .B1(n_0_2_57), .B2(n_0_2_195), .ZN(
      MUX_v_8_2_212_return[5]));
   DFF_X1 \pix_buf0_lpi_3_reg[5]  (.D(MUX_v_8_2_212_return[5]), .CK(n_0_3), 
      .Q(pix_buf0_lpi_3[5]), .QN());
   DFF_X1 \pix_buf1_lpi_3_reg[5]  (.D(pix_buf0_lpi_3[5]), .CK(n_0_44), .Q(
      pix_buf1_lpi_3[5]), .QN());
   OAI22_X1 i_0_2_248 (.A1(n_0_2_175), .A2(pix_buf1_lpi_3[5]), .B1(n_0_2_173), 
      .B2(pix0_lpi_3[5]), .ZN(n_0_2_188));
   AOI21_X1 i_0_2_249 (.A(n_0_2_187), .B1(n_0_2_188), .B2(
      operator_8_false_2_or_1_nl), .ZN(n_0_2_139));
   INV_X1 i_0_2_255 (.A(dat_in_rsc_dat[4]), .ZN(n_0_2_58));
   NAND2_X1 i_0_2_245 (.A1(n_0_2_58), .A2(n_0_2_61), .ZN(n_0_2_186));
   AOI21_X1 i_0_2_50 (.A(n_0_2_58), .B1(n_0_2_83), .B2(n_0_2_84), .ZN(
      MUX_v_8_2_211_return[4]));
   DFF_X1 \pix0_lpi_3_reg[4]  (.D(MUX_v_8_2_211_return[4]), .CK(n_0_2), .Q(
      pix0_lpi_3[4]), .QN());
   OAI211_X1 i_0_2_246 (.A(operator_8_false_2_or_1_nl), .B(n_0_2_186), .C1(
      pix0_lpi_3[4]), .C2(n_0_2_61), .ZN(n_0_2_137));
   NOR2_X1 i_0_2_242 (.A1(operator_8_false_2_or_1_nl), .A2(heightIn[4]), 
      .ZN(n_0_2_183));
   NAND2_X1 i_0_2_38 (.A1(n_0_2_57), .A2(pix0_lpi_3[4]), .ZN(n_0_2_53));
   OAI21_X1 i_0_2_37 (.A(n_0_2_53), .B1(n_0_2_57), .B2(n_0_2_58), .ZN(
      MUX_v_8_2_212_return[4]));
   DFF_X1 \pix_buf0_lpi_3_reg[4]  (.D(MUX_v_8_2_212_return[4]), .CK(n_0_3), 
      .Q(pix_buf0_lpi_3[4]), .QN());
   DFF_X1 \pix_buf1_lpi_3_reg[4]  (.D(pix_buf0_lpi_3[4]), .CK(n_0_44), .Q(
      pix_buf1_lpi_3[4]), .QN());
   OAI22_X1 i_0_2_243 (.A1(n_0_2_175), .A2(pix_buf1_lpi_3[4]), .B1(n_0_2_173), 
      .B2(pix0_lpi_3[4]), .ZN(n_0_2_184));
   AOI21_X1 i_0_2_244 (.A(n_0_2_183), .B1(n_0_2_184), .B2(
      operator_8_false_2_or_1_nl), .ZN(n_0_2_135));
   INV_X1 i_0_2_254 (.A(dat_in_rsc_dat[3]), .ZN(n_0_2_185));
   AOI21_X1 i_0_2_201 (.A(sel), .B1(n_0_2_61), .B2(n_0_2_185), .ZN(n_0_2_46));
   AOI21_X1 i_0_2_49 (.A(n_0_2_185), .B1(n_0_2_83), .B2(n_0_2_84), .ZN(
      MUX_v_8_2_211_return[3]));
   DFF_X1 \pix0_lpi_3_reg[3]  (.D(MUX_v_8_2_211_return[3]), .CK(n_0_2), .Q(
      pix0_lpi_3[3]), .QN());
   OAI21_X1 i_0_2_241 (.A(n_0_2_46), .B1(pix0_lpi_3[3]), .B2(n_0_2_61), .ZN(
      n_0_2_133));
   NAND2_X1 i_0_2_36 (.A1(n_0_2_57), .A2(pix0_lpi_3[3]), .ZN(n_0_2_52));
   OAI21_X1 i_0_2_35 (.A(n_0_2_52), .B1(n_0_2_57), .B2(n_0_2_185), .ZN(
      MUX_v_8_2_212_return[3]));
   DFF_X1 \pix_buf0_lpi_3_reg[3]  (.D(MUX_v_8_2_212_return[3]), .CK(n_0_3), 
      .Q(pix_buf0_lpi_3[3]), .QN());
   DFF_X1 \pix_buf1_lpi_3_reg[3]  (.D(pix_buf0_lpi_3[3]), .CK(n_0_44), .Q(
      pix_buf1_lpi_3[3]), .QN());
   MUX2_X1 i_0_2_199 (.A(pix0_lpi_3[3]), .B(pix_buf1_lpi_3[3]), .S(n_0_2_173), 
      .Z(n_0_2_45));
   OAI22_X1 i_0_2_239 (.A1(sel), .A2(n_0_2_45), .B1(operator_8_false_2_or_1_nl), 
      .B2(heightIn[3]), .ZN(n_0_2_182));
   INV_X1 i_0_2_240 (.A(n_0_2_182), .ZN(n_0_2_131));
   INV_X1 i_0_2_263 (.A(dat_in_rsc_dat[2]), .ZN(n_0_2_194));
   AOI21_X1 i_0_2_48 (.A(n_0_2_194), .B1(n_0_2_83), .B2(n_0_2_84), .ZN(
      MUX_v_8_2_211_return[2]));
   DFF_X1 \pix0_lpi_3_reg[2]  (.D(MUX_v_8_2_211_return[2]), .CK(n_0_2), .Q(
      pix0_lpi_3[2]), .QN());
   OAI221_X1 i_0_2_238 (.A(operator_8_false_2_or_1_nl), .B1(pix0_lpi_3[2]), 
      .B2(n_0_2_61), .C1(n_0_2_177), .C2(dat_in_rsc_dat[2]), .ZN(n_0_2_129));
   NOR2_X1 i_0_2_235 (.A1(operator_8_false_2_or_1_nl), .A2(heightIn[2]), 
      .ZN(n_0_2_180));
   NAND2_X1 i_0_2_34 (.A1(n_0_2_57), .A2(pix0_lpi_3[2]), .ZN(n_0_2_51));
   OAI21_X1 i_0_2_33 (.A(n_0_2_51), .B1(n_0_2_57), .B2(n_0_2_194), .ZN(
      MUX_v_8_2_212_return[2]));
   DFF_X1 \pix_buf0_lpi_3_reg[2]  (.D(MUX_v_8_2_212_return[2]), .CK(n_0_3), 
      .Q(pix_buf0_lpi_3[2]), .QN());
   DFF_X1 \pix_buf1_lpi_3_reg[2]  (.D(pix_buf0_lpi_3[2]), .CK(n_0_44), .Q(
      pix_buf1_lpi_3[2]), .QN());
   OAI22_X1 i_0_2_236 (.A1(n_0_2_175), .A2(pix_buf1_lpi_3[2]), .B1(n_0_2_173), 
      .B2(pix0_lpi_3[2]), .ZN(n_0_2_181));
   AOI21_X1 i_0_2_237 (.A(n_0_2_180), .B1(n_0_2_181), .B2(
      operator_8_false_2_or_1_nl), .ZN(n_0_2_127));
   INV_X1 i_0_2_262 (.A(dat_in_rsc_dat[1]), .ZN(n_0_2_193));
   AOI21_X1 i_0_2_47 (.A(n_0_2_193), .B1(n_0_2_83), .B2(n_0_2_84), .ZN(
      MUX_v_8_2_211_return[1]));
   DFF_X1 \pix0_lpi_3_reg[1]  (.D(MUX_v_8_2_211_return[1]), .CK(n_0_2), .Q(
      pix0_lpi_3[1]), .QN());
   OAI221_X1 i_0_2_234 (.A(operator_8_false_2_or_1_nl), .B1(pix0_lpi_3[1]), 
      .B2(n_0_2_61), .C1(n_0_2_177), .C2(dat_in_rsc_dat[1]), .ZN(n_0_2_125));
   NOR2_X1 i_0_2_231 (.A1(operator_8_false_2_or_1_nl), .A2(heightIn[1]), 
      .ZN(n_0_2_178));
   NAND2_X1 i_0_2_32 (.A1(n_0_2_57), .A2(pix0_lpi_3[1]), .ZN(n_0_2_50));
   OAI21_X1 i_0_2_31 (.A(n_0_2_50), .B1(n_0_2_57), .B2(n_0_2_193), .ZN(
      MUX_v_8_2_212_return[1]));
   DFF_X1 \pix_buf0_lpi_3_reg[1]  (.D(MUX_v_8_2_212_return[1]), .CK(n_0_3), 
      .Q(pix_buf0_lpi_3[1]), .QN());
   DFF_X1 \pix_buf1_lpi_3_reg[1]  (.D(pix_buf0_lpi_3[1]), .CK(n_0_44), .Q(
      pix_buf1_lpi_3[1]), .QN());
   OAI22_X1 i_0_2_232 (.A1(n_0_2_175), .A2(pix_buf1_lpi_3[1]), .B1(n_0_2_173), 
      .B2(pix0_lpi_3[1]), .ZN(n_0_2_179));
   AOI21_X1 i_0_2_233 (.A(n_0_2_178), .B1(n_0_2_179), .B2(
      operator_8_false_2_or_1_nl), .ZN(n_0_2_123));
   INV_X1 i_0_2_267 (.A(dat_in_rsc_dat[0]), .ZN(n_0_2_198));
   AOI21_X1 i_0_2_14 (.A(n_0_2_198), .B1(n_0_2_83), .B2(n_0_2_84), .ZN(
      MUX_v_8_2_211_return[0]));
   DFF_X1 \pix0_lpi_3_reg[0]  (.D(MUX_v_8_2_211_return[0]), .CK(n_0_2), .Q(
      pix0_lpi_3[0]), .QN());
   OAI221_X1 i_0_2_230 (.A(operator_8_false_2_or_1_nl), .B1(pix0_lpi_3[0]), 
      .B2(n_0_2_61), .C1(n_0_2_177), .C2(dat_in_rsc_dat[0]), .ZN(n_0_2_121));
   NOR2_X1 i_0_2_225 (.A1(operator_8_false_2_or_1_nl), .A2(heightIn[0]), 
      .ZN(n_0_2_174));
   NAND2_X1 i_0_2_12 (.A1(n_0_2_57), .A2(pix0_lpi_3[0]), .ZN(n_0_2_49));
   OAI21_X1 i_0_2_11 (.A(n_0_2_49), .B1(n_0_2_57), .B2(n_0_2_198), .ZN(
      MUX_v_8_2_212_return[0]));
   DFF_X1 \pix_buf0_lpi_3_reg[0]  (.D(MUX_v_8_2_212_return[0]), .CK(n_0_3), 
      .Q(pix_buf0_lpi_3[0]), .QN());
   DFF_X1 \pix_buf1_lpi_3_reg[0]  (.D(pix_buf0_lpi_3[0]), .CK(n_0_44), .Q(
      pix_buf1_lpi_3[0]), .QN());
   OAI22_X1 i_0_2_227 (.A1(n_0_2_175), .A2(pix_buf1_lpi_3[0]), .B1(n_0_2_173), 
      .B2(pix0_lpi_3[0]), .ZN(n_0_2_176));
   AOI21_X1 i_0_2_228 (.A(n_0_2_174), .B1(n_0_2_176), .B2(
      operator_8_false_2_or_1_nl), .ZN(n_0_2_119));
   FA_X1 i_0_2_191 (.A(n_0_2_121), .B(n_0_2_119), .CI(operator_8_false_2_or_1_nl), 
      .CO(n_0_2_31), .S(n_0_26));
   FA_X1 i_0_2_200 (.A(n_0_2_125), .B(n_0_2_123), .CI(n_0_2_31), .CO(n_0_2_32), 
      .S(n_0_27));
   FA_X1 i_0_2_192 (.A(n_0_2_129), .B(n_0_2_127), .CI(n_0_2_32), .CO(n_0_2_33), 
      .S(n_0_28));
   FA_X1 i_0_2_193 (.A(n_0_2_133), .B(n_0_2_131), .CI(n_0_2_33), .CO(n_0_2_34), 
      .S(n_0_29));
   FA_X1 i_0_2_194 (.A(n_0_2_137), .B(n_0_2_135), .CI(n_0_2_34), .CO(n_0_2_35), 
      .S(n_0_30));
   FA_X1 i_0_2_195 (.A(n_0_2_141), .B(n_0_2_139), .CI(n_0_2_35), .CO(n_0_2_36), 
      .S(n_0_31));
   FA_X1 i_0_2_196 (.A(n_0_2_145), .B(n_0_2_143), .CI(n_0_2_36), .CO(n_0_2_37), 
      .S(n_0_32));
   FA_X1 i_0_2_197 (.A(n_0_2_150), .B(n_0_2_147), .CI(n_0_2_37), .CO(n_0_2_38), 
      .S(n_0_33));
   FA_X1 i_0_2_198 (.A(n_0_2_169), .B(sel), .CI(n_0_2_38), .CO(n_0_2_39), 
      .S(n_0_34));
   XOR2_X1 i_0_2_203 (.A(HROW_y_sva[8]), .B(n_0_34), .Z(n_0_2_153));
   XOR2_X1 i_0_2_204 (.A(HROW_y_sva[6]), .B(n_0_32), .Z(n_0_2_154));
   XOR2_X1 i_0_2_205 (.A(HROW_y_sva[7]), .B(n_0_33), .Z(n_0_2_155));
   XOR2_X1 i_0_2_206 (.A(HROW_y_sva[5]), .B(n_0_31), .Z(n_0_2_156));
   NOR4_X1 i_0_2_207 (.A1(n_0_2_153), .A2(n_0_2_154), .A3(n_0_2_155), .A4(
      n_0_2_156), .ZN(n_0_2_157));
   INV_X1 i_0_2_208 (.A(n_0_27), .ZN(n_0_2_158));
   INV_X1 i_0_2_209 (.A(HROW_y_sva[1]), .ZN(n_0_2_159));
   OAI221_X1 i_0_2_210 (.A(n_0_2_157), .B1(n_0_2_158), .B2(HROW_y_sva[1]), 
      .C1(n_0_27), .C2(n_0_2_159), .ZN(n_0_2_160));
   XNOR2_X1 i_0_2_211 (.A(HROW_y_sva[3]), .B(n_0_29), .ZN(n_0_2_161));
   XNOR2_X1 i_0_2_212 (.A(HROW_y_sva[2]), .B(n_0_28), .ZN(n_0_2_162));
   XNOR2_X1 i_0_2_213 (.A(HROW_y_sva[4]), .B(n_0_30), .ZN(n_0_2_163));
   NAND3_X1 i_0_2_214 (.A1(n_0_2_161), .A2(n_0_2_162), .A3(n_0_2_163), .ZN(
      n_0_2_164));
   NOR2_X1 i_0_2_215 (.A1(n_0_2_160), .A2(n_0_2_164), .ZN(n_0_2_165));
   AOI21_X1 i_0_2_15 (.A(MUX_v_10_2_24_return[0]), .B1(n_0_2_83), .B2(n_0_2_84), 
      .ZN(MUX_v_10_2_23_return[0]));
   DFF_X1 \HROW_y_sva_reg[0]  (.D(MUX_v_10_2_23_return[0]), .CK(n_0_1), .Q(
      HROW_y_sva[0]), .QN());
   XNOR2_X1 i_0_2_217 (.A(HROW_y_sva[0]), .B(n_0_26), .ZN(n_0_2_166));
   XNOR2_X1 i_0_2_218 (.A(HROW_y_sva[9]), .B(n_0_2_39), .ZN(n_0_2_167));
   XNOR2_X1 i_0_2_219 (.A(n_0_2_167), .B(heightIn[9]), .ZN(n_0_2_168));
   NAND4_X1 i_0_2_220 (.A1(n_0_2_165), .A2(sel), .A3(n_0_2_166), .A4(n_0_2_168), 
      .ZN(n_0_2_170));
   INV_X1 i_0_2_221 (.A(HCOL_stage_0_1), .ZN(n_0_2_171));
   NAND3_X1 i_0_2_222 (.A1(n_0_2_171), .A2(n_0_2_152), .A3(n_0_2_60), .ZN(
      n_0_2_172));
   AOI21_X1 i_0_2_223 (.A(rst), .B1(n_0_2_170), .B2(n_0_2_172), .ZN(
      EdgeDetect_IP_EdgeDetect_HorDer_run_run_fsm_inst_n_3));
   DFFR_X1 \EdgeDetect_IP_EdgeDetect_HorDer_run_run_fsm_inst_state_var_reg[1]  (
      .D(EdgeDetect_IP_EdgeDetect_HorDer_run_run_fsm_inst_n_3), .RN(arst_n), 
      .CK(n_0_4), .Q(
      EdgeDetect_IP_EdgeDetect_HorDer_run_run_fsm_inst_state_var[1]), .QN());
   NOR2_X1 i_0_2_88 (.A1(
      EdgeDetect_IP_EdgeDetect_HorDer_run_run_fsm_inst_state_var[1]), .A2(
      n_0_2_83), .ZN(n_0_2_60));
   INV_X1 i_0_2_149 (.A(n_0_2_60), .ZN(n_0_2_102));
   OAI22_X1 i_0_2_152 (.A1(n_0_2_102), .A2(n_0_16), .B1(HROW_y_sva[0]), .B2(
      n_0_2_60), .ZN(n_0_2_104));
   INV_X1 i_0_2_153 (.A(n_0_2_104), .ZN(MUX_v_10_2_24_return[0]));
   NAND2_X1 i_0_2_69 (.A1(MUX_v_10_2_24_return[0]), .A2(HCOL_stage_0_2), 
      .ZN(n_0_2_73));
   OAI21_X1 i_0_2_68 (.A(n_0_2_73), .B1(HCOL_stage_0_2), .B2(n_0_16), .ZN(
      vector[0]));
   NOR2_X1 i_0_2_62 (.A1(vector[0]), .A2(rst), .ZN(n_0_47));
   DFFR_X1 \HCOL_asn_1_itm_1_reg[0]  (.D(n_0_47), .RN(arst_n), .CK(n_0_4), 
      .Q(HCOL_asn_1_itm_1[0]), .QN());
   NOR2_X1 i_0_2_98 (.A1(vector[1]), .A2(rst), .ZN(n_0_49));
   DFFR_X1 \HCOL_asn_1_itm_1_reg[1]  (.D(n_0_49), .RN(arst_n), .CK(n_0_4), 
      .Q(HCOL_asn_1_itm_1[1]), .QN());
   NOR2_X1 i_0_2_99 (.A1(vector[2]), .A2(rst), .ZN(n_0_50));
   DFFR_X1 \HCOL_asn_1_itm_1_reg[2]  (.D(n_0_50), .RN(arst_n), .CK(n_0_4), 
      .Q(HCOL_asn_1_itm_1[2]), .QN());
   NOR3_X1 i_0_2_77 (.A1(HCOL_asn_1_itm_1[0]), .A2(HCOL_asn_1_itm_1[1]), 
      .A3(HCOL_asn_1_itm_1[2]), .ZN(n_0_2_95));
   NOR2_X1 i_0_2_105 (.A1(vector[8]), .A2(rst), .ZN(n_0_56));
   DFFR_X1 \HCOL_asn_1_itm_1_reg[8]  (.D(n_0_56), .RN(arst_n), .CK(n_0_4), 
      .Q(HCOL_asn_1_itm_1[8]), .QN());
   NOR2_X1 i_0_2_106 (.A1(vector[9]), .A2(rst), .ZN(n_0_57));
   DFFR_X1 \HCOL_asn_1_itm_1_reg[9]  (.D(n_0_57), .RN(arst_n), .CK(n_0_4), 
      .Q(HCOL_asn_1_itm_1[9]), .QN());
   NOR2_X1 i_0_2_100 (.A1(vector[3]), .A2(rst), .ZN(n_0_51));
   DFFR_X1 \HCOL_asn_1_itm_1_reg[3]  (.D(n_0_51), .RN(arst_n), .CK(n_0_4), 
      .Q(HCOL_asn_1_itm_1[3]), .QN());
   NOR2_X1 i_0_2_103 (.A1(vector[6]), .A2(rst), .ZN(n_0_54));
   DFFR_X1 \HCOL_asn_1_itm_1_reg[6]  (.D(n_0_54), .RN(arst_n), .CK(n_0_4), 
      .Q(HCOL_asn_1_itm_1[6]), .QN());
   NOR4_X1 i_0_2_76 (.A1(HCOL_asn_1_itm_1[8]), .A2(HCOL_asn_1_itm_1[9]), 
      .A3(HCOL_asn_1_itm_1[3]), .A4(HCOL_asn_1_itm_1[6]), .ZN(n_0_2_94));
   NOR2_X1 i_0_2_104 (.A1(vector[7]), .A2(rst), .ZN(n_0_55));
   DFFR_X1 \HCOL_asn_1_itm_1_reg[7]  (.D(n_0_55), .RN(arst_n), .CK(n_0_4), 
      .Q(HCOL_asn_1_itm_1[7]), .QN());
   NOR2_X1 i_0_2_107 (.A1(vector[10]), .A2(rst), .ZN(n_0_58));
   DFFR_X1 \HCOL_asn_1_itm_1_reg[10]  (.D(n_0_58), .RN(arst_n), .CK(n_0_4), 
      .Q(HCOL_asn_1_itm_1[10]), .QN());
   NOR2_X1 i_0_2_101 (.A1(vector[4]), .A2(rst), .ZN(n_0_52));
   DFFR_X1 \HCOL_asn_1_itm_1_reg[4]  (.D(n_0_52), .RN(arst_n), .CK(n_0_4), 
      .Q(HCOL_asn_1_itm_1[4]), .QN());
   NOR2_X1 i_0_2_102 (.A1(vector[5]), .A2(rst), .ZN(n_0_53));
   DFFR_X1 \HCOL_asn_1_itm_1_reg[5]  (.D(n_0_53), .RN(arst_n), .CK(n_0_4), 
      .Q(HCOL_asn_1_itm_1[5]), .QN());
   NOR4_X1 i_0_2_75 (.A1(HCOL_asn_1_itm_1[7]), .A2(HCOL_asn_1_itm_1[10]), 
      .A3(HCOL_asn_1_itm_1[4]), .A4(HCOL_asn_1_itm_1[5]), .ZN(n_0_2_93));
   NAND3_X1 i_0_2_74 (.A1(n_0_2_95), .A2(n_0_2_94), .A3(n_0_2_93), .ZN(n_0_2_92));
   NAND3_X1 i_0_2_73 (.A1(n_0_2_92), .A2(n_0_2_60), .A3(HCOL_stage_0_2), 
      .ZN(n_0_2_91));
   NOR2_X1 i_0_2_61 (.A1(n_0_2_91), .A2(rst), .ZN(n_0_46));
   DFFR_X1 reg_dx_rsci_oswt_cse_reg (.D(n_0_46), .RN(arst_n), .CK(n_0_4), 
      .Q(reg_dx_rsci_oswt_cse), .QN());
   EdgeDetect_IP_EdgeDetect_HorDer_run_dx_rsci EdgeDetect_IP_EdgeDetect_HorDer_run_dx_rsci_inst (
      .clk(clk), .rst(rst), .arst_n(arst_n), .dx_rsc_dat(), .dx_rsc_vld(
      dx_rsc_vld), .dx_rsc_rdy(dx_rsc_rdy), .run_wen(run_wen), .dx_rsci_oswt(
      reg_dx_rsci_oswt_cse), .dx_rsci_wen_comp(dx_rsci_wen_comp), .dx_rsci_idat());
   NAND2_X1 i_0_2_116 (.A1(dat_in_rsci_wen_comp), .A2(dx_rsci_wen_comp), 
      .ZN(n_0_2_82));
   INV_X1 i_0_2_85 (.A(n_0_2_82), .ZN(run_wen));
   AND3_X1 i_0_2_64 (.A1(n_0_59), .A2(n_0_2_84), .A3(n_0_2_30), .ZN(n_0_61));
   DFFR_X1 reg_dat_in_rsci_oswt_cse_reg (.D(n_0_61), .RN(arst_n), .CK(n_0_4), 
      .Q(reg_dat_in_rsci_oswt_cse), .QN());
   EdgeDetect_IP_EdgeDetect_HorDer_run_dat_in_rsci EdgeDetect_IP_EdgeDetect_HorDer_run_dat_in_rsci_inst (
      .dat_in_rsc_dat(), .dat_in_rsc_vld(dat_in_rsc_vld), .dat_in_rsc_rdy(
      dat_in_rsc_rdy), .run_wen(run_wen), .dat_in_rsci_oswt(
      reg_dat_in_rsci_oswt_cse), .dat_in_rsci_wen_comp(dat_in_rsci_wen_comp), 
      .dat_in_rsci_idat_mxwt());
   NOR2_X1 i_0_2_72 (.A1(n_0_2_82), .A2(n_0_2_91), .ZN(n_0_62));
   CLKGATE_X1 clk_gate_dx_rsci_idat_reg (.CK(clk), .E(n_0_62), .GCK(n_0_48));
   DFF_X1 \dx_rsci_idat_reg[8]  (.D(n_0_34), .CK(n_0_48), .Q(dx_rsc_dat[8]), 
      .QN());
   DFF_X1 \dx_rsci_idat_reg[7]  (.D(n_0_33), .CK(n_0_48), .Q(dx_rsc_dat[7]), 
      .QN());
   DFF_X1 \dx_rsci_idat_reg[6]  (.D(n_0_32), .CK(n_0_48), .Q(dx_rsc_dat[6]), 
      .QN());
   DFF_X1 \dx_rsci_idat_reg[5]  (.D(n_0_31), .CK(n_0_48), .Q(dx_rsc_dat[5]), 
      .QN());
   DFF_X1 \dx_rsci_idat_reg[4]  (.D(n_0_30), .CK(n_0_48), .Q(dx_rsc_dat[4]), 
      .QN());
   DFF_X1 \dx_rsci_idat_reg[3]  (.D(n_0_29), .CK(n_0_48), .Q(dx_rsc_dat[3]), 
      .QN());
   DFF_X1 \dx_rsci_idat_reg[2]  (.D(n_0_28), .CK(n_0_48), .Q(dx_rsc_dat[2]), 
      .QN());
   DFF_X1 \dx_rsci_idat_reg[1]  (.D(n_0_27), .CK(n_0_48), .Q(dx_rsc_dat[1]), 
      .QN());
   DFF_X1 \dx_rsci_idat_reg[0]  (.D(n_0_26), .CK(n_0_48), .Q(dx_rsc_dat[0]), 
      .QN());
endmodule

module EdgeDetect_IP_EdgeDetect_HorDer(clk, rst, arst_n, dat_in_rsc_dat, 
      dat_in_rsc_vld, dat_in_rsc_rdy, widthIn, heightIn, dx_rsc_dat, dx_rsc_vld, 
      dx_rsc_rdy);
   input clk;
   input rst;
   input arst_n;
   input [7:0]dat_in_rsc_dat;
   input dat_in_rsc_vld;
   output dat_in_rsc_rdy;
   input [10:0]widthIn;
   input [9:0]heightIn;
   output [8:0]dx_rsc_dat;
   output dx_rsc_vld;
   input dx_rsc_rdy;

   EdgeDetect_IP_EdgeDetect_HorDer_run EdgeDetect_IP_EdgeDetect_HorDer_run_inst (
      .clk(clk), .rst(rst), .arst_n(arst_n), .dat_in_rsc_dat(dat_in_rsc_dat), 
      .dat_in_rsc_vld(dat_in_rsc_vld), .dat_in_rsc_rdy(dat_in_rsc_rdy), .widthIn(
      widthIn), .heightIn(heightIn), .dx_rsc_dat(dx_rsc_dat), .dx_rsc_vld(
      dx_rsc_vld), .dx_rsc_rdy(dx_rsc_rdy));
endmodule

module EdgeDetect_IP_EdgeDetect_VerDer_run_dy_rsci(clk, rst, arst_n, dy_rsc_dat, 
      dy_rsc_vld, dy_rsc_rdy, run_wen, dy_rsci_oswt, dy_rsci_wen_comp, 
      dy_rsci_idat);
   input clk;
   input rst;
   input arst_n;
   output [8:0]dy_rsc_dat;
   output dy_rsc_vld;
   input dy_rsc_rdy;
   input run_wen;
   input dy_rsci_oswt;
   output dy_rsci_wen_comp;
   input [8:0]dy_rsci_idat;

   wire dy_rsci_bcwt;
   wire EdgeDetect_IP_EdgeDetect_VerDer_run_dy_rsci_dy_wait_dp_inst_n_1;
   wire n_0_0_0;
   wire n_0_0_1;
   wire n_0_0_2;

   INV_X1 i_0_0_5 (.A(dy_rsci_oswt), .ZN(n_0_0_2));
   AOI21_X1 i_0_0_1 (.A(dy_rsci_bcwt), .B1(dy_rsci_oswt), .B2(dy_rsc_rdy), 
      .ZN(n_0_0_0));
   AOI211_X1 i_0_0_0 (.A(rst), .B(n_0_0_0), .C1(dy_rsci_oswt), .C2(run_wen), 
      .ZN(EdgeDetect_IP_EdgeDetect_VerDer_run_dy_rsci_dy_wait_dp_inst_n_1));
   DFFR_X1 EdgeDetect_IP_EdgeDetect_VerDer_run_dy_rsci_dy_wait_dp_inst_dy_rsci_bcwt_reg (
      .D(EdgeDetect_IP_EdgeDetect_VerDer_run_dy_rsci_dy_wait_dp_inst_n_1), 
      .RN(arst_n), .CK(clk), .Q(dy_rsci_bcwt), .QN());
   NOR2_X1 i_0_0_3 (.A1(n_0_0_2), .A2(dy_rsci_bcwt), .ZN(dy_rsc_vld));
   INV_X1 i_0_0_4 (.A(dy_rsc_rdy), .ZN(n_0_0_1));
   NAND2_X1 i_0_0_2 (.A1(dy_rsc_vld), .A2(n_0_0_1), .ZN(dy_rsci_wen_comp));
endmodule

module EdgeDetect_IP_EdgeDetect_VerDer_run_dat_rgb_rsci(clk, rst, arst_n, 
      dat_rgb_rsc_dat, dat_rgb_rsc_vld, dat_rgb_rsc_rdy, run_wen, 
      dat_rgb_rsci_oswt, dat_rgb_rsci_wen_comp, dat_rgb_rsci_idat);
   input clk;
   input rst;
   input arst_n;
   output [33:0]dat_rgb_rsc_dat;
   output dat_rgb_rsc_vld;
   input dat_rgb_rsc_rdy;
   input run_wen;
   input dat_rgb_rsci_oswt;
   output dat_rgb_rsci_wen_comp;
   input [33:0]dat_rgb_rsci_idat;

   wire dat_rgb_rsci_bcwt;
   wire EdgeDetect_IP_EdgeDetect_VerDer_run_dat_rgb_rsci_dat_rgb_wait_dp_inst_n_1;
   wire n_0_0_0;
   wire n_0_0_1;
   wire n_0_0_2;

   INV_X1 i_0_0_5 (.A(dat_rgb_rsci_oswt), .ZN(n_0_0_2));
   AOI21_X1 i_0_0_1 (.A(dat_rgb_rsci_bcwt), .B1(dat_rgb_rsci_oswt), .B2(
      dat_rgb_rsc_rdy), .ZN(n_0_0_0));
   AOI211_X1 i_0_0_0 (.A(rst), .B(n_0_0_0), .C1(dat_rgb_rsci_oswt), .C2(run_wen), 
      .ZN(
      EdgeDetect_IP_EdgeDetect_VerDer_run_dat_rgb_rsci_dat_rgb_wait_dp_inst_n_1));
   DFFR_X1 EdgeDetect_IP_EdgeDetect_VerDer_run_dat_rgb_rsci_dat_rgb_wait_dp_inst_dat_rgb_rsci_bcwt_reg (
      .D(
      EdgeDetect_IP_EdgeDetect_VerDer_run_dat_rgb_rsci_dat_rgb_wait_dp_inst_n_1), 
      .RN(arst_n), .CK(clk), .Q(dat_rgb_rsci_bcwt), .QN());
   NOR2_X1 i_0_0_3 (.A1(n_0_0_2), .A2(dat_rgb_rsci_bcwt), .ZN(dat_rgb_rsc_vld));
   INV_X1 i_0_0_4 (.A(dat_rgb_rsc_rdy), .ZN(n_0_0_1));
   NAND2_X1 i_0_0_2 (.A1(dat_rgb_rsc_vld), .A2(n_0_0_1), .ZN(
      dat_rgb_rsci_wen_comp));
endmodule

module EdgeDetect_IP_EdgeDetect_VerDer_run_dat_out_rsci(clk, rst, arst_n, 
      dat_out_rsc_dat, dat_out_rsc_vld, dat_out_rsc_rdy, run_wen, 
      dat_out_rsci_oswt, dat_out_rsci_wen_comp, dat_out_rsci_idat);
   input clk;
   input rst;
   input arst_n;
   output [7:0]dat_out_rsc_dat;
   output dat_out_rsc_vld;
   input dat_out_rsc_rdy;
   input run_wen;
   input dat_out_rsci_oswt;
   output dat_out_rsci_wen_comp;
   input [7:0]dat_out_rsci_idat;

   wire dat_out_rsci_bcwt;
   wire EdgeDetect_IP_EdgeDetect_VerDer_run_dat_out_rsci_dat_out_wait_dp_inst_n_1;
   wire n_0_0_0;
   wire n_0_0_1;
   wire n_0_0_2;

   INV_X1 i_0_0_5 (.A(dat_out_rsci_oswt), .ZN(n_0_0_2));
   AOI21_X1 i_0_0_1 (.A(dat_out_rsci_bcwt), .B1(dat_out_rsci_oswt), .B2(
      dat_out_rsc_rdy), .ZN(n_0_0_0));
   AOI211_X1 i_0_0_0 (.A(rst), .B(n_0_0_0), .C1(dat_out_rsci_oswt), .C2(run_wen), 
      .ZN(
      EdgeDetect_IP_EdgeDetect_VerDer_run_dat_out_rsci_dat_out_wait_dp_inst_n_1));
   DFFR_X1 EdgeDetect_IP_EdgeDetect_VerDer_run_dat_out_rsci_dat_out_wait_dp_inst_dat_out_rsci_bcwt_reg (
      .D(
      EdgeDetect_IP_EdgeDetect_VerDer_run_dat_out_rsci_dat_out_wait_dp_inst_n_1), 
      .RN(arst_n), .CK(clk), .Q(dat_out_rsci_bcwt), .QN());
   NOR2_X1 i_0_0_3 (.A1(n_0_0_2), .A2(dat_out_rsci_bcwt), .ZN(dat_out_rsc_vld));
   INV_X1 i_0_0_4 (.A(dat_out_rsc_rdy), .ZN(n_0_0_1));
   NAND2_X1 i_0_0_2 (.A1(dat_out_rsc_vld), .A2(n_0_0_1), .ZN(
      dat_out_rsci_wen_comp));
endmodule

module EdgeDetect_IP_EdgeDetect_VerDer_run_dat_in_rsci(dat_in_rsc_dat, 
      dat_in_rsc_vld, dat_in_rsc_rdy, run_wen, dat_in_rsci_oswt, 
      dat_in_rsci_wen_comp, dat_in_rsci_idat_mxwt);
   input [33:0]dat_in_rsc_dat;
   input dat_in_rsc_vld;
   output dat_in_rsc_rdy;
   input run_wen;
   input dat_in_rsci_oswt;
   output dat_in_rsci_wen_comp;
   output [23:0]dat_in_rsci_idat_mxwt;

   wire n_0_0_0;

   AND2_X1 i_0_0_0 (.A1(dat_in_rsci_oswt), .A2(run_wen), .ZN(dat_in_rsc_rdy));
   INV_X1 i_0_0_1 (.A(dat_in_rsc_vld), .ZN(n_0_0_0));
   NAND2_X1 i_0_0_2 (.A1(n_0_0_0), .A2(dat_in_rsci_oswt), .ZN(
      dat_in_rsci_wen_comp));
endmodule

module EdgeDetect_IP_EdgeDetect_VerDer_run(clk, rst, arst_n, dat_in_rsc_dat, 
      dat_in_rsc_vld, dat_in_rsc_rdy, widthIn, heightIn, dat_out_rsc_dat, 
      dat_out_rsc_vld, dat_out_rsc_rdy, dat_rgb_rsc_dat, dat_rgb_rsc_vld, 
      dat_rgb_rsc_rdy, dy_rsc_dat, dy_rsc_vld, dy_rsc_rdy, 
      line_buf0_r_pixelType_rsci_d_d, line_buf0_r_pixelType_rsci_en_d, 
      line_buf0_r_pixelType_rsci_q_d, line_buf0_g_pixelType_rsci_d_d, 
      line_buf0_g_pixelType_rsci_q_d, line_buf0_b_pixelType_rsci_d_d, 
      line_buf0_b_pixelType_rsci_q_d, line_buf1_r_pixelType_rsci_d_d, 
      line_buf1_r_pixelType_rsci_q_d, line_buf1_g_pixelType_rsci_d_d, 
      line_buf1_g_pixelType_rsci_q_d, line_buf1_b_pixelType_rsci_d_d, 
      line_buf1_b_pixelType_rsci_q_d, line_buf0_r_pixelType_rsci_adr_d_pff, 
      line_buf0_r_pixelType_rsci_we_d_pff, 
      line_buf0_r_pixelType_rsci_port_0_rw_ram_ir_internal_RMASK_B_d_pff);
   input clk;
   input rst;
   input arst_n;
   input [33:0]dat_in_rsc_dat;
   input dat_in_rsc_vld;
   output dat_in_rsc_rdy;
   input [10:0]widthIn;
   input [9:0]heightIn;
   output [7:0]dat_out_rsc_dat;
   output dat_out_rsc_vld;
   input dat_out_rsc_rdy;
   output [33:0]dat_rgb_rsc_dat;
   output dat_rgb_rsc_vld;
   input dat_rgb_rsc_rdy;
   output [8:0]dy_rsc_dat;
   output dy_rsc_vld;
   input dy_rsc_rdy;
   output [15:0]line_buf0_r_pixelType_rsci_d_d;
   output line_buf0_r_pixelType_rsci_en_d;
   input [15:0]line_buf0_r_pixelType_rsci_q_d;
   output [15:0]line_buf0_g_pixelType_rsci_d_d;
   input [15:0]line_buf0_g_pixelType_rsci_q_d;
   output [15:0]line_buf0_b_pixelType_rsci_d_d;
   input [15:0]line_buf0_b_pixelType_rsci_q_d;
   output [11:0]line_buf1_r_pixelType_rsci_d_d;
   input [11:0]line_buf1_r_pixelType_rsci_q_d;
   output [11:0]line_buf1_g_pixelType_rsci_d_d;
   input [11:0]line_buf1_g_pixelType_rsci_q_d;
   output [11:0]line_buf1_b_pixelType_rsci_d_d;
   input [11:0]line_buf1_b_pixelType_rsci_q_d;
   output [9:0]line_buf0_r_pixelType_rsci_adr_d_pff;
   output line_buf0_r_pixelType_rsci_we_d_pff;
   output line_buf0_r_pixelType_rsci_port_0_rw_ram_ir_internal_RMASK_B_d_pff;

   wire dat_out_rsci_wen_comp;
   wire dat_rgb_rsci_wen_comp;
   wire dy_rsci_wen_comp;
   wire dat_in_rsci_wen_comp;
   wire [1:0]EdgeDetect_IP_EdgeDetect_VerDer_run_run_fsm_inst_state_var;
   wire operator_11_false_operator_11_false_slc_VCOL_x_0_2_itm_1;
   wire VCOL_if_slc_operator_10_false_acc_10_svs_1;
   wire [9:0]VCOL_asn_12_itm_1;
   wire VCOL_asn_24_itm_1;
   wire [9:0]VCOL_asn_12_itm_2;
   wire reg_line_buf0_r_pixelType_rsci_cgo_cse;
   wire reg_dat_in_rsci_oswt_cse;
   wire reg_dat_out_rsci_oswt_cse;
   wire [9:0]VCOL_asn_12_itm;
   wire VCOL_stage_0_3;
   wire VCOL_stage_0_2;
   wire VCOL_stage_0_1;
   wire reg_operator_11_false_operator_11_false_slc_VCOL_x_0_9_itm_1_cse;
   wire n_0_11;
   wire [15:0]rdbuf0_pix_g_pixelType_lpi_3_reg;
   wire [15:0]rdbuf0_pix_r_pixelType_lpi_3_reg;
   wire [15:0]rdbuf0_pix_b_pixelType_lpi_3_reg;
   wire n_0_0;
   wire [7:0]pix0_g_pixelType_lpi_3_dfm;
   wire [7:0]pix0_r_pixelType_lpi_3_dfm;
   wire [7:0]pix0_b_pixelType_lpi_3_dfm;
   wire n_0_1;
   wire n_0_2;
   wire VCOL_nor_1_itm_1;
   wire n_0_12;
   wire [11:0]VCOL_if_2_read_mem_line_buf1_b_pixelType_rsc_cse_lpi_3;
   wire [5:0]VCOL_if_2_read_mem_line_buf1_r_pixelType_rsc_cse_lpi_3_11_6;
   wire [11:0]VCOL_if_2_read_mem_line_buf1_g_pixelType_rsc_cse_lpi_3;
   wire n_0_3;
   wire VCOL_nor_1_itm_2;
   wire n_0_13;
   wire n_0_4;
   wire [9:0]VROW_y_sva;
   wire n_0_5;
   wire [10:0]VCOL_x_sva;
   wire [7:0]pix0_g_pixelType_lpi_3;
   wire [7:0]pix0_r_pixelType_lpi_3;
   wire [7:0]pix0_b_pixelType_lpi_3;
   wire n_0_6;
   wire n_0_7;
   wire n_0_8;
   wire n_0_9;
   wire n_0_10;
   wire n_0_3_103;
   wire n_0_3_0;
   wire n_0_3_104;
   wire n_0_3_1;
   wire n_0_3_105;
   wire n_0_3_2;
   wire n_0_3_106;
   wire n_0_3_3;
   wire n_0_3_107;
   wire n_0_3_4;
   wire n_0_3_108;
   wire n_0_3_5;
   wire n_0_3_109;
   wire n_0_3_6;
   wire n_0_3_110;
   wire n_0_3_7;
   wire n_0_3_111;
   wire n_0_3_8;
   wire n_0_3_9;
   wire n_0_3_10;
   wire n_0_3_11;
   wire n_0_3_12;
   wire n_0_3_13;
   wire n_0_3_14;
   wire n_0_3_15;
   wire n_0_3_16;
   wire n_0_3_17;
   wire n_0_3_18;
   wire n_0_3_19;
   wire n_0_3_20;
   wire n_0_3_21;
   wire n_0_3_22;
   wire n_0_3_23;
   wire n_0_3_24;
   wire n_0_3_25;
   wire n_0_3_26;
   wire n_0_3_27;
   wire n_0_3_28;
   wire n_0_3_29;
   wire n_0_3_30;
   wire n_0_3_31;
   wire n_0_3_32;
   wire n_0_3_33;
   wire n_0_3_34;
   wire n_0_76;
   wire n_0_3_35;
   wire n_0_3_36;
   wire n_0_3_37;
   wire n_0_3_38;
   wire n_0_3_39;
   wire n_0_3_40;
   wire n_0_3_41;
   wire n_0_3_42;
   wire n_0_3_43;
   wire n_0_3_44;
   wire n_0_3_45;
   wire n_0_3_46;
   wire n_0_3_47;
   wire n_0_3_48;
   wire n_0_3_49;
   wire n_0_3_50;
   wire n_0_3_51;
   wire n_0_3_52;
   wire n_0_3_53;
   wire n_0_3_54;
   wire n_0_3_55;
   wire n_0_3_56;
   wire n_0_3_57;
   wire n_0_3_58;
   wire n_0_3_59;
   wire n_0_3_60;
   wire n_0_3_61;
   wire n_0_3_62;
   wire n_0_3_63;
   wire n_0_3_64;
   wire n_0_3_65;
   wire n_0_3_66;
   wire n_0_3_67;
   wire n_0_3_68;
   wire n_0_3_69;
   wire n_0_3_70;
   wire n_0_3_71;
   wire n_0_3_72;
   wire n_0_3_73;
   wire n_0_3_74;
   wire n_0_3_75;
   wire n_0_3_76;
   wire n_0_3_77;
   wire n_0_77;
   wire n_0_3_78;
   wire n_0_78;
   wire n_0_3_79;
   wire n_0_79;
   wire n_0_3_80;
   wire n_0_80;
   wire n_0_3_81;
   wire n_0_81;
   wire n_0_3_82;
   wire n_0_82;
   wire n_0_3_83;
   wire n_0_83;
   wire n_0_3_84;
   wire n_0_85;
   wire n_0_3_85;
   wire n_0_3_86;
   wire n_0_3_87;
   wire n_0_3_88;
   wire n_0_3_89;
   wire n_0_3_90;
   wire n_0_3_91;
   wire n_0_3_92;
   wire n_0_3_93;
   wire n_0_3_94;
   wire n_0_3_95;
   wire n_0_86;
   wire n_0_3_96;
   wire n_0_87;
   wire n_0_3_97;
   wire n_0_88;
   wire n_0_3_98;
   wire n_0_89;
   wire n_0_3_99;
   wire n_0_90;
   wire n_0_3_100;
   wire n_0_91;
   wire n_0_92;
   wire [7:0]MUX_v_8_2_26_return;
   wire n_0_3_112;
   wire n_0_3_113;
   wire n_0_3_114;
   wire n_0_3_115;
   wire n_0_3_116;
   wire n_0_3_117;
   wire n_0_3_118;
   wire n_0_3_119;
   wire [7:0]MUX_v_8_2_27_return;
   wire n_0_3_120;
   wire n_0_3_121;
   wire n_0_3_122;
   wire n_0_3_123;
   wire n_0_3_124;
   wire n_0_3_125;
   wire n_0_3_126;
   wire n_0_3_127;
   wire [7:0]MUX_v_8_2_25_return;
   wire n_0_3_128;
   wire n_0_3_129;
   wire n_0_3_130;
   wire n_0_3_131;
   wire n_0_3_132;
   wire n_0_3_133;
   wire n_0_3_134;
   wire n_0_3_135;
   wire n_0_3_136;
   wire n_0_3_137;
   wire [7:0]MUX_v_8_2_28_return;
   wire n_0_3_138;
   wire n_0_3_139;
   wire n_0_3_140;
   wire n_0_3_141;
   wire n_0_3_142;
   wire n_0_3_143;
   wire n_0_3_144;
   wire n_0_3_145;
   wire [7:0]MUX_v_8_2_210_return;
   wire n_0_3_146;
   wire n_0_3_147;
   wire n_0_3_148;
   wire n_0_3_149;
   wire n_0_3_150;
   wire n_0_3_151;
   wire n_0_3_152;
   wire n_0_3_153;
   wire [7:0]MUX_v_8_2_29_return;
   wire n_0_3_154;
   wire n_0_3_155;
   wire n_0_3_156;
   wire n_0_3_157;
   wire n_0_3_158;
   wire n_0_3_160;
   wire n_0_3_161;
   wire n_0_3_162;
   wire n_0_14;
   wire n_0_15;
   wire n_0_16;
   wire n_0_17;
   wire n_0_18;
   wire n_0_19;
   wire n_0_20;
   wire n_0_21;
   wire n_0_22;
   wire n_0_23;
   wire n_0_24;
   wire n_0_3_164;
   wire n_0_3_165;
   wire n_0_3_166;
   wire n_0_3_167;
   wire n_0_25;
   wire n_0_26;
   wire n_0_27;
   wire n_0_28;
   wire n_0_29;
   wire n_0_30;
   wire n_0_31;
   wire n_0_32;
   wire n_0_33;
   wire n_0_34;
   wire n_0_35;
   wire n_0_3_168;
   wire n_0_36;
   wire n_0_3_169;
   wire n_0_37;
   wire n_0_38;
   wire n_0_3_170;
   wire n_0_39;
   wire n_0_40;
   wire n_0_41;
   wire n_0_42;
   wire n_0_43;
   wire n_0_44;
   wire n_0_45;
   wire n_0_46;
   wire n_0_47;
   wire n_0_3_171;
   wire n_0_3_172;
   wire n_0_3_173;
   wire n_0_3_174;
   wire n_0_3_175;
   wire n_0_3_176;
   wire n_0_3_177;
   wire n_0_3_178;
   wire n_0_3_179;
   wire n_0_49;
   wire n_0_50;
   wire n_0_51;
   wire n_0_48;
   wire n_0_52;
   wire n_0_53;
   wire n_0_54;
   wire n_0_55;
   wire n_0_3_180;
   wire n_0_3_181;
   wire n_0_56;
   wire n_0_3_182;
   wire n_0_3_183;
   wire n_0_3_184;
   wire n_0_57;
   wire n_0_58;
   wire n_0_59;
   wire n_0_60;
   wire n_0_61;
   wire n_0_62;
   wire n_0_63;
   wire n_0_64;
   wire n_0_65;
   wire n_0_66;
   wire n_0_67;
   wire n_0_68;
   wire n_0_69;
   wire n_0_70;
   wire n_0_71;
   wire n_0_72;
   wire n_0_73;
   wire n_0_74;
   wire n_0_75;
   wire n_0_93;
   wire n_0_94;
   wire n_0_95;
   wire n_0_96;
   wire n_0_97;
   wire n_0_98;
   wire n_0_3_185;
   wire n_0_99;
   wire n_0_3_186;
   wire n_0_100;
   wire n_0_3_187;
   wire n_0_3_188;
   wire n_0_3_189;
   wire n_0_3_190;
   wire n_0_3_191;
   wire n_0_3_192;
   wire n_0_3_193;
   wire n_0_3_194;
   wire n_0_3_195;
   wire n_0_3_196;
   wire n_0_3_197;
   wire n_0_3_198;
   wire n_0_3_199;
   wire n_0_3_200;
   wire n_0_3_201;
   wire n_0_3_202;
   wire n_0_3_203;
   wire n_0_3_204;
   wire n_0_3_205;
   wire n_0_3_206;
   wire n_0_3_207;
   wire n_0_3_208;
   wire n_0_3_209;
   wire n_0_3_210;
   wire n_0_3_211;
   wire n_0_3_212;
   wire n_0_3_213;
   wire n_0_3_214;
   wire n_0_3_215;
   wire n_0_3_216;
   wire n_0_3_217;
   wire n_0_3_218;
   wire n_0_3_219;
   wire n_0_3_220;
   wire n_0_3_221;
   wire n_0_3_222;
   wire n_0_3_223;
   wire n_0_3_224;
   wire n_0_3_225;
   wire n_0_3_226;
   wire n_0_3_227;
   wire n_0_3_228;
   wire n_0_3_229;
   wire n_0_3_230;
   wire n_0_3_231;
   wire n_0_3_232;
   wire n_0_3_233;
   wire n_0_3_234;
   wire n_0_3_235;
   wire n_0_3_236;
   wire n_0_3_237;
   wire n_0_3_238;
   wire n_0_3_239;
   wire n_0_3_240;
   wire n_0_3_241;
   wire n_0_3_242;
   wire n_0_3_243;
   wire n_0_3_244;
   wire n_0_3_245;
   wire n_0_3_246;
   wire n_0_3_247;
   wire EdgeDetect_IP_EdgeDetect_VerDer_run_run_fsm_inst_n_2;
   wire n_0_3_248;
   wire EdgeDetect_IP_EdgeDetect_VerDer_run_run_fsm_inst_n_3;
   wire n_0_3_249;
   wire n_0_3_250;
   wire n_0_3_251;
   wire n_0_3_252;
   wire EdgeDetect_IP_EdgeDetect_VerDer_run_run_fsm_inst_n_1;
   wire VCOL_if_2_and_cse;
   wire n_0_3_253;
   wire n_0_3_254;
   wire VCOL_if_5_and_cse;
   wire n_0_3_255;
   wire n_0_3_256;
   wire n_0_3_257;
   wire n_0_3_258;
   wire n_0_3_259;
   wire and_160_cse;
   wire n_0_3_260;
   wire n_0_3_261;
   wire n_0_3_262;
   wire n_0_3_263;
   wire n_0_3_264;
   wire n_0_3_265;
   wire n_0_3_266;
   wire n_0_3_267;
   wire n_0_3_268;
   wire n_0_3_269;
   wire n_0_3_270;
   wire n_0_3_271;
   wire and_153_cse;
   wire n_0_3_272;
   wire n_0_3_273;
   wire pix0_b_pixelType_and_3_cse;
   wire n_0_3_275;
   wire wrbuf0_pix_b_pixelType_and_cse;
   wire n_0_3_276;
   wire n_0_3_277;
   wire n_0_3_278;
   wire n_0_3_279;
   wire n_0_3_280;
   wire n_0_3_281;
   wire n_0_3_282;
   wire n_0_3_283;
   wire n_0_3_284;
   wire n_0_3_285;
   wire n_0_3_286;
   wire n_0_3_287;
   wire n_0_3_288;
   wire n_0_3_289;
   wire n_0_3_290;
   wire n_0_3_291;
   wire n_0_3_292;
   wire n_0_3_293;
   wire n_0_3_294;
   wire n_0_3_295;
   wire n_0_3_296;
   wire n_0_3_297;
   wire n_0_3_298;
   wire n_0_3_299;
   wire n_0_3_300;
   wire n_0_3_301;
   wire n_0_3_302;
   wire n_0_3_303;
   wire n_0_3_304;
   wire n_0_3_305;
   wire n_0_3_306;
   wire n_0_3_307;
   wire n_0_3_308;
   wire n_0_3_309;
   wire n_0_3_310;
   wire n_0_3_311;
   wire n_0_3_312;
   wire n_0_3_313;
   wire n_0_3_314;
   wire n_0_3_315;
   wire n_0_3_316;
   wire n_0_3_317;
   wire n_0_3_318;
   wire n_0_3_319;
   wire n_0_3_320;
   wire n_0_3_321;
   wire n_0_3_322;
   wire n_0_3_323;
   wire n_0_3_324;
   wire n_0_3_325;
   wire n_0_3_326;
   wire n_0_3_327;
   wire n_0_3_328;
   wire n_0_3_329;
   wire n_0_3_330;
   wire run_wen;
   wire n_0_3_331;
   wire n_0_3_332;
   wire n_0_3_333;
   wire n_0_3_334;
   wire n_0_3_335;
   wire n_0_3_336;
   wire n_0_3_337;
   wire n_0_3_338;
   wire n_0_3_339;
   wire n_0_3_340;
   wire n_0_3_341;
   wire n_0_3_342;
   wire n_0_3_343;
   wire [7:0]MUX_v_8_2_23_return;
   wire n_0_3_344;
   wire n_0_3_345;
   wire n_0_3_346;
   wire n_0_3_347;
   wire n_0_3_348;
   wire n_0_3_349;
   wire [7:0]MUX_v_8_2_24_return;
   wire n_0_3_350;
   wire n_0_3_351;
   wire n_0_3_352;
   wire n_0_3_353;
   wire n_0_3_354;
   wire n_0_3_355;
   wire [7:0]MUX_v_8_2_22_return;
   wire n_0_3_356;
   wire n_0_3_357;
   wire n_0_3_358;
   wire n_0_3_359;
   wire n_0_3_360;
   wire n_0_3_361;
   wire n_0_3_362;
   wire n_0_3_363;
   wire n_0_3_364;
   wire n_0_3_365;
   wire n_0_3_366;
   wire n_0_3_367;
   wire n_0_3_368;
   wire n_0_3_369;
   wire n_0_3_370;
   wire n_0_3_371;
   wire n_0_3_372;
   wire n_0_3_373;
   wire n_0_3_374;
   wire n_0_3_375;
   wire n_0_3_376;
   wire n_0_3_377;
   wire n_0_3_378;
   wire n_0_3_379;
   wire n_0_3_380;
   wire n_0_3_381;
   wire n_0_3_382;
   wire n_0_3_383;
   wire n_0_3_384;
   wire n_0_3_385;
   wire n_0_3_386;
   wire n_0_3_387;
   wire n_0_3_388;
   wire n_0_3_389;
   wire n_0_3_390;
   wire n_0_3_391;
   wire n_0_3_392;
   wire n_0_3_393;
   wire n_0_3_394;
   wire n_0_3_395;
   wire n_0_3_396;
   wire n_0_3_397;
   wire n_0_3_398;
   wire n_0_3_399;
   wire n_0_3_400;
   wire n_0_3_401;
   wire n_0_3_402;
   wire n_0_3_403;
   wire n_0_3_404;
   wire n_0_3_405;
   wire n_0_3_406;
   wire n_0_3_407;
   wire n_0_3_408;
   wire n_0_3_409;
   wire n_0_3_410;
   wire n_0_3_411;
   wire n_0_3_101;
   wire n_0_3_102;
   wire n_0_3_412;
   wire n_0_3_413;
   wire n_0_3_414;
   wire n_0_3_415;
   wire n_0_3_416;
   wire n_0_3_417;
   wire n_0_3_418;
   wire n_0_3_419;
   wire n_0_3_420;
   wire n_0_3_421;
   wire n_0_3_422;
   wire n_0_3_423;
   wire n_0_3_424;
   wire n_0_3_425;
   wire n_0_3_426;
   wire n_0_3_427;
   wire n_0_3_442;
   wire n_0_3_443;
   wire n_0_3_444;
   wire n_0_3_445;
   wire n_0_3_446;
   wire n_0_3_447;
   wire n_0_3_448;
   wire n_0_3_449;
   wire n_0_3_450;
   wire n_0_3_451;
   wire n_0_3_452;
   wire n_0_3_453;
   wire n_0_3_454;
   wire n_0_3_455;
   wire n_0_3_456;
   wire n_0_3_457;
   wire n_0_3_458;
   wire n_0_3_459;
   wire n_0_3_460;
   wire n_0_3_461;
   wire n_0_3_462;
   wire n_0_3_463;
   wire n_0_3_464;
   wire n_0_3_465;
   wire n_0_3_466;
   wire n_0_3_467;
   wire n_0_3_468;
   wire n_0_3_469;
   wire n_0_3_470;
   wire n_0_3_471;
   wire n_0_3_472;
   wire n_0_3_473;
   wire n_0_3_475;
   wire n_0_3_476;
   wire n_0_3_477;
   wire n_0_84;
   wire n_0_3_478;
   wire n_0_3_479;
   wire n_0_3_480;
   wire n_0_3_481;
   wire n_0_3_482;
   wire n_0_3_483;
   wire n_0_3_484;
   wire n_0_3_485;
   wire [9:0]vector;
   wire n_0_3_488;
   wire n_0_3_159;
   wire n_0_3_163;
   wire n_0_3_274;
   wire n_0_3_428;
   wire n_0_3_429;
   wire n_0_3_430;
   wire n_0_3_431;
   wire n_0_3_432;
   wire n_0_3_433;
   wire n_0_3_434;
   wire n_0_3_435;
   wire n_0_3_436;
   wire n_0_3_437;
   wire n_0_3_438;
   wire n_0_3_439;
   wire n_0_3_440;
   wire n_0_3_441;
   wire n_0_3_474;
   wire n_0_3_486;
   wire n_0_3_487;

   INV_X1 i_0_3_613 (.A(line_buf0_r_pixelType_rsci_adr_d_pff[5]), .ZN(n_0_3_470));
   INV_X1 i_0_3_619 (.A(
      EdgeDetect_IP_EdgeDetect_VerDer_run_run_fsm_inst_state_var[0]), .ZN(
      n_0_3_476));
   INV_X1 i_0_3_597 (.A(rst), .ZN(n_0_3_454));
   NAND3_X1 i_0_3_333 (.A1(
      EdgeDetect_IP_EdgeDetect_VerDer_run_run_fsm_inst_state_var[1]), .A2(
      n_0_3_476), .A3(n_0_3_454), .ZN(n_0_3_249));
   NAND2_X1 i_0_3_187 (.A1(n_0_3_251), .A2(n_0_3_249), .ZN(n_0_3_168));
   AND2_X1 i_0_3_183 (.A1(n_0_3_108), .A2(n_0_3_168), .ZN(n_0_32));
   NAND2_X1 i_0_3_382 (.A1(n_0_3_454), .A2(n_0_3_331), .ZN(
      EdgeDetect_IP_EdgeDetect_VerDer_run_run_fsm_inst_n_1));
   NAND2_X1 i_0_3_189 (.A1(EdgeDetect_IP_EdgeDetect_VerDer_run_run_fsm_inst_n_1), 
      .A2(n_0_3_251), .ZN(n_0_3_169));
   INV_X1 i_0_3_188 (.A(n_0_3_169), .ZN(n_0_36));
   CLKGATE_X1 clk_gate_VROW_y_sva_reg (.CK(clk), .E(n_0_36), .GCK(n_0_4));
   DFFR_X1 \VROW_y_sva_reg[6]  (.D(n_0_32), .RN(arst_n), .CK(n_0_4), .Q(
      VROW_y_sva[6]), .QN());
   INV_X1 i_0_3_659 (.A(VROW_y_sva[6]), .ZN(vector[6]));
   NAND2_X1 i_0_3_465 (.A1(n_0_3_477), .A2(
      EdgeDetect_IP_EdgeDetect_VerDer_run_run_fsm_inst_state_var[0]), .ZN(
      n_0_3_330));
   INV_X1 i_0_3_464 (.A(n_0_3_330), .ZN(n_0_3_329));
   OAI22_X1 i_0_3_207 (.A1(vector[6]), .A2(n_0_3_329), .B1(n_0_3_470), .B2(
      n_0_3_330), .ZN(n_0_3_176));
   INV_X1 i_0_3_592 (.A(n_0_3_107), .ZN(n_0_3_447));
   AOI221_X1 i_0_3_166 (.A(n_0_3_251), .B1(VCOL_stage_0_2), .B2(n_0_3_447), 
      .C1(n_0_3_475), .C2(n_0_3_467), .ZN(n_0_19));
   NAND2_X1 i_0_3_407 (.A1(VCOL_stage_0_2), .A2(run_wen), .ZN(n_0_3_276));
   NAND2_X1 i_0_3_176 (.A1(n_0_3_276), .A2(n_0_3_169), .ZN(n_0_25));
   CLKGATE_X1 clk_gate_VCOL_x_sva_reg (.CK(clk), .E(n_0_25), .GCK(n_0_5));
   DFFR_X1 \VCOL_x_sva_reg[5]  (.D(n_0_19), .RN(arst_n), .CK(n_0_5), .Q(
      line_buf0_r_pixelType_rsci_adr_d_pff[4]), .QN());
   INV_X1 i_0_3_610 (.A(line_buf0_r_pixelType_rsci_adr_d_pff[4]), .ZN(n_0_3_467));
   AND2_X1 i_0_3_182 (.A1(n_0_3_107), .A2(n_0_3_168), .ZN(n_0_31));
   DFFR_X1 \VROW_y_sva_reg[5]  (.D(n_0_31), .RN(arst_n), .CK(n_0_4), .Q(
      VROW_y_sva[5]), .QN());
   INV_X1 i_0_3_658 (.A(VROW_y_sva[5]), .ZN(vector[5]));
   OAI22_X1 i_0_3_206 (.A1(n_0_3_467), .A2(n_0_3_330), .B1(vector[5]), .B2(
      n_0_3_329), .ZN(n_0_3_175));
   AND2_X1 i_0_3_181 (.A1(n_0_3_106), .A2(n_0_3_168), .ZN(n_0_30));
   DFFR_X1 \VROW_y_sva_reg[4]  (.D(n_0_30), .RN(arst_n), .CK(n_0_4), .Q(
      VROW_y_sva[4]), .QN());
   INV_X1 i_0_3_626 (.A(VROW_y_sva[4]), .ZN(vector[4]));
   INV_X1 i_0_3_591 (.A(n_0_3_106), .ZN(n_0_3_446));
   AOI221_X1 i_0_3_165 (.A(n_0_3_251), .B1(VCOL_stage_0_2), .B2(n_0_3_446), 
      .C1(n_0_3_475), .C2(n_0_3_463), .ZN(n_0_18));
   DFFR_X1 \VCOL_x_sva_reg[4]  (.D(n_0_18), .RN(arst_n), .CK(n_0_5), .Q(
      line_buf0_r_pixelType_rsci_adr_d_pff[3]), .QN());
   INV_X1 i_0_3_606 (.A(line_buf0_r_pixelType_rsci_adr_d_pff[3]), .ZN(n_0_3_463));
   OAI22_X1 i_0_3_205 (.A1(vector[4]), .A2(n_0_3_329), .B1(n_0_3_463), .B2(
      n_0_3_330), .ZN(n_0_3_174));
   AND2_X1 i_0_3_180 (.A1(n_0_3_105), .A2(n_0_3_168), .ZN(n_0_29));
   DFFR_X1 \VROW_y_sva_reg[3]  (.D(n_0_29), .RN(arst_n), .CK(n_0_4), .Q(
      VROW_y_sva[3]), .QN());
   INV_X1 i_0_3_624 (.A(VROW_y_sva[3]), .ZN(vector[3]));
   INV_X1 i_0_3_590 (.A(n_0_3_105), .ZN(n_0_3_445));
   AOI221_X1 i_0_3_164 (.A(n_0_3_251), .B1(VCOL_stage_0_2), .B2(n_0_3_445), 
      .C1(n_0_3_475), .C2(n_0_3_466), .ZN(n_0_17));
   DFFR_X1 \VCOL_x_sva_reg[3]  (.D(n_0_17), .RN(arst_n), .CK(n_0_5), .Q(
      line_buf0_r_pixelType_rsci_adr_d_pff[2]), .QN());
   INV_X1 i_0_3_609 (.A(line_buf0_r_pixelType_rsci_adr_d_pff[2]), .ZN(n_0_3_466));
   OAI22_X1 i_0_3_204 (.A1(vector[3]), .A2(n_0_3_329), .B1(n_0_3_466), .B2(
      n_0_3_330), .ZN(n_0_3_173));
   AND2_X1 i_0_3_179 (.A1(n_0_3_104), .A2(n_0_3_168), .ZN(n_0_28));
   DFFR_X1 \VROW_y_sva_reg[2]  (.D(n_0_28), .RN(arst_n), .CK(n_0_4), .Q(
      VROW_y_sva[2]), .QN());
   INV_X1 i_0_3_657 (.A(VROW_y_sva[2]), .ZN(vector[2]));
   INV_X1 i_0_3_589 (.A(n_0_3_104), .ZN(n_0_3_444));
   AOI221_X1 i_0_3_163 (.A(n_0_3_251), .B1(VCOL_stage_0_2), .B2(n_0_3_444), 
      .C1(n_0_3_475), .C2(n_0_3_464), .ZN(n_0_16));
   DFFR_X1 \VCOL_x_sva_reg[2]  (.D(n_0_16), .RN(arst_n), .CK(n_0_5), .Q(
      line_buf0_r_pixelType_rsci_adr_d_pff[1]), .QN());
   INV_X1 i_0_3_607 (.A(line_buf0_r_pixelType_rsci_adr_d_pff[1]), .ZN(n_0_3_464));
   OAI22_X1 i_0_3_202 (.A1(vector[2]), .A2(n_0_3_329), .B1(n_0_3_464), .B2(
      n_0_3_330), .ZN(n_0_3_172));
   AND2_X1 i_0_3_178 (.A1(n_0_3_103), .A2(n_0_3_168), .ZN(n_0_27));
   DFFR_X1 \VROW_y_sva_reg[1]  (.D(n_0_27), .RN(arst_n), .CK(n_0_4), .Q(
      VROW_y_sva[1]), .QN());
   INV_X1 i_0_3_656 (.A(VROW_y_sva[1]), .ZN(vector[1]));
   INV_X1 i_0_3_588 (.A(n_0_3_103), .ZN(n_0_3_443));
   AOI221_X1 i_0_3_162 (.A(n_0_3_251), .B1(n_0_3_475), .B2(n_0_3_465), .C1(
      VCOL_stage_0_2), .C2(n_0_3_443), .ZN(n_0_15));
   DFFR_X1 \VCOL_x_sva_reg[1]  (.D(n_0_15), .RN(arst_n), .CK(n_0_5), .Q(
      line_buf0_r_pixelType_rsci_adr_d_pff[0]), .QN());
   INV_X1 i_0_3_608 (.A(line_buf0_r_pixelType_rsci_adr_d_pff[0]), .ZN(n_0_3_465));
   OAI22_X1 i_0_3_201 (.A1(vector[1]), .A2(n_0_3_329), .B1(n_0_3_465), .B2(
      n_0_3_330), .ZN(n_0_3_171));
   AND2_X1 i_0_3_177 (.A1(n_0_3_327), .A2(n_0_3_168), .ZN(n_0_26));
   DFFR_X1 \VROW_y_sva_reg[0]  (.D(n_0_26), .RN(arst_n), .CK(n_0_4), .Q(
      VROW_y_sva[0]), .QN());
   INV_X1 i_0_3_616 (.A(VCOL_x_sva[0]), .ZN(n_0_3_471));
   AOI221_X1 i_0_3_212 (.A(rst), .B1(n_0_3_475), .B2(n_0_3_471), .C1(
      VCOL_stage_0_2), .C2(n_0_3_326), .ZN(n_0_100));
   AND2_X1 i_0_3_158 (.A1(
      EdgeDetect_IP_EdgeDetect_VerDer_run_run_fsm_inst_state_var[0]), .A2(
      n_0_100), .ZN(n_0_14));
   DFFR_X1 \VCOL_x_sva_reg[0]  (.D(n_0_14), .RN(arst_n), .CK(n_0_5), .Q(
      VCOL_x_sva[0]), .QN());
   AOI22_X1 i_0_3_463 (.A1(VROW_y_sva[0]), .A2(n_0_3_330), .B1(VCOL_x_sva[0]), 
      .B2(n_0_3_329), .ZN(n_0_3_327));
   INV_X1 i_0_3_462 (.A(n_0_3_327), .ZN(n_0_3_326));
   HA_X1 i_0_3_0 (.A(n_0_3_171), .B(n_0_3_326), .CO(n_0_3_0), .S(n_0_3_103));
   HA_X1 i_0_3_1 (.A(n_0_3_172), .B(n_0_3_0), .CO(n_0_3_1), .S(n_0_3_104));
   HA_X1 i_0_3_2 (.A(n_0_3_173), .B(n_0_3_1), .CO(n_0_3_2), .S(n_0_3_105));
   HA_X1 i_0_3_3 (.A(n_0_3_174), .B(n_0_3_2), .CO(n_0_3_3), .S(n_0_3_106));
   HA_X1 i_0_3_4 (.A(n_0_3_175), .B(n_0_3_3), .CO(n_0_3_4), .S(n_0_3_107));
   HA_X1 i_0_3_5 (.A(n_0_3_176), .B(n_0_3_4), .CO(n_0_3_5), .S(n_0_3_108));
   INV_X1 i_0_3_593 (.A(n_0_3_108), .ZN(n_0_3_448));
   AOI221_X1 i_0_3_167 (.A(n_0_3_251), .B1(n_0_3_475), .B2(n_0_3_470), .C1(
      VCOL_stage_0_2), .C2(n_0_3_448), .ZN(n_0_20));
   DFFR_X1 \VCOL_x_sva_reg[6]  (.D(n_0_20), .RN(arst_n), .CK(n_0_5), .Q(
      line_buf0_r_pixelType_rsci_adr_d_pff[5]), .QN());
   INV_X1 i_0_3_612 (.A(widthIn[1]), .ZN(n_0_3_469));
   INV_X1 i_0_3_611 (.A(widthIn[0]), .ZN(n_0_3_468));
   NAND2_X1 i_0_3_461 (.A1(n_0_3_469), .A2(n_0_3_468), .ZN(n_0_3_325));
   NOR2_X1 i_0_3_460 (.A1(widthIn[2]), .A2(n_0_3_325), .ZN(n_0_3_324));
   INV_X1 i_0_3_459 (.A(n_0_3_324), .ZN(n_0_3_323));
   NOR2_X1 i_0_3_458 (.A1(widthIn[3]), .A2(n_0_3_323), .ZN(n_0_3_322));
   INV_X1 i_0_3_457 (.A(n_0_3_322), .ZN(n_0_3_321));
   NOR2_X1 i_0_3_456 (.A1(widthIn[4]), .A2(n_0_3_321), .ZN(n_0_3_320));
   INV_X1 i_0_3_455 (.A(n_0_3_320), .ZN(n_0_3_319));
   NOR2_X1 i_0_3_454 (.A1(widthIn[5]), .A2(n_0_3_319), .ZN(n_0_3_318));
   INV_X1 i_0_3_453 (.A(n_0_3_318), .ZN(n_0_3_317));
   NOR2_X1 i_0_3_452 (.A1(widthIn[6]), .A2(n_0_3_317), .ZN(n_0_3_316));
   AOI21_X1 i_0_3_442 (.A(n_0_3_316), .B1(widthIn[6]), .B2(n_0_3_317), .ZN(
      n_0_3_306));
   XOR2_X1 i_0_3_441 (.A(line_buf0_r_pixelType_rsci_adr_d_pff[5]), .B(n_0_3_306), 
      .Z(n_0_3_305));
   AOI21_X1 i_0_3_430 (.A(n_0_3_320), .B1(widthIn[4]), .B2(n_0_3_321), .ZN(
      n_0_3_294));
   XNOR2_X1 i_0_3_429 (.A(line_buf0_r_pixelType_rsci_adr_d_pff[3]), .B(n_0_3_294), 
      .ZN(n_0_3_293));
   AOI22_X1 i_0_3_436 (.A1(n_0_3_469), .A2(
      line_buf0_r_pixelType_rsci_adr_d_pff[0]), .B1(widthIn[1]), .B2(n_0_3_465), 
      .ZN(n_0_3_300));
   INV_X1 i_0_3_435 (.A(n_0_3_300), .ZN(n_0_3_299));
   OAI33_X1 i_0_3_434 (.A1(VCOL_x_sva[0]), .A2(n_0_3_299), .A3(n_0_3_468), 
      .B1(n_0_3_471), .B2(n_0_3_300), .B3(widthIn[0]), .ZN(n_0_3_298));
   AOI21_X1 i_0_3_437 (.A(n_0_3_324), .B1(widthIn[2]), .B2(n_0_3_325), .ZN(
      n_0_3_301));
   XNOR2_X1 i_0_3_433 (.A(n_0_3_464), .B(n_0_3_301), .ZN(n_0_3_297));
   AOI21_X1 i_0_3_439 (.A(n_0_3_322), .B1(widthIn[3]), .B2(n_0_3_323), .ZN(
      n_0_3_303));
   XOR2_X1 i_0_3_438 (.A(line_buf0_r_pixelType_rsci_adr_d_pff[2]), .B(n_0_3_303), 
      .Z(n_0_3_302));
   AND3_X1 i_0_3_432 (.A1(n_0_3_298), .A2(n_0_3_297), .A3(n_0_3_302), .ZN(
      n_0_3_296));
   AOI21_X1 i_0_3_440 (.A(n_0_3_318), .B1(widthIn[5]), .B2(n_0_3_319), .ZN(
      n_0_3_304));
   OAI21_X1 i_0_3_431 (.A(n_0_3_296), .B1(
      line_buf0_r_pixelType_rsci_adr_d_pff[4]), .B2(n_0_3_304), .ZN(n_0_3_295));
   AOI211_X1 i_0_3_428 (.A(n_0_3_293), .B(n_0_3_295), .C1(
      line_buf0_r_pixelType_rsci_adr_d_pff[4]), .C2(n_0_3_304), .ZN(n_0_3_292));
   INV_X1 i_0_3_605 (.A(line_buf0_r_pixelType_rsci_adr_d_pff[6]), .ZN(n_0_3_462));
   AND2_X1 i_0_3_184 (.A1(n_0_3_109), .A2(n_0_3_168), .ZN(n_0_33));
   DFFR_X1 \VROW_y_sva_reg[7]  (.D(n_0_33), .RN(arst_n), .CK(n_0_4), .Q(
      VROW_y_sva[7]), .QN());
   INV_X1 i_0_3_660 (.A(VROW_y_sva[7]), .ZN(vector[7]));
   OAI22_X1 i_0_3_208 (.A1(n_0_3_462), .A2(n_0_3_330), .B1(vector[7]), .B2(
      n_0_3_329), .ZN(n_0_3_177));
   HA_X1 i_0_3_6 (.A(n_0_3_177), .B(n_0_3_5), .CO(n_0_3_6), .S(n_0_3_109));
   INV_X1 i_0_3_594 (.A(n_0_3_109), .ZN(n_0_3_449));
   AOI221_X1 i_0_3_168 (.A(n_0_3_251), .B1(n_0_3_475), .B2(n_0_3_462), .C1(
      VCOL_stage_0_2), .C2(n_0_3_449), .ZN(n_0_21));
   DFFR_X1 \VCOL_x_sva_reg[7]  (.D(n_0_21), .RN(arst_n), .CK(n_0_5), .Q(
      line_buf0_r_pixelType_rsci_adr_d_pff[6]), .QN());
   INV_X1 i_0_3_451 (.A(n_0_3_316), .ZN(n_0_3_315));
   NOR2_X1 i_0_3_450 (.A1(widthIn[7]), .A2(n_0_3_315), .ZN(n_0_3_314));
   AOI21_X1 i_0_3_444 (.A(n_0_3_314), .B1(widthIn[7]), .B2(n_0_3_315), .ZN(
      n_0_3_308));
   XOR2_X1 i_0_3_443 (.A(line_buf0_r_pixelType_rsci_adr_d_pff[6]), .B(n_0_3_308), 
      .Z(n_0_3_307));
   INV_X1 i_0_3_604 (.A(line_buf0_r_pixelType_rsci_adr_d_pff[7]), .ZN(n_0_3_461));
   AND2_X1 i_0_3_185 (.A1(n_0_3_110), .A2(n_0_3_168), .ZN(n_0_34));
   DFFR_X1 \VROW_y_sva_reg[8]  (.D(n_0_34), .RN(arst_n), .CK(n_0_4), .Q(
      VROW_y_sva[8]), .QN());
   INV_X1 i_0_3_625 (.A(VROW_y_sva[8]), .ZN(vector[8]));
   OAI22_X1 i_0_3_209 (.A1(n_0_3_461), .A2(n_0_3_330), .B1(vector[8]), .B2(
      n_0_3_329), .ZN(n_0_3_178));
   HA_X1 i_0_3_7 (.A(n_0_3_178), .B(n_0_3_6), .CO(n_0_3_7), .S(n_0_3_110));
   INV_X1 i_0_3_595 (.A(n_0_3_110), .ZN(n_0_3_450));
   AOI221_X1 i_0_3_169 (.A(n_0_3_251), .B1(n_0_3_475), .B2(n_0_3_461), .C1(
      VCOL_stage_0_2), .C2(n_0_3_450), .ZN(n_0_22));
   DFFR_X1 \VCOL_x_sva_reg[8]  (.D(n_0_22), .RN(arst_n), .CK(n_0_5), .Q(
      line_buf0_r_pixelType_rsci_adr_d_pff[7]), .QN());
   INV_X1 i_0_3_449 (.A(n_0_3_314), .ZN(n_0_3_313));
   NOR2_X1 i_0_3_448 (.A1(widthIn[8]), .A2(n_0_3_313), .ZN(n_0_3_312));
   AOI21_X1 i_0_3_446 (.A(n_0_3_312), .B1(widthIn[8]), .B2(n_0_3_313), .ZN(
      n_0_3_310));
   XOR2_X1 i_0_3_445 (.A(line_buf0_r_pixelType_rsci_adr_d_pff[7]), .B(n_0_3_310), 
      .Z(n_0_3_309));
   NAND4_X1 i_0_3_427 (.A1(n_0_3_305), .A2(n_0_3_292), .A3(n_0_3_307), .A4(
      n_0_3_309), .ZN(n_0_3_291));
   INV_X1 i_0_3_422 (.A(n_0_3_291), .ZN(n_0_3_290));
   AOI21_X1 i_0_3_175 (.A(n_0_3_459), .B1(VCOL_stage_0_2), .B2(n_0_3_330), 
      .ZN(n_0_3_167));
   INV_X1 i_0_3_596 (.A(n_0_3_111), .ZN(n_0_3_451));
   AOI221_X1 i_0_3_170 (.A(n_0_3_251), .B1(VCOL_stage_0_2), .B2(n_0_3_451), 
      .C1(n_0_3_475), .C2(n_0_3_458), .ZN(n_0_23));
   DFFR_X1 \VCOL_x_sva_reg[9]  (.D(n_0_23), .RN(arst_n), .CK(n_0_5), .Q(
      line_buf0_r_pixelType_rsci_adr_d_pff[8]), .QN());
   INV_X1 i_0_3_601 (.A(line_buf0_r_pixelType_rsci_adr_d_pff[8]), .ZN(n_0_3_458));
   AND2_X1 i_0_3_186 (.A1(n_0_3_111), .A2(n_0_3_168), .ZN(n_0_35));
   DFFR_X1 \VROW_y_sva_reg[9]  (.D(n_0_35), .RN(arst_n), .CK(n_0_4), .Q(
      VROW_y_sva[9]), .QN());
   INV_X1 i_0_3_661 (.A(VROW_y_sva[9]), .ZN(vector[9]));
   OAI22_X1 i_0_3_210 (.A1(n_0_3_458), .A2(n_0_3_330), .B1(vector[9]), .B2(
      n_0_3_329), .ZN(n_0_3_179));
   HA_X1 i_0_3_8 (.A(n_0_3_179), .B(n_0_3_7), .CO(n_0_3_8), .S(n_0_3_111));
   NAND2_X1 i_0_3_173 (.A1(VCOL_stage_0_2), .A2(n_0_3_8), .ZN(n_0_3_165));
   INV_X1 i_0_3_172 (.A(n_0_3_165), .ZN(n_0_3_164));
   INV_X1 i_0_3_174 (.A(n_0_3_167), .ZN(n_0_3_166));
   AOI221_X1 i_0_3_171 (.A(n_0_3_251), .B1(n_0_3_167), .B2(n_0_3_164), .C1(
      n_0_3_166), .C2(n_0_3_165), .ZN(n_0_24));
   DFFR_X1 \VCOL_x_sva_reg[10]  (.D(n_0_24), .RN(arst_n), .CK(n_0_5), .Q(
      line_buf0_r_pixelType_rsci_adr_d_pff[9]), .QN());
   INV_X1 i_0_3_602 (.A(line_buf0_r_pixelType_rsci_adr_d_pff[9]), .ZN(n_0_3_459));
   XNOR2_X1 i_0_3_421 (.A(n_0_3_459), .B(widthIn[10]), .ZN(n_0_3_289));
   INV_X1 i_0_3_420 (.A(n_0_3_289), .ZN(n_0_3_288));
   INV_X1 i_0_3_447 (.A(n_0_3_312), .ZN(n_0_3_311));
   NOR2_X1 i_0_3_419 (.A1(widthIn[9]), .A2(n_0_3_311), .ZN(n_0_3_283));
   XOR2_X1 i_0_3_418 (.A(n_0_3_288), .B(n_0_3_283), .Z(n_0_3_282));
   INV_X1 i_0_3_603 (.A(widthIn[9]), .ZN(n_0_3_460));
   OAI22_X1 i_0_3_417 (.A1(widthIn[9]), .A2(n_0_3_311), .B1(n_0_3_460), .B2(
      n_0_3_312), .ZN(n_0_3_281));
   XNOR2_X1 i_0_3_416 (.A(line_buf0_r_pixelType_rsci_adr_d_pff[8]), .B(n_0_3_281), 
      .ZN(n_0_3_280));
   NAND3_X1 i_0_3_415 (.A1(n_0_3_290), .A2(n_0_3_282), .A3(n_0_3_280), .ZN(
      n_0_3_279));
   OAI21_X1 i_0_3_254 (.A(VCOL_stage_0_1), .B1(n_0_3_475), .B2(n_0_3_279), 
      .ZN(n_0_3_186));
   AOI21_X1 i_0_3_213 (.A(rst), .B1(
      EdgeDetect_IP_EdgeDetect_VerDer_run_run_fsm_inst_state_var[0]), .B2(
      n_0_3_186), .ZN(n_0_49));
   CLKGATE_X1 clk_gate_reg_line_buf0_r_pixelType_rsci_cgo_cse_reg (.CK(clk), 
      .E(EdgeDetect_IP_EdgeDetect_VerDer_run_run_fsm_inst_n_1), .GCK(n_0_6));
   DFFR_X1 VCOL_stage_0_1_reg (.D(n_0_49), .RN(arst_n), .CK(n_0_6), .Q(
      VCOL_stage_0_1), .QN());
   INV_X1 i_0_3_617 (.A(VCOL_stage_0_1), .ZN(n_0_3_472));
   NAND3_X1 i_0_3_381 (.A1(n_0_3_475), .A2(n_0_3_440), .A3(n_0_3_472), .ZN(
      n_0_3_252));
   NAND2_X1 i_0_3_376 (.A1(n_0_3_454), .A2(n_0_3_329), .ZN(n_0_3_250));
   XNOR2_X1 i_0_3_645 (.A(VROW_y_sva[4]), .B(heightIn[4]), .ZN(n_0_3_437));
   INV_X1 i_0_3_652 (.A(heightIn[6]), .ZN(n_0_3_474));
   OAI221_X1 i_0_3_643 (.A(n_0_3_437), .B1(vector[6]), .B2(heightIn[6]), 
      .C1(VROW_y_sva[6]), .C2(n_0_3_474), .ZN(n_0_3_436));
   AOI22_X1 i_0_3_638 (.A1(vector[1]), .A2(heightIn[1]), .B1(vector[2]), 
      .B2(heightIn[2]), .ZN(n_0_3_434));
   OAI221_X1 i_0_3_637 (.A(n_0_3_434), .B1(vector[1]), .B2(heightIn[1]), 
      .C1(vector[2]), .C2(heightIn[2]), .ZN(n_0_3_433));
   XNOR2_X1 i_0_3_649 (.A(heightIn[8]), .B(VROW_y_sva[8]), .ZN(n_0_3_439));
   INV_X1 i_0_3_651 (.A(heightIn[5]), .ZN(n_0_3_441));
   OAI221_X1 i_0_3_636 (.A(n_0_3_439), .B1(vector[5]), .B2(heightIn[5]), 
      .C1(VROW_y_sva[5]), .C2(n_0_3_441), .ZN(n_0_3_432));
   NOR2_X1 i_0_3_639 (.A1(vector[9]), .A2(heightIn[9]), .ZN(n_0_3_435));
   INV_X1 i_0_3_654 (.A(heightIn[0]), .ZN(n_0_3_487));
   AOI221_X1 i_0_3_634 (.A(n_0_3_435), .B1(vector[9]), .B2(heightIn[9]), 
      .C1(VROW_y_sva[0]), .C2(n_0_3_487), .ZN(n_0_3_431));
   XOR2_X1 i_0_3_646 (.A(VROW_y_sva[3]), .B(heightIn[3]), .Z(n_0_3_438));
   INV_X1 i_0_3_653 (.A(heightIn[7]), .ZN(n_0_3_486));
   AOI221_X1 i_0_3_633 (.A(n_0_3_438), .B1(VROW_y_sva[7]), .B2(n_0_3_486), 
      .C1(vector[7]), .C2(heightIn[7]), .ZN(n_0_3_430));
   OAI211_X1 i_0_3_632 (.A(n_0_3_431), .B(n_0_3_430), .C1(VROW_y_sva[0]), 
      .C2(n_0_3_487), .ZN(n_0_3_429));
   NOR4_X1 i_0_3_631 (.A1(n_0_3_436), .A2(n_0_3_433), .A3(n_0_3_432), .A4(
      n_0_3_429), .ZN(n_0_3_428));
   INV_X1 i_0_3_585 (.A(n_0_3_428), .ZN(n_0_3_427));
   OAI22_X1 i_0_3_379 (.A1(n_0_3_252), .A2(n_0_3_250), .B1(n_0_3_427), .B2(
      n_0_3_249), .ZN(EdgeDetect_IP_EdgeDetect_VerDer_run_run_fsm_inst_n_3));
   DFFR_X1 \EdgeDetect_IP_EdgeDetect_VerDer_run_run_fsm_inst_state_var_reg[1]  (
      .D(EdgeDetect_IP_EdgeDetect_VerDer_run_run_fsm_inst_n_3), .RN(arst_n), 
      .CK(n_0_6), .Q(
      EdgeDetect_IP_EdgeDetect_VerDer_run_run_fsm_inst_state_var[1]), .QN());
   INV_X1 i_0_3_620 (.A(
      EdgeDetect_IP_EdgeDetect_VerDer_run_run_fsm_inst_state_var[1]), .ZN(
      n_0_3_477));
   NAND2_X1 i_0_3_378 (.A1(n_0_3_477), .A2(n_0_3_252), .ZN(n_0_3_248));
   AOI21_X1 i_0_3_377 (.A(rst), .B1(
      EdgeDetect_IP_EdgeDetect_VerDer_run_run_fsm_inst_state_var[0]), .B2(
      n_0_3_248), .ZN(EdgeDetect_IP_EdgeDetect_VerDer_run_run_fsm_inst_n_2));
   DFFR_X1 \EdgeDetect_IP_EdgeDetect_VerDer_run_run_fsm_inst_state_var_reg[0]  (
      .D(EdgeDetect_IP_EdgeDetect_VerDer_run_run_fsm_inst_n_2), .RN(arst_n), 
      .CK(n_0_6), .Q(
      EdgeDetect_IP_EdgeDetect_VerDer_run_run_fsm_inst_state_var[0]), .QN());
   NAND2_X1 i_0_3_380 (.A1(
      EdgeDetect_IP_EdgeDetect_VerDer_run_run_fsm_inst_state_var[0]), .A2(
      n_0_3_454), .ZN(n_0_3_251));
   NOR2_X1 i_0_3_216 (.A1(n_0_3_251), .A2(n_0_3_186), .ZN(n_0_48));
   DFFR_X1 VCOL_stage_0_2_reg (.D(n_0_48), .RN(arst_n), .CK(n_0_6), .Q(
      VCOL_stage_0_2), .QN());
   INV_X1 i_0_3_618 (.A(VCOL_stage_0_2), .ZN(n_0_3_475));
   NOR2_X1 i_0_3_214 (.A1(n_0_3_475), .A2(n_0_3_251), .ZN(n_0_50));
   DFFR_X1 VCOL_stage_0_3_reg (.D(n_0_50), .RN(arst_n), .CK(n_0_6), .Q(
      VCOL_stage_0_3), .QN());
   INV_X1 i_0_3_650 (.A(VCOL_stage_0_3), .ZN(n_0_3_440));
   OAI22_X1 i_0_3_198 (.A1(n_0_3_448), .A2(n_0_3_249), .B1(vector[6]), .B2(
      n_0_3_250), .ZN(n_0_44));
   DFFR_X1 \VCOL_asn_12_itm_reg[6]  (.D(n_0_44), .RN(arst_n), .CK(n_0_6), 
      .Q(VCOL_asn_12_itm[6]), .QN());
   INV_X1 i_0_3_615 (.A(VCOL_asn_12_itm[6]), .ZN(n_0_3_453));
   NOR2_X1 i_0_3_247 (.A1(rst), .A2(n_0_3_453), .ZN(n_0_94));
   OAI21_X1 i_0_3_253 (.A(n_0_3_454), .B1(n_0_3_331), .B2(n_0_3_186), .ZN(n_0_99));
   CLKGATE_X1 clk_gate_operator_11_false_operator_11_false_slc_VCOL_x_0_2_itm_1_reg (
      .CK(clk), .E(n_0_99), .GCK(n_0_7));
   DFFR_X1 \VCOL_asn_12_itm_1_reg[6]  (.D(n_0_94), .RN(arst_n), .CK(n_0_7), 
      .Q(VCOL_asn_12_itm_1[6]), .QN());
   AND2_X1 i_0_3_235 (.A1(VCOL_asn_12_itm_1[6]), .A2(n_0_3_454), .ZN(n_0_65));
   NAND2_X1 i_0_3_240 (.A1(n_0_3_454), .A2(n_0_3_276), .ZN(n_0_70));
   CLKGATE_X1 clk_gate_VCOL_asn_24_itm_1_reg (.CK(clk), .E(n_0_70), .GCK(n_0_8));
   DFFR_X1 \VCOL_asn_12_itm_2_reg[6]  (.D(n_0_65), .RN(arst_n), .CK(n_0_8), 
      .Q(VCOL_asn_12_itm_2[6]), .QN());
   OAI22_X1 i_0_3_199 (.A1(n_0_3_449), .A2(n_0_3_249), .B1(vector[7]), .B2(
      n_0_3_250), .ZN(n_0_45));
   DFFR_X1 \VCOL_asn_12_itm_reg[7]  (.D(n_0_45), .RN(arst_n), .CK(n_0_6), 
      .Q(VCOL_asn_12_itm[7]), .QN());
   AND2_X1 i_0_3_248 (.A1(n_0_3_454), .A2(VCOL_asn_12_itm[7]), .ZN(n_0_95));
   DFFR_X1 \VCOL_asn_12_itm_1_reg[7]  (.D(n_0_95), .RN(arst_n), .CK(n_0_7), 
      .Q(VCOL_asn_12_itm_1[7]), .QN());
   AND2_X1 i_0_3_236 (.A1(VCOL_asn_12_itm_1[7]), .A2(n_0_3_454), .ZN(n_0_66));
   DFFR_X1 \VCOL_asn_12_itm_2_reg[7]  (.D(n_0_66), .RN(arst_n), .CK(n_0_8), 
      .Q(VCOL_asn_12_itm_2[7]), .QN());
   OAI22_X1 i_0_3_200 (.A1(n_0_3_450), .A2(n_0_3_249), .B1(vector[8]), .B2(
      n_0_3_250), .ZN(n_0_46));
   DFFR_X1 \VCOL_asn_12_itm_reg[8]  (.D(n_0_46), .RN(arst_n), .CK(n_0_6), 
      .Q(VCOL_asn_12_itm[8]), .QN());
   AND2_X1 i_0_3_249 (.A1(n_0_3_454), .A2(VCOL_asn_12_itm[8]), .ZN(n_0_96));
   DFFR_X1 \VCOL_asn_12_itm_1_reg[8]  (.D(n_0_96), .RN(arst_n), .CK(n_0_7), 
      .Q(VCOL_asn_12_itm_1[8]), .QN());
   AND2_X1 i_0_3_237 (.A1(VCOL_asn_12_itm_1[8]), .A2(n_0_3_454), .ZN(n_0_67));
   DFFR_X1 \VCOL_asn_12_itm_2_reg[8]  (.D(n_0_67), .RN(arst_n), .CK(n_0_8), 
      .Q(VCOL_asn_12_itm_2[8]), .QN());
   OAI22_X1 i_0_3_195 (.A1(n_0_3_445), .A2(n_0_3_249), .B1(vector[3]), .B2(
      n_0_3_250), .ZN(n_0_41));
   DFFR_X1 \VCOL_asn_12_itm_reg[3]  (.D(n_0_41), .RN(arst_n), .CK(n_0_6), 
      .Q(VCOL_asn_12_itm[3]), .QN());
   AND2_X1 i_0_3_244 (.A1(n_0_3_454), .A2(VCOL_asn_12_itm[3]), .ZN(n_0_74));
   DFFR_X1 \VCOL_asn_12_itm_1_reg[3]  (.D(n_0_74), .RN(arst_n), .CK(n_0_7), 
      .Q(VCOL_asn_12_itm_1[3]), .QN());
   AND2_X1 i_0_3_232 (.A1(VCOL_asn_12_itm_1[3]), .A2(n_0_3_454), .ZN(n_0_62));
   DFFR_X1 \VCOL_asn_12_itm_2_reg[3]  (.D(n_0_62), .RN(arst_n), .CK(n_0_8), 
      .Q(VCOL_asn_12_itm_2[3]), .QN());
   NOR4_X1 i_0_3_391 (.A1(VCOL_asn_12_itm_2[6]), .A2(VCOL_asn_12_itm_2[7]), 
      .A3(VCOL_asn_12_itm_2[8]), .A4(VCOL_asn_12_itm_2[3]), .ZN(n_0_3_259));
   OAI22_X1 i_0_3_203 (.A1(n_0_3_451), .A2(n_0_3_249), .B1(vector[9]), .B2(
      n_0_3_250), .ZN(n_0_47));
   DFFR_X1 \VCOL_asn_12_itm_reg[9]  (.D(n_0_47), .RN(arst_n), .CK(n_0_6), 
      .Q(VCOL_asn_12_itm[9]), .QN());
   AND2_X1 i_0_3_250 (.A1(n_0_3_454), .A2(VCOL_asn_12_itm[9]), .ZN(n_0_97));
   DFFR_X1 \VCOL_asn_12_itm_1_reg[9]  (.D(n_0_97), .RN(arst_n), .CK(n_0_7), 
      .Q(VCOL_asn_12_itm_1[9]), .QN());
   AND2_X1 i_0_3_238 (.A1(VCOL_asn_12_itm_1[9]), .A2(n_0_3_454), .ZN(n_0_68));
   DFFR_X1 \VCOL_asn_12_itm_2_reg[9]  (.D(n_0_68), .RN(arst_n), .CK(n_0_8), 
      .Q(VCOL_asn_12_itm_2[9]), .QN());
   OAI22_X1 i_0_3_194 (.A1(n_0_3_444), .A2(n_0_3_249), .B1(vector[2]), .B2(
      n_0_3_250), .ZN(n_0_40));
   DFFR_X1 \VCOL_asn_12_itm_reg[2]  (.D(n_0_40), .RN(arst_n), .CK(n_0_6), 
      .Q(VCOL_asn_12_itm[2]), .QN());
   AND2_X1 i_0_3_243 (.A1(n_0_3_454), .A2(VCOL_asn_12_itm[2]), .ZN(n_0_73));
   DFFR_X1 \VCOL_asn_12_itm_1_reg[2]  (.D(n_0_73), .RN(arst_n), .CK(n_0_7), 
      .Q(VCOL_asn_12_itm_1[2]), .QN());
   AND2_X1 i_0_3_231 (.A1(VCOL_asn_12_itm_1[2]), .A2(n_0_3_454), .ZN(n_0_61));
   DFFR_X1 \VCOL_asn_12_itm_2_reg[2]  (.D(n_0_61), .RN(arst_n), .CK(n_0_8), 
      .Q(VCOL_asn_12_itm_2[2]), .QN());
   AOI21_X1 i_0_3_192 (.A(VROW_y_sva[0]), .B1(
      EdgeDetect_IP_EdgeDetect_VerDer_run_run_fsm_inst_state_var[1]), .B2(
      n_0_3_476), .ZN(n_0_3_170));
   AOI211_X1 i_0_3_191 (.A(rst), .B(n_0_3_170), .C1(VROW_y_sva[0]), .C2(
      n_0_3_330), .ZN(n_0_38));
   DFFR_X1 \VCOL_asn_12_itm_reg[0]  (.D(n_0_38), .RN(arst_n), .CK(n_0_6), 
      .Q(VCOL_asn_12_itm[0]), .QN());
   AND2_X1 i_0_3_241 (.A1(n_0_3_454), .A2(VCOL_asn_12_itm[0]), .ZN(n_0_71));
   DFFR_X1 \VCOL_asn_12_itm_1_reg[0]  (.D(n_0_71), .RN(arst_n), .CK(n_0_7), 
      .Q(VCOL_asn_12_itm_1[0]), .QN());
   AND2_X1 i_0_3_211 (.A1(VCOL_asn_12_itm_1[0]), .A2(n_0_3_454), .ZN(n_0_59));
   DFFR_X1 \VCOL_asn_12_itm_2_reg[0]  (.D(n_0_59), .RN(arst_n), .CK(n_0_8), 
      .Q(VCOL_asn_12_itm_2[0]), .QN());
   OAI22_X1 i_0_3_193 (.A1(n_0_3_443), .A2(n_0_3_249), .B1(vector[1]), .B2(
      n_0_3_250), .ZN(n_0_39));
   DFFR_X1 \VCOL_asn_12_itm_reg[1]  (.D(n_0_39), .RN(arst_n), .CK(n_0_6), 
      .Q(VCOL_asn_12_itm[1]), .QN());
   AND2_X1 i_0_3_242 (.A1(n_0_3_454), .A2(VCOL_asn_12_itm[1]), .ZN(n_0_72));
   DFFR_X1 \VCOL_asn_12_itm_1_reg[1]  (.D(n_0_72), .RN(arst_n), .CK(n_0_7), 
      .Q(VCOL_asn_12_itm_1[1]), .QN());
   AND2_X1 i_0_3_230 (.A1(VCOL_asn_12_itm_1[1]), .A2(n_0_3_454), .ZN(n_0_60));
   DFFR_X1 \VCOL_asn_12_itm_2_reg[1]  (.D(n_0_60), .RN(arst_n), .CK(n_0_8), 
      .Q(VCOL_asn_12_itm_2[1]), .QN());
   OAI22_X1 i_0_3_196 (.A1(n_0_3_446), .A2(n_0_3_249), .B1(vector[4]), .B2(
      n_0_3_250), .ZN(n_0_42));
   DFFR_X1 \VCOL_asn_12_itm_reg[4]  (.D(n_0_42), .RN(arst_n), .CK(n_0_6), 
      .Q(VCOL_asn_12_itm[4]), .QN());
   AND2_X1 i_0_3_245 (.A1(n_0_3_454), .A2(VCOL_asn_12_itm[4]), .ZN(n_0_75));
   DFFR_X1 \VCOL_asn_12_itm_1_reg[4]  (.D(n_0_75), .RN(arst_n), .CK(n_0_7), 
      .Q(VCOL_asn_12_itm_1[4]), .QN());
   AND2_X1 i_0_3_233 (.A1(VCOL_asn_12_itm_1[4]), .A2(n_0_3_454), .ZN(n_0_63));
   DFFR_X1 \VCOL_asn_12_itm_2_reg[4]  (.D(n_0_63), .RN(arst_n), .CK(n_0_8), 
      .Q(VCOL_asn_12_itm_2[4]), .QN());
   OAI22_X1 i_0_3_197 (.A1(n_0_3_447), .A2(n_0_3_249), .B1(vector[5]), .B2(
      n_0_3_250), .ZN(n_0_43));
   DFFR_X1 \VCOL_asn_12_itm_reg[5]  (.D(n_0_43), .RN(arst_n), .CK(n_0_6), 
      .Q(VCOL_asn_12_itm[5]), .QN());
   INV_X1 i_0_3_614 (.A(VCOL_asn_12_itm[5]), .ZN(n_0_3_452));
   NOR2_X1 i_0_3_246 (.A1(rst), .A2(n_0_3_452), .ZN(n_0_93));
   DFFR_X1 \VCOL_asn_12_itm_1_reg[5]  (.D(n_0_93), .RN(arst_n), .CK(n_0_7), 
      .Q(VCOL_asn_12_itm_1[5]), .QN());
   AND2_X1 i_0_3_234 (.A1(VCOL_asn_12_itm_1[5]), .A2(n_0_3_454), .ZN(n_0_64));
   DFFR_X1 \VCOL_asn_12_itm_2_reg[5]  (.D(n_0_64), .RN(arst_n), .CK(n_0_8), 
      .Q(VCOL_asn_12_itm_2[5]), .QN());
   OR4_X1 i_0_3_390 (.A1(VCOL_asn_12_itm_2[0]), .A2(VCOL_asn_12_itm_2[1]), 
      .A3(VCOL_asn_12_itm_2[4]), .A4(VCOL_asn_12_itm_2[5]), .ZN(n_0_3_258));
   NOR3_X1 i_0_3_389 (.A1(VCOL_asn_12_itm_2[9]), .A2(VCOL_asn_12_itm_2[2]), 
      .A3(n_0_3_258), .ZN(n_0_3_257));
   AOI211_X1 i_0_3_388 (.A(n_0_3_440), .B(n_0_3_330), .C1(n_0_3_259), .C2(
      n_0_3_257), .ZN(n_0_3_256));
   INV_X1 i_0_3_387 (.A(n_0_3_256), .ZN(n_0_3_255));
   NOR2_X1 i_0_3_190 (.A1(rst), .A2(n_0_3_255), .ZN(n_0_37));
   DFFR_X1 reg_dat_out_rsci_oswt_cse_reg (.D(n_0_37), .RN(arst_n), .CK(n_0_6), 
      .Q(reg_dat_out_rsci_oswt_cse), .QN());
   EdgeDetect_IP_EdgeDetect_VerDer_run_dy_rsci EdgeDetect_IP_EdgeDetect_VerDer_run_dy_rsci_inst (
      .clk(clk), .rst(rst), .arst_n(arst_n), .dy_rsc_dat(), .dy_rsc_vld(
      dy_rsc_vld), .dy_rsc_rdy(dy_rsc_rdy), .run_wen(run_wen), .dy_rsci_oswt(
      reg_dat_out_rsci_oswt_cse), .dy_rsci_wen_comp(dy_rsci_wen_comp), 
      .dy_rsci_idat());
   EdgeDetect_IP_EdgeDetect_VerDer_run_dat_rgb_rsci EdgeDetect_IP_EdgeDetect_VerDer_run_dat_rgb_rsci_inst (
      .clk(clk), .rst(rst), .arst_n(arst_n), .dat_rgb_rsc_dat(), 
      .dat_rgb_rsc_vld(dat_rgb_rsc_vld), .dat_rgb_rsc_rdy(dat_rgb_rsc_rdy), 
      .run_wen(run_wen), .dat_rgb_rsci_oswt(reg_dat_out_rsci_oswt_cse), 
      .dat_rgb_rsci_wen_comp(dat_rgb_rsci_wen_comp), .dat_rgb_rsci_idat({1'b0, 
      1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, uc_0, uc_1, uc_2, 
      uc_3, uc_4, uc_5, uc_6, uc_7, uc_8, uc_9, uc_10, uc_11, uc_12, uc_13, 
      uc_14, uc_15, uc_16, uc_17, uc_18, uc_19, uc_20, uc_21, uc_22, uc_23}));
   EdgeDetect_IP_EdgeDetect_VerDer_run_dat_out_rsci EdgeDetect_IP_EdgeDetect_VerDer_run_dat_out_rsci_inst (
      .clk(clk), .rst(rst), .arst_n(arst_n), .dat_out_rsc_dat(), 
      .dat_out_rsc_vld(dat_out_rsc_vld), .dat_out_rsc_rdy(dat_out_rsc_rdy), 
      .run_wen(run_wen), .dat_out_rsci_oswt(reg_dat_out_rsci_oswt_cse), 
      .dat_out_rsci_wen_comp(dat_out_rsci_wen_comp), .dat_out_rsci_idat());
   NAND4_X1 i_0_3_469 (.A1(dat_in_rsci_wen_comp), .A2(dy_rsci_wen_comp), 
      .A3(dat_rgb_rsci_wen_comp), .A4(dat_out_rsci_wen_comp), .ZN(n_0_3_331));
   INV_X1 i_0_3_466 (.A(n_0_3_331), .ZN(run_wen));
   INV_X1 i_0_3_655 (.A(VROW_y_sva[0]), .ZN(vector[0]));
   HA_X1 i_0_3_9 (.A(vector[0]), .B(heightIn[0]), .CO(n_0_3_10), .S(n_0_3_9));
   FA_X1 i_0_3_10 (.A(vector[1]), .B(heightIn[1]), .CI(n_0_3_10), .CO(n_0_3_12), 
      .S(n_0_3_11));
   FA_X1 i_0_3_11 (.A(vector[2]), .B(heightIn[2]), .CI(n_0_3_12), .CO(n_0_3_14), 
      .S(n_0_3_13));
   FA_X1 i_0_3_12 (.A(vector[3]), .B(heightIn[3]), .CI(n_0_3_14), .CO(n_0_3_16), 
      .S(n_0_3_15));
   FA_X1 i_0_3_13 (.A(vector[4]), .B(heightIn[4]), .CI(n_0_3_16), .CO(n_0_3_18), 
      .S(n_0_3_17));
   FA_X1 i_0_3_14 (.A(vector[5]), .B(heightIn[5]), .CI(n_0_3_18), .CO(n_0_3_20), 
      .S(n_0_3_19));
   FA_X1 i_0_3_15 (.A(vector[6]), .B(heightIn[6]), .CI(n_0_3_20), .CO(n_0_3_22), 
      .S(n_0_3_21));
   FA_X1 i_0_3_16 (.A(vector[7]), .B(heightIn[7]), .CI(n_0_3_22), .CO(n_0_3_24), 
      .S(n_0_3_23));
   FA_X1 i_0_3_17 (.A(vector[8]), .B(heightIn[8]), .CI(n_0_3_24), .CO(n_0_3_26), 
      .S(n_0_3_25));
   FA_X1 i_0_3_18 (.A(vector[9]), .B(heightIn[9]), .CI(n_0_3_26), .CO(n_0_3_28), 
      .S(n_0_3_27));
   INV_X1 i_0_3_599 (.A(n_0_3_28), .ZN(n_0_3_456));
   NOR3_X1 i_0_3_215 (.A1(n_0_3_456), .A2(n_0_3_250), .A3(n_0_3_186), .ZN(n_0_51));
   DFFR_X1 reg_dat_in_rsci_oswt_cse_reg (.D(n_0_51), .RN(arst_n), .CK(n_0_6), 
      .Q(reg_dat_in_rsci_oswt_cse), .QN());
   EdgeDetect_IP_EdgeDetect_VerDer_run_dat_in_rsci EdgeDetect_IP_EdgeDetect_VerDer_run_dat_in_rsci_inst (
      .dat_in_rsc_dat(), .dat_in_rsc_vld(dat_in_rsc_vld), .dat_in_rsc_rdy(
      dat_in_rsc_rdy), .run_wen(run_wen), .dat_in_rsci_oswt(
      reg_dat_in_rsci_oswt_cse), .dat_in_rsci_wen_comp(dat_in_rsci_wen_comp), 
      .dat_in_rsci_idat_mxwt());
   NOR3_X1 i_0_3_398 (.A1(n_0_3_472), .A2(n_0_3_456), .A3(n_0_3_327), .ZN(
      n_0_3_264));
   NOR4_X1 i_0_3_402 (.A1(VCOL_asn_12_itm_1[9]), .A2(VCOL_asn_12_itm_1[2]), 
      .A3(VCOL_asn_12_itm_1[8]), .A4(VCOL_asn_12_itm_1[3]), .ZN(n_0_3_268));
   NOR4_X1 i_0_3_401 (.A1(VCOL_asn_12_itm_1[0]), .A2(VCOL_asn_12_itm_1[1]), 
      .A3(VCOL_asn_12_itm_1[4]), .A4(VCOL_asn_12_itm_1[7]), .ZN(n_0_3_267));
   NAND2_X1 i_0_3_400 (.A1(n_0_3_268), .A2(n_0_3_267), .ZN(n_0_3_266));
   NOR3_X1 i_0_3_399 (.A1(VCOL_asn_12_itm_1[5]), .A2(VCOL_asn_12_itm_1[6]), 
      .A3(n_0_3_266), .ZN(n_0_3_265));
   NAND3_X1 i_0_3_396 (.A1(n_0_3_279), .A2(n_0_3_264), .A3(n_0_3_265), .ZN(
      n_0_3_263));
   INV_X1 i_0_3_393 (.A(n_0_3_263), .ZN(n_0_3_262));
   OAI21_X1 i_0_3_228 (.A(n_0_3_454), .B1(n_0_3_276), .B2(n_0_3_262), .ZN(n_0_58));
   NOR2_X1 i_0_3_227 (.A1(n_0_3_471), .A2(rst), .ZN(n_0_57));
   MUX2_X1 reg_operator_11_false_operator_11_false_slc_VCOL_x_0_9_itm_1_cse_reg_enable_mux_0 (
      .A(reg_operator_11_false_operator_11_false_slc_VCOL_x_0_9_itm_1_cse), 
      .B(n_0_57), .S(n_0_58), .Z(n_0_11));
   DFFR_X1 reg_operator_11_false_operator_11_false_slc_VCOL_x_0_9_itm_1_cse_reg (
      .D(n_0_11), .RN(arst_n), .CK(clk), .Q(
      reg_operator_11_false_operator_11_false_slc_VCOL_x_0_9_itm_1_cse), .QN());
   INV_X1 i_0_3_627 (.A(
      reg_operator_11_false_operator_11_false_slc_VCOL_x_0_9_itm_1_cse), 
      .ZN(n_0_3_488));
   AOI21_X1 i_0_3_425 (.A(n_0_3_289), .B1(widthIn[9]), .B2(n_0_3_458), .ZN(
      n_0_3_286));
   AOI22_X1 i_0_3_426 (.A1(n_0_3_460), .A2(
      line_buf0_r_pixelType_rsci_adr_d_pff[8]), .B1(n_0_3_312), .B2(n_0_3_288), 
      .ZN(n_0_3_287));
   NOR3_X1 i_0_3_424 (.A1(n_0_3_311), .A2(n_0_3_286), .A3(n_0_3_287), .ZN(
      n_0_3_285));
   AOI21_X1 i_0_3_423 (.A(n_0_3_285), .B1(n_0_3_287), .B2(n_0_3_286), .ZN(
      n_0_3_284));
   NOR3_X1 i_0_3_239 (.A1(n_0_3_291), .A2(n_0_3_284), .A3(rst), .ZN(n_0_69));
   DFFR_X1 VCOL_asn_24_itm_1_reg (.D(n_0_69), .RN(arst_n), .CK(n_0_8), .Q(
      VCOL_asn_24_itm_1), .QN());
   INV_X1 i_0_3_600 (.A(VCOL_asn_24_itm_1), .ZN(n_0_3_457));
   NAND3_X1 i_0_3_405 (.A1(VCOL_stage_0_3), .A2(n_0_3_457), .A3(n_0_3_488), 
      .ZN(n_0_3_271));
   INV_X1 i_0_3_404 (.A(n_0_3_271), .ZN(n_0_3_270));
   NAND3_X1 i_0_3_403 (.A1(VCOL_x_sva[0]), .A2(run_wen), .A3(n_0_3_270), 
      .ZN(n_0_3_269));
   NAND2_X1 i_0_3_397 (.A1(VCOL_stage_0_2), .A2(n_0_3_263), .ZN(n_0_3_261));
   NAND2_X1 i_0_3_392 (.A1(n_0_3_475), .A2(VCOL_stage_0_1), .ZN(n_0_3_260));
   AOI21_X1 i_0_3_395 (.A(n_0_3_269), .B1(n_0_3_261), .B2(n_0_3_260), .ZN(
      and_160_cse));
   CLKGATE_X1 clk_gate_rdbuf0_pix_r_pixelType_lpi_3_reg__0 (.CK(clk), .E(
      and_160_cse), .GCK(n_0_0));
   DFF_X1 \rdbuf0_pix_g_pixelType_lpi_3_reg[15]  (.D(
      line_buf0_g_pixelType_rsci_q_d[15]), .CK(n_0_0), .Q(
      rdbuf0_pix_g_pixelType_lpi_3_reg[15]), .QN());
   AOI22_X1 i_0_3_575 (.A1(n_0_3_488), .A2(line_buf0_g_pixelType_rsci_q_d[7]), 
      .B1(reg_operator_11_false_operator_11_false_slc_VCOL_x_0_9_itm_1_cse), 
      .B2(rdbuf0_pix_g_pixelType_lpi_3_reg[15]), .ZN(n_0_3_419));
   INV_X1 i_0_3_568 (.A(n_0_3_419), .ZN(MUX_v_8_2_24_return[7]));
   DFF_X1 \rdbuf0_pix_r_pixelType_lpi_3_reg[15]  (.D(
      line_buf0_r_pixelType_rsci_q_d[15]), .CK(n_0_0), .Q(
      rdbuf0_pix_r_pixelType_lpi_3_reg[15]), .QN());
   AOI22_X1 i_0_3_587 (.A1(n_0_3_488), .A2(line_buf0_r_pixelType_rsci_q_d[7]), 
      .B1(reg_operator_11_false_operator_11_false_slc_VCOL_x_0_9_itm_1_cse), 
      .B2(rdbuf0_pix_r_pixelType_lpi_3_reg[15]), .ZN(n_0_3_442));
   INV_X1 i_0_3_586 (.A(n_0_3_442), .ZN(MUX_v_8_2_22_return[7]));
   DFF_X1 \rdbuf0_pix_b_pixelType_lpi_3_reg[15]  (.D(
      line_buf0_b_pixelType_rsci_q_d[15]), .CK(n_0_0), .Q(
      rdbuf0_pix_b_pixelType_lpi_3_reg[15]), .QN());
   AOI22_X1 i_0_3_567 (.A1(n_0_3_488), .A2(line_buf0_b_pixelType_rsci_q_d[7]), 
      .B1(reg_operator_11_false_operator_11_false_slc_VCOL_x_0_9_itm_1_cse), 
      .B2(rdbuf0_pix_b_pixelType_lpi_3_reg[15]), .ZN(n_0_3_416));
   INV_X1 i_0_3_563 (.A(n_0_3_416), .ZN(MUX_v_8_2_23_return[7]));
   DFF_X1 \rdbuf0_pix_g_pixelType_lpi_3_reg[14]  (.D(
      line_buf0_g_pixelType_rsci_q_d[14]), .CK(n_0_0), .Q(
      rdbuf0_pix_g_pixelType_lpi_3_reg[14]), .QN());
   AOI22_X1 i_0_3_558 (.A1(n_0_3_488), .A2(line_buf0_g_pixelType_rsci_q_d[6]), 
      .B1(reg_operator_11_false_operator_11_false_slc_VCOL_x_0_9_itm_1_cse), 
      .B2(rdbuf0_pix_g_pixelType_lpi_3_reg[14]), .ZN(n_0_3_407));
   INV_X1 i_0_3_553 (.A(n_0_3_407), .ZN(MUX_v_8_2_24_return[6]));
   FA_X1 i_0_3_56 (.A(MUX_v_8_2_22_return[7]), .B(MUX_v_8_2_23_return[7]), 
      .CI(MUX_v_8_2_24_return[6]), .CO(n_0_3_95), .S(n_0_3_94));
   DFF_X1 \rdbuf0_pix_r_pixelType_lpi_3_reg[14]  (.D(
      line_buf0_r_pixelType_rsci_q_d[14]), .CK(n_0_0), .Q(
      rdbuf0_pix_r_pixelType_lpi_3_reg[14]), .QN());
   AOI22_X1 i_0_3_562 (.A1(n_0_3_488), .A2(line_buf0_r_pixelType_rsci_q_d[6]), 
      .B1(reg_operator_11_false_operator_11_false_slc_VCOL_x_0_9_itm_1_cse), 
      .B2(rdbuf0_pix_r_pixelType_lpi_3_reg[14]), .ZN(n_0_3_411));
   INV_X1 i_0_3_559 (.A(n_0_3_411), .ZN(MUX_v_8_2_22_return[6]));
   DFF_X1 \rdbuf0_pix_b_pixelType_lpi_3_reg[14]  (.D(
      line_buf0_b_pixelType_rsci_q_d[14]), .CK(n_0_0), .Q(
      rdbuf0_pix_b_pixelType_lpi_3_reg[14]), .QN());
   AOI22_X1 i_0_3_552 (.A1(n_0_3_488), .A2(line_buf0_b_pixelType_rsci_q_d[6]), 
      .B1(reg_operator_11_false_operator_11_false_slc_VCOL_x_0_9_itm_1_cse), 
      .B2(rdbuf0_pix_b_pixelType_lpi_3_reg[14]), .ZN(n_0_3_404));
   INV_X1 i_0_3_551 (.A(n_0_3_404), .ZN(MUX_v_8_2_23_return[6]));
   DFF_X1 \rdbuf0_pix_g_pixelType_lpi_3_reg[13]  (.D(
      line_buf0_g_pixelType_rsci_q_d[13]), .CK(n_0_0), .Q(
      rdbuf0_pix_g_pixelType_lpi_3_reg[13]), .QN());
   AOI22_X1 i_0_3_545 (.A1(n_0_3_488), .A2(line_buf0_g_pixelType_rsci_q_d[5]), 
      .B1(reg_operator_11_false_operator_11_false_slc_VCOL_x_0_9_itm_1_cse), 
      .B2(rdbuf0_pix_g_pixelType_lpi_3_reg[13]), .ZN(n_0_3_395));
   INV_X1 i_0_3_544 (.A(n_0_3_395), .ZN(MUX_v_8_2_24_return[5]));
   FA_X1 i_0_3_55 (.A(MUX_v_8_2_22_return[6]), .B(MUX_v_8_2_23_return[6]), 
      .CI(MUX_v_8_2_24_return[5]), .CO(n_0_3_93), .S(n_0_3_92));
   DFF_X1 \rdbuf0_pix_r_pixelType_lpi_3_reg[13]  (.D(
      line_buf0_r_pixelType_rsci_q_d[13]), .CK(n_0_0), .Q(
      rdbuf0_pix_r_pixelType_lpi_3_reg[13]), .QN());
   AOI22_X1 i_0_3_550 (.A1(n_0_3_488), .A2(line_buf0_r_pixelType_rsci_q_d[5]), 
      .B1(reg_operator_11_false_operator_11_false_slc_VCOL_x_0_9_itm_1_cse), 
      .B2(rdbuf0_pix_r_pixelType_lpi_3_reg[13]), .ZN(n_0_3_399));
   INV_X1 i_0_3_549 (.A(n_0_3_399), .ZN(MUX_v_8_2_22_return[5]));
   DFF_X1 \rdbuf0_pix_b_pixelType_lpi_3_reg[13]  (.D(
      line_buf0_b_pixelType_rsci_q_d[13]), .CK(n_0_0), .Q(
      rdbuf0_pix_b_pixelType_lpi_3_reg[13]), .QN());
   AOI22_X1 i_0_3_541 (.A1(n_0_3_488), .A2(line_buf0_b_pixelType_rsci_q_d[5]), 
      .B1(reg_operator_11_false_operator_11_false_slc_VCOL_x_0_9_itm_1_cse), 
      .B2(rdbuf0_pix_b_pixelType_lpi_3_reg[13]), .ZN(n_0_3_392));
   INV_X1 i_0_3_540 (.A(n_0_3_392), .ZN(MUX_v_8_2_23_return[5]));
   DFF_X1 \rdbuf0_pix_g_pixelType_lpi_3_reg[12]  (.D(
      line_buf0_g_pixelType_rsci_q_d[12]), .CK(n_0_0), .Q(
      rdbuf0_pix_g_pixelType_lpi_3_reg[12]), .QN());
   AOI22_X1 i_0_3_528 (.A1(n_0_3_488), .A2(line_buf0_g_pixelType_rsci_q_d[4]), 
      .B1(reg_operator_11_false_operator_11_false_slc_VCOL_x_0_9_itm_1_cse), 
      .B2(rdbuf0_pix_g_pixelType_lpi_3_reg[12]), .ZN(n_0_3_383));
   INV_X1 i_0_3_523 (.A(n_0_3_383), .ZN(MUX_v_8_2_24_return[4]));
   FA_X1 i_0_3_54 (.A(MUX_v_8_2_22_return[5]), .B(MUX_v_8_2_23_return[5]), 
      .CI(MUX_v_8_2_24_return[4]), .CO(n_0_3_91), .S(n_0_3_90));
   DFF_X1 \rdbuf0_pix_r_pixelType_lpi_3_reg[12]  (.D(
      line_buf0_r_pixelType_rsci_q_d[12]), .CK(n_0_0), .Q(
      rdbuf0_pix_r_pixelType_lpi_3_reg[12]), .QN());
   AOI22_X1 i_0_3_532 (.A1(n_0_3_488), .A2(line_buf0_r_pixelType_rsci_q_d[4]), 
      .B1(reg_operator_11_false_operator_11_false_slc_VCOL_x_0_9_itm_1_cse), 
      .B2(rdbuf0_pix_r_pixelType_lpi_3_reg[12]), .ZN(n_0_3_387));
   INV_X1 i_0_3_529 (.A(n_0_3_387), .ZN(MUX_v_8_2_22_return[4]));
   DFF_X1 \rdbuf0_pix_b_pixelType_lpi_3_reg[12]  (.D(
      line_buf0_b_pixelType_rsci_q_d[12]), .CK(n_0_0), .Q(
      rdbuf0_pix_b_pixelType_lpi_3_reg[12]), .QN());
   AOI22_X1 i_0_3_522 (.A1(n_0_3_488), .A2(line_buf0_b_pixelType_rsci_q_d[4]), 
      .B1(reg_operator_11_false_operator_11_false_slc_VCOL_x_0_9_itm_1_cse), 
      .B2(rdbuf0_pix_b_pixelType_lpi_3_reg[12]), .ZN(n_0_3_380));
   INV_X1 i_0_3_518 (.A(n_0_3_380), .ZN(MUX_v_8_2_23_return[4]));
   DFF_X1 \rdbuf0_pix_g_pixelType_lpi_3_reg[11]  (.D(
      line_buf0_g_pixelType_rsci_q_d[11]), .CK(n_0_0), .Q(
      rdbuf0_pix_g_pixelType_lpi_3_reg[11]), .QN());
   AOI22_X1 i_0_3_513 (.A1(n_0_3_488), .A2(line_buf0_g_pixelType_rsci_q_d[3]), 
      .B1(reg_operator_11_false_operator_11_false_slc_VCOL_x_0_9_itm_1_cse), 
      .B2(rdbuf0_pix_g_pixelType_lpi_3_reg[11]), .ZN(n_0_3_371));
   INV_X1 i_0_3_508 (.A(n_0_3_371), .ZN(MUX_v_8_2_24_return[3]));
   FA_X1 i_0_3_53 (.A(MUX_v_8_2_22_return[4]), .B(MUX_v_8_2_23_return[4]), 
      .CI(MUX_v_8_2_24_return[3]), .CO(n_0_3_89), .S(n_0_3_88));
   DFF_X1 \rdbuf0_pix_r_pixelType_lpi_3_reg[11]  (.D(
      line_buf0_r_pixelType_rsci_q_d[11]), .CK(n_0_0), .Q(
      rdbuf0_pix_r_pixelType_lpi_3_reg[11]), .QN());
   AOI22_X1 i_0_3_517 (.A1(n_0_3_488), .A2(line_buf0_r_pixelType_rsci_q_d[3]), 
      .B1(reg_operator_11_false_operator_11_false_slc_VCOL_x_0_9_itm_1_cse), 
      .B2(rdbuf0_pix_r_pixelType_lpi_3_reg[11]), .ZN(n_0_3_375));
   INV_X1 i_0_3_514 (.A(n_0_3_375), .ZN(MUX_v_8_2_22_return[3]));
   DFF_X1 \rdbuf0_pix_b_pixelType_lpi_3_reg[11]  (.D(
      line_buf0_b_pixelType_rsci_q_d[11]), .CK(n_0_0), .Q(
      rdbuf0_pix_b_pixelType_lpi_3_reg[11]), .QN());
   AOI22_X1 i_0_3_507 (.A1(n_0_3_488), .A2(line_buf0_b_pixelType_rsci_q_d[3]), 
      .B1(reg_operator_11_false_operator_11_false_slc_VCOL_x_0_9_itm_1_cse), 
      .B2(rdbuf0_pix_b_pixelType_lpi_3_reg[11]), .ZN(n_0_3_368));
   INV_X1 i_0_3_506 (.A(n_0_3_368), .ZN(MUX_v_8_2_23_return[3]));
   DFF_X1 \rdbuf0_pix_g_pixelType_lpi_3_reg[10]  (.D(
      line_buf0_g_pixelType_rsci_q_d[10]), .CK(n_0_0), .Q(
      rdbuf0_pix_g_pixelType_lpi_3_reg[10]), .QN());
   AOI22_X1 i_0_3_494 (.A1(n_0_3_488), .A2(line_buf0_g_pixelType_rsci_q_d[2]), 
      .B1(reg_operator_11_false_operator_11_false_slc_VCOL_x_0_9_itm_1_cse), 
      .B2(rdbuf0_pix_g_pixelType_lpi_3_reg[10]), .ZN(n_0_3_353));
   INV_X1 i_0_3_493 (.A(n_0_3_353), .ZN(MUX_v_8_2_24_return[2]));
   FA_X1 i_0_3_52 (.A(MUX_v_8_2_22_return[3]), .B(MUX_v_8_2_23_return[3]), 
      .CI(MUX_v_8_2_24_return[2]), .CO(n_0_3_87), .S(n_0_3_86));
   DFF_X1 \rdbuf0_pix_r_pixelType_lpi_3_reg[10]  (.D(
      line_buf0_r_pixelType_rsci_q_d[10]), .CK(n_0_0), .Q(
      rdbuf0_pix_r_pixelType_lpi_3_reg[10]), .QN());
   AOI22_X1 i_0_3_498 (.A1(n_0_3_488), .A2(line_buf0_r_pixelType_rsci_q_d[2]), 
      .B1(reg_operator_11_false_operator_11_false_slc_VCOL_x_0_9_itm_1_cse), 
      .B2(rdbuf0_pix_r_pixelType_lpi_3_reg[10]), .ZN(n_0_3_356));
   INV_X1 i_0_3_497 (.A(n_0_3_356), .ZN(MUX_v_8_2_22_return[2]));
   DFF_X1 \rdbuf0_pix_b_pixelType_lpi_3_reg[10]  (.D(
      line_buf0_b_pixelType_rsci_q_d[10]), .CK(n_0_0), .Q(
      rdbuf0_pix_b_pixelType_lpi_3_reg[10]), .QN());
   AOI22_X1 i_0_3_472 (.A1(n_0_3_488), .A2(line_buf0_b_pixelType_rsci_q_d[2]), 
      .B1(reg_operator_11_false_operator_11_false_slc_VCOL_x_0_9_itm_1_cse), 
      .B2(rdbuf0_pix_b_pixelType_lpi_3_reg[10]), .ZN(n_0_3_344));
   INV_X1 i_0_3_471 (.A(n_0_3_344), .ZN(MUX_v_8_2_23_return[2]));
   DFF_X1 \rdbuf0_pix_g_pixelType_lpi_3_reg[9]  (.D(
      line_buf0_g_pixelType_rsci_q_d[9]), .CK(n_0_0), .Q(
      rdbuf0_pix_g_pixelType_lpi_3_reg[9]), .QN());
   NAND2_X1 i_0_3_485 (.A1(
      reg_operator_11_false_operator_11_false_slc_VCOL_x_0_9_itm_1_cse), 
      .A2(rdbuf0_pix_g_pixelType_lpi_3_reg[9]), .ZN(n_0_3_350));
   INV_X1 i_0_3_621 (.A(line_buf0_g_pixelType_rsci_q_d[1]), .ZN(n_0_3_480));
   OAI21_X1 i_0_3_481 (.A(n_0_3_350), .B1(
      reg_operator_11_false_operator_11_false_slc_VCOL_x_0_9_itm_1_cse), 
      .B2(n_0_3_480), .ZN(MUX_v_8_2_24_return[1]));
   FA_X1 i_0_3_51 (.A(MUX_v_8_2_22_return[2]), .B(MUX_v_8_2_23_return[2]), 
      .CI(MUX_v_8_2_24_return[1]), .CO(n_0_3_85), .S(n_0_85));
   HA_X1 i_0_3_57 (.A(n_0_3_85), .B(n_0_3_86), .CO(n_0_3_96), .S(n_0_86));
   FA_X1 i_0_3_58 (.A(n_0_3_87), .B(n_0_3_88), .CI(n_0_3_96), .CO(n_0_3_97), 
      .S(n_0_87));
   FA_X1 i_0_3_59 (.A(n_0_3_89), .B(n_0_3_90), .CI(n_0_3_97), .CO(n_0_3_98), 
      .S(n_0_88));
   FA_X1 i_0_3_60 (.A(n_0_3_91), .B(n_0_3_92), .CI(n_0_3_98), .CO(n_0_3_99), 
      .S(n_0_89));
   FA_X1 i_0_3_61 (.A(n_0_3_93), .B(n_0_3_94), .CI(n_0_3_99), .CO(n_0_3_100), 
      .S(n_0_90));
   FA_X1 i_0_3_62 (.A(MUX_v_8_2_24_return[7]), .B(n_0_3_95), .CI(n_0_3_100), 
      .CO(n_0_92), .S(n_0_91));
   NOR2_X1 i_0_3_386 (.A1(n_0_3_331), .A2(n_0_3_255), .ZN(VCOL_if_5_and_cse));
   CLKGATE_X1 clk_gate_dy_rsci_idat_reg (.CK(clk), .E(VCOL_if_5_and_cse), 
      .GCK(n_0_10));
   DFF_X1 \dat_out_rsci_idat_reg[7]  (.D(n_0_92), .CK(n_0_10), .Q(
      dat_out_rsc_dat[7]), .QN());
   DFF_X1 \dat_out_rsci_idat_reg[6]  (.D(n_0_91), .CK(n_0_10), .Q(
      dat_out_rsc_dat[6]), .QN());
   DFF_X1 \dat_out_rsci_idat_reg[5]  (.D(n_0_90), .CK(n_0_10), .Q(
      dat_out_rsc_dat[5]), .QN());
   DFF_X1 \dat_out_rsci_idat_reg[4]  (.D(n_0_89), .CK(n_0_10), .Q(
      dat_out_rsc_dat[4]), .QN());
   DFF_X1 \dat_out_rsci_idat_reg[3]  (.D(n_0_88), .CK(n_0_10), .Q(
      dat_out_rsc_dat[3]), .QN());
   DFF_X1 \dat_out_rsci_idat_reg[2]  (.D(n_0_87), .CK(n_0_10), .Q(
      dat_out_rsc_dat[2]), .QN());
   DFF_X1 \dat_out_rsci_idat_reg[1]  (.D(n_0_86), .CK(n_0_10), .Q(
      dat_out_rsc_dat[1]), .QN());
   DFF_X1 \dat_out_rsci_idat_reg[0]  (.D(n_0_85), .CK(n_0_10), .Q(
      dat_out_rsc_dat[0]), .QN());
   NOR2_X1 i_0_3_112 (.A1(
      reg_operator_11_false_operator_11_false_slc_VCOL_x_0_9_itm_1_cse), 
      .A2(n_0_3_256), .ZN(n_0_3_137));
   NAND2_X1 i_0_3_78 (.A1(line_buf0_b_pixelType_rsci_q_d[15]), .A2(n_0_3_137), 
      .ZN(n_0_3_119));
   OAI21_X1 i_0_3_77 (.A(n_0_3_119), .B1(n_0_3_416), .B2(n_0_3_137), .ZN(
      MUX_v_8_2_26_return[7]));
   DFF_X1 \dat_rgb_rsci_idat_23_16_reg[7]  (.D(MUX_v_8_2_26_return[7]), .CK(
      n_0_10), .Q(dat_rgb_rsc_dat[23]), .QN());
   NAND2_X1 i_0_3_76 (.A1(line_buf0_b_pixelType_rsci_q_d[14]), .A2(n_0_3_137), 
      .ZN(n_0_3_118));
   OAI21_X1 i_0_3_75 (.A(n_0_3_118), .B1(n_0_3_404), .B2(n_0_3_137), .ZN(
      MUX_v_8_2_26_return[6]));
   DFF_X1 \dat_rgb_rsci_idat_23_16_reg[6]  (.D(MUX_v_8_2_26_return[6]), .CK(
      n_0_10), .Q(dat_rgb_rsc_dat[22]), .QN());
   NAND2_X1 i_0_3_74 (.A1(line_buf0_b_pixelType_rsci_q_d[13]), .A2(n_0_3_137), 
      .ZN(n_0_3_117));
   OAI21_X1 i_0_3_73 (.A(n_0_3_117), .B1(n_0_3_392), .B2(n_0_3_137), .ZN(
      MUX_v_8_2_26_return[5]));
   DFF_X1 \dat_rgb_rsci_idat_23_16_reg[5]  (.D(MUX_v_8_2_26_return[5]), .CK(
      n_0_10), .Q(dat_rgb_rsc_dat[21]), .QN());
   NAND2_X1 i_0_3_72 (.A1(line_buf0_b_pixelType_rsci_q_d[12]), .A2(n_0_3_137), 
      .ZN(n_0_3_116));
   OAI21_X1 i_0_3_71 (.A(n_0_3_116), .B1(n_0_3_380), .B2(n_0_3_137), .ZN(
      MUX_v_8_2_26_return[4]));
   DFF_X1 \dat_rgb_rsci_idat_23_16_reg[4]  (.D(MUX_v_8_2_26_return[4]), .CK(
      n_0_10), .Q(dat_rgb_rsc_dat[20]), .QN());
   NAND2_X1 i_0_3_70 (.A1(line_buf0_b_pixelType_rsci_q_d[11]), .A2(n_0_3_137), 
      .ZN(n_0_3_115));
   OAI21_X1 i_0_3_69 (.A(n_0_3_115), .B1(n_0_3_368), .B2(n_0_3_137), .ZN(
      MUX_v_8_2_26_return[3]));
   DFF_X1 \dat_rgb_rsci_idat_23_16_reg[3]  (.D(MUX_v_8_2_26_return[3]), .CK(
      n_0_10), .Q(dat_rgb_rsc_dat[19]), .QN());
   NAND2_X1 i_0_3_68 (.A1(line_buf0_b_pixelType_rsci_q_d[10]), .A2(n_0_3_137), 
      .ZN(n_0_3_114));
   OAI21_X1 i_0_3_67 (.A(n_0_3_114), .B1(n_0_3_344), .B2(n_0_3_137), .ZN(
      MUX_v_8_2_26_return[2]));
   DFF_X1 \dat_rgb_rsci_idat_23_16_reg[2]  (.D(MUX_v_8_2_26_return[2]), .CK(
      n_0_10), .Q(dat_rgb_rsc_dat[18]), .QN());
   DFF_X1 \rdbuf0_pix_b_pixelType_lpi_3_reg[9]  (.D(
      line_buf0_b_pixelType_rsci_q_d[9]), .CK(n_0_0), .Q(
      rdbuf0_pix_b_pixelType_lpi_3_reg[9]), .QN());
   NAND2_X1 i_0_3_502 (.A1(
      reg_operator_11_false_operator_11_false_slc_VCOL_x_0_9_itm_1_cse), 
      .A2(rdbuf0_pix_b_pixelType_lpi_3_reg[9]), .ZN(n_0_3_360));
   OAI21_X1 i_0_3_66 (.A(n_0_3_488), .B1(line_buf0_b_pixelType_rsci_q_d[9]), 
      .B2(n_0_3_256), .ZN(n_0_3_113));
   INV_X1 i_0_3_622 (.A(line_buf0_b_pixelType_rsci_q_d[1]), .ZN(n_0_3_482));
   NOR2_X1 i_0_3_108 (.A1(
      reg_operator_11_false_operator_11_false_slc_VCOL_x_0_9_itm_1_cse), 
      .A2(n_0_3_255), .ZN(n_0_3_134));
   AOI22_X1 i_0_3_65 (.A1(n_0_3_360), .A2(n_0_3_113), .B1(n_0_3_482), .B2(
      n_0_3_134), .ZN(MUX_v_8_2_26_return[1]));
   DFF_X1 \dat_rgb_rsci_idat_23_16_reg[1]  (.D(MUX_v_8_2_26_return[1]), .CK(
      n_0_10), .Q(dat_rgb_rsc_dat[17]), .QN());
   DFF_X1 \rdbuf0_pix_b_pixelType_lpi_3_reg[8]  (.D(
      line_buf0_b_pixelType_rsci_q_d[8]), .CK(n_0_0), .Q(
      rdbuf0_pix_b_pixelType_lpi_3_reg[8]), .QN());
   NAND2_X1 i_0_3_505 (.A1(
      reg_operator_11_false_operator_11_false_slc_VCOL_x_0_9_itm_1_cse), 
      .A2(rdbuf0_pix_b_pixelType_lpi_3_reg[8]), .ZN(n_0_3_363));
   OAI21_X1 i_0_3_64 (.A(n_0_3_488), .B1(line_buf0_b_pixelType_rsci_q_d[8]), 
      .B2(n_0_3_256), .ZN(n_0_3_112));
   INV_X1 i_0_3_623 (.A(line_buf0_b_pixelType_rsci_q_d[0]), .ZN(n_0_3_483));
   AOI22_X1 i_0_3_63 (.A1(n_0_3_363), .A2(n_0_3_112), .B1(n_0_3_483), .B2(
      n_0_3_134), .ZN(MUX_v_8_2_26_return[0]));
   DFF_X1 \dat_rgb_rsci_idat_23_16_reg[0]  (.D(MUX_v_8_2_26_return[0]), .CK(
      n_0_10), .Q(dat_rgb_rsc_dat[16]), .QN());
   NAND2_X1 i_0_3_94 (.A1(line_buf0_g_pixelType_rsci_q_d[15]), .A2(n_0_3_137), 
      .ZN(n_0_3_127));
   OAI21_X1 i_0_3_93 (.A(n_0_3_127), .B1(n_0_3_419), .B2(n_0_3_137), .ZN(
      MUX_v_8_2_27_return[7]));
   DFF_X1 \dat_rgb_rsci_idat_15_8_reg[7]  (.D(MUX_v_8_2_27_return[7]), .CK(
      n_0_10), .Q(dat_rgb_rsc_dat[15]), .QN());
   NAND2_X1 i_0_3_92 (.A1(line_buf0_g_pixelType_rsci_q_d[14]), .A2(n_0_3_137), 
      .ZN(n_0_3_126));
   OAI21_X1 i_0_3_91 (.A(n_0_3_126), .B1(n_0_3_407), .B2(n_0_3_137), .ZN(
      MUX_v_8_2_27_return[6]));
   DFF_X1 \dat_rgb_rsci_idat_15_8_reg[6]  (.D(MUX_v_8_2_27_return[6]), .CK(
      n_0_10), .Q(dat_rgb_rsc_dat[14]), .QN());
   NAND2_X1 i_0_3_90 (.A1(line_buf0_g_pixelType_rsci_q_d[13]), .A2(n_0_3_137), 
      .ZN(n_0_3_125));
   OAI21_X1 i_0_3_89 (.A(n_0_3_125), .B1(n_0_3_395), .B2(n_0_3_137), .ZN(
      MUX_v_8_2_27_return[5]));
   DFF_X1 \dat_rgb_rsci_idat_15_8_reg[5]  (.D(MUX_v_8_2_27_return[5]), .CK(
      n_0_10), .Q(dat_rgb_rsc_dat[13]), .QN());
   NAND2_X1 i_0_3_88 (.A1(line_buf0_g_pixelType_rsci_q_d[12]), .A2(n_0_3_137), 
      .ZN(n_0_3_124));
   OAI21_X1 i_0_3_87 (.A(n_0_3_124), .B1(n_0_3_383), .B2(n_0_3_137), .ZN(
      MUX_v_8_2_27_return[4]));
   DFF_X1 \dat_rgb_rsci_idat_15_8_reg[4]  (.D(MUX_v_8_2_27_return[4]), .CK(
      n_0_10), .Q(dat_rgb_rsc_dat[12]), .QN());
   NAND2_X1 i_0_3_86 (.A1(line_buf0_g_pixelType_rsci_q_d[11]), .A2(n_0_3_137), 
      .ZN(n_0_3_123));
   OAI21_X1 i_0_3_85 (.A(n_0_3_123), .B1(n_0_3_371), .B2(n_0_3_137), .ZN(
      MUX_v_8_2_27_return[3]));
   DFF_X1 \dat_rgb_rsci_idat_15_8_reg[3]  (.D(MUX_v_8_2_27_return[3]), .CK(
      n_0_10), .Q(dat_rgb_rsc_dat[11]), .QN());
   NAND2_X1 i_0_3_84 (.A1(line_buf0_g_pixelType_rsci_q_d[10]), .A2(n_0_3_137), 
      .ZN(n_0_3_122));
   OAI21_X1 i_0_3_83 (.A(n_0_3_122), .B1(n_0_3_353), .B2(n_0_3_137), .ZN(
      MUX_v_8_2_27_return[2]));
   DFF_X1 \dat_rgb_rsci_idat_15_8_reg[2]  (.D(MUX_v_8_2_27_return[2]), .CK(
      n_0_10), .Q(dat_rgb_rsc_dat[10]), .QN());
   OAI21_X1 i_0_3_82 (.A(n_0_3_488), .B1(line_buf0_g_pixelType_rsci_q_d[9]), 
      .B2(n_0_3_256), .ZN(n_0_3_121));
   AOI22_X1 i_0_3_81 (.A1(n_0_3_350), .A2(n_0_3_121), .B1(n_0_3_480), .B2(
      n_0_3_134), .ZN(MUX_v_8_2_27_return[1]));
   DFF_X1 \dat_rgb_rsci_idat_15_8_reg[1]  (.D(MUX_v_8_2_27_return[1]), .CK(
      n_0_10), .Q(dat_rgb_rsc_dat[9]), .QN());
   DFF_X1 \rdbuf0_pix_g_pixelType_lpi_3_reg[8]  (.D(
      line_buf0_g_pixelType_rsci_q_d[8]), .CK(n_0_0), .Q(
      rdbuf0_pix_g_pixelType_lpi_3_reg[8]), .QN());
   NAND2_X1 i_0_3_491 (.A1(
      reg_operator_11_false_operator_11_false_slc_VCOL_x_0_9_itm_1_cse), 
      .A2(rdbuf0_pix_g_pixelType_lpi_3_reg[8]), .ZN(n_0_3_349));
   OAI21_X1 i_0_3_80 (.A(n_0_3_488), .B1(line_buf0_g_pixelType_rsci_q_d[8]), 
      .B2(n_0_3_256), .ZN(n_0_3_120));
   INV_X1 i_0_3_644 (.A(line_buf0_g_pixelType_rsci_q_d[0]), .ZN(n_0_3_481));
   AOI22_X1 i_0_3_79 (.A1(n_0_3_349), .A2(n_0_3_120), .B1(n_0_3_481), .B2(
      n_0_3_134), .ZN(MUX_v_8_2_27_return[0]));
   DFF_X1 \dat_rgb_rsci_idat_15_8_reg[0]  (.D(MUX_v_8_2_27_return[0]), .CK(
      n_0_10), .Q(dat_rgb_rsc_dat[8]), .QN());
   NAND2_X1 i_0_3_111 (.A1(line_buf0_r_pixelType_rsci_q_d[15]), .A2(n_0_3_137), 
      .ZN(n_0_3_136));
   OAI21_X1 i_0_3_110 (.A(n_0_3_136), .B1(n_0_3_442), .B2(n_0_3_137), .ZN(
      MUX_v_8_2_25_return[7]));
   DFF_X1 \dat_rgb_rsci_idat_7_0_reg[7]  (.D(MUX_v_8_2_25_return[7]), .CK(n_0_10), 
      .Q(dat_rgb_rsc_dat[7]), .QN());
   NAND2_X1 i_0_3_109 (.A1(line_buf0_r_pixelType_rsci_q_d[14]), .A2(n_0_3_137), 
      .ZN(n_0_3_135));
   OAI21_X1 i_0_3_107 (.A(n_0_3_135), .B1(n_0_3_411), .B2(n_0_3_137), .ZN(
      MUX_v_8_2_25_return[6]));
   DFF_X1 \dat_rgb_rsci_idat_7_0_reg[6]  (.D(MUX_v_8_2_25_return[6]), .CK(n_0_10), 
      .Q(dat_rgb_rsc_dat[6]), .QN());
   NAND2_X1 i_0_3_106 (.A1(line_buf0_r_pixelType_rsci_q_d[13]), .A2(n_0_3_137), 
      .ZN(n_0_3_133));
   OAI21_X1 i_0_3_105 (.A(n_0_3_133), .B1(n_0_3_399), .B2(n_0_3_137), .ZN(
      MUX_v_8_2_25_return[5]));
   DFF_X1 \dat_rgb_rsci_idat_7_0_reg[5]  (.D(MUX_v_8_2_25_return[5]), .CK(n_0_10), 
      .Q(dat_rgb_rsc_dat[5]), .QN());
   NAND2_X1 i_0_3_104 (.A1(line_buf0_r_pixelType_rsci_q_d[12]), .A2(n_0_3_137), 
      .ZN(n_0_3_132));
   OAI21_X1 i_0_3_103 (.A(n_0_3_132), .B1(n_0_3_387), .B2(n_0_3_137), .ZN(
      MUX_v_8_2_25_return[4]));
   DFF_X1 \dat_rgb_rsci_idat_7_0_reg[4]  (.D(MUX_v_8_2_25_return[4]), .CK(n_0_10), 
      .Q(dat_rgb_rsc_dat[4]), .QN());
   NAND2_X1 i_0_3_102 (.A1(line_buf0_r_pixelType_rsci_q_d[11]), .A2(n_0_3_137), 
      .ZN(n_0_3_131));
   OAI21_X1 i_0_3_101 (.A(n_0_3_131), .B1(n_0_3_375), .B2(n_0_3_137), .ZN(
      MUX_v_8_2_25_return[3]));
   DFF_X1 \dat_rgb_rsci_idat_7_0_reg[3]  (.D(MUX_v_8_2_25_return[3]), .CK(n_0_10), 
      .Q(dat_rgb_rsc_dat[3]), .QN());
   NAND2_X1 i_0_3_100 (.A1(line_buf0_r_pixelType_rsci_q_d[10]), .A2(n_0_3_137), 
      .ZN(n_0_3_130));
   OAI21_X1 i_0_3_99 (.A(n_0_3_130), .B1(n_0_3_356), .B2(n_0_3_137), .ZN(
      MUX_v_8_2_25_return[2]));
   DFF_X1 \dat_rgb_rsci_idat_7_0_reg[2]  (.D(MUX_v_8_2_25_return[2]), .CK(n_0_10), 
      .Q(dat_rgb_rsc_dat[2]), .QN());
   DFF_X1 \rdbuf0_pix_r_pixelType_lpi_3_reg[9]  (.D(
      line_buf0_r_pixelType_rsci_q_d[9]), .CK(n_0_0), .Q(
      rdbuf0_pix_r_pixelType_lpi_3_reg[9]), .QN());
   NAND2_X1 i_0_3_477 (.A1(
      reg_operator_11_false_operator_11_false_slc_VCOL_x_0_9_itm_1_cse), 
      .A2(rdbuf0_pix_r_pixelType_lpi_3_reg[9]), .ZN(n_0_3_336));
   OAI21_X1 i_0_3_98 (.A(n_0_3_488), .B1(line_buf0_r_pixelType_rsci_q_d[9]), 
      .B2(n_0_3_256), .ZN(n_0_3_129));
   INV_X1 i_0_3_641 (.A(line_buf0_r_pixelType_rsci_q_d[1]), .ZN(n_0_3_478));
   AOI22_X1 i_0_3_97 (.A1(n_0_3_336), .A2(n_0_3_129), .B1(n_0_3_478), .B2(
      n_0_3_134), .ZN(MUX_v_8_2_25_return[1]));
   DFF_X1 \dat_rgb_rsci_idat_7_0_reg[1]  (.D(MUX_v_8_2_25_return[1]), .CK(n_0_10), 
      .Q(dat_rgb_rsc_dat[1]), .QN());
   DFF_X1 \rdbuf0_pix_r_pixelType_lpi_3_reg[8]  (.D(
      line_buf0_r_pixelType_rsci_q_d[8]), .CK(n_0_0), .Q(
      rdbuf0_pix_r_pixelType_lpi_3_reg[8]), .QN());
   NAND2_X1 i_0_3_480 (.A1(
      reg_operator_11_false_operator_11_false_slc_VCOL_x_0_9_itm_1_cse), 
      .A2(rdbuf0_pix_r_pixelType_lpi_3_reg[8]), .ZN(n_0_3_339));
   OAI21_X1 i_0_3_96 (.A(n_0_3_488), .B1(line_buf0_r_pixelType_rsci_q_d[8]), 
      .B2(n_0_3_256), .ZN(n_0_3_128));
   INV_X1 i_0_3_642 (.A(line_buf0_r_pixelType_rsci_q_d[0]), .ZN(n_0_3_479));
   AOI22_X1 i_0_3_95 (.A1(n_0_3_339), .A2(n_0_3_128), .B1(n_0_3_479), .B2(
      n_0_3_134), .ZN(MUX_v_8_2_25_return[0]));
   DFF_X1 \dat_rgb_rsci_idat_7_0_reg[0]  (.D(MUX_v_8_2_25_return[0]), .CK(n_0_10), 
      .Q(dat_rgb_rsc_dat[0]), .QN());
   NOR2_X1 i_0_3_251 (.A1(n_0_3_28), .A2(rst), .ZN(n_0_98));
   DFFR_X1 VCOL_if_slc_operator_10_false_acc_10_svs_1_reg (.D(n_0_98), .RN(
      arst_n), .CK(n_0_7), .Q(VCOL_if_slc_operator_10_false_acc_10_svs_1), .QN());
   INV_X1 i_0_3_598 (.A(VCOL_if_slc_operator_10_false_acc_10_svs_1), .ZN(
      n_0_3_455));
   AOI21_X1 i_0_3_630 (.A(n_0_3_440), .B1(VCOL_stage_0_1), .B2(VCOL_asn_24_itm_1), 
      .ZN(n_0_3_274));
   NAND2_X1 i_0_3_629 (.A1(n_0_3_428), .A2(n_0_3_274), .ZN(n_0_3_163));
   NAND2_X1 i_0_3_144 (.A1(pix0_r_pixelType_lpi_3_dfm[7]), .A2(n_0_3_163), 
      .ZN(n_0_3_153));
   OAI21_X1 i_0_3_143 (.A(n_0_3_153), .B1(n_0_3_442), .B2(n_0_3_163), .ZN(
      MUX_v_8_2_210_return[7]));
   AOI211_X1 i_0_3_413 (.A(VCOL_stage_0_2), .B(n_0_3_330), .C1(VCOL_stage_0_1), 
      .C2(n_0_3_28), .ZN(n_0_3_275));
   AND3_X1 i_0_3_411 (.A1(run_wen), .A2(n_0_3_274), .A3(n_0_3_275), .ZN(
      pix0_b_pixelType_and_3_cse));
   CLKGATE_X1 clk_gate_pix0_r_pixelType_lpi_3_reg (.CK(clk), .E(
      pix0_b_pixelType_and_3_cse), .GCK(n_0_9));
   DFF_X1 \pix0_r_pixelType_lpi_3_reg[7]  (.D(MUX_v_8_2_210_return[7]), .CK(
      n_0_9), .Q(pix0_r_pixelType_lpi_3[7]), .QN());
   AOI21_X1 i_0_3_332 (.A(n_0_3_455), .B1(VCOL_stage_0_3), .B2(n_0_3_457), 
      .ZN(n_0_3_247));
   AOI22_X1 i_0_3_375 (.A1(n_0_3_455), .A2(dat_in_rsc_dat[7]), .B1(
      pix0_r_pixelType_lpi_3[7]), .B2(n_0_3_247), .ZN(n_0_3_246));
   NAND3_X1 i_0_3_406 (.A1(VCOL_stage_0_3), .A2(n_0_3_457), .A3(
      VCOL_if_slc_operator_10_false_acc_10_svs_1), .ZN(n_0_3_273));
   OAI21_X1 i_0_3_374 (.A(n_0_3_246), .B1(n_0_3_426), .B2(n_0_3_273), .ZN(
      line_buf0_r_pixelType_rsci_d_d[15]));
   INV_X1 i_0_3_409 (.A(n_0_3_273), .ZN(n_0_3_272));
   AOI21_X1 i_0_3_408 (.A(n_0_3_331), .B1(n_0_3_427), .B2(n_0_3_272), .ZN(
      and_153_cse));
   CLKGATE_X1 clk_gate_pix0_r_pixelType_lpi_3_dfm_reg (.CK(clk), .E(and_153_cse), 
      .GCK(n_0_1));
   DFF_X1 \pix0_r_pixelType_lpi_3_dfm_reg[7]  (.D(
      line_buf0_r_pixelType_rsci_d_d[15]), .CK(n_0_1), .Q(
      pix0_r_pixelType_lpi_3_dfm[7]), .QN());
   AOI22_X1 i_0_3_584 (.A1(pix0_r_pixelType_lpi_3_dfm[7]), .A2(n_0_3_427), 
      .B1(MUX_v_8_2_22_return[7]), .B2(n_0_3_428), .ZN(n_0_3_426));
   NAND2_X1 i_0_3_412 (.A1(n_0_3_327), .A2(n_0_3_279), .ZN(n_0_3_278));
   INV_X1 i_0_3_410 (.A(n_0_3_278), .ZN(n_0_3_277));
   INV_X1 i_0_3_252 (.A(n_0_99), .ZN(n_0_3_185));
   NOR4_X1 i_0_3_225 (.A1(VCOL_asn_12_itm[2]), .A2(VCOL_asn_12_itm[1]), .A3(
      VCOL_asn_12_itm[3]), .A4(VCOL_asn_12_itm[0]), .ZN(n_0_3_183));
   NOR4_X1 i_0_3_226 (.A1(VCOL_asn_12_itm[9]), .A2(VCOL_asn_12_itm[8]), .A3(
      VCOL_asn_12_itm[7]), .A4(VCOL_asn_12_itm[4]), .ZN(n_0_3_184));
   AND4_X1 i_0_3_224 (.A1(n_0_3_453), .A2(n_0_3_452), .A3(n_0_3_183), .A4(
      n_0_3_184), .ZN(n_0_3_182));
   AOI21_X1 i_0_3_223 (.A(n_0_3_185), .B1(n_0_3_454), .B2(n_0_3_182), .ZN(n_0_56));
   NAND4_X1 i_0_3_221 (.A1(vector[6]), .A2(vector[5]), .A3(vector[4]), .A4(
      n_0_3_454), .ZN(n_0_3_180));
   NAND4_X1 i_0_3_222 (.A1(vector[2]), .A2(vector[3]), .A3(vector[1]), .A4(
      vector[7]), .ZN(n_0_3_181));
   NOR4_X1 i_0_3_220 (.A1(VROW_y_sva[8]), .A2(VROW_y_sva[9]), .A3(n_0_3_180), 
      .A4(n_0_3_181), .ZN(n_0_55));
   MUX2_X1 VCOL_nor_1_itm_1_reg_enable_mux_0 (.A(VCOL_nor_1_itm_1), .B(n_0_55), 
      .S(n_0_56), .Z(n_0_12));
   DFFR_X1 VCOL_nor_1_itm_1_reg (.D(n_0_12), .RN(arst_n), .CK(clk), .Q(
      VCOL_nor_1_itm_1), .QN());
   AOI21_X1 i_0_3_385 (.A(n_0_3_265), .B1(VROW_y_sva[0]), .B2(VCOL_nor_1_itm_1), 
      .ZN(n_0_3_254));
   OAI21_X1 i_0_3_384 (.A(VCOL_stage_0_2), .B1(n_0_3_277), .B2(n_0_3_254), 
      .ZN(n_0_3_253));
   AOI21_X1 i_0_3_383 (.A(n_0_3_269), .B1(n_0_3_260), .B2(n_0_3_253), .ZN(
      VCOL_if_2_and_cse));
   CLKGATE_X1 clk_gate_VCOL_if_2_read_mem_line_buf1_r_pixelType_rsc_cse_lpi_3_11_6_reg (
      .CK(clk), .E(VCOL_if_2_and_cse), .GCK(n_0_3));
   DFF_X1 \VCOL_if_2_read_mem_line_buf1_r_pixelType_rsc_cse_lpi_3_11_6_reg[5]  (
      .D(line_buf1_r_pixelType_rsci_q_d[11]), .CK(n_0_3), .Q(
      VCOL_if_2_read_mem_line_buf1_r_pixelType_rsc_cse_lpi_3_11_6[5]), .QN());
   OAI21_X1 i_0_3_219 (.A(n_0_3_454), .B1(n_0_3_276), .B2(n_0_3_265), .ZN(n_0_54));
   AND2_X1 i_0_3_218 (.A1(VCOL_nor_1_itm_1), .A2(n_0_3_454), .ZN(n_0_53));
   MUX2_X1 VCOL_nor_1_itm_2_reg_enable_mux_0 (.A(VCOL_nor_1_itm_2), .B(n_0_53), 
      .S(n_0_54), .Z(n_0_13));
   DFFR_X1 VCOL_nor_1_itm_2_reg (.D(n_0_13), .RN(arst_n), .CK(clk), .Q(
      VCOL_nor_1_itm_2), .QN());
   NAND2_X1 i_0_3_583 (.A1(VROW_y_sva[0]), .A2(VCOL_nor_1_itm_2), .ZN(n_0_3_425));
   INV_X1 i_0_3_580 (.A(n_0_3_425), .ZN(n_0_3_424));
   NOR2_X1 i_0_3_579 (.A1(n_0_3_488), .A2(n_0_3_424), .ZN(n_0_3_423));
   NOR2_X1 i_0_3_576 (.A1(
      reg_operator_11_false_operator_11_false_slc_VCOL_x_0_9_itm_1_cse), 
      .A2(n_0_3_424), .ZN(n_0_3_422));
   AOI22_X1 i_0_3_582 (.A1(
      VCOL_if_2_read_mem_line_buf1_r_pixelType_rsc_cse_lpi_3_11_6[5]), .A2(
      n_0_3_423), .B1(line_buf1_r_pixelType_rsci_q_d[5]), .B2(n_0_3_422), 
      .ZN(n_0_3_421));
   OAI21_X1 i_0_3_581 (.A(n_0_3_421), .B1(n_0_3_442), .B2(n_0_3_425), .ZN(
      n_0_3_420));
   DFF_X1 \VCOL_if_2_read_mem_line_buf1_g_pixelType_rsc_cse_lpi_3_reg[11]  (
      .D(line_buf1_g_pixelType_rsci_q_d[11]), .CK(n_0_3), .Q(
      VCOL_if_2_read_mem_line_buf1_g_pixelType_rsc_cse_lpi_3[11]), .QN());
   AOI22_X1 i_0_3_578 (.A1(
      VCOL_if_2_read_mem_line_buf1_g_pixelType_rsc_cse_lpi_3[11]), .A2(n_0_3_423), 
      .B1(line_buf1_g_pixelType_rsci_q_d[5]), .B2(n_0_3_422), .ZN(n_0_3_418));
   OAI21_X1 i_0_3_577 (.A(n_0_3_418), .B1(n_0_3_425), .B2(n_0_3_419), .ZN(
      n_0_3_417));
   FA_X1 i_0_3_40 (.A(n_0_3_426), .B(n_0_3_420), .CI(n_0_3_417), .CO(n_0_3_71), 
      .S(n_0_3_70));
   INV_X1 i_0_3_648 (.A(n_0_3_71), .ZN(n_0_3_485));
   NAND2_X1 i_0_3_128 (.A1(pix0_b_pixelType_lpi_3_dfm[7]), .A2(n_0_3_163), 
      .ZN(n_0_3_145));
   OAI21_X1 i_0_3_127 (.A(n_0_3_145), .B1(n_0_3_416), .B2(n_0_3_163), .ZN(
      MUX_v_8_2_28_return[7]));
   DFF_X1 \pix0_b_pixelType_lpi_3_reg[7]  (.D(MUX_v_8_2_28_return[7]), .CK(n_0_9), 
      .Q(pix0_b_pixelType_lpi_3[7]), .QN());
   AOI22_X1 i_0_3_343 (.A1(n_0_3_455), .A2(dat_in_rsc_dat[23]), .B1(
      pix0_b_pixelType_lpi_3[7]), .B2(n_0_3_247), .ZN(n_0_3_230));
   OAI21_X1 i_0_3_342 (.A(n_0_3_230), .B1(n_0_3_415), .B2(n_0_3_273), .ZN(
      line_buf0_b_pixelType_rsci_d_d[15]));
   DFF_X1 \pix0_b_pixelType_lpi_3_dfm_reg[7]  (.D(
      line_buf0_b_pixelType_rsci_d_d[15]), .CK(n_0_1), .Q(
      pix0_b_pixelType_lpi_3_dfm[7]), .QN());
   AOI22_X1 i_0_3_574 (.A1(pix0_b_pixelType_lpi_3_dfm[7]), .A2(n_0_3_427), 
      .B1(n_0_3_428), .B2(MUX_v_8_2_23_return[7]), .ZN(n_0_3_415));
   NAND2_X1 i_0_3_160 (.A1(pix0_g_pixelType_lpi_3_dfm[7]), .A2(n_0_3_163), 
      .ZN(n_0_3_161));
   OAI21_X1 i_0_3_159 (.A(n_0_3_161), .B1(n_0_3_419), .B2(n_0_3_163), .ZN(
      MUX_v_8_2_29_return[7]));
   DFF_X1 \pix0_g_pixelType_lpi_3_reg[7]  (.D(MUX_v_8_2_29_return[7]), .CK(n_0_9), 
      .Q(pix0_g_pixelType_lpi_3[7]), .QN());
   AOI22_X1 i_0_3_359 (.A1(n_0_3_455), .A2(dat_in_rsc_dat[15]), .B1(
      pix0_g_pixelType_lpi_3[7]), .B2(n_0_3_247), .ZN(n_0_3_238));
   OAI21_X1 i_0_3_358 (.A(n_0_3_238), .B1(n_0_3_414), .B2(n_0_3_273), .ZN(
      line_buf0_g_pixelType_rsci_d_d[15]));
   DFF_X1 \pix0_g_pixelType_lpi_3_dfm_reg[7]  (.D(
      line_buf0_g_pixelType_rsci_d_d[15]), .CK(n_0_1), .Q(
      pix0_g_pixelType_lpi_3_dfm[7]), .QN());
   AOI22_X1 i_0_3_573 (.A1(pix0_g_pixelType_lpi_3_dfm[7]), .A2(n_0_3_427), 
      .B1(n_0_3_428), .B2(MUX_v_8_2_24_return[7]), .ZN(n_0_3_414));
   DFF_X1 \VCOL_if_2_read_mem_line_buf1_b_pixelType_rsc_cse_lpi_3_reg[11]  (
      .D(line_buf1_b_pixelType_rsci_q_d[11]), .CK(n_0_3), .Q(
      VCOL_if_2_read_mem_line_buf1_b_pixelType_rsc_cse_lpi_3[11]), .QN());
   AOI22_X1 i_0_3_572 (.A1(
      VCOL_if_2_read_mem_line_buf1_b_pixelType_rsc_cse_lpi_3[11]), .A2(n_0_3_423), 
      .B1(line_buf1_b_pixelType_rsci_q_d[5]), .B2(n_0_3_422), .ZN(n_0_3_413));
   OAI21_X1 i_0_3_571 (.A(n_0_3_413), .B1(n_0_3_425), .B2(n_0_3_416), .ZN(
      n_0_3_412));
   FA_X1 i_0_3_39 (.A(n_0_3_415), .B(n_0_3_414), .CI(n_0_3_412), .CO(n_0_3_69), 
      .S(n_0_3_68));
   INV_X1 i_0_3_647 (.A(n_0_3_69), .ZN(n_0_3_484));
   NAND2_X1 i_0_3_570 (.A1(n_0_3_485), .A2(n_0_3_484), .ZN(n_0_3_102));
   OAI21_X1 i_0_3_569 (.A(n_0_3_102), .B1(n_0_3_485), .B2(n_0_3_484), .ZN(
      n_0_3_101));
   NAND2_X1 i_0_3_142 (.A1(pix0_r_pixelType_lpi_3_dfm[6]), .A2(n_0_3_163), 
      .ZN(n_0_3_152));
   OAI21_X1 i_0_3_141 (.A(n_0_3_152), .B1(n_0_3_411), .B2(n_0_3_163), .ZN(
      MUX_v_8_2_210_return[6]));
   DFF_X1 \pix0_r_pixelType_lpi_3_reg[6]  (.D(MUX_v_8_2_210_return[6]), .CK(
      n_0_9), .Q(pix0_r_pixelType_lpi_3[6]), .QN());
   AOI22_X1 i_0_3_373 (.A1(n_0_3_455), .A2(dat_in_rsc_dat[6]), .B1(
      pix0_r_pixelType_lpi_3[6]), .B2(n_0_3_247), .ZN(n_0_3_245));
   OAI21_X1 i_0_3_372 (.A(n_0_3_245), .B1(n_0_3_410), .B2(n_0_3_273), .ZN(
      line_buf0_r_pixelType_rsci_d_d[14]));
   DFF_X1 \pix0_r_pixelType_lpi_3_dfm_reg[6]  (.D(
      line_buf0_r_pixelType_rsci_d_d[14]), .CK(n_0_1), .Q(
      pix0_r_pixelType_lpi_3_dfm[6]), .QN());
   AOI22_X1 i_0_3_566 (.A1(pix0_r_pixelType_lpi_3_dfm[6]), .A2(n_0_3_427), 
      .B1(n_0_3_428), .B2(MUX_v_8_2_22_return[6]), .ZN(n_0_3_410));
   DFF_X1 \VCOL_if_2_read_mem_line_buf1_r_pixelType_rsc_cse_lpi_3_11_6_reg[4]  (
      .D(line_buf1_r_pixelType_rsci_q_d[10]), .CK(n_0_3), .Q(
      VCOL_if_2_read_mem_line_buf1_r_pixelType_rsc_cse_lpi_3_11_6[4]), .QN());
   AOI22_X1 i_0_3_565 (.A1(
      VCOL_if_2_read_mem_line_buf1_r_pixelType_rsc_cse_lpi_3_11_6[4]), .A2(
      n_0_3_423), .B1(line_buf1_r_pixelType_rsci_q_d[4]), .B2(n_0_3_422), 
      .ZN(n_0_3_409));
   OAI21_X1 i_0_3_564 (.A(n_0_3_409), .B1(n_0_3_425), .B2(n_0_3_411), .ZN(
      n_0_3_408));
   DFF_X1 \VCOL_if_2_read_mem_line_buf1_g_pixelType_rsc_cse_lpi_3_reg[10]  (
      .D(line_buf1_g_pixelType_rsci_q_d[10]), .CK(n_0_3), .Q(
      VCOL_if_2_read_mem_line_buf1_g_pixelType_rsc_cse_lpi_3[10]), .QN());
   AOI22_X1 i_0_3_561 (.A1(
      VCOL_if_2_read_mem_line_buf1_g_pixelType_rsc_cse_lpi_3[10]), .A2(n_0_3_423), 
      .B1(line_buf1_g_pixelType_rsci_q_d[4]), .B2(n_0_3_422), .ZN(n_0_3_406));
   OAI21_X1 i_0_3_560 (.A(n_0_3_406), .B1(n_0_3_425), .B2(n_0_3_407), .ZN(
      n_0_3_405));
   FA_X1 i_0_3_36 (.A(n_0_3_410), .B(n_0_3_408), .CI(n_0_3_405), .CO(n_0_3_63), 
      .S(n_0_3_62));
   NAND2_X1 i_0_3_126 (.A1(pix0_b_pixelType_lpi_3_dfm[6]), .A2(n_0_3_163), 
      .ZN(n_0_3_144));
   OAI21_X1 i_0_3_125 (.A(n_0_3_144), .B1(n_0_3_404), .B2(n_0_3_163), .ZN(
      MUX_v_8_2_28_return[6]));
   DFF_X1 \pix0_b_pixelType_lpi_3_reg[6]  (.D(MUX_v_8_2_28_return[6]), .CK(n_0_9), 
      .Q(pix0_b_pixelType_lpi_3[6]), .QN());
   AOI22_X1 i_0_3_341 (.A1(n_0_3_455), .A2(dat_in_rsc_dat[22]), .B1(
      pix0_b_pixelType_lpi_3[6]), .B2(n_0_3_247), .ZN(n_0_3_229));
   OAI21_X1 i_0_3_340 (.A(n_0_3_229), .B1(n_0_3_403), .B2(n_0_3_273), .ZN(
      line_buf0_b_pixelType_rsci_d_d[14]));
   DFF_X1 \pix0_b_pixelType_lpi_3_dfm_reg[6]  (.D(
      line_buf0_b_pixelType_rsci_d_d[14]), .CK(n_0_1), .Q(
      pix0_b_pixelType_lpi_3_dfm[6]), .QN());
   AOI22_X1 i_0_3_557 (.A1(pix0_b_pixelType_lpi_3_dfm[6]), .A2(n_0_3_427), 
      .B1(n_0_3_428), .B2(MUX_v_8_2_23_return[6]), .ZN(n_0_3_403));
   NAND2_X1 i_0_3_157 (.A1(pix0_g_pixelType_lpi_3_dfm[6]), .A2(n_0_3_163), 
      .ZN(n_0_3_160));
   OAI21_X1 i_0_3_156 (.A(n_0_3_160), .B1(n_0_3_407), .B2(n_0_3_163), .ZN(
      MUX_v_8_2_29_return[6]));
   DFF_X1 \pix0_g_pixelType_lpi_3_reg[6]  (.D(MUX_v_8_2_29_return[6]), .CK(n_0_9), 
      .Q(pix0_g_pixelType_lpi_3[6]), .QN());
   AOI22_X1 i_0_3_357 (.A1(n_0_3_455), .A2(dat_in_rsc_dat[14]), .B1(
      pix0_g_pixelType_lpi_3[6]), .B2(n_0_3_247), .ZN(n_0_3_237));
   OAI21_X1 i_0_3_356 (.A(n_0_3_237), .B1(n_0_3_402), .B2(n_0_3_273), .ZN(
      line_buf0_g_pixelType_rsci_d_d[14]));
   DFF_X1 \pix0_g_pixelType_lpi_3_dfm_reg[6]  (.D(
      line_buf0_g_pixelType_rsci_d_d[14]), .CK(n_0_1), .Q(
      pix0_g_pixelType_lpi_3_dfm[6]), .QN());
   AOI22_X1 i_0_3_556 (.A1(pix0_g_pixelType_lpi_3_dfm[6]), .A2(n_0_3_427), 
      .B1(n_0_3_428), .B2(MUX_v_8_2_24_return[6]), .ZN(n_0_3_402));
   DFF_X1 \VCOL_if_2_read_mem_line_buf1_b_pixelType_rsc_cse_lpi_3_reg[10]  (
      .D(line_buf1_b_pixelType_rsci_q_d[10]), .CK(n_0_3), .Q(
      VCOL_if_2_read_mem_line_buf1_b_pixelType_rsc_cse_lpi_3[10]), .QN());
   AOI22_X1 i_0_3_555 (.A1(
      VCOL_if_2_read_mem_line_buf1_b_pixelType_rsc_cse_lpi_3[10]), .A2(n_0_3_423), 
      .B1(line_buf1_b_pixelType_rsci_q_d[4]), .B2(n_0_3_422), .ZN(n_0_3_401));
   OAI21_X1 i_0_3_554 (.A(n_0_3_401), .B1(n_0_3_425), .B2(n_0_3_404), .ZN(
      n_0_3_400));
   FA_X1 i_0_3_35 (.A(n_0_3_403), .B(n_0_3_402), .CI(n_0_3_400), .CO(n_0_3_61), 
      .S(n_0_3_60));
   FA_X1 i_0_3_41 (.A(n_0_3_63), .B(n_0_3_61), .CI(n_0_3_70), .CO(n_0_3_73), 
      .S(n_0_3_72));
   HA_X1 i_0_3_43 (.A(n_0_3_101), .B(n_0_3_73), .CO(n_0_3_77), .S(n_0_3_76));
   NAND2_X1 i_0_3_140 (.A1(pix0_r_pixelType_lpi_3_dfm[5]), .A2(n_0_3_163), 
      .ZN(n_0_3_151));
   OAI21_X1 i_0_3_139 (.A(n_0_3_151), .B1(n_0_3_399), .B2(n_0_3_163), .ZN(
      MUX_v_8_2_210_return[5]));
   DFF_X1 \pix0_r_pixelType_lpi_3_reg[5]  (.D(MUX_v_8_2_210_return[5]), .CK(
      n_0_9), .Q(pix0_r_pixelType_lpi_3[5]), .QN());
   AOI22_X1 i_0_3_371 (.A1(n_0_3_455), .A2(dat_in_rsc_dat[5]), .B1(
      pix0_r_pixelType_lpi_3[5]), .B2(n_0_3_247), .ZN(n_0_3_244));
   OAI21_X1 i_0_3_370 (.A(n_0_3_244), .B1(n_0_3_398), .B2(n_0_3_273), .ZN(
      line_buf0_r_pixelType_rsci_d_d[13]));
   DFF_X1 \pix0_r_pixelType_lpi_3_dfm_reg[5]  (.D(
      line_buf0_r_pixelType_rsci_d_d[13]), .CK(n_0_1), .Q(
      pix0_r_pixelType_lpi_3_dfm[5]), .QN());
   AOI22_X1 i_0_3_548 (.A1(pix0_r_pixelType_lpi_3_dfm[5]), .A2(n_0_3_427), 
      .B1(n_0_3_428), .B2(MUX_v_8_2_22_return[5]), .ZN(n_0_3_398));
   DFF_X1 \VCOL_if_2_read_mem_line_buf1_r_pixelType_rsc_cse_lpi_3_11_6_reg[3]  (
      .D(line_buf1_r_pixelType_rsci_q_d[9]), .CK(n_0_3), .Q(
      VCOL_if_2_read_mem_line_buf1_r_pixelType_rsc_cse_lpi_3_11_6[3]), .QN());
   AOI22_X1 i_0_3_547 (.A1(
      VCOL_if_2_read_mem_line_buf1_r_pixelType_rsc_cse_lpi_3_11_6[3]), .A2(
      n_0_3_423), .B1(line_buf1_r_pixelType_rsci_q_d[3]), .B2(n_0_3_422), 
      .ZN(n_0_3_397));
   OAI21_X1 i_0_3_546 (.A(n_0_3_397), .B1(n_0_3_425), .B2(n_0_3_399), .ZN(
      n_0_3_396));
   DFF_X1 \VCOL_if_2_read_mem_line_buf1_g_pixelType_rsc_cse_lpi_3_reg[9]  (
      .D(line_buf1_g_pixelType_rsci_q_d[9]), .CK(n_0_3), .Q(
      VCOL_if_2_read_mem_line_buf1_g_pixelType_rsc_cse_lpi_3[9]), .QN());
   AOI22_X1 i_0_3_543 (.A1(
      VCOL_if_2_read_mem_line_buf1_g_pixelType_rsc_cse_lpi_3[9]), .A2(n_0_3_423), 
      .B1(line_buf1_g_pixelType_rsci_q_d[3]), .B2(n_0_3_422), .ZN(n_0_3_394));
   OAI21_X1 i_0_3_542 (.A(n_0_3_394), .B1(n_0_3_425), .B2(n_0_3_395), .ZN(
      n_0_3_393));
   FA_X1 i_0_3_32 (.A(n_0_3_398), .B(n_0_3_396), .CI(n_0_3_393), .CO(n_0_3_55), 
      .S(n_0_3_54));
   NAND2_X1 i_0_3_124 (.A1(pix0_b_pixelType_lpi_3_dfm[5]), .A2(n_0_3_163), 
      .ZN(n_0_3_143));
   OAI21_X1 i_0_3_123 (.A(n_0_3_143), .B1(n_0_3_392), .B2(n_0_3_163), .ZN(
      MUX_v_8_2_28_return[5]));
   DFF_X1 \pix0_b_pixelType_lpi_3_reg[5]  (.D(MUX_v_8_2_28_return[5]), .CK(n_0_9), 
      .Q(pix0_b_pixelType_lpi_3[5]), .QN());
   AOI22_X1 i_0_3_339 (.A1(n_0_3_455), .A2(dat_in_rsc_dat[21]), .B1(
      pix0_b_pixelType_lpi_3[5]), .B2(n_0_3_247), .ZN(n_0_3_228));
   OAI21_X1 i_0_3_338 (.A(n_0_3_228), .B1(n_0_3_391), .B2(n_0_3_273), .ZN(
      line_buf0_b_pixelType_rsci_d_d[13]));
   DFF_X1 \pix0_b_pixelType_lpi_3_dfm_reg[5]  (.D(
      line_buf0_b_pixelType_rsci_d_d[13]), .CK(n_0_1), .Q(
      pix0_b_pixelType_lpi_3_dfm[5]), .QN());
   AOI22_X1 i_0_3_539 (.A1(pix0_b_pixelType_lpi_3_dfm[5]), .A2(n_0_3_427), 
      .B1(n_0_3_428), .B2(MUX_v_8_2_23_return[5]), .ZN(n_0_3_391));
   NAND2_X1 i_0_3_628 (.A1(pix0_g_pixelType_lpi_3_dfm[5]), .A2(n_0_3_163), 
      .ZN(n_0_3_159));
   OAI21_X1 i_0_3_155 (.A(n_0_3_159), .B1(n_0_3_395), .B2(n_0_3_163), .ZN(
      MUX_v_8_2_29_return[5]));
   DFF_X1 \pix0_g_pixelType_lpi_3_reg[5]  (.D(MUX_v_8_2_29_return[5]), .CK(n_0_9), 
      .Q(pix0_g_pixelType_lpi_3[5]), .QN());
   AOI22_X1 i_0_3_355 (.A1(n_0_3_455), .A2(dat_in_rsc_dat[13]), .B1(
      pix0_g_pixelType_lpi_3[5]), .B2(n_0_3_247), .ZN(n_0_3_236));
   OAI21_X1 i_0_3_354 (.A(n_0_3_236), .B1(n_0_3_390), .B2(n_0_3_273), .ZN(
      line_buf0_g_pixelType_rsci_d_d[13]));
   DFF_X1 \pix0_g_pixelType_lpi_3_dfm_reg[5]  (.D(
      line_buf0_g_pixelType_rsci_d_d[13]), .CK(n_0_1), .Q(
      pix0_g_pixelType_lpi_3_dfm[5]), .QN());
   AOI22_X1 i_0_3_538 (.A1(pix0_g_pixelType_lpi_3_dfm[5]), .A2(n_0_3_427), 
      .B1(n_0_3_428), .B2(MUX_v_8_2_24_return[5]), .ZN(n_0_3_390));
   DFF_X1 \VCOL_if_2_read_mem_line_buf1_b_pixelType_rsc_cse_lpi_3_reg[9]  (
      .D(line_buf1_b_pixelType_rsci_q_d[9]), .CK(n_0_3), .Q(
      VCOL_if_2_read_mem_line_buf1_b_pixelType_rsc_cse_lpi_3[9]), .QN());
   AOI22_X1 i_0_3_537 (.A1(
      VCOL_if_2_read_mem_line_buf1_b_pixelType_rsc_cse_lpi_3[9]), .A2(n_0_3_423), 
      .B1(line_buf1_b_pixelType_rsci_q_d[3]), .B2(n_0_3_422), .ZN(n_0_3_389));
   OAI21_X1 i_0_3_533 (.A(n_0_3_389), .B1(n_0_3_425), .B2(n_0_3_392), .ZN(
      n_0_3_388));
   FA_X1 i_0_3_31 (.A(n_0_3_391), .B(n_0_3_390), .CI(n_0_3_388), .CO(n_0_3_53), 
      .S(n_0_3_52));
   FA_X1 i_0_3_37 (.A(n_0_3_55), .B(n_0_3_53), .CI(n_0_3_62), .CO(n_0_3_65), 
      .S(n_0_3_64));
   FA_X1 i_0_3_42 (.A(n_0_3_68), .B(n_0_3_65), .CI(n_0_3_72), .CO(n_0_3_75), 
      .S(n_0_3_74));
   NAND2_X1 i_0_3_138 (.A1(pix0_r_pixelType_lpi_3_dfm[4]), .A2(n_0_3_163), 
      .ZN(n_0_3_150));
   OAI21_X1 i_0_3_137 (.A(n_0_3_150), .B1(n_0_3_387), .B2(n_0_3_163), .ZN(
      MUX_v_8_2_210_return[4]));
   DFF_X1 \pix0_r_pixelType_lpi_3_reg[4]  (.D(MUX_v_8_2_210_return[4]), .CK(
      n_0_9), .Q(pix0_r_pixelType_lpi_3[4]), .QN());
   AOI22_X1 i_0_3_369 (.A1(n_0_3_455), .A2(dat_in_rsc_dat[4]), .B1(
      pix0_r_pixelType_lpi_3[4]), .B2(n_0_3_247), .ZN(n_0_3_243));
   OAI21_X1 i_0_3_368 (.A(n_0_3_243), .B1(n_0_3_386), .B2(n_0_3_273), .ZN(
      line_buf0_r_pixelType_rsci_d_d[12]));
   DFF_X1 \pix0_r_pixelType_lpi_3_dfm_reg[4]  (.D(
      line_buf0_r_pixelType_rsci_d_d[12]), .CK(n_0_1), .Q(
      pix0_r_pixelType_lpi_3_dfm[4]), .QN());
   AOI22_X1 i_0_3_536 (.A1(pix0_r_pixelType_lpi_3_dfm[4]), .A2(n_0_3_427), 
      .B1(n_0_3_428), .B2(MUX_v_8_2_22_return[4]), .ZN(n_0_3_386));
   DFF_X1 \VCOL_if_2_read_mem_line_buf1_r_pixelType_rsc_cse_lpi_3_11_6_reg[2]  (
      .D(line_buf1_r_pixelType_rsci_q_d[8]), .CK(n_0_3), .Q(
      VCOL_if_2_read_mem_line_buf1_r_pixelType_rsc_cse_lpi_3_11_6[2]), .QN());
   AOI22_X1 i_0_3_535 (.A1(
      VCOL_if_2_read_mem_line_buf1_r_pixelType_rsc_cse_lpi_3_11_6[2]), .A2(
      n_0_3_423), .B1(line_buf1_r_pixelType_rsci_q_d[2]), .B2(n_0_3_422), 
      .ZN(n_0_3_385));
   OAI21_X1 i_0_3_534 (.A(n_0_3_385), .B1(n_0_3_425), .B2(n_0_3_387), .ZN(
      n_0_3_384));
   DFF_X1 \VCOL_if_2_read_mem_line_buf1_g_pixelType_rsc_cse_lpi_3_reg[8]  (
      .D(line_buf1_g_pixelType_rsci_q_d[8]), .CK(n_0_3), .Q(
      VCOL_if_2_read_mem_line_buf1_g_pixelType_rsc_cse_lpi_3[8]), .QN());
   AOI22_X1 i_0_3_531 (.A1(
      VCOL_if_2_read_mem_line_buf1_g_pixelType_rsc_cse_lpi_3[8]), .A2(n_0_3_423), 
      .B1(line_buf1_g_pixelType_rsci_q_d[2]), .B2(n_0_3_422), .ZN(n_0_3_382));
   OAI21_X1 i_0_3_530 (.A(n_0_3_382), .B1(n_0_3_425), .B2(n_0_3_383), .ZN(
      n_0_3_381));
   FA_X1 i_0_3_28 (.A(n_0_3_386), .B(n_0_3_384), .CI(n_0_3_381), .CO(n_0_3_47), 
      .S(n_0_3_46));
   NAND2_X1 i_0_3_122 (.A1(pix0_b_pixelType_lpi_3_dfm[4]), .A2(n_0_3_163), 
      .ZN(n_0_3_142));
   OAI21_X1 i_0_3_121 (.A(n_0_3_142), .B1(n_0_3_380), .B2(n_0_3_163), .ZN(
      MUX_v_8_2_28_return[4]));
   DFF_X1 \pix0_b_pixelType_lpi_3_reg[4]  (.D(MUX_v_8_2_28_return[4]), .CK(n_0_9), 
      .Q(pix0_b_pixelType_lpi_3[4]), .QN());
   AOI22_X1 i_0_3_337 (.A1(n_0_3_455), .A2(dat_in_rsc_dat[20]), .B1(
      pix0_b_pixelType_lpi_3[4]), .B2(n_0_3_247), .ZN(n_0_3_227));
   OAI21_X1 i_0_3_336 (.A(n_0_3_227), .B1(n_0_3_379), .B2(n_0_3_273), .ZN(
      line_buf0_b_pixelType_rsci_d_d[12]));
   DFF_X1 \pix0_b_pixelType_lpi_3_dfm_reg[4]  (.D(
      line_buf0_b_pixelType_rsci_d_d[12]), .CK(n_0_1), .Q(
      pix0_b_pixelType_lpi_3_dfm[4]), .QN());
   AOI22_X1 i_0_3_527 (.A1(pix0_b_pixelType_lpi_3_dfm[4]), .A2(n_0_3_427), 
      .B1(n_0_3_428), .B2(MUX_v_8_2_23_return[4]), .ZN(n_0_3_379));
   NAND2_X1 i_0_3_154 (.A1(pix0_g_pixelType_lpi_3_dfm[4]), .A2(n_0_3_163), 
      .ZN(n_0_3_158));
   OAI21_X1 i_0_3_153 (.A(n_0_3_158), .B1(n_0_3_383), .B2(n_0_3_163), .ZN(
      MUX_v_8_2_29_return[4]));
   DFF_X1 \pix0_g_pixelType_lpi_3_reg[4]  (.D(MUX_v_8_2_29_return[4]), .CK(n_0_9), 
      .Q(pix0_g_pixelType_lpi_3[4]), .QN());
   AOI22_X1 i_0_3_353 (.A1(n_0_3_455), .A2(dat_in_rsc_dat[12]), .B1(
      pix0_g_pixelType_lpi_3[4]), .B2(n_0_3_247), .ZN(n_0_3_235));
   OAI21_X1 i_0_3_352 (.A(n_0_3_235), .B1(n_0_3_378), .B2(n_0_3_273), .ZN(
      line_buf0_g_pixelType_rsci_d_d[12]));
   DFF_X1 \pix0_g_pixelType_lpi_3_dfm_reg[4]  (.D(
      line_buf0_g_pixelType_rsci_d_d[12]), .CK(n_0_1), .Q(
      pix0_g_pixelType_lpi_3_dfm[4]), .QN());
   AOI22_X1 i_0_3_526 (.A1(pix0_g_pixelType_lpi_3_dfm[4]), .A2(n_0_3_427), 
      .B1(n_0_3_428), .B2(MUX_v_8_2_24_return[4]), .ZN(n_0_3_378));
   DFF_X1 \VCOL_if_2_read_mem_line_buf1_b_pixelType_rsc_cse_lpi_3_reg[8]  (
      .D(line_buf1_b_pixelType_rsci_q_d[8]), .CK(n_0_3), .Q(
      VCOL_if_2_read_mem_line_buf1_b_pixelType_rsc_cse_lpi_3[8]), .QN());
   AOI22_X1 i_0_3_525 (.A1(
      VCOL_if_2_read_mem_line_buf1_b_pixelType_rsc_cse_lpi_3[8]), .A2(n_0_3_423), 
      .B1(line_buf1_b_pixelType_rsci_q_d[2]), .B2(n_0_3_422), .ZN(n_0_3_377));
   OAI21_X1 i_0_3_524 (.A(n_0_3_377), .B1(n_0_3_425), .B2(n_0_3_380), .ZN(
      n_0_3_376));
   FA_X1 i_0_3_27 (.A(n_0_3_379), .B(n_0_3_378), .CI(n_0_3_376), .CO(n_0_3_45), 
      .S(n_0_3_44));
   FA_X1 i_0_3_33 (.A(n_0_3_47), .B(n_0_3_45), .CI(n_0_3_54), .CO(n_0_3_57), 
      .S(n_0_3_56));
   FA_X1 i_0_3_38 (.A(n_0_3_60), .B(n_0_3_57), .CI(n_0_3_64), .CO(n_0_3_67), 
      .S(n_0_3_66));
   NAND2_X1 i_0_3_136 (.A1(pix0_r_pixelType_lpi_3_dfm[3]), .A2(n_0_3_163), 
      .ZN(n_0_3_149));
   OAI21_X1 i_0_3_135 (.A(n_0_3_149), .B1(n_0_3_375), .B2(n_0_3_163), .ZN(
      MUX_v_8_2_210_return[3]));
   DFF_X1 \pix0_r_pixelType_lpi_3_reg[3]  (.D(MUX_v_8_2_210_return[3]), .CK(
      n_0_9), .Q(pix0_r_pixelType_lpi_3[3]), .QN());
   AOI22_X1 i_0_3_367 (.A1(n_0_3_455), .A2(dat_in_rsc_dat[3]), .B1(
      pix0_r_pixelType_lpi_3[3]), .B2(n_0_3_247), .ZN(n_0_3_242));
   OAI21_X1 i_0_3_366 (.A(n_0_3_242), .B1(n_0_3_374), .B2(n_0_3_273), .ZN(
      line_buf0_r_pixelType_rsci_d_d[11]));
   DFF_X1 \pix0_r_pixelType_lpi_3_dfm_reg[3]  (.D(
      line_buf0_r_pixelType_rsci_d_d[11]), .CK(n_0_1), .Q(
      pix0_r_pixelType_lpi_3_dfm[3]), .QN());
   AOI22_X1 i_0_3_521 (.A1(pix0_r_pixelType_lpi_3_dfm[3]), .A2(n_0_3_427), 
      .B1(n_0_3_428), .B2(MUX_v_8_2_22_return[3]), .ZN(n_0_3_374));
   DFF_X1 \VCOL_if_2_read_mem_line_buf1_r_pixelType_rsc_cse_lpi_3_11_6_reg[1]  (
      .D(line_buf1_r_pixelType_rsci_q_d[7]), .CK(n_0_3), .Q(
      VCOL_if_2_read_mem_line_buf1_r_pixelType_rsc_cse_lpi_3_11_6[1]), .QN());
   AOI22_X1 i_0_3_520 (.A1(
      VCOL_if_2_read_mem_line_buf1_r_pixelType_rsc_cse_lpi_3_11_6[1]), .A2(
      n_0_3_423), .B1(line_buf1_r_pixelType_rsci_q_d[1]), .B2(n_0_3_422), 
      .ZN(n_0_3_373));
   OAI21_X1 i_0_3_519 (.A(n_0_3_373), .B1(n_0_3_425), .B2(n_0_3_375), .ZN(
      n_0_3_372));
   DFF_X1 \VCOL_if_2_read_mem_line_buf1_g_pixelType_rsc_cse_lpi_3_reg[7]  (
      .D(line_buf1_g_pixelType_rsci_q_d[7]), .CK(n_0_3), .Q(
      VCOL_if_2_read_mem_line_buf1_g_pixelType_rsc_cse_lpi_3[7]), .QN());
   AOI22_X1 i_0_3_516 (.A1(
      VCOL_if_2_read_mem_line_buf1_g_pixelType_rsc_cse_lpi_3[7]), .A2(n_0_3_423), 
      .B1(line_buf1_g_pixelType_rsci_q_d[1]), .B2(n_0_3_422), .ZN(n_0_3_370));
   OAI21_X1 i_0_3_515 (.A(n_0_3_370), .B1(n_0_3_425), .B2(n_0_3_371), .ZN(
      n_0_3_369));
   FA_X1 i_0_3_24 (.A(n_0_3_374), .B(n_0_3_372), .CI(n_0_3_369), .CO(n_0_3_39), 
      .S(n_0_3_38));
   NAND2_X1 i_0_3_120 (.A1(pix0_b_pixelType_lpi_3_dfm[3]), .A2(n_0_3_163), 
      .ZN(n_0_3_141));
   OAI21_X1 i_0_3_119 (.A(n_0_3_141), .B1(n_0_3_368), .B2(n_0_3_163), .ZN(
      MUX_v_8_2_28_return[3]));
   DFF_X1 \pix0_b_pixelType_lpi_3_reg[3]  (.D(MUX_v_8_2_28_return[3]), .CK(n_0_9), 
      .Q(pix0_b_pixelType_lpi_3[3]), .QN());
   AOI22_X1 i_0_3_335 (.A1(n_0_3_455), .A2(dat_in_rsc_dat[19]), .B1(
      pix0_b_pixelType_lpi_3[3]), .B2(n_0_3_247), .ZN(n_0_3_226));
   OAI21_X1 i_0_3_334 (.A(n_0_3_226), .B1(n_0_3_367), .B2(n_0_3_273), .ZN(
      line_buf0_b_pixelType_rsci_d_d[11]));
   DFF_X1 \pix0_b_pixelType_lpi_3_dfm_reg[3]  (.D(
      line_buf0_b_pixelType_rsci_d_d[11]), .CK(n_0_1), .Q(
      pix0_b_pixelType_lpi_3_dfm[3]), .QN());
   AOI22_X1 i_0_3_512 (.A1(pix0_b_pixelType_lpi_3_dfm[3]), .A2(n_0_3_427), 
      .B1(n_0_3_428), .B2(MUX_v_8_2_23_return[3]), .ZN(n_0_3_367));
   NAND2_X1 i_0_3_152 (.A1(pix0_g_pixelType_lpi_3_dfm[3]), .A2(n_0_3_163), 
      .ZN(n_0_3_157));
   OAI21_X1 i_0_3_151 (.A(n_0_3_157), .B1(n_0_3_371), .B2(n_0_3_163), .ZN(
      MUX_v_8_2_29_return[3]));
   DFF_X1 \pix0_g_pixelType_lpi_3_reg[3]  (.D(MUX_v_8_2_29_return[3]), .CK(n_0_9), 
      .Q(pix0_g_pixelType_lpi_3[3]), .QN());
   AOI22_X1 i_0_3_351 (.A1(n_0_3_455), .A2(dat_in_rsc_dat[11]), .B1(
      pix0_g_pixelType_lpi_3[3]), .B2(n_0_3_247), .ZN(n_0_3_234));
   OAI21_X1 i_0_3_350 (.A(n_0_3_234), .B1(n_0_3_366), .B2(n_0_3_273), .ZN(
      line_buf0_g_pixelType_rsci_d_d[11]));
   DFF_X1 \pix0_g_pixelType_lpi_3_dfm_reg[3]  (.D(
      line_buf0_g_pixelType_rsci_d_d[11]), .CK(n_0_1), .Q(
      pix0_g_pixelType_lpi_3_dfm[3]), .QN());
   AOI22_X1 i_0_3_511 (.A1(pix0_g_pixelType_lpi_3_dfm[3]), .A2(n_0_3_427), 
      .B1(n_0_3_428), .B2(MUX_v_8_2_24_return[3]), .ZN(n_0_3_366));
   DFF_X1 \VCOL_if_2_read_mem_line_buf1_b_pixelType_rsc_cse_lpi_3_reg[7]  (
      .D(line_buf1_b_pixelType_rsci_q_d[7]), .CK(n_0_3), .Q(
      VCOL_if_2_read_mem_line_buf1_b_pixelType_rsc_cse_lpi_3[7]), .QN());
   AOI22_X1 i_0_3_510 (.A1(
      VCOL_if_2_read_mem_line_buf1_b_pixelType_rsc_cse_lpi_3[7]), .A2(n_0_3_423), 
      .B1(line_buf1_b_pixelType_rsci_q_d[1]), .B2(n_0_3_422), .ZN(n_0_3_365));
   OAI21_X1 i_0_3_509 (.A(n_0_3_365), .B1(n_0_3_425), .B2(n_0_3_368), .ZN(
      n_0_3_364));
   FA_X1 i_0_3_23 (.A(n_0_3_367), .B(n_0_3_366), .CI(n_0_3_364), .CO(n_0_3_37), 
      .S(n_0_3_36));
   OAI21_X1 i_0_3_504 (.A(n_0_3_363), .B1(
      reg_operator_11_false_operator_11_false_slc_VCOL_x_0_9_itm_1_cse), 
      .B2(n_0_3_483), .ZN(n_0_3_362));
   INV_X1 i_0_3_161 (.A(n_0_3_163), .ZN(n_0_3_162));
   AOI22_X1 i_0_3_114 (.A1(pix0_b_pixelType_lpi_3_dfm[0]), .A2(n_0_3_163), 
      .B1(n_0_3_362), .B2(n_0_3_162), .ZN(n_0_3_138));
   INV_X1 i_0_3_113 (.A(n_0_3_138), .ZN(MUX_v_8_2_28_return[0]));
   DFF_X1 \pix0_b_pixelType_lpi_3_reg[0]  (.D(MUX_v_8_2_28_return[0]), .CK(n_0_9), 
      .Q(pix0_b_pixelType_lpi_3[0]), .QN());
   AOI22_X1 i_0_3_280 (.A1(n_0_3_455), .A2(dat_in_rsc_dat[16]), .B1(
      pix0_b_pixelType_lpi_3[0]), .B2(n_0_3_247), .ZN(n_0_3_223));
   OAI21_X1 i_0_3_328 (.A(n_0_3_223), .B1(n_0_3_361), .B2(n_0_3_273), .ZN(
      line_buf0_b_pixelType_rsci_d_d[8]));
   DFF_X1 \pix0_b_pixelType_lpi_3_dfm_reg[0]  (.D(
      line_buf0_b_pixelType_rsci_d_d[8]), .CK(n_0_1), .Q(
      pix0_b_pixelType_lpi_3_dfm[0]), .QN());
   AOI22_X1 i_0_3_503 (.A1(pix0_b_pixelType_lpi_3_dfm[0]), .A2(n_0_3_427), 
      .B1(n_0_3_428), .B2(n_0_3_362), .ZN(n_0_3_361));
   OAI21_X1 i_0_3_501 (.A(n_0_3_360), .B1(
      reg_operator_11_false_operator_11_false_slc_VCOL_x_0_9_itm_1_cse), 
      .B2(n_0_3_482), .ZN(n_0_3_359));
   AOI22_X1 i_0_3_116 (.A1(pix0_b_pixelType_lpi_3_dfm[1]), .A2(n_0_3_163), 
      .B1(n_0_3_359), .B2(n_0_3_162), .ZN(n_0_3_139));
   INV_X1 i_0_3_115 (.A(n_0_3_139), .ZN(MUX_v_8_2_28_return[1]));
   DFF_X1 \pix0_b_pixelType_lpi_3_reg[1]  (.D(MUX_v_8_2_28_return[1]), .CK(n_0_9), 
      .Q(pix0_b_pixelType_lpi_3[1]), .QN());
   AOI22_X1 i_0_3_329 (.A1(n_0_3_455), .A2(dat_in_rsc_dat[17]), .B1(
      pix0_b_pixelType_lpi_3[1]), .B2(n_0_3_247), .ZN(n_0_3_224));
   OAI21_X1 i_0_3_281 (.A(n_0_3_224), .B1(n_0_3_358), .B2(n_0_3_273), .ZN(
      line_buf0_b_pixelType_rsci_d_d[9]));
   DFF_X1 \pix0_b_pixelType_lpi_3_dfm_reg[1]  (.D(
      line_buf0_b_pixelType_rsci_d_d[9]), .CK(n_0_1), .Q(
      pix0_b_pixelType_lpi_3_dfm[1]), .QN());
   AOI22_X1 i_0_3_500 (.A1(pix0_b_pixelType_lpi_3_dfm[1]), .A2(n_0_3_427), 
      .B1(n_0_3_428), .B2(n_0_3_359), .ZN(n_0_3_358));
   AND2_X1 i_0_3_499 (.A1(n_0_3_361), .A2(n_0_3_358), .ZN(n_0_3_357));
   DFF_X1 \VCOL_if_2_read_mem_line_buf1_r_pixelType_rsc_cse_lpi_3_11_6_reg[0]  (
      .D(line_buf1_r_pixelType_rsci_q_d[6]), .CK(n_0_3), .Q(
      VCOL_if_2_read_mem_line_buf1_r_pixelType_rsc_cse_lpi_3_11_6[0]), .QN());
   AOI22_X1 i_0_3_496 (.A1(
      VCOL_if_2_read_mem_line_buf1_r_pixelType_rsc_cse_lpi_3_11_6[0]), .A2(
      n_0_3_423), .B1(line_buf1_r_pixelType_rsci_q_d[0]), .B2(n_0_3_422), 
      .ZN(n_0_3_355));
   OAI21_X1 i_0_3_495 (.A(n_0_3_355), .B1(n_0_3_425), .B2(n_0_3_356), .ZN(
      n_0_3_354));
   DFF_X1 \VCOL_if_2_read_mem_line_buf1_g_pixelType_rsc_cse_lpi_3_reg[6]  (
      .D(line_buf1_g_pixelType_rsci_q_d[6]), .CK(n_0_3), .Q(
      VCOL_if_2_read_mem_line_buf1_g_pixelType_rsc_cse_lpi_3[6]), .QN());
   AOI22_X1 i_0_3_492 (.A1(
      VCOL_if_2_read_mem_line_buf1_g_pixelType_rsc_cse_lpi_3[6]), .A2(n_0_3_423), 
      .B1(line_buf1_g_pixelType_rsci_q_d[0]), .B2(n_0_3_422), .ZN(n_0_3_352));
   OAI21_X1 i_0_3_486 (.A(n_0_3_352), .B1(n_0_3_425), .B2(n_0_3_353), .ZN(
      n_0_3_351));
   FA_X1 i_0_3_21 (.A(n_0_3_357), .B(n_0_3_354), .CI(n_0_3_351), .CO(n_0_3_34), 
      .S(n_0_3_33));
   OAI21_X1 i_0_3_490 (.A(n_0_3_349), .B1(
      reg_operator_11_false_operator_11_false_slc_VCOL_x_0_9_itm_1_cse), 
      .B2(n_0_3_481), .ZN(n_0_3_348));
   AOI22_X1 i_0_3_146 (.A1(pix0_g_pixelType_lpi_3_dfm[0]), .A2(n_0_3_163), 
      .B1(n_0_3_348), .B2(n_0_3_162), .ZN(n_0_3_154));
   INV_X1 i_0_3_145 (.A(n_0_3_154), .ZN(MUX_v_8_2_29_return[0]));
   DFF_X1 \pix0_g_pixelType_lpi_3_reg[0]  (.D(MUX_v_8_2_29_return[0]), .CK(n_0_9), 
      .Q(pix0_g_pixelType_lpi_3[0]), .QN());
   AOI22_X1 i_0_3_345 (.A1(n_0_3_455), .A2(dat_in_rsc_dat[8]), .B1(
      pix0_g_pixelType_lpi_3[0]), .B2(n_0_3_247), .ZN(n_0_3_231));
   OAI21_X1 i_0_3_344 (.A(n_0_3_231), .B1(n_0_3_347), .B2(n_0_3_273), .ZN(
      line_buf0_g_pixelType_rsci_d_d[8]));
   DFF_X1 \pix0_g_pixelType_lpi_3_dfm_reg[0]  (.D(
      line_buf0_g_pixelType_rsci_d_d[8]), .CK(n_0_1), .Q(
      pix0_g_pixelType_lpi_3_dfm[0]), .QN());
   AOI22_X1 i_0_3_489 (.A1(pix0_g_pixelType_lpi_3_dfm[0]), .A2(n_0_3_427), 
      .B1(n_0_3_428), .B2(n_0_3_348), .ZN(n_0_3_347));
   AOI22_X1 i_0_3_148 (.A1(pix0_g_pixelType_lpi_3_dfm[1]), .A2(n_0_3_163), 
      .B1(MUX_v_8_2_24_return[1]), .B2(n_0_3_162), .ZN(n_0_3_155));
   INV_X1 i_0_3_147 (.A(n_0_3_155), .ZN(MUX_v_8_2_29_return[1]));
   DFF_X1 \pix0_g_pixelType_lpi_3_reg[1]  (.D(MUX_v_8_2_29_return[1]), .CK(n_0_9), 
      .Q(pix0_g_pixelType_lpi_3[1]), .QN());
   AOI22_X1 i_0_3_347 (.A1(n_0_3_455), .A2(dat_in_rsc_dat[9]), .B1(
      pix0_g_pixelType_lpi_3[1]), .B2(n_0_3_247), .ZN(n_0_3_232));
   OAI21_X1 i_0_3_346 (.A(n_0_3_232), .B1(n_0_3_346), .B2(n_0_3_273), .ZN(
      line_buf0_g_pixelType_rsci_d_d[9]));
   DFF_X1 \pix0_g_pixelType_lpi_3_dfm_reg[1]  (.D(
      line_buf0_g_pixelType_rsci_d_d[9]), .CK(n_0_1), .Q(
      pix0_g_pixelType_lpi_3_dfm[1]), .QN());
   AOI22_X1 i_0_3_488 (.A1(pix0_g_pixelType_lpi_3_dfm[1]), .A2(n_0_3_427), 
      .B1(n_0_3_428), .B2(MUX_v_8_2_24_return[1]), .ZN(n_0_3_346));
   AND2_X1 i_0_3_487 (.A1(n_0_3_347), .A2(n_0_3_346), .ZN(n_0_3_345));
   DFF_X1 \VCOL_if_2_read_mem_line_buf1_b_pixelType_rsc_cse_lpi_3_reg[6]  (
      .D(line_buf1_b_pixelType_rsci_q_d[6]), .CK(n_0_3), .Q(
      VCOL_if_2_read_mem_line_buf1_b_pixelType_rsc_cse_lpi_3[6]), .QN());
   AOI22_X1 i_0_3_484 (.A1(
      VCOL_if_2_read_mem_line_buf1_b_pixelType_rsc_cse_lpi_3[6]), .A2(n_0_3_423), 
      .B1(line_buf1_b_pixelType_rsci_q_d[0]), .B2(n_0_3_422), .ZN(n_0_3_343));
   OAI21_X1 i_0_3_483 (.A(n_0_3_343), .B1(n_0_3_425), .B2(n_0_3_344), .ZN(
      n_0_3_342));
   NAND2_X1 i_0_3_134 (.A1(pix0_r_pixelType_lpi_3_dfm[2]), .A2(n_0_3_163), 
      .ZN(n_0_3_148));
   OAI21_X1 i_0_3_133 (.A(n_0_3_148), .B1(n_0_3_356), .B2(n_0_3_163), .ZN(
      MUX_v_8_2_210_return[2]));
   DFF_X1 \pix0_r_pixelType_lpi_3_reg[2]  (.D(MUX_v_8_2_210_return[2]), .CK(
      n_0_9), .Q(pix0_r_pixelType_lpi_3[2]), .QN());
   AOI22_X1 i_0_3_365 (.A1(n_0_3_455), .A2(dat_in_rsc_dat[2]), .B1(
      pix0_r_pixelType_lpi_3[2]), .B2(n_0_3_247), .ZN(n_0_3_241));
   OAI21_X1 i_0_3_364 (.A(n_0_3_241), .B1(n_0_3_341), .B2(n_0_3_273), .ZN(
      line_buf0_r_pixelType_rsci_d_d[10]));
   DFF_X1 \pix0_r_pixelType_lpi_3_dfm_reg[2]  (.D(
      line_buf0_r_pixelType_rsci_d_d[10]), .CK(n_0_1), .Q(
      pix0_r_pixelType_lpi_3_dfm[2]), .QN());
   AOI22_X1 i_0_3_482 (.A1(pix0_r_pixelType_lpi_3_dfm[2]), .A2(n_0_3_427), 
      .B1(n_0_3_428), .B2(MUX_v_8_2_22_return[2]), .ZN(n_0_3_341));
   FA_X1 i_0_3_20 (.A(n_0_3_345), .B(n_0_3_342), .CI(n_0_3_341), .CO(n_0_3_32), 
      .S(n_0_3_31));
   NAND2_X1 i_0_3_118 (.A1(pix0_b_pixelType_lpi_3_dfm[2]), .A2(n_0_3_163), 
      .ZN(n_0_3_140));
   OAI21_X1 i_0_3_117 (.A(n_0_3_140), .B1(n_0_3_344), .B2(n_0_3_163), .ZN(
      MUX_v_8_2_28_return[2]));
   DFF_X1 \pix0_b_pixelType_lpi_3_reg[2]  (.D(MUX_v_8_2_28_return[2]), .CK(n_0_9), 
      .Q(pix0_b_pixelType_lpi_3[2]), .QN());
   AOI22_X1 i_0_3_331 (.A1(n_0_3_455), .A2(dat_in_rsc_dat[18]), .B1(
      pix0_b_pixelType_lpi_3[2]), .B2(n_0_3_247), .ZN(n_0_3_225));
   OAI21_X1 i_0_3_330 (.A(n_0_3_225), .B1(n_0_3_340), .B2(n_0_3_273), .ZN(
      line_buf0_b_pixelType_rsci_d_d[10]));
   DFF_X1 \pix0_b_pixelType_lpi_3_dfm_reg[2]  (.D(
      line_buf0_b_pixelType_rsci_d_d[10]), .CK(n_0_1), .Q(
      pix0_b_pixelType_lpi_3_dfm[2]), .QN());
   AOI22_X1 i_0_3_470 (.A1(pix0_b_pixelType_lpi_3_dfm[2]), .A2(n_0_3_427), 
      .B1(n_0_3_428), .B2(MUX_v_8_2_23_return[2]), .ZN(n_0_3_340));
   OAI21_X1 i_0_3_479 (.A(n_0_3_339), .B1(
      reg_operator_11_false_operator_11_false_slc_VCOL_x_0_9_itm_1_cse), 
      .B2(n_0_3_479), .ZN(n_0_3_338));
   AOI22_X1 i_0_3_130 (.A1(pix0_r_pixelType_lpi_3_dfm[0]), .A2(n_0_3_163), 
      .B1(n_0_3_338), .B2(n_0_3_162), .ZN(n_0_3_146));
   INV_X1 i_0_3_129 (.A(n_0_3_146), .ZN(MUX_v_8_2_210_return[0]));
   DFF_X1 \pix0_r_pixelType_lpi_3_reg[0]  (.D(MUX_v_8_2_210_return[0]), .CK(
      n_0_9), .Q(pix0_r_pixelType_lpi_3[0]), .QN());
   AOI22_X1 i_0_3_361 (.A1(n_0_3_455), .A2(dat_in_rsc_dat[0]), .B1(
      pix0_r_pixelType_lpi_3[0]), .B2(n_0_3_247), .ZN(n_0_3_239));
   OAI21_X1 i_0_3_360 (.A(n_0_3_239), .B1(n_0_3_337), .B2(n_0_3_273), .ZN(
      line_buf0_r_pixelType_rsci_d_d[8]));
   DFF_X1 \pix0_r_pixelType_lpi_3_dfm_reg[0]  (.D(
      line_buf0_r_pixelType_rsci_d_d[8]), .CK(n_0_1), .Q(
      pix0_r_pixelType_lpi_3_dfm[0]), .QN());
   AOI22_X1 i_0_3_478 (.A1(pix0_r_pixelType_lpi_3_dfm[0]), .A2(n_0_3_427), 
      .B1(n_0_3_428), .B2(n_0_3_338), .ZN(n_0_3_337));
   OAI21_X1 i_0_3_476 (.A(n_0_3_336), .B1(
      reg_operator_11_false_operator_11_false_slc_VCOL_x_0_9_itm_1_cse), 
      .B2(n_0_3_478), .ZN(n_0_3_335));
   AOI22_X1 i_0_3_132 (.A1(pix0_r_pixelType_lpi_3_dfm[1]), .A2(n_0_3_163), 
      .B1(n_0_3_335), .B2(n_0_3_162), .ZN(n_0_3_147));
   INV_X1 i_0_3_131 (.A(n_0_3_147), .ZN(MUX_v_8_2_210_return[1]));
   DFF_X1 \pix0_r_pixelType_lpi_3_reg[1]  (.D(MUX_v_8_2_210_return[1]), .CK(
      n_0_9), .Q(pix0_r_pixelType_lpi_3[1]), .QN());
   AOI22_X1 i_0_3_363 (.A1(n_0_3_455), .A2(dat_in_rsc_dat[1]), .B1(
      pix0_r_pixelType_lpi_3[1]), .B2(n_0_3_247), .ZN(n_0_3_240));
   OAI21_X1 i_0_3_362 (.A(n_0_3_240), .B1(n_0_3_334), .B2(n_0_3_273), .ZN(
      line_buf0_r_pixelType_rsci_d_d[9]));
   DFF_X1 \pix0_r_pixelType_lpi_3_dfm_reg[1]  (.D(
      line_buf0_r_pixelType_rsci_d_d[9]), .CK(n_0_1), .Q(
      pix0_r_pixelType_lpi_3_dfm[1]), .QN());
   AOI22_X1 i_0_3_475 (.A1(pix0_r_pixelType_lpi_3_dfm[1]), .A2(n_0_3_427), 
      .B1(n_0_3_428), .B2(n_0_3_335), .ZN(n_0_3_334));
   AND2_X1 i_0_3_474 (.A1(n_0_3_337), .A2(n_0_3_334), .ZN(n_0_3_333));
   NAND2_X1 i_0_3_150 (.A1(pix0_g_pixelType_lpi_3_dfm[2]), .A2(n_0_3_163), 
      .ZN(n_0_3_156));
   OAI21_X1 i_0_3_149 (.A(n_0_3_156), .B1(n_0_3_353), .B2(n_0_3_163), .ZN(
      MUX_v_8_2_29_return[2]));
   DFF_X1 \pix0_g_pixelType_lpi_3_reg[2]  (.D(MUX_v_8_2_29_return[2]), .CK(n_0_9), 
      .Q(pix0_g_pixelType_lpi_3[2]), .QN());
   AOI22_X1 i_0_3_349 (.A1(n_0_3_455), .A2(dat_in_rsc_dat[10]), .B1(
      pix0_g_pixelType_lpi_3[2]), .B2(n_0_3_247), .ZN(n_0_3_233));
   OAI21_X1 i_0_3_348 (.A(n_0_3_233), .B1(n_0_3_332), .B2(n_0_3_273), .ZN(
      line_buf0_g_pixelType_rsci_d_d[10]));
   DFF_X1 \pix0_g_pixelType_lpi_3_dfm_reg[2]  (.D(
      line_buf0_g_pixelType_rsci_d_d[10]), .CK(n_0_1), .Q(
      pix0_g_pixelType_lpi_3_dfm[2]), .QN());
   AOI22_X1 i_0_3_473 (.A1(pix0_g_pixelType_lpi_3_dfm[2]), .A2(n_0_3_427), 
      .B1(n_0_3_428), .B2(MUX_v_8_2_24_return[2]), .ZN(n_0_3_332));
   FA_X1 i_0_3_19 (.A(n_0_3_340), .B(n_0_3_333), .CI(n_0_3_332), .CO(n_0_3_30), 
      .S(n_0_3_29));
   FA_X1 i_0_3_25 (.A(n_0_3_34), .B(n_0_3_32), .CI(n_0_3_30), .CO(n_0_3_41), 
      .S(n_0_3_40));
   FA_X1 i_0_3_29 (.A(n_0_3_39), .B(n_0_3_37), .CI(n_0_3_41), .CO(n_0_3_49), 
      .S(n_0_3_48));
   FA_X1 i_0_3_34 (.A(n_0_3_52), .B(n_0_3_49), .CI(n_0_3_56), .CO(n_0_3_59), 
      .S(n_0_3_58));
   FA_X1 i_0_3_30 (.A(n_0_3_46), .B(n_0_3_44), .CI(n_0_3_48), .CO(n_0_3_51), 
      .S(n_0_3_50));
   FA_X1 i_0_3_26 (.A(n_0_3_38), .B(n_0_3_36), .CI(n_0_3_40), .CO(n_0_3_43), 
      .S(n_0_3_42));
   FA_X1 i_0_3_22 (.A(n_0_3_33), .B(n_0_3_31), .CI(n_0_3_29), .CO(n_0_3_35), 
      .S(n_0_76));
   HA_X1 i_0_3_44 (.A(n_0_3_35), .B(n_0_3_42), .CO(n_0_3_78), .S(n_0_77));
   FA_X1 i_0_3_45 (.A(n_0_3_43), .B(n_0_3_50), .CI(n_0_3_78), .CO(n_0_3_79), 
      .S(n_0_78));
   FA_X1 i_0_3_46 (.A(n_0_3_51), .B(n_0_3_58), .CI(n_0_3_79), .CO(n_0_3_80), 
      .S(n_0_79));
   FA_X1 i_0_3_47 (.A(n_0_3_59), .B(n_0_3_66), .CI(n_0_3_80), .CO(n_0_3_81), 
      .S(n_0_80));
   FA_X1 i_0_3_48 (.A(n_0_3_67), .B(n_0_3_74), .CI(n_0_3_81), .CO(n_0_3_82), 
      .S(n_0_81));
   FA_X1 i_0_3_49 (.A(n_0_3_76), .B(n_0_3_75), .CI(n_0_3_82), .CO(n_0_3_83), 
      .S(n_0_82));
   FA_X1 i_0_3_50 (.A(n_0_3_102), .B(n_0_3_77), .CI(n_0_3_83), .CO(n_0_3_84), 
      .S(n_0_83));
   INV_X1 i_0_3_640 (.A(n_0_3_84), .ZN(n_0_84));
   DFF_X1 \dy_rsci_idat_reg[8]  (.D(n_0_84), .CK(n_0_10), .Q(dy_rsc_dat[8]), 
      .QN());
   DFF_X1 \dy_rsci_idat_reg[7]  (.D(n_0_83), .CK(n_0_10), .Q(dy_rsc_dat[7]), 
      .QN());
   DFF_X1 \dy_rsci_idat_reg[6]  (.D(n_0_82), .CK(n_0_10), .Q(dy_rsc_dat[6]), 
      .QN());
   DFF_X1 \dy_rsci_idat_reg[5]  (.D(n_0_81), .CK(n_0_10), .Q(dy_rsc_dat[5]), 
      .QN());
   DFF_X1 \dy_rsci_idat_reg[4]  (.D(n_0_80), .CK(n_0_10), .Q(dy_rsc_dat[4]), 
      .QN());
   DFF_X1 \dy_rsci_idat_reg[3]  (.D(n_0_79), .CK(n_0_10), .Q(dy_rsc_dat[3]), 
      .QN());
   DFF_X1 \dy_rsci_idat_reg[2]  (.D(n_0_78), .CK(n_0_10), .Q(dy_rsc_dat[2]), 
      .QN());
   DFF_X1 \dy_rsci_idat_reg[1]  (.D(n_0_77), .CK(n_0_10), .Q(dy_rsc_dat[1]), 
      .QN());
   DFF_X1 \dy_rsci_idat_reg[0]  (.D(n_0_76), .CK(n_0_10), .Q(dy_rsc_dat[0]), 
      .QN());
   NOR4_X1 i_0_3_414 (.A1(n_0_3_472), .A2(n_0_3_276), .A3(VCOL_x_sva[0]), 
      .A4(n_0_3_278), .ZN(wrbuf0_pix_b_pixelType_and_cse));
   CLKGATE_X1 clk_gate_wrbuf0_pix_r_pixelType_7_0_lpi_4_reg (.CK(clk), .E(
      wrbuf0_pix_b_pixelType_and_cse), .GCK(n_0_2));
   DFF_X1 \wrbuf0_pix_r_pixelType_7_0_lpi_4_reg[7]  (.D(
      line_buf0_r_pixelType_rsci_d_d[15]), .CK(n_0_2), .Q(
      line_buf0_r_pixelType_rsci_d_d[7]), .QN());
   DFF_X1 \wrbuf0_pix_r_pixelType_7_0_lpi_4_reg[6]  (.D(
      line_buf0_r_pixelType_rsci_d_d[14]), .CK(n_0_2), .Q(
      line_buf0_r_pixelType_rsci_d_d[6]), .QN());
   DFF_X1 \wrbuf0_pix_r_pixelType_7_0_lpi_4_reg[5]  (.D(
      line_buf0_r_pixelType_rsci_d_d[13]), .CK(n_0_2), .Q(
      line_buf0_r_pixelType_rsci_d_d[5]), .QN());
   DFF_X1 \wrbuf0_pix_r_pixelType_7_0_lpi_4_reg[4]  (.D(
      line_buf0_r_pixelType_rsci_d_d[12]), .CK(n_0_2), .Q(
      line_buf0_r_pixelType_rsci_d_d[4]), .QN());
   DFF_X1 \wrbuf0_pix_r_pixelType_7_0_lpi_4_reg[3]  (.D(
      line_buf0_r_pixelType_rsci_d_d[11]), .CK(n_0_2), .Q(
      line_buf0_r_pixelType_rsci_d_d[3]), .QN());
   DFF_X1 \wrbuf0_pix_r_pixelType_7_0_lpi_4_reg[2]  (.D(
      line_buf0_r_pixelType_rsci_d_d[10]), .CK(n_0_2), .Q(
      line_buf0_r_pixelType_rsci_d_d[2]), .QN());
   DFF_X1 \wrbuf0_pix_r_pixelType_7_0_lpi_4_reg[1]  (.D(
      line_buf0_r_pixelType_rsci_d_d[9]), .CK(n_0_2), .Q(
      line_buf0_r_pixelType_rsci_d_d[1]), .QN());
   DFF_X1 \wrbuf0_pix_r_pixelType_7_0_lpi_4_reg[0]  (.D(
      line_buf0_r_pixelType_rsci_d_d[8]), .CK(n_0_2), .Q(
      line_buf0_r_pixelType_rsci_d_d[0]), .QN());
   OAI21_X1 i_0_3_468 (.A(n_0_3_329), .B1(VCOL_stage_0_2), .B2(VCOL_stage_0_3), 
      .ZN(n_0_3_328));
   NOR2_X1 i_0_3_217 (.A1(rst), .A2(n_0_3_328), .ZN(n_0_52));
   DFFR_X1 reg_line_buf0_r_pixelType_rsci_cgo_cse_reg (.D(n_0_52), .RN(arst_n), 
      .CK(n_0_6), .Q(reg_line_buf0_r_pixelType_rsci_cgo_cse), .QN());
   INV_X1 i_0_3_635 (.A(reg_line_buf0_r_pixelType_rsci_cgo_cse), .ZN(n_0_3_473));
   AOI21_X1 i_0_3_467 (.A(n_0_3_331), .B1(n_0_3_473), .B2(n_0_3_328), .ZN(
      line_buf0_r_pixelType_rsci_en_d));
   DFF_X1 \wrbuf0_pix_g_pixelType_7_0_lpi_4_reg[7]  (.D(
      line_buf0_g_pixelType_rsci_d_d[15]), .CK(n_0_2), .Q(
      line_buf0_g_pixelType_rsci_d_d[7]), .QN());
   DFF_X1 \wrbuf0_pix_g_pixelType_7_0_lpi_4_reg[6]  (.D(
      line_buf0_g_pixelType_rsci_d_d[14]), .CK(n_0_2), .Q(
      line_buf0_g_pixelType_rsci_d_d[6]), .QN());
   DFF_X1 \wrbuf0_pix_g_pixelType_7_0_lpi_4_reg[5]  (.D(
      line_buf0_g_pixelType_rsci_d_d[13]), .CK(n_0_2), .Q(
      line_buf0_g_pixelType_rsci_d_d[5]), .QN());
   DFF_X1 \wrbuf0_pix_g_pixelType_7_0_lpi_4_reg[4]  (.D(
      line_buf0_g_pixelType_rsci_d_d[12]), .CK(n_0_2), .Q(
      line_buf0_g_pixelType_rsci_d_d[4]), .QN());
   DFF_X1 \wrbuf0_pix_g_pixelType_7_0_lpi_4_reg[3]  (.D(
      line_buf0_g_pixelType_rsci_d_d[11]), .CK(n_0_2), .Q(
      line_buf0_g_pixelType_rsci_d_d[3]), .QN());
   DFF_X1 \wrbuf0_pix_g_pixelType_7_0_lpi_4_reg[2]  (.D(
      line_buf0_g_pixelType_rsci_d_d[10]), .CK(n_0_2), .Q(
      line_buf0_g_pixelType_rsci_d_d[2]), .QN());
   DFF_X1 \wrbuf0_pix_g_pixelType_7_0_lpi_4_reg[1]  (.D(
      line_buf0_g_pixelType_rsci_d_d[9]), .CK(n_0_2), .Q(
      line_buf0_g_pixelType_rsci_d_d[1]), .QN());
   DFF_X1 \wrbuf0_pix_g_pixelType_7_0_lpi_4_reg[0]  (.D(
      line_buf0_g_pixelType_rsci_d_d[8]), .CK(n_0_2), .Q(
      line_buf0_g_pixelType_rsci_d_d[0]), .QN());
   DFF_X1 \wrbuf0_pix_b_pixelType_7_0_lpi_4_reg[7]  (.D(
      line_buf0_b_pixelType_rsci_d_d[15]), .CK(n_0_2), .Q(
      line_buf0_b_pixelType_rsci_d_d[7]), .QN());
   DFF_X1 \wrbuf0_pix_b_pixelType_7_0_lpi_4_reg[6]  (.D(
      line_buf0_b_pixelType_rsci_d_d[14]), .CK(n_0_2), .Q(
      line_buf0_b_pixelType_rsci_d_d[6]), .QN());
   DFF_X1 \wrbuf0_pix_b_pixelType_7_0_lpi_4_reg[5]  (.D(
      line_buf0_b_pixelType_rsci_d_d[13]), .CK(n_0_2), .Q(
      line_buf0_b_pixelType_rsci_d_d[5]), .QN());
   DFF_X1 \wrbuf0_pix_b_pixelType_7_0_lpi_4_reg[4]  (.D(
      line_buf0_b_pixelType_rsci_d_d[12]), .CK(n_0_2), .Q(
      line_buf0_b_pixelType_rsci_d_d[4]), .QN());
   DFF_X1 \wrbuf0_pix_b_pixelType_7_0_lpi_4_reg[3]  (.D(
      line_buf0_b_pixelType_rsci_d_d[11]), .CK(n_0_2), .Q(
      line_buf0_b_pixelType_rsci_d_d[3]), .QN());
   DFF_X1 \wrbuf0_pix_b_pixelType_7_0_lpi_4_reg[2]  (.D(
      line_buf0_b_pixelType_rsci_d_d[10]), .CK(n_0_2), .Q(
      line_buf0_b_pixelType_rsci_d_d[2]), .QN());
   DFF_X1 \wrbuf0_pix_b_pixelType_7_0_lpi_4_reg[1]  (.D(
      line_buf0_b_pixelType_rsci_d_d[9]), .CK(n_0_2), .Q(
      line_buf0_b_pixelType_rsci_d_d[1]), .QN());
   DFF_X1 \wrbuf0_pix_b_pixelType_7_0_lpi_4_reg[0]  (.D(
      line_buf0_b_pixelType_rsci_d_d[8]), .CK(n_0_2), .Q(
      line_buf0_b_pixelType_rsci_d_d[0]), .QN());
   AOI22_X1 i_0_3_327 (.A1(line_buf0_r_pixelType_rsci_q_d[15]), .A2(n_0_3_270), 
      .B1(rdbuf0_pix_r_pixelType_lpi_3_reg[15]), .B2(n_0_3_271), .ZN(n_0_3_222));
   INV_X1 i_0_3_326 (.A(n_0_3_222), .ZN(line_buf1_r_pixelType_rsci_d_d[11]));
   AOI22_X1 i_0_3_325 (.A1(line_buf0_r_pixelType_rsci_q_d[14]), .A2(n_0_3_270), 
      .B1(rdbuf0_pix_r_pixelType_lpi_3_reg[14]), .B2(n_0_3_271), .ZN(n_0_3_221));
   INV_X1 i_0_3_324 (.A(n_0_3_221), .ZN(line_buf1_r_pixelType_rsci_d_d[10]));
   AOI22_X1 i_0_3_323 (.A1(line_buf0_r_pixelType_rsci_q_d[13]), .A2(n_0_3_270), 
      .B1(rdbuf0_pix_r_pixelType_lpi_3_reg[13]), .B2(n_0_3_271), .ZN(n_0_3_220));
   INV_X1 i_0_3_322 (.A(n_0_3_220), .ZN(line_buf1_r_pixelType_rsci_d_d[9]));
   AOI22_X1 i_0_3_321 (.A1(line_buf0_r_pixelType_rsci_q_d[12]), .A2(n_0_3_270), 
      .B1(rdbuf0_pix_r_pixelType_lpi_3_reg[12]), .B2(n_0_3_271), .ZN(n_0_3_219));
   INV_X1 i_0_3_320 (.A(n_0_3_219), .ZN(line_buf1_r_pixelType_rsci_d_d[8]));
   AOI22_X1 i_0_3_319 (.A1(line_buf0_r_pixelType_rsci_q_d[11]), .A2(n_0_3_270), 
      .B1(rdbuf0_pix_r_pixelType_lpi_3_reg[11]), .B2(n_0_3_271), .ZN(n_0_3_218));
   INV_X1 i_0_3_318 (.A(n_0_3_218), .ZN(line_buf1_r_pixelType_rsci_d_d[7]));
   AOI22_X1 i_0_3_317 (.A1(line_buf0_r_pixelType_rsci_q_d[10]), .A2(n_0_3_270), 
      .B1(rdbuf0_pix_r_pixelType_lpi_3_reg[10]), .B2(n_0_3_271), .ZN(n_0_3_217));
   INV_X1 i_0_3_316 (.A(n_0_3_217), .ZN(line_buf1_r_pixelType_rsci_d_d[6]));
   DFF_X1 \rdbuf0_pix_r_pixelType_lpi_3_reg[7]  (.D(
      line_buf0_r_pixelType_rsci_q_d[7]), .CK(n_0_0), .Q(
      rdbuf0_pix_r_pixelType_lpi_3_reg[7]), .QN());
   AOI22_X1 i_0_3_315 (.A1(line_buf0_r_pixelType_rsci_q_d[7]), .A2(n_0_3_270), 
      .B1(rdbuf0_pix_r_pixelType_lpi_3_reg[7]), .B2(n_0_3_271), .ZN(n_0_3_216));
   INV_X1 i_0_3_314 (.A(n_0_3_216), .ZN(line_buf1_r_pixelType_rsci_d_d[5]));
   DFF_X1 \rdbuf0_pix_r_pixelType_lpi_3_reg[6]  (.D(
      line_buf0_r_pixelType_rsci_q_d[6]), .CK(n_0_0), .Q(
      rdbuf0_pix_r_pixelType_lpi_3_reg[6]), .QN());
   AOI22_X1 i_0_3_313 (.A1(rdbuf0_pix_r_pixelType_lpi_3_reg[6]), .A2(n_0_3_271), 
      .B1(line_buf0_r_pixelType_rsci_q_d[6]), .B2(n_0_3_270), .ZN(n_0_3_215));
   INV_X1 i_0_3_312 (.A(n_0_3_215), .ZN(line_buf1_r_pixelType_rsci_d_d[4]));
   DFF_X1 \rdbuf0_pix_r_pixelType_lpi_3_reg[5]  (.D(
      line_buf0_r_pixelType_rsci_q_d[5]), .CK(n_0_0), .Q(
      rdbuf0_pix_r_pixelType_lpi_3_reg[5]), .QN());
   AOI22_X1 i_0_3_311 (.A1(rdbuf0_pix_r_pixelType_lpi_3_reg[5]), .A2(n_0_3_271), 
      .B1(line_buf0_r_pixelType_rsci_q_d[5]), .B2(n_0_3_270), .ZN(n_0_3_214));
   INV_X1 i_0_3_310 (.A(n_0_3_214), .ZN(line_buf1_r_pixelType_rsci_d_d[3]));
   DFF_X1 \rdbuf0_pix_r_pixelType_lpi_3_reg[4]  (.D(
      line_buf0_r_pixelType_rsci_q_d[4]), .CK(n_0_0), .Q(
      rdbuf0_pix_r_pixelType_lpi_3_reg[4]), .QN());
   AOI22_X1 i_0_3_309 (.A1(rdbuf0_pix_r_pixelType_lpi_3_reg[4]), .A2(n_0_3_271), 
      .B1(line_buf0_r_pixelType_rsci_q_d[4]), .B2(n_0_3_270), .ZN(n_0_3_213));
   INV_X1 i_0_3_308 (.A(n_0_3_213), .ZN(line_buf1_r_pixelType_rsci_d_d[2]));
   DFF_X1 \rdbuf0_pix_r_pixelType_lpi_3_reg[3]  (.D(
      line_buf0_r_pixelType_rsci_q_d[3]), .CK(n_0_0), .Q(
      rdbuf0_pix_r_pixelType_lpi_3_reg[3]), .QN());
   AOI22_X1 i_0_3_307 (.A1(rdbuf0_pix_r_pixelType_lpi_3_reg[3]), .A2(n_0_3_271), 
      .B1(line_buf0_r_pixelType_rsci_q_d[3]), .B2(n_0_3_270), .ZN(n_0_3_212));
   INV_X1 i_0_3_306 (.A(n_0_3_212), .ZN(line_buf1_r_pixelType_rsci_d_d[1]));
   DFF_X1 \rdbuf0_pix_r_pixelType_lpi_3_reg[2]  (.D(
      line_buf0_r_pixelType_rsci_q_d[2]), .CK(n_0_0), .Q(
      rdbuf0_pix_r_pixelType_lpi_3_reg[2]), .QN());
   AOI22_X1 i_0_3_305 (.A1(rdbuf0_pix_r_pixelType_lpi_3_reg[2]), .A2(n_0_3_271), 
      .B1(line_buf0_r_pixelType_rsci_q_d[2]), .B2(n_0_3_270), .ZN(n_0_3_211));
   INV_X1 i_0_3_304 (.A(n_0_3_211), .ZN(line_buf1_r_pixelType_rsci_d_d[0]));
   AOI22_X1 i_0_3_303 (.A1(line_buf0_g_pixelType_rsci_q_d[15]), .A2(n_0_3_270), 
      .B1(rdbuf0_pix_g_pixelType_lpi_3_reg[15]), .B2(n_0_3_271), .ZN(n_0_3_210));
   INV_X1 i_0_3_302 (.A(n_0_3_210), .ZN(line_buf1_g_pixelType_rsci_d_d[11]));
   AOI22_X1 i_0_3_301 (.A1(line_buf0_g_pixelType_rsci_q_d[14]), .A2(n_0_3_270), 
      .B1(rdbuf0_pix_g_pixelType_lpi_3_reg[14]), .B2(n_0_3_271), .ZN(n_0_3_209));
   INV_X1 i_0_3_300 (.A(n_0_3_209), .ZN(line_buf1_g_pixelType_rsci_d_d[10]));
   AOI22_X1 i_0_3_299 (.A1(line_buf0_g_pixelType_rsci_q_d[13]), .A2(n_0_3_270), 
      .B1(rdbuf0_pix_g_pixelType_lpi_3_reg[13]), .B2(n_0_3_271), .ZN(n_0_3_208));
   INV_X1 i_0_3_298 (.A(n_0_3_208), .ZN(line_buf1_g_pixelType_rsci_d_d[9]));
   AOI22_X1 i_0_3_297 (.A1(line_buf0_g_pixelType_rsci_q_d[12]), .A2(n_0_3_270), 
      .B1(rdbuf0_pix_g_pixelType_lpi_3_reg[12]), .B2(n_0_3_271), .ZN(n_0_3_207));
   INV_X1 i_0_3_296 (.A(n_0_3_207), .ZN(line_buf1_g_pixelType_rsci_d_d[8]));
   AOI22_X1 i_0_3_295 (.A1(line_buf0_g_pixelType_rsci_q_d[11]), .A2(n_0_3_270), 
      .B1(rdbuf0_pix_g_pixelType_lpi_3_reg[11]), .B2(n_0_3_271), .ZN(n_0_3_206));
   INV_X1 i_0_3_294 (.A(n_0_3_206), .ZN(line_buf1_g_pixelType_rsci_d_d[7]));
   AOI22_X1 i_0_3_293 (.A1(line_buf0_g_pixelType_rsci_q_d[10]), .A2(n_0_3_270), 
      .B1(rdbuf0_pix_g_pixelType_lpi_3_reg[10]), .B2(n_0_3_271), .ZN(n_0_3_205));
   INV_X1 i_0_3_292 (.A(n_0_3_205), .ZN(line_buf1_g_pixelType_rsci_d_d[6]));
   DFF_X1 \rdbuf0_pix_g_pixelType_lpi_3_reg[7]  (.D(
      line_buf0_g_pixelType_rsci_q_d[7]), .CK(n_0_0), .Q(
      rdbuf0_pix_g_pixelType_lpi_3_reg[7]), .QN());
   AOI22_X1 i_0_3_291 (.A1(rdbuf0_pix_g_pixelType_lpi_3_reg[7]), .A2(n_0_3_271), 
      .B1(line_buf0_g_pixelType_rsci_q_d[7]), .B2(n_0_3_270), .ZN(n_0_3_204));
   INV_X1 i_0_3_290 (.A(n_0_3_204), .ZN(line_buf1_g_pixelType_rsci_d_d[5]));
   DFF_X1 \rdbuf0_pix_g_pixelType_lpi_3_reg[6]  (.D(
      line_buf0_g_pixelType_rsci_q_d[6]), .CK(n_0_0), .Q(
      rdbuf0_pix_g_pixelType_lpi_3_reg[6]), .QN());
   AOI22_X1 i_0_3_289 (.A1(rdbuf0_pix_g_pixelType_lpi_3_reg[6]), .A2(n_0_3_271), 
      .B1(line_buf0_g_pixelType_rsci_q_d[6]), .B2(n_0_3_270), .ZN(n_0_3_203));
   INV_X1 i_0_3_288 (.A(n_0_3_203), .ZN(line_buf1_g_pixelType_rsci_d_d[4]));
   DFF_X1 \rdbuf0_pix_g_pixelType_lpi_3_reg[5]  (.D(
      line_buf0_g_pixelType_rsci_q_d[5]), .CK(n_0_0), .Q(
      rdbuf0_pix_g_pixelType_lpi_3_reg[5]), .QN());
   AOI22_X1 i_0_3_287 (.A1(rdbuf0_pix_g_pixelType_lpi_3_reg[5]), .A2(n_0_3_271), 
      .B1(line_buf0_g_pixelType_rsci_q_d[5]), .B2(n_0_3_270), .ZN(n_0_3_202));
   INV_X1 i_0_3_286 (.A(n_0_3_202), .ZN(line_buf1_g_pixelType_rsci_d_d[3]));
   DFF_X1 \rdbuf0_pix_g_pixelType_lpi_3_reg[4]  (.D(
      line_buf0_g_pixelType_rsci_q_d[4]), .CK(n_0_0), .Q(
      rdbuf0_pix_g_pixelType_lpi_3_reg[4]), .QN());
   AOI22_X1 i_0_3_285 (.A1(rdbuf0_pix_g_pixelType_lpi_3_reg[4]), .A2(n_0_3_271), 
      .B1(line_buf0_g_pixelType_rsci_q_d[4]), .B2(n_0_3_270), .ZN(n_0_3_201));
   INV_X1 i_0_3_284 (.A(n_0_3_201), .ZN(line_buf1_g_pixelType_rsci_d_d[2]));
   DFF_X1 \rdbuf0_pix_g_pixelType_lpi_3_reg[3]  (.D(
      line_buf0_g_pixelType_rsci_q_d[3]), .CK(n_0_0), .Q(
      rdbuf0_pix_g_pixelType_lpi_3_reg[3]), .QN());
   AOI22_X1 i_0_3_283 (.A1(rdbuf0_pix_g_pixelType_lpi_3_reg[3]), .A2(n_0_3_271), 
      .B1(line_buf0_g_pixelType_rsci_q_d[3]), .B2(n_0_3_270), .ZN(n_0_3_200));
   INV_X1 i_0_3_282 (.A(n_0_3_200), .ZN(line_buf1_g_pixelType_rsci_d_d[1]));
   DFF_X1 \rdbuf0_pix_g_pixelType_lpi_3_reg[2]  (.D(
      line_buf0_g_pixelType_rsci_q_d[2]), .CK(n_0_0), .Q(
      rdbuf0_pix_g_pixelType_lpi_3_reg[2]), .QN());
   AOI22_X1 i_0_3_277 (.A1(rdbuf0_pix_g_pixelType_lpi_3_reg[2]), .A2(n_0_3_271), 
      .B1(line_buf0_g_pixelType_rsci_q_d[2]), .B2(n_0_3_270), .ZN(n_0_3_199));
   INV_X1 i_0_3_276 (.A(n_0_3_199), .ZN(line_buf1_g_pixelType_rsci_d_d[0]));
   AOI22_X1 i_0_3_279 (.A1(line_buf0_b_pixelType_rsci_q_d[15]), .A2(n_0_3_270), 
      .B1(rdbuf0_pix_b_pixelType_lpi_3_reg[15]), .B2(n_0_3_271), .ZN(n_0_3_198));
   INV_X1 i_0_3_278 (.A(n_0_3_198), .ZN(line_buf1_b_pixelType_rsci_d_d[11]));
   AOI22_X1 i_0_3_275 (.A1(line_buf0_b_pixelType_rsci_q_d[14]), .A2(n_0_3_270), 
      .B1(rdbuf0_pix_b_pixelType_lpi_3_reg[14]), .B2(n_0_3_271), .ZN(n_0_3_197));
   INV_X1 i_0_3_255 (.A(n_0_3_197), .ZN(line_buf1_b_pixelType_rsci_d_d[10]));
   AOI22_X1 i_0_3_229 (.A1(line_buf0_b_pixelType_rsci_q_d[13]), .A2(n_0_3_270), 
      .B1(rdbuf0_pix_b_pixelType_lpi_3_reg[13]), .B2(n_0_3_271), .ZN(n_0_3_196));
   INV_X1 i_0_3_274 (.A(n_0_3_196), .ZN(line_buf1_b_pixelType_rsci_d_d[9]));
   AOI22_X1 i_0_3_273 (.A1(line_buf0_b_pixelType_rsci_q_d[12]), .A2(n_0_3_270), 
      .B1(rdbuf0_pix_b_pixelType_lpi_3_reg[12]), .B2(n_0_3_271), .ZN(n_0_3_195));
   INV_X1 i_0_3_272 (.A(n_0_3_195), .ZN(line_buf1_b_pixelType_rsci_d_d[8]));
   AOI22_X1 i_0_3_271 (.A1(line_buf0_b_pixelType_rsci_q_d[11]), .A2(n_0_3_270), 
      .B1(rdbuf0_pix_b_pixelType_lpi_3_reg[11]), .B2(n_0_3_271), .ZN(n_0_3_194));
   INV_X1 i_0_3_270 (.A(n_0_3_194), .ZN(line_buf1_b_pixelType_rsci_d_d[7]));
   AOI22_X1 i_0_3_269 (.A1(line_buf0_b_pixelType_rsci_q_d[10]), .A2(n_0_3_270), 
      .B1(rdbuf0_pix_b_pixelType_lpi_3_reg[10]), .B2(n_0_3_271), .ZN(n_0_3_193));
   INV_X1 i_0_3_268 (.A(n_0_3_193), .ZN(line_buf1_b_pixelType_rsci_d_d[6]));
   DFF_X1 \rdbuf0_pix_b_pixelType_lpi_3_reg[7]  (.D(
      line_buf0_b_pixelType_rsci_q_d[7]), .CK(n_0_0), .Q(
      rdbuf0_pix_b_pixelType_lpi_3_reg[7]), .QN());
   AOI22_X1 i_0_3_267 (.A1(rdbuf0_pix_b_pixelType_lpi_3_reg[7]), .A2(n_0_3_271), 
      .B1(line_buf0_b_pixelType_rsci_q_d[7]), .B2(n_0_3_270), .ZN(n_0_3_192));
   INV_X1 i_0_3_266 (.A(n_0_3_192), .ZN(line_buf1_b_pixelType_rsci_d_d[5]));
   DFF_X1 \rdbuf0_pix_b_pixelType_lpi_3_reg[6]  (.D(
      line_buf0_b_pixelType_rsci_q_d[6]), .CK(n_0_0), .Q(
      rdbuf0_pix_b_pixelType_lpi_3_reg[6]), .QN());
   AOI22_X1 i_0_3_265 (.A1(rdbuf0_pix_b_pixelType_lpi_3_reg[6]), .A2(n_0_3_271), 
      .B1(line_buf0_b_pixelType_rsci_q_d[6]), .B2(n_0_3_270), .ZN(n_0_3_191));
   INV_X1 i_0_3_264 (.A(n_0_3_191), .ZN(line_buf1_b_pixelType_rsci_d_d[4]));
   DFF_X1 \rdbuf0_pix_b_pixelType_lpi_3_reg[5]  (.D(
      line_buf0_b_pixelType_rsci_q_d[5]), .CK(n_0_0), .Q(
      rdbuf0_pix_b_pixelType_lpi_3_reg[5]), .QN());
   AOI22_X1 i_0_3_263 (.A1(rdbuf0_pix_b_pixelType_lpi_3_reg[5]), .A2(n_0_3_271), 
      .B1(line_buf0_b_pixelType_rsci_q_d[5]), .B2(n_0_3_270), .ZN(n_0_3_190));
   INV_X1 i_0_3_262 (.A(n_0_3_190), .ZN(line_buf1_b_pixelType_rsci_d_d[3]));
   DFF_X1 \rdbuf0_pix_b_pixelType_lpi_3_reg[4]  (.D(
      line_buf0_b_pixelType_rsci_q_d[4]), .CK(n_0_0), .Q(
      rdbuf0_pix_b_pixelType_lpi_3_reg[4]), .QN());
   AOI22_X1 i_0_3_261 (.A1(rdbuf0_pix_b_pixelType_lpi_3_reg[4]), .A2(n_0_3_271), 
      .B1(line_buf0_b_pixelType_rsci_q_d[4]), .B2(n_0_3_270), .ZN(n_0_3_189));
   INV_X1 i_0_3_260 (.A(n_0_3_189), .ZN(line_buf1_b_pixelType_rsci_d_d[2]));
   DFF_X1 \rdbuf0_pix_b_pixelType_lpi_3_reg[3]  (.D(
      line_buf0_b_pixelType_rsci_q_d[3]), .CK(n_0_0), .Q(
      rdbuf0_pix_b_pixelType_lpi_3_reg[3]), .QN());
   AOI22_X1 i_0_3_259 (.A1(rdbuf0_pix_b_pixelType_lpi_3_reg[3]), .A2(n_0_3_271), 
      .B1(line_buf0_b_pixelType_rsci_q_d[3]), .B2(n_0_3_270), .ZN(n_0_3_188));
   INV_X1 i_0_3_258 (.A(n_0_3_188), .ZN(line_buf1_b_pixelType_rsci_d_d[1]));
   DFF_X1 \rdbuf0_pix_b_pixelType_lpi_3_reg[2]  (.D(
      line_buf0_b_pixelType_rsci_q_d[2]), .CK(n_0_0), .Q(
      rdbuf0_pix_b_pixelType_lpi_3_reg[2]), .QN());
   AOI22_X1 i_0_3_257 (.A1(rdbuf0_pix_b_pixelType_lpi_3_reg[2]), .A2(n_0_3_271), 
      .B1(line_buf0_b_pixelType_rsci_q_d[2]), .B2(n_0_3_270), .ZN(n_0_3_187));
   INV_X1 i_0_3_256 (.A(n_0_3_187), .ZN(line_buf1_b_pixelType_rsci_d_d[0]));
   DFFR_X1 operator_11_false_operator_11_false_slc_VCOL_x_0_2_itm_1_reg (
      .D(n_0_100), .RN(arst_n), .CK(n_0_7), .Q(
      operator_11_false_operator_11_false_slc_VCOL_x_0_2_itm_1), .QN());
   AND3_X1 i_0_3_394 (.A1(VCOL_stage_0_2), .A2(
      operator_11_false_operator_11_false_slc_VCOL_x_0_2_itm_1), .A3(n_0_3_329), 
      .ZN(line_buf0_r_pixelType_rsci_we_d_pff));
endmodule

module EdgeDetect_IP_EdgeDetect_VerDer_struct(clk, rst, arst_n, 
      dat_in_rsc_dat_eol, dat_in_rsc_dat_sof, dat_in_rsc_dat_dummy, 
      dat_in_rsc_dat_b_pixelType, dat_in_rsc_dat_g_pixelType, 
      dat_in_rsc_dat_r_pixelType, dat_in_rsc_vld, dat_in_rsc_rdy, widthIn, 
      heightIn, dat_out_rsc_dat, dat_out_rsc_vld, dat_out_rsc_rdy, 
      dat_rgb_rsc_dat_eol, dat_rgb_rsc_dat_sof, dat_rgb_rsc_dat_dummy, 
      dat_rgb_rsc_dat_b_pixelType, dat_rgb_rsc_dat_g_pixelType, 
      dat_rgb_rsc_dat_r_pixelType, dat_rgb_rsc_vld, dat_rgb_rsc_rdy, dy_rsc_dat, 
      dy_rsc_vld, dy_rsc_rdy, line_buf0_r_pixelType_rsc_en, 
      line_buf0_r_pixelType_rsc_q, line_buf0_r_pixelType_rsc_we, 
      line_buf0_r_pixelType_rsc_d, line_buf0_r_pixelType_rsc_adr, 
      line_buf0_g_pixelType_rsc_en, line_buf0_g_pixelType_rsc_q, 
      line_buf0_g_pixelType_rsc_we, line_buf0_g_pixelType_rsc_d, 
      line_buf0_g_pixelType_rsc_adr, line_buf0_b_pixelType_rsc_en, 
      line_buf0_b_pixelType_rsc_q, line_buf0_b_pixelType_rsc_we, 
      line_buf0_b_pixelType_rsc_d, line_buf0_b_pixelType_rsc_adr, 
      line_buf1_r_pixelType_rsc_en, line_buf1_r_pixelType_rsc_q, 
      line_buf1_r_pixelType_rsc_we, line_buf1_r_pixelType_rsc_d, 
      line_buf1_r_pixelType_rsc_adr, line_buf1_g_pixelType_rsc_en, 
      line_buf1_g_pixelType_rsc_q, line_buf1_g_pixelType_rsc_we, 
      line_buf1_g_pixelType_rsc_d, line_buf1_g_pixelType_rsc_adr, 
      line_buf1_b_pixelType_rsc_en, line_buf1_b_pixelType_rsc_q, 
      line_buf1_b_pixelType_rsc_we, line_buf1_b_pixelType_rsc_d, 
      line_buf1_b_pixelType_rsc_adr);
   input clk;
   input rst;
   input arst_n;
   input dat_in_rsc_dat_eol;
   input dat_in_rsc_dat_sof;
   input [7:0]dat_in_rsc_dat_dummy;
   input [7:0]dat_in_rsc_dat_b_pixelType;
   input [7:0]dat_in_rsc_dat_g_pixelType;
   input [7:0]dat_in_rsc_dat_r_pixelType;
   input dat_in_rsc_vld;
   output dat_in_rsc_rdy;
   input [10:0]widthIn;
   input [9:0]heightIn;
   output [7:0]dat_out_rsc_dat;
   output dat_out_rsc_vld;
   input dat_out_rsc_rdy;
   output dat_rgb_rsc_dat_eol;
   output dat_rgb_rsc_dat_sof;
   output [7:0]dat_rgb_rsc_dat_dummy;
   output [7:0]dat_rgb_rsc_dat_b_pixelType;
   output [7:0]dat_rgb_rsc_dat_g_pixelType;
   output [7:0]dat_rgb_rsc_dat_r_pixelType;
   output dat_rgb_rsc_vld;
   input dat_rgb_rsc_rdy;
   output [8:0]dy_rsc_dat;
   output dy_rsc_vld;
   input dy_rsc_rdy;
   output line_buf0_r_pixelType_rsc_en;
   input [15:0]line_buf0_r_pixelType_rsc_q;
   output line_buf0_r_pixelType_rsc_we;
   output [15:0]line_buf0_r_pixelType_rsc_d;
   output [9:0]line_buf0_r_pixelType_rsc_adr;
   output line_buf0_g_pixelType_rsc_en;
   input [15:0]line_buf0_g_pixelType_rsc_q;
   output line_buf0_g_pixelType_rsc_we;
   output [15:0]line_buf0_g_pixelType_rsc_d;
   output [9:0]line_buf0_g_pixelType_rsc_adr;
   output line_buf0_b_pixelType_rsc_en;
   input [15:0]line_buf0_b_pixelType_rsc_q;
   output line_buf0_b_pixelType_rsc_we;
   output [15:0]line_buf0_b_pixelType_rsc_d;
   output [9:0]line_buf0_b_pixelType_rsc_adr;
   output line_buf1_r_pixelType_rsc_en;
   input [11:0]line_buf1_r_pixelType_rsc_q;
   output line_buf1_r_pixelType_rsc_we;
   output [11:0]line_buf1_r_pixelType_rsc_d;
   output [9:0]line_buf1_r_pixelType_rsc_adr;
   output line_buf1_g_pixelType_rsc_en;
   input [11:0]line_buf1_g_pixelType_rsc_q;
   output line_buf1_g_pixelType_rsc_we;
   output [11:0]line_buf1_g_pixelType_rsc_d;
   output [9:0]line_buf1_g_pixelType_rsc_adr;
   output line_buf1_b_pixelType_rsc_en;
   input [11:0]line_buf1_b_pixelType_rsc_q;
   output line_buf1_b_pixelType_rsc_we;
   output [11:0]line_buf1_b_pixelType_rsc_d;
   output [9:0]line_buf1_b_pixelType_rsc_adr;

   EdgeDetect_IP_EdgeDetect_VerDer_run EdgeDetect_IP_EdgeDetect_VerDer_run_inst (
      .clk(clk), .rst(rst), .arst_n(arst_n), .dat_in_rsc_dat({uc_0, uc_1, uc_2, 
      uc_3, uc_4, uc_5, uc_6, uc_7, uc_8, uc_9, dat_in_rsc_dat_b_pixelType[7], 
      dat_in_rsc_dat_b_pixelType[6], dat_in_rsc_dat_b_pixelType[5], 
      dat_in_rsc_dat_b_pixelType[4], dat_in_rsc_dat_b_pixelType[3], 
      dat_in_rsc_dat_b_pixelType[2], dat_in_rsc_dat_b_pixelType[1], 
      dat_in_rsc_dat_b_pixelType[0], dat_in_rsc_dat_g_pixelType[7], 
      dat_in_rsc_dat_g_pixelType[6], dat_in_rsc_dat_g_pixelType[5], 
      dat_in_rsc_dat_g_pixelType[4], dat_in_rsc_dat_g_pixelType[3], 
      dat_in_rsc_dat_g_pixelType[2], dat_in_rsc_dat_g_pixelType[1], 
      dat_in_rsc_dat_g_pixelType[0], dat_in_rsc_dat_r_pixelType[7], 
      dat_in_rsc_dat_r_pixelType[6], dat_in_rsc_dat_r_pixelType[5], 
      dat_in_rsc_dat_r_pixelType[4], dat_in_rsc_dat_r_pixelType[3], 
      dat_in_rsc_dat_r_pixelType[2], dat_in_rsc_dat_r_pixelType[1], 
      dat_in_rsc_dat_r_pixelType[0]}), .dat_in_rsc_vld(dat_in_rsc_vld), 
      .dat_in_rsc_rdy(dat_in_rsc_rdy), .widthIn(widthIn), .heightIn(heightIn), 
      .dat_out_rsc_dat(dat_out_rsc_dat), .dat_out_rsc_vld(dat_out_rsc_vld), 
      .dat_out_rsc_rdy(dat_out_rsc_rdy), .dat_rgb_rsc_dat({uc_10, uc_11, uc_12, 
      uc_13, uc_14, uc_15, uc_16, uc_17, uc_18, uc_19, 
      dat_rgb_rsc_dat_b_pixelType[7], dat_rgb_rsc_dat_b_pixelType[6], 
      dat_rgb_rsc_dat_b_pixelType[5], dat_rgb_rsc_dat_b_pixelType[4], 
      dat_rgb_rsc_dat_b_pixelType[3], dat_rgb_rsc_dat_b_pixelType[2], 
      dat_rgb_rsc_dat_b_pixelType[1], dat_rgb_rsc_dat_b_pixelType[0], 
      dat_rgb_rsc_dat_g_pixelType[7], dat_rgb_rsc_dat_g_pixelType[6], 
      dat_rgb_rsc_dat_g_pixelType[5], dat_rgb_rsc_dat_g_pixelType[4], 
      dat_rgb_rsc_dat_g_pixelType[3], dat_rgb_rsc_dat_g_pixelType[2], 
      dat_rgb_rsc_dat_g_pixelType[1], dat_rgb_rsc_dat_g_pixelType[0], 
      dat_rgb_rsc_dat_r_pixelType[7], dat_rgb_rsc_dat_r_pixelType[6], 
      dat_rgb_rsc_dat_r_pixelType[5], dat_rgb_rsc_dat_r_pixelType[4], 
      dat_rgb_rsc_dat_r_pixelType[3], dat_rgb_rsc_dat_r_pixelType[2], 
      dat_rgb_rsc_dat_r_pixelType[1], dat_rgb_rsc_dat_r_pixelType[0]}), 
      .dat_rgb_rsc_vld(dat_rgb_rsc_vld), .dat_rgb_rsc_rdy(dat_rgb_rsc_rdy), 
      .dy_rsc_dat(dy_rsc_dat), .dy_rsc_vld(dy_rsc_vld), .dy_rsc_rdy(dy_rsc_rdy), 
      .line_buf0_r_pixelType_rsci_d_d(line_buf0_r_pixelType_rsc_d), 
      .line_buf0_r_pixelType_rsci_en_d(line_buf0_r_pixelType_rsc_en), 
      .line_buf0_r_pixelType_rsci_q_d(line_buf0_r_pixelType_rsc_q), 
      .line_buf0_g_pixelType_rsci_d_d(line_buf0_g_pixelType_rsc_d), 
      .line_buf0_g_pixelType_rsci_q_d(line_buf0_g_pixelType_rsc_q), 
      .line_buf0_b_pixelType_rsci_d_d(line_buf0_b_pixelType_rsc_d), 
      .line_buf0_b_pixelType_rsci_q_d(line_buf0_b_pixelType_rsc_q), 
      .line_buf1_r_pixelType_rsci_d_d(line_buf1_r_pixelType_rsc_d), 
      .line_buf1_r_pixelType_rsci_q_d(line_buf1_r_pixelType_rsc_q), 
      .line_buf1_g_pixelType_rsci_d_d(line_buf1_g_pixelType_rsc_d), 
      .line_buf1_g_pixelType_rsci_q_d(line_buf1_g_pixelType_rsc_q), 
      .line_buf1_b_pixelType_rsci_d_d(line_buf1_b_pixelType_rsc_d), 
      .line_buf1_b_pixelType_rsci_q_d(line_buf1_b_pixelType_rsc_q), 
      .line_buf0_r_pixelType_rsci_adr_d_pff(line_buf0_r_pixelType_rsc_adr), 
      .line_buf0_r_pixelType_rsci_we_d_pff(line_buf0_r_pixelType_rsc_we), 
      .line_buf0_r_pixelType_rsci_port_0_rw_ram_ir_internal_RMASK_B_d_pff());
endmodule

module EdgeDetect_IP_EdgeDetect_VerDer(clk, rst, arst_n, dat_in_rsc_dat, 
      dat_in_rsc_vld, dat_in_rsc_rdy, widthIn, heightIn, dat_out_rsc_dat, 
      dat_out_rsc_vld, dat_out_rsc_rdy, dat_rgb_rsc_dat, dat_rgb_rsc_vld, 
      dat_rgb_rsc_rdy, dy_rsc_dat, dy_rsc_vld, dy_rsc_rdy, 
      line_buf0_r_pixelType_rsc_en, line_buf0_r_pixelType_rsc_q, 
      line_buf0_r_pixelType_rsc_we, line_buf0_r_pixelType_rsc_d, 
      line_buf0_r_pixelType_rsc_adr, line_buf0_g_pixelType_rsc_en, 
      line_buf0_g_pixelType_rsc_q, line_buf0_g_pixelType_rsc_we, 
      line_buf0_g_pixelType_rsc_d, line_buf0_g_pixelType_rsc_adr, 
      line_buf0_b_pixelType_rsc_en, line_buf0_b_pixelType_rsc_q, 
      line_buf0_b_pixelType_rsc_we, line_buf0_b_pixelType_rsc_d, 
      line_buf0_b_pixelType_rsc_adr, line_buf1_r_pixelType_rsc_en, 
      line_buf1_r_pixelType_rsc_q, line_buf1_r_pixelType_rsc_we, 
      line_buf1_r_pixelType_rsc_d, line_buf1_r_pixelType_rsc_adr, 
      line_buf1_g_pixelType_rsc_en, line_buf1_g_pixelType_rsc_q, 
      line_buf1_g_pixelType_rsc_we, line_buf1_g_pixelType_rsc_d, 
      line_buf1_g_pixelType_rsc_adr, line_buf1_b_pixelType_rsc_en, 
      line_buf1_b_pixelType_rsc_q, line_buf1_b_pixelType_rsc_we, 
      line_buf1_b_pixelType_rsc_d, line_buf1_b_pixelType_rsc_adr);
   input clk;
   input rst;
   input arst_n;
   input [33:0]dat_in_rsc_dat;
   input dat_in_rsc_vld;
   output dat_in_rsc_rdy;
   input [10:0]widthIn;
   input [9:0]heightIn;
   output [7:0]dat_out_rsc_dat;
   output dat_out_rsc_vld;
   input dat_out_rsc_rdy;
   output [33:0]dat_rgb_rsc_dat;
   output dat_rgb_rsc_vld;
   input dat_rgb_rsc_rdy;
   output [8:0]dy_rsc_dat;
   output dy_rsc_vld;
   input dy_rsc_rdy;
   output line_buf0_r_pixelType_rsc_en;
   input [15:0]line_buf0_r_pixelType_rsc_q;
   output line_buf0_r_pixelType_rsc_we;
   output [15:0]line_buf0_r_pixelType_rsc_d;
   output [9:0]line_buf0_r_pixelType_rsc_adr;
   output line_buf0_g_pixelType_rsc_en;
   input [15:0]line_buf0_g_pixelType_rsc_q;
   output line_buf0_g_pixelType_rsc_we;
   output [15:0]line_buf0_g_pixelType_rsc_d;
   output [9:0]line_buf0_g_pixelType_rsc_adr;
   output line_buf0_b_pixelType_rsc_en;
   input [15:0]line_buf0_b_pixelType_rsc_q;
   output line_buf0_b_pixelType_rsc_we;
   output [15:0]line_buf0_b_pixelType_rsc_d;
   output [9:0]line_buf0_b_pixelType_rsc_adr;
   output line_buf1_r_pixelType_rsc_en;
   input [11:0]line_buf1_r_pixelType_rsc_q;
   output line_buf1_r_pixelType_rsc_we;
   output [11:0]line_buf1_r_pixelType_rsc_d;
   output [9:0]line_buf1_r_pixelType_rsc_adr;
   output line_buf1_g_pixelType_rsc_en;
   input [11:0]line_buf1_g_pixelType_rsc_q;
   output line_buf1_g_pixelType_rsc_we;
   output [11:0]line_buf1_g_pixelType_rsc_d;
   output [9:0]line_buf1_g_pixelType_rsc_adr;
   output line_buf1_b_pixelType_rsc_en;
   input [11:0]line_buf1_b_pixelType_rsc_q;
   output line_buf1_b_pixelType_rsc_we;
   output [11:0]line_buf1_b_pixelType_rsc_d;
   output [9:0]line_buf1_b_pixelType_rsc_adr;

   EdgeDetect_IP_EdgeDetect_VerDer_struct EdgeDetect_IP_EdgeDetect_VerDer_struct_inst (
      .clk(clk), .rst(rst), .arst_n(arst_n), .dat_in_rsc_dat_eol(), 
      .dat_in_rsc_dat_sof(), .dat_in_rsc_dat_dummy(), 
      .dat_in_rsc_dat_b_pixelType({dat_in_rsc_dat[23], dat_in_rsc_dat[22], 
      dat_in_rsc_dat[21], dat_in_rsc_dat[20], dat_in_rsc_dat[19], 
      dat_in_rsc_dat[18], dat_in_rsc_dat[17], dat_in_rsc_dat[16]}), 
      .dat_in_rsc_dat_g_pixelType({dat_in_rsc_dat[15], dat_in_rsc_dat[14], 
      dat_in_rsc_dat[13], dat_in_rsc_dat[12], dat_in_rsc_dat[11], 
      dat_in_rsc_dat[10], dat_in_rsc_dat[9], dat_in_rsc_dat[8]}), 
      .dat_in_rsc_dat_r_pixelType({dat_in_rsc_dat[7], dat_in_rsc_dat[6], 
      dat_in_rsc_dat[5], dat_in_rsc_dat[4], dat_in_rsc_dat[3], dat_in_rsc_dat[2], 
      dat_in_rsc_dat[1], dat_in_rsc_dat[0]}), .dat_in_rsc_vld(dat_in_rsc_vld), 
      .dat_in_rsc_rdy(dat_in_rsc_rdy), .widthIn(widthIn), .heightIn(heightIn), 
      .dat_out_rsc_dat(dat_out_rsc_dat), .dat_out_rsc_vld(dat_out_rsc_vld), 
      .dat_out_rsc_rdy(dat_out_rsc_rdy), .dat_rgb_rsc_dat_eol(), 
      .dat_rgb_rsc_dat_sof(), .dat_rgb_rsc_dat_dummy(), 
      .dat_rgb_rsc_dat_b_pixelType({dat_rgb_rsc_dat[23], dat_rgb_rsc_dat[22], 
      dat_rgb_rsc_dat[21], dat_rgb_rsc_dat[20], dat_rgb_rsc_dat[19], 
      dat_rgb_rsc_dat[18], dat_rgb_rsc_dat[17], dat_rgb_rsc_dat[16]}), 
      .dat_rgb_rsc_dat_g_pixelType({dat_rgb_rsc_dat[15], dat_rgb_rsc_dat[14], 
      dat_rgb_rsc_dat[13], dat_rgb_rsc_dat[12], dat_rgb_rsc_dat[11], 
      dat_rgb_rsc_dat[10], dat_rgb_rsc_dat[9], dat_rgb_rsc_dat[8]}), 
      .dat_rgb_rsc_dat_r_pixelType({dat_rgb_rsc_dat[7], dat_rgb_rsc_dat[6], 
      dat_rgb_rsc_dat[5], dat_rgb_rsc_dat[4], dat_rgb_rsc_dat[3], 
      dat_rgb_rsc_dat[2], dat_rgb_rsc_dat[1], dat_rgb_rsc_dat[0]}), 
      .dat_rgb_rsc_vld(dat_rgb_rsc_vld), .dat_rgb_rsc_rdy(dat_rgb_rsc_rdy), 
      .dy_rsc_dat(dy_rsc_dat), .dy_rsc_vld(dy_rsc_vld), .dy_rsc_rdy(dy_rsc_rdy), 
      .line_buf0_r_pixelType_rsc_en(line_buf0_r_pixelType_rsc_en), 
      .line_buf0_r_pixelType_rsc_q(line_buf0_r_pixelType_rsc_q), 
      .line_buf0_r_pixelType_rsc_we(line_buf0_r_pixelType_rsc_we), 
      .line_buf0_r_pixelType_rsc_d(line_buf0_r_pixelType_rsc_d), 
      .line_buf0_r_pixelType_rsc_adr(line_buf0_r_pixelType_rsc_adr), 
      .line_buf0_g_pixelType_rsc_en(), .line_buf0_g_pixelType_rsc_q(
      line_buf0_g_pixelType_rsc_q), .line_buf0_g_pixelType_rsc_we(), 
      .line_buf0_g_pixelType_rsc_d(line_buf0_g_pixelType_rsc_d), 
      .line_buf0_g_pixelType_rsc_adr(), .line_buf0_b_pixelType_rsc_en(), 
      .line_buf0_b_pixelType_rsc_q(line_buf0_b_pixelType_rsc_q), 
      .line_buf0_b_pixelType_rsc_we(), .line_buf0_b_pixelType_rsc_d(
      line_buf0_b_pixelType_rsc_d), .line_buf0_b_pixelType_rsc_adr(), 
      .line_buf1_r_pixelType_rsc_en(), .line_buf1_r_pixelType_rsc_q(
      line_buf1_r_pixelType_rsc_q), .line_buf1_r_pixelType_rsc_we(), 
      .line_buf1_r_pixelType_rsc_d(line_buf1_r_pixelType_rsc_d), 
      .line_buf1_r_pixelType_rsc_adr(), .line_buf1_g_pixelType_rsc_en(), 
      .line_buf1_g_pixelType_rsc_q(line_buf1_g_pixelType_rsc_q), 
      .line_buf1_g_pixelType_rsc_we(), .line_buf1_g_pixelType_rsc_d(
      line_buf1_g_pixelType_rsc_d), .line_buf1_g_pixelType_rsc_adr(), 
      .line_buf1_b_pixelType_rsc_en(), .line_buf1_b_pixelType_rsc_q(
      line_buf1_b_pixelType_rsc_q), .line_buf1_b_pixelType_rsc_we(), 
      .line_buf1_b_pixelType_rsc_d(line_buf1_b_pixelType_rsc_d), 
      .line_buf1_b_pixelType_rsc_adr());
endmodule

module EdgeDetect_IP_EdgeDetect_Top(clk, rst, arst_n, dat_in_rsc_dat, 
      dat_in_rsc_vld, dat_in_rsc_rdy, widthIn, heightIn, dat_out_rsc_dat, 
      dat_out_rsc_vld, dat_out_rsc_rdy, line_buf0_r_pixelType_rsc_en, 
      line_buf0_r_pixelType_rsc_q, line_buf0_r_pixelType_rsc_we, 
      line_buf0_r_pixelType_rsc_d, line_buf0_r_pixelType_rsc_adr, 
      line_buf0_g_pixelType_rsc_en, line_buf0_g_pixelType_rsc_q, 
      line_buf0_g_pixelType_rsc_we, line_buf0_g_pixelType_rsc_d, 
      line_buf0_g_pixelType_rsc_adr, line_buf0_b_pixelType_rsc_en, 
      line_buf0_b_pixelType_rsc_q, line_buf0_b_pixelType_rsc_we, 
      line_buf0_b_pixelType_rsc_d, line_buf0_b_pixelType_rsc_adr, 
      line_buf1_r_pixelType_rsc_en, line_buf1_r_pixelType_rsc_q, 
      line_buf1_r_pixelType_rsc_we, line_buf1_r_pixelType_rsc_d, 
      line_buf1_r_pixelType_rsc_adr, line_buf1_g_pixelType_rsc_en, 
      line_buf1_g_pixelType_rsc_q, line_buf1_g_pixelType_rsc_we, 
      line_buf1_g_pixelType_rsc_d, line_buf1_g_pixelType_rsc_adr, 
      line_buf1_b_pixelType_rsc_en, line_buf1_b_pixelType_rsc_q, 
      line_buf1_b_pixelType_rsc_we, line_buf1_b_pixelType_rsc_d, 
      line_buf1_b_pixelType_rsc_adr);
   input clk;
   input rst;
   input arst_n;
   input [33:0]dat_in_rsc_dat;
   input dat_in_rsc_vld;
   output dat_in_rsc_rdy;
   input [10:0]widthIn;
   input [9:0]heightIn;
   output [33:0]dat_out_rsc_dat;
   output dat_out_rsc_vld;
   input dat_out_rsc_rdy;
   output line_buf0_r_pixelType_rsc_en;
   input [15:0]line_buf0_r_pixelType_rsc_q;
   output line_buf0_r_pixelType_rsc_we;
   output [15:0]line_buf0_r_pixelType_rsc_d;
   output [9:0]line_buf0_r_pixelType_rsc_adr;
   output line_buf0_g_pixelType_rsc_en;
   input [15:0]line_buf0_g_pixelType_rsc_q;
   output line_buf0_g_pixelType_rsc_we;
   output [15:0]line_buf0_g_pixelType_rsc_d;
   output [9:0]line_buf0_g_pixelType_rsc_adr;
   output line_buf0_b_pixelType_rsc_en;
   input [15:0]line_buf0_b_pixelType_rsc_q;
   output line_buf0_b_pixelType_rsc_we;
   output [15:0]line_buf0_b_pixelType_rsc_d;
   output [9:0]line_buf0_b_pixelType_rsc_adr;
   output line_buf1_r_pixelType_rsc_en;
   input [11:0]line_buf1_r_pixelType_rsc_q;
   output line_buf1_r_pixelType_rsc_we;
   output [11:0]line_buf1_r_pixelType_rsc_d;
   output [9:0]line_buf1_r_pixelType_rsc_adr;
   output line_buf1_g_pixelType_rsc_en;
   input [11:0]line_buf1_g_pixelType_rsc_q;
   output line_buf1_g_pixelType_rsc_we;
   output [11:0]line_buf1_g_pixelType_rsc_d;
   output [9:0]line_buf1_g_pixelType_rsc_adr;
   output line_buf1_b_pixelType_rsc_en;
   input [11:0]line_buf1_b_pixelType_rsc_q;
   output line_buf1_b_pixelType_rsc_we;
   output [11:0]line_buf1_b_pixelType_rsc_d;
   output [9:0]line_buf1_b_pixelType_rsc_adr;

   wire kmean_out_rsc_vld_n_Kmean_inst_bud;
   wire [23:0]kmean_out_rsc_dat_n_Kmean_inst;
   wire kmean_in_rsc_rdy_n_Kmean_inst_bud;
   wire magn_rsc_rdy_n_Mix_inst_bud;
   wire grb_in_rsc_rdy_n_Mix_inst_bud;
   wire magn_rsc_vld_n_MagAng_inst_bud;
   wire [7:0]magn_rsc_dat_n_MagAng_inst;
   wire dy_in_rsc_rdy_n_MagAng_inst_bud;
   wire dx_in_rsc_rdy_n_MagAng_inst_bud;
   wire dx_rsc_vld_n_HorDer_inst_bud;
   wire [8:0]dx_rsc_dat_n_HorDer_inst;
   wire dat_in_rsc_rdy_n_HorDer_inst_bud;
   wire dy_rsc_vld_n_VerDer_inst_bud;
   wire [8:0]dy_rsc_dat_n_VerDer_inst;
   wire dat_rgb_rsc_vld_n_VerDer_inst_bud;
   wire [33:0]dat_rgb_rsc_dat_n_VerDer_inst;
   wire dat_out_rsc_vld_n_VerDer_inst_bud;
   wire [7:0]dat_out_rsc_dat_n_VerDer_inst;
   wire [8:0]dy_in_rsc_dat_n_MagAng_inst;
   wire dy_in_rsc_vld_n_MagAng_inst;
   wire dy_rsc_rdy_n_VerDer_inst;
   wire [7:0]magn_rsc_dat_n_Mix_inst;
   wire magn_rsc_vld_n_Mix_inst;
   wire magn_rsc_rdy_n_MagAng_inst;

   assign dat_out_rsc_dat[31] = 1'b0;
   assign dat_out_rsc_dat[30] = 1'b0;
   assign dat_out_rsc_dat[29] = 1'b0;
   assign dat_out_rsc_dat[28] = 1'b0;
   assign dat_out_rsc_dat[27] = 1'b0;
   assign dat_out_rsc_dat[26] = 1'b0;
   assign dat_out_rsc_dat[25] = 1'b0;
   assign dat_out_rsc_dat[22] = dat_out_rsc_dat[16];
   assign dat_out_rsc_dat[15] = dat_out_rsc_dat[11];
   assign dat_out_rsc_dat[14] = dat_out_rsc_dat[8];
   assign dat_out_rsc_dat[7] = dat_out_rsc_dat[3];
   assign dat_out_rsc_dat[6] = dat_out_rsc_dat[0];
   assign line_buf0_r_pixelType_rsc_en = line_buf1_b_pixelType_rsc_en;
   assign line_buf0_r_pixelType_rsc_we = line_buf1_b_pixelType_rsc_we;
   assign line_buf0_r_pixelType_rsc_adr[9] = line_buf1_b_pixelType_rsc_adr[9];
   assign line_buf0_r_pixelType_rsc_adr[8] = line_buf1_b_pixelType_rsc_adr[8];
   assign line_buf0_r_pixelType_rsc_adr[7] = line_buf1_b_pixelType_rsc_adr[7];
   assign line_buf0_r_pixelType_rsc_adr[6] = line_buf1_b_pixelType_rsc_adr[6];
   assign line_buf0_r_pixelType_rsc_adr[5] = line_buf1_b_pixelType_rsc_adr[5];
   assign line_buf0_r_pixelType_rsc_adr[4] = line_buf1_b_pixelType_rsc_adr[4];
   assign line_buf0_r_pixelType_rsc_adr[3] = line_buf1_b_pixelType_rsc_adr[3];
   assign line_buf0_r_pixelType_rsc_adr[2] = line_buf1_b_pixelType_rsc_adr[2];
   assign line_buf0_r_pixelType_rsc_adr[1] = line_buf1_b_pixelType_rsc_adr[1];
   assign line_buf0_r_pixelType_rsc_adr[0] = line_buf1_b_pixelType_rsc_adr[0];
   assign line_buf0_g_pixelType_rsc_en = line_buf1_b_pixelType_rsc_en;
   assign line_buf0_g_pixelType_rsc_we = line_buf1_b_pixelType_rsc_we;
   assign line_buf0_g_pixelType_rsc_adr[9] = line_buf1_b_pixelType_rsc_adr[9];
   assign line_buf0_g_pixelType_rsc_adr[8] = line_buf1_b_pixelType_rsc_adr[8];
   assign line_buf0_g_pixelType_rsc_adr[7] = line_buf1_b_pixelType_rsc_adr[7];
   assign line_buf0_g_pixelType_rsc_adr[6] = line_buf1_b_pixelType_rsc_adr[6];
   assign line_buf0_g_pixelType_rsc_adr[5] = line_buf1_b_pixelType_rsc_adr[5];
   assign line_buf0_g_pixelType_rsc_adr[4] = line_buf1_b_pixelType_rsc_adr[4];
   assign line_buf0_g_pixelType_rsc_adr[3] = line_buf1_b_pixelType_rsc_adr[3];
   assign line_buf0_g_pixelType_rsc_adr[2] = line_buf1_b_pixelType_rsc_adr[2];
   assign line_buf0_g_pixelType_rsc_adr[1] = line_buf1_b_pixelType_rsc_adr[1];
   assign line_buf0_g_pixelType_rsc_adr[0] = line_buf1_b_pixelType_rsc_adr[0];
   assign line_buf0_b_pixelType_rsc_en = line_buf1_b_pixelType_rsc_en;
   assign line_buf0_b_pixelType_rsc_we = line_buf1_b_pixelType_rsc_we;
   assign line_buf0_b_pixelType_rsc_adr[9] = line_buf1_b_pixelType_rsc_adr[9];
   assign line_buf0_b_pixelType_rsc_adr[8] = line_buf1_b_pixelType_rsc_adr[8];
   assign line_buf0_b_pixelType_rsc_adr[7] = line_buf1_b_pixelType_rsc_adr[7];
   assign line_buf0_b_pixelType_rsc_adr[6] = line_buf1_b_pixelType_rsc_adr[6];
   assign line_buf0_b_pixelType_rsc_adr[5] = line_buf1_b_pixelType_rsc_adr[5];
   assign line_buf0_b_pixelType_rsc_adr[4] = line_buf1_b_pixelType_rsc_adr[4];
   assign line_buf0_b_pixelType_rsc_adr[3] = line_buf1_b_pixelType_rsc_adr[3];
   assign line_buf0_b_pixelType_rsc_adr[2] = line_buf1_b_pixelType_rsc_adr[2];
   assign line_buf0_b_pixelType_rsc_adr[1] = line_buf1_b_pixelType_rsc_adr[1];
   assign line_buf0_b_pixelType_rsc_adr[0] = line_buf1_b_pixelType_rsc_adr[0];
   assign line_buf1_r_pixelType_rsc_en = line_buf1_b_pixelType_rsc_en;
   assign line_buf1_r_pixelType_rsc_we = line_buf1_b_pixelType_rsc_we;
   assign line_buf1_r_pixelType_rsc_adr[9] = line_buf1_b_pixelType_rsc_adr[9];
   assign line_buf1_r_pixelType_rsc_adr[8] = line_buf1_b_pixelType_rsc_adr[8];
   assign line_buf1_r_pixelType_rsc_adr[7] = line_buf1_b_pixelType_rsc_adr[7];
   assign line_buf1_r_pixelType_rsc_adr[6] = line_buf1_b_pixelType_rsc_adr[6];
   assign line_buf1_r_pixelType_rsc_adr[5] = line_buf1_b_pixelType_rsc_adr[5];
   assign line_buf1_r_pixelType_rsc_adr[4] = line_buf1_b_pixelType_rsc_adr[4];
   assign line_buf1_r_pixelType_rsc_adr[3] = line_buf1_b_pixelType_rsc_adr[3];
   assign line_buf1_r_pixelType_rsc_adr[2] = line_buf1_b_pixelType_rsc_adr[2];
   assign line_buf1_r_pixelType_rsc_adr[1] = line_buf1_b_pixelType_rsc_adr[1];
   assign line_buf1_r_pixelType_rsc_adr[0] = line_buf1_b_pixelType_rsc_adr[0];
   assign line_buf1_g_pixelType_rsc_en = line_buf1_b_pixelType_rsc_en;
   assign line_buf1_g_pixelType_rsc_we = line_buf1_b_pixelType_rsc_we;
   assign line_buf1_g_pixelType_rsc_adr[9] = line_buf1_b_pixelType_rsc_adr[9];
   assign line_buf1_g_pixelType_rsc_adr[8] = line_buf1_b_pixelType_rsc_adr[8];
   assign line_buf1_g_pixelType_rsc_adr[7] = line_buf1_b_pixelType_rsc_adr[7];
   assign line_buf1_g_pixelType_rsc_adr[6] = line_buf1_b_pixelType_rsc_adr[6];
   assign line_buf1_g_pixelType_rsc_adr[5] = line_buf1_b_pixelType_rsc_adr[5];
   assign line_buf1_g_pixelType_rsc_adr[4] = line_buf1_b_pixelType_rsc_adr[4];
   assign line_buf1_g_pixelType_rsc_adr[3] = line_buf1_b_pixelType_rsc_adr[3];
   assign line_buf1_g_pixelType_rsc_adr[2] = line_buf1_b_pixelType_rsc_adr[2];
   assign line_buf1_g_pixelType_rsc_adr[1] = line_buf1_b_pixelType_rsc_adr[1];
   assign line_buf1_g_pixelType_rsc_adr[0] = line_buf1_b_pixelType_rsc_adr[0];

   ccs_pipe_v6 dy_cns_pipe (.clk(clk), .en(), .arst(arst_n), .srst(rst), 
      .din_rdy(dy_rsc_rdy_n_VerDer_inst), .din_vld(dy_rsc_vld_n_VerDer_inst_bud), 
      .din(dy_rsc_dat_n_VerDer_inst), .dout_rdy(dy_in_rsc_rdy_n_MagAng_inst_bud), 
      .dout_vld(dy_in_rsc_vld_n_MagAng_inst), .dout(dy_in_rsc_dat_n_MagAng_inst), 
      .sz(), .sz_req(1'b0), .is_idle());
   EdgeDetect_IP_Kmean Kmean_inst (.clk(clk), .rst(rst), .arst_n(arst_n), 
      .kmean_in_rsc_dat({uc_0, uc_1, uc_2, uc_3, uc_4, uc_5, uc_6, uc_7, uc_8, 
      uc_9, dat_rgb_rsc_dat_n_VerDer_inst[23], dat_rgb_rsc_dat_n_VerDer_inst[22], 
      dat_rgb_rsc_dat_n_VerDer_inst[21], dat_rgb_rsc_dat_n_VerDer_inst[20], 
      dat_rgb_rsc_dat_n_VerDer_inst[19], dat_rgb_rsc_dat_n_VerDer_inst[18], 
      dat_rgb_rsc_dat_n_VerDer_inst[17], dat_rgb_rsc_dat_n_VerDer_inst[16], 
      dat_rgb_rsc_dat_n_VerDer_inst[15], dat_rgb_rsc_dat_n_VerDer_inst[14], 
      dat_rgb_rsc_dat_n_VerDer_inst[13], dat_rgb_rsc_dat_n_VerDer_inst[12], 
      dat_rgb_rsc_dat_n_VerDer_inst[11], dat_rgb_rsc_dat_n_VerDer_inst[10], 
      dat_rgb_rsc_dat_n_VerDer_inst[9], dat_rgb_rsc_dat_n_VerDer_inst[8], 
      dat_rgb_rsc_dat_n_VerDer_inst[7], dat_rgb_rsc_dat_n_VerDer_inst[6], 
      dat_rgb_rsc_dat_n_VerDer_inst[5], dat_rgb_rsc_dat_n_VerDer_inst[4], 
      dat_rgb_rsc_dat_n_VerDer_inst[3], dat_rgb_rsc_dat_n_VerDer_inst[2], 
      dat_rgb_rsc_dat_n_VerDer_inst[1], dat_rgb_rsc_dat_n_VerDer_inst[0]}), 
      .kmean_in_rsc_vld(dat_rgb_rsc_vld_n_VerDer_inst_bud), .kmean_in_rsc_rdy(
      kmean_in_rsc_rdy_n_Kmean_inst_bud), .widthIn(widthIn), .heightIn(heightIn), 
      .kmean_out_rsc_dat({kmean_out_rsc_dat_n_Kmean_inst[23], 
      kmean_out_rsc_dat_n_Kmean_inst[22], kmean_out_rsc_dat_n_Kmean_inst[21], 
      kmean_out_rsc_dat_n_Kmean_inst[20], kmean_out_rsc_dat_n_Kmean_inst[19], 
      kmean_out_rsc_dat_n_Kmean_inst[18], kmean_out_rsc_dat_n_Kmean_inst[17], 
      uc_10, kmean_out_rsc_dat_n_Kmean_inst[15], 
      kmean_out_rsc_dat_n_Kmean_inst[14], kmean_out_rsc_dat_n_Kmean_inst[13], 
      kmean_out_rsc_dat_n_Kmean_inst[12], uc_11, 
      kmean_out_rsc_dat_n_Kmean_inst[10], kmean_out_rsc_dat_n_Kmean_inst[9], 
      uc_12, kmean_out_rsc_dat_n_Kmean_inst[7], 
      kmean_out_rsc_dat_n_Kmean_inst[6], kmean_out_rsc_dat_n_Kmean_inst[5], 
      kmean_out_rsc_dat_n_Kmean_inst[4], uc_13, 
      kmean_out_rsc_dat_n_Kmean_inst[2], kmean_out_rsc_dat_n_Kmean_inst[1], 
      uc_14}), .kmean_out_rsc_vld(kmean_out_rsc_vld_n_Kmean_inst_bud), 
      .kmean_out_rsc_rdy(grb_in_rsc_rdy_n_Mix_inst_bud));
   EdgeDetect_IP_Mix Mix_inst (.clk(clk), .rst(rst), .arst_n(arst_n), 
      .grb_in_rsc_dat({kmean_out_rsc_dat_n_Kmean_inst[23], 
      kmean_out_rsc_dat_n_Kmean_inst[22], kmean_out_rsc_dat_n_Kmean_inst[21], 
      kmean_out_rsc_dat_n_Kmean_inst[20], kmean_out_rsc_dat_n_Kmean_inst[19], 
      kmean_out_rsc_dat_n_Kmean_inst[18], kmean_out_rsc_dat_n_Kmean_inst[17], 
      uc_15, kmean_out_rsc_dat_n_Kmean_inst[15], 
      kmean_out_rsc_dat_n_Kmean_inst[14], kmean_out_rsc_dat_n_Kmean_inst[13], 
      kmean_out_rsc_dat_n_Kmean_inst[12], uc_16, 
      kmean_out_rsc_dat_n_Kmean_inst[10], kmean_out_rsc_dat_n_Kmean_inst[9], 
      uc_17, kmean_out_rsc_dat_n_Kmean_inst[7], 
      kmean_out_rsc_dat_n_Kmean_inst[6], kmean_out_rsc_dat_n_Kmean_inst[5], 
      kmean_out_rsc_dat_n_Kmean_inst[4], uc_18, 
      kmean_out_rsc_dat_n_Kmean_inst[2], kmean_out_rsc_dat_n_Kmean_inst[1], 
      uc_19}), .grb_in_rsc_vld(kmean_out_rsc_vld_n_Kmean_inst_bud), 
      .grb_in_rsc_rdy(grb_in_rsc_rdy_n_Mix_inst_bud), .widthIn(widthIn), 
      .heightIn(heightIn), .magn_rsc_dat({magn_rsc_dat_n_Mix_inst[7], uc_20, 
      uc_21, uc_22, uc_23, uc_24, uc_25, uc_26}), .magn_rsc_vld(
      magn_rsc_vld_n_Mix_inst), .magn_rsc_rdy(magn_rsc_rdy_n_Mix_inst_bud), 
      .rgb_out_rsc_dat({dat_out_rsc_dat[33], dat_out_rsc_dat[32], uc_27, uc_28, 
      uc_29, uc_30, uc_31, uc_32, uc_33, dat_out_rsc_dat[24], 
      dat_out_rsc_dat[23], dat_out_rsc_dat[16], dat_out_rsc_dat[21], 
      dat_out_rsc_dat[20], dat_out_rsc_dat[19], dat_out_rsc_dat[18], 
      dat_out_rsc_dat[17], uc_34, dat_out_rsc_dat[11], dat_out_rsc_dat[8], 
      dat_out_rsc_dat[13], dat_out_rsc_dat[12], uc_35, dat_out_rsc_dat[10], 
      dat_out_rsc_dat[9], uc_36, dat_out_rsc_dat[3], dat_out_rsc_dat[0], 
      dat_out_rsc_dat[5], dat_out_rsc_dat[4], uc_37, dat_out_rsc_dat[2], 
      dat_out_rsc_dat[1], uc_38}), .rgb_out_rsc_vld(dat_out_rsc_vld), 
      .rgb_out_rsc_rdy(dat_out_rsc_rdy));
   ccs_pipe_v6__parameterized0 magn_cns_pipe (.clk(clk), .en(), .arst(arst_n), 
      .srst(rst), .din_rdy(magn_rsc_rdy_n_MagAng_inst), .din_vld(
      magn_rsc_vld_n_MagAng_inst_bud), .din({magn_rsc_dat_n_MagAng_inst[0], 
      uc_39, uc_40, uc_41, uc_42, uc_43, uc_44, uc_45}), .dout_rdy(
      magn_rsc_rdy_n_Mix_inst_bud), .dout_vld(magn_rsc_vld_n_Mix_inst), .dout({
      magn_rsc_dat_n_Mix_inst[7], uc_46, uc_47, uc_48, uc_49, uc_50, uc_51, 
      uc_52}), .sz(), .sz_req(1'b0), .is_idle());
   EdgeDetect_IP_EdgeDetect_MagAng MagAng_inst (.clk(clk), .rst(rst), .arst_n(
      arst_n), .dx_in_rsc_dat(dx_rsc_dat_n_HorDer_inst), .dx_in_rsc_vld(
      dx_rsc_vld_n_HorDer_inst_bud), .dx_in_rsc_rdy(
      dx_in_rsc_rdy_n_MagAng_inst_bud), .dy_in_rsc_dat(
      dy_in_rsc_dat_n_MagAng_inst), .dy_in_rsc_vld(dy_in_rsc_vld_n_MagAng_inst), 
      .dy_in_rsc_rdy(dy_in_rsc_rdy_n_MagAng_inst_bud), .widthIn_rsc_dat(), 
      .widthIn_triosy_lz(), .heightIn_rsc_dat(), .heightIn_triosy_lz(), 
      .magn_rsc_dat({magn_rsc_dat_n_MagAng_inst[0], uc_53, uc_54, uc_55, uc_56, 
      uc_57, uc_58, uc_59}), .magn_rsc_vld(magn_rsc_vld_n_MagAng_inst_bud), 
      .magn_rsc_rdy(magn_rsc_rdy_n_MagAng_inst));
   EdgeDetect_IP_EdgeDetect_HorDer HorDer_inst (.clk(clk), .rst(rst), .arst_n(
      arst_n), .dat_in_rsc_dat(dat_out_rsc_dat_n_VerDer_inst), .dat_in_rsc_vld(
      dat_out_rsc_vld_n_VerDer_inst_bud), .dat_in_rsc_rdy(
      dat_in_rsc_rdy_n_HorDer_inst_bud), .widthIn(widthIn), .heightIn(heightIn), 
      .dx_rsc_dat(dx_rsc_dat_n_HorDer_inst), .dx_rsc_vld(
      dx_rsc_vld_n_HorDer_inst_bud), .dx_rsc_rdy(dx_in_rsc_rdy_n_MagAng_inst_bud));
   EdgeDetect_IP_EdgeDetect_VerDer VerDer_inst (.clk(clk), .rst(rst), .arst_n(
      arst_n), .dat_in_rsc_dat({uc_60, uc_61, uc_62, uc_63, uc_64, uc_65, uc_66, 
      uc_67, uc_68, uc_69, dat_in_rsc_dat[23], dat_in_rsc_dat[22], 
      dat_in_rsc_dat[21], dat_in_rsc_dat[20], dat_in_rsc_dat[19], 
      dat_in_rsc_dat[18], dat_in_rsc_dat[17], dat_in_rsc_dat[16], 
      dat_in_rsc_dat[15], dat_in_rsc_dat[14], dat_in_rsc_dat[13], 
      dat_in_rsc_dat[12], dat_in_rsc_dat[11], dat_in_rsc_dat[10], 
      dat_in_rsc_dat[9], dat_in_rsc_dat[8], dat_in_rsc_dat[7], dat_in_rsc_dat[6], 
      dat_in_rsc_dat[5], dat_in_rsc_dat[4], dat_in_rsc_dat[3], dat_in_rsc_dat[2], 
      dat_in_rsc_dat[1], dat_in_rsc_dat[0]}), .dat_in_rsc_vld(dat_in_rsc_vld), 
      .dat_in_rsc_rdy(dat_in_rsc_rdy), .widthIn(widthIn), .heightIn(heightIn), 
      .dat_out_rsc_dat(dat_out_rsc_dat_n_VerDer_inst), .dat_out_rsc_vld(
      dat_out_rsc_vld_n_VerDer_inst_bud), .dat_out_rsc_rdy(
      dat_in_rsc_rdy_n_HorDer_inst_bud), .dat_rgb_rsc_dat({uc_70, uc_71, uc_72, 
      uc_73, uc_74, uc_75, uc_76, uc_77, uc_78, uc_79, 
      dat_rgb_rsc_dat_n_VerDer_inst[23], dat_rgb_rsc_dat_n_VerDer_inst[22], 
      dat_rgb_rsc_dat_n_VerDer_inst[21], dat_rgb_rsc_dat_n_VerDer_inst[20], 
      dat_rgb_rsc_dat_n_VerDer_inst[19], dat_rgb_rsc_dat_n_VerDer_inst[18], 
      dat_rgb_rsc_dat_n_VerDer_inst[17], dat_rgb_rsc_dat_n_VerDer_inst[16], 
      dat_rgb_rsc_dat_n_VerDer_inst[15], dat_rgb_rsc_dat_n_VerDer_inst[14], 
      dat_rgb_rsc_dat_n_VerDer_inst[13], dat_rgb_rsc_dat_n_VerDer_inst[12], 
      dat_rgb_rsc_dat_n_VerDer_inst[11], dat_rgb_rsc_dat_n_VerDer_inst[10], 
      dat_rgb_rsc_dat_n_VerDer_inst[9], dat_rgb_rsc_dat_n_VerDer_inst[8], 
      dat_rgb_rsc_dat_n_VerDer_inst[7], dat_rgb_rsc_dat_n_VerDer_inst[6], 
      dat_rgb_rsc_dat_n_VerDer_inst[5], dat_rgb_rsc_dat_n_VerDer_inst[4], 
      dat_rgb_rsc_dat_n_VerDer_inst[3], dat_rgb_rsc_dat_n_VerDer_inst[2], 
      dat_rgb_rsc_dat_n_VerDer_inst[1], dat_rgb_rsc_dat_n_VerDer_inst[0]}), 
      .dat_rgb_rsc_vld(dat_rgb_rsc_vld_n_VerDer_inst_bud), .dat_rgb_rsc_rdy(
      kmean_in_rsc_rdy_n_Kmean_inst_bud), .dy_rsc_dat(dy_rsc_dat_n_VerDer_inst), 
      .dy_rsc_vld(dy_rsc_vld_n_VerDer_inst_bud), .dy_rsc_rdy(
      dy_rsc_rdy_n_VerDer_inst), .line_buf0_r_pixelType_rsc_en(
      line_buf1_b_pixelType_rsc_en), .line_buf0_r_pixelType_rsc_q(
      line_buf0_r_pixelType_rsc_q), .line_buf0_r_pixelType_rsc_we(
      line_buf1_b_pixelType_rsc_we), .line_buf0_r_pixelType_rsc_d(
      line_buf0_r_pixelType_rsc_d), .line_buf0_r_pixelType_rsc_adr(
      line_buf1_b_pixelType_rsc_adr), .line_buf0_g_pixelType_rsc_en(), 
      .line_buf0_g_pixelType_rsc_q(line_buf0_g_pixelType_rsc_q), 
      .line_buf0_g_pixelType_rsc_we(), .line_buf0_g_pixelType_rsc_d(
      line_buf0_g_pixelType_rsc_d), .line_buf0_g_pixelType_rsc_adr(), 
      .line_buf0_b_pixelType_rsc_en(), .line_buf0_b_pixelType_rsc_q(
      line_buf0_b_pixelType_rsc_q), .line_buf0_b_pixelType_rsc_we(), 
      .line_buf0_b_pixelType_rsc_d(line_buf0_b_pixelType_rsc_d), 
      .line_buf0_b_pixelType_rsc_adr(), .line_buf1_r_pixelType_rsc_en(), 
      .line_buf1_r_pixelType_rsc_q(line_buf1_r_pixelType_rsc_q), 
      .line_buf1_r_pixelType_rsc_we(), .line_buf1_r_pixelType_rsc_d(
      line_buf1_r_pixelType_rsc_d), .line_buf1_r_pixelType_rsc_adr(), 
      .line_buf1_g_pixelType_rsc_en(), .line_buf1_g_pixelType_rsc_q(
      line_buf1_g_pixelType_rsc_q), .line_buf1_g_pixelType_rsc_we(), 
      .line_buf1_g_pixelType_rsc_d(line_buf1_g_pixelType_rsc_d), 
      .line_buf1_g_pixelType_rsc_adr(), .line_buf1_b_pixelType_rsc_en(), 
      .line_buf1_b_pixelType_rsc_q(line_buf1_b_pixelType_rsc_q), 
      .line_buf1_b_pixelType_rsc_we(), .line_buf1_b_pixelType_rsc_d(
      line_buf1_b_pixelType_rsc_d), .line_buf1_b_pixelType_rsc_adr());
endmodule
