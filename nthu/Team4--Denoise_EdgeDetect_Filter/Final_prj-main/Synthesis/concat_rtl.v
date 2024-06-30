
//------> /usr/cadtool/mentor/Catapult/2024.1/Mgc_home/pkgs/siflibs/ccs_in_wait_coupled_v1.v 
//------------------------------------------------------------------------------
// Catapult Synthesis - Sample I/O Port Library
//
// Copyright (c) 2003-2017 Mentor Graphics Corp.
//       All Rights Reserved
//
// This document may be used and distributed without restriction provided that
// this copyright statement is not removed from the file and that any derivative
// work contains this copyright notice.
//
// The design information contained in this file is intended to be an example
// of the functionality which the end user may study in preparation for creating
// their own custom interfaces. This design does not necessarily present a 
// complete implementation of the named protocol or standard.
//
//------------------------------------------------------------------------------


module ccs_in_wait_coupled_v1 (idat, rdy, ivld, dat, irdy, vld);

  parameter integer rscid = 1;
  parameter integer width = 8;

  output [width-1:0] idat;
  output             rdy;
  output             ivld;
  input  [width-1:0] dat;
  input              irdy;
  input              vld;

  wire   [width-1:0] idat;
  wire               rdy;
  wire               ivld;

  assign idat = dat;
  assign rdy = irdy;
  assign ivld = vld;

endmodule


//------> /usr/cadtool/mentor/Catapult/2024.1/Mgc_home/pkgs/siflibs/ccs_out_wait_v1.v 
//------------------------------------------------------------------------------
// Catapult Synthesis - Sample I/O Port Library
//
// Copyright (c) 2003-2017 Mentor Graphics Corp.
//       All Rights Reserved
//
// This document may be used and distributed without restriction provided that
// this copyright statement is not removed from the file and that any derivative
// work contains this copyright notice.
//
// The design information contained in this file is intended to be an example
// of the functionality which the end user may study in preparation for creating
// their own custom interfaces. This design does not necessarily present a 
// complete implementation of the named protocol or standard.
//
//------------------------------------------------------------------------------


module ccs_out_wait_v1 (dat, irdy, vld, idat, rdy, ivld);

  parameter integer rscid = 1;
  parameter integer width = 8;

  output [width-1:0] dat;
  output             irdy;
  output             vld;
  input  [width-1:0] idat;
  input              rdy;
  input              ivld;

  wire   [width-1:0] dat;
  wire               irdy;
  wire               vld;

  localparam stallOff = 0; 
  wire stall_ctrl;
  assign stall_ctrl = stallOff;

  assign dat = idat;
  assign irdy = rdy && !stall_ctrl;
  assign vld = ivld && !stall_ctrl;

endmodule



//------> /usr/cadtool/mentor/Catapult/2024.1/Mgc_home/pkgs/siflibs/mgc_io_sync_v2.v 
//------------------------------------------------------------------------------
// Catapult Synthesis - Sample I/O Port Library
//
// Copyright (c) 2003-2017 Mentor Graphics Corp.
//       All Rights Reserved
//
// This document may be used and distributed without restriction provided that
// this copyright statement is not removed from the file and that any derivative
// work contains this copyright notice.
//
// The design information contained in this file is intended to be an example
// of the functionality which the end user may study in preparation for creating
// their own custom interfaces. This design does not necessarily present a 
// complete implementation of the named protocol or standard.
//
//------------------------------------------------------------------------------


module mgc_io_sync_v2 (ld, lz);
    parameter valid = 0;

    input  ld;
    output lz;

    wire   lz;

    assign lz = ld;

endmodule


//------> /usr/cadtool/mentor/Catapult/2024.1/Mgc_home/pkgs/siflibs/ccs_in_v1.v 
//------------------------------------------------------------------------------
// Catapult Synthesis - Sample I/O Port Library
//
// Copyright (c) 2003-2017 Mentor Graphics Corp.
//       All Rights Reserved
//
// This document may be used and distributed without restriction provided that
// this copyright statement is not removed from the file and that any derivative
// work contains this copyright notice.
//
// The design information contained in this file is intended to be an example
// of the functionality which the end user may study in preparation for creating
// their own custom interfaces. This design does not necessarily present a 
// complete implementation of the named protocol or standard.
//
//------------------------------------------------------------------------------


module ccs_in_v1 (idat, dat);

  parameter integer rscid = 1;
  parameter integer width = 8;

  output [width-1:0] idat;
  input  [width-1:0] dat;

  wire   [width-1:0] idat;

  assign idat = dat;

endmodule


//------> ../EdgeDetect_IP_EdgeDetect_Filter.v1/rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    2024.1/1091966 Production Release
//  HLS Date:       Wed Feb 14 09:07:18 PST 2024
// 
//  Generated by:   m111061631@ws41
//  Generated date: Fri Jun  7 09:29:11 2024
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_Filter_ccs_sample_mem_ccs_ram_sync_singleport_rwport_en_7_16_10_963_963_16_5_gen
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_Filter_ccs_sample_mem_ccs_ram_sync_singleport_rwport_en_7_16_10_963_963_16_5_gen
    (
  en, q, we, d, adr, adr_d, d_d, en_d, we_d, q_d, port_0_rw_ram_ir_internal_RMASK_B_d,
      port_0_rw_ram_ir_internal_WMASK_B_d
);
  output en;
  input [15:0] q;
  output we;
  output [15:0] d;
  output [9:0] adr;
  input [9:0] adr_d;
  input [15:0] d_d;
  input en_d;
  input we_d;
  output [15:0] q_d;
  input port_0_rw_ram_ir_internal_RMASK_B_d;
  input port_0_rw_ram_ir_internal_WMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign en = (en_d);
  assign q_d = q;
  assign we = (port_0_rw_ram_ir_internal_WMASK_B_d);
  assign d = (d_d);
  assign adr = (adr_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_Filter_ccs_sample_mem_ccs_ram_sync_singleport_rwport_en_6_16_10_963_963_16_5_gen
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_Filter_ccs_sample_mem_ccs_ram_sync_singleport_rwport_en_6_16_10_963_963_16_5_gen
    (
  en, q, we, d, adr, adr_d, d_d, en_d, we_d, q_d, port_0_rw_ram_ir_internal_RMASK_B_d,
      port_0_rw_ram_ir_internal_WMASK_B_d
);
  output en;
  input [15:0] q;
  output we;
  output [15:0] d;
  output [9:0] adr;
  input [9:0] adr_d;
  input [15:0] d_d;
  input en_d;
  input we_d;
  output [15:0] q_d;
  input port_0_rw_ram_ir_internal_RMASK_B_d;
  input port_0_rw_ram_ir_internal_WMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign en = (en_d);
  assign q_d = q;
  assign we = (port_0_rw_ram_ir_internal_WMASK_B_d);
  assign d = (d_d);
  assign adr = (adr_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_Filter_run_run_fsm
//  FSM Module
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_Filter_run_run_fsm (
  clk, rst, arst_n, run_wen, fsm_output, VCOL_C_0_tr0, VROW_C_0_tr0
);
  input clk;
  input rst;
  input arst_n;
  input run_wen;
  output [3:0] fsm_output;
  reg [3:0] fsm_output;
  input VCOL_C_0_tr0;
  input VROW_C_0_tr0;


  // FSM State Type Declaration for EdgeDetect_IP_EdgeDetect_Filter_run_run_fsm_1
  parameter
    main_C_0 = 2'd0,
    VCOL_C_0 = 2'd1,
    VROW_C_0 = 2'd2,
    main_C_1 = 2'd3;

  reg [1:0] state_var;
  reg [1:0] state_var_NS;


  // Interconnect Declarations for Component Instantiations 
  always @(*)
  begin : EdgeDetect_IP_EdgeDetect_Filter_run_run_fsm_1
    case (state_var)
      VCOL_C_0 : begin
        fsm_output = 4'b0010;
        if ( VCOL_C_0_tr0 ) begin
          state_var_NS = VROW_C_0;
        end
        else begin
          state_var_NS = VCOL_C_0;
        end
      end
      VROW_C_0 : begin
        fsm_output = 4'b0100;
        if ( VROW_C_0_tr0 ) begin
          state_var_NS = main_C_1;
        end
        else begin
          state_var_NS = VCOL_C_0;
        end
      end
      main_C_1 : begin
        fsm_output = 4'b1000;
        state_var_NS = main_C_0;
      end
      // main_C_0
      default : begin
        fsm_output = 4'b0001;
        state_var_NS = VCOL_C_0;
      end
    endcase
  end

  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      state_var <= main_C_0;
    end
    else if ( rst ) begin
      state_var <= main_C_0;
    end
    else if ( run_wen ) begin
      state_var <= state_var_NS;
    end
  end

endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_Filter_run_staller
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_Filter_run_staller (
  clk, rst, arst_n, run_wen, run_wten, dat_in_rsci_wen_comp, dat_out_rsci_wen_comp
);
  input clk;
  input rst;
  input arst_n;
  output run_wen;
  output run_wten;
  reg run_wten;
  input dat_in_rsci_wen_comp;
  input dat_out_rsci_wen_comp;



  // Interconnect Declarations for Component Instantiations 
  assign run_wen = dat_in_rsci_wen_comp & dat_out_rsci_wen_comp;
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      run_wten <= 1'b0;
    end
    else if ( rst ) begin
      run_wten <= 1'b0;
    end
    else begin
      run_wten <= ~ run_wen;
    end
  end
endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_Filter_run_ctrl_signal_triosy_obj_ctrl_signal_triosy_wait_ctrl
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_Filter_run_ctrl_signal_triosy_obj_ctrl_signal_triosy_wait_ctrl
    (
  run_wten, ctrl_signal_triosy_obj_iswt0, ctrl_signal_triosy_obj_biwt
);
  input run_wten;
  input ctrl_signal_triosy_obj_iswt0;
  output ctrl_signal_triosy_obj_biwt;



  // Interconnect Declarations for Component Instantiations 
  assign ctrl_signal_triosy_obj_biwt = (~ run_wten) & ctrl_signal_triosy_obj_iswt0;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_Filter_run_wait_dp
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_Filter_run_wait_dp (
  line_buf0_rsci_en_d, line_buf1_rsci_en_d, run_wen, line_buf0_rsci_cgo, line_buf0_rsci_cgo_ir_unreg,
      line_buf1_rsci_cgo, line_buf1_rsci_cgo_ir_unreg
);
  output line_buf0_rsci_en_d;
  output line_buf1_rsci_en_d;
  input run_wen;
  input line_buf0_rsci_cgo;
  input line_buf0_rsci_cgo_ir_unreg;
  input line_buf1_rsci_cgo;
  input line_buf1_rsci_cgo_ir_unreg;



  // Interconnect Declarations for Component Instantiations 
  assign line_buf0_rsci_en_d = run_wen & (line_buf0_rsci_cgo | line_buf0_rsci_cgo_ir_unreg);
  assign line_buf1_rsci_en_d = run_wen & (line_buf1_rsci_cgo | line_buf1_rsci_cgo_ir_unreg);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_Filter_run_dat_out_rsci_dat_out_wait_dp
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_Filter_run_dat_out_rsci_dat_out_wait_dp (
  clk, rst, arst_n, dat_out_rsci_oswt, dat_out_rsci_wen_comp, dat_out_rsci_biwt,
      dat_out_rsci_bdwt, dat_out_rsci_bcwt
);
  input clk;
  input rst;
  input arst_n;
  input dat_out_rsci_oswt;
  output dat_out_rsci_wen_comp;
  input dat_out_rsci_biwt;
  input dat_out_rsci_bdwt;
  output dat_out_rsci_bcwt;
  reg dat_out_rsci_bcwt;



  // Interconnect Declarations for Component Instantiations 
  assign dat_out_rsci_wen_comp = (~ dat_out_rsci_oswt) | dat_out_rsci_biwt | dat_out_rsci_bcwt;
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      dat_out_rsci_bcwt <= 1'b0;
    end
    else if ( rst ) begin
      dat_out_rsci_bcwt <= 1'b0;
    end
    else begin
      dat_out_rsci_bcwt <= ~((~(dat_out_rsci_bcwt | dat_out_rsci_biwt)) | dat_out_rsci_bdwt);
    end
  end
endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_Filter_run_dat_out_rsci_dat_out_wait_ctrl
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_Filter_run_dat_out_rsci_dat_out_wait_ctrl (
  run_wen, dat_out_rsci_oswt, dat_out_rsci_biwt, dat_out_rsci_bdwt, dat_out_rsci_bcwt,
      dat_out_rsci_irdy, dat_out_rsci_ivld_run_sct
);
  input run_wen;
  input dat_out_rsci_oswt;
  output dat_out_rsci_biwt;
  output dat_out_rsci_bdwt;
  input dat_out_rsci_bcwt;
  input dat_out_rsci_irdy;
  output dat_out_rsci_ivld_run_sct;


  // Interconnect Declarations
  wire dat_out_rsci_ogwt;


  // Interconnect Declarations for Component Instantiations 
  assign dat_out_rsci_bdwt = dat_out_rsci_oswt & run_wen;
  assign dat_out_rsci_biwt = dat_out_rsci_ogwt & dat_out_rsci_irdy;
  assign dat_out_rsci_ogwt = dat_out_rsci_oswt & (~ dat_out_rsci_bcwt);
  assign dat_out_rsci_ivld_run_sct = dat_out_rsci_ogwt;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_Filter_run_dat_in_rsci_dat_in_wait_ctrl
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_Filter_run_dat_in_rsci_dat_in_wait_ctrl (
  run_wen, dat_in_rsci_iswt0, dat_in_rsci_irdy_run_sct
);
  input run_wen;
  input dat_in_rsci_iswt0;
  output dat_in_rsci_irdy_run_sct;



  // Interconnect Declarations for Component Instantiations 
  assign dat_in_rsci_irdy_run_sct = dat_in_rsci_iswt0 & run_wen;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_Filter_run_ctrl_signal_triosy_obj
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_Filter_run_ctrl_signal_triosy_obj (
  ctrl_signal_triosy_lz, run_wten, ctrl_signal_triosy_obj_iswt0
);
  output ctrl_signal_triosy_lz;
  input run_wten;
  input ctrl_signal_triosy_obj_iswt0;


  // Interconnect Declarations
  wire ctrl_signal_triosy_obj_biwt;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) ctrl_signal_triosy_obj (
      .ld(ctrl_signal_triosy_obj_biwt),
      .lz(ctrl_signal_triosy_lz)
    );
  EdgeDetect_IP_EdgeDetect_Filter_run_ctrl_signal_triosy_obj_ctrl_signal_triosy_wait_ctrl
      EdgeDetect_IP_EdgeDetect_Filter_run_ctrl_signal_triosy_obj_ctrl_signal_triosy_wait_ctrl_inst
      (
      .run_wten(run_wten),
      .ctrl_signal_triosy_obj_iswt0(ctrl_signal_triosy_obj_iswt0),
      .ctrl_signal_triosy_obj_biwt(ctrl_signal_triosy_obj_biwt)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_Filter_run_dat_out_rsci
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_Filter_run_dat_out_rsci (
  clk, rst, arst_n, dat_out_rsc_dat, dat_out_rsc_vld, dat_out_rsc_rdy, run_wen, dat_out_rsci_oswt,
      dat_out_rsci_wen_comp, dat_out_rsci_idat
);
  input clk;
  input rst;
  input arst_n;
  output [7:0] dat_out_rsc_dat;
  output dat_out_rsc_vld;
  input dat_out_rsc_rdy;
  input run_wen;
  input dat_out_rsci_oswt;
  output dat_out_rsci_wen_comp;
  input [7:0] dat_out_rsci_idat;


  // Interconnect Declarations
  wire dat_out_rsci_biwt;
  wire dat_out_rsci_bdwt;
  wire dat_out_rsci_bcwt;
  wire dat_out_rsci_irdy;
  wire dat_out_rsci_ivld_run_sct;


  // Interconnect Declarations for Component Instantiations 
  ccs_out_wait_v1 #(.rscid(32'sd4),
  .width(32'sd8)) dat_out_rsci (
      .irdy(dat_out_rsci_irdy),
      .ivld(dat_out_rsci_ivld_run_sct),
      .idat(dat_out_rsci_idat),
      .rdy(dat_out_rsc_rdy),
      .vld(dat_out_rsc_vld),
      .dat(dat_out_rsc_dat)
    );
  EdgeDetect_IP_EdgeDetect_Filter_run_dat_out_rsci_dat_out_wait_ctrl EdgeDetect_IP_EdgeDetect_Filter_run_dat_out_rsci_dat_out_wait_ctrl_inst
      (
      .run_wen(run_wen),
      .dat_out_rsci_oswt(dat_out_rsci_oswt),
      .dat_out_rsci_biwt(dat_out_rsci_biwt),
      .dat_out_rsci_bdwt(dat_out_rsci_bdwt),
      .dat_out_rsci_bcwt(dat_out_rsci_bcwt),
      .dat_out_rsci_irdy(dat_out_rsci_irdy),
      .dat_out_rsci_ivld_run_sct(dat_out_rsci_ivld_run_sct)
    );
  EdgeDetect_IP_EdgeDetect_Filter_run_dat_out_rsci_dat_out_wait_dp EdgeDetect_IP_EdgeDetect_Filter_run_dat_out_rsci_dat_out_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .arst_n(arst_n),
      .dat_out_rsci_oswt(dat_out_rsci_oswt),
      .dat_out_rsci_wen_comp(dat_out_rsci_wen_comp),
      .dat_out_rsci_biwt(dat_out_rsci_biwt),
      .dat_out_rsci_bdwt(dat_out_rsci_bdwt),
      .dat_out_rsci_bcwt(dat_out_rsci_bcwt)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_Filter_run_dat_in_rsci
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_Filter_run_dat_in_rsci (
  dat_in_rsc_dat, dat_in_rsc_vld, dat_in_rsc_rdy, run_wen, dat_in_rsci_oswt, dat_in_rsci_wen_comp,
      dat_in_rsci_idat_mxwt
);
  input [7:0] dat_in_rsc_dat;
  input dat_in_rsc_vld;
  output dat_in_rsc_rdy;
  input run_wen;
  input dat_in_rsci_oswt;
  output dat_in_rsci_wen_comp;
  output [7:0] dat_in_rsci_idat_mxwt;


  // Interconnect Declarations
  wire dat_in_rsci_irdy_run_sct;
  wire dat_in_rsci_ivld;
  wire [7:0] dat_in_rsci_idat;


  // Interconnect Declarations for Component Instantiations 
  ccs_in_wait_coupled_v1 #(.rscid(32'sd1),
  .width(32'sd8)) dat_in_rsci (
      .rdy(dat_in_rsc_rdy),
      .vld(dat_in_rsc_vld),
      .dat(dat_in_rsc_dat),
      .irdy(dat_in_rsci_irdy_run_sct),
      .ivld(dat_in_rsci_ivld),
      .idat(dat_in_rsci_idat)
    );
  EdgeDetect_IP_EdgeDetect_Filter_run_dat_in_rsci_dat_in_wait_ctrl EdgeDetect_IP_EdgeDetect_Filter_run_dat_in_rsci_dat_in_wait_ctrl_inst
      (
      .run_wen(run_wen),
      .dat_in_rsci_iswt0(dat_in_rsci_oswt),
      .dat_in_rsci_irdy_run_sct(dat_in_rsci_irdy_run_sct)
    );
  assign dat_in_rsci_idat_mxwt = dat_in_rsci_idat;
  assign dat_in_rsci_wen_comp = (~ dat_in_rsci_oswt) | dat_in_rsci_ivld;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_Filter_run
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_Filter_run (
  clk, rst, arst_n, dat_in_rsc_dat, dat_in_rsc_vld, dat_in_rsc_rdy, widthIn, heightIn,
      dat_out_rsc_dat, dat_out_rsc_vld, dat_out_rsc_rdy, ctrl_signal_rsc_dat, ctrl_signal_triosy_lz,
      line_buf0_rsci_d_d, line_buf0_rsci_en_d, line_buf0_rsci_q_d, line_buf1_rsci_d_d,
      line_buf1_rsci_en_d, line_buf1_rsci_q_d, line_buf0_rsci_adr_d_pff, line_buf0_rsci_we_d_pff,
      line_buf0_rsci_port_0_rw_ram_ir_internal_RMASK_B_d_pff, line_buf1_rsci_we_d_pff
);
  input clk;
  input rst;
  input arst_n;
  input [7:0] dat_in_rsc_dat;
  input dat_in_rsc_vld;
  output dat_in_rsc_rdy;
  input [10:0] widthIn;
  input [9:0] heightIn;
  output [7:0] dat_out_rsc_dat;
  output dat_out_rsc_vld;
  input dat_out_rsc_rdy;
  input [1:0] ctrl_signal_rsc_dat;
  output ctrl_signal_triosy_lz;
  output [15:0] line_buf0_rsci_d_d;
  output line_buf0_rsci_en_d;
  input [15:0] line_buf0_rsci_q_d;
  output [15:0] line_buf1_rsci_d_d;
  output line_buf1_rsci_en_d;
  input [15:0] line_buf1_rsci_q_d;
  output [9:0] line_buf0_rsci_adr_d_pff;
  output line_buf0_rsci_we_d_pff;
  output line_buf0_rsci_port_0_rw_ram_ir_internal_RMASK_B_d_pff;
  output line_buf1_rsci_we_d_pff;


  // Interconnect Declarations
  wire run_wen;
  wire run_wten;
  wire dat_in_rsci_wen_comp;
  wire [7:0] dat_in_rsci_idat_mxwt;
  wire dat_out_rsci_wen_comp;
  wire [1:0] ctrl_signal_rsci_idat;
  reg ctrl_signal_triosy_obj_iswt0;
  reg [6:0] dat_out_rsci_idat_7_1;
  reg dat_out_rsci_idat_0;
  wire [3:0] fsm_output;
  wire VROW_equal_tmp;
  wire operator_10_false_1_nor_tmp;
  wire operator_11_false_4_operator_11_false_4_nor_tmp;
  wire operator_11_false_1_nor_tmp;
  wire VCOL_else_2_else_else_else_nor_1_tmp;
  wire VCOL_else_2_else_else_aif_equal_tmp;
  wire VCOL_VCOL_oelse_operator_11_false_or_tmp;
  wire or_dcpl_6;
  wire and_dcpl_4;
  wire or_tmp_14;
  wire or_tmp_17;
  wire mux_tmp_14;
  wire not_tmp_22;
  wire or_dcpl_31;
  wire and_dcpl_19;
  wire or_tmp_30;
  wire nor_tmp_14;
  wire mux_tmp_22;
  wire or_dcpl_34;
  wire and_dcpl_30;
  wire or_dcpl_42;
  wire and_tmp_1;
  wire mux_tmp_34;
  wire or_dcpl_60;
  wire or_dcpl_61;
  wire [10:0] VCOL_x_sva_2;
  wire [11:0] nl_VCOL_x_sva_2;
  wire [10:0] pix_result_sva_4;
  wire [11:0] nl_pix_result_sva_4;
  wire VCOL_VCOL_nor_ssc_1;
  wire VCOL_VCOL_and_ssc_1;
  wire VCOL_VCOL_and_1_ssc_1;
  wire VCOL_VCOL_and_2_ssc_1;
  wire [9:0] VCOL_else_3_else_if_ac_int_cctor_1_sva_1;
  wire [10:0] nl_VCOL_else_3_else_if_ac_int_cctor_1_sva_1;
  wire VCOL_else_2_else_else_else_unequal_tmp_1;
  wire VCOL_else_2_land_lpi_3_dfm_1;
  wire VCOL_else_2_else_else_VCOL_else_2_else_else_nor_1_cse_1;
  wire VCOL_else_2_VCOL_else_2_nor_m1c_1;
  wire VCOL_else_2_else_else_else_else_and_5_tmp_mx0w0;
  wire VCOL_else_2_else_else_and_3_m1c_1;
  reg VCOL_land_1_lpi_3_dfm_1;
  wire VCOL_else_2_else_else_land_lpi_3_dfm_1;
  wire VCOL_VCOL_nor_1_m1c_1;
  wire VCOL_else_2_else_else_else_and_tmp_1;
  reg operator_10_false_1_operator_10_false_1_and_cse_sva_1;
  wire VCOL_and_m1c_1;
  wire VCOL_and_1_cse_1;
  reg VCOL_VCOL_oelse_operator_11_false_or_cse_sva_1;
  reg operator_11_false_4_operator_11_false_4_nor_cse_sva_1;
  reg VCOL_stage_0_2;
  reg [9:0] VROW_y_sva;
  reg [10:0] VCOL_x_sva;
  reg VCOL_stage_0_1;
  reg VCOL_stage_0_3;
  reg VCOL_asn_21_itm_1;
  reg operator_11_false_4_operator_11_false_4_nor_cse_sva_2;
  reg VCOL_if_4_VCOL_if_4_and_itm_1;
  reg [9:0] VCOL_else_1_else_asn_itm_1;
  reg operator_11_false_2_operator_11_false_2_slc_VCOL_x_0_1_itm_1;
  wire [10:0] VCOL_x_sva_mx1;
  reg [1:0] VCOL_io_read_ctrl_signal_rsc_svs_1;
  wire [7:0] pix_3_lpi_3_dfm_7_1_mx0;
  wire [7:0] pix_7_lpi_3_dfm_4_mx0;
  wire [7:0] pix_5_lpi_3_dfm_5_mx1;
  wire VCOL_if_4_and_cse;
  reg reg_operator_11_false_6_nor_itm_1_cse;
  reg reg_dat_in_rsci_oswt_cse;
  reg reg_dat_out_rsci_oswt_cse;
  reg reg_line_buf0_rsci_cgo_cse;
  reg reg_line_buf1_rsci_cgo_cse;
  wire pix_and_3_cse;
  wire and_147_cse;
  wire and_152_cse;
  wire and_146_cse;
  wire and_149_cse;
  wire or_29_cse;
  wire nor_28_cse;
  wire mux_32_cse;
  wire VCOL_if_4_VCOL_if_4_or_cse;
  wire [7:0] pix_4_lpi_3_dfm_mx1;
  wire or_118_tmp;
  wire VCOL_and_21_m1c;
  wire VCOL_VCOL_nor_15_m1c;
  reg reg_VCOL_else_2_VCOL_else_2_nor_4_m1c_cse;
  wire rdbuf1_pix_and_cse;
  wire VCOL_VCOL_and_3_cse;
  wire VCOL_nand_cse;
  wire VCOL_if_1_and_m1c;
  wire VCOL_else_2_mux_cse;
  wire VCOL_else_2_and_cse;
  wire and_111_rmff;
  wire and_123_rmff;
  reg [7:0] VCOL_VCOL_slc_pix_47_40_2_lpi_4;
  wire [7:0] pix_2_lpi_3_dfm_8_mx1w0;
  reg [7:0] pix_5_lpi_3_dfm_5;
  reg [7:0] pix_5_lpi_3;
  reg [7:0] VCOL_VCOL_slc_pix_39_32_2_lpi_4;
  wire [7:0] pix_1_lpi_3_dfm_9;
  reg [7:0] VCOL_VCOL_slc_pix_63_56_lpi_4;
  wire or_tmp_95;
  wire [9:0] z_out;
  wire [8:0] z_out_3;
  wire mux_tmp;
  wire or_tmp_104;
  wire [9:0] z_out_4;
  wire [10:0] nl_z_out_4;
  reg [7:0] pix_0_lpi_3;
  reg [7:0] pix_1_lpi_3;
  reg [7:0] pix_2_lpi_3;
  reg [15:0] rdbuf0_pix_lpi_3;
  reg [15:0] rdbuf1_pix_lpi_3;
  reg [7:0] pix_4_lpi_3;
  reg [7:0] pix_3_lpi_3;
  reg [7:0] pix_4_lpi_3_dfm;
  reg [7:0] pix_3_lpi_3_dfm_7;
  reg VCOL_else_2_else_else_else_else_and_5_tmp;
  reg VCOL_else_2_else_else_and_7_m1c;
  reg VCOL_land_lpi_3_dfm_1;
  reg [7:0] pix_3_lpi_3_dfm_7_1;
  reg VCOL_and_8_itm_1;
  reg pix_result_lpi_3_0;
  wire [7:0] pix_0_lpi_3_dfm_8_mx2w1;
  wire VCOL_else_2_else_else_and_7_m1c_mx0;
  wire VCOL_else_2_else_else_else_else_and_5_tmp_mx0;
  wire pix_result_lpi_3_dfm_0_mx1w0;
  wire pix_3_lpi_3_dfm_7_mx1c0;
  wire pix_3_lpi_3_dfm_7_mx1c1;
  wire [7:0] pix_3_lpi_3_dfm_mx0;
  wire [7:0] pix_6_lpi_3_dfm_7;
  wire [7:0] pix_8_lpi_3_dfm_6;
  wire VCOL_else_2_else_else_and_10_m1c_1;
  wire VCOL_else_2_and_1_cse_1;
  wire VCOL_or_7_m1c_1;
  wire VCOL_lor_lpi_3_dfm_1;
  wire VCOL_or_5_m1c_1;
  wire [2:0] pix_result_lpi_3_dfm_10_1_mx1w0_9_7;
  wire [6:0] pix_result_lpi_3_dfm_10_1_mx1w0_6_0;
  wire VROW_y_or_cse;
  wire and_170_cse;
  reg [2:0] pix_result_lpi_3_10_8;
  reg [6:0] pix_result_lpi_3_7_1;
  wire VCOL_else_2_and_26_cse;
  wire operator_10_false_1_and_cse;
  wire VCOL_and_58_cse;
  wire mux_tmp_43;
  wire or_tmp_106;
  wire or_tmp_112;
  wire mux_tmp_46;
  wire mux_tmp_49;
  wire or_tmp_114;
  wire or_tmp_117;
  wire or_tmp_121;
  wire mux_tmp_67;
  wire and_tmp_9;
  wire or_tmp_134;
  wire or_tmp_153;
  wire VCOL_and_55_cse;
  wire or_176_cse;
  wire or_203_cse;
  wire or_239_cse;
  wire and_212_cse;
  wire nor_75_cse;
  wire and_232_cse;
  wire nor_66_cse;
  wire or_196_cse;
  wire or_178_cse;
  wire or_205_cse;
  wire nand_25_itm;
  wire [7:0] VCOL_mux_13_itm;
  wire operator_11_false_acc_itm_11_1;
  wire operator_10_false_acc_itm_10_1;
  wire operator_11_true_acc_itm_2_1;
  wire nor_63_cse;

  wire mux_65_nl;
  wire nand_18_nl;
  wire mux_64_nl;
  wire mux_63_nl;
  wire mux_62_nl;
  wire mux_61_nl;
  wire mux_60_nl;
  wire and_188_nl;
  wire mux_59_nl;
  wire mux_58_nl;
  wire mux_57_nl;
  wire mux_56_nl;
  wire mux_55_nl;
  wire or_184_nl;
  wire mux_54_nl;
  wire or_182_nl;
  wire mux_53_nl;
  wire mux_52_nl;
  wire mux_51_nl;
  wire mux_48_nl;
  wire or_177_nl;
  wire and_226_nl;
  wire mux_45_nl;
  wire mux_78_nl;
  wire mux_77_nl;
  wire and_227_nl;
  wire mux_76_nl;
  wire mux_75_nl;
  wire mux_74_nl;
  wire mux_nl;
  wire and_195_nl;
  wire mux_73_nl;
  wire mux_72_nl;
  wire mux_71_nl;
  wire nor_71_nl;
  wire and_194_nl;
  wire and_193_nl;
  wire and_192_nl;
  wire mux_70_nl;
  wire mux_69_nl;
  wire mux_68_nl;
  wire mux_66_nl;
  wire mux_100_nl;
  wire or_188_nl;
  wire and_191_nl;
  wire mux_87_nl;
  wire mux_86_nl;
  wire mux_85_nl;
  wire mux_84_nl;
  wire mux_83_nl;
  wire mux_82_nl;
  wire and_199_nl;
  wire or_204_nl;
  wire mux_81_nl;
  wire mux_79_nl;
  wire not_201_nl;
  wire VROW_y_not_2_nl;
  wire[6:0] VCOL_if_4_nor_1_nl;
  wire mux_89_nl;
  wire nor_72_nl;
  wire mux_88_nl;
  wire nand_20_nl;
  wire and_201_nl;
  wire mux_91_nl;
  wire mux_90_nl;
  wire nand_22_nl;
  wire nor_73_nl;
  wire nor_74_nl;
  wire or_216_nl;
  wire mux_13_nl;
  wire mux_12_nl;
  wire mux_11_nl;
  wire or_27_nl;
  wire mux_18_nl;
  wire nor_23_nl;
  wire and_44_nl;
  wire mux_93_nl;
  wire or_230_nl;
  wire or_229_nl;
  wire mux_92_nl;
  wire mux_19_nl;
  wire and_47_nl;
  wire mux_97_nl;
  wire mux_96_nl;
  wire mux_95_nl;
  wire nor_77_nl;
  wire mux_94_nl;
  wire nor_78_nl;
  wire nor_79_nl;
  wire or_231_nl;
  wire mux_37_nl;
  wire mux_36_nl;
  wire nor_50_nl;
  wire mux_35_nl;
  wire or_92_nl;
  wire or_91_nl;
  wire or_88_nl;
  wire mux_17_nl;
  wire mux_15_nl;
  wire or_159_nl;
  wire nor_31_nl;
  wire and_68_nl;
  wire mux_16_nl;
  wire or_36_nl;
  wire VCOL_and_nl;
  wire VCOL_and_6_nl;
  wire VCOL_and_50_nl;
  wire VCOL_and_51_nl;
  wire VCOL_and_39_nl;
  wire VCOL_and_24_nl;
  wire VCOL_or_6_nl;
  wire VCOL_and_13_nl;
  wire and_37_nl;
  wire VCOL_and_41_nl;
  wire VCOL_and_42_nl;
  wire VCOL_VCOL_nor_11_nl;
  wire VCOL_VCOL_nor_12_nl;
  wire VCOL_else_2_and_10_nl;
  wire[2:0] VCOL_mux1h_5_nl;
  wire VCOL_not_nl;
  wire or_84_nl;
  wire VCOL_mux1h_22_nl;
  wire[11:0] operator_11_false_acc_nl;
  wire[12:0] nl_operator_11_false_acc_nl;
  wire[10:0] operator_10_false_acc_nl;
  wire[11:0] nl_operator_10_false_acc_nl;
  wire VCOL_if_1_or_nl;
  wire VCOL_if_1_and_2_nl;
  wire VCOL_VCOL_nor_9_nl;
  wire VCOL_and_23_nl;
  wire or_122_nl;
  wire mux_41_nl;
  wire and_161_nl;
  wire or_120_nl;
  wire[9:0] VCOL_else_3_else_if_VCOL_else_3_else_if_and_nl;
  wire VCOL_else_3_else_if_not_6_nl;
  wire[9:0] VCOL_else_3_else_if_VCOL_else_3_else_if_and_1_nl;
  wire VCOL_else_3_else_if_not_7_nl;
  wire[9:0] operator_8_false_24_acc_nl;
  wire[10:0] nl_operator_8_false_24_acc_nl;
  wire[8:0] operator_8_false_24_acc_1_nl;
  wire[9:0] nl_operator_8_false_24_acc_1_nl;
  wire[8:0] operator_8_false_24_acc_3_nl;
  wire[9:0] nl_operator_8_false_24_acc_3_nl;
  wire[8:0] operator_8_false_24_acc_4_nl;
  wire[9:0] nl_operator_8_false_24_acc_4_nl;
  wire VCOL_VCOL_nor_14_nl;
  wire VCOL_and_52_nl;
  wire VCOL_and_53_nl;
  wire VCOL_VCOL_nor_16_nl;
  wire VCOL_or_8_nl;
  wire VCOL_VCOL_nor_17_nl;
  wire VCOL_else_2_and_21_nl;
  wire[2:0] operator_11_true_acc_nl;
  wire[3:0] nl_operator_11_true_acc_nl;
  wire nor_36_nl;
  wire mux_21_nl;
  wire mux_30_nl;
  wire mux_25_nl;
  wire mux_24_nl;
  wire nor_39_nl;
  wire nand_12_nl;
  wire mux_40_nl;
  wire or_116_nl;
  wire mux_39_nl;
  wire nor_43_nl;
  wire VCOL_if_1_not_nl;
  wire[7:0] VCOL_mux_8_nl;
  wire[7:0] VCOL_VCOL_mux1h_12_nl;
  wire VCOL_and_46_nl;
  wire VCOL_and_47_nl;
  wire mux_33_nl;
  wire nor_49_nl;
  wire[7:0] VCOL_VCOL_mux1h_13_nl;
  wire[7:0] VCOL_mux_10_nl;
  wire mux_38_nl;
  wire nor_51_nl;
  wire nor_52_nl;
  wire mux_99_nl;
  wire or_173_nl;
  wire mux_46_nl;
  wire mux_43_nl;
  wire mux_49_nl;
  wire or_191_nl;
  wire mux_80_nl;
  wire[10:0] acc_nl;
  wire[11:0] nl_acc_nl;
  wire[10:0] acc_1_nl;
  wire[11:0] nl_acc_1_nl;
  wire[9:0] acc_2_nl;
  wire[10:0] nl_acc_2_nl;
  wire[7:0] operator_8_false_1_mux_12_nl;
  wire[7:0] operator_8_false_1_mux_13_nl;
  wire[8:0] operator_8_false_1_mux_11_nl;
  wire[8:0] operator_8_false_11_acc_5_nl;
  wire[9:0] nl_operator_8_false_11_acc_5_nl;
  wire operator_8_false_1_operator_8_false_1_nand_2_nl;
  wire[7:0] operator_8_false_1_mux_10_nl;
  wire operator_8_false_1_operator_8_false_1_and_1_nl;
  wire[9:0] acc_3_nl;
  wire[10:0] nl_acc_3_nl;
  wire[7:0] operator_8_false_1_mux_14_nl;
  wire operator_8_false_1_operator_8_false_1_nand_3_nl;
  wire[7:0] operator_8_false_1_mux_15_nl;
  wire[9:0] VROW_VROW_mux_1_nl;
  wire VROW_or_2_nl;

  // Interconnect Declarations for Component Instantiations 
  wire [7:0] nl_EdgeDetect_IP_EdgeDetect_Filter_run_dat_out_rsci_inst_dat_out_rsci_idat;
  assign nl_EdgeDetect_IP_EdgeDetect_Filter_run_dat_out_rsci_inst_dat_out_rsci_idat
      = {dat_out_rsci_idat_7_1 , dat_out_rsci_idat_0};
  wire  nl_EdgeDetect_IP_EdgeDetect_Filter_run_run_fsm_inst_VCOL_C_0_tr0;
  assign nl_EdgeDetect_IP_EdgeDetect_Filter_run_run_fsm_inst_VCOL_C_0_tr0 = ~(VCOL_stage_0_1
      | VCOL_stage_0_2);
  ccs_in_v1 #(.rscid(32'sd5),
  .width(32'sd2)) ctrl_signal_rsci (
      .dat(ctrl_signal_rsc_dat),
      .idat(ctrl_signal_rsci_idat)
    );
  EdgeDetect_IP_EdgeDetect_Filter_run_dat_in_rsci EdgeDetect_IP_EdgeDetect_Filter_run_dat_in_rsci_inst
      (
      .dat_in_rsc_dat(dat_in_rsc_dat),
      .dat_in_rsc_vld(dat_in_rsc_vld),
      .dat_in_rsc_rdy(dat_in_rsc_rdy),
      .run_wen(run_wen),
      .dat_in_rsci_oswt(reg_dat_in_rsci_oswt_cse),
      .dat_in_rsci_wen_comp(dat_in_rsci_wen_comp),
      .dat_in_rsci_idat_mxwt(dat_in_rsci_idat_mxwt)
    );
  EdgeDetect_IP_EdgeDetect_Filter_run_dat_out_rsci EdgeDetect_IP_EdgeDetect_Filter_run_dat_out_rsci_inst
      (
      .clk(clk),
      .rst(rst),
      .arst_n(arst_n),
      .dat_out_rsc_dat(dat_out_rsc_dat),
      .dat_out_rsc_vld(dat_out_rsc_vld),
      .dat_out_rsc_rdy(dat_out_rsc_rdy),
      .run_wen(run_wen),
      .dat_out_rsci_oswt(reg_dat_out_rsci_oswt_cse),
      .dat_out_rsci_wen_comp(dat_out_rsci_wen_comp),
      .dat_out_rsci_idat(nl_EdgeDetect_IP_EdgeDetect_Filter_run_dat_out_rsci_inst_dat_out_rsci_idat[7:0])
    );
  EdgeDetect_IP_EdgeDetect_Filter_run_wait_dp EdgeDetect_IP_EdgeDetect_Filter_run_wait_dp_inst
      (
      .line_buf0_rsci_en_d(line_buf0_rsci_en_d),
      .line_buf1_rsci_en_d(line_buf1_rsci_en_d),
      .run_wen(run_wen),
      .line_buf0_rsci_cgo(reg_line_buf0_rsci_cgo_cse),
      .line_buf0_rsci_cgo_ir_unreg(and_111_rmff),
      .line_buf1_rsci_cgo(reg_line_buf1_rsci_cgo_cse),
      .line_buf1_rsci_cgo_ir_unreg(and_123_rmff)
    );
  EdgeDetect_IP_EdgeDetect_Filter_run_ctrl_signal_triosy_obj EdgeDetect_IP_EdgeDetect_Filter_run_ctrl_signal_triosy_obj_inst
      (
      .ctrl_signal_triosy_lz(ctrl_signal_triosy_lz),
      .run_wten(run_wten),
      .ctrl_signal_triosy_obj_iswt0(ctrl_signal_triosy_obj_iswt0)
    );
  EdgeDetect_IP_EdgeDetect_Filter_run_staller EdgeDetect_IP_EdgeDetect_Filter_run_staller_inst
      (
      .clk(clk),
      .rst(rst),
      .arst_n(arst_n),
      .run_wen(run_wen),
      .run_wten(run_wten),
      .dat_in_rsci_wen_comp(dat_in_rsci_wen_comp),
      .dat_out_rsci_wen_comp(dat_out_rsci_wen_comp)
    );
  EdgeDetect_IP_EdgeDetect_Filter_run_run_fsm EdgeDetect_IP_EdgeDetect_Filter_run_run_fsm_inst
      (
      .clk(clk),
      .rst(rst),
      .arst_n(arst_n),
      .run_wen(run_wen),
      .fsm_output(fsm_output),
      .VCOL_C_0_tr0(nl_EdgeDetect_IP_EdgeDetect_Filter_run_run_fsm_inst_VCOL_C_0_tr0),
      .VROW_C_0_tr0(VROW_equal_tmp)
    );
  assign and_147_cse = operator_11_false_1_nor_tmp & (VCOL_x_sva[0]) & (VROW_y_sva[0])
      & operator_10_false_1_nor_tmp;
  assign and_146_cse = VCOL_stage_0_2 & operator_11_false_4_operator_11_false_4_nor_cse_sva_1;
  assign and_149_cse = (VROW_y_sva[0]) & operator_10_false_1_nor_tmp;
  assign or_176_cse = (VCOL_x_sva[10:1]!=10'b0000000000);
  assign or_239_cse = (VROW_y_sva!=10'b0000000001);
  assign nor_63_cse = ~(reg_operator_11_false_6_nor_itm_1_cse | (~ VCOL_VCOL_oelse_operator_11_false_or_cse_sva_1));
  assign and_152_cse = (VROW_y_sva[0]) & operator_10_false_1_nor_tmp & operator_11_false_1_nor_tmp
      & (VCOL_x_sva_2[0]);
  assign or_203_cse = (ctrl_signal_rsci_idat!=2'b10);
  assign nor_66_cse = ~(VROW_equal_tmp | (~ operator_10_false_1_operator_10_false_1_and_cse_sva_1));
  assign or_196_cse = (~ VCOL_stage_0_1) | VCOL_else_2_else_else_aif_equal_tmp;
  assign or_205_cse = (VCOL_x_sva!=11'b00000000001) | operator_11_false_4_operator_11_false_4_nor_cse_sva_1;
  assign VCOL_and_55_cse = run_wen & VCOL_stage_0_2;
  assign VROW_y_or_cse = (fsm_output[0]) | (fsm_output[2]);
  assign VCOL_if_4_and_cse = run_wen & (fsm_output[1]) & VCOL_stage_0_2 & VCOL_if_4_VCOL_if_4_and_itm_1;
  assign pix_and_3_cse = run_wen & VCOL_stage_0_2 & (fsm_output[1]);
  assign and_232_cse = operator_10_false_1_operator_10_false_1_and_cse_sva_1 & VCOL_else_2_else_else_aif_equal_tmp;
  assign or_29_cse = (VCOL_x_sva[0]) | operator_11_false_4_operator_11_false_4_nor_tmp;
  assign nor_28_cse = ~((VCOL_x_sva_2[0]) | operator_11_false_4_operator_11_false_4_nor_tmp);
  assign rdbuf1_pix_and_cse = run_wen & ((VCOL_x_sva[0]) | operator_11_false_4_operator_11_false_4_nor_cse_sva_1)
      & VCOL_stage_0_2 & (fsm_output[1]);
  assign nor_23_nl = ~(VCOL_else_2_else_else_aif_equal_tmp | (~ (VCOL_x_sva_2[0])));
  assign mux_18_nl = MUX_s_1_2_2((VCOL_x_sva[0]), nor_23_nl, VCOL_stage_0_2);
  assign VCOL_else_2_and_26_cse = run_wen & (~(VCOL_land_1_lpi_3_dfm_1 | (~ VCOL_stage_0_2)))
      & mux_18_nl & VCOL_stage_0_1 & (VROW_y_sva[0]) & operator_10_false_1_nor_tmp
      & operator_11_false_1_nor_tmp;
  assign operator_10_false_1_and_cse = run_wen & VCOL_VCOL_and_3_cse;
  assign VCOL_if_4_VCOL_if_4_or_cse = (VROW_y_sva!=10'b0000000000);
  assign and_212_cse = (VCOL_else_2_else_else_aif_equal_tmp | (~ VCOL_stage_0_1)
      | ((ctrl_signal_rsci_idat==2'b11))) & (~((VCOL_io_read_ctrl_signal_rsc_svs_1==2'b11)))
      & (fsm_output[1]) & run_wen & VCOL_stage_0_2;
  assign nor_75_cse = ~((VCOL_x_sva[10:1]!=10'b0000000000) | operator_10_false_1_operator_10_false_1_and_cse_sva_1);
  assign and_111_rmff = (VCOL_stage_0_1 | VCOL_stage_0_2) & (fsm_output[1]);
  assign or_118_tmp = (nor_tmp_14 & (~ reg_operator_11_false_6_nor_itm_1_cse)) |
      or_dcpl_60;
  assign or_92_nl = (VCOL_x_sva_2[0]) | operator_11_false_4_operator_11_false_4_nor_tmp;
  assign mux_35_nl = MUX_s_1_2_2(and_tmp_1, VCOL_stage_0_1, or_92_nl);
  assign nor_50_nl = ~(VCOL_else_2_else_else_aif_equal_tmp | (~ mux_35_nl));
  assign mux_36_nl = MUX_s_1_2_2(mux_tmp_34, nor_50_nl, VCOL_stage_0_2);
  assign or_91_nl = VCOL_stage_0_2 | mux_tmp_34;
  assign or_88_nl = operator_11_false_2_operator_11_false_2_slc_VCOL_x_0_1_itm_1
      | (VCOL_else_1_else_asn_itm_1!=10'b0000000000) | operator_11_false_4_operator_11_false_4_nor_cse_sva_1;
  assign mux_37_nl = MUX_s_1_2_2(mux_36_nl, or_91_nl, or_88_nl);
  assign and_123_rmff = mux_37_nl & (fsm_output[1]);
  assign VCOL_and_58_cse = run_wen & (~((~((z_out_4!=10'b0000000000))) | VROW_equal_tmp));
  assign VCOL_and_21_m1c = VCOL_lor_lpi_3_dfm_1 & (~ operator_11_false_4_operator_11_false_4_nor_cse_sva_1)
      & VCOL_or_5_m1c_1;
  assign VCOL_and_nl = (~((VCOL_x_sva[0]) | VCOL_lor_lpi_3_dfm_1 | operator_11_false_4_operator_11_false_4_nor_cse_sva_1))
      & VCOL_or_5_m1c_1;
  assign VCOL_and_6_nl = (VCOL_x_sva[0]) & (~ VCOL_lor_lpi_3_dfm_1) & (~ operator_11_false_4_operator_11_false_4_nor_cse_sva_1)
      & VCOL_or_5_m1c_1;
  assign VCOL_and_50_nl = (~ or_dcpl_31) & VCOL_and_21_m1c;
  assign VCOL_and_51_nl = or_dcpl_31 & VCOL_and_21_m1c;
  assign VCOL_and_39_nl = operator_11_false_4_operator_11_false_4_nor_cse_sva_1 &
      VCOL_or_5_m1c_1;
  assign VCOL_and_24_nl = ((VCOL_else_2_else_else_aif_equal_tmp & (~ operator_10_false_1_operator_10_false_1_and_cse_sva_1)
      & VCOL_else_2_else_else_else_and_tmp_1) | VCOL_else_2_else_else_land_lpi_3_dfm_1)
      & VCOL_and_m1c_1;
  assign VCOL_or_6_nl = (operator_10_false_1_operator_10_false_1_and_cse_sva_1 &
      VCOL_else_2_else_else_else_and_tmp_1 & VCOL_and_m1c_1) | VCOL_land_1_lpi_3_dfm_1;
  assign VCOL_and_13_nl = and_232_cse & VCOL_VCOL_nor_1_m1c_1;
  assign pix_0_lpi_3_dfm_8_mx2w1 = MUX1HOT_v_8_8_2((rdbuf1_pix_lpi_3[7:0]), (rdbuf1_pix_lpi_3[15:8]),
      pix_3_lpi_3, pix_0_lpi_3, (line_buf1_rsci_q_d[15:8]), pix_3_lpi_3_dfm_mx0,
      pix_1_lpi_3_dfm_9, pix_4_lpi_3_dfm_mx1, {VCOL_and_nl , VCOL_and_6_nl , VCOL_and_50_nl
      , VCOL_and_51_nl , VCOL_and_39_nl , VCOL_and_24_nl , VCOL_or_6_nl , VCOL_and_13_nl});
  assign and_37_nl = or_dcpl_34 & (~ VCOL_land_1_lpi_3_dfm_1);
  assign pix_3_lpi_3_dfm_7_1_mx0 = MUX_v_8_2_2(pix_4_lpi_3_dfm_mx1, pix_3_lpi_3_dfm_mx0,
      and_37_nl);
  assign VCOL_else_2_else_else_aif_equal_tmp = VCOL_x_sva == widthIn;
  assign VCOL_x_sva_mx1 = MUX_v_11_2_2(VCOL_x_sva, VCOL_x_sva_2, VCOL_stage_0_2);
  assign VCOL_VCOL_and_3_cse = VCOL_stage_0_1 & or_dcpl_6;
  assign VCOL_and_41_nl = (~ VCOL_land_lpi_3_dfm_1) & VCOL_or_7_m1c_1;
  assign VCOL_and_42_nl = VCOL_land_lpi_3_dfm_1 & VCOL_or_7_m1c_1;
  assign VCOL_VCOL_nor_11_nl = ~((~((VCOL_else_2_else_else_aif_equal_tmp & VCOL_else_2_else_else_and_3_m1c_1)
      | VCOL_else_2_and_1_cse_1)) | VCOL_land_1_lpi_3_dfm_1);
  assign VCOL_VCOL_nor_12_nl = ~((~((VROW_equal_tmp & VCOL_else_2_else_else_and_3_m1c_1)
      | VCOL_else_2_land_lpi_3_dfm_1)) | VCOL_land_1_lpi_3_dfm_1);
  assign VCOL_else_2_and_10_nl = VCOL_else_2_else_else_land_lpi_3_dfm_1 & VCOL_else_2_VCOL_else_2_nor_m1c_1
      & (~ VCOL_land_1_lpi_3_dfm_1);
  assign pix_2_lpi_3_dfm_8_mx1w0 = MUX1HOT_v_8_5_2(pix_2_lpi_3, dat_in_rsci_idat_mxwt,
      pix_5_lpi_3, pix_1_lpi_3_dfm_9, pix_4_lpi_3_dfm_mx1, {VCOL_and_41_nl , VCOL_and_42_nl
      , VCOL_VCOL_nor_11_nl , VCOL_VCOL_nor_12_nl , VCOL_else_2_and_10_nl});
  assign VCOL_else_2_mux_cse = MUX_s_1_2_2(VCOL_else_2_VCOL_else_2_nor_m1c_1, reg_VCOL_else_2_VCOL_else_2_nor_4_m1c_cse,
      VCOL_land_1_lpi_3_dfm_1);
  assign VCOL_else_2_else_else_and_7_m1c_mx0 = MUX_s_1_2_2(VCOL_else_2_else_else_and_3_m1c_1,
      VCOL_else_2_else_else_and_7_m1c, VCOL_land_1_lpi_3_dfm_1);
  assign VCOL_else_2_else_else_else_else_and_5_tmp_mx0w0 = operator_10_false_1_operator_10_false_1_and_cse_sva_1
      & (~ VROW_equal_tmp);
  assign VCOL_else_2_else_else_else_else_and_5_tmp_mx0 = MUX_s_1_2_2(VCOL_else_2_else_else_else_else_and_5_tmp_mx0w0,
      VCOL_else_2_else_else_else_else_and_5_tmp, VCOL_land_1_lpi_3_dfm_1);
  assign operator_10_false_1_nor_tmp = ~((VROW_y_sva[9:1]!=9'b000000000));
  assign operator_11_false_1_nor_tmp = ~((VCOL_x_sva_mx1[10:1]!=10'b0000000000));
  assign VCOL_mux1h_5_nl = MUX1HOT_v_3_3_2((z_out[9:7]), (pix_result_sva_4[10:8]),
      pix_result_lpi_3_10_8, {VCOL_VCOL_and_ssc_1 , VCOL_VCOL_and_1_ssc_1 , VCOL_VCOL_and_2_ssc_1});
  assign VCOL_not_nl = ~ VCOL_VCOL_nor_ssc_1;
  assign pix_result_lpi_3_dfm_10_1_mx1w0_9_7 = MUX_v_3_2_2(3'b000, VCOL_mux1h_5_nl,
      VCOL_not_nl);
  assign pix_result_lpi_3_dfm_10_1_mx1w0_6_0 = MUX1HOT_v_7_4_2((pix_4_lpi_3_dfm_mx1[7:1]),
      (z_out[6:0]), (pix_result_sva_4[7:1]), pix_result_lpi_3_7_1, {VCOL_VCOL_nor_ssc_1
      , VCOL_VCOL_and_ssc_1 , VCOL_VCOL_and_1_ssc_1 , VCOL_VCOL_and_2_ssc_1});
  assign operator_11_false_4_operator_11_false_4_nor_tmp = ~((VCOL_x_sva_mx1!=11'b00000000000));
  assign VCOL_VCOL_oelse_operator_11_false_or_tmp = (VCOL_x_sva_mx1!=11'b00000000000);
  assign or_84_nl = VCOL_else_2_else_else_aif_equal_tmp | (VCOL_x_sva_2[0]);
  assign mux_32_cse = MUX_s_1_2_2((VCOL_x_sva[0]), or_84_nl, VCOL_stage_0_2);
  assign VCOL_mux1h_22_nl = MUX1HOT_s_1_3_2((pix_4_lpi_3_dfm_mx1[0]), (pix_result_sva_4[0]),
      pix_result_lpi_3_0, {VCOL_VCOL_nor_ssc_1 , VCOL_VCOL_and_1_ssc_1 , VCOL_VCOL_and_2_ssc_1});
  assign pix_result_lpi_3_dfm_0_mx1w0 = VCOL_mux1h_22_nl & (~ VCOL_VCOL_and_ssc_1);
  assign pix_4_lpi_3_dfm_mx1 = MUX_v_8_2_2(pix_4_lpi_3, (line_buf0_rsci_q_d[7:0]),
      operator_11_false_4_operator_11_false_4_nor_cse_sva_1);
  assign pix_5_lpi_3_dfm_5_mx1 = MUX_v_8_2_2(pix_4_lpi_3_dfm_mx1, pix_5_lpi_3, or_dcpl_61);
  assign nl_operator_11_false_acc_nl = ({1'b1 , widthIn}) + conv_u2s_11_12(~ VCOL_x_sva_mx1);
  assign operator_11_false_acc_nl = nl_operator_11_false_acc_nl[11:0];
  assign operator_11_false_acc_itm_11_1 = readslicef_12_1_11(operator_11_false_acc_nl);
  assign nl_operator_10_false_acc_nl = ({1'b1 , heightIn}) + conv_u2s_10_11(~ VROW_y_sva);
  assign operator_10_false_acc_nl = nl_operator_10_false_acc_nl[10:0];
  assign operator_10_false_acc_itm_10_1 = readslicef_11_1_10(operator_10_false_acc_nl);
  assign VCOL_if_1_and_m1c = ~(or_dcpl_31 | operator_11_false_4_operator_11_false_4_nor_cse_sva_1);
  assign VCOL_if_1_or_nl = ((~ operator_11_false_4_operator_11_false_4_nor_cse_sva_2)
      & VCOL_if_1_and_m1c) | (or_dcpl_31 & (~ operator_11_false_4_operator_11_false_4_nor_cse_sva_1));
  assign VCOL_if_1_and_2_nl = operator_11_false_4_operator_11_false_4_nor_cse_sva_2
      & VCOL_if_1_and_m1c;
  assign pix_3_lpi_3_dfm_mx0 = MUX1HOT_v_8_3_2(pix_3_lpi_3, pix_3_lpi_3_dfm_7_1,
      (line_buf1_rsci_q_d[7:0]), {VCOL_if_1_or_nl , VCOL_if_1_and_2_nl , operator_11_false_4_operator_11_false_4_nor_cse_sva_1});
  assign VCOL_VCOL_nor_9_nl = ~((VCOL_x_sva[0]) | reg_operator_11_false_6_nor_itm_1_cse
      | operator_11_false_4_operator_11_false_4_nor_cse_sva_1);
  assign VCOL_and_23_nl = reg_operator_11_false_6_nor_itm_1_cse & (~ operator_11_false_4_operator_11_false_4_nor_cse_sva_1);
  assign pix_1_lpi_3_dfm_9 = MUX1HOT_v_8_4_2((rdbuf0_pix_lpi_3[7:0]), (rdbuf0_pix_lpi_3[15:8]),
      pix_1_lpi_3, (line_buf0_rsci_q_d[15:8]), {VCOL_VCOL_nor_9_nl , VCOL_and_8_itm_1
      , VCOL_and_23_nl , operator_11_false_4_operator_11_false_4_nor_cse_sva_1});
  assign and_161_nl = (~(operator_10_false_1_operator_10_false_1_and_cse_sva_1 &
      VCOL_else_2_else_else_aif_equal_tmp)) & VCOL_else_2_else_else_else_nor_1_tmp;
  assign or_120_nl = reg_operator_11_false_6_nor_itm_1_cse | (~(VCOL_else_2_else_else_aif_equal_tmp
      | (~ VCOL_else_2_else_else_else_nor_1_tmp)));
  assign mux_41_nl = MUX_s_1_2_2(and_161_nl, or_120_nl, VROW_equal_tmp);
  assign or_122_nl = (mux_41_nl & (VCOL_x_sva[0])) | VCOL_land_1_lpi_3_dfm_1;
  assign pix_7_lpi_3_dfm_4_mx0 = MUX_v_8_2_2(pix_4_lpi_3_dfm, pix_4_lpi_3_dfm_mx1,
      or_122_nl);
  assign VCOL_else_2_else_else_else_nor_1_tmp = ~((VCOL_x_sva[10:1]!=10'b0000000000));
  assign VCOL_else_2_else_else_else_unequal_tmp_1 = ~((VCOL_x_sva[0]) & VCOL_else_2_else_else_else_nor_1_tmp);
  assign VCOL_else_2_else_else_else_and_tmp_1 = (~ VROW_equal_tmp) & VCOL_else_2_else_else_else_unequal_tmp_1;
  assign VCOL_else_2_else_else_land_lpi_3_dfm_1 = VCOL_else_2_else_else_aif_equal_tmp
      & VROW_equal_tmp;
  assign VROW_equal_tmp = VROW_y_sva == heightIn;
  assign VCOL_else_2_VCOL_else_2_nor_m1c_1 = ~(and_232_cse | VCOL_else_2_land_lpi_3_dfm_1);
  assign VCOL_else_2_else_else_and_3_m1c_1 = VCOL_else_2_else_else_else_unequal_tmp_1
      & (~ VCOL_else_2_else_else_land_lpi_3_dfm_1) & VCOL_else_2_VCOL_else_2_nor_m1c_1;
  assign VCOL_else_2_land_lpi_3_dfm_1 = (VCOL_x_sva[0]) & reg_operator_11_false_6_nor_itm_1_cse
      & VROW_equal_tmp;
  assign VCOL_else_3_else_if_not_6_nl = ~ (z_out[9]);
  assign VCOL_else_3_else_if_VCOL_else_3_else_if_and_nl = MUX_v_10_2_2(10'b0000000000,
      z_out, VCOL_else_3_else_if_not_6_nl);
  assign VCOL_else_3_else_if_not_7_nl = ~ (VCOL_else_3_else_if_ac_int_cctor_1_sva_1[9]);
  assign VCOL_else_3_else_if_VCOL_else_3_else_if_and_1_nl = MUX_v_10_2_2(10'b0000000000,
      VCOL_else_3_else_if_ac_int_cctor_1_sva_1, VCOL_else_3_else_if_not_7_nl);
  assign nl_pix_result_sva_4 = conv_s2s_10_11(VCOL_else_3_else_if_VCOL_else_3_else_if_and_nl)
      + conv_s2s_10_11(VCOL_else_3_else_if_VCOL_else_3_else_if_and_1_nl);
  assign pix_result_sva_4 = nl_pix_result_sva_4[10:0];
  assign nl_operator_8_false_24_acc_1_nl = conv_u2u_8_9(pix_0_lpi_3_dfm_8_mx2w1)
      + conv_u2u_8_9(~ pix_2_lpi_3_dfm_8_mx1w0) + 9'b000000001;
  assign operator_8_false_24_acc_1_nl = nl_operator_8_false_24_acc_1_nl[8:0];
  assign nl_operator_8_false_24_acc_3_nl = conv_u2u_8_9(pix_6_lpi_3_dfm_7) + conv_u2u_8_9(~
      pix_8_lpi_3_dfm_6) + 9'b000000001;
  assign operator_8_false_24_acc_3_nl = nl_operator_8_false_24_acc_3_nl[8:0];
  assign nl_operator_8_false_24_acc_nl = conv_u2u_9_10(operator_8_false_24_acc_1_nl)
      + conv_u2u_9_10(operator_8_false_24_acc_3_nl) + 10'b0000000001;
  assign operator_8_false_24_acc_nl = nl_operator_8_false_24_acc_nl[9:0];
  assign nl_operator_8_false_24_acc_4_nl = conv_u2u_8_9(pix_3_lpi_3_dfm_7_1_mx0)
      + conv_u2u_8_9(~ pix_5_lpi_3_dfm_5_mx1);
  assign operator_8_false_24_acc_4_nl = nl_operator_8_false_24_acc_4_nl[8:0];
  assign nl_VCOL_else_3_else_if_ac_int_cctor_1_sva_1 = operator_8_false_24_acc_nl
      + ({operator_8_false_24_acc_4_nl , 1'b1});
  assign VCOL_else_3_else_if_ac_int_cctor_1_sva_1 = nl_VCOL_else_3_else_if_ac_int_cctor_1_sva_1[9:0];
  assign VCOL_VCOL_nor_15_m1c = ~((~(((~ VCOL_else_2_else_else_else_else_and_5_tmp_mx0)
      & VCOL_else_2_else_else_and_7_m1c_mx0) | (VCOL_else_2_else_else_land_lpi_3_dfm_1
      & VCOL_else_2_mux_cse))) | VCOL_land_1_lpi_3_dfm_1);
  assign VCOL_else_2_and_cse = VCOL_else_2_else_else_VCOL_else_2_else_else_nor_1_cse_1
      & VCOL_else_2_mux_cse;
  assign VCOL_VCOL_nor_14_nl = ~((~(VCOL_else_2_and_cse | VCOL_else_2_land_lpi_3_dfm_1))
      | VCOL_land_1_lpi_3_dfm_1);
  assign VCOL_and_52_nl = (~ or_dcpl_31) & VCOL_VCOL_nor_15_m1c;
  assign VCOL_and_53_nl = or_dcpl_31 & VCOL_VCOL_nor_15_m1c;
  assign VCOL_VCOL_nor_16_nl = ~((~((VCOL_else_2_else_else_else_else_and_5_tmp_mx0
      & VCOL_else_2_else_else_and_7_m1c_mx0) | VCOL_else_2_and_1_cse_1)) | VCOL_land_1_lpi_3_dfm_1);
  assign pix_6_lpi_3_dfm_7 = MUX1HOT_v_8_5_2(pix_3_lpi_3_dfm_mx0, pix_3_lpi_3_dfm_7_1,
      pix_3_lpi_3_dfm_7, pix_4_lpi_3_dfm, pix_4_lpi_3_dfm_mx1, {VCOL_VCOL_nor_14_nl
      , VCOL_and_52_nl , VCOL_and_53_nl , VCOL_VCOL_nor_16_nl , VCOL_land_1_lpi_3_dfm_1});
  assign VCOL_or_8_nl = VCOL_else_2_and_cse | VCOL_land_1_lpi_3_dfm_1;
  assign VCOL_VCOL_nor_17_nl = ~((~(((~ VROW_equal_tmp) & VCOL_else_2_else_else_and_10_m1c_1
      & VCOL_else_2_mux_cse) | VCOL_else_2_and_1_cse_1)) | VCOL_land_1_lpi_3_dfm_1);
  assign VCOL_else_2_and_21_nl = ((VROW_equal_tmp & VCOL_else_2_else_else_and_10_m1c_1)
      | VCOL_else_2_else_else_land_lpi_3_dfm_1) & VCOL_else_2_mux_cse & (~ VCOL_land_1_lpi_3_dfm_1);
  assign pix_8_lpi_3_dfm_6 = MUX1HOT_v_8_4_2(pix_5_lpi_3, pix_5_lpi_3_dfm_5, pix_4_lpi_3_dfm,
      pix_4_lpi_3_dfm_mx1, {VCOL_or_8_nl , VCOL_VCOL_nor_17_nl , VCOL_else_2_and_21_nl
      , VCOL_and_1_cse_1});
  assign VCOL_else_2_else_else_VCOL_else_2_else_else_nor_1_cse_1 = ~(VCOL_else_2_else_else_else_unequal_tmp_1
      | VCOL_else_2_else_else_land_lpi_3_dfm_1);
  assign VCOL_else_2_else_else_and_10_m1c_1 = VCOL_else_2_else_else_else_unequal_tmp_1
      & (~ VCOL_else_2_else_else_land_lpi_3_dfm_1);
  assign VCOL_else_2_and_1_cse_1 = and_232_cse & (~ VCOL_else_2_land_lpi_3_dfm_1);
  assign VCOL_and_1_cse_1 = VCOL_else_2_land_lpi_3_dfm_1 & (~ VCOL_land_1_lpi_3_dfm_1);
  assign nl_operator_11_true_acc_nl = ({1'b1 , (~ (pix_result_lpi_3_dfm_10_1_mx1w0_9_7[1:0]))})
      + 3'b001;
  assign operator_11_true_acc_nl = nl_operator_11_true_acc_nl[2:0];
  assign operator_11_true_acc_itm_2_1 = readslicef_3_1_2(operator_11_true_acc_nl);
  assign nl_VCOL_x_sva_2 = VCOL_x_sva + 11'b00000000001;
  assign VCOL_x_sva_2 = nl_VCOL_x_sva_2[10:0];
  assign VCOL_VCOL_nor_ssc_1 = ~((VCOL_io_read_ctrl_signal_rsc_svs_1!=2'b00));
  assign VCOL_VCOL_and_ssc_1 = (VCOL_io_read_ctrl_signal_rsc_svs_1==2'b01);
  assign VCOL_VCOL_and_1_ssc_1 = (VCOL_io_read_ctrl_signal_rsc_svs_1==2'b10);
  assign VCOL_VCOL_and_2_ssc_1 = (VCOL_io_read_ctrl_signal_rsc_svs_1==2'b11);
  assign VCOL_VCOL_nor_1_m1c_1 = ~(VCOL_else_2_land_lpi_3_dfm_1 | VCOL_land_1_lpi_3_dfm_1);
  assign VCOL_or_7_m1c_1 = (VCOL_else_2_else_else_VCOL_else_2_else_else_nor_1_cse_1
      & VCOL_else_2_VCOL_else_2_nor_m1c_1) | (((~(VCOL_else_2_else_else_aif_equal_tmp
      | operator_10_false_1_operator_10_false_1_and_cse_sva_1 | VROW_equal_tmp))
      | VCOL_else_2_else_else_else_else_and_5_tmp_mx0w0) & VCOL_else_2_else_else_and_3_m1c_1)
      | VCOL_land_1_lpi_3_dfm_1;
  assign VCOL_and_m1c_1 = (~ and_232_cse) & VCOL_VCOL_nor_1_m1c_1;
  assign VCOL_nand_cse = ~((VCOL_x_sva[0]) & reg_operator_11_false_6_nor_itm_1_cse);
  assign VCOL_lor_lpi_3_dfm_1 = ~(VCOL_nand_cse & VCOL_VCOL_oelse_operator_11_false_or_cse_sva_1);
  assign VCOL_or_5_m1c_1 = (((~(VCOL_else_2_else_else_else_and_tmp_1 | VCOL_else_2_else_else_land_lpi_3_dfm_1))
      | ((~(VCOL_else_2_else_else_aif_equal_tmp | operator_10_false_1_operator_10_false_1_and_cse_sva_1))
      & VCOL_else_2_else_else_else_and_tmp_1)) & VCOL_and_m1c_1) | VCOL_and_1_cse_1;
  assign or_dcpl_6 = ~(VCOL_else_2_else_else_aif_equal_tmp & VCOL_stage_0_2);
  assign and_dcpl_4 = VCOL_stage_0_1 & (~ operator_11_false_4_operator_11_false_4_nor_tmp);
  assign or_tmp_14 = VCOL_else_2_else_else_aif_equal_tmp | (~((operator_11_false_1_nor_tmp
      & (VCOL_x_sva_2[0])) | operator_11_false_4_operator_11_false_4_nor_tmp));
  assign or_tmp_17 = ((VCOL_x_sva[0]) & operator_11_false_1_nor_tmp) | operator_11_false_4_operator_11_false_4_nor_tmp;
  assign mux_tmp_14 = MUX_s_1_2_2((~ (ctrl_signal_rsci_idat[0])), (ctrl_signal_rsci_idat[0]),
      ctrl_signal_rsci_idat[1]);
  assign not_tmp_22 = ~(and_147_cse | (ctrl_signal_rsci_idat!=2'b10));
  assign or_dcpl_31 = (~ VCOL_stage_0_3) | VCOL_asn_21_itm_1;
  assign and_dcpl_19 = VCOL_stage_0_3 & (~ VCOL_asn_21_itm_1) & VCOL_stage_0_1 &
      (~ VCOL_stage_0_2);
  assign or_tmp_30 = (~ VCOL_else_2_else_else_aif_equal_tmp) | (VCOL_x_sva[0]);
  assign nor_tmp_14 = VCOL_else_2_else_else_else_nor_1_tmp & (VCOL_x_sva[0]);
  assign nor_36_nl = ~(VCOL_else_2_else_else_aif_equal_tmp | (~ nor_tmp_14));
  assign mux_21_nl = MUX_s_1_2_2((~ VCOL_else_2_else_else_aif_equal_tmp), or_tmp_30,
      reg_operator_11_false_6_nor_itm_1_cse);
  assign mux_tmp_22 = MUX_s_1_2_2(nor_36_nl, mux_21_nl, VROW_equal_tmp);
  assign or_dcpl_34 = mux_tmp_22 | (~ operator_10_false_1_operator_10_false_1_and_cse_sva_1);
  assign and_dcpl_30 = VCOL_stage_0_2 & (~ operator_11_false_4_operator_11_false_4_nor_cse_sva_1);
  assign nor_39_nl = ~(VCOL_else_2_else_else_else_nor_1_tmp | (~ VCOL_else_2_else_else_aif_equal_tmp));
  assign mux_24_nl = MUX_s_1_2_2(VCOL_else_2_else_else_aif_equal_tmp, nor_39_nl,
      VCOL_x_sva[0]);
  assign mux_25_nl = MUX_s_1_2_2(mux_24_nl, VCOL_else_2_else_else_aif_equal_tmp,
      operator_10_false_1_operator_10_false_1_and_cse_sva_1);
  assign nand_12_nl = ~(VCOL_nand_cse & VCOL_else_2_else_else_aif_equal_tmp);
  assign mux_30_nl = MUX_s_1_2_2((~ mux_25_nl), nand_12_nl, VROW_equal_tmp);
  assign or_dcpl_42 = mux_30_nl | VCOL_land_1_lpi_3_dfm_1;
  assign and_tmp_1 = VCOL_stage_0_1 & VCOL_if_4_VCOL_if_4_or_cse;
  assign mux_tmp_34 = MUX_s_1_2_2(and_tmp_1, VCOL_stage_0_1, or_29_cse);
  assign or_dcpl_60 = (~ VROW_equal_tmp) | VCOL_land_1_lpi_3_dfm_1;
  assign or_116_nl = reg_operator_11_false_6_nor_itm_1_cse | VCOL_else_2_else_else_aif_equal_tmp
      | (~ nor_tmp_14);
  assign nor_43_nl = ~(VCOL_else_2_else_else_aif_equal_tmp | nor_tmp_14);
  assign mux_39_nl = MUX_s_1_2_2(nor_43_nl, or_tmp_30, reg_operator_11_false_6_nor_itm_1_cse);
  assign mux_40_nl = MUX_s_1_2_2(or_116_nl, mux_39_nl, operator_10_false_1_operator_10_false_1_and_cse_sva_1);
  assign or_dcpl_61 = (~ mux_40_nl) | or_dcpl_60;
  assign pix_3_lpi_3_dfm_7_mx1c0 = (((~ mux_tmp_22) & operator_10_false_1_operator_10_false_1_and_cse_sva_1)
      | VCOL_land_1_lpi_3_dfm_1) & VCOL_stage_0_2;
  assign pix_3_lpi_3_dfm_7_mx1c1 = or_dcpl_34 & (~ VCOL_land_1_lpi_3_dfm_1) & VCOL_stage_0_2;
  assign VCOL_if_1_not_nl = ~ operator_11_false_4_operator_11_false_4_nor_tmp;
  assign line_buf0_rsci_adr_d_pff = MUX_v_10_2_2(10'b0000000000, z_out_4, VCOL_if_1_not_nl);
  assign VCOL_mux_8_nl = MUX_v_8_2_2(VCOL_VCOL_slc_pix_47_40_2_lpi_4, pix_2_lpi_3_dfm_8_mx1w0,
      VCOL_stage_0_2);
  assign VCOL_and_46_nl = (~ or_118_tmp) & VCOL_stage_0_2;
  assign VCOL_and_47_nl = or_118_tmp & VCOL_stage_0_2;
  assign VCOL_VCOL_mux1h_12_nl = MUX1HOT_v_8_3_2(pix_5_lpi_3_dfm_5, pix_4_lpi_3_dfm_mx1,
      pix_5_lpi_3, {(~ VCOL_stage_0_2) , VCOL_and_46_nl , VCOL_and_47_nl});
  assign line_buf0_rsci_d_d = {VCOL_mux_8_nl , VCOL_VCOL_mux1h_12_nl};
  assign line_buf0_rsci_we_d_pff = (~ mux_32_cse) & and_dcpl_4 & (fsm_output[1]);
  assign nor_49_nl = ~(VCOL_else_2_else_else_aif_equal_tmp | nor_28_cse);
  assign mux_33_nl = MUX_s_1_2_2(or_29_cse, nor_49_nl, VCOL_stage_0_2);
  assign line_buf0_rsci_port_0_rw_ram_ir_internal_RMASK_B_d_pff = mux_33_nl & VCOL_stage_0_1
      & (fsm_output[1]);
  assign VCOL_VCOL_mux1h_13_nl = MUX1HOT_v_8_3_2(VCOL_VCOL_slc_pix_39_32_2_lpi_4,
      pix_4_lpi_3_dfm_mx1, pix_1_lpi_3_dfm_9, {(~ VCOL_stage_0_2) , and_146_cse ,
      and_dcpl_30});
  assign VCOL_mux_10_nl = MUX_v_8_2_2(VCOL_VCOL_slc_pix_63_56_lpi_4, pix_4_lpi_3_dfm_mx1,
      VCOL_stage_0_2);
  assign line_buf1_rsci_d_d = {VCOL_VCOL_mux1h_13_nl , VCOL_mux_10_nl};
  assign nor_51_nl = ~((VCOL_x_sva[0]) | (~ VCOL_if_4_VCOL_if_4_or_cse));
  assign nor_52_nl = ~(VCOL_else_2_else_else_aif_equal_tmp | (VCOL_x_sva_2[0]) |
      (~ VCOL_if_4_VCOL_if_4_or_cse));
  assign mux_38_nl = MUX_s_1_2_2(nor_51_nl, nor_52_nl, VCOL_stage_0_2);
  assign line_buf1_rsci_we_d_pff = mux_38_nl & and_dcpl_4 & (fsm_output[1]);
  assign or_tmp_95 = (~ (VCOL_io_read_ctrl_signal_rsc_svs_1[0])) & (fsm_output[1]);
  assign and_170_cse = (VCOL_io_read_ctrl_signal_rsc_svs_1[1]) & (fsm_output[1]);
  assign mux_tmp = MUX_s_1_2_2((VCOL_x_sva[0]), (VCOL_x_sva_2[0]), VCOL_stage_0_2);
  assign or_tmp_104 = (~ mux_tmp) & (fsm_output[1]);
  assign nand_25_itm = ~((VCOL_x_sva_2[0]) & or_239_cse);
  assign mux_99_nl = MUX_s_1_2_2(operator_11_false_4_operator_11_false_4_nor_cse_sva_1,
      nand_25_itm, VCOL_stage_0_1);
  assign or_173_nl = VCOL_else_2_else_else_aif_equal_tmp | (VCOL_x_sva_2[10:1]!=10'b0000000000);
  assign mux_tmp_43 = MUX_s_1_2_2(mux_99_nl, operator_11_false_4_operator_11_false_4_nor_cse_sva_1,
      or_173_nl);
  assign or_tmp_106 = VCOL_stage_0_1 | (~ operator_11_false_4_operator_11_false_4_nor_cse_sva_2);
  assign or_tmp_112 = (VCOL_x_sva_2[10:1]!=10'b0000000000) | (~(VCOL_stage_0_1 &
      (VCOL_x_sva_2[0]) & or_239_cse & operator_11_false_4_operator_11_false_4_nor_cse_sva_1));
  assign or_178_cse = (VCOL_x_sva_2[10:1]!=10'b0000000000);
  assign mux_43_nl = MUX_s_1_2_2(operator_11_false_4_operator_11_false_4_nor_cse_sva_1,
      nand_25_itm, VCOL_stage_0_1);
  assign mux_46_nl = MUX_s_1_2_2(mux_43_nl, operator_11_false_4_operator_11_false_4_nor_cse_sva_1,
      or_178_cse);
  assign mux_tmp_46 = MUX_s_1_2_2(or_tmp_112, mux_46_nl, nor_66_cse);
  assign mux_49_nl = MUX_s_1_2_2(mux_tmp_46, operator_11_false_4_operator_11_false_4_nor_cse_sva_1,
      VCOL_else_2_else_else_aif_equal_tmp);
  assign mux_tmp_49 = MUX_s_1_2_2(mux_49_nl, mux_tmp_43, VCOL_VCOL_oelse_operator_11_false_or_cse_sva_1);
  assign or_tmp_114 = VROW_equal_tmp | operator_10_false_1_operator_10_false_1_and_cse_sva_1;
  assign or_tmp_117 = operator_11_false_4_operator_11_false_4_nor_cse_sva_1 | VCOL_land_1_lpi_3_dfm_1;
  assign or_tmp_121 = VCOL_stage_0_1 | (~ VCOL_stage_0_3) | VCOL_asn_21_itm_1;
  assign or_191_nl = nor_66_cse | VCOL_VCOL_oelse_operator_11_false_or_cse_sva_1;
  assign mux_tmp_67 = MUX_s_1_2_2(or_tmp_121, VCOL_stage_0_1, or_191_nl);
  assign and_tmp_9 = operator_11_false_4_operator_11_false_4_nor_cse_sva_1 & or_178_cse;
  assign mux_80_nl = MUX_s_1_2_2(operator_11_false_4_operator_11_false_4_nor_cse_sva_1,
      or_205_cse, nor_66_cse);
  assign or_tmp_134 = VCOL_land_1_lpi_3_dfm_1 | (~ operator_11_false_4_operator_11_false_4_nor_cse_sva_2)
      | (~ VCOL_stage_0_3) | VCOL_asn_21_itm_1 | mux_80_nl;
  assign or_tmp_153 = VCOL_else_2_else_else_aif_equal_tmp | (~(VCOL_stage_0_1 & ((VCOL_x_sva_2!=11'b00000000001))));
  assign VCOL_mux_13_itm = MUX_v_8_2_2(pix_4_lpi_3_dfm_mx1, pix_1_lpi_3_dfm_9, or_dcpl_42);
  always @(posedge clk) begin
    if ( (~ mux_65_nl) & run_wen & (fsm_output[1]) ) begin
      pix_3_lpi_3 <= MUX_v_8_2_2(pix_3_lpi_3_dfm_7_1, pix_0_lpi_3_dfm_8_mx2w1, VCOL_stage_0_2);
    end
  end
  always @(posedge clk) begin
    if ( mux_78_nl & run_wen & (fsm_output[1]) ) begin
      pix_0_lpi_3 <= MUX_v_8_2_2(pix_3_lpi_3, pix_0_lpi_3_dfm_8_mx2w1, VCOL_stage_0_2);
    end
  end
  always @(posedge clk) begin
    if ( mux_87_nl & VCOL_and_55_cse ) begin
      pix_3_lpi_3_dfm_7_1 <= pix_3_lpi_3_dfm_7_1_mx0;
    end
  end
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      VCOL_asn_21_itm_1 <= 1'b0;
    end
    else if ( rst ) begin
      VCOL_asn_21_itm_1 <= 1'b0;
    end
    else if ( VCOL_and_55_cse ) begin
      VCOL_asn_21_itm_1 <= VCOL_else_2_else_else_aif_equal_tmp;
    end
  end
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      operator_11_false_4_operator_11_false_4_nor_cse_sva_2 <= 1'b0;
    end
    else if ( rst ) begin
      operator_11_false_4_operator_11_false_4_nor_cse_sva_2 <= 1'b0;
    end
    else if ( run_wen & ((~((~((~((VROW_y_sva[0]) & operator_10_false_1_nor_tmp))
        | (~(operator_11_false_1_nor_tmp & (VCOL_x_sva_2[0]))))) | operator_11_false_4_operator_11_false_4_nor_tmp))
        | (~ VCOL_stage_0_1) | VCOL_else_2_else_else_aif_equal_tmp) & VCOL_stage_0_2
        ) begin
      operator_11_false_4_operator_11_false_4_nor_cse_sva_2 <= operator_11_false_4_operator_11_false_4_nor_cse_sva_1;
    end
  end
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      VCOL_x_sva <= 11'b00000000000;
    end
    else if ( rst ) begin
      VCOL_x_sva <= 11'b00000000000;
    end
    else if ( (VCOL_stage_0_2 | (fsm_output[2]) | (fsm_output[0])) & run_wen ) begin
      VCOL_x_sva <= MUX_v_11_2_2(11'b00000000000, VCOL_x_sva_mx1, not_201_nl);
    end
  end
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      VROW_y_sva <= 10'b0000000000;
    end
    else if ( rst ) begin
      VROW_y_sva <= 10'b0000000000;
    end
    else if ( run_wen & VROW_y_or_cse ) begin
      VROW_y_sva <= MUX_v_10_2_2(10'b0000000000, z_out_4, VROW_y_not_2_nl);
    end
  end
  always @(posedge clk) begin
    if ( VCOL_if_4_and_cse ) begin
      dat_out_rsci_idat_7_1 <= ~(MUX_v_7_2_2(VCOL_if_4_nor_1_nl, 7'b1111111, (pix_result_lpi_3_dfm_10_1_mx1w0_9_7[2])));
      dat_out_rsci_idat_0 <= ~((~(pix_result_lpi_3_dfm_0_mx1w0 | operator_11_true_acc_itm_2_1))
          | (pix_result_lpi_3_dfm_10_1_mx1w0_9_7[2]));
    end
  end
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      VCOL_stage_0_1 <= 1'b0;
      VCOL_stage_0_2 <= 1'b0;
      VCOL_stage_0_3 <= 1'b0;
      reg_dat_in_rsci_oswt_cse <= 1'b0;
      reg_dat_out_rsci_oswt_cse <= 1'b0;
      reg_line_buf0_rsci_cgo_cse <= 1'b0;
      reg_line_buf1_rsci_cgo_cse <= 1'b0;
      ctrl_signal_triosy_obj_iswt0 <= 1'b0;
    end
    else if ( rst ) begin
      VCOL_stage_0_1 <= 1'b0;
      VCOL_stage_0_2 <= 1'b0;
      VCOL_stage_0_3 <= 1'b0;
      reg_dat_in_rsci_oswt_cse <= 1'b0;
      reg_dat_out_rsci_oswt_cse <= 1'b0;
      reg_line_buf0_rsci_cgo_cse <= 1'b0;
      reg_line_buf1_rsci_cgo_cse <= 1'b0;
      ctrl_signal_triosy_obj_iswt0 <= 1'b0;
    end
    else if ( run_wen ) begin
      VCOL_stage_0_1 <= VCOL_VCOL_and_3_cse | VROW_y_or_cse;
      VCOL_stage_0_2 <= VCOL_VCOL_and_3_cse & (~ VROW_y_or_cse);
      VCOL_stage_0_3 <= VCOL_stage_0_2 & (~ VROW_y_or_cse);
      reg_dat_in_rsci_oswt_cse <= or_dcpl_6 & VCOL_stage_0_1 & (~ operator_10_false_acc_itm_10_1)
          & (~ operator_11_false_acc_itm_11_1) & (fsm_output[1]);
      reg_dat_out_rsci_oswt_cse <= VCOL_stage_0_2 & VCOL_if_4_VCOL_if_4_and_itm_1
          & (fsm_output[1]);
      reg_line_buf0_rsci_cgo_cse <= and_111_rmff;
      reg_line_buf1_rsci_cgo_cse <= and_123_rmff;
      ctrl_signal_triosy_obj_iswt0 <= VROW_equal_tmp & (fsm_output[2]);
    end
  end
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      VCOL_else_1_else_asn_itm_1 <= 10'b0000000000;
    end
    else if ( rst ) begin
      VCOL_else_1_else_asn_itm_1 <= 10'b0000000000;
    end
    else if ( run_wen & (~ mux_32_cse) & and_dcpl_4 ) begin
      VCOL_else_1_else_asn_itm_1 <= VROW_y_sva;
    end
  end
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      operator_11_false_2_operator_11_false_2_slc_VCOL_x_0_1_itm_1 <= 1'b0;
    end
    else if ( rst ) begin
      operator_11_false_2_operator_11_false_2_slc_VCOL_x_0_1_itm_1 <= 1'b0;
    end
    else if ( run_wen & and_dcpl_4 & or_dcpl_6 ) begin
      operator_11_false_2_operator_11_false_2_slc_VCOL_x_0_1_itm_1 <= VCOL_x_sva_mx1[0];
    end
  end
  always @(posedge clk) begin
    if ( (((mux_89_nl | (~ VCOL_else_2_else_else_aif_equal_tmp) | VCOL_land_1_lpi_3_dfm_1)
        & VCOL_stage_0_2) | (fsm_output[2]) | (fsm_output[0])) & run_wen ) begin
      pix_5_lpi_3 <= MUX_v_8_2_2(pix_2_lpi_3_dfm_8_mx1w0, pix_2_lpi_3, VROW_y_or_cse);
    end
  end
  always @(posedge clk) begin
    if ( ((~(mux_91_nl | VCOL_land_1_lpi_3_dfm_1)) | VCOL_land_lpi_3_dfm_1) & (fsm_output[1])
        & VCOL_stage_0_2 & run_wen ) begin
      pix_2_lpi_3 <= pix_2_lpi_3_dfm_8_mx1w0;
    end
  end
  always @(posedge clk) begin
    if ( rdbuf1_pix_and_cse & (mux_13_nl | (~ VCOL_stage_0_1)) ) begin
      rdbuf1_pix_lpi_3 <= line_buf1_rsci_q_d;
    end
  end
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      reg_VCOL_else_2_VCOL_else_2_nor_4_m1c_cse <= 1'b0;
      VCOL_else_2_else_else_and_7_m1c <= 1'b0;
      VCOL_else_2_else_else_else_else_and_5_tmp <= 1'b0;
    end
    else if ( rst ) begin
      reg_VCOL_else_2_VCOL_else_2_nor_4_m1c_cse <= 1'b0;
      VCOL_else_2_else_else_and_7_m1c <= 1'b0;
      VCOL_else_2_else_else_else_else_and_5_tmp <= 1'b0;
    end
    else if ( VCOL_else_2_and_26_cse ) begin
      reg_VCOL_else_2_VCOL_else_2_nor_4_m1c_cse <= VCOL_else_2_VCOL_else_2_nor_m1c_1;
      VCOL_else_2_else_else_and_7_m1c <= VCOL_else_2_else_else_and_3_m1c_1;
      VCOL_else_2_else_else_else_else_and_5_tmp <= VCOL_else_2_else_else_else_else_and_5_tmp_mx0w0;
    end
  end
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      operator_10_false_1_operator_10_false_1_and_cse_sva_1 <= 1'b0;
      reg_operator_11_false_6_nor_itm_1_cse <= 1'b0;
      VCOL_land_1_lpi_3_dfm_1 <= 1'b0;
      VCOL_if_4_VCOL_if_4_and_itm_1 <= 1'b0;
      VCOL_io_read_ctrl_signal_rsc_svs_1 <= 2'b00;
      VCOL_land_lpi_3_dfm_1 <= 1'b0;
      operator_11_false_4_operator_11_false_4_nor_cse_sva_1 <= 1'b0;
      VCOL_and_8_itm_1 <= 1'b0;
      VCOL_VCOL_oelse_operator_11_false_or_cse_sva_1 <= 1'b0;
    end
    else if ( rst ) begin
      operator_10_false_1_operator_10_false_1_and_cse_sva_1 <= 1'b0;
      reg_operator_11_false_6_nor_itm_1_cse <= 1'b0;
      VCOL_land_1_lpi_3_dfm_1 <= 1'b0;
      VCOL_if_4_VCOL_if_4_and_itm_1 <= 1'b0;
      VCOL_io_read_ctrl_signal_rsc_svs_1 <= 2'b00;
      VCOL_land_lpi_3_dfm_1 <= 1'b0;
      operator_11_false_4_operator_11_false_4_nor_cse_sva_1 <= 1'b0;
      VCOL_and_8_itm_1 <= 1'b0;
      VCOL_VCOL_oelse_operator_11_false_or_cse_sva_1 <= 1'b0;
    end
    else if ( operator_10_false_1_and_cse ) begin
      operator_10_false_1_operator_10_false_1_and_cse_sva_1 <= and_149_cse;
      reg_operator_11_false_6_nor_itm_1_cse <= operator_11_false_1_nor_tmp;
      VCOL_land_1_lpi_3_dfm_1 <= (VCOL_x_sva_mx1[0]) & operator_11_false_1_nor_tmp
          & and_149_cse;
      VCOL_if_4_VCOL_if_4_and_itm_1 <= VCOL_VCOL_oelse_operator_11_false_or_tmp &
          VCOL_if_4_VCOL_if_4_or_cse;
      VCOL_io_read_ctrl_signal_rsc_svs_1 <= ctrl_signal_rsci_idat;
      VCOL_land_lpi_3_dfm_1 <= ~(operator_11_false_acc_itm_11_1 | operator_10_false_acc_itm_10_1);
      operator_11_false_4_operator_11_false_4_nor_cse_sva_1 <= operator_11_false_4_operator_11_false_4_nor_tmp;
      VCOL_and_8_itm_1 <= (VCOL_x_sva_mx1[0]) & (~ operator_11_false_1_nor_tmp);
      VCOL_VCOL_oelse_operator_11_false_or_cse_sva_1 <= VCOL_VCOL_oelse_operator_11_false_or_tmp;
    end
  end
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      pix_result_lpi_3_10_8 <= 3'b000;
      pix_result_lpi_3_7_1 <= 7'b0000000;
    end
    else if ( rst ) begin
      pix_result_lpi_3_10_8 <= 3'b000;
      pix_result_lpi_3_7_1 <= 7'b0000000;
    end
    else if ( and_212_cse ) begin
      pix_result_lpi_3_10_8 <= pix_result_lpi_3_dfm_10_1_mx1w0_9_7;
      pix_result_lpi_3_7_1 <= pix_result_lpi_3_dfm_10_1_mx1w0_6_0;
    end
  end
  always @(posedge clk) begin
    if ( mux_93_nl & (fsm_output[1]) & run_wen & VCOL_stage_0_2 ) begin
      pix_4_lpi_3 <= MUX_v_8_2_2(pix_4_lpi_3_dfm_mx1, pix_1_lpi_3_dfm_9, and_44_nl);
    end
  end
  always @(posedge clk) begin
    if ( rdbuf1_pix_and_cse & (mux_19_nl | (~ VCOL_stage_0_1)) ) begin
      rdbuf0_pix_lpi_3 <= line_buf0_rsci_q_d;
    end
  end
  always @(posedge clk) begin
    if ( mux_97_nl & VCOL_and_55_cse & (fsm_output[1]) ) begin
      pix_1_lpi_3 <= MUX_v_8_2_2(pix_4_lpi_3_dfm_mx1, pix_1_lpi_3_dfm_9, and_47_nl);
    end
  end
  always @(posedge clk) begin
    if ( VCOL_and_58_cse ) begin
      VCOL_VCOL_slc_pix_39_32_2_lpi_4 <= pix_4_lpi_3;
      VCOL_VCOL_slc_pix_63_56_lpi_4 <= pix_4_lpi_3_dfm;
    end
  end
  always @(posedge clk) begin
    if ( run_wen ) begin
      VCOL_VCOL_slc_pix_47_40_2_lpi_4 <= pix_2_lpi_3;
    end
  end
  always @(posedge clk) begin
    if ( pix_and_3_cse & ((~((~((ctrl_signal_rsci_idat==2'b11))) & VCOL_stage_0_1))
        | (VCOL_else_2_else_else_aif_equal_tmp & VCOL_stage_0_2)) ) begin
      pix_result_lpi_3_0 <= pix_result_lpi_3_dfm_0_mx1w0;
    end
  end
  always @(posedge clk) begin
    if ( run_wen & (pix_3_lpi_3_dfm_7_mx1c0 | pix_3_lpi_3_dfm_7_mx1c1 | and_dcpl_19)
        & (fsm_output[1]) & (mux_17_nl | (~ VCOL_stage_0_1)) ) begin
      pix_3_lpi_3_dfm_7 <= MUX1HOT_v_8_3_2(pix_4_lpi_3_dfm_mx1, pix_3_lpi_3_dfm_mx0,
          pix_3_lpi_3_dfm_7_1, {pix_3_lpi_3_dfm_7_mx1c0 , pix_3_lpi_3_dfm_7_mx1c1
          , and_dcpl_19});
    end
  end
  always @(posedge clk) begin
    if ( run_wen & (and_146_cse | and_dcpl_30) & (fsm_output[1]) & (~(mux_15_nl &
        VCOL_stage_0_1)) ) begin
      pix_4_lpi_3_dfm <= MUX_v_8_2_2((line_buf0_rsci_q_d[7:0]), pix_4_lpi_3, and_dcpl_30);
    end
  end
  always @(posedge clk) begin
    if ( pix_and_3_cse & (mux_16_nl | (~ VCOL_stage_0_1)) ) begin
      pix_5_lpi_3_dfm_5 <= MUX_v_8_2_2(pix_4_lpi_3_dfm_mx1, pix_5_lpi_3, and_68_nl);
    end
  end
  assign nand_18_nl = ~(VCOL_stage_0_2 & (~ mux_tmp_43));
  assign and_188_nl = operator_11_false_4_operator_11_false_4_nor_cse_sva_2 & or_239_cse;
  assign mux_60_nl = MUX_s_1_2_2(operator_11_false_4_operator_11_false_4_nor_cse_sva_2,
      and_188_nl, VCOL_stage_0_1);
  assign mux_61_nl = MUX_s_1_2_2(or_tmp_106, (~ mux_60_nl), VCOL_x_sva[0]);
  assign or_184_nl = (~ or_tmp_114) | operator_11_false_4_operator_11_false_4_nor_cse_sva_1;
  assign mux_55_nl = MUX_s_1_2_2(or_tmp_112, or_184_nl, VCOL_else_2_else_else_aif_equal_tmp);
  assign mux_56_nl = MUX_s_1_2_2(mux_55_nl, mux_tmp_43, VCOL_VCOL_oelse_operator_11_false_or_cse_sva_1);
  assign or_182_nl = VROW_equal_tmp | (~ operator_10_false_1_operator_10_false_1_and_cse_sva_1)
      | operator_11_false_4_operator_11_false_4_nor_cse_sva_1;
  assign mux_54_nl = MUX_s_1_2_2(or_tmp_112, or_182_nl, VCOL_else_2_else_else_aif_equal_tmp);
  assign mux_57_nl = MUX_s_1_2_2(mux_56_nl, mux_54_nl, reg_operator_11_false_6_nor_itm_1_cse);
  assign mux_58_nl = MUX_s_1_2_2(mux_tmp_49, mux_57_nl, VCOL_x_sva[0]);
  assign mux_59_nl = MUX_s_1_2_2(mux_58_nl, mux_tmp_43, VCOL_land_1_lpi_3_dfm_1);
  assign mux_62_nl = MUX_s_1_2_2(mux_61_nl, mux_59_nl, VCOL_stage_0_2);
  assign or_177_nl = VROW_equal_tmp | operator_11_false_4_operator_11_false_4_nor_cse_sva_1;
  assign mux_48_nl = MUX_s_1_2_2(mux_tmp_46, or_177_nl, VCOL_else_2_else_else_aif_equal_tmp);
  assign and_226_nl = (VCOL_x_sva[0]) & reg_operator_11_false_6_nor_itm_1_cse;
  assign mux_51_nl = MUX_s_1_2_2(mux_tmp_49, mux_48_nl, and_226_nl);
  assign mux_52_nl = MUX_s_1_2_2(mux_51_nl, mux_tmp_43, VCOL_land_1_lpi_3_dfm_1);
  assign mux_53_nl = MUX_s_1_2_2((~ operator_11_false_4_operator_11_false_4_nor_cse_sva_2),
      mux_52_nl, VCOL_stage_0_2);
  assign mux_63_nl = MUX_s_1_2_2(mux_62_nl, mux_53_nl, or_176_cse);
  assign mux_45_nl = MUX_s_1_2_2(or_tmp_106, mux_tmp_43, VCOL_stage_0_2);
  assign mux_64_nl = MUX_s_1_2_2(mux_63_nl, mux_45_nl, VCOL_asn_21_itm_1);
  assign mux_65_nl = MUX_s_1_2_2(nand_18_nl, mux_64_nl, VCOL_stage_0_3);
  assign and_227_nl = or_239_cse & (VCOL_x_sva[0]) & VCOL_stage_0_1 & VCOL_stage_0_3
      & (~ VCOL_asn_21_itm_1);
  assign mux_nl = MUX_s_1_2_2(or_tmp_121, VCOL_stage_0_1, nor_63_cse);
  assign mux_74_nl = MUX_s_1_2_2(mux_tmp_67, mux_nl, VCOL_x_sva[0]);
  assign nor_71_nl = ~(VCOL_VCOL_oelse_operator_11_false_or_cse_sva_1 | (~ or_dcpl_31));
  assign mux_71_nl = MUX_s_1_2_2(nor_71_nl, or_dcpl_31, reg_operator_11_false_6_nor_itm_1_cse);
  assign and_194_nl = reg_operator_11_false_6_nor_itm_1_cse & or_dcpl_31;
  assign mux_72_nl = MUX_s_1_2_2(mux_71_nl, and_194_nl, VROW_equal_tmp);
  assign and_193_nl = VROW_equal_tmp & reg_operator_11_false_6_nor_itm_1_cse & or_dcpl_31;
  assign mux_73_nl = MUX_s_1_2_2(mux_72_nl, and_193_nl, operator_10_false_1_operator_10_false_1_and_cse_sva_1);
  assign and_195_nl = (VCOL_x_sva[0]) & mux_73_nl;
  assign mux_75_nl = MUX_s_1_2_2(mux_74_nl, and_195_nl, VCOL_else_2_else_else_aif_equal_tmp);
  assign mux_76_nl = MUX_s_1_2_2((~ mux_75_nl), or_196_cse, or_tmp_117);
  assign mux_77_nl = MUX_s_1_2_2(and_227_nl, mux_76_nl, VCOL_stage_0_2);
  assign mux_100_nl = MUX_s_1_2_2(or_tmp_121, VCOL_stage_0_1, nor_63_cse);
  assign or_188_nl = (~ operator_10_false_1_operator_10_false_1_and_cse_sva_1) |
      VROW_equal_tmp;
  assign mux_66_nl = MUX_s_1_2_2(VCOL_stage_0_1, mux_100_nl, or_188_nl);
  assign mux_68_nl = MUX_s_1_2_2(mux_tmp_67, mux_66_nl, VCOL_x_sva[0]);
  assign and_191_nl = (VCOL_x_sva[0]) & VROW_equal_tmp & reg_operator_11_false_6_nor_itm_1_cse
      & or_dcpl_31;
  assign mux_69_nl = MUX_s_1_2_2(mux_68_nl, and_191_nl, VCOL_else_2_else_else_aif_equal_tmp);
  assign mux_70_nl = MUX_s_1_2_2((~ mux_69_nl), or_196_cse, or_tmp_117);
  assign and_192_nl = VCOL_stage_0_2 & mux_70_nl;
  assign mux_78_nl = MUX_s_1_2_2(mux_77_nl, and_192_nl, or_176_cse);
  assign and_199_nl = or_205_cse & or_178_cse;
  assign mux_82_nl = MUX_s_1_2_2(and_tmp_9, and_199_nl, nor_66_cse);
  assign or_204_nl = VCOL_land_1_lpi_3_dfm_1 | (~ operator_11_false_4_operator_11_false_4_nor_cse_sva_2)
      | (~ VCOL_stage_0_3) | VCOL_asn_21_itm_1;
  assign mux_83_nl = MUX_s_1_2_2(mux_82_nl, or_178_cse, or_204_nl);
  assign mux_84_nl = MUX_s_1_2_2(or_tmp_134, mux_83_nl, VCOL_x_sva_2[0]);
  assign mux_85_nl = MUX_s_1_2_2(mux_84_nl, and_tmp_9, or_203_cse);
  assign mux_79_nl = MUX_s_1_2_2(and_tmp_9, operator_11_false_4_operator_11_false_4_nor_cse_sva_1,
      VCOL_x_sva_2[0]);
  assign mux_81_nl = MUX_s_1_2_2(or_tmp_134, mux_79_nl, or_203_cse);
  assign mux_86_nl = MUX_s_1_2_2(mux_85_nl, mux_81_nl, or_239_cse);
  assign mux_87_nl = MUX_s_1_2_2(mux_86_nl, operator_11_false_4_operator_11_false_4_nor_cse_sva_1,
      or_196_cse);
  assign not_201_nl = ~ VROW_y_or_cse;
  assign VROW_y_not_2_nl = ~ (fsm_output[0]);
  assign VCOL_if_4_nor_1_nl = ~(MUX_v_7_2_2(pix_result_lpi_3_dfm_10_1_mx1w0_6_0,
      7'b1111111, operator_11_true_acc_itm_2_1));
  assign nor_72_nl = ~((~ VROW_equal_tmp) | operator_10_false_1_operator_10_false_1_and_cse_sva_1);
  assign nand_20_nl = ~((~(VROW_equal_tmp & reg_operator_11_false_6_nor_itm_1_cse))
      & operator_10_false_1_operator_10_false_1_and_cse_sva_1);
  assign and_201_nl = VROW_equal_tmp & (reg_operator_11_false_6_nor_itm_1_cse | (~
      operator_10_false_1_operator_10_false_1_and_cse_sva_1));
  assign mux_88_nl = MUX_s_1_2_2(nand_20_nl, and_201_nl, or_176_cse);
  assign mux_89_nl = MUX_s_1_2_2(nor_72_nl, mux_88_nl, VCOL_x_sva[0]);
  assign nand_22_nl = ~(or_tmp_114 & VCOL_else_2_else_else_aif_equal_tmp);
  assign nor_73_nl = ~(VROW_equal_tmp | and_232_cse);
  assign mux_90_nl = MUX_s_1_2_2(nand_22_nl, nor_73_nl, reg_operator_11_false_6_nor_itm_1_cse);
  assign nor_74_nl = ~(VROW_equal_tmp | VCOL_else_2_else_else_aif_equal_tmp);
  assign or_216_nl = (VCOL_x_sva!=11'b00000000001);
  assign mux_91_nl = MUX_s_1_2_2(mux_90_nl, nor_74_nl, or_216_nl);
  assign mux_12_nl = MUX_s_1_2_2(or_29_cse, or_tmp_17, VCOL_VCOL_oelse_operator_11_false_or_tmp);
  assign or_27_nl = VCOL_else_2_else_else_aif_equal_tmp | nor_28_cse;
  assign mux_11_nl = MUX_s_1_2_2(or_27_nl, or_tmp_14, VCOL_VCOL_oelse_operator_11_false_or_tmp);
  assign mux_13_nl = MUX_s_1_2_2((~ mux_12_nl), mux_11_nl, VCOL_stage_0_2);
  assign and_44_nl = or_dcpl_42 & and_dcpl_30;
  assign or_230_nl = (~ VCOL_stage_0_1) | (VCOL_x_sva_2!=11'b00000000000);
  assign mux_92_nl = MUX_s_1_2_2(nor_75_cse, reg_operator_11_false_6_nor_itm_1_cse,
      VROW_equal_tmp);
  assign or_229_nl = or_tmp_117 | ((VCOL_x_sva[0]) & mux_92_nl);
  assign mux_93_nl = MUX_s_1_2_2(or_230_nl, or_229_nl, VCOL_else_2_else_else_aif_equal_tmp);
  assign mux_19_nl = MUX_s_1_2_2((~ or_tmp_17), or_tmp_14, VCOL_stage_0_2);
  assign and_47_nl = or_dcpl_42 & VCOL_stage_0_2;
  assign nor_77_nl = ~((~ VCOL_else_2_else_else_aif_equal_tmp) | VCOL_land_1_lpi_3_dfm_1);
  assign mux_95_nl = MUX_s_1_2_2(or_tmp_153, nor_77_nl, reg_operator_11_false_6_nor_itm_1_cse);
  assign nor_78_nl = ~(nor_75_cse | (~ VCOL_else_2_else_else_aif_equal_tmp) | VCOL_land_1_lpi_3_dfm_1);
  assign nor_79_nl = ~(reg_operator_11_false_6_nor_itm_1_cse | (~ VCOL_else_2_else_else_aif_equal_tmp)
      | VCOL_land_1_lpi_3_dfm_1);
  assign mux_94_nl = MUX_s_1_2_2(nor_78_nl, nor_79_nl, VROW_equal_tmp);
  assign mux_96_nl = MUX_s_1_2_2(mux_95_nl, mux_94_nl, VCOL_x_sva[0]);
  assign or_231_nl = operator_11_false_4_operator_11_false_4_nor_cse_sva_1 | VCOL_and_8_itm_1;
  assign mux_97_nl = MUX_s_1_2_2(mux_96_nl, or_tmp_153, or_231_nl);
  assign mux_17_nl = MUX_s_1_2_2(not_tmp_22, VCOL_else_2_else_else_aif_equal_tmp,
      VCOL_stage_0_2);
  assign or_159_nl = and_147_cse | mux_tmp_14;
  assign nor_31_nl = ~(VCOL_else_2_else_else_aif_equal_tmp | (~(and_152_cse | mux_tmp_14)));
  assign mux_15_nl = MUX_s_1_2_2(or_159_nl, nor_31_nl, VCOL_stage_0_2);
  assign and_68_nl = or_dcpl_61 & VCOL_stage_0_2;
  assign or_36_nl = VCOL_else_2_else_else_aif_equal_tmp | (~(and_152_cse | (ctrl_signal_rsci_idat!=2'b10)));
  assign mux_16_nl = MUX_s_1_2_2(not_tmp_22, or_36_nl, VCOL_stage_0_2);
  assign operator_8_false_1_mux_12_nl = MUX_v_8_2_2((~ VCOL_mux_13_itm), (~ pix_0_lpi_3_dfm_8_mx2w1),
      and_170_cse);
  assign operator_8_false_1_mux_13_nl = MUX_v_8_2_2((~ pix_3_lpi_3_dfm_7_1_mx0),
      (~ pix_2_lpi_3_dfm_8_mx1w0), and_170_cse);
  assign nl_acc_2_nl = conv_u2u_9_10({operator_8_false_1_mux_12_nl , 1'b1}) + conv_u2u_9_10({operator_8_false_1_mux_13_nl
      , 1'b1});
  assign acc_2_nl = nl_acc_2_nl[9:0];
  assign nl_operator_8_false_11_acc_5_nl = conv_u2u_8_9(pix_6_lpi_3_dfm_7) + conv_u2u_8_9(pix_8_lpi_3_dfm_6)
      + 9'b000000001;
  assign operator_8_false_11_acc_5_nl = nl_operator_8_false_11_acc_5_nl[8:0];
  assign operator_8_false_1_mux_11_nl = MUX_v_9_2_2(z_out_3, operator_8_false_11_acc_5_nl,
      and_170_cse);
  assign nl_acc_1_nl = conv_u2u_10_11({(readslicef_10_9_1(acc_2_nl)) , 1'b1}) + conv_u2u_10_11({operator_8_false_1_mux_11_nl
      , 1'b1});
  assign acc_1_nl = nl_acc_1_nl[10:0];
  assign operator_8_false_1_operator_8_false_1_nand_2_nl = ~(or_tmp_95 & (~((VCOL_io_read_ctrl_signal_rsc_svs_1[0])
      & (fsm_output[1]))));
  assign operator_8_false_1_mux_10_nl = MUX_v_8_2_2(pix_4_lpi_3_dfm_mx1, (z_out_3[8:1]),
      or_tmp_95);
  assign operator_8_false_1_operator_8_false_1_and_1_nl = (z_out_3[0]) & or_tmp_95;
  assign nl_acc_nl = ({(readslicef_11_10_1(acc_1_nl)) , operator_8_false_1_operator_8_false_1_nand_2_nl})
      + ({operator_8_false_1_mux_10_nl , operator_8_false_1_operator_8_false_1_and_1_nl
      , or_tmp_95 , 1'b1});
  assign acc_nl = nl_acc_nl[10:0];
  assign z_out = readslicef_11_10_1(acc_nl);
  assign operator_8_false_1_mux_14_nl = MUX_v_8_2_2((~ pix_5_lpi_3_dfm_5_mx1), (~
      VCOL_mux_13_itm), and_170_cse);
  assign operator_8_false_1_operator_8_false_1_nand_3_nl = ~(and_170_cse & (~((~
      (VCOL_io_read_ctrl_signal_rsc_svs_1[1])) & (fsm_output[1]))));
  assign operator_8_false_1_mux_15_nl = MUX_v_8_2_2((~ pix_7_lpi_3_dfm_4_mx0), pix_7_lpi_3_dfm_4_mx0,
      and_170_cse);
  assign nl_acc_3_nl = conv_u2u_9_10({operator_8_false_1_mux_14_nl , operator_8_false_1_operator_8_false_1_nand_3_nl})
      + conv_u2u_9_10({operator_8_false_1_mux_15_nl , 1'b1});
  assign acc_3_nl = nl_acc_3_nl[9:0];
  assign z_out_3 = readslicef_10_9_1(acc_3_nl);
  assign VROW_or_2_nl = (mux_tmp & (fsm_output[1])) | or_tmp_104;
  assign VROW_VROW_mux_1_nl = MUX_v_10_2_2(VROW_y_sva, (VCOL_x_sva_mx1[10:1]), VROW_or_2_nl);
  assign nl_z_out_4 = VROW_VROW_mux_1_nl + conv_s2u_2_10({or_tmp_104 , 1'b1});
  assign z_out_4 = nl_z_out_4[9:0];

  function automatic  MUX1HOT_s_1_3_2;
    input  input_2;
    input  input_1;
    input  input_0;
    input [2:0] sel;
    reg  result;
  begin
    result = input_0 & sel[0];
    result = result | (input_1 & sel[1]);
    result = result | (input_2 & sel[2]);
    MUX1HOT_s_1_3_2 = result;
  end
  endfunction


  function automatic [2:0] MUX1HOT_v_3_3_2;
    input [2:0] input_2;
    input [2:0] input_1;
    input [2:0] input_0;
    input [2:0] sel;
    reg [2:0] result;
  begin
    result = input_0 & {3{sel[0]}};
    result = result | (input_1 & {3{sel[1]}});
    result = result | (input_2 & {3{sel[2]}});
    MUX1HOT_v_3_3_2 = result;
  end
  endfunction


  function automatic [6:0] MUX1HOT_v_7_4_2;
    input [6:0] input_3;
    input [6:0] input_2;
    input [6:0] input_1;
    input [6:0] input_0;
    input [3:0] sel;
    reg [6:0] result;
  begin
    result = input_0 & {7{sel[0]}};
    result = result | (input_1 & {7{sel[1]}});
    result = result | (input_2 & {7{sel[2]}});
    result = result | (input_3 & {7{sel[3]}});
    MUX1HOT_v_7_4_2 = result;
  end
  endfunction


  function automatic [7:0] MUX1HOT_v_8_3_2;
    input [7:0] input_2;
    input [7:0] input_1;
    input [7:0] input_0;
    input [2:0] sel;
    reg [7:0] result;
  begin
    result = input_0 & {8{sel[0]}};
    result = result | (input_1 & {8{sel[1]}});
    result = result | (input_2 & {8{sel[2]}});
    MUX1HOT_v_8_3_2 = result;
  end
  endfunction


  function automatic [7:0] MUX1HOT_v_8_4_2;
    input [7:0] input_3;
    input [7:0] input_2;
    input [7:0] input_1;
    input [7:0] input_0;
    input [3:0] sel;
    reg [7:0] result;
  begin
    result = input_0 & {8{sel[0]}};
    result = result | (input_1 & {8{sel[1]}});
    result = result | (input_2 & {8{sel[2]}});
    result = result | (input_3 & {8{sel[3]}});
    MUX1HOT_v_8_4_2 = result;
  end
  endfunction


  function automatic [7:0] MUX1HOT_v_8_5_2;
    input [7:0] input_4;
    input [7:0] input_3;
    input [7:0] input_2;
    input [7:0] input_1;
    input [7:0] input_0;
    input [4:0] sel;
    reg [7:0] result;
  begin
    result = input_0 & {8{sel[0]}};
    result = result | (input_1 & {8{sel[1]}});
    result = result | (input_2 & {8{sel[2]}});
    result = result | (input_3 & {8{sel[3]}});
    result = result | (input_4 & {8{sel[4]}});
    MUX1HOT_v_8_5_2 = result;
  end
  endfunction


  function automatic [7:0] MUX1HOT_v_8_8_2;
    input [7:0] input_7;
    input [7:0] input_6;
    input [7:0] input_5;
    input [7:0] input_4;
    input [7:0] input_3;
    input [7:0] input_2;
    input [7:0] input_1;
    input [7:0] input_0;
    input [7:0] sel;
    reg [7:0] result;
  begin
    result = input_0 & {8{sel[0]}};
    result = result | (input_1 & {8{sel[1]}});
    result = result | (input_2 & {8{sel[2]}});
    result = result | (input_3 & {8{sel[3]}});
    result = result | (input_4 & {8{sel[4]}});
    result = result | (input_5 & {8{sel[5]}});
    result = result | (input_6 & {8{sel[6]}});
    result = result | (input_7 & {8{sel[7]}});
    MUX1HOT_v_8_8_2 = result;
  end
  endfunction


  function automatic  MUX_s_1_2_2;
    input  input_0;
    input  input_1;
    input  sel;
    reg  result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_s_1_2_2 = result;
  end
  endfunction


  function automatic [9:0] MUX_v_10_2_2;
    input [9:0] input_0;
    input [9:0] input_1;
    input  sel;
    reg [9:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_10_2_2 = result;
  end
  endfunction


  function automatic [10:0] MUX_v_11_2_2;
    input [10:0] input_0;
    input [10:0] input_1;
    input  sel;
    reg [10:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_11_2_2 = result;
  end
  endfunction


  function automatic [2:0] MUX_v_3_2_2;
    input [2:0] input_0;
    input [2:0] input_1;
    input  sel;
    reg [2:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_3_2_2 = result;
  end
  endfunction


  function automatic [6:0] MUX_v_7_2_2;
    input [6:0] input_0;
    input [6:0] input_1;
    input  sel;
    reg [6:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_7_2_2 = result;
  end
  endfunction


  function automatic [7:0] MUX_v_8_2_2;
    input [7:0] input_0;
    input [7:0] input_1;
    input  sel;
    reg [7:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_8_2_2 = result;
  end
  endfunction


  function automatic [8:0] MUX_v_9_2_2;
    input [8:0] input_0;
    input [8:0] input_1;
    input  sel;
    reg [8:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_9_2_2 = result;
  end
  endfunction


  function automatic [8:0] readslicef_10_9_1;
    input [9:0] vector;
    reg [9:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_10_9_1 = tmp[8:0];
  end
  endfunction


  function automatic [9:0] readslicef_11_10_1;
    input [10:0] vector;
    reg [10:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_11_10_1 = tmp[9:0];
  end
  endfunction


  function automatic [0:0] readslicef_11_1_10;
    input [10:0] vector;
    reg [10:0] tmp;
  begin
    tmp = vector >> 10;
    readslicef_11_1_10 = tmp[0:0];
  end
  endfunction


  function automatic [0:0] readslicef_12_1_11;
    input [11:0] vector;
    reg [11:0] tmp;
  begin
    tmp = vector >> 11;
    readslicef_12_1_11 = tmp[0:0];
  end
  endfunction


  function automatic [0:0] readslicef_3_1_2;
    input [2:0] vector;
    reg [2:0] tmp;
  begin
    tmp = vector >> 2;
    readslicef_3_1_2 = tmp[0:0];
  end
  endfunction


  function automatic [10:0] conv_s2s_10_11 ;
    input [9:0]  vector ;
  begin
    conv_s2s_10_11 = {vector[9], vector};
  end
  endfunction


  function automatic [9:0] conv_s2u_2_10 ;
    input [1:0]  vector ;
  begin
    conv_s2u_2_10 = {{8{vector[1]}}, vector};
  end
  endfunction


  function automatic [10:0] conv_u2s_10_11 ;
    input [9:0]  vector ;
  begin
    conv_u2s_10_11 =  {1'b0, vector};
  end
  endfunction


  function automatic [11:0] conv_u2s_11_12 ;
    input [10:0]  vector ;
  begin
    conv_u2s_11_12 =  {1'b0, vector};
  end
  endfunction


  function automatic [8:0] conv_u2u_8_9 ;
    input [7:0]  vector ;
  begin
    conv_u2u_8_9 = {1'b0, vector};
  end
  endfunction


  function automatic [9:0] conv_u2u_9_10 ;
    input [8:0]  vector ;
  begin
    conv_u2u_9_10 = {1'b0, vector};
  end
  endfunction


  function automatic [10:0] conv_u2u_10_11 ;
    input [9:0]  vector ;
  begin
    conv_u2u_10_11 = {1'b0, vector};
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_Filter
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_Filter (
  clk, rst, arst_n, dat_in_rsc_dat, dat_in_rsc_vld, dat_in_rsc_rdy, widthIn, heightIn,
      dat_out_rsc_dat, dat_out_rsc_vld, dat_out_rsc_rdy, ctrl_signal_rsc_dat, ctrl_signal_triosy_lz,
      line_buf0_rsc_en, line_buf0_rsc_q, line_buf0_rsc_we, line_buf0_rsc_d, line_buf0_rsc_adr,
      line_buf1_rsc_en, line_buf1_rsc_q, line_buf1_rsc_we, line_buf1_rsc_d, line_buf1_rsc_adr
);
  input clk;
  input rst;
  input arst_n;
  input [7:0] dat_in_rsc_dat;
  input dat_in_rsc_vld;
  output dat_in_rsc_rdy;
  input [10:0] widthIn;
  input [9:0] heightIn;
  output [7:0] dat_out_rsc_dat;
  output dat_out_rsc_vld;
  input dat_out_rsc_rdy;
  input [1:0] ctrl_signal_rsc_dat;
  output ctrl_signal_triosy_lz;
  output line_buf0_rsc_en;
  input [15:0] line_buf0_rsc_q;
  output line_buf0_rsc_we;
  output [15:0] line_buf0_rsc_d;
  output [9:0] line_buf0_rsc_adr;
  output line_buf1_rsc_en;
  input [15:0] line_buf1_rsc_q;
  output line_buf1_rsc_we;
  output [15:0] line_buf1_rsc_d;
  output [9:0] line_buf1_rsc_adr;


  // Interconnect Declarations
  wire [15:0] line_buf0_rsci_d_d;
  wire line_buf0_rsci_en_d;
  wire [15:0] line_buf0_rsci_q_d;
  wire [15:0] line_buf1_rsci_d_d;
  wire line_buf1_rsci_en_d;
  wire [15:0] line_buf1_rsci_q_d;
  wire [9:0] line_buf0_rsci_adr_d_iff;
  wire line_buf0_rsci_we_d_iff;
  wire line_buf0_rsci_port_0_rw_ram_ir_internal_RMASK_B_d_iff;
  wire line_buf1_rsci_we_d_iff;


  // Interconnect Declarations for Component Instantiations 
  EdgeDetect_IP_EdgeDetect_Filter_ccs_sample_mem_ccs_ram_sync_singleport_rwport_en_6_16_10_963_963_16_5_gen
      line_buf0_rsci (
      .en(line_buf0_rsc_en),
      .q(line_buf0_rsc_q),
      .we(line_buf0_rsc_we),
      .d(line_buf0_rsc_d),
      .adr(line_buf0_rsc_adr),
      .adr_d(line_buf0_rsci_adr_d_iff),
      .d_d(line_buf0_rsci_d_d),
      .en_d(line_buf0_rsci_en_d),
      .we_d(line_buf0_rsci_we_d_iff),
      .q_d(line_buf0_rsci_q_d),
      .port_0_rw_ram_ir_internal_RMASK_B_d(line_buf0_rsci_port_0_rw_ram_ir_internal_RMASK_B_d_iff),
      .port_0_rw_ram_ir_internal_WMASK_B_d(line_buf0_rsci_we_d_iff)
    );
  EdgeDetect_IP_EdgeDetect_Filter_ccs_sample_mem_ccs_ram_sync_singleport_rwport_en_7_16_10_963_963_16_5_gen
      line_buf1_rsci (
      .en(line_buf1_rsc_en),
      .q(line_buf1_rsc_q),
      .we(line_buf1_rsc_we),
      .d(line_buf1_rsc_d),
      .adr(line_buf1_rsc_adr),
      .adr_d(line_buf0_rsci_adr_d_iff),
      .d_d(line_buf1_rsci_d_d),
      .en_d(line_buf1_rsci_en_d),
      .we_d(line_buf1_rsci_we_d_iff),
      .q_d(line_buf1_rsci_q_d),
      .port_0_rw_ram_ir_internal_RMASK_B_d(line_buf0_rsci_port_0_rw_ram_ir_internal_RMASK_B_d_iff),
      .port_0_rw_ram_ir_internal_WMASK_B_d(line_buf1_rsci_we_d_iff)
    );
  EdgeDetect_IP_EdgeDetect_Filter_run EdgeDetect_IP_EdgeDetect_Filter_run_inst (
      .clk(clk),
      .rst(rst),
      .arst_n(arst_n),
      .dat_in_rsc_dat(dat_in_rsc_dat),
      .dat_in_rsc_vld(dat_in_rsc_vld),
      .dat_in_rsc_rdy(dat_in_rsc_rdy),
      .widthIn(widthIn),
      .heightIn(heightIn),
      .dat_out_rsc_dat(dat_out_rsc_dat),
      .dat_out_rsc_vld(dat_out_rsc_vld),
      .dat_out_rsc_rdy(dat_out_rsc_rdy),
      .ctrl_signal_rsc_dat(ctrl_signal_rsc_dat),
      .ctrl_signal_triosy_lz(ctrl_signal_triosy_lz),
      .line_buf0_rsci_d_d(line_buf0_rsci_d_d),
      .line_buf0_rsci_en_d(line_buf0_rsci_en_d),
      .line_buf0_rsci_q_d(line_buf0_rsci_q_d),
      .line_buf1_rsci_d_d(line_buf1_rsci_d_d),
      .line_buf1_rsci_en_d(line_buf1_rsci_en_d),
      .line_buf1_rsci_q_d(line_buf1_rsci_q_d),
      .line_buf0_rsci_adr_d_pff(line_buf0_rsci_adr_d_iff),
      .line_buf0_rsci_we_d_pff(line_buf0_rsci_we_d_iff),
      .line_buf0_rsci_port_0_rw_ram_ir_internal_RMASK_B_d_pff(line_buf0_rsci_port_0_rw_ram_ir_internal_RMASK_B_d_iff),
      .line_buf1_rsci_we_d_pff(line_buf1_rsci_we_d_iff)
    );
endmodule




//------> ../EdgeDetect_IP_Denoise_IP.v1/rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    2024.1/1091966 Production Release
//  HLS Date:       Wed Feb 14 09:07:18 PST 2024
// 
//  Generated by:   m111061631@ws41
//  Generated date: Fri Jun  7 09:19:04 2024
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_Denoise_IP_ccs_sample_mem_ccs_ram_sync_singleport_rwport_en_7_16_10_963_963_16_5_gen
// ------------------------------------------------------------------


module EdgeDetect_IP_Denoise_IP_ccs_sample_mem_ccs_ram_sync_singleport_rwport_en_7_16_10_963_963_16_5_gen
    (
  en, q, we, d, adr, adr_d, d_d, en_d, we_d, q_d, port_0_rw_ram_ir_internal_RMASK_B_d,
      port_0_rw_ram_ir_internal_WMASK_B_d
);
  output en;
  input [15:0] q;
  output we;
  output [15:0] d;
  output [9:0] adr;
  input [9:0] adr_d;
  input [15:0] d_d;
  input en_d;
  input we_d;
  output [15:0] q_d;
  input port_0_rw_ram_ir_internal_RMASK_B_d;
  input port_0_rw_ram_ir_internal_WMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign en = (en_d);
  assign q_d = q;
  assign we = (port_0_rw_ram_ir_internal_WMASK_B_d);
  assign d = (d_d);
  assign adr = (adr_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_Denoise_IP_ccs_sample_mem_ccs_ram_sync_singleport_rwport_en_6_16_10_963_963_16_5_gen
// ------------------------------------------------------------------


module EdgeDetect_IP_Denoise_IP_ccs_sample_mem_ccs_ram_sync_singleport_rwport_en_6_16_10_963_963_16_5_gen
    (
  en, q, we, d, adr, adr_d, d_d, en_d, we_d, q_d, port_0_rw_ram_ir_internal_RMASK_B_d,
      port_0_rw_ram_ir_internal_WMASK_B_d
);
  output en;
  input [15:0] q;
  output we;
  output [15:0] d;
  output [9:0] adr;
  input [9:0] adr_d;
  input [15:0] d_d;
  input en_d;
  input we_d;
  output [15:0] q_d;
  input port_0_rw_ram_ir_internal_RMASK_B_d;
  input port_0_rw_ram_ir_internal_WMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign en = (en_d);
  assign q_d = q;
  assign we = (port_0_rw_ram_ir_internal_WMASK_B_d);
  assign d = (d_d);
  assign adr = (adr_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_Denoise_IP_run_run_fsm
//  FSM Module
// ------------------------------------------------------------------


module EdgeDetect_IP_Denoise_IP_run_run_fsm (
  clk, rst, arst_n, run_wen, fsm_output, VCOL_C_0_tr0, VROW_C_0_tr0
);
  input clk;
  input rst;
  input arst_n;
  input run_wen;
  output [3:0] fsm_output;
  reg [3:0] fsm_output;
  input VCOL_C_0_tr0;
  input VROW_C_0_tr0;


  // FSM State Type Declaration for EdgeDetect_IP_Denoise_IP_run_run_fsm_1
  parameter
    main_C_0 = 2'd0,
    VCOL_C_0 = 2'd1,
    VROW_C_0 = 2'd2,
    main_C_1 = 2'd3;

  reg [1:0] state_var;
  reg [1:0] state_var_NS;


  // Interconnect Declarations for Component Instantiations 
  always @(*)
  begin : EdgeDetect_IP_Denoise_IP_run_run_fsm_1
    case (state_var)
      VCOL_C_0 : begin
        fsm_output = 4'b0010;
        if ( VCOL_C_0_tr0 ) begin
          state_var_NS = VROW_C_0;
        end
        else begin
          state_var_NS = VCOL_C_0;
        end
      end
      VROW_C_0 : begin
        fsm_output = 4'b0100;
        if ( VROW_C_0_tr0 ) begin
          state_var_NS = main_C_1;
        end
        else begin
          state_var_NS = VCOL_C_0;
        end
      end
      main_C_1 : begin
        fsm_output = 4'b1000;
        state_var_NS = main_C_0;
      end
      // main_C_0
      default : begin
        fsm_output = 4'b0001;
        state_var_NS = VCOL_C_0;
      end
    endcase
  end

  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      state_var <= main_C_0;
    end
    else if ( rst ) begin
      state_var <= main_C_0;
    end
    else if ( run_wen ) begin
      state_var <= state_var_NS;
    end
  end

endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_Denoise_IP_run_staller
// ------------------------------------------------------------------


module EdgeDetect_IP_Denoise_IP_run_staller (
  clk, rst, arst_n, run_wen, run_wten, dat_in_rsci_wen_comp, dat_out_rsci_wen_comp
);
  input clk;
  input rst;
  input arst_n;
  output run_wen;
  output run_wten;
  reg run_wten;
  input dat_in_rsci_wen_comp;
  input dat_out_rsci_wen_comp;



  // Interconnect Declarations for Component Instantiations 
  assign run_wen = dat_in_rsci_wen_comp & dat_out_rsci_wen_comp;
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      run_wten <= 1'b0;
    end
    else if ( rst ) begin
      run_wten <= 1'b0;
    end
    else begin
      run_wten <= ~ run_wen;
    end
  end
endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_Denoise_IP_run_ctrl_signal_triosy_obj_ctrl_signal_triosy_wait_ctrl
// ------------------------------------------------------------------


module EdgeDetect_IP_Denoise_IP_run_ctrl_signal_triosy_obj_ctrl_signal_triosy_wait_ctrl
    (
  run_wten, ctrl_signal_triosy_obj_iswt0, ctrl_signal_triosy_obj_biwt
);
  input run_wten;
  input ctrl_signal_triosy_obj_iswt0;
  output ctrl_signal_triosy_obj_biwt;



  // Interconnect Declarations for Component Instantiations 
  assign ctrl_signal_triosy_obj_biwt = (~ run_wten) & ctrl_signal_triosy_obj_iswt0;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_Denoise_IP_run_wait_dp
// ------------------------------------------------------------------


module EdgeDetect_IP_Denoise_IP_run_wait_dp (
  line_buf0_rsci_en_d, line_buf1_rsci_en_d, run_wen, line_buf0_rsci_cgo, line_buf0_rsci_cgo_ir_unreg,
      line_buf1_rsci_cgo, line_buf1_rsci_cgo_ir_unreg
);
  output line_buf0_rsci_en_d;
  output line_buf1_rsci_en_d;
  input run_wen;
  input line_buf0_rsci_cgo;
  input line_buf0_rsci_cgo_ir_unreg;
  input line_buf1_rsci_cgo;
  input line_buf1_rsci_cgo_ir_unreg;



  // Interconnect Declarations for Component Instantiations 
  assign line_buf0_rsci_en_d = run_wen & (line_buf0_rsci_cgo | line_buf0_rsci_cgo_ir_unreg);
  assign line_buf1_rsci_en_d = run_wen & (line_buf1_rsci_cgo | line_buf1_rsci_cgo_ir_unreg);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_Denoise_IP_run_dat_out_rsci_dat_out_wait_dp
// ------------------------------------------------------------------


module EdgeDetect_IP_Denoise_IP_run_dat_out_rsci_dat_out_wait_dp (
  clk, rst, arst_n, dat_out_rsci_oswt, dat_out_rsci_wen_comp, dat_out_rsci_biwt,
      dat_out_rsci_bdwt, dat_out_rsci_bcwt
);
  input clk;
  input rst;
  input arst_n;
  input dat_out_rsci_oswt;
  output dat_out_rsci_wen_comp;
  input dat_out_rsci_biwt;
  input dat_out_rsci_bdwt;
  output dat_out_rsci_bcwt;
  reg dat_out_rsci_bcwt;



  // Interconnect Declarations for Component Instantiations 
  assign dat_out_rsci_wen_comp = (~ dat_out_rsci_oswt) | dat_out_rsci_biwt | dat_out_rsci_bcwt;
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      dat_out_rsci_bcwt <= 1'b0;
    end
    else if ( rst ) begin
      dat_out_rsci_bcwt <= 1'b0;
    end
    else begin
      dat_out_rsci_bcwt <= ~((~(dat_out_rsci_bcwt | dat_out_rsci_biwt)) | dat_out_rsci_bdwt);
    end
  end
endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_Denoise_IP_run_dat_out_rsci_dat_out_wait_ctrl
// ------------------------------------------------------------------


module EdgeDetect_IP_Denoise_IP_run_dat_out_rsci_dat_out_wait_ctrl (
  run_wen, dat_out_rsci_oswt, dat_out_rsci_biwt, dat_out_rsci_bdwt, dat_out_rsci_bcwt,
      dat_out_rsci_irdy, dat_out_rsci_ivld_run_sct
);
  input run_wen;
  input dat_out_rsci_oswt;
  output dat_out_rsci_biwt;
  output dat_out_rsci_bdwt;
  input dat_out_rsci_bcwt;
  input dat_out_rsci_irdy;
  output dat_out_rsci_ivld_run_sct;


  // Interconnect Declarations
  wire dat_out_rsci_ogwt;


  // Interconnect Declarations for Component Instantiations 
  assign dat_out_rsci_bdwt = dat_out_rsci_oswt & run_wen;
  assign dat_out_rsci_biwt = dat_out_rsci_ogwt & dat_out_rsci_irdy;
  assign dat_out_rsci_ogwt = dat_out_rsci_oswt & (~ dat_out_rsci_bcwt);
  assign dat_out_rsci_ivld_run_sct = dat_out_rsci_ogwt;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_Denoise_IP_run_dat_in_rsci_dat_in_wait_ctrl
// ------------------------------------------------------------------


module EdgeDetect_IP_Denoise_IP_run_dat_in_rsci_dat_in_wait_ctrl (
  run_wen, dat_in_rsci_iswt0, dat_in_rsci_irdy_run_sct
);
  input run_wen;
  input dat_in_rsci_iswt0;
  output dat_in_rsci_irdy_run_sct;



  // Interconnect Declarations for Component Instantiations 
  assign dat_in_rsci_irdy_run_sct = dat_in_rsci_iswt0 & run_wen;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_Denoise_IP_run_ctrl_signal_triosy_obj
// ------------------------------------------------------------------


module EdgeDetect_IP_Denoise_IP_run_ctrl_signal_triosy_obj (
  ctrl_signal_triosy_lz, run_wten, ctrl_signal_triosy_obj_iswt0
);
  output ctrl_signal_triosy_lz;
  input run_wten;
  input ctrl_signal_triosy_obj_iswt0;


  // Interconnect Declarations
  wire ctrl_signal_triosy_obj_biwt;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) ctrl_signal_triosy_obj (
      .ld(ctrl_signal_triosy_obj_biwt),
      .lz(ctrl_signal_triosy_lz)
    );
  EdgeDetect_IP_Denoise_IP_run_ctrl_signal_triosy_obj_ctrl_signal_triosy_wait_ctrl
      EdgeDetect_IP_Denoise_IP_run_ctrl_signal_triosy_obj_ctrl_signal_triosy_wait_ctrl_inst
      (
      .run_wten(run_wten),
      .ctrl_signal_triosy_obj_iswt0(ctrl_signal_triosy_obj_iswt0),
      .ctrl_signal_triosy_obj_biwt(ctrl_signal_triosy_obj_biwt)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_Denoise_IP_run_dat_out_rsci
// ------------------------------------------------------------------


module EdgeDetect_IP_Denoise_IP_run_dat_out_rsci (
  clk, rst, arst_n, dat_out_rsc_dat, dat_out_rsc_vld, dat_out_rsc_rdy, run_wen, dat_out_rsci_oswt,
      dat_out_rsci_wen_comp, dat_out_rsci_idat
);
  input clk;
  input rst;
  input arst_n;
  output [7:0] dat_out_rsc_dat;
  output dat_out_rsc_vld;
  input dat_out_rsc_rdy;
  input run_wen;
  input dat_out_rsci_oswt;
  output dat_out_rsci_wen_comp;
  input [7:0] dat_out_rsci_idat;


  // Interconnect Declarations
  wire dat_out_rsci_biwt;
  wire dat_out_rsci_bdwt;
  wire dat_out_rsci_bcwt;
  wire dat_out_rsci_irdy;
  wire dat_out_rsci_ivld_run_sct;


  // Interconnect Declarations for Component Instantiations 
  ccs_out_wait_v1 #(.rscid(32'sd4),
  .width(32'sd8)) dat_out_rsci (
      .irdy(dat_out_rsci_irdy),
      .ivld(dat_out_rsci_ivld_run_sct),
      .idat(dat_out_rsci_idat),
      .rdy(dat_out_rsc_rdy),
      .vld(dat_out_rsc_vld),
      .dat(dat_out_rsc_dat)
    );
  EdgeDetect_IP_Denoise_IP_run_dat_out_rsci_dat_out_wait_ctrl EdgeDetect_IP_Denoise_IP_run_dat_out_rsci_dat_out_wait_ctrl_inst
      (
      .run_wen(run_wen),
      .dat_out_rsci_oswt(dat_out_rsci_oswt),
      .dat_out_rsci_biwt(dat_out_rsci_biwt),
      .dat_out_rsci_bdwt(dat_out_rsci_bdwt),
      .dat_out_rsci_bcwt(dat_out_rsci_bcwt),
      .dat_out_rsci_irdy(dat_out_rsci_irdy),
      .dat_out_rsci_ivld_run_sct(dat_out_rsci_ivld_run_sct)
    );
  EdgeDetect_IP_Denoise_IP_run_dat_out_rsci_dat_out_wait_dp EdgeDetect_IP_Denoise_IP_run_dat_out_rsci_dat_out_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .arst_n(arst_n),
      .dat_out_rsci_oswt(dat_out_rsci_oswt),
      .dat_out_rsci_wen_comp(dat_out_rsci_wen_comp),
      .dat_out_rsci_biwt(dat_out_rsci_biwt),
      .dat_out_rsci_bdwt(dat_out_rsci_bdwt),
      .dat_out_rsci_bcwt(dat_out_rsci_bcwt)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_Denoise_IP_run_dat_in_rsci
// ------------------------------------------------------------------


module EdgeDetect_IP_Denoise_IP_run_dat_in_rsci (
  dat_in_rsc_dat, dat_in_rsc_vld, dat_in_rsc_rdy, run_wen, dat_in_rsci_oswt, dat_in_rsci_wen_comp,
      dat_in_rsci_idat_mxwt
);
  input [7:0] dat_in_rsc_dat;
  input dat_in_rsc_vld;
  output dat_in_rsc_rdy;
  input run_wen;
  input dat_in_rsci_oswt;
  output dat_in_rsci_wen_comp;
  output [7:0] dat_in_rsci_idat_mxwt;


  // Interconnect Declarations
  wire dat_in_rsci_irdy_run_sct;
  wire dat_in_rsci_ivld;
  wire [7:0] dat_in_rsci_idat;


  // Interconnect Declarations for Component Instantiations 
  ccs_in_wait_coupled_v1 #(.rscid(32'sd1),
  .width(32'sd8)) dat_in_rsci (
      .rdy(dat_in_rsc_rdy),
      .vld(dat_in_rsc_vld),
      .dat(dat_in_rsc_dat),
      .irdy(dat_in_rsci_irdy_run_sct),
      .ivld(dat_in_rsci_ivld),
      .idat(dat_in_rsci_idat)
    );
  EdgeDetect_IP_Denoise_IP_run_dat_in_rsci_dat_in_wait_ctrl EdgeDetect_IP_Denoise_IP_run_dat_in_rsci_dat_in_wait_ctrl_inst
      (
      .run_wen(run_wen),
      .dat_in_rsci_iswt0(dat_in_rsci_oswt),
      .dat_in_rsci_irdy_run_sct(dat_in_rsci_irdy_run_sct)
    );
  assign dat_in_rsci_idat_mxwt = dat_in_rsci_idat;
  assign dat_in_rsci_wen_comp = (~ dat_in_rsci_oswt) | dat_in_rsci_ivld;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_Denoise_IP_run
// ------------------------------------------------------------------


module EdgeDetect_IP_Denoise_IP_run (
  clk, rst, arst_n, dat_in_rsc_dat, dat_in_rsc_vld, dat_in_rsc_rdy, widthIn, heightIn,
      dat_out_rsc_dat, dat_out_rsc_vld, dat_out_rsc_rdy, ctrl_signal_rsc_dat, ctrl_signal_triosy_lz,
      line_buf0_rsci_d_d, line_buf0_rsci_en_d, line_buf0_rsci_q_d, line_buf1_rsci_d_d,
      line_buf1_rsci_en_d, line_buf1_rsci_q_d, line_buf0_rsci_adr_d_pff, line_buf0_rsci_we_d_pff,
      line_buf0_rsci_port_0_rw_ram_ir_internal_RMASK_B_d_pff, line_buf1_rsci_we_d_pff
);
  input clk;
  input rst;
  input arst_n;
  input [7:0] dat_in_rsc_dat;
  input dat_in_rsc_vld;
  output dat_in_rsc_rdy;
  input [10:0] widthIn;
  input [9:0] heightIn;
  output [7:0] dat_out_rsc_dat;
  output dat_out_rsc_vld;
  input dat_out_rsc_rdy;
  input [1:0] ctrl_signal_rsc_dat;
  output ctrl_signal_triosy_lz;
  output [15:0] line_buf0_rsci_d_d;
  output line_buf0_rsci_en_d;
  input [15:0] line_buf0_rsci_q_d;
  output [15:0] line_buf1_rsci_d_d;
  output line_buf1_rsci_en_d;
  input [15:0] line_buf1_rsci_q_d;
  output [9:0] line_buf0_rsci_adr_d_pff;
  output line_buf0_rsci_we_d_pff;
  output line_buf0_rsci_port_0_rw_ram_ir_internal_RMASK_B_d_pff;
  output line_buf1_rsci_we_d_pff;


  // Interconnect Declarations
  wire run_wen;
  wire run_wten;
  wire dat_in_rsci_wen_comp;
  wire [7:0] dat_in_rsci_idat_mxwt;
  wire dat_out_rsci_wen_comp;
  reg [7:0] dat_out_rsci_idat;
  wire [1:0] ctrl_signal_rsci_idat;
  reg ctrl_signal_triosy_obj_iswt0;
  wire [3:0] fsm_output;
  wire VROW_equal_tmp;
  wire operator_11_false_4_operator_11_false_4_nor_tmp;
  wire operator_11_false_1_nor_tmp;
  wire VCOL_else_4_else_else_else_nor_1_tmp;
  wire VCOL_else_4_else_aif_equal_tmp;
  wire VCOL_VCOL_oelse_operator_11_false_or_tmp;
  wire and_dcpl_1;
  wire not_tmp_4;
  wire mux_tmp_3;
  wire or_dcpl_3;
  wire and_dcpl_4;
  wire or_dcpl_4;
  wire mux_tmp_6;
  wire or_tmp_35;
  wire mux_tmp_34;
  wire or_dcpl_42;
  wire and_dcpl_21;
  wire mux_tmp_94;
  wire and_dcpl_27;
  wire mux_tmp_102;
  wire nor_tmp_47;
  wire and_dcpl_44;
  wire and_dcpl_46;
  wire and_dcpl_50;
  wire or_dcpl_63;
  wire VCOL_else_5_else_if_for_1_mux_81_tmp_0;
  wire lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_3_1_1;
  wire VCOL_else_5_else_if_for_1_and_55_ssc_1;
  wire VCOL_equal_tmp_4;
  wire VCOL_equal_tmp_5;
  wire VCOL_equal_tmp_7;
  wire VCOL_else_5_else_if_for_1_equal_tmp_mx0w1;
  wire lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_1_mx1;
  wire lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_2;
  wire lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_0_mx1;
  wire exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva_mx1;
  wire operator_10_false_1_operator_10_false_1_and_cse_sva_1;
  wire lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1_mx0w0;
  wire VCOL_or_6_tmp_1;
  reg exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva;
  reg operator_10_false_1_operator_10_false_1_and_cse_sva_1_1;
  wire VCOL_else_4_else_else_else_unequal_tmp_1;
  wire VCOL_else_4_else_else_land_lpi_3_dfm_1;
  wire VCOL_else_4_else_land_lpi_3_dfm_1;
  wire VCOL_VCOL_nor_1_m1c_1;
  reg VCOL_land_1_lpi_3_dfm_1;
  wire VCOL_VCOL_nor_5_m1c_1;
  wire VCOL_or_tmp_1;
  reg operator_11_false_4_operator_11_false_4_nor_cse_sva_1;
  wire VCOL_equal_tmp_6;
  wire VCOL_and_7_ssc_1;
  wire VCOL_and_6_ssc_1;
  reg operator_11_false_4_operator_11_false_4_nor_cse_lpi_3_dfm_1;
  reg exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1;
  wire VCOL_else_4_and_9_cse_1;
  wire VCOL_else_4_else_else_else_else_else_and_tmp_1;
  wire VCOL_else_4_else_else_and_m1c_1;
  wire VCOL_else_5_else_if_for_1_and_98_m1c_1;
  wire VCOL_else_4_else_else_VCOL_else_4_else_else_nor_1_cse_1;
  wire VCOL_else_4_VCOL_else_4_nor_m1c_1;
  wire VCOL_else_4_else_else_and_3_m1c_1;
  wire VCOL_else_5_else_if_for_and_stg_2_0_sva_1;
  wire VCOL_else_5_else_if_for_and_stg_1_3_sva_1;
  wire VCOL_else_5_else_if_for_and_stg_1_2_sva_1;
  wire VCOL_else_5_else_if_for_and_stg_1_1_sva_1;
  wire VCOL_else_5_else_if_for_and_stg_1_0_sva_1;
  reg lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3;
  reg VCOL_equal_tmp_2_1;
  wire VCOL_else_4_else_else_else_and_tmp_1;
  wire VCOL_and_m1c_1;
  reg VCOL_VCOL_oelse_operator_11_false_or_cse_sva_1;
  wire VCOL_else_5_else_if_for_1_and_stg_2_0_sva_1;
  wire VCOL_else_5_else_if_for_1_and_stg_1_3_sva_1;
  wire VCOL_else_5_else_if_for_1_and_stg_1_1_sva_1;
  wire VCOL_else_5_else_if_for_1_and_stg_1_2_sva_1;
  wire VCOL_else_5_else_if_for_1_and_stg_1_0_sva_1;
  reg [3:0] max_i_lpi_3;
  reg VCOL_stage_0_2;
  reg [9:0] VROW_y_sva;
  reg [10:0] VCOL_x_sva;
  reg VCOL_stage_0_1;
  reg lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_1;
  reg lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_0;
  reg [1:0] VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1;
  reg lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_1;
  reg lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_0;
  reg VCOL_if_6_VCOL_if_6_and_itm_1;
  reg [9:0] VCOL_else_3_else_asn_itm_1;
  reg operator_11_false_2_operator_11_false_2_slc_VCOL_x_0_1_itm_1;
  reg VCOL_land_lpi_3_dfm_1;
  wire [1:0] VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1_mx0;
  wire [10:0] VCOL_x_sva_mx1;
  reg [3:0] i_1_lpi_3_dfm_1;
  wire max_i_lpi_3_dfm_mx0_3;
  wire [2:0] max_i_lpi_3_dfm_mx1_2_0;
  wire VCOL_asn_80_rgt;
  reg reg_dat_in_rsci_oswt_cse;
  reg reg_dat_out_rsci_oswt_cse;
  reg reg_line_buf0_rsci_cgo_cse;
  reg reg_line_buf1_rsci_cgo_cse;
  wire VCOL_and_46_cse;
  reg reg_operator_11_false_6_nor_itm_1_cse;
  wire nor_79_cse;
  wire nor_33_cse;
  wire or_40_cse;
  wire mux_110_cse;
  wire nand_6_cse;
  wire and_81_m1c;
  wire VCOL_aelse_VCOL_aelse_and_cse;
  wire nor_62_cse;
  wire mux_112_cse;
  wire mux_4_cse;
  wire VCOL_x_and_cse;
  wire and_131_rmff;
  wire and_143_rmff;
  reg [7:0] VCOL_VCOL_slc_pix_dummy_3_9_2_lpi_4;
  wire [7:0] pix_2_9_2_lpi_3_dfm_8_mx0w0;
  reg [7:0] VCOL_VCOL_slc_pix_dummy_2_9_2_lpi_4;
  wire [7:0] pix_5_9_2_lpi_3_dfm_6_mx0;
  reg [7:0] VCOL_VCOL_slc_pix_dummy_5_9_2_lpi_4;
  wire [7:0] VCOL_VCOL_slc_pix_dummy_5_9_2_lpi_3_dfm_mx1w0;
  reg [7:0] VCOL_VCOL_slc_pix_dummy_4_9_2_lpi_4;
  wire [7:0] pix_4_9_2_lpi_3_dfm_1_mx0;
  wire mux_tmp;
  wire or_tmp_265;
  wire [9:0] z_out;
  wire [10:0] nl_z_out;
  reg [7:0] uint_pix_2_lpi_3;
  reg [7:0] pix_0_9_2_lpi_3;
  reg [7:0] pix_1_9_2_lpi_3;
  reg [7:0] pix_2_9_2_lpi_3;
  reg [15:0] rdbuf0_pix_lpi_3;
  reg [15:0] rdbuf1_pix_lpi_3;
  reg [7:0] pix_3_9_2_lpi_3;
  reg [7:0] pix_4_9_2_lpi_3;
  reg [7:0] pix_6_9_2_lpi_3;
  reg [7:0] pix_7_9_2_lpi_3;
  reg [7:0] pix_8_9_2_lpi_3;
  reg [7:0] pix_5_9_2_lpi_3;
  reg [7:0] pix_result_9_2_lpi_3;
  reg [7:0] tmp_pix_4_9_2_lpi_3;
  reg [7:0] tmp_pix_3_9_2_lpi_3;
  reg [7:0] tmp_pix_5_9_2_lpi_3;
  reg [7:0] tmp_pix_2_9_2_lpi_3;
  reg [7:0] tmp_pix_6_9_2_lpi_3;
  reg [7:0] tmp_pix_1_9_2_lpi_3;
  reg [7:0] tmp_pix_7_9_2_lpi_3;
  reg [1:0] tmp_pix_0_1_0_lpi_3;
  reg [7:0] tmp_pix_0_9_2_lpi_3;
  reg [7:0] tmp_pix_8_9_2_lpi_3;
  reg [1:0] tmp_pix_4_1_0_lpi_3;
  reg [1:0] tmp_pix_3_1_0_lpi_3;
  reg [1:0] tmp_pix_5_1_0_lpi_3;
  reg [1:0] tmp_pix_2_1_0_lpi_3;
  reg [1:0] tmp_pix_6_1_0_lpi_3;
  reg [1:0] tmp_pix_7_1_0_lpi_3;
  reg [1:0] tmp_pix_8_1_0_lpi_3;
  reg VCOL_equal_tmp_1;
  reg VCOL_equal_tmp_1_1;
  reg [3:0] i_lpi_3_dfm_4_1;
  reg [3:0] max_i_lpi_3_dfm_2_1;
  reg [1:0] tmp_pix_0_1_0_lpi_3_dfm_2_1;
  reg [1:0] tmp_pix_1_1_0_lpi_3_dfm_2_1;
  reg [1:0] tmp_pix_2_1_0_lpi_3_dfm_2_1;
  reg [1:0] tmp_pix_3_1_0_lpi_3_dfm_2_1;
  reg [1:0] tmp_pix_4_1_0_lpi_3_dfm_2_1;
  reg [1:0] tmp_pix_5_1_0_lpi_3_dfm_2_1;
  reg [1:0] tmp_pix_6_1_0_lpi_3_dfm_2_1;
  reg [1:0] tmp_pix_7_1_0_lpi_3_dfm_2_1;
  reg [1:0] tmp_pix_8_1_0_lpi_3_dfm_2_1;
  reg VCOL_and_16_itm_1;
  reg [7:0] VCOL_else_5_else_if_slc_max_val_9_2_itm_1;
  reg VCOL_or_1_itm_1;
  reg VCOL_and_22_itm_1;
  reg [7:0] max_val_lpi_3_dfm_5_1_9_2;
  wire [7:0] pix_result_9_2_lpi_3_dfm_2_mx0w0;
  wire lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_mx0c1;
  wire [7:0] pix_1_9_2_lpi_3_dfm_9_mx1w0;
  wire [7:0] max_val_lpi_3_dfm_3_9_2_1;
  wire [7:0] tmp_pix_1_9_2_lpi_3_mx1;
  wire [7:0] tmp_pix_5_9_2_lpi_3_mx1;
  wire [7:0] tmp_pix_2_9_2_lpi_3_mx1;
  wire [7:0] tmp_pix_6_9_2_lpi_3_mx1;
  wire [7:0] tmp_pix_3_9_2_lpi_3_mx1;
  wire [7:0] tmp_pix_7_9_2_lpi_3_mx1;
  wire [7:0] tmp_pix_0_9_2_lpi_3_mx0;
  wire [7:0] tmp_pix_8_9_2_lpi_3_mx1;
  wire [7:0] tmp_pix_4_9_2_lpi_3_mx1;
  wire [1:0] tmp_pix_0_1_0_lpi_3_mx1;
  wire [1:0] tmp_pix_1_1_0_lpi_3_mx1;
  wire [1:0] tmp_pix_2_1_0_lpi_3_mx1;
  wire [1:0] tmp_pix_3_1_0_lpi_3_mx1;
  wire [1:0] tmp_pix_4_1_0_lpi_3_mx1;
  wire [1:0] tmp_pix_5_1_0_lpi_3_mx1;
  wire [1:0] tmp_pix_6_1_0_lpi_3_mx1;
  wire [1:0] tmp_pix_7_1_0_lpi_3_mx1;
  wire [1:0] tmp_pix_8_1_0_lpi_3_mx1;
  wire [7:0] pix_0_9_2_lpi_3_dfm_9_mx1w0;
  wire [3:0] i_1_lpi_3_dfm_3;
  wire [3:0] max_i_lpi_3_mx1;
  wire [3:0] i_1_sva_2;
  wire [4:0] nl_i_1_sva_2;
  wire [2:0] j_2_0_sva_2;
  wire [3:0] nl_j_2_0_sva_2;
  wire [3:0] i_sva_2;
  wire [4:0] nl_i_sva_2;
  wire [7:0] pix_4_9_2_lpi_3_dfm_mx0;
  wire [7:0] pix_1_9_2_lpi_3_dfm_10;
  wire [7:0] pix_7_9_2_lpi_3_dfm_5_mx0;
  wire [7:0] pix_3_9_2_lpi_3_dfm_11;
  wire [10:0] VCOL_x_sva_2;
  wire [11:0] nl_VCOL_x_sva_2;
  wire VCOL_else_4_and_1_cse_1;
  wire VCOL_else_5_else_if_for_1_and_130_m1c_1;
  wire VCOL_or_4_tmp_1;
  wire VCOL_else_5_else_if_for_1_or_3_m1c_1;
  wire [7:0] max_val_lpi_3_dfm_1_9_2_mx0;
  wire [7:0] VCOL_else_5_else_if_for_1_for_slc_tmp_pix_10_9_0_cse_sva_9_2_1;
  wire [1:0] VCOL_else_5_else_if_for_1_for_slc_tmp_pix_10_9_0_cse_sva_1_0_1;
  wire [7:0] pix_3_9_2_lpi_3_dfm_mx0;
  wire VCOL_else_4_else_else_and_7_m1c_1;
  wire VCOL_else_4_else_else_else_else_and_1_tmp_1;
  wire VCOL_lor_lpi_3_dfm_1;
  wire [7:0] VCOL_else_5_else_if_for_VCOL_else_5_else_if_for_VCOL_else_5_else_if_for_mux_psp_sva_1;
  wire [7:0] pix_6_9_2_lpi_3_dfm_9;
  wire [7:0] pix_8_9_2_lpi_3_dfm_8;
  wire VCOL_else_5_else_if_for_1_or_m1c_1;
  wire [1:0] tmp_pix_0_1_0_sva_2;
  wire [1:0] tmp_pix_8_1_0_sva_2;
  wire [1:0] tmp_pix_7_1_0_sva_2;
  wire [1:0] tmp_pix_6_1_0_sva_2;
  wire [1:0] tmp_pix_5_1_0_sva_2;
  wire [1:0] tmp_pix_4_1_0_sva_2;
  wire [1:0] tmp_pix_3_1_0_sva_2;
  wire [1:0] tmp_pix_2_1_0_sva_2;
  wire [1:0] tmp_pix_1_1_0_sva_2;
  wire VCOL_else_5_else_if_for_1_VCOL_else_5_else_if_for_1_nand_8_seb_sva_1;
  wire VCOL_else_5_else_if_for_1_VCOL_else_5_else_if_for_1_nand_7_seb_sva_1;
  wire VCOL_else_5_else_if_for_1_VCOL_else_5_else_if_for_1_nand_6_seb_sva_1;
  wire VCOL_else_5_else_if_for_1_VCOL_else_5_else_if_for_1_nand_5_seb_sva_1;
  wire VCOL_else_5_else_if_for_1_VCOL_else_5_else_if_for_1_nand_4_seb_sva_1;
  wire VCOL_else_5_else_if_for_1_VCOL_else_5_else_if_for_1_nand_3_seb_sva_1;
  wire VCOL_else_5_else_if_for_1_VCOL_else_5_else_if_for_1_nand_2_seb_sva_1;
  wire VCOL_else_5_else_if_for_1_VCOL_else_5_else_if_for_1_nand_1_seb_sva_1;
  wire VCOL_else_5_else_if_for_1_VCOL_else_5_else_if_for_1_nand_seb_sva_1;
  reg j_2_0_lpi_3_dfm_3_1_2;
  reg [1:0] j_2_0_lpi_3_dfm_3_1_1_0;
  wire VROW_y_or_cse;
  wire operator_10_false_1_and_cse;
  wire operator_11_false_6_and_cse;
  wire VCOL_if_6_and_1_cse;
  wire rdbuf0_pix_and_1_cse;
  wire tmp_pix_and_27_rgt;
  wire j_or_1_rgt;
  wire and_dcpl_69;
  wire and_dcpl_85;
  wire or_tmp_301;
  wire mux_tmp_159;
  wire nand_tmp_9;
  wire mux_tmp_164;
  wire or_tmp_323;
  wire or_tmp_327;
  wire or_tmp_332;
  wire or_tmp_347;
  wire not_tmp_188;
  wire or_tmp_362;
  wire or_tmp_377;
  wire or_tmp_392;
  wire or_tmp_407;
  wire and_tmp_19;
  wire mux_tmp_210;
  wire or_tmp_430;
  wire not_tmp_217;
  wire or_tmp_443;
  wire mux_tmp_230;
  wire or_tmp_467;
  wire or_tmp_536;
  wire nand_tmp_23;
  wire mux_tmp_263;
  wire or_tmp_547;
  wire or_tmp_548;
  wire or_tmp_554;
  wire or_tmp_555;
  wire mux_tmp_285;
  wire or_tmp_598;
  wire and_254_cse;
  wire and_274_cse;
  wire or_357_cse;
  wire nor_211_cse;
  wire and_450_cse;
  wire or_384_cse;
  wire or_429_cse;
  wire or_368_cse;
  wire or_516_cse;
  wire mux_134_cse;
  wire or_634_cse;
  wire or_633_cse;
  wire nor_244_cse;
  wire or_49_cse;
  wire or_46_cse;
  wire or_52_cse;
  wire or_704_cse;
  wire nand_82_cse;
  wire and_457_cse;
  wire and_cse;
  wire or_703_cse;
  wire or_705_cse;
  wire or_388_cse;
  wire VCOL_else_5_else_if_for_1_and_39_cse;
  wire nand_89_cse;
  wire or_554_cse;
  wire nor_176_cse;
  wire or_444_cse;
  wire operator_4_false_1_acc_itm_2;
  wire operator_4_false_2_acc_itm_3;
  wire operator_11_false_acc_itm_11_1;
  wire operator_10_false_acc_itm_10_1;
  wire operator_4_false_acc_itm_3;
  wire VCOL_else_5_else_if_for_1_for_if_acc_itm_10;

  wire not_510_nl;
  wire VROW_y_not_2_nl;
  wire nor_198_nl;
  wire mux_135_nl;
  wire nor_197_nl;
  wire and_101_nl;
  wire and_103_nl;
  wire and_105_nl;
  wire mux_138_nl;
  wire mux_137_nl;
  wire or_358_nl;
  wire mux_136_nl;
  wire nor_199_nl;
  wire mux_139_nl;
  wire mux_16_nl;
  wire mux_15_nl;
  wire operator_11_false_mux_nl;
  wire mux_21_nl;
  wire mux_20_nl;
  wire mux_19_nl;
  wire nor_74_nl;
  wire mux_18_nl;
  wire nor_75_nl;
  wire mux_17_nl;
  wire nor_76_nl;
  wire j_and_6_nl;
  wire j_and_7_nl;
  wire j_and_4_nl;
  wire j_and_2_nl;
  wire mux_146_nl;
  wire mux_145_nl;
  wire mux_144_nl;
  wire or_374_nl;
  wire mux_143_nl;
  wire mux_142_nl;
  wire or_373_nl;
  wire or_371_nl;
  wire mux_141_nl;
  wire nor_204_nl;
  wire VCOL_else_5_else_if_for_1_and_44_nl;
  wire VCOL_else_5_else_if_for_1_and_45_nl;
  wire mux_29_nl;
  wire mux_28_nl;
  wire mux_27_nl;
  wire mux_26_nl;
  wire or_50_nl;
  wire mux_24_nl;
  wire or_nl;
  wire mux_23_nl;
  wire mux_147_nl;
  wire nor_206_nl;
  wire mux_108_nl;
  wire mux_107_nl;
  wire or_205_nl;
  wire mux_111_nl;
  wire nand_45_nl;
  wire or_208_nl;
  wire mux_116_nl;
  wire and_65_nl;
  wire mux_115_nl;
  wire mux_114_nl;
  wire and_256_nl;
  wire or_337_nl;
  wire mux_113_nl;
  wire nand_2_nl;
  wire or_209_nl;
  wire and_165_nl;
  wire mux_151_nl;
  wire mux_150_nl;
  wire mux_149_nl;
  wire or_382_nl;
  wire mux_148_nl;
  wire nor_207_nl;
  wire nand_55_nl;
  wire or_378_nl;
  wire mux_156_nl;
  wire mux_155_nl;
  wire mux_154_nl;
  wire mux_153_nl;
  wire mux_152_nl;
  wire and_448_nl;
  wire and_449_nl;
  wire and_451_nl;
  wire or_383_nl;
  wire mux_163_nl;
  wire mux_162_nl;
  wire and_297_nl;
  wire mux_161_nl;
  wire and_296_nl;
  wire mux_160_nl;
  wire and_453_nl;
  wire mux_158_nl;
  wire or_394_nl;
  wire mux_157_nl;
  wire or_393_nl;
  wire and_294_nl;
  wire mux_173_nl;
  wire mux_172_nl;
  wire and_301_nl;
  wire mux_171_nl;
  wire mux_170_nl;
  wire mux_169_nl;
  wire mux_168_nl;
  wire mux_167_nl;
  wire mux_166_nl;
  wire mux_165_nl;
  wire mux_11_nl;
  wire nand_nl;
  wire mux_178_nl;
  wire mux_177_nl;
  wire mux_176_nl;
  wire or_414_nl;
  wire mux_175_nl;
  wire mux_174_nl;
  wire or_413_nl;
  wire or_412_nl;
  wire mux_179_nl;
  wire nand_85_nl;
  wire nor_215_nl;
  wire mux_33_nl;
  wire nor_77_nl;
  wire nor_78_nl;
  wire[7:0] VCOL_else_5_else_if_for_1_and_31_nl;
  wire mux_184_nl;
  wire nor_217_nl;
  wire mux_183_nl;
  wire or_434_nl;
  wire mux_182_nl;
  wire or_713_nl;
  wire mux_181_nl;
  wire or_431_nl;
  wire nor_218_nl;
  wire mux_180_nl;
  wire or_425_nl;
  wire or_420_nl;
  wire[7:0] VCOL_else_5_else_if_for_1_and_35_nl;
  wire mux_189_nl;
  wire nor_220_nl;
  wire mux_188_nl;
  wire or_449_nl;
  wire mux_187_nl;
  wire or_715_nl;
  wire mux_186_nl;
  wire or_446_nl;
  wire nor_221_nl;
  wire mux_185_nl;
  wire or_440_nl;
  wire or_435_nl;
  wire[7:0] VCOL_else_5_else_if_for_1_and_32_nl;
  wire mux_194_nl;
  wire nor_223_nl;
  wire mux_193_nl;
  wire or_464_nl;
  wire mux_192_nl;
  wire or_717_nl;
  wire mux_191_nl;
  wire or_461_nl;
  wire nor_224_nl;
  wire mux_190_nl;
  wire or_455_nl;
  wire or_450_nl;
  wire[7:0] VCOL_else_5_else_if_for_1_and_36_nl;
  wire mux_199_nl;
  wire nor_226_nl;
  wire mux_198_nl;
  wire or_479_nl;
  wire mux_197_nl;
  wire or_719_nl;
  wire mux_196_nl;
  wire or_476_nl;
  wire nor_227_nl;
  wire mux_195_nl;
  wire or_470_nl;
  wire or_465_nl;
  wire[7:0] VCOL_else_5_else_if_for_1_and_33_nl;
  wire mux_204_nl;
  wire nor_229_nl;
  wire mux_203_nl;
  wire or_494_nl;
  wire mux_202_nl;
  wire or_721_nl;
  wire mux_201_nl;
  wire or_491_nl;
  wire nor_230_nl;
  wire mux_200_nl;
  wire or_485_nl;
  wire or_480_nl;
  wire[7:0] VCOL_else_5_else_if_for_1_and_37_nl;
  wire mux_209_nl;
  wire nor_232_nl;
  wire mux_208_nl;
  wire or_509_nl;
  wire mux_207_nl;
  wire or_723_nl;
  wire mux_206_nl;
  wire or_506_nl;
  wire nor_233_nl;
  wire mux_205_nl;
  wire or_500_nl;
  wire or_495_nl;
  wire[7:0] VCOL_else_5_else_if_for_1_and_30_nl;
  wire nor_131_nl;
  wire mux_120_nl;
  wire or_149_nl;
  wire mux_216_nl;
  wire and_461_nl;
  wire mux_215_nl;
  wire and_460_nl;
  wire nor_234_nl;
  wire nor_236_nl;
  wire mux_214_nl;
  wire or_724_nl;
  wire mux_213_nl;
  wire or_515_nl;
  wire mux_212_nl;
  wire mux_211_nl;
  wire nand_66_nl;
  wire or_510_nl;
  wire nor_165_nl;
  wire[7:0] VCOL_else_5_else_if_for_1_and_38_nl;
  wire mux_221_nl;
  wire nor_239_nl;
  wire mux_220_nl;
  wire or_530_nl;
  wire mux_219_nl;
  wire or_728_nl;
  wire mux_218_nl;
  wire or_727_nl;
  wire nand_87_nl;
  wire nor_240_nl;
  wire mux_217_nl;
  wire or_523_nl;
  wire or_518_nl;
  wire[7:0] VCOL_else_5_else_if_for_1_and_34_nl;
  wire mux_226_nl;
  wire nor_242_nl;
  wire mux_225_nl;
  wire or_545_nl;
  wire mux_224_nl;
  wire or_730_nl;
  wire mux_223_nl;
  wire or_542_nl;
  wire nor_243_nl;
  wire mux_222_nl;
  wire or_536_nl;
  wire or_531_nl;
  wire mux_124_nl;
  wire mux_123_nl;
  wire nor_50_nl;
  wire mux_122_nl;
  wire or_237_nl;
  wire and_80_nl;
  wire mux_121_nl;
  wire nor_134_nl;
  wire nor_135_nl;
  wire VCOL_and_50_nl;
  wire VCOL_and_48_nl;
  wire VCOL_and_49_nl;
  wire mux_239_nl;
  wire mux_238_nl;
  wire mux_237_nl;
  wire mux_236_nl;
  wire mux_235_nl;
  wire mux_234_nl;
  wire mux_233_nl;
  wire or_559_nl;
  wire mux_232_nl;
  wire mux_231_nl;
  wire or_556_nl;
  wire or_555_nl;
  wire nor_246_nl;
  wire mux_229_nl;
  wire mux_228_nl;
  wire nor_247_nl;
  wire mux_227_nl;
  wire nor_248_nl;
  wire nor_249_nl;
  wire nor_250_nl;
  wire mux_242_nl;
  wire nor_254_nl;
  wire mux_241_nl;
  wire or_568_nl;
  wire or_567_nl;
  wire mux_245_nl;
  wire nor_259_nl;
  wire mux_244_nl;
  wire or_577_nl;
  wire or_576_nl;
  wire mux_248_nl;
  wire nor_264_nl;
  wire mux_247_nl;
  wire or_586_nl;
  wire or_585_nl;
  wire mux_251_nl;
  wire nor_269_nl;
  wire mux_250_nl;
  wire or_595_nl;
  wire or_594_nl;
  wire mux_254_nl;
  wire nor_274_nl;
  wire mux_253_nl;
  wire or_604_nl;
  wire or_603_nl;
  wire mux_257_nl;
  wire nor_279_nl;
  wire mux_256_nl;
  wire or_613_nl;
  wire or_612_nl;
  wire mux_260_nl;
  wire nor_284_nl;
  wire mux_259_nl;
  wire or_622_nl;
  wire or_621_nl;
  wire mux_266_nl;
  wire mux_265_nl;
  wire and_464_nl;
  wire mux_264_nl;
  wire nor_173_nl;
  wire mux_272_nl;
  wire and_465_nl;
  wire mux_271_nl;
  wire mux_270_nl;
  wire mux_276_nl;
  wire and_466_nl;
  wire mux_275_nl;
  wire mux_274_nl;
  wire mux_277_nl;
  wire nor_287_nl;
  wire nor_288_nl;
  wire mux_278_nl;
  wire nor_289_nl;
  wire nor_290_nl;
  wire mux_279_nl;
  wire nor_291_nl;
  wire nor_292_nl;
  wire mux_280_nl;
  wire nor_293_nl;
  wire nor_294_nl;
  wire mux_281_nl;
  wire nor_295_nl;
  wire nor_296_nl;
  wire mux_282_nl;
  wire nor_297_nl;
  wire nor_298_nl;
  wire mux_283_nl;
  wire nor_299_nl;
  wire nor_300_nl;
  wire mux_284_nl;
  wire nor_301_nl;
  wire nor_302_nl;
  wire mux_291_nl;
  wire mux_290_nl;
  wire mux_289_nl;
  wire mux_288_nl;
  wire nor_303_nl;
  wire mux_287_nl;
  wire or_684_nl;
  wire mux_286_nl;
  wire or_683_nl;
  wire or_738_nl;
  wire or_680_nl;
  wire VCOL_and_51_nl;
  wire VCOL_and_52_nl;
  wire mux_299_nl;
  wire mux_298_nl;
  wire mux_297_nl;
  wire nor_305_nl;
  wire mux_296_nl;
  wire or_693_nl;
  wire mux_295_nl;
  wire mux_294_nl;
  wire or_690_nl;
  wire mux_293_nl;
  wire or_689_nl;
  wire mux_292_nl;
  wire or_688_nl;
  wire and_229_nl;
  wire and_231_nl;
  wire mux_130_nl;
  wire mux_129_nl;
  wire nor_137_nl;
  wire mux_128_nl;
  wire or_340_nl;
  wire VCOL_and_53_nl;
  wire mux_304_nl;
  wire mux_303_nl;
  wire mux_302_nl;
  wire nor_306_nl;
  wire mux_301_nl;
  wire and_439_nl;
  wire mux_300_nl;
  wire nor_307_nl;
  wire or_250_nl;
  wire[9:0] operator_42_40_true_AC_TRN_AC_WRAP_acc_nl;
  wire[12:0] nl_operator_42_40_true_AC_TRN_AC_WRAP_acc_nl;
  wire[2:0] operator_4_false_1_acc_nl;
  wire[3:0] nl_operator_4_false_1_acc_nl;
  wire mux_106_nl;
  wire nor_124_nl;
  wire nor_125_nl;
  wire VCOL_else_5_else_if_for_1_and_110_nl;
  wire VCOL_else_5_else_if_for_1_and_111_nl;
  wire VCOL_else_5_else_if_for_1_and_126_nl;
  wire VCOL_else_5_else_if_for_1_and_127_nl;
  wire VCOL_else_5_else_if_for_1_not_151_nl;
  wire VCOL_else_5_else_if_for_1_and_128_nl;
  wire VCOL_else_5_else_if_for_1_and_129_nl;
  wire VCOL_else_5_else_if_for_1_and_117_nl;
  wire VCOL_else_5_else_if_for_1_and_118_nl;
  wire VCOL_else_4_and_10_nl;
  wire tmp_pix_and_28_nl;
  wire tmp_pix_and_29_nl;
  wire tmp_pix_and_30_nl;
  wire tmp_pix_and_31_nl;
  wire tmp_pix_and_32_nl;
  wire tmp_pix_and_33_nl;
  wire tmp_pix_and_34_nl;
  wire tmp_pix_and_35_nl;
  wire tmp_pix_and_36_nl;
  wire VCOL_else_5_else_if_for_1_nand_10_nl;
  wire VCOL_else_5_else_if_for_1_and_124_nl;
  wire VCOL_and_14_nl;
  wire VCOL_else_5_else_if_for_1_and_125_nl;
  wire VCOL_else_5_else_if_for_1_and_113_nl;
  wire VCOL_else_5_else_if_for_1_or_1_nl;
  wire VCOL_and_17_nl;
  wire[3:0] operator_4_false_2_acc_nl;
  wire[4:0] nl_operator_4_false_2_acc_nl;
  wire[11:0] operator_11_false_acc_nl;
  wire[12:0] nl_operator_11_false_acc_nl;
  wire[10:0] operator_10_false_acc_nl;
  wire[11:0] nl_operator_10_false_acc_nl;
  wire[3:0] operator_4_false_acc_nl;
  wire[4:0] nl_operator_4_false_acc_nl;
  wire VCOL_else_5_else_if_for_1_mux_4_nl;
  wire VCOL_VCOL_nor_7_nl;
  wire VCOL_and_39_nl;
  wire or_254_nl;
  wire mux_131_nl;
  wire nor_120_nl;
  wire and_253_nl;
  wire nand_51_nl;
  wire mux_133_nl;
  wire and_258_nl;
  wire mux_132_nl;
  wire or_255_nl;
  wire nand_44_nl;
  wire VCOL_else_5_else_if_for_1_nand_12_nl;
  wire VCOL_else_5_else_if_for_1_and_134_nl;
  wire VCOL_else_5_else_if_for_1_and_131_nl;
  wire VCOL_else_5_else_if_for_1_nand_6_nl;
  wire VCOL_else_5_else_if_for_1_and_119_nl;
  wire VCOL_else_5_else_if_for_1_and_121_nl;
  wire VCOL_else_5_else_if_for_1_nand_4_nl;
  wire VCOL_else_5_else_if_for_1_or_2_nl;
  wire VCOL_else_4_and_15_nl;
  wire VCOL_else_5_else_if_for_1_and_115_nl;
  wire VCOL_else_5_else_if_for_1_and_106_nl;
  wire[10:0] VCOL_else_5_else_if_for_1_for_if_acc_nl;
  wire[11:0] nl_VCOL_else_5_else_if_for_1_for_if_acc_nl;
  wire nor_61_nl;
  wire mux_2_nl;
  wire mux_93_nl;
  wire mux_92_nl;
  wire or_185_nl;
  wire or_183_nl;
  wire mux_97_nl;
  wire mux_95_nl;
  wire mux_101_nl;
  wire VCOL_if_3_not_nl;
  wire[7:0] VCOL_else_5_else_if_for_1_mux_10_nl;
  wire[7:0] VCOL_else_5_else_if_for_1_mux_9_nl;
  wire[7:0] VCOL_mux_9_nl;
  wire[7:0] VCOL_else_5_else_if_for_1_mux_11_nl;
  wire mux_117_nl;
  wire nor_127_nl;
  wire nor_128_nl;
  wire or_347_nl;
  wire or_399_nl;
  wire or_397_nl;
  wire or_407_nl;
  wire or_512_nl;
  wire or_511_nl;
  wire or_557_nl;
  wire mux_261_nl;
  wire nor_310_nl;
  wire nor_311_nl;
  wire or_631_nl;
  wire mux_262_nl;
  wire or_630_nl;
  wire mux_269_nl;
  wire mux_268_nl;
  wire and_478_nl;
  wire or_636_nl;
  wire mux_267_nl;
  wire nand_74_nl;
  wire mux_273_nl;
  wire or_644_nl;
  wire or_679_nl;
  wire or_678_nl;
  wire[9:0] VROW_VROW_mux_1_nl;
  wire VROW_or_2_nl;

  // Interconnect Declarations for Component Instantiations 
  wire  nl_EdgeDetect_IP_Denoise_IP_run_run_fsm_inst_VCOL_C_0_tr0;
  assign nl_EdgeDetect_IP_Denoise_IP_run_run_fsm_inst_VCOL_C_0_tr0 = ~(VCOL_stage_0_2
      | VCOL_stage_0_1);
  ccs_in_v1 #(.rscid(32'sd5),
  .width(32'sd2)) ctrl_signal_rsci (
      .dat(ctrl_signal_rsc_dat),
      .idat(ctrl_signal_rsci_idat)
    );
  EdgeDetect_IP_Denoise_IP_run_dat_in_rsci EdgeDetect_IP_Denoise_IP_run_dat_in_rsci_inst
      (
      .dat_in_rsc_dat(dat_in_rsc_dat),
      .dat_in_rsc_vld(dat_in_rsc_vld),
      .dat_in_rsc_rdy(dat_in_rsc_rdy),
      .run_wen(run_wen),
      .dat_in_rsci_oswt(reg_dat_in_rsci_oswt_cse),
      .dat_in_rsci_wen_comp(dat_in_rsci_wen_comp),
      .dat_in_rsci_idat_mxwt(dat_in_rsci_idat_mxwt)
    );
  EdgeDetect_IP_Denoise_IP_run_dat_out_rsci EdgeDetect_IP_Denoise_IP_run_dat_out_rsci_inst
      (
      .clk(clk),
      .rst(rst),
      .arst_n(arst_n),
      .dat_out_rsc_dat(dat_out_rsc_dat),
      .dat_out_rsc_vld(dat_out_rsc_vld),
      .dat_out_rsc_rdy(dat_out_rsc_rdy),
      .run_wen(run_wen),
      .dat_out_rsci_oswt(reg_dat_out_rsci_oswt_cse),
      .dat_out_rsci_wen_comp(dat_out_rsci_wen_comp),
      .dat_out_rsci_idat(dat_out_rsci_idat)
    );
  EdgeDetect_IP_Denoise_IP_run_wait_dp EdgeDetect_IP_Denoise_IP_run_wait_dp_inst
      (
      .line_buf0_rsci_en_d(line_buf0_rsci_en_d),
      .line_buf1_rsci_en_d(line_buf1_rsci_en_d),
      .run_wen(run_wen),
      .line_buf0_rsci_cgo(reg_line_buf0_rsci_cgo_cse),
      .line_buf0_rsci_cgo_ir_unreg(and_131_rmff),
      .line_buf1_rsci_cgo(reg_line_buf1_rsci_cgo_cse),
      .line_buf1_rsci_cgo_ir_unreg(and_143_rmff)
    );
  EdgeDetect_IP_Denoise_IP_run_ctrl_signal_triosy_obj EdgeDetect_IP_Denoise_IP_run_ctrl_signal_triosy_obj_inst
      (
      .ctrl_signal_triosy_lz(ctrl_signal_triosy_lz),
      .run_wten(run_wten),
      .ctrl_signal_triosy_obj_iswt0(ctrl_signal_triosy_obj_iswt0)
    );
  EdgeDetect_IP_Denoise_IP_run_staller EdgeDetect_IP_Denoise_IP_run_staller_inst
      (
      .clk(clk),
      .rst(rst),
      .arst_n(arst_n),
      .run_wen(run_wen),
      .run_wten(run_wten),
      .dat_in_rsci_wen_comp(dat_in_rsci_wen_comp),
      .dat_out_rsci_wen_comp(dat_out_rsci_wen_comp)
    );
  EdgeDetect_IP_Denoise_IP_run_run_fsm EdgeDetect_IP_Denoise_IP_run_run_fsm_inst
      (
      .clk(clk),
      .rst(rst),
      .arst_n(arst_n),
      .run_wen(run_wen),
      .fsm_output(fsm_output),
      .VCOL_C_0_tr0(nl_EdgeDetect_IP_Denoise_IP_run_run_fsm_inst_VCOL_C_0_tr0),
      .VROW_C_0_tr0(VROW_equal_tmp)
    );
  assign VROW_y_or_cse = (fsm_output[0]) | (fsm_output[2]);
  assign or_703_cse = (~(lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_0 | (~
      lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_1) | operator_4_false_2_acc_itm_3
      | operator_4_false_1_acc_itm_2)) | (VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1!=2'b10);
  assign nor_198_nl = ~(VCOL_else_4_else_aif_equal_tmp | (~((ctrl_signal_rsci_idat!=2'b10))));
  assign mux_134_cse = MUX_s_1_2_2(or_703_cse, nor_198_nl, exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1);
  assign or_357_cse = (ctrl_signal_rsci_idat!=2'b10);
  assign operator_10_false_1_and_cse = run_wen & VCOL_aelse_VCOL_aelse_and_cse;
  assign operator_11_false_6_and_cse = run_wen & (~ mux_tmp_6) & VCOL_stage_0_1;
  assign or_704_cse = (VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1!=2'b10);
  assign or_705_cse = VCOL_else_4_else_aif_equal_tmp | (ctrl_signal_rsci_idat!=2'b10);
  assign mux_139_nl = MUX_s_1_2_2(or_704_cse, or_705_cse, exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1);
  assign and_274_cse = (~(mux_139_nl & VCOL_stage_0_2)) & and_dcpl_69;
  assign mux_15_nl = MUX_s_1_2_2(or_703_cse, nor_62_cse, exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1);
  assign mux_16_nl = MUX_s_1_2_2(mux_tmp_3, mux_15_nl, VCOL_stage_0_2);
  assign VCOL_if_6_and_1_cse = run_wen & mux_16_nl & VCOL_stage_0_1;
  assign or_40_cse = (~ lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3) | exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva;
  assign tmp_pix_and_27_rgt = VCOL_stage_0_2 & and_dcpl_21 & (fsm_output[1]);
  assign j_or_1_rgt = (~ (fsm_output[1])) | or_dcpl_3;
  assign or_368_cse = (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_1) | lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_0;
  assign or_49_cse = (ctrl_signal_rsci_idat!=2'b10) | operator_4_false_acc_itm_3;
  assign or_46_cse = VCOL_else_4_else_aif_equal_tmp | (ctrl_signal_rsci_idat!=2'b10)
      | operator_4_false_acc_itm_3;
  assign or_52_cse = operator_4_false_1_acc_itm_2 | operator_4_false_2_acc_itm_3;
  assign and_254_cse = VCOL_stage_0_2 & exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva;
  assign or_205_nl = exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva | (~ lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1_mx0w0);
  assign mux_107_nl = MUX_s_1_2_2(exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva,
      or_205_nl, VCOL_stage_0_2);
  assign mux_108_nl = MUX_s_1_2_2(and_254_cse, mux_107_nl, VCOL_stage_0_1);
  assign and_131_rmff = mux_108_nl & (fsm_output[1]);
  assign nand_45_nl = ~(exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva & (VCOL_x_sva[0]));
  assign or_208_nl = (~ VCOL_else_5_else_if_for_1_mux_81_tmp_0) | (~ exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1)
      | VCOL_else_4_else_aif_equal_tmp;
  assign mux_111_nl = MUX_s_1_2_2(nand_45_nl, or_208_nl, VCOL_stage_0_2);
  assign mux_112_cse = MUX_s_1_2_2(mux_111_nl, mux_tmp_6, operator_11_false_4_operator_11_false_4_nor_tmp);
  assign and_65_nl = VCOL_stage_0_2 & nor_tmp_47;
  assign and_256_nl = (VCOL_x_sva[0]) & exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva;
  assign or_337_nl = (~((~ VCOL_else_5_else_if_for_1_mux_81_tmp_0) | (~ exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1)
      | VCOL_else_4_else_aif_equal_tmp)) | nor_tmp_47;
  assign mux_114_nl = MUX_s_1_2_2(and_256_nl, or_337_nl, VCOL_stage_0_2);
  assign nand_2_nl = ~(lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1_mx0w0
      & (~ nor_tmp_47));
  assign mux_113_nl = MUX_s_1_2_2(exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva,
      nand_2_nl, VCOL_stage_0_2);
  assign or_209_nl = (VROW_y_sva!=10'b0000000000) | operator_11_false_4_operator_11_false_4_nor_tmp;
  assign mux_115_nl = MUX_s_1_2_2(mux_114_nl, mux_113_nl, or_209_nl);
  assign mux_116_nl = MUX_s_1_2_2(and_65_nl, mux_115_nl, VCOL_stage_0_1);
  assign and_143_rmff = mux_116_nl & (fsm_output[1]);
  assign VCOL_and_46_cse = run_wen & (~(or_dcpl_42 | (~ (fsm_output[1]))));
  assign nand_82_cse = ~(reg_operator_11_false_6_nor_itm_1_cse & (VCOL_x_sva[0]));
  assign and_450_cse = VROW_equal_tmp & reg_operator_11_false_6_nor_itm_1_cse;
  assign or_384_cse = (VCOL_x_sva[10:1]!=10'b0000000000);
  assign and_cse = VCOL_land_1_lpi_3_dfm_1 & exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva;
  assign nor_211_cse = ~((VCOL_x_sva!=11'b00000000001));
  assign or_388_cse = (~ exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1) | operator_11_false_4_operator_11_false_4_nor_cse_lpi_3_dfm_1;
  assign and_457_cse = (VCOL_x_sva[0]) & VROW_equal_tmp & reg_operator_11_false_6_nor_itm_1_cse;
  assign VCOL_else_5_else_if_for_1_and_39_cse = operator_11_false_4_operator_11_false_4_nor_cse_sva_1
      & exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva;
  assign nand_nl = ~(operator_11_false_4_operator_11_false_4_nor_tmp & (~ mux_tmp_6));
  assign mux_11_nl = MUX_s_1_2_2(nand_nl, mux_112_cse, operator_11_false_1_nor_tmp);
  assign rdbuf0_pix_and_1_cse = run_wen & (((VCOL_x_sva[0]) & (~ operator_11_false_4_operator_11_false_4_nor_cse_sva_1)
      & exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva) | VCOL_else_5_else_if_for_1_and_39_cse)
      & VCOL_stage_0_2 & (fsm_output[1]) & (mux_11_nl | (~ VCOL_stage_0_1));
  assign nor_79_cse = ~(operator_4_false_2_acc_itm_3 | operator_4_false_1_acc_itm_2);
  assign or_429_cse = (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_0) | (max_i_lpi_3[3:2]!=2'b00)
      | (~ VCOL_stage_0_1);
  assign or_444_cse = (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_0) | (max_i_lpi_3[3])
      | not_tmp_188;
  assign or_516_cse = (max_i_lpi_3!=4'b0000);
  assign nor_33_cse = ~(exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva | (~ lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3));
  assign nor_50_nl = ~(operator_4_false_1_acc_itm_2 | operator_4_false_2_acc_itm_3
      | (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_1));
  assign mux_123_nl = MUX_s_1_2_2(or_357_cse, nor_50_nl, nor_33_cse);
  assign or_237_nl = (~((~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_1) |
      operator_4_false_1_acc_itm_2 | operator_4_false_2_acc_itm_3)) | (VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1!=2'b10);
  assign mux_122_nl = MUX_s_1_2_2(or_237_nl, or_705_cse, exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1);
  assign mux_124_nl = MUX_s_1_2_2(mux_123_nl, mux_122_nl, VCOL_stage_0_2);
  assign and_81_m1c = (~ mux_124_nl) & VCOL_stage_0_1;
  assign nor_244_cse = ~(operator_4_false_1_acc_itm_2 | lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_0);
  assign or_554_cse = (i_lpi_3_dfm_4_1!=4'b0000);
  assign nand_89_cse = ~(exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1 & VCOL_stage_0_1);
  assign or_634_cse = (~(lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_0 | (~
      lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_1))) | (VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1[0]);
  assign or_633_cse = (~((~((VROW_y_sva!=10'b0000000001) | (VCOL_x_sva_2!=11'b00000000001)))
      | (ctrl_signal_rsci_idat!=2'b10))) | (~ VCOL_stage_0_1) | VCOL_else_4_else_aif_equal_tmp;
  assign VCOL_x_and_cse = exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1 & VCOL_stage_0_2;
  assign VCOL_x_sva_mx1 = MUX_v_11_2_2(VCOL_x_sva, VCOL_x_sva_2, VCOL_x_and_cse);
  assign nl_operator_42_40_true_AC_TRN_AC_WRAP_acc_nl = conv_u2u_8_10(pix_4_9_2_lpi_3_dfm_1_mx0)
      + conv_u2u_7_10(pix_3_9_2_lpi_3_dfm_11[7:1]) + conv_u2u_7_10(pix_7_9_2_lpi_3_dfm_5_mx0[7:1])
      + conv_u2u_7_10(pix_1_9_2_lpi_3_dfm_9_mx1w0[7:1]) + conv_u2u_7_10(pix_5_9_2_lpi_3_dfm_6_mx0[7:1]);
  assign operator_42_40_true_AC_TRN_AC_WRAP_acc_nl = nl_operator_42_40_true_AC_TRN_AC_WRAP_acc_nl[9:0];
  assign pix_result_9_2_lpi_3_dfm_2_mx0w0 = MUX1HOT_v_8_4_2(pix_4_9_2_lpi_3_dfm_1_mx0,
      (readslicef_10_8_2(operator_42_40_true_AC_TRN_AC_WRAP_acc_nl)), pix_result_9_2_lpi_3,
      VCOL_else_5_else_if_slc_max_val_9_2_itm_1, {VCOL_equal_tmp_1 , VCOL_equal_tmp_1_1
      , VCOL_or_1_itm_1 , VCOL_and_22_itm_1});
  assign VCOL_else_5_else_if_for_1_and_55_ssc_1 = operator_4_false_acc_itm_3 & (~
      VCOL_else_5_else_if_for_1_equal_tmp_mx0w1);
  assign lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_1_mx1 = MUX_s_1_2_2(lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_1,
      lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_1, VCOL_stage_0_2);
  assign lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_0_mx1 = MUX_s_1_2_2(lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_0,
      lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_0, VCOL_stage_0_2);
  assign lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1_mx0w0 = VCOL_else_4_else_aif_equal_tmp
      | (~ exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1);
  assign VCOL_else_5_else_if_for_1_equal_tmp_mx0w1 = lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_1_mx1
      & lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_2 & (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_0_mx1);
  assign exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva_mx1 = MUX_s_1_2_2(exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva,
      (~ lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1_mx0w0), VCOL_stage_0_2);
  assign VCOL_aelse_VCOL_aelse_and_cse = VCOL_stage_0_1 & nand_6_cse;
  assign nl_operator_4_false_1_acc_nl = j_2_0_sva_2 + 3'b011;
  assign operator_4_false_1_acc_nl = nl_operator_4_false_1_acc_nl[2:0];
  assign operator_4_false_1_acc_itm_2 = readslicef_3_1_2(operator_4_false_1_acc_nl);
  assign operator_10_false_1_operator_10_false_1_and_cse_sva_1 = (VROW_y_sva==10'b0000000001);
  assign operator_11_false_1_nor_tmp = ~((VCOL_x_sva_mx1[10:1]!=10'b0000000000));
  assign VCOL_asn_80_rgt = (~ operator_4_false_2_acc_itm_3) & VCOL_else_5_else_if_for_1_equal_tmp_mx0w1
      & VCOL_equal_tmp_6;
  assign mux_106_nl = MUX_s_1_2_2(or_40_cse, exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1,
      VCOL_stage_0_2);
  assign VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1_mx0 = MUX_v_2_2_2(VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1,
      ctrl_signal_rsci_idat, mux_106_nl);
  assign nor_124_nl = ~((~ exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva) | (VCOL_x_sva[0]));
  assign nor_125_nl = ~(VCOL_else_5_else_if_for_1_mux_81_tmp_0 | (~ exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1)
      | VCOL_else_4_else_aif_equal_tmp);
  assign mux_110_cse = MUX_s_1_2_2(nor_124_nl, nor_125_nl, VCOL_stage_0_2);
  assign VCOL_else_5_else_if_for_1_and_110_nl = (~ operator_11_false_4_operator_11_false_4_nor_cse_lpi_3_dfm_1)
      & exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1;
  assign VCOL_else_5_else_if_for_1_and_111_nl = operator_11_false_4_operator_11_false_4_nor_cse_lpi_3_dfm_1
      & exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1;
  assign VCOL_VCOL_slc_pix_dummy_5_9_2_lpi_3_dfm_mx1w0 = MUX1HOT_v_8_3_2(VCOL_VCOL_slc_pix_dummy_5_9_2_lpi_4,
      pix_1_9_2_lpi_3_dfm_9_mx1w0, pix_4_9_2_lpi_3_dfm_1_mx0, {(~ exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1)
      , VCOL_else_5_else_if_for_1_and_110_nl , VCOL_else_5_else_if_for_1_and_111_nl});
  assign operator_11_false_4_operator_11_false_4_nor_tmp = ~((VCOL_x_sva_mx1!=11'b00000000000));
  assign VCOL_else_5_else_if_for_1_and_126_nl = (~ VCOL_or_4_tmp_1) & exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva;
  assign VCOL_else_5_else_if_for_1_and_127_nl = VCOL_or_4_tmp_1 & exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva;
  assign pix_1_9_2_lpi_3_dfm_9_mx1w0 = MUX1HOT_v_8_3_2(pix_1_9_2_lpi_3, pix_1_9_2_lpi_3_dfm_10,
      pix_4_9_2_lpi_3_dfm_mx0, {(~ exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva)
      , VCOL_else_5_else_if_for_1_and_126_nl , VCOL_else_5_else_if_for_1_and_127_nl});
  assign VCOL_equal_tmp_4 = ~((VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1_mx0!=2'b00));
  assign VCOL_equal_tmp_5 = (VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1_mx0==2'b01);
  assign VCOL_else_5_else_if_for_1_not_151_nl = ~ operator_4_false_1_acc_itm_2;
  assign max_val_lpi_3_dfm_3_9_2_1 = MUX_v_8_2_2(8'b00000000, max_val_lpi_3_dfm_1_9_2_mx0,
      VCOL_else_5_else_if_for_1_not_151_nl);
  assign VCOL_else_5_else_if_for_1_and_128_nl = (~ VCOL_land_lpi_3_dfm_1) & VCOL_else_5_else_if_for_1_or_3_m1c_1;
  assign VCOL_else_5_else_if_for_1_and_129_nl = VCOL_land_lpi_3_dfm_1 & VCOL_else_5_else_if_for_1_or_3_m1c_1;
  assign VCOL_else_5_else_if_for_1_and_117_nl = ((VCOL_else_4_else_else_else_else_else_and_tmp_1
      & VCOL_else_4_else_else_and_m1c_1) | VCOL_else_4_and_1_cse_1) & VCOL_else_5_else_if_for_1_and_98_m1c_1;
  assign VCOL_else_5_else_if_for_1_and_118_nl = ((VROW_equal_tmp & VCOL_else_4_else_else_and_3_m1c_1
      & VCOL_else_4_VCOL_else_4_nor_m1c_1) | and_457_cse) & VCOL_else_5_else_if_for_1_and_98_m1c_1;
  assign VCOL_else_4_and_10_nl = VCOL_else_4_else_else_land_lpi_3_dfm_1 & VCOL_else_4_VCOL_else_4_nor_m1c_1
      & VCOL_else_5_else_if_for_1_and_98_m1c_1;
  assign pix_2_9_2_lpi_3_dfm_8_mx0w0 = MUX1HOT_v_8_6_2(pix_2_9_2_lpi_3, uint_pix_2_lpi_3,
      dat_in_rsci_idat_mxwt, pix_5_9_2_lpi_3, pix_1_9_2_lpi_3_dfm_10, pix_4_9_2_lpi_3_dfm_mx0,
      {(~ exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva) , VCOL_else_5_else_if_for_1_and_128_nl
      , VCOL_else_5_else_if_for_1_and_129_nl , VCOL_else_5_else_if_for_1_and_117_nl
      , VCOL_else_5_else_if_for_1_and_118_nl , VCOL_else_4_and_10_nl});
  assign tmp_pix_and_28_nl = VCOL_else_5_else_if_for_and_stg_1_1_sva_1 & (i_1_lpi_3_dfm_1[3:2]==2'b00)
      & (~ lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3) & VCOL_equal_tmp_2_1
      & VCOL_stage_0_2;
  assign tmp_pix_1_9_2_lpi_3_mx1 = MUX_v_8_2_2(tmp_pix_1_9_2_lpi_3, VCOL_else_5_else_if_for_VCOL_else_5_else_if_for_VCOL_else_5_else_if_for_mux_psp_sva_1,
      tmp_pix_and_28_nl);
  assign tmp_pix_and_29_nl = VCOL_else_5_else_if_for_and_stg_1_1_sva_1 & (i_1_lpi_3_dfm_1[3:2]==2'b01)
      & (~ lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3) & VCOL_equal_tmp_2_1
      & VCOL_stage_0_2;
  assign tmp_pix_5_9_2_lpi_3_mx1 = MUX_v_8_2_2(tmp_pix_5_9_2_lpi_3, VCOL_else_5_else_if_for_VCOL_else_5_else_if_for_VCOL_else_5_else_if_for_mux_psp_sva_1,
      tmp_pix_and_29_nl);
  assign tmp_pix_and_30_nl = VCOL_else_5_else_if_for_and_stg_1_2_sva_1 & (i_1_lpi_3_dfm_1[3:2]==2'b00)
      & (~ lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3) & VCOL_equal_tmp_2_1
      & VCOL_stage_0_2;
  assign tmp_pix_2_9_2_lpi_3_mx1 = MUX_v_8_2_2(tmp_pix_2_9_2_lpi_3, VCOL_else_5_else_if_for_VCOL_else_5_else_if_for_VCOL_else_5_else_if_for_mux_psp_sva_1,
      tmp_pix_and_30_nl);
  assign tmp_pix_and_31_nl = VCOL_else_5_else_if_for_and_stg_1_2_sva_1 & (i_1_lpi_3_dfm_1[3:2]==2'b01)
      & (~ lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3) & VCOL_equal_tmp_2_1
      & VCOL_stage_0_2;
  assign tmp_pix_6_9_2_lpi_3_mx1 = MUX_v_8_2_2(tmp_pix_6_9_2_lpi_3, VCOL_else_5_else_if_for_VCOL_else_5_else_if_for_VCOL_else_5_else_if_for_mux_psp_sva_1,
      tmp_pix_and_31_nl);
  assign tmp_pix_and_32_nl = VCOL_else_5_else_if_for_and_stg_1_3_sva_1 & (i_1_lpi_3_dfm_1[3:2]==2'b00)
      & (~ lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3) & VCOL_equal_tmp_2_1
      & VCOL_stage_0_2;
  assign tmp_pix_3_9_2_lpi_3_mx1 = MUX_v_8_2_2(tmp_pix_3_9_2_lpi_3, VCOL_else_5_else_if_for_VCOL_else_5_else_if_for_VCOL_else_5_else_if_for_mux_psp_sva_1,
      tmp_pix_and_32_nl);
  assign tmp_pix_and_33_nl = VCOL_else_5_else_if_for_and_stg_1_3_sva_1 & (i_1_lpi_3_dfm_1[3:2]==2'b01)
      & (~ lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3) & VCOL_equal_tmp_2_1
      & VCOL_stage_0_2;
  assign tmp_pix_7_9_2_lpi_3_mx1 = MUX_v_8_2_2(tmp_pix_7_9_2_lpi_3, VCOL_else_5_else_if_for_VCOL_else_5_else_if_for_VCOL_else_5_else_if_for_mux_psp_sva_1,
      tmp_pix_and_33_nl);
  assign tmp_pix_and_34_nl = VCOL_else_5_else_if_for_and_stg_2_0_sva_1 & (~ (i_1_lpi_3_dfm_1[3]))
      & (~ lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3) & VCOL_equal_tmp_2_1
      & VCOL_stage_0_2;
  assign tmp_pix_0_9_2_lpi_3_mx0 = MUX_v_8_2_2(tmp_pix_0_9_2_lpi_3, VCOL_else_5_else_if_for_VCOL_else_5_else_if_for_VCOL_else_5_else_if_for_mux_psp_sva_1,
      tmp_pix_and_34_nl);
  assign tmp_pix_and_35_nl = VCOL_else_5_else_if_for_and_stg_2_0_sva_1 & (i_1_lpi_3_dfm_1[3])
      & (~ lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3) & VCOL_equal_tmp_2_1
      & VCOL_stage_0_2;
  assign tmp_pix_8_9_2_lpi_3_mx1 = MUX_v_8_2_2(tmp_pix_8_9_2_lpi_3, VCOL_else_5_else_if_for_VCOL_else_5_else_if_for_VCOL_else_5_else_if_for_mux_psp_sva_1,
      tmp_pix_and_35_nl);
  assign tmp_pix_and_36_nl = VCOL_else_5_else_if_for_and_stg_1_0_sva_1 & (i_1_lpi_3_dfm_1[3:2]==2'b01)
      & (~ lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3) & VCOL_equal_tmp_2_1
      & VCOL_stage_0_2;
  assign tmp_pix_4_9_2_lpi_3_mx1 = MUX_v_8_2_2(tmp_pix_4_9_2_lpi_3, VCOL_else_5_else_if_for_VCOL_else_5_else_if_for_VCOL_else_5_else_if_for_mux_psp_sva_1,
      tmp_pix_and_36_nl);
  assign tmp_pix_0_1_0_lpi_3_mx1 = MUX_v_2_2_2(tmp_pix_0_1_0_lpi_3, tmp_pix_0_1_0_lpi_3_dfm_2_1,
      VCOL_stage_0_2);
  assign tmp_pix_1_1_0_lpi_3_mx1 = MUX_v_2_2_2(j_2_0_lpi_3_dfm_3_1_1_0, tmp_pix_1_1_0_lpi_3_dfm_2_1,
      VCOL_stage_0_2);
  assign tmp_pix_2_1_0_lpi_3_mx1 = MUX_v_2_2_2(tmp_pix_2_1_0_lpi_3, tmp_pix_2_1_0_lpi_3_dfm_2_1,
      VCOL_stage_0_2);
  assign tmp_pix_3_1_0_lpi_3_mx1 = MUX_v_2_2_2(tmp_pix_3_1_0_lpi_3, tmp_pix_3_1_0_lpi_3_dfm_2_1,
      VCOL_stage_0_2);
  assign tmp_pix_4_1_0_lpi_3_mx1 = MUX_v_2_2_2(tmp_pix_4_1_0_lpi_3, tmp_pix_4_1_0_lpi_3_dfm_2_1,
      VCOL_stage_0_2);
  assign tmp_pix_5_1_0_lpi_3_mx1 = MUX_v_2_2_2(tmp_pix_5_1_0_lpi_3, tmp_pix_5_1_0_lpi_3_dfm_2_1,
      VCOL_stage_0_2);
  assign tmp_pix_6_1_0_lpi_3_mx1 = MUX_v_2_2_2(tmp_pix_6_1_0_lpi_3, tmp_pix_6_1_0_lpi_3_dfm_2_1,
      VCOL_stage_0_2);
  assign tmp_pix_7_1_0_lpi_3_mx1 = MUX_v_2_2_2(tmp_pix_7_1_0_lpi_3, tmp_pix_7_1_0_lpi_3_dfm_2_1,
      VCOL_stage_0_2);
  assign tmp_pix_8_1_0_lpi_3_mx1 = MUX_v_2_2_2(tmp_pix_8_1_0_lpi_3, tmp_pix_8_1_0_lpi_3_dfm_2_1,
      VCOL_stage_0_2);
  assign VCOL_else_5_else_if_for_1_nand_10_nl = ~(exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva
      & (~(VCOL_lor_lpi_3_dfm_1 & (~ operator_11_false_4_operator_11_false_4_nor_cse_sva_1)
      & VCOL_else_5_else_if_for_1_or_m1c_1)));
  assign VCOL_else_5_else_if_for_1_and_124_nl = (~((VCOL_x_sva[0]) | VCOL_lor_lpi_3_dfm_1
      | operator_11_false_4_operator_11_false_4_nor_cse_sva_1)) & VCOL_else_5_else_if_for_1_or_m1c_1;
  assign VCOL_and_14_nl = (VCOL_x_sva[0]) & (~ VCOL_lor_lpi_3_dfm_1) & (~ operator_11_false_4_operator_11_false_4_nor_cse_sva_1)
      & VCOL_else_5_else_if_for_1_or_m1c_1;
  assign VCOL_else_5_else_if_for_1_and_125_nl = operator_11_false_4_operator_11_false_4_nor_cse_sva_1
      & VCOL_else_5_else_if_for_1_or_m1c_1;
  assign VCOL_else_5_else_if_for_1_and_113_nl = ((VCOL_else_4_else_aif_equal_tmp
      & (~ operator_10_false_1_operator_10_false_1_and_cse_sva_1_1) & VCOL_else_4_else_else_else_and_tmp_1)
      | VCOL_else_4_else_else_land_lpi_3_dfm_1) & VCOL_and_m1c_1;
  assign VCOL_else_5_else_if_for_1_or_1_nl = (operator_10_false_1_operator_10_false_1_and_cse_sva_1_1
      & VCOL_else_4_else_else_else_and_tmp_1 & VCOL_and_m1c_1) | and_cse;
  assign VCOL_and_17_nl = VCOL_else_4_else_land_lpi_3_dfm_1 & VCOL_VCOL_nor_1_m1c_1
      & exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva;
  assign pix_0_9_2_lpi_3_dfm_9_mx1w0 = MUX1HOT_v_8_7_2(pix_0_9_2_lpi_3, (rdbuf1_pix_lpi_3[7:0]),
      (rdbuf1_pix_lpi_3[15:8]), (line_buf1_rsci_q_d[15:8]), pix_3_9_2_lpi_3_dfm_mx0,
      pix_1_9_2_lpi_3_dfm_10, pix_4_9_2_lpi_3_dfm_mx0, {VCOL_else_5_else_if_for_1_nand_10_nl
      , VCOL_else_5_else_if_for_1_and_124_nl , VCOL_and_14_nl , VCOL_else_5_else_if_for_1_and_125_nl
      , VCOL_else_5_else_if_for_1_and_113_nl , VCOL_else_5_else_if_for_1_or_1_nl
      , VCOL_and_17_nl});
  assign VCOL_VCOL_oelse_operator_11_false_or_tmp = (VCOL_x_sva_mx1!=11'b00000000000);
  assign i_1_lpi_3_dfm_3 = MUX_v_4_2_2(4'b0000, max_i_lpi_3, lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_2);
  assign VCOL_equal_tmp_6 = (VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1_mx0==2'b10);
  assign nl_operator_4_false_2_acc_nl = i_sva_2 + 4'b0111;
  assign operator_4_false_2_acc_nl = nl_operator_4_false_2_acc_nl[3:0];
  assign operator_4_false_2_acc_itm_3 = readslicef_4_1_3(operator_4_false_2_acc_nl);
  assign max_i_lpi_3_mx1 = MUX_v_4_2_2(max_i_lpi_3, max_i_lpi_3_dfm_2_1, VCOL_stage_0_2);
  assign nl_operator_11_false_acc_nl = ({1'b1 , widthIn}) + conv_u2s_11_12(~ VCOL_x_sva_mx1);
  assign operator_11_false_acc_nl = nl_operator_11_false_acc_nl[11:0];
  assign operator_11_false_acc_itm_11_1 = readslicef_12_1_11(operator_11_false_acc_nl);
  assign nl_operator_10_false_acc_nl = ({1'b1 , heightIn}) + conv_u2s_10_11(~ VROW_y_sva);
  assign operator_10_false_acc_nl = nl_operator_10_false_acc_nl[10:0];
  assign operator_10_false_acc_itm_10_1 = readslicef_11_1_10(operator_10_false_acc_nl);
  assign lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_3_1_1 = (~(nor_79_cse | VCOL_else_5_else_if_for_1_and_55_ssc_1))
      | (~(operator_4_false_acc_itm_3 | VCOL_else_5_else_if_for_1_equal_tmp_mx0w1));
  assign nl_operator_4_false_acc_nl = i_1_sva_2 + 4'b0111;
  assign operator_4_false_acc_nl = nl_operator_4_false_acc_nl[3:0];
  assign operator_4_false_acc_itm_3 = readslicef_4_1_3(operator_4_false_acc_nl);
  assign nl_i_1_sva_2 = i_1_lpi_3_dfm_3 + 4'b0001;
  assign i_1_sva_2 = nl_i_1_sva_2[3:0];
  assign VCOL_else_5_else_if_for_1_mux_4_nl = MUX_s_1_2_2(lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3,
      lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1_mx0w0, VCOL_stage_0_2);
  assign lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_2 = VCOL_else_5_else_if_for_1_mux_4_nl
      & (~ exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva_mx1);
  assign VCOL_equal_tmp_7 = (VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1_mx0==2'b11);
  assign nl_j_2_0_sva_2 = ({j_2_0_lpi_3_dfm_3_1_2 , j_2_0_lpi_3_dfm_3_1_1_0}) + 3'b001;
  assign j_2_0_sva_2 = nl_j_2_0_sva_2[2:0];
  assign nl_i_sva_2 = i_lpi_3_dfm_4_1 + 4'b0001;
  assign i_sva_2 = nl_i_sva_2[3:0];
  assign pix_4_9_2_lpi_3_dfm_mx0 = MUX_v_8_2_2(pix_4_9_2_lpi_3, (line_buf0_rsci_q_d[7:0]),
      operator_11_false_4_operator_11_false_4_nor_cse_sva_1);
  assign VCOL_VCOL_nor_7_nl = ~((VCOL_x_sva[0]) | reg_operator_11_false_6_nor_itm_1_cse
      | operator_11_false_4_operator_11_false_4_nor_cse_sva_1);
  assign VCOL_and_39_nl = reg_operator_11_false_6_nor_itm_1_cse & (~ operator_11_false_4_operator_11_false_4_nor_cse_sva_1);
  assign pix_1_9_2_lpi_3_dfm_10 = MUX1HOT_v_8_4_2((rdbuf0_pix_lpi_3[7:0]), (rdbuf0_pix_lpi_3[15:8]),
      pix_1_9_2_lpi_3, (line_buf0_rsci_q_d[15:8]), {VCOL_VCOL_nor_7_nl , VCOL_and_16_itm_1
      , VCOL_and_39_nl , operator_11_false_4_operator_11_false_4_nor_cse_sva_1});
  assign nor_120_nl = ~(reg_operator_11_false_6_nor_itm_1_cse | VCOL_else_4_else_else_else_unequal_tmp_1);
  assign and_253_nl = operator_10_false_1_operator_10_false_1_and_cse_sva_1_1 & nand_82_cse;
  assign mux_131_nl = MUX_s_1_2_2(nor_120_nl, and_253_nl, VCOL_else_4_else_aif_equal_tmp);
  assign or_254_nl = mux_131_nl | (~(exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva
      & VROW_equal_tmp)) | VCOL_land_1_lpi_3_dfm_1;
  assign pix_5_9_2_lpi_3_dfm_6_mx0 = MUX_v_8_2_2(pix_4_9_2_lpi_3_dfm_mx0, pix_5_9_2_lpi_3,
      or_254_nl);
  assign and_258_nl = (~(VCOL_else_4_else_aif_equal_tmp & operator_10_false_1_operator_10_false_1_and_cse_sva_1_1))
      & VCOL_else_4_else_else_else_nor_1_tmp;
  assign or_255_nl = reg_operator_11_false_6_nor_itm_1_cse | VCOL_else_4_else_else_else_nor_1_tmp;
  assign mux_132_nl = MUX_s_1_2_2(or_255_nl, reg_operator_11_false_6_nor_itm_1_cse,
      VCOL_else_4_else_aif_equal_tmp);
  assign mux_133_nl = MUX_s_1_2_2(and_258_nl, mux_132_nl, VROW_equal_tmp);
  assign nand_51_nl = ~(((mux_133_nl & (VCOL_x_sva[0])) | VCOL_land_1_lpi_3_dfm_1)
      & exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva);
  assign pix_7_9_2_lpi_3_dfm_5_mx0 = MUX_v_8_2_2(pix_4_9_2_lpi_3_dfm_mx0, pix_7_9_2_lpi_3,
      nand_51_nl);
  assign VCOL_else_4_else_else_else_nor_1_tmp = ~((VCOL_x_sva[10:1]!=10'b0000000000));
  assign VCOL_else_4_else_else_else_unequal_tmp_1 = ~((VCOL_x_sva[0]) & VCOL_else_4_else_else_else_nor_1_tmp);
  assign VCOL_else_4_else_else_land_lpi_3_dfm_1 = VCOL_else_4_else_aif_equal_tmp
      & VROW_equal_tmp;
  assign VCOL_else_4_else_aif_equal_tmp = VCOL_x_sva == widthIn;
  assign VCOL_else_4_else_land_lpi_3_dfm_1 = VCOL_else_4_else_aif_equal_tmp & operator_10_false_1_operator_10_false_1_and_cse_sva_1_1;
  assign VROW_equal_tmp = VROW_y_sva == heightIn;
  assign VCOL_VCOL_nor_5_m1c_1 = ~(VCOL_else_4_else_land_lpi_3_dfm_1 | VCOL_or_tmp_1);
  assign VCOL_or_tmp_1 = and_457_cse | VCOL_land_1_lpi_3_dfm_1;
  assign VCOL_VCOL_nor_1_m1c_1 = ~(and_457_cse | VCOL_land_1_lpi_3_dfm_1);
  assign nand_44_nl = ~(exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva & operator_11_false_4_operator_11_false_4_nor_cse_sva_1);
  assign pix_4_9_2_lpi_3_dfm_1_mx0 = MUX_v_8_2_2((line_buf0_rsci_q_d[7:0]), pix_4_9_2_lpi_3,
      nand_44_nl);
  assign VCOL_else_5_else_if_for_1_nand_12_nl = ~(exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva
      & (~((~ operator_11_false_4_operator_11_false_4_nor_cse_sva_1) & VCOL_else_5_else_if_for_1_and_130_m1c_1)));
  assign VCOL_else_5_else_if_for_1_and_134_nl = operator_11_false_4_operator_11_false_4_nor_cse_sva_1
      & VCOL_else_5_else_if_for_1_and_130_m1c_1;
  assign VCOL_else_5_else_if_for_1_and_131_nl = VCOL_or_6_tmp_1 & exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva;
  assign pix_3_9_2_lpi_3_dfm_11 = MUX1HOT_v_8_3_2(pix_3_9_2_lpi_3, (line_buf1_rsci_q_d[7:0]),
      pix_4_9_2_lpi_3_dfm_mx0, {VCOL_else_5_else_if_for_1_nand_12_nl , VCOL_else_5_else_if_for_1_and_134_nl
      , VCOL_else_5_else_if_for_1_and_131_nl});
  assign nl_VCOL_x_sva_2 = VCOL_x_sva + 11'b00000000001;
  assign VCOL_x_sva_2 = nl_VCOL_x_sva_2[10:0];
  assign VCOL_else_4_and_1_cse_1 = VCOL_else_4_else_land_lpi_3_dfm_1 & (~ and_457_cse);
  assign VCOL_else_5_else_if_for_1_and_130_m1c_1 = (~ VCOL_or_6_tmp_1) & exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva;
  assign VCOL_or_6_tmp_1 = (operator_10_false_1_operator_10_false_1_and_cse_sva_1_1
      & (~ VROW_equal_tmp) & VCOL_else_4_else_else_else_unequal_tmp_1 & (~(VCOL_else_4_else_else_land_lpi_3_dfm_1
      | VCOL_else_4_else_land_lpi_3_dfm_1)) & VCOL_VCOL_nor_1_m1c_1) | (VCOL_else_4_else_land_lpi_3_dfm_1
      & VCOL_VCOL_nor_1_m1c_1) | VCOL_land_1_lpi_3_dfm_1;
  assign VCOL_or_4_tmp_1 = (VCOL_else_4_else_aif_equal_tmp & VCOL_else_4_else_else_else_unequal_tmp_1
      & (~ VCOL_else_4_else_else_land_lpi_3_dfm_1) & VCOL_VCOL_nor_5_m1c_1) | (VCOL_else_4_else_else_land_lpi_3_dfm_1
      & VCOL_VCOL_nor_5_m1c_1) | (VCOL_else_4_else_land_lpi_3_dfm_1 & (~ VCOL_or_tmp_1));
  assign VCOL_and_6_ssc_1 = (~ VCOL_else_5_else_if_for_1_equal_tmp_mx0w1) & VCOL_equal_tmp_6;
  assign VCOL_and_7_ssc_1 = VCOL_else_5_else_if_for_1_equal_tmp_mx0w1 & VCOL_equal_tmp_6;
  assign VCOL_else_4_else_else_and_3_m1c_1 = VCOL_else_4_else_else_else_unequal_tmp_1
      & (~ VCOL_else_4_else_else_land_lpi_3_dfm_1);
  assign VCOL_else_4_else_else_and_m1c_1 = (~ VROW_equal_tmp) & VCOL_else_4_else_else_and_3_m1c_1
      & VCOL_else_4_VCOL_else_4_nor_m1c_1;
  assign VCOL_else_4_VCOL_else_4_nor_m1c_1 = ~(VCOL_else_4_else_land_lpi_3_dfm_1
      | and_457_cse);
  assign VCOL_else_4_else_else_else_else_else_and_tmp_1 = VCOL_else_4_else_aif_equal_tmp
      & (~ operator_10_false_1_operator_10_false_1_and_cse_sva_1_1);
  assign VCOL_else_5_else_if_for_1_or_3_m1c_1 = ((VCOL_else_4_and_9_cse_1 | ((~ VCOL_else_4_else_else_else_else_else_and_tmp_1)
      & VCOL_else_4_else_else_and_m1c_1)) & VCOL_else_5_else_if_for_1_and_98_m1c_1)
      | and_cse;
  assign VCOL_else_5_else_if_for_1_and_98_m1c_1 = (~ VCOL_land_1_lpi_3_dfm_1) & exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva;
  assign VCOL_else_4_and_9_cse_1 = VCOL_else_4_else_else_VCOL_else_4_else_else_nor_1_cse_1
      & VCOL_else_4_VCOL_else_4_nor_m1c_1;
  assign VCOL_else_4_else_else_VCOL_else_4_else_else_nor_1_cse_1 = ~(VCOL_else_4_else_else_else_unequal_tmp_1
      | VCOL_else_4_else_else_land_lpi_3_dfm_1);
  assign max_val_lpi_3_dfm_1_9_2_mx0 = MUX_v_8_2_2(max_val_lpi_3_dfm_5_1_9_2, VCOL_else_5_else_if_for_1_for_slc_tmp_pix_10_9_0_cse_sva_9_2_1,
      VCOL_else_5_else_if_for_1_for_if_acc_itm_10);
  assign VCOL_else_5_else_if_for_1_for_slc_tmp_pix_10_9_0_cse_sva_9_2_1 = MUX_v_8_9_2(tmp_pix_0_9_2_lpi_3_mx0,
      tmp_pix_1_9_2_lpi_3_mx1, tmp_pix_2_9_2_lpi_3_mx1, tmp_pix_3_9_2_lpi_3_mx1,
      tmp_pix_4_9_2_lpi_3_mx1, tmp_pix_5_9_2_lpi_3_mx1, tmp_pix_6_9_2_lpi_3_mx1,
      tmp_pix_7_9_2_lpi_3_mx1, tmp_pix_8_9_2_lpi_3_mx1, i_lpi_3_dfm_4_1);
  assign VCOL_else_5_else_if_for_1_for_slc_tmp_pix_10_9_0_cse_sva_1_0_1 = MUX_v_2_9_2(tmp_pix_0_1_0_lpi_3_mx1,
      tmp_pix_1_1_0_lpi_3_mx1, tmp_pix_2_1_0_lpi_3_mx1, tmp_pix_3_1_0_lpi_3_mx1,
      tmp_pix_4_1_0_lpi_3_mx1, tmp_pix_5_1_0_lpi_3_mx1, tmp_pix_6_1_0_lpi_3_mx1,
      tmp_pix_7_1_0_lpi_3_mx1, tmp_pix_8_1_0_lpi_3_mx1, i_lpi_3_dfm_4_1);
  assign pix_3_9_2_lpi_3_dfm_mx0 = MUX_v_8_2_2(pix_3_9_2_lpi_3, (line_buf1_rsci_q_d[7:0]),
      operator_11_false_4_operator_11_false_4_nor_cse_sva_1);
  assign VCOL_else_4_else_else_else_and_tmp_1 = (~ VROW_equal_tmp) & VCOL_else_4_else_else_else_unequal_tmp_1;
  assign VCOL_else_4_else_else_and_7_m1c_1 = VCOL_else_4_else_else_else_unequal_tmp_1
      & (~ VCOL_else_4_else_else_land_lpi_3_dfm_1) & VCOL_else_4_VCOL_else_4_nor_m1c_1;
  assign VCOL_else_4_else_else_else_else_and_1_tmp_1 = operator_10_false_1_operator_10_false_1_and_cse_sva_1_1
      & (~ VROW_equal_tmp);
  assign VCOL_lor_lpi_3_dfm_1 = ~(nand_82_cse & VCOL_VCOL_oelse_operator_11_false_or_cse_sva_1);
  assign VCOL_else_5_else_if_for_VCOL_else_5_else_if_for_VCOL_else_5_else_if_for_mux_psp_sva_1
      = MUX_v_8_9_2(pix_0_9_2_lpi_3_dfm_9_mx1w0, pix_1_9_2_lpi_3_dfm_9_mx1w0, pix_2_9_2_lpi_3_dfm_8_mx0w0,
      pix_3_9_2_lpi_3_dfm_11, pix_4_9_2_lpi_3_dfm_1_mx0, pix_5_9_2_lpi_3_dfm_6_mx0,
      pix_6_9_2_lpi_3_dfm_9, pix_7_9_2_lpi_3_dfm_5_mx0, pix_8_9_2_lpi_3_dfm_8, i_1_lpi_3_dfm_1);
  assign VCOL_else_5_else_if_for_and_stg_1_1_sva_1 = (i_1_lpi_3_dfm_1[1:0]==2'b01);
  assign VCOL_else_5_else_if_for_and_stg_1_2_sva_1 = (i_1_lpi_3_dfm_1[1:0]==2'b10);
  assign VCOL_else_5_else_if_for_and_stg_1_3_sva_1 = (i_1_lpi_3_dfm_1[1:0]==2'b11);
  assign VCOL_else_5_else_if_for_and_stg_2_0_sva_1 = VCOL_else_5_else_if_for_and_stg_1_0_sva_1
      & (~ (i_1_lpi_3_dfm_1[2]));
  assign VCOL_else_5_else_if_for_and_stg_1_0_sva_1 = ~((i_1_lpi_3_dfm_1[1:0]!=2'b00));
  assign VCOL_else_5_else_if_for_1_nand_6_nl = ~(exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva
      & (~((((~ VCOL_else_4_else_else_else_else_and_1_tmp_1) & VCOL_else_4_else_else_and_7_m1c_1)
      | (VCOL_else_4_else_else_land_lpi_3_dfm_1 & VCOL_else_4_VCOL_else_4_nor_m1c_1))
      & VCOL_else_5_else_if_for_1_and_98_m1c_1)));
  assign VCOL_else_5_else_if_for_1_and_119_nl = (VCOL_else_4_and_9_cse_1 | and_457_cse)
      & VCOL_else_5_else_if_for_1_and_98_m1c_1;
  assign VCOL_else_5_else_if_for_1_and_121_nl = ((VCOL_else_4_else_else_else_else_and_1_tmp_1
      & VCOL_else_4_else_else_and_7_m1c_1) | VCOL_else_4_and_1_cse_1) & VCOL_else_5_else_if_for_1_and_98_m1c_1;
  assign pix_6_9_2_lpi_3_dfm_9 = MUX1HOT_v_8_4_2(pix_6_9_2_lpi_3, pix_3_9_2_lpi_3_dfm_mx0,
      pix_7_9_2_lpi_3, pix_4_9_2_lpi_3_dfm_mx0, {VCOL_else_5_else_if_for_1_nand_6_nl
      , VCOL_else_5_else_if_for_1_and_119_nl , VCOL_else_5_else_if_for_1_and_121_nl
      , and_cse});
  assign VCOL_else_5_else_if_for_1_nand_4_nl = ~(exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva
      & (~((VCOL_else_4_else_else_and_m1c_1 | VCOL_else_4_and_1_cse_1) & VCOL_else_5_else_if_for_1_and_98_m1c_1)));
  assign VCOL_else_5_else_if_for_1_or_2_nl = (VCOL_else_4_else_else_VCOL_else_4_else_else_nor_1_cse_1
      & VCOL_else_4_VCOL_else_4_nor_m1c_1 & VCOL_else_5_else_if_for_1_and_98_m1c_1)
      | and_cse;
  assign VCOL_else_4_and_15_nl = ((VROW_equal_tmp & VCOL_else_4_else_else_and_3_m1c_1)
      | VCOL_else_4_else_else_land_lpi_3_dfm_1) & VCOL_else_4_VCOL_else_4_nor_m1c_1
      & VCOL_else_5_else_if_for_1_and_98_m1c_1;
  assign VCOL_else_5_else_if_for_1_and_115_nl = and_457_cse & VCOL_else_5_else_if_for_1_and_98_m1c_1;
  assign pix_8_9_2_lpi_3_dfm_8 = MUX1HOT_v_8_4_2(pix_8_9_2_lpi_3, pix_5_9_2_lpi_3,
      pix_7_9_2_lpi_3, pix_4_9_2_lpi_3_dfm_mx0, {VCOL_else_5_else_if_for_1_nand_4_nl
      , VCOL_else_5_else_if_for_1_or_2_nl , VCOL_else_4_and_15_nl , VCOL_else_5_else_if_for_1_and_115_nl});
  assign VCOL_else_5_else_if_for_1_or_m1c_1 = (((~(VCOL_else_4_else_else_else_and_tmp_1
      | VCOL_else_4_else_else_land_lpi_3_dfm_1)) | ((~(VCOL_else_4_else_aif_equal_tmp
      | operator_10_false_1_operator_10_false_1_and_cse_sva_1_1)) & VCOL_else_4_else_else_else_and_tmp_1))
      & VCOL_and_m1c_1) | (and_457_cse & (~ VCOL_land_1_lpi_3_dfm_1) & exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva);
  assign VCOL_and_m1c_1 = (~ VCOL_else_4_else_land_lpi_3_dfm_1) & VCOL_VCOL_nor_1_m1c_1
      & exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva;
  assign tmp_pix_0_1_0_sva_2 = MUX_v_2_2_2(2'b00, tmp_pix_0_1_0_lpi_3_mx1, VCOL_else_5_else_if_for_1_VCOL_else_5_else_if_for_1_nand_7_seb_sva_1);
  assign tmp_pix_8_1_0_sva_2 = MUX_v_2_2_2(2'b00, tmp_pix_8_1_0_lpi_3_mx1, VCOL_else_5_else_if_for_1_VCOL_else_5_else_if_for_1_nand_8_seb_sva_1);
  assign tmp_pix_7_1_0_sva_2 = MUX_v_2_2_2(2'b00, tmp_pix_7_1_0_lpi_3_mx1, VCOL_else_5_else_if_for_1_VCOL_else_5_else_if_for_1_nand_6_seb_sva_1);
  assign tmp_pix_6_1_0_sva_2 = MUX_v_2_2_2(2'b00, tmp_pix_6_1_0_lpi_3_mx1, VCOL_else_5_else_if_for_1_VCOL_else_5_else_if_for_1_nand_4_seb_sva_1);
  assign tmp_pix_5_1_0_sva_2 = MUX_v_2_2_2(2'b00, tmp_pix_5_1_0_lpi_3_mx1, VCOL_else_5_else_if_for_1_VCOL_else_5_else_if_for_1_nand_2_seb_sva_1);
  assign tmp_pix_4_1_0_sva_2 = MUX_v_2_2_2(2'b00, tmp_pix_4_1_0_lpi_3_mx1, VCOL_else_5_else_if_for_1_VCOL_else_5_else_if_for_1_nand_seb_sva_1);
  assign tmp_pix_3_1_0_sva_2 = MUX_v_2_2_2(2'b00, tmp_pix_3_1_0_lpi_3_mx1, VCOL_else_5_else_if_for_1_VCOL_else_5_else_if_for_1_nand_1_seb_sva_1);
  assign tmp_pix_2_1_0_sva_2 = MUX_v_2_2_2(2'b00, tmp_pix_2_1_0_lpi_3_mx1, VCOL_else_5_else_if_for_1_VCOL_else_5_else_if_for_1_nand_3_seb_sva_1);
  assign tmp_pix_1_1_0_sva_2 = MUX_v_2_2_2(2'b00, tmp_pix_1_1_0_lpi_3_mx1, VCOL_else_5_else_if_for_1_VCOL_else_5_else_if_for_1_nand_5_seb_sva_1);
  assign VCOL_else_5_else_if_for_1_VCOL_else_5_else_if_for_1_nand_8_seb_sva_1 = ~(VCOL_else_5_else_if_for_1_and_stg_2_0_sva_1
      & max_i_lpi_3_dfm_mx0_3);
  assign VCOL_else_5_else_if_for_1_and_stg_2_0_sva_1 = VCOL_else_5_else_if_for_1_and_stg_1_0_sva_1
      & (~ (max_i_lpi_3_dfm_mx1_2_0[2]));
  assign max_i_lpi_3_dfm_mx0_3 = MUX_s_1_2_2((max_i_lpi_3_mx1[3]), (i_lpi_3_dfm_4_1[3]),
      VCOL_else_5_else_if_for_1_for_if_acc_itm_10);
  assign max_i_lpi_3_dfm_mx1_2_0 = MUX_v_3_2_2((max_i_lpi_3_mx1[2:0]), (i_lpi_3_dfm_4_1[2:0]),
      VCOL_else_5_else_if_for_1_for_if_acc_itm_10);
  assign VCOL_else_5_else_if_for_1_VCOL_else_5_else_if_for_1_nand_7_seb_sva_1 = ~(VCOL_else_5_else_if_for_1_and_stg_2_0_sva_1
      & (~ max_i_lpi_3_dfm_mx0_3));
  assign VCOL_else_5_else_if_for_1_VCOL_else_5_else_if_for_1_nand_6_seb_sva_1 = ~(VCOL_else_5_else_if_for_1_and_stg_1_3_sva_1
      & (max_i_lpi_3_dfm_mx1_2_0[2]) & (~ max_i_lpi_3_dfm_mx0_3));
  assign VCOL_else_5_else_if_for_1_and_stg_1_3_sva_1 = (max_i_lpi_3_dfm_mx1_2_0[1:0]==2'b11);
  assign VCOL_else_5_else_if_for_1_VCOL_else_5_else_if_for_1_nand_5_seb_sva_1 = ~(VCOL_else_5_else_if_for_1_and_stg_1_1_sva_1
      & (~ (max_i_lpi_3_dfm_mx1_2_0[2])) & (~ max_i_lpi_3_dfm_mx0_3));
  assign VCOL_else_5_else_if_for_1_and_stg_1_1_sva_1 = (max_i_lpi_3_dfm_mx1_2_0[1:0]==2'b01);
  assign VCOL_else_5_else_if_for_1_VCOL_else_5_else_if_for_1_nand_4_seb_sva_1 = ~(VCOL_else_5_else_if_for_1_and_stg_1_2_sva_1
      & (max_i_lpi_3_dfm_mx1_2_0[2]) & (~ max_i_lpi_3_dfm_mx0_3));
  assign VCOL_else_5_else_if_for_1_and_stg_1_2_sva_1 = (max_i_lpi_3_dfm_mx1_2_0[1:0]==2'b10);
  assign VCOL_else_5_else_if_for_1_VCOL_else_5_else_if_for_1_nand_3_seb_sva_1 = ~(VCOL_else_5_else_if_for_1_and_stg_1_2_sva_1
      & (~ (max_i_lpi_3_dfm_mx1_2_0[2])) & (~ max_i_lpi_3_dfm_mx0_3));
  assign VCOL_else_5_else_if_for_1_VCOL_else_5_else_if_for_1_nand_2_seb_sva_1 = ~(VCOL_else_5_else_if_for_1_and_stg_1_1_sva_1
      & (max_i_lpi_3_dfm_mx1_2_0[2]) & (~ max_i_lpi_3_dfm_mx0_3));
  assign VCOL_else_5_else_if_for_1_VCOL_else_5_else_if_for_1_nand_1_seb_sva_1 = ~(VCOL_else_5_else_if_for_1_and_stg_1_3_sva_1
      & (~ (max_i_lpi_3_dfm_mx1_2_0[2])) & (~ max_i_lpi_3_dfm_mx0_3));
  assign VCOL_else_5_else_if_for_1_VCOL_else_5_else_if_for_1_nand_seb_sva_1 = ~(VCOL_else_5_else_if_for_1_and_stg_1_0_sva_1
      & (max_i_lpi_3_dfm_mx1_2_0[2]) & (~ max_i_lpi_3_dfm_mx0_3));
  assign VCOL_else_5_else_if_for_1_and_stg_1_0_sva_1 = ~((max_i_lpi_3_dfm_mx1_2_0[1:0]!=2'b00));
  assign VCOL_else_5_else_if_for_1_and_106_nl = (~ VCOL_else_4_else_aif_equal_tmp)
      & exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1;
  assign VCOL_else_5_else_if_for_1_mux_81_tmp_0 = MUX_s_1_2_2((VCOL_x_sva[0]), (VCOL_x_sva_2[0]),
      VCOL_else_5_else_if_for_1_and_106_nl);
  assign nl_VCOL_else_5_else_if_for_1_for_if_acc_nl = ({1'b1 , max_val_lpi_3_dfm_5_1_9_2
      , tmp_pix_0_1_0_lpi_3}) + conv_u2u_10_11({(~ VCOL_else_5_else_if_for_1_for_slc_tmp_pix_10_9_0_cse_sva_9_2_1)
      , (~ VCOL_else_5_else_if_for_1_for_slc_tmp_pix_10_9_0_cse_sva_1_0_1)}) + 11'b00000000001;
  assign VCOL_else_5_else_if_for_1_for_if_acc_nl = nl_VCOL_else_5_else_if_for_1_for_if_acc_nl[10:0];
  assign VCOL_else_5_else_if_for_1_for_if_acc_itm_10 = readslicef_11_1_10(VCOL_else_5_else_if_for_1_for_if_acc_nl);
  assign nand_6_cse = ~(VCOL_else_4_else_aif_equal_tmp & exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1
      & VCOL_stage_0_2);
  assign and_dcpl_1 = VCOL_stage_0_1 & (~ operator_11_false_4_operator_11_false_4_nor_tmp);
  assign not_tmp_4 = ~((VROW_y_sva!=10'b0000000000));
  assign nor_61_nl = ~((~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_1) | lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_0
      | operator_4_false_1_acc_itm_2 | operator_4_false_2_acc_itm_3);
  assign mux_tmp_3 = MUX_s_1_2_2(or_357_cse, nor_61_nl, nor_33_cse);
  assign mux_2_nl = MUX_s_1_2_2(or_703_cse, or_705_cse, exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1);
  assign mux_4_cse = MUX_s_1_2_2(mux_tmp_3, mux_2_nl, VCOL_stage_0_2);
  assign or_dcpl_3 = mux_4_cse | (~ VCOL_stage_0_1);
  assign and_dcpl_4 = VCOL_else_4_else_aif_equal_tmp & exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1;
  assign or_dcpl_4 = ~((~(and_dcpl_4 & VCOL_stage_0_2)) & VCOL_stage_0_1);
  assign mux_tmp_6 = MUX_s_1_2_2((~ exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva),
      lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1_mx0w0, VCOL_stage_0_2);
  assign nor_62_cse = ~(VCOL_else_4_else_aif_equal_tmp | (~ or_357_cse));
  assign or_tmp_35 = ~(lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_1 | (~ operator_4_false_acc_itm_3));
  assign mux_tmp_34 = MUX_s_1_2_2(exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva,
      exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1, VCOL_stage_0_2);
  assign or_dcpl_42 = ~(exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1 & VCOL_stage_0_2);
  assign mux_92_nl = MUX_s_1_2_2(or_704_cse, (~ VCOL_else_4_else_aif_equal_tmp),
      exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1);
  assign mux_93_nl = MUX_s_1_2_2(or_40_cse, mux_92_nl, VCOL_stage_0_2);
  assign and_dcpl_21 = mux_93_nl & VCOL_stage_0_1;
  assign or_185_nl = exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva | (~ lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3)
      | lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_0 | (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_1);
  assign or_183_nl = exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1 | (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_1)
      | lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_0 | (VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1!=2'b10);
  assign mux_tmp_94 = MUX_s_1_2_2(or_185_nl, or_183_nl, VCOL_stage_0_2);
  assign mux_95_nl = MUX_s_1_2_2(or_704_cse, nor_62_cse, exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1);
  assign mux_97_nl = MUX_s_1_2_2(or_357_cse, mux_95_nl, VCOL_stage_0_2);
  assign and_dcpl_27 = mux_97_nl & VCOL_stage_0_1;
  assign mux_101_nl = MUX_s_1_2_2(or_704_cse, or_357_cse, exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1);
  assign mux_tmp_102 = MUX_s_1_2_2(or_357_cse, mux_101_nl, VCOL_stage_0_2);
  assign nor_tmp_47 = (operator_11_false_4_operator_11_false_4_nor_cse_sva_1 | operator_11_false_2_operator_11_false_2_slc_VCOL_x_0_1_itm_1
      | (VCOL_else_3_else_asn_itm_1!=10'b0000000000)) & exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva;
  assign and_dcpl_44 = (~ exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1) & VCOL_stage_0_2;
  assign and_dcpl_46 = or_388_cse & VCOL_stage_0_2;
  assign and_dcpl_50 = (~ mux_tmp_94) & (~ operator_4_false_2_acc_itm_3) & VCOL_stage_0_1;
  assign or_dcpl_63 = mux_tmp_94 | operator_4_false_2_acc_itm_3;
  assign lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_mx0c1 = nand_6_cse & VCOL_stage_0_1
      & (fsm_output[1]);
  assign VCOL_if_3_not_nl = ~ operator_11_false_4_operator_11_false_4_nor_tmp;
  assign line_buf0_rsci_adr_d_pff = MUX_v_10_2_2(10'b0000000000, z_out, VCOL_if_3_not_nl);
  assign VCOL_else_5_else_if_for_1_mux_10_nl = MUX_v_8_2_2(VCOL_VCOL_slc_pix_dummy_3_9_2_lpi_4,
      pix_2_9_2_lpi_3_dfm_8_mx0w0, VCOL_stage_0_2);
  assign VCOL_else_5_else_if_for_1_mux_9_nl = MUX_v_8_2_2(VCOL_VCOL_slc_pix_dummy_2_9_2_lpi_4,
      pix_5_9_2_lpi_3_dfm_6_mx0, VCOL_stage_0_2);
  assign line_buf0_rsci_d_d = {VCOL_else_5_else_if_for_1_mux_10_nl , VCOL_else_5_else_if_for_1_mux_9_nl};
  assign line_buf0_rsci_we_d_pff = mux_110_cse & and_dcpl_1 & (fsm_output[1]);
  assign line_buf0_rsci_port_0_rw_ram_ir_internal_RMASK_B_d_pff = (~ mux_112_cse)
      & VCOL_stage_0_1 & (fsm_output[1]);
  assign VCOL_mux_9_nl = MUX_v_8_2_2(VCOL_VCOL_slc_pix_dummy_5_9_2_lpi_4, VCOL_VCOL_slc_pix_dummy_5_9_2_lpi_3_dfm_mx1w0,
      VCOL_stage_0_2);
  assign VCOL_else_5_else_if_for_1_mux_11_nl = MUX_v_8_2_2(VCOL_VCOL_slc_pix_dummy_4_9_2_lpi_4,
      pix_4_9_2_lpi_3_dfm_1_mx0, VCOL_stage_0_2);
  assign line_buf1_rsci_d_d = {VCOL_mux_9_nl , VCOL_else_5_else_if_for_1_mux_11_nl};
  assign nor_127_nl = ~((~ exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva) | (VCOL_x_sva[0])
      | not_tmp_4);
  assign nor_128_nl = ~(VCOL_else_5_else_if_for_1_mux_81_tmp_0 | (~ exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1)
      | VCOL_else_4_else_aif_equal_tmp | not_tmp_4);
  assign mux_117_nl = MUX_s_1_2_2(nor_127_nl, nor_128_nl, VCOL_stage_0_2);
  assign line_buf1_rsci_we_d_pff = mux_117_nl & and_dcpl_1 & (fsm_output[1]);
  assign or_347_nl = (~ VCOL_stage_0_2) | (~ exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1)
      | VCOL_else_4_else_aif_equal_tmp;
  assign mux_tmp = MUX_s_1_2_2((VCOL_x_sva_2[0]), (VCOL_x_sva[0]), or_347_nl);
  assign or_tmp_265 = (~ mux_tmp) & (fsm_output[1]);
  assign and_dcpl_69 = run_wen & VCOL_stage_0_1;
  assign and_dcpl_85 = run_wen & VCOL_stage_0_2;
  assign or_tmp_301 = operator_11_false_4_operator_11_false_4_nor_cse_sva_1 | VCOL_land_1_lpi_3_dfm_1;
  assign or_399_nl = (VCOL_x_sva_2[10:1]!=10'b0000000000) | (~ VCOL_stage_0_1);
  assign or_397_nl = (VROW_y_sva!=10'b0000000001) | (VCOL_x_sva_2[10:1]!=10'b0000000000)
      | (~ VCOL_stage_0_1);
  assign mux_tmp_159 = MUX_s_1_2_2(or_399_nl, or_397_nl, VCOL_x_sva_2[0]);
  assign nand_tmp_9 = ~(operator_11_false_4_operator_11_false_4_nor_cse_lpi_3_dfm_1
      & (~ VCOL_else_5_else_if_for_1_and_39_cse));
  assign or_407_nl = operator_11_false_4_operator_11_false_4_nor_cse_sva_1 | (~ exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva);
  assign mux_tmp_164 = MUX_s_1_2_2(or_407_nl, VCOL_else_5_else_if_for_1_and_39_cse,
      operator_11_false_4_operator_11_false_4_nor_cse_lpi_3_dfm_1);
  assign or_tmp_323 = (~((VCOL_x_sva[0]) | reg_operator_11_false_6_nor_itm_1_cse))
      | operator_11_false_4_operator_11_false_4_nor_cse_sva_1 | VCOL_and_16_itm_1;
  assign or_tmp_327 = ~(nand_89_cse & or_tmp_323);
  assign or_tmp_332 = (i_lpi_3_dfm_4_1!=4'b0001) | operator_4_false_2_acc_itm_3 |
      (~ VCOL_stage_0_1);
  assign or_tmp_347 = (i_lpi_3_dfm_4_1!=4'b0101) | operator_4_false_2_acc_itm_3 |
      (~ VCOL_stage_0_1);
  assign not_tmp_188 = ~((max_i_lpi_3[2]) & VCOL_stage_0_1);
  assign or_tmp_362 = (i_lpi_3_dfm_4_1!=4'b0010) | operator_4_false_2_acc_itm_3 |
      (~ VCOL_stage_0_1);
  assign or_tmp_377 = (i_lpi_3_dfm_4_1!=4'b0110) | operator_4_false_2_acc_itm_3 |
      (~ VCOL_stage_0_1);
  assign or_tmp_392 = (i_lpi_3_dfm_4_1!=4'b0011) | operator_4_false_2_acc_itm_3 |
      (~ VCOL_stage_0_1);
  assign or_tmp_407 = (i_lpi_3_dfm_4_1!=4'b0111) | operator_4_false_2_acc_itm_3 |
      (~ VCOL_stage_0_1);
  assign and_tmp_19 = VCOL_else_5_else_if_for_1_for_if_acc_itm_10 & or_554_cse;
  assign or_512_nl = (~ VCOL_else_5_else_if_for_1_for_if_acc_itm_10) | (i_lpi_3_dfm_4_1!=4'b0000);
  assign or_511_nl = (max_i_lpi_3_dfm_2_1!=4'b0000);
  assign mux_tmp_210 = MUX_s_1_2_2(and_tmp_19, or_512_nl, or_511_nl);
  assign or_tmp_430 = (i_lpi_3_dfm_4_1!=4'b1000) | operator_4_false_2_acc_itm_3 |
      (~ VCOL_stage_0_1);
  assign not_tmp_217 = ~((max_i_lpi_3[3]) & VCOL_stage_0_1);
  assign or_tmp_443 = (i_lpi_3_dfm_4_1!=4'b0100) | operator_4_false_2_acc_itm_3 |
      (~ VCOL_stage_0_1);
  assign or_557_nl = operator_4_false_1_acc_itm_2 | (ctrl_signal_rsci_idat!=2'b10);
  assign mux_tmp_230 = MUX_s_1_2_2(operator_4_false_1_acc_itm_2, or_557_nl, lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_0);
  assign or_tmp_467 = lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_0 | operator_4_false_1_acc_itm_2;
  assign or_tmp_536 = (~(reg_operator_11_false_6_nor_itm_1_cse | (~ VCOL_VCOL_oelse_operator_11_false_or_cse_sva_1)))
      | operator_11_false_4_operator_11_false_4_nor_cse_sva_1 | VCOL_land_1_lpi_3_dfm_1;
  assign nor_310_nl = ~(operator_10_false_1_operator_10_false_1_and_cse_sva_1_1 |
      (VCOL_x_sva[10:1]!=10'b0000000000) | or_tmp_536);
  assign nor_311_nl = ~((~ reg_operator_11_false_6_nor_itm_1_cse) | operator_11_false_4_operator_11_false_4_nor_cse_sva_1
      | VCOL_land_1_lpi_3_dfm_1);
  assign mux_261_nl = MUX_s_1_2_2(nor_310_nl, nor_311_nl, VROW_equal_tmp);
  assign nand_tmp_23 = ~((VCOL_x_sva[0]) & mux_261_nl);
  assign nor_176_cse = ~(VROW_equal_tmp | (~ operator_10_false_1_operator_10_false_1_and_cse_sva_1_1));
  assign or_631_nl = nor_176_cse | VCOL_VCOL_oelse_operator_11_false_or_cse_sva_1
      | operator_11_false_4_operator_11_false_4_nor_cse_sva_1 | VCOL_land_1_lpi_3_dfm_1;
  assign or_630_nl = (VCOL_x_sva[10:1]!=10'b0000000000) | or_tmp_536;
  assign mux_262_nl = MUX_s_1_2_2(or_tmp_536, or_630_nl, nor_176_cse);
  assign mux_tmp_263 = MUX_s_1_2_2(or_631_nl, mux_262_nl, VCOL_x_sva[0]);
  assign and_478_nl = ((~ VCOL_else_4_else_aif_equal_tmp) | (~ VROW_equal_tmp) |
      reg_operator_11_false_6_nor_itm_1_cse) & (VCOL_x_sva[0]);
  assign or_636_nl = VCOL_else_4_else_aif_equal_tmp | (~ VROW_equal_tmp) | (VCOL_x_sva[0]);
  assign mux_268_nl = MUX_s_1_2_2(and_478_nl, or_636_nl, operator_10_false_1_operator_10_false_1_and_cse_sva_1_1);
  assign nand_74_nl = ~((~(VCOL_else_4_else_aif_equal_tmp | (~ VROW_equal_tmp)))
      & nand_82_cse);
  assign mux_267_nl = MUX_s_1_2_2(and_457_cse, nand_74_nl, operator_10_false_1_operator_10_false_1_and_cse_sva_1_1);
  assign mux_269_nl = MUX_s_1_2_2(mux_268_nl, mux_267_nl, or_384_cse);
  assign or_tmp_547 = VCOL_land_1_lpi_3_dfm_1 | mux_269_nl;
  assign or_tmp_548 = VCOL_stage_0_1 | (~ or_tmp_547);
  assign or_644_nl = VROW_equal_tmp | nor_211_cse;
  assign mux_273_nl = MUX_s_1_2_2(or_644_nl, and_457_cse, VCOL_else_4_else_land_lpi_3_dfm_1);
  assign or_tmp_554 = VCOL_land_1_lpi_3_dfm_1 | mux_273_nl;
  assign or_tmp_555 = VCOL_stage_0_1 | (~ or_tmp_554);
  assign or_679_nl = (max_i_lpi_3_dfm_2_1!=4'b0000) | operator_4_false_2_acc_itm_3;
  assign or_678_nl = (i_lpi_3_dfm_4_1!=4'b0000) | operator_4_false_2_acc_itm_3;
  assign mux_tmp_285 = MUX_s_1_2_2(or_679_nl, or_678_nl, VCOL_else_5_else_if_for_1_for_if_acc_itm_10);
  assign or_tmp_598 = nor_79_cse | (VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1!=2'b10);
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      VCOL_x_sva <= 11'b00000000000;
    end
    else if ( rst ) begin
      VCOL_x_sva <= 11'b00000000000;
    end
    else if ( (VCOL_x_and_cse | (fsm_output[2]) | (fsm_output[0])) & run_wen ) begin
      VCOL_x_sva <= MUX_v_11_2_2(11'b00000000000, VCOL_x_sva_mx1, not_510_nl);
    end
  end
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      VROW_y_sva <= 10'b0000000000;
    end
    else if ( rst ) begin
      VROW_y_sva <= 10'b0000000000;
    end
    else if ( run_wen & VROW_y_or_cse ) begin
      VROW_y_sva <= MUX_v_10_2_2(10'b0000000000, z_out, VROW_y_not_2_nl);
    end
  end
  always @(posedge clk) begin
    if ( run_wen & (~((~ (fsm_output[1])) | or_dcpl_42 | (~ VCOL_if_6_VCOL_if_6_and_itm_1)))
        ) begin
      dat_out_rsci_idat <= pix_result_9_2_lpi_3_dfm_2_mx0w0;
    end
  end
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_1 <= 1'b0;
    end
    else if ( rst ) begin
      lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_1 <= 1'b0;
    end
    else if ( mux_135_nl & run_wen & (fsm_output[1]) & VCOL_stage_0_1 ) begin
      lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_1 <= MUX_s_1_2_2(lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_3_1_1,
          lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_1_mx1, and_dcpl_21);
    end
  end
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_0 <= 1'b0;
    end
    else if ( rst ) begin
      lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_0 <= 1'b0;
    end
    else if ( (~ mux_138_nl) & and_dcpl_69 & (fsm_output[1]) ) begin
      lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_0 <= MUX1HOT_s_1_3_2(VCOL_else_5_else_if_for_1_and_55_ssc_1,
          lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_0_mx1, VCOL_VCOL_oelse_operator_11_false_or_tmp,
          {and_101_nl , and_103_nl , and_105_nl});
    end
  end
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3 <= 1'b0;
    end
    else if ( rst ) begin
      lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3 <= 1'b0;
    end
    else if ( run_wen & (((and_dcpl_4 | (~ VCOL_stage_0_1)) & VCOL_stage_0_2 & (fsm_output[1]))
        | lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_mx0c1) ) begin
      lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3 <= MUX_s_1_2_2(lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1_mx0w0,
          VCOL_else_5_else_if_for_1_equal_tmp_mx0w1, lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_mx0c1);
    end
  end
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva <= 1'b0;
      VCOL_stage_0_1 <= 1'b0;
      VCOL_stage_0_2 <= 1'b0;
      reg_dat_in_rsci_oswt_cse <= 1'b0;
      reg_dat_out_rsci_oswt_cse <= 1'b0;
      reg_line_buf0_rsci_cgo_cse <= 1'b0;
      reg_line_buf1_rsci_cgo_cse <= 1'b0;
      ctrl_signal_triosy_obj_iswt0 <= 1'b0;
      operator_11_false_4_operator_11_false_4_nor_cse_sva_1 <= 1'b0;
    end
    else if ( rst ) begin
      exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva <= 1'b0;
      VCOL_stage_0_1 <= 1'b0;
      VCOL_stage_0_2 <= 1'b0;
      reg_dat_in_rsci_oswt_cse <= 1'b0;
      reg_dat_out_rsci_oswt_cse <= 1'b0;
      reg_line_buf0_rsci_cgo_cse <= 1'b0;
      reg_line_buf1_rsci_cgo_cse <= 1'b0;
      ctrl_signal_triosy_obj_iswt0 <= 1'b0;
      operator_11_false_4_operator_11_false_4_nor_cse_sva_1 <= 1'b0;
    end
    else if ( run_wen ) begin
      exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva <= exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva_mx1
          | VROW_y_or_cse;
      VCOL_stage_0_1 <= VCOL_aelse_VCOL_aelse_and_cse | VROW_y_or_cse;
      VCOL_stage_0_2 <= VCOL_aelse_VCOL_aelse_and_cse & (~ VROW_y_or_cse);
      reg_dat_in_rsci_oswt_cse <= (~ mux_tmp_6) & VCOL_stage_0_1 & (~ operator_10_false_acc_itm_10_1)
          & (~ operator_11_false_acc_itm_11_1) & (fsm_output[1]);
      reg_dat_out_rsci_oswt_cse <= VCOL_x_and_cse & VCOL_if_6_VCOL_if_6_and_itm_1
          & (fsm_output[1]);
      reg_line_buf0_rsci_cgo_cse <= and_131_rmff;
      reg_line_buf1_rsci_cgo_cse <= and_143_rmff;
      ctrl_signal_triosy_obj_iswt0 <= VROW_equal_tmp & (fsm_output[2]);
      operator_11_false_4_operator_11_false_4_nor_cse_sva_1 <= operator_11_false_4_operator_11_false_4_nor_tmp;
    end
  end
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      VCOL_else_3_else_asn_itm_1 <= 10'b0000000000;
    end
    else if ( rst ) begin
      VCOL_else_3_else_asn_itm_1 <= 10'b0000000000;
    end
    else if ( run_wen & mux_110_cse & and_dcpl_1 ) begin
      VCOL_else_3_else_asn_itm_1 <= VROW_y_sva;
    end
  end
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      operator_11_false_2_operator_11_false_2_slc_VCOL_x_0_1_itm_1 <= 1'b0;
    end
    else if ( rst ) begin
      operator_11_false_2_operator_11_false_2_slc_VCOL_x_0_1_itm_1 <= 1'b0;
    end
    else if ( run_wen & (~ mux_tmp_6) & and_dcpl_1 ) begin
      operator_11_false_2_operator_11_false_2_slc_VCOL_x_0_1_itm_1 <= VCOL_x_sva_mx1[0];
    end
  end
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      operator_10_false_1_operator_10_false_1_and_cse_sva_1_1 <= 1'b0;
      exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1 <= 1'b0;
      VCOL_land_1_lpi_3_dfm_1 <= 1'b0;
      VCOL_land_lpi_3_dfm_1 <= 1'b0;
      i_1_lpi_3_dfm_1 <= 4'b0000;
      VCOL_equal_tmp_2_1 <= 1'b0;
    end
    else if ( rst ) begin
      operator_10_false_1_operator_10_false_1_and_cse_sva_1_1 <= 1'b0;
      exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1 <= 1'b0;
      VCOL_land_1_lpi_3_dfm_1 <= 1'b0;
      VCOL_land_lpi_3_dfm_1 <= 1'b0;
      i_1_lpi_3_dfm_1 <= 4'b0000;
      VCOL_equal_tmp_2_1 <= 1'b0;
    end
    else if ( operator_10_false_1_and_cse ) begin
      operator_10_false_1_operator_10_false_1_and_cse_sva_1_1 <= operator_10_false_1_operator_10_false_1_and_cse_sva_1;
      exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1 <= (~(lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_3_1_1
          | VCOL_else_5_else_if_for_1_and_55_ssc_1)) | VCOL_equal_tmp_4 | VCOL_equal_tmp_5
          | VCOL_equal_tmp_7;
      VCOL_land_1_lpi_3_dfm_1 <= (VCOL_x_sva_mx1[0]) & operator_11_false_1_nor_tmp
          & operator_10_false_1_operator_10_false_1_and_cse_sva_1;
      VCOL_land_lpi_3_dfm_1 <= ~(operator_11_false_acc_itm_11_1 | operator_10_false_acc_itm_10_1);
      i_1_lpi_3_dfm_1 <= i_1_lpi_3_dfm_3;
      VCOL_equal_tmp_2_1 <= VCOL_equal_tmp_6;
    end
  end
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      reg_operator_11_false_6_nor_itm_1_cse <= 1'b0;
      VCOL_and_16_itm_1 <= 1'b0;
      VCOL_VCOL_oelse_operator_11_false_or_cse_sva_1 <= 1'b0;
    end
    else if ( rst ) begin
      reg_operator_11_false_6_nor_itm_1_cse <= 1'b0;
      VCOL_and_16_itm_1 <= 1'b0;
      VCOL_VCOL_oelse_operator_11_false_or_cse_sva_1 <= 1'b0;
    end
    else if ( operator_11_false_6_and_cse ) begin
      reg_operator_11_false_6_nor_itm_1_cse <= operator_11_false_1_nor_tmp;
      VCOL_and_16_itm_1 <= (VCOL_x_sva_mx1[0]) & (~ operator_11_false_1_nor_tmp);
      VCOL_VCOL_oelse_operator_11_false_or_cse_sva_1 <= VCOL_VCOL_oelse_operator_11_false_or_tmp;
    end
  end
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_1 <= 1'b0;
      lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_0 <= 1'b0;
    end
    else if ( rst ) begin
      lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_1 <= 1'b0;
      lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_0 <= 1'b0;
    end
    else if ( and_274_cse ) begin
      lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_1 <= MUX_s_1_2_2(lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_3_1_1,
          lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_1_mx1, mux_tmp_102);
      lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_0 <= MUX_s_1_2_2(VCOL_else_5_else_if_for_1_and_55_ssc_1,
          lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_0_mx1, mux_tmp_102);
    end
  end
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      VCOL_if_6_VCOL_if_6_and_itm_1 <= 1'b0;
      VCOL_equal_tmp_1 <= 1'b0;
      VCOL_equal_tmp_1_1 <= 1'b0;
      VCOL_or_1_itm_1 <= 1'b0;
      VCOL_and_22_itm_1 <= 1'b0;
    end
    else if ( rst ) begin
      VCOL_if_6_VCOL_if_6_and_itm_1 <= 1'b0;
      VCOL_equal_tmp_1 <= 1'b0;
      VCOL_equal_tmp_1_1 <= 1'b0;
      VCOL_or_1_itm_1 <= 1'b0;
      VCOL_and_22_itm_1 <= 1'b0;
    end
    else if ( VCOL_if_6_and_1_cse ) begin
      VCOL_if_6_VCOL_if_6_and_itm_1 <= operator_11_false_mux_nl & ((VROW_y_sva!=10'b0000000000));
      VCOL_equal_tmp_1 <= VCOL_equal_tmp_4;
      VCOL_equal_tmp_1_1 <= VCOL_equal_tmp_5;
      VCOL_or_1_itm_1 <= VCOL_and_6_ssc_1 | VCOL_equal_tmp_7 | ((~ nor_79_cse) &
          VCOL_and_7_ssc_1);
      VCOL_and_22_itm_1 <= nor_79_cse & VCOL_and_7_ssc_1;
    end
  end
  always @(posedge clk) begin
    if ( run_wen & (VCOL_and_6_ssc_1 | VCOL_asn_80_rgt | or_dcpl_3 | (~ (fsm_output[1])))
        & (~(mux_21_nl & VCOL_stage_0_1)) ) begin
      j_2_0_lpi_3_dfm_3_1_2 <= MUX_s_1_2_2(operator_4_false_acc_itm_3, (j_2_0_sva_2[2]),
          VCOL_asn_80_rgt);
    end
  end
  always @(posedge clk) begin
    if ( (~ mux_146_nl) & and_dcpl_69 & (fsm_output[1]) ) begin
      j_2_0_lpi_3_dfm_3_1_1_0 <= MUX1HOT_v_2_4_2(tmp_pix_1_1_0_sva_2, tmp_pix_1_1_0_lpi_3_dfm_2_1,
          ({{1{operator_4_false_acc_itm_3}}, operator_4_false_acc_itm_3}), (j_2_0_sva_2[1:0]),
          {j_and_6_nl , j_and_7_nl , j_and_4_nl , j_and_2_nl});
    end
  end
  always @(posedge clk) begin
    if ( run_wen & (~ mux_29_nl) & VCOL_stage_0_1 ) begin
      i_lpi_3_dfm_4_1 <= MUX1HOT_v_4_3_2(({{3{operator_4_false_acc_itm_3}}, operator_4_false_acc_itm_3}),
          (signext_4_1(~ operator_4_false_1_acc_itm_2)), i_sva_2, {(~ VCOL_else_5_else_if_for_1_equal_tmp_mx0w1)
          , VCOL_else_5_else_if_for_1_and_44_nl , VCOL_else_5_else_if_for_1_and_45_nl});
    end
  end
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1 <= 2'b00;
    end
    else if ( rst ) begin
      VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1 <= 2'b00;
    end
    else if ( mux_147_nl & and_dcpl_69 ) begin
      VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1 <= VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1_mx0;
    end
  end
  always @(posedge clk) begin
    if ( (VCOL_else_4_else_aif_equal_tmp | (~ VCOL_stage_0_1)) & exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1
        & (~ (fsm_output[2])) & run_wen & VCOL_stage_0_2 ) begin
      VCOL_VCOL_slc_pix_dummy_5_9_2_lpi_4 <= VCOL_VCOL_slc_pix_dummy_5_9_2_lpi_3_dfm_mx1w0;
    end
  end
  always @(posedge clk) begin
    if ( run_wen & (~(or_dcpl_42 | (fsm_output[2]))) & or_dcpl_4 ) begin
      VCOL_VCOL_slc_pix_dummy_4_9_2_lpi_4 <= pix_4_9_2_lpi_3_dfm_1_mx0;
    end
  end
  always @(posedge clk) begin
    if ( VCOL_and_46_cse ) begin
      VCOL_VCOL_slc_pix_dummy_3_9_2_lpi_4 <= pix_2_9_2_lpi_3_dfm_8_mx0w0;
    end
  end
  always @(posedge clk) begin
    if ( VCOL_and_46_cse & or_dcpl_4 ) begin
      VCOL_VCOL_slc_pix_dummy_2_9_2_lpi_4 <= pix_5_9_2_lpi_3_dfm_6_mx0;
    end
  end
  always @(posedge clk) begin
    if ( mux_151_nl & and_dcpl_85 & (fsm_output[1]) ) begin
      pix_5_9_2_lpi_3 <= MUX_v_8_2_2(pix_2_9_2_lpi_3_dfm_8_mx0w0, pix_5_9_2_lpi_3_dfm_6_mx0,
          and_165_nl);
    end
  end
  always @(posedge clk) begin
    if ( run_wen & exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva & VCOL_stage_0_2
        & VCOL_land_lpi_3_dfm_1 & (fsm_output[1]) & (mux_tmp_6 | (~ VCOL_stage_0_1)
        | operator_10_false_acc_itm_10_1 | operator_11_false_acc_itm_11_1) ) begin
      uint_pix_2_lpi_3 <= dat_in_rsci_idat_mxwt;
    end
  end
  always @(posedge clk) begin
    if ( mux_156_nl & (fsm_output[1]) & run_wen & VCOL_stage_0_2 ) begin
      pix_7_9_2_lpi_3 <= MUX_v_8_2_2(pix_4_9_2_lpi_3_dfm_1_mx0, pix_7_9_2_lpi_3_dfm_5_mx0,
          and_dcpl_44);
    end
  end
  always @(posedge clk) begin
    if ( mux_163_nl & run_wen & (fsm_output[1]) & VCOL_stage_0_2 ) begin
      pix_3_9_2_lpi_3 <= MUX_v_8_2_2(pix_0_9_2_lpi_3_dfm_9_mx1w0, pix_3_9_2_lpi_3_dfm_11,
          and_dcpl_46);
    end
  end
  always @(posedge clk) begin
    if ( mux_173_nl & run_wen & (fsm_output[1]) & VCOL_stage_0_2 ) begin
      pix_4_9_2_lpi_3 <= MUX_v_8_2_2(pix_1_9_2_lpi_3_dfm_9_mx1w0, pix_4_9_2_lpi_3_dfm_1_mx0,
          and_dcpl_46);
    end
  end
  always @(posedge clk) begin
    if ( rdbuf0_pix_and_1_cse ) begin
      rdbuf0_pix_lpi_3 <= line_buf0_rsci_q_d;
      rdbuf1_pix_lpi_3 <= line_buf1_rsci_q_d;
    end
  end
  always @(posedge clk) begin
    if ( mux_178_nl & (fsm_output[1]) & run_wen & and_254_cse ) begin
      pix_1_9_2_lpi_3 <= pix_1_9_2_lpi_3_dfm_9_mx1w0;
    end
  end
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      operator_11_false_4_operator_11_false_4_nor_cse_lpi_3_dfm_1 <= 1'b0;
    end
    else if ( rst ) begin
      operator_11_false_4_operator_11_false_4_nor_cse_lpi_3_dfm_1 <= 1'b0;
    end
    else if ( run_wen & mux_tmp_34 ) begin
      operator_11_false_4_operator_11_false_4_nor_cse_lpi_3_dfm_1 <= operator_11_false_4_operator_11_false_4_nor_tmp;
    end
  end
  always @(posedge clk) begin
    if ( (~(mux_179_nl & VCOL_stage_0_1)) & (fsm_output[1]) & VCOL_stage_0_2 & run_wen
        & (VCOL_equal_tmp_1 | VCOL_equal_tmp_1_1 | VCOL_and_22_itm_1) ) begin
      pix_result_9_2_lpi_3 <= pix_result_9_2_lpi_3_dfm_2_mx0w0;
    end
  end
  always @(posedge clk) begin
    if ( run_wen & mux_33_nl & nor_79_cse & VCOL_stage_0_1 ) begin
      VCOL_else_5_else_if_slc_max_val_9_2_itm_1 <= max_val_lpi_3_dfm_3_9_2_1;
    end
  end
  always @(posedge clk) begin
    if ( and_dcpl_85 & exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva ) begin
      pix_2_9_2_lpi_3 <= pix_2_9_2_lpi_3_dfm_8_mx0w0;
    end
  end
  always @(posedge clk) begin
    if ( mux_184_nl & run_wen & (fsm_output[1]) ) begin
      tmp_pix_1_9_2_lpi_3 <= MUX_v_8_2_2(VCOL_else_5_else_if_for_VCOL_else_5_else_if_for_VCOL_else_5_else_if_for_mux_psp_sva_1,
          VCOL_else_5_else_if_for_1_and_31_nl, and_dcpl_50);
    end
  end
  always @(posedge clk) begin
    if ( mux_189_nl & run_wen & (fsm_output[1]) ) begin
      tmp_pix_5_9_2_lpi_3 <= MUX_v_8_2_2(VCOL_else_5_else_if_for_VCOL_else_5_else_if_for_VCOL_else_5_else_if_for_mux_psp_sva_1,
          VCOL_else_5_else_if_for_1_and_35_nl, and_dcpl_50);
    end
  end
  always @(posedge clk) begin
    if ( mux_194_nl & run_wen & (fsm_output[1]) ) begin
      tmp_pix_2_9_2_lpi_3 <= MUX_v_8_2_2(VCOL_else_5_else_if_for_VCOL_else_5_else_if_for_VCOL_else_5_else_if_for_mux_psp_sva_1,
          VCOL_else_5_else_if_for_1_and_32_nl, and_dcpl_50);
    end
  end
  always @(posedge clk) begin
    if ( mux_199_nl & run_wen & (fsm_output[1]) ) begin
      tmp_pix_6_9_2_lpi_3 <= MUX_v_8_2_2(VCOL_else_5_else_if_for_VCOL_else_5_else_if_for_VCOL_else_5_else_if_for_mux_psp_sva_1,
          VCOL_else_5_else_if_for_1_and_36_nl, and_dcpl_50);
    end
  end
  always @(posedge clk) begin
    if ( mux_204_nl & run_wen & (fsm_output[1]) ) begin
      tmp_pix_3_9_2_lpi_3 <= MUX_v_8_2_2(VCOL_else_5_else_if_for_VCOL_else_5_else_if_for_VCOL_else_5_else_if_for_mux_psp_sva_1,
          VCOL_else_5_else_if_for_1_and_33_nl, and_dcpl_50);
    end
  end
  always @(posedge clk) begin
    if ( mux_209_nl & run_wen & (fsm_output[1]) ) begin
      tmp_pix_7_9_2_lpi_3 <= MUX_v_8_2_2(VCOL_else_5_else_if_for_VCOL_else_5_else_if_for_VCOL_else_5_else_if_for_mux_psp_sva_1,
          VCOL_else_5_else_if_for_1_and_37_nl, and_dcpl_50);
    end
  end
  always @(posedge clk) begin
    if ( mux_216_nl & and_dcpl_69 ) begin
      tmp_pix_0_9_2_lpi_3 <= MUX_v_8_2_2(VCOL_else_5_else_if_for_VCOL_else_5_else_if_for_VCOL_else_5_else_if_for_mux_psp_sva_1,
          VCOL_else_5_else_if_for_1_and_30_nl, nor_131_nl);
    end
  end
  always @(posedge clk) begin
    if ( mux_221_nl & run_wen & (fsm_output[1]) ) begin
      tmp_pix_8_9_2_lpi_3 <= MUX_v_8_2_2(VCOL_else_5_else_if_for_VCOL_else_5_else_if_for_VCOL_else_5_else_if_for_mux_psp_sva_1,
          VCOL_else_5_else_if_for_1_and_38_nl, and_dcpl_50);
    end
  end
  always @(posedge clk) begin
    if ( mux_226_nl & run_wen & (fsm_output[1]) ) begin
      tmp_pix_4_9_2_lpi_3 <= MUX_v_8_2_2(VCOL_else_5_else_if_for_VCOL_else_5_else_if_for_VCOL_else_5_else_if_for_mux_psp_sva_1,
          VCOL_else_5_else_if_for_1_and_34_nl, and_dcpl_50);
    end
  end
  always @(posedge clk) begin
    if ( mux_239_nl & run_wen & (fsm_output[1]) & VCOL_stage_0_1 ) begin
      tmp_pix_0_1_0_lpi_3 <= MUX1HOT_v_2_5_2(tmp_pix_0_1_0_sva_2, tmp_pix_0_1_0_lpi_3_mx1,
          ({{1{operator_4_false_acc_itm_3}}, operator_4_false_acc_itm_3}), (signext_2_1(~
          operator_4_false_1_acc_itm_2)), VCOL_else_5_else_if_for_1_for_slc_tmp_pix_10_9_0_cse_sva_1_0_1,
          {and_80_nl , and_dcpl_27 , VCOL_and_50_nl , VCOL_and_48_nl , VCOL_and_49_nl});
    end
  end
  always @(posedge clk) begin
    if ( mux_242_nl & run_wen & (fsm_output[1]) & VCOL_stage_0_1 ) begin
      tmp_pix_2_1_0_lpi_3 <= MUX_v_2_2_2(tmp_pix_2_1_0_sva_2, tmp_pix_2_1_0_lpi_3_mx1,
          and_dcpl_21);
    end
  end
  always @(posedge clk) begin
    if ( mux_245_nl & run_wen & (fsm_output[1]) & VCOL_stage_0_1 ) begin
      tmp_pix_3_1_0_lpi_3 <= MUX_v_2_2_2(tmp_pix_3_1_0_sva_2, tmp_pix_3_1_0_lpi_3_mx1,
          and_dcpl_21);
    end
  end
  always @(posedge clk) begin
    if ( mux_248_nl & run_wen & (fsm_output[1]) & VCOL_stage_0_1 ) begin
      tmp_pix_4_1_0_lpi_3 <= MUX_v_2_2_2(tmp_pix_4_1_0_sva_2, tmp_pix_4_1_0_lpi_3_mx1,
          and_dcpl_21);
    end
  end
  always @(posedge clk) begin
    if ( mux_251_nl & run_wen & (fsm_output[1]) & VCOL_stage_0_1 ) begin
      tmp_pix_5_1_0_lpi_3 <= MUX_v_2_2_2(tmp_pix_5_1_0_sva_2, tmp_pix_5_1_0_lpi_3_mx1,
          and_dcpl_21);
    end
  end
  always @(posedge clk) begin
    if ( mux_254_nl & run_wen & (fsm_output[1]) & VCOL_stage_0_1 ) begin
      tmp_pix_6_1_0_lpi_3 <= MUX_v_2_2_2(tmp_pix_6_1_0_sva_2, tmp_pix_6_1_0_lpi_3_mx1,
          and_dcpl_21);
    end
  end
  always @(posedge clk) begin
    if ( mux_257_nl & run_wen & (fsm_output[1]) & VCOL_stage_0_1 ) begin
      tmp_pix_7_1_0_lpi_3 <= MUX_v_2_2_2(tmp_pix_7_1_0_sva_2, tmp_pix_7_1_0_lpi_3_mx1,
          and_dcpl_21);
    end
  end
  always @(posedge clk) begin
    if ( mux_260_nl & run_wen & (fsm_output[1]) & VCOL_stage_0_1 ) begin
      tmp_pix_8_1_0_lpi_3 <= MUX_v_2_2_2(tmp_pix_8_1_0_sva_2, tmp_pix_8_1_0_lpi_3_mx1,
          and_dcpl_21);
    end
  end
  always @(posedge clk) begin
    if ( mux_266_nl & (fsm_output[1]) & run_wen & and_254_cse ) begin
      pix_0_9_2_lpi_3 <= pix_0_9_2_lpi_3_dfm_9_mx1w0;
    end
  end
  always @(posedge clk) begin
    if ( mux_272_nl & (fsm_output[1]) & run_wen & VCOL_stage_0_2 ) begin
      pix_6_9_2_lpi_3 <= MUX_v_8_2_2(pix_3_9_2_lpi_3_dfm_11, pix_6_9_2_lpi_3_dfm_9,
          and_dcpl_44);
    end
  end
  always @(posedge clk) begin
    if ( mux_276_nl & (fsm_output[1]) & run_wen & VCOL_stage_0_2 ) begin
      pix_8_9_2_lpi_3 <= MUX_v_8_2_2(pix_5_9_2_lpi_3_dfm_6_mx0, pix_8_9_2_lpi_3_dfm_8,
          and_dcpl_44);
    end
  end
  always @(posedge clk) begin
    if ( (~((~(mux_277_nl & (VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1==2'b10)
        & (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_0) & lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_1
        & (~ exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1) & (~ operator_4_false_2_acc_itm_3)))
        & VCOL_stage_0_2)) & and_dcpl_69 ) begin
      tmp_pix_8_1_0_lpi_3_dfm_2_1 <= MUX_v_2_2_2(tmp_pix_8_1_0_sva_2, tmp_pix_8_1_0_lpi_3_mx1,
          or_dcpl_63);
    end
  end
  always @(posedge clk) begin
    if ( (~((~(mux_278_nl & (VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1==2'b10)
        & (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_0) & lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_1
        & (~ exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1) & (~ operator_4_false_2_acc_itm_3)))
        & VCOL_stage_0_2)) & and_dcpl_69 ) begin
      tmp_pix_7_1_0_lpi_3_dfm_2_1 <= MUX_v_2_2_2(tmp_pix_7_1_0_sva_2, tmp_pix_7_1_0_lpi_3_mx1,
          or_dcpl_63);
    end
  end
  always @(posedge clk) begin
    if ( (~((~(mux_279_nl & (VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1==2'b10)
        & (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_0) & lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_1
        & (~ exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1) & (~ operator_4_false_2_acc_itm_3)))
        & VCOL_stage_0_2)) & and_dcpl_69 ) begin
      tmp_pix_6_1_0_lpi_3_dfm_2_1 <= MUX_v_2_2_2(tmp_pix_6_1_0_sva_2, tmp_pix_6_1_0_lpi_3_mx1,
          or_dcpl_63);
    end
  end
  always @(posedge clk) begin
    if ( (~((~(mux_280_nl & (VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1==2'b10)
        & (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_0) & lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_1
        & (~ exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1) & (~ operator_4_false_2_acc_itm_3)))
        & VCOL_stage_0_2)) & and_dcpl_69 ) begin
      tmp_pix_5_1_0_lpi_3_dfm_2_1 <= MUX_v_2_2_2(tmp_pix_5_1_0_sva_2, tmp_pix_5_1_0_lpi_3_mx1,
          or_dcpl_63);
    end
  end
  always @(posedge clk) begin
    if ( (~((~(mux_281_nl & (VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1==2'b10)
        & (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_0) & lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_1
        & (~ exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1) & (~ operator_4_false_2_acc_itm_3)))
        & VCOL_stage_0_2)) & and_dcpl_69 ) begin
      tmp_pix_4_1_0_lpi_3_dfm_2_1 <= MUX_v_2_2_2(tmp_pix_4_1_0_sva_2, tmp_pix_4_1_0_lpi_3_mx1,
          or_dcpl_63);
    end
  end
  always @(posedge clk) begin
    if ( (~((~(mux_282_nl & (VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1==2'b10)
        & (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_0) & lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_1
        & (~ exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1) & (~ operator_4_false_2_acc_itm_3)))
        & VCOL_stage_0_2)) & and_dcpl_69 ) begin
      tmp_pix_3_1_0_lpi_3_dfm_2_1 <= MUX_v_2_2_2(tmp_pix_3_1_0_sva_2, tmp_pix_3_1_0_lpi_3_mx1,
          or_dcpl_63);
    end
  end
  always @(posedge clk) begin
    if ( (~((~(mux_283_nl & (VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1==2'b10)
        & (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_0) & lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_1
        & (~ exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1) & (~ operator_4_false_2_acc_itm_3)))
        & VCOL_stage_0_2)) & and_dcpl_69 ) begin
      tmp_pix_2_1_0_lpi_3_dfm_2_1 <= MUX_v_2_2_2(tmp_pix_2_1_0_sva_2, tmp_pix_2_1_0_lpi_3_mx1,
          or_dcpl_63);
    end
  end
  always @(posedge clk) begin
    if ( (~((~(mux_284_nl & (VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1==2'b10)
        & (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_0) & lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_1
        & (~ exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1) & (~ operator_4_false_2_acc_itm_3)))
        & VCOL_stage_0_2)) & and_dcpl_69 ) begin
      tmp_pix_1_1_0_lpi_3_dfm_2_1 <= MUX_v_2_2_2(tmp_pix_1_1_0_sva_2, tmp_pix_1_1_0_lpi_3_mx1,
          or_dcpl_63);
    end
  end
  always @(posedge clk) begin
    if ( (~ mux_291_nl) & and_dcpl_69 ) begin
      tmp_pix_0_1_0_lpi_3_dfm_2_1 <= MUX_v_2_2_2(tmp_pix_0_1_0_sva_2, tmp_pix_0_1_0_lpi_3_mx1,
          operator_4_false_2_acc_itm_3);
    end
  end
  always @(posedge clk) begin
    if ( (~ mux_299_nl) & and_dcpl_69 ) begin
      max_val_lpi_3_dfm_5_1_9_2 <= MUX1HOT_v_8_3_2(({{7{operator_4_false_acc_itm_3}},
          operator_4_false_acc_itm_3}), max_val_lpi_3_dfm_3_9_2_1, max_val_lpi_3_dfm_1_9_2_mx0,
          {(~ VCOL_and_7_ssc_1) , VCOL_and_51_nl , VCOL_and_52_nl});
    end
  end
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      max_i_lpi_3 <= 4'b0000;
    end
    else if ( rst ) begin
      max_i_lpi_3 <= 4'b0000;
    end
    else if ( (~ mux_304_nl) & and_dcpl_69 & (fsm_output[1]) ) begin
      max_i_lpi_3 <= MUX1HOT_v_4_3_2(i_lpi_3_dfm_4_1, max_i_lpi_3_mx1, i_1_sva_2,
          {and_229_nl , and_231_nl , VCOL_and_53_nl});
    end
  end
  always @(posedge clk) begin
    if ( (~((~((~((VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1[0]) | exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1))
        & lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_1 & (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_0)
        & (VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1[1]) & VCOL_else_5_else_if_for_1_for_if_acc_itm_10))
        & VCOL_stage_0_2)) & and_dcpl_69 ) begin
      max_i_lpi_3_dfm_2_1 <= MUX_v_4_2_2(i_lpi_3_dfm_4_1, max_i_lpi_3_mx1, or_250_nl);
    end
  end
  assign not_510_nl = ~ VROW_y_or_cse;
  assign VROW_y_not_2_nl = ~ (fsm_output[0]);
  assign nor_197_nl = ~((~ lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3) | exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva
      | operator_4_false_2_acc_itm_3 | lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_0
      | (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_1) | operator_4_false_1_acc_itm_2);
  assign mux_135_nl = MUX_s_1_2_2(nor_197_nl, mux_134_cse, VCOL_stage_0_2);
  assign and_101_nl = (~ mux_tmp_94) & nor_79_cse & VCOL_stage_0_1 & (fsm_output[1]);
  assign and_103_nl = and_dcpl_27 & (fsm_output[1]);
  assign and_105_nl = (~ mux_tmp_6) & (~ or_357_cse) & VCOL_stage_0_1 & (fsm_output[1]);
  assign or_358_nl = (~ lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3) | lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_0
      | (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_1) | operator_4_false_1_acc_itm_2
      | operator_4_false_2_acc_itm_3;
  assign mux_137_nl = MUX_s_1_2_2(or_358_nl, or_357_cse, exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva);
  assign nor_199_nl = ~((VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1[0]) | (~((VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1[1])
      & ((~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_1) | lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_0
      | operator_4_false_1_acc_itm_2 | operator_4_false_2_acc_itm_3))));
  assign mux_136_nl = MUX_s_1_2_2(nor_199_nl, VCOL_else_4_else_aif_equal_tmp, exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1);
  assign mux_138_nl = MUX_s_1_2_2(mux_137_nl, mux_136_nl, VCOL_stage_0_2);
  assign operator_11_false_mux_nl = MUX_s_1_2_2(lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_0,
      VCOL_VCOL_oelse_operator_11_false_or_tmp, mux_tmp_34);
  assign mux_19_nl = MUX_s_1_2_2(operator_4_false_acc_itm_3, lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_0,
      lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_1);
  assign nor_74_nl = ~((ctrl_signal_rsci_idat!=2'b10) | (~ operator_4_false_acc_itm_3));
  assign mux_20_nl = MUX_s_1_2_2(mux_19_nl, nor_74_nl, or_40_cse);
  assign mux_17_nl = MUX_s_1_2_2(operator_4_false_acc_itm_3, lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_0,
      lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_1);
  assign nor_75_nl = ~((VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1[0]) | (~((VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1[1])
      & mux_17_nl)));
  assign nor_76_nl = ~(VCOL_else_4_else_aif_equal_tmp | (ctrl_signal_rsci_idat!=2'b10)
      | (~ operator_4_false_acc_itm_3));
  assign mux_18_nl = MUX_s_1_2_2(nor_75_nl, nor_76_nl, exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1);
  assign mux_21_nl = MUX_s_1_2_2(mux_20_nl, mux_18_nl, VCOL_stage_0_2);
  assign j_and_6_nl = (~ tmp_pix_and_27_rgt) & j_or_1_rgt;
  assign j_and_7_nl = tmp_pix_and_27_rgt & j_or_1_rgt;
  assign j_and_4_nl = (~(VCOL_asn_80_rgt | or_dcpl_3)) & (fsm_output[1]);
  assign j_and_2_nl = VCOL_asn_80_rgt & (~ or_dcpl_3) & (fsm_output[1]);
  assign or_373_nl = (max_i_lpi_3!=4'b0001);
  assign or_371_nl = (i_lpi_3_dfm_4_1!=4'b0001);
  assign mux_142_nl = MUX_s_1_2_2(or_373_nl, or_371_nl, VCOL_else_5_else_if_for_1_for_if_acc_itm_10);
  assign mux_143_nl = MUX_s_1_2_2(mux_142_nl, or_704_cse, operator_4_false_1_acc_itm_2);
  assign or_374_nl = operator_4_false_2_acc_itm_3 | mux_143_nl;
  assign mux_144_nl = MUX_s_1_2_2(or_374_nl, or_704_cse, or_368_cse);
  assign mux_145_nl = MUX_s_1_2_2(mux_144_nl, or_357_cse, or_40_cse);
  assign nor_204_nl = ~((~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_1) |
      lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_0 | (~ operator_4_false_2_acc_itm_3)
      | (VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1!=2'b10));
  assign mux_141_nl = MUX_s_1_2_2(nor_204_nl, VCOL_else_4_else_aif_equal_tmp, exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1);
  assign mux_146_nl = MUX_s_1_2_2(mux_145_nl, mux_141_nl, VCOL_stage_0_2);
  assign VCOL_else_5_else_if_for_1_and_44_nl = (~ operator_4_false_2_acc_itm_3) &
      VCOL_else_5_else_if_for_1_equal_tmp_mx0w1;
  assign VCOL_else_5_else_if_for_1_and_45_nl = operator_4_false_2_acc_itm_3 & VCOL_else_5_else_if_for_1_equal_tmp_mx0w1;
  assign or_50_nl = lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_1 | operator_4_false_acc_itm_3;
  assign mux_26_nl = MUX_s_1_2_2(or_50_nl, or_tmp_35, or_52_cse);
  assign mux_27_nl = MUX_s_1_2_2(mux_26_nl, or_tmp_35, lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_0);
  assign mux_28_nl = MUX_s_1_2_2(mux_27_nl, or_49_cse, or_40_cse);
  assign mux_23_nl = MUX_s_1_2_2(operator_4_false_acc_itm_3, nor_79_cse, lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_1);
  assign or_nl = (VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1!=2'b10) | mux_23_nl;
  assign mux_24_nl = MUX_s_1_2_2(or_nl, or_46_cse, exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1);
  assign mux_29_nl = MUX_s_1_2_2(mux_28_nl, mux_24_nl, VCOL_stage_0_2);
  assign nor_206_nl = ~(VCOL_else_4_else_aif_equal_tmp | (~ exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1));
  assign mux_147_nl = MUX_s_1_2_2(or_40_cse, nor_206_nl, VCOL_stage_0_2);
  assign and_165_nl = and_dcpl_44 & (fsm_output[1]);
  assign or_382_nl = reg_operator_11_false_6_nor_itm_1_cse | exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1
      | (VCOL_x_sva!=11'b00000000001);
  assign mux_149_nl = MUX_s_1_2_2(exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1,
      or_382_nl, VROW_equal_tmp);
  assign nor_207_nl = ~(operator_10_false_1_operator_10_false_1_and_cse_sva_1_1 |
      (~ exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1) | (VCOL_x_sva!=11'b00000000001));
  assign nand_55_nl = ~(operator_10_false_1_operator_10_false_1_and_cse_sva_1_1 &
      nand_82_cse);
  assign mux_148_nl = MUX_s_1_2_2(nor_207_nl, nand_55_nl, VROW_equal_tmp);
  assign mux_150_nl = MUX_s_1_2_2(mux_149_nl, mux_148_nl, VCOL_else_4_else_aif_equal_tmp);
  assign or_378_nl = (~ exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva) | VCOL_land_1_lpi_3_dfm_1;
  assign mux_151_nl = MUX_s_1_2_2(mux_150_nl, exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1,
      or_378_nl);
  assign and_448_nl = ((~ operator_10_false_1_operator_10_false_1_and_cse_sva_1_1)
      | VCOL_land_1_lpi_3_dfm_1) & exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva;
  assign and_449_nl = (reg_operator_11_false_6_nor_itm_1_cse | VCOL_land_1_lpi_3_dfm_1)
      & exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva;
  assign mux_152_nl = MUX_s_1_2_2(and_448_nl, and_449_nl, VROW_equal_tmp);
  assign mux_153_nl = MUX_s_1_2_2(exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva,
      mux_152_nl, VCOL_else_4_else_aif_equal_tmp);
  assign and_451_nl = (and_450_cse | VCOL_land_1_lpi_3_dfm_1) & exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva;
  assign mux_154_nl = MUX_s_1_2_2(mux_153_nl, and_451_nl, or_384_cse);
  assign mux_155_nl = MUX_s_1_2_2(and_cse, mux_154_nl, VCOL_x_sva[0]);
  assign or_383_nl = VCOL_else_4_else_aif_equal_tmp | (VROW_y_sva[9:2]!=8'b00000000)
      | (~ (VCOL_x_sva_2[0])) | (VROW_y_sva[1:0]!=2'b01) | (~ VCOL_stage_0_1) | (VCOL_x_sva_2[10:1]!=10'b0000000000);
  assign mux_156_nl = MUX_s_1_2_2(mux_155_nl, or_383_nl, exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1);
  assign and_297_nl = exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva & (or_tmp_301
      | (operator_10_false_1_operator_10_false_1_and_cse_sva_1_1 & (~(nor_211_cse
      | VROW_equal_tmp))));
  assign and_453_nl = operator_10_false_1_operator_10_false_1_and_cse_sva_1_1 & (~(nor_211_cse
      | VROW_equal_tmp | (~ mux_tmp_159)));
  assign mux_160_nl = MUX_s_1_2_2(and_453_nl, mux_tmp_159, or_tmp_301);
  assign and_296_nl = exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva & mux_160_nl;
  assign mux_161_nl = MUX_s_1_2_2(mux_tmp_159, and_296_nl, operator_11_false_4_operator_11_false_4_nor_cse_lpi_3_dfm_1);
  assign mux_162_nl = MUX_s_1_2_2(and_297_nl, mux_161_nl, exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1);
  assign or_393_nl = (~ VROW_equal_tmp) | reg_operator_11_false_6_nor_itm_1_cse;
  assign mux_157_nl = MUX_s_1_2_2(or_393_nl, and_450_cse, or_384_cse);
  assign or_394_nl = (~ exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva) | operator_11_false_4_operator_11_false_4_nor_cse_sva_1
      | VCOL_land_1_lpi_3_dfm_1 | operator_10_false_1_operator_10_false_1_and_cse_sva_1_1
      | ((VCOL_x_sva[0]) & mux_157_nl);
  assign and_294_nl = exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva & (or_tmp_301
      | (operator_10_false_1_operator_10_false_1_and_cse_sva_1_1 & (~((VCOL_x_sva[0])
      & VROW_equal_tmp & reg_operator_11_false_6_nor_itm_1_cse))));
  assign mux_158_nl = MUX_s_1_2_2(or_394_nl, and_294_nl, or_388_cse);
  assign mux_163_nl = MUX_s_1_2_2(mux_162_nl, mux_158_nl, VCOL_else_4_else_aif_equal_tmp);
  assign and_301_nl = ((~ VCOL_stage_0_1) | (VCOL_x_sva_2!=11'b00000000000)) & nand_tmp_9;
  assign mux_167_nl = MUX_s_1_2_2(nand_tmp_9, mux_tmp_164, or_384_cse);
  assign mux_166_nl = MUX_s_1_2_2(mux_tmp_164, nand_tmp_9, reg_operator_11_false_6_nor_itm_1_cse);
  assign mux_168_nl = MUX_s_1_2_2(mux_167_nl, mux_166_nl, VROW_equal_tmp);
  assign mux_169_nl = MUX_s_1_2_2(mux_tmp_164, mux_168_nl, VCOL_x_sva[0]);
  assign mux_165_nl = MUX_s_1_2_2(mux_tmp_164, nand_tmp_9, and_457_cse);
  assign mux_170_nl = MUX_s_1_2_2(mux_169_nl, mux_165_nl, operator_10_false_1_operator_10_false_1_and_cse_sva_1_1);
  assign mux_171_nl = MUX_s_1_2_2(mux_170_nl, nand_tmp_9, VCOL_land_1_lpi_3_dfm_1);
  assign mux_172_nl = MUX_s_1_2_2(and_301_nl, mux_171_nl, VCOL_else_4_else_aif_equal_tmp);
  assign mux_173_nl = MUX_s_1_2_2(VCOL_else_5_else_if_for_1_and_39_cse, mux_172_nl,
      exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1);
  assign mux_176_nl = MUX_s_1_2_2(or_tmp_327, (~ or_tmp_323), VCOL_x_sva_2[0]);
  assign or_414_nl = (VCOL_x_sva_2[10:1]!=10'b0000000000);
  assign mux_177_nl = MUX_s_1_2_2(mux_176_nl, or_tmp_327, or_414_nl);
  assign or_413_nl = (VCOL_x_sva!=11'b00000000001) | operator_10_false_1_operator_10_false_1_and_cse_sva_1_1
      | operator_11_false_4_operator_11_false_4_nor_cse_sva_1 | VCOL_and_16_itm_1;
  assign or_412_nl = (~ (VCOL_x_sva[0])) | (~ reg_operator_11_false_6_nor_itm_1_cse)
      | operator_11_false_4_operator_11_false_4_nor_cse_sva_1 | VCOL_and_16_itm_1;
  assign mux_174_nl = MUX_s_1_2_2(or_413_nl, or_412_nl, VROW_equal_tmp);
  assign mux_175_nl = MUX_s_1_2_2(mux_174_nl, or_tmp_323, VCOL_land_1_lpi_3_dfm_1);
  assign mux_178_nl = MUX_s_1_2_2((~ mux_177_nl), mux_175_nl, VCOL_else_4_else_aif_equal_tmp);
  assign nand_85_nl = ~((VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1==2'b11));
  assign nor_215_nl = ~(((ctrl_signal_rsci_idat==2'b11)) | VCOL_else_4_else_aif_equal_tmp);
  assign mux_179_nl = MUX_s_1_2_2(nand_85_nl, nor_215_nl, exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1);
  assign nor_77_nl = ~(exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva | (~ lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3)
      | (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_1) | lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_0);
  assign nor_78_nl = ~(exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1 | (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_1)
      | lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_0 | (VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1!=2'b10));
  assign mux_33_nl = MUX_s_1_2_2(nor_77_nl, nor_78_nl, VCOL_stage_0_2);
  assign VCOL_else_5_else_if_for_1_and_31_nl = MUX_v_8_2_2(8'b00000000, tmp_pix_1_9_2_lpi_3_mx1,
      VCOL_else_5_else_if_for_1_VCOL_else_5_else_if_for_1_nand_5_seb_sva_1);
  assign or_434_nl = operator_4_false_2_acc_itm_3 | (max_i_lpi_3!=4'b0001) | (~ VCOL_stage_0_1);
  assign mux_183_nl = MUX_s_1_2_2(or_434_nl, or_tmp_332, VCOL_else_5_else_if_for_1_for_if_acc_itm_10);
  assign nor_217_nl = ~(exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva | lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_0
      | (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_1) | (~ lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3)
      | mux_183_nl);
  assign or_431_nl = (max_i_lpi_3!=4'b0001) | (~ VCOL_stage_0_1);
  assign mux_181_nl = MUX_s_1_2_2(or_431_nl, or_429_cse, lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_1);
  assign or_713_nl = exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1 | (VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1!=2'b10)
      | mux_181_nl;
  assign or_425_nl = (max_i_lpi_3_dfm_2_1!=4'b0001) | operator_4_false_2_acc_itm_3
      | (~ VCOL_stage_0_1);
  assign mux_180_nl = MUX_s_1_2_2(or_425_nl, or_tmp_332, VCOL_else_5_else_if_for_1_for_if_acc_itm_10);
  assign nor_218_nl = ~(exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1 | (VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1!=2'b10)
      | (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_1) | lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_0
      | mux_180_nl);
  assign or_420_nl = (i_1_lpi_3_dfm_1!=4'b0001) | (~ VCOL_equal_tmp_2_1) | lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3;
  assign mux_182_nl = MUX_s_1_2_2(or_713_nl, nor_218_nl, or_420_nl);
  assign mux_184_nl = MUX_s_1_2_2(nor_217_nl, mux_182_nl, VCOL_stage_0_2);
  assign VCOL_else_5_else_if_for_1_and_35_nl = MUX_v_8_2_2(8'b00000000, tmp_pix_5_9_2_lpi_3_mx1,
      VCOL_else_5_else_if_for_1_VCOL_else_5_else_if_for_1_nand_2_seb_sva_1);
  assign or_449_nl = operator_4_false_2_acc_itm_3 | (max_i_lpi_3[1]) | (~ (max_i_lpi_3[0]))
      | (max_i_lpi_3[3]) | not_tmp_188;
  assign mux_188_nl = MUX_s_1_2_2(or_449_nl, or_tmp_347, VCOL_else_5_else_if_for_1_for_if_acc_itm_10);
  assign nor_220_nl = ~(exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva | lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_0
      | (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_1) | (~ lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3)
      | mux_188_nl);
  assign or_446_nl = (max_i_lpi_3[1]) | (~ (max_i_lpi_3[0])) | (max_i_lpi_3[3]) |
      not_tmp_188;
  assign mux_186_nl = MUX_s_1_2_2(or_446_nl, or_444_cse, lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_1);
  assign or_715_nl = exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1 | (VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1!=2'b10)
      | mux_186_nl;
  assign or_440_nl = (max_i_lpi_3_dfm_2_1!=4'b0101) | operator_4_false_2_acc_itm_3
      | (~ VCOL_stage_0_1);
  assign mux_185_nl = MUX_s_1_2_2(or_440_nl, or_tmp_347, VCOL_else_5_else_if_for_1_for_if_acc_itm_10);
  assign nor_221_nl = ~(exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1 | (VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1!=2'b10)
      | (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_1) | lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_0
      | mux_185_nl);
  assign or_435_nl = (i_1_lpi_3_dfm_1!=4'b0101) | (~ VCOL_equal_tmp_2_1) | lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3;
  assign mux_187_nl = MUX_s_1_2_2(or_715_nl, nor_221_nl, or_435_nl);
  assign mux_189_nl = MUX_s_1_2_2(nor_220_nl, mux_187_nl, VCOL_stage_0_2);
  assign VCOL_else_5_else_if_for_1_and_32_nl = MUX_v_8_2_2(8'b00000000, tmp_pix_2_9_2_lpi_3_mx1,
      VCOL_else_5_else_if_for_1_VCOL_else_5_else_if_for_1_nand_3_seb_sva_1);
  assign or_464_nl = operator_4_false_2_acc_itm_3 | (max_i_lpi_3!=4'b0010) | (~ VCOL_stage_0_1);
  assign mux_193_nl = MUX_s_1_2_2(or_464_nl, or_tmp_362, VCOL_else_5_else_if_for_1_for_if_acc_itm_10);
  assign nor_223_nl = ~(exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva | lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_0
      | (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_1) | (~ lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3)
      | mux_193_nl);
  assign or_461_nl = (max_i_lpi_3!=4'b0010) | (~ VCOL_stage_0_1);
  assign mux_191_nl = MUX_s_1_2_2(or_461_nl, or_429_cse, lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_1);
  assign or_717_nl = exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1 | (VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1!=2'b10)
      | mux_191_nl;
  assign or_455_nl = (max_i_lpi_3_dfm_2_1!=4'b0010) | operator_4_false_2_acc_itm_3
      | (~ VCOL_stage_0_1);
  assign mux_190_nl = MUX_s_1_2_2(or_455_nl, or_tmp_362, VCOL_else_5_else_if_for_1_for_if_acc_itm_10);
  assign nor_224_nl = ~(exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1 | (VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1!=2'b10)
      | (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_1) | lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_0
      | mux_190_nl);
  assign or_450_nl = (i_1_lpi_3_dfm_1!=4'b0010) | (~ VCOL_equal_tmp_2_1) | lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3;
  assign mux_192_nl = MUX_s_1_2_2(or_717_nl, nor_224_nl, or_450_nl);
  assign mux_194_nl = MUX_s_1_2_2(nor_223_nl, mux_192_nl, VCOL_stage_0_2);
  assign VCOL_else_5_else_if_for_1_and_36_nl = MUX_v_8_2_2(8'b00000000, tmp_pix_6_9_2_lpi_3_mx1,
      VCOL_else_5_else_if_for_1_VCOL_else_5_else_if_for_1_nand_4_seb_sva_1);
  assign or_479_nl = operator_4_false_2_acc_itm_3 | (~ (max_i_lpi_3[1])) | (max_i_lpi_3[0])
      | (max_i_lpi_3[3]) | not_tmp_188;
  assign mux_198_nl = MUX_s_1_2_2(or_479_nl, or_tmp_377, VCOL_else_5_else_if_for_1_for_if_acc_itm_10);
  assign nor_226_nl = ~(exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva | lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_0
      | (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_1) | (~ lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3)
      | mux_198_nl);
  assign or_476_nl = (~ (max_i_lpi_3[1])) | (max_i_lpi_3[0]) | (max_i_lpi_3[3]) |
      not_tmp_188;
  assign mux_196_nl = MUX_s_1_2_2(or_476_nl, or_444_cse, lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_1);
  assign or_719_nl = exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1 | (VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1!=2'b10)
      | mux_196_nl;
  assign or_470_nl = (max_i_lpi_3_dfm_2_1!=4'b0110) | operator_4_false_2_acc_itm_3
      | (~ VCOL_stage_0_1);
  assign mux_195_nl = MUX_s_1_2_2(or_470_nl, or_tmp_377, VCOL_else_5_else_if_for_1_for_if_acc_itm_10);
  assign nor_227_nl = ~(exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1 | (VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1!=2'b10)
      | (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_1) | lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_0
      | mux_195_nl);
  assign or_465_nl = (i_1_lpi_3_dfm_1!=4'b0110) | (~ VCOL_equal_tmp_2_1) | lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3;
  assign mux_197_nl = MUX_s_1_2_2(or_719_nl, nor_227_nl, or_465_nl);
  assign mux_199_nl = MUX_s_1_2_2(nor_226_nl, mux_197_nl, VCOL_stage_0_2);
  assign VCOL_else_5_else_if_for_1_and_33_nl = MUX_v_8_2_2(8'b00000000, tmp_pix_3_9_2_lpi_3_mx1,
      VCOL_else_5_else_if_for_1_VCOL_else_5_else_if_for_1_nand_1_seb_sva_1);
  assign or_494_nl = operator_4_false_2_acc_itm_3 | (max_i_lpi_3!=4'b0011) | (~ VCOL_stage_0_1);
  assign mux_203_nl = MUX_s_1_2_2(or_494_nl, or_tmp_392, VCOL_else_5_else_if_for_1_for_if_acc_itm_10);
  assign nor_229_nl = ~(exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva | lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_0
      | (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_1) | (~ lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3)
      | mux_203_nl);
  assign or_491_nl = (max_i_lpi_3!=4'b0011) | (~ VCOL_stage_0_1);
  assign mux_201_nl = MUX_s_1_2_2(or_491_nl, or_429_cse, lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_1);
  assign or_721_nl = exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1 | (VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1!=2'b10)
      | mux_201_nl;
  assign or_485_nl = (max_i_lpi_3_dfm_2_1!=4'b0011) | operator_4_false_2_acc_itm_3
      | (~ VCOL_stage_0_1);
  assign mux_200_nl = MUX_s_1_2_2(or_485_nl, or_tmp_392, VCOL_else_5_else_if_for_1_for_if_acc_itm_10);
  assign nor_230_nl = ~(exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1 | (VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1!=2'b10)
      | (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_1) | lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_0
      | mux_200_nl);
  assign or_480_nl = (i_1_lpi_3_dfm_1!=4'b0011) | (~ VCOL_equal_tmp_2_1) | lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3;
  assign mux_202_nl = MUX_s_1_2_2(or_721_nl, nor_230_nl, or_480_nl);
  assign mux_204_nl = MUX_s_1_2_2(nor_229_nl, mux_202_nl, VCOL_stage_0_2);
  assign VCOL_else_5_else_if_for_1_and_37_nl = MUX_v_8_2_2(8'b00000000, tmp_pix_7_9_2_lpi_3_mx1,
      VCOL_else_5_else_if_for_1_VCOL_else_5_else_if_for_1_nand_6_seb_sva_1);
  assign or_509_nl = operator_4_false_2_acc_itm_3 | (~ (max_i_lpi_3[1])) | (~ (max_i_lpi_3[0]))
      | (max_i_lpi_3[3]) | not_tmp_188;
  assign mux_208_nl = MUX_s_1_2_2(or_509_nl, or_tmp_407, VCOL_else_5_else_if_for_1_for_if_acc_itm_10);
  assign nor_232_nl = ~(exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva | lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_0
      | (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_1) | (~ lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3)
      | mux_208_nl);
  assign or_506_nl = (~ (max_i_lpi_3[1])) | (~ (max_i_lpi_3[0])) | (max_i_lpi_3[3])
      | not_tmp_188;
  assign mux_206_nl = MUX_s_1_2_2(or_506_nl, or_444_cse, lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_1);
  assign or_723_nl = exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1 | (VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1!=2'b10)
      | mux_206_nl;
  assign or_500_nl = (max_i_lpi_3_dfm_2_1!=4'b0111) | operator_4_false_2_acc_itm_3
      | (~ VCOL_stage_0_1);
  assign mux_205_nl = MUX_s_1_2_2(or_500_nl, or_tmp_407, VCOL_else_5_else_if_for_1_for_if_acc_itm_10);
  assign nor_233_nl = ~(exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1 | (VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1!=2'b10)
      | (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_1) | lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_0
      | mux_205_nl);
  assign or_495_nl = (i_1_lpi_3_dfm_1!=4'b0111) | (~ VCOL_equal_tmp_2_1) | lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3;
  assign mux_207_nl = MUX_s_1_2_2(or_723_nl, nor_233_nl, or_495_nl);
  assign mux_209_nl = MUX_s_1_2_2(nor_232_nl, mux_207_nl, VCOL_stage_0_2);
  assign VCOL_else_5_else_if_for_1_and_30_nl = MUX_v_8_2_2(8'b00000000, tmp_pix_0_9_2_lpi_3_mx0,
      VCOL_else_5_else_if_for_1_VCOL_else_5_else_if_for_1_nand_7_seb_sva_1);
  assign or_149_nl = lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_0 | (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_1);
  assign mux_120_nl = MUX_s_1_2_2(or_368_cse, or_149_nl, VCOL_stage_0_2);
  assign nor_131_nl = ~(mux_120_nl | operator_4_false_2_acc_itm_3);
  assign and_460_nl = lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3 & (~ and_tmp_19);
  assign nor_234_nl = ~((~ lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3) | (~
      VCOL_else_5_else_if_for_1_for_if_acc_itm_10) | (i_lpi_3_dfm_4_1!=4'b0000));
  assign mux_215_nl = MUX_s_1_2_2(and_460_nl, nor_234_nl, or_516_cse);
  assign and_461_nl = (~(lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_0 | (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_1)
      | exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva | operator_4_false_2_acc_itm_3
      | (~ operator_4_false_1_acc_itm_2))) & mux_215_nl;
  assign or_724_nl = (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_1) | lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_0
      | operator_4_false_2_acc_itm_3 | (~ operator_4_false_1_acc_itm_2) | mux_tmp_210;
  assign or_515_nl = (~((max_i_lpi_3!=4'b0000))) | lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3;
  assign nand_66_nl = ~(operator_4_false_1_acc_itm_2 & (~(lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3
      & mux_tmp_210)));
  assign mux_211_nl = MUX_s_1_2_2(nand_66_nl, lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3,
      operator_4_false_2_acc_itm_3);
  assign or_510_nl = (~ (max_i_lpi_3[3])) | lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3;
  assign mux_212_nl = MUX_s_1_2_2(mux_211_nl, or_510_nl, lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_0);
  assign mux_213_nl = MUX_s_1_2_2(or_515_nl, mux_212_nl, lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_1);
  assign nor_165_nl = ~((i_1_lpi_3_dfm_1!=4'b0000) | (~ VCOL_equal_tmp_2_1));
  assign mux_214_nl = MUX_s_1_2_2(or_724_nl, mux_213_nl, nor_165_nl);
  assign nor_236_nl = ~(exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1 | (VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1!=2'b10)
      | mux_214_nl);
  assign mux_216_nl = MUX_s_1_2_2(and_461_nl, nor_236_nl, VCOL_stage_0_2);
  assign VCOL_else_5_else_if_for_1_and_38_nl = MUX_v_8_2_2(8'b00000000, tmp_pix_8_9_2_lpi_3_mx1,
      VCOL_else_5_else_if_for_1_VCOL_else_5_else_if_for_1_nand_8_seb_sva_1);
  assign or_530_nl = operator_4_false_2_acc_itm_3 | (max_i_lpi_3[2:0]!=3'b000) |
      not_tmp_217;
  assign mux_220_nl = MUX_s_1_2_2(or_530_nl, or_tmp_430, VCOL_else_5_else_if_for_1_for_if_acc_itm_10);
  assign nor_239_nl = ~(exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva | lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_0
      | (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_1) | (~ lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3)
      | mux_220_nl);
  assign or_727_nl = (max_i_lpi_3[2:0]!=3'b000) | not_tmp_217;
  assign nand_87_nl = ~(lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_0 & (max_i_lpi_3[3])
      & VCOL_stage_0_1);
  assign mux_218_nl = MUX_s_1_2_2(or_727_nl, nand_87_nl, lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_1);
  assign or_728_nl = exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1 | (VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1!=2'b10)
      | mux_218_nl;
  assign or_523_nl = (max_i_lpi_3_dfm_2_1!=4'b1000) | operator_4_false_2_acc_itm_3
      | (~ VCOL_stage_0_1);
  assign mux_217_nl = MUX_s_1_2_2(or_523_nl, or_tmp_430, VCOL_else_5_else_if_for_1_for_if_acc_itm_10);
  assign nor_240_nl = ~(exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1 | (VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1!=2'b10)
      | (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_1) | lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_0
      | mux_217_nl);
  assign or_518_nl = (i_1_lpi_3_dfm_1!=4'b1000) | (~ VCOL_equal_tmp_2_1) | lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3;
  assign mux_219_nl = MUX_s_1_2_2(or_728_nl, nor_240_nl, or_518_nl);
  assign mux_221_nl = MUX_s_1_2_2(nor_239_nl, mux_219_nl, VCOL_stage_0_2);
  assign VCOL_else_5_else_if_for_1_and_34_nl = MUX_v_8_2_2(8'b00000000, tmp_pix_4_9_2_lpi_3_mx1,
      VCOL_else_5_else_if_for_1_VCOL_else_5_else_if_for_1_nand_seb_sva_1);
  assign or_545_nl = operator_4_false_2_acc_itm_3 | (max_i_lpi_3[1]) | (max_i_lpi_3[0])
      | (max_i_lpi_3[3]) | not_tmp_188;
  assign mux_225_nl = MUX_s_1_2_2(or_545_nl, or_tmp_443, VCOL_else_5_else_if_for_1_for_if_acc_itm_10);
  assign nor_242_nl = ~(exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva | lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_0
      | (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_1) | (~ lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3)
      | mux_225_nl);
  assign or_542_nl = (max_i_lpi_3[1]) | (max_i_lpi_3[0]) | (max_i_lpi_3[3]) | not_tmp_188;
  assign mux_223_nl = MUX_s_1_2_2(or_542_nl, or_444_cse, lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_1);
  assign or_730_nl = exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1 | (VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1!=2'b10)
      | mux_223_nl;
  assign or_536_nl = (max_i_lpi_3_dfm_2_1!=4'b0100) | operator_4_false_2_acc_itm_3
      | (~ VCOL_stage_0_1);
  assign mux_222_nl = MUX_s_1_2_2(or_536_nl, or_tmp_443, VCOL_else_5_else_if_for_1_for_if_acc_itm_10);
  assign nor_243_nl = ~(exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1 | (VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1!=2'b10)
      | (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_1) | lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_0
      | mux_222_nl);
  assign or_531_nl = (i_1_lpi_3_dfm_1!=4'b0100) | (~ VCOL_equal_tmp_2_1) | lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3;
  assign mux_224_nl = MUX_s_1_2_2(or_730_nl, nor_243_nl, or_531_nl);
  assign mux_226_nl = MUX_s_1_2_2(nor_242_nl, mux_224_nl, VCOL_stage_0_2);
  assign nor_134_nl = ~(exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva | (~ lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3)
      | (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_1));
  assign nor_135_nl = ~(exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1 | (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_1)
      | (VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1!=2'b10));
  assign mux_121_nl = MUX_s_1_2_2(nor_134_nl, nor_135_nl, VCOL_stage_0_2);
  assign and_80_nl = mux_121_nl & nor_79_cse & VCOL_stage_0_1;
  assign VCOL_and_50_nl = (~ VCOL_and_7_ssc_1) & and_81_m1c;
  assign VCOL_and_48_nl = (~ operator_4_false_2_acc_itm_3) & VCOL_and_7_ssc_1 & and_81_m1c;
  assign VCOL_and_49_nl = operator_4_false_2_acc_itm_3 & VCOL_and_7_ssc_1 & and_81_m1c;
  assign mux_233_nl = MUX_s_1_2_2(or_tmp_467, mux_tmp_230, or_516_cse);
  assign mux_234_nl = MUX_s_1_2_2(mux_233_nl, or_tmp_467, VCOL_else_5_else_if_for_1_for_if_acc_itm_10);
  assign or_559_nl = lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_0 | (ctrl_signal_rsci_idat!=2'b10)
      | (VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1!=2'b10);
  assign mux_235_nl = MUX_s_1_2_2(mux_234_nl, or_559_nl, operator_4_false_2_acc_itm_3);
  assign or_556_nl = VCOL_else_5_else_if_for_1_for_if_acc_itm_10 | (max_i_lpi_3!=4'b0000);
  assign mux_231_nl = MUX_s_1_2_2(or_tmp_467, mux_tmp_230, or_556_nl);
  assign or_555_nl = VCOL_else_5_else_if_for_1_for_if_acc_itm_10 | lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_0
      | (ctrl_signal_rsci_idat!=2'b10) | (VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1!=2'b10);
  assign mux_232_nl = MUX_s_1_2_2(mux_231_nl, or_555_nl, operator_4_false_2_acc_itm_3);
  assign mux_236_nl = MUX_s_1_2_2(mux_235_nl, mux_232_nl, or_554_cse);
  assign mux_237_nl = MUX_s_1_2_2((~ operator_4_false_acc_itm_3), mux_236_nl, lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_1);
  assign nor_246_nl = ~(operator_4_false_acc_itm_3 | (ctrl_signal_rsci_idat!=2'b10));
  assign mux_238_nl = MUX_s_1_2_2(mux_237_nl, nor_246_nl, or_40_cse);
  assign nor_247_nl = ~(operator_4_false_acc_itm_3 | (VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1!=2'b10));
  assign nor_248_nl = ~(nor_244_cse | (VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1!=2'b10));
  assign nor_249_nl = ~((~(VCOL_else_5_else_if_for_1_for_if_acc_itm_10 | lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_0))
      | (VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1!=2'b10));
  assign mux_227_nl = MUX_s_1_2_2(nor_248_nl, nor_249_nl, operator_4_false_2_acc_itm_3);
  assign mux_228_nl = MUX_s_1_2_2(nor_247_nl, mux_227_nl, lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_1);
  assign nor_250_nl = ~(VCOL_else_4_else_aif_equal_tmp | operator_4_false_acc_itm_3
      | (ctrl_signal_rsci_idat!=2'b10));
  assign mux_229_nl = MUX_s_1_2_2(mux_228_nl, nor_250_nl, exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1);
  assign mux_239_nl = MUX_s_1_2_2(mux_238_nl, mux_229_nl, VCOL_stage_0_2);
  assign or_568_nl = (max_i_lpi_3!=4'b0010) | operator_4_false_1_acc_itm_2 | operator_4_false_2_acc_itm_3;
  assign or_567_nl = (i_lpi_3_dfm_4_1!=4'b0010) | operator_4_false_1_acc_itm_2 |
      operator_4_false_2_acc_itm_3;
  assign mux_241_nl = MUX_s_1_2_2(or_568_nl, or_567_nl, VCOL_else_5_else_if_for_1_for_if_acc_itm_10);
  assign nor_254_nl = ~((~ lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3) | exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva
      | (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_1) | lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_0
      | mux_241_nl);
  assign mux_242_nl = MUX_s_1_2_2(nor_254_nl, mux_134_cse, VCOL_stage_0_2);
  assign or_577_nl = (max_i_lpi_3!=4'b0011) | operator_4_false_1_acc_itm_2 | operator_4_false_2_acc_itm_3;
  assign or_576_nl = (i_lpi_3_dfm_4_1!=4'b0011) | operator_4_false_1_acc_itm_2 |
      operator_4_false_2_acc_itm_3;
  assign mux_244_nl = MUX_s_1_2_2(or_577_nl, or_576_nl, VCOL_else_5_else_if_for_1_for_if_acc_itm_10);
  assign nor_259_nl = ~((~ lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3) | exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva
      | (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_1) | lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_0
      | mux_244_nl);
  assign mux_245_nl = MUX_s_1_2_2(nor_259_nl, mux_134_cse, VCOL_stage_0_2);
  assign or_586_nl = (max_i_lpi_3!=4'b0100) | operator_4_false_1_acc_itm_2 | operator_4_false_2_acc_itm_3;
  assign or_585_nl = (i_lpi_3_dfm_4_1!=4'b0100) | operator_4_false_1_acc_itm_2 |
      operator_4_false_2_acc_itm_3;
  assign mux_247_nl = MUX_s_1_2_2(or_586_nl, or_585_nl, VCOL_else_5_else_if_for_1_for_if_acc_itm_10);
  assign nor_264_nl = ~((~ lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3) | exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva
      | (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_1) | lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_0
      | mux_247_nl);
  assign mux_248_nl = MUX_s_1_2_2(nor_264_nl, mux_134_cse, VCOL_stage_0_2);
  assign or_595_nl = (max_i_lpi_3!=4'b0101) | operator_4_false_1_acc_itm_2 | operator_4_false_2_acc_itm_3;
  assign or_594_nl = (i_lpi_3_dfm_4_1!=4'b0101) | operator_4_false_1_acc_itm_2 |
      operator_4_false_2_acc_itm_3;
  assign mux_250_nl = MUX_s_1_2_2(or_595_nl, or_594_nl, VCOL_else_5_else_if_for_1_for_if_acc_itm_10);
  assign nor_269_nl = ~((~ lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3) | exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva
      | (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_1) | lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_0
      | mux_250_nl);
  assign mux_251_nl = MUX_s_1_2_2(nor_269_nl, mux_134_cse, VCOL_stage_0_2);
  assign or_604_nl = (max_i_lpi_3!=4'b0110) | operator_4_false_1_acc_itm_2 | operator_4_false_2_acc_itm_3;
  assign or_603_nl = (i_lpi_3_dfm_4_1!=4'b0110) | operator_4_false_1_acc_itm_2 |
      operator_4_false_2_acc_itm_3;
  assign mux_253_nl = MUX_s_1_2_2(or_604_nl, or_603_nl, VCOL_else_5_else_if_for_1_for_if_acc_itm_10);
  assign nor_274_nl = ~((~ lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3) | exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva
      | (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_1) | lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_0
      | mux_253_nl);
  assign mux_254_nl = MUX_s_1_2_2(nor_274_nl, mux_134_cse, VCOL_stage_0_2);
  assign or_613_nl = (max_i_lpi_3!=4'b0111) | operator_4_false_1_acc_itm_2 | operator_4_false_2_acc_itm_3;
  assign or_612_nl = (i_lpi_3_dfm_4_1!=4'b0111) | operator_4_false_1_acc_itm_2 |
      operator_4_false_2_acc_itm_3;
  assign mux_256_nl = MUX_s_1_2_2(or_613_nl, or_612_nl, VCOL_else_5_else_if_for_1_for_if_acc_itm_10);
  assign nor_279_nl = ~((~ lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3) | exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva
      | (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_1) | lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_0
      | mux_256_nl);
  assign mux_257_nl = MUX_s_1_2_2(nor_279_nl, mux_134_cse, VCOL_stage_0_2);
  assign or_622_nl = (max_i_lpi_3!=4'b1000) | operator_4_false_1_acc_itm_2 | operator_4_false_2_acc_itm_3;
  assign or_621_nl = (i_lpi_3_dfm_4_1!=4'b1000) | operator_4_false_1_acc_itm_2 |
      operator_4_false_2_acc_itm_3;
  assign mux_259_nl = MUX_s_1_2_2(or_622_nl, or_621_nl, VCOL_else_5_else_if_for_1_for_if_acc_itm_10);
  assign nor_284_nl = ~((~ lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3) | exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva
      | (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_1) | lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_0
      | mux_259_nl);
  assign mux_260_nl = MUX_s_1_2_2(nor_284_nl, mux_134_cse, VCOL_stage_0_2);
  assign and_464_nl = nand_89_cse & mux_tmp_263;
  assign mux_265_nl = MUX_s_1_2_2(and_464_nl, nand_tmp_23, VCOL_else_4_else_aif_equal_tmp);
  assign mux_264_nl = MUX_s_1_2_2(mux_tmp_263, nand_tmp_23, VCOL_else_4_else_aif_equal_tmp);
  assign nor_173_nl = ~((~((VROW_y_sva!=10'b0000000001))) | (VCOL_x_sva_2!=11'b00000000001));
  assign mux_266_nl = MUX_s_1_2_2(mux_265_nl, mux_264_nl, nor_173_nl);
  assign mux_270_nl = MUX_s_1_2_2(or_tmp_548, (~ or_tmp_547), VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1[1]);
  assign mux_271_nl = MUX_s_1_2_2(mux_270_nl, or_tmp_548, or_634_cse);
  assign and_465_nl = exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva & (~ mux_271_nl);
  assign mux_272_nl = MUX_s_1_2_2(and_465_nl, or_633_cse, exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1);
  assign mux_274_nl = MUX_s_1_2_2(or_tmp_555, (~ or_tmp_554), VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1[1]);
  assign mux_275_nl = MUX_s_1_2_2(mux_274_nl, or_tmp_555, or_634_cse);
  assign and_466_nl = exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva & (~ mux_275_nl);
  assign mux_276_nl = MUX_s_1_2_2(and_466_nl, or_633_cse, exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1);
  assign nor_287_nl = ~((max_i_lpi_3_dfm_2_1!=4'b1000));
  assign nor_288_nl = ~((i_lpi_3_dfm_4_1!=4'b1000));
  assign mux_277_nl = MUX_s_1_2_2(nor_287_nl, nor_288_nl, VCOL_else_5_else_if_for_1_for_if_acc_itm_10);
  assign nor_289_nl = ~((max_i_lpi_3_dfm_2_1!=4'b0111));
  assign nor_290_nl = ~((i_lpi_3_dfm_4_1!=4'b0111));
  assign mux_278_nl = MUX_s_1_2_2(nor_289_nl, nor_290_nl, VCOL_else_5_else_if_for_1_for_if_acc_itm_10);
  assign nor_291_nl = ~((max_i_lpi_3_dfm_2_1!=4'b0110));
  assign nor_292_nl = ~((i_lpi_3_dfm_4_1!=4'b0110));
  assign mux_279_nl = MUX_s_1_2_2(nor_291_nl, nor_292_nl, VCOL_else_5_else_if_for_1_for_if_acc_itm_10);
  assign nor_293_nl = ~((max_i_lpi_3_dfm_2_1!=4'b0101));
  assign nor_294_nl = ~((i_lpi_3_dfm_4_1!=4'b0101));
  assign mux_280_nl = MUX_s_1_2_2(nor_293_nl, nor_294_nl, VCOL_else_5_else_if_for_1_for_if_acc_itm_10);
  assign nor_295_nl = ~((max_i_lpi_3_dfm_2_1!=4'b0100));
  assign nor_296_nl = ~((i_lpi_3_dfm_4_1!=4'b0100));
  assign mux_281_nl = MUX_s_1_2_2(nor_295_nl, nor_296_nl, VCOL_else_5_else_if_for_1_for_if_acc_itm_10);
  assign nor_297_nl = ~((max_i_lpi_3_dfm_2_1!=4'b0011));
  assign nor_298_nl = ~((i_lpi_3_dfm_4_1!=4'b0011));
  assign mux_282_nl = MUX_s_1_2_2(nor_297_nl, nor_298_nl, VCOL_else_5_else_if_for_1_for_if_acc_itm_10);
  assign nor_299_nl = ~((max_i_lpi_3_dfm_2_1!=4'b0010));
  assign nor_300_nl = ~((i_lpi_3_dfm_4_1!=4'b0010));
  assign mux_283_nl = MUX_s_1_2_2(nor_299_nl, nor_300_nl, VCOL_else_5_else_if_for_1_for_if_acc_itm_10);
  assign nor_301_nl = ~((max_i_lpi_3_dfm_2_1!=4'b0001));
  assign nor_302_nl = ~((i_lpi_3_dfm_4_1!=4'b0001));
  assign mux_284_nl = MUX_s_1_2_2(nor_301_nl, nor_302_nl, VCOL_else_5_else_if_for_1_for_if_acc_itm_10);
  assign nor_303_nl = ~(operator_4_false_1_acc_itm_2 | lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_0
      | operator_4_false_2_acc_itm_3);
  assign mux_288_nl = MUX_s_1_2_2(operator_4_false_acc_itm_3, nor_303_nl, lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_1);
  assign mux_289_nl = MUX_s_1_2_2(or_49_cse, mux_288_nl, lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3);
  assign mux_290_nl = MUX_s_1_2_2(mux_289_nl, or_49_cse, exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva);
  assign or_683_nl = operator_4_false_acc_itm_3 | mux_tmp_285;
  assign or_738_nl = nor_244_cse | mux_tmp_285;
  assign mux_286_nl = MUX_s_1_2_2(or_683_nl, or_738_nl, lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_1);
  assign or_684_nl = (VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1!=2'b10) | mux_286_nl;
  assign or_680_nl = (ctrl_signal_rsci_idat!=2'b10) | VCOL_else_4_else_aif_equal_tmp
      | operator_4_false_acc_itm_3 | mux_tmp_285;
  assign mux_287_nl = MUX_s_1_2_2(or_684_nl, or_680_nl, exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1);
  assign mux_291_nl = MUX_s_1_2_2(mux_290_nl, mux_287_nl, VCOL_stage_0_2);
  assign VCOL_and_51_nl = (~ operator_4_false_2_acc_itm_3) & VCOL_and_7_ssc_1;
  assign VCOL_and_52_nl = operator_4_false_2_acc_itm_3 & VCOL_and_7_ssc_1;
  assign or_693_nl = (VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1!=2'b10) | VCOL_else_5_else_if_for_1_for_if_acc_itm_10;
  assign mux_296_nl = MUX_s_1_2_2(operator_4_false_1_acc_itm_2, or_693_nl, operator_4_false_2_acc_itm_3);
  assign nor_305_nl = ~(lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_0 | mux_296_nl);
  assign mux_297_nl = MUX_s_1_2_2(operator_4_false_acc_itm_3, nor_305_nl, lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_1);
  assign mux_298_nl = MUX_s_1_2_2(mux_297_nl, or_49_cse, or_40_cse);
  assign mux_293_nl = MUX_s_1_2_2((~ operator_4_false_acc_itm_3), operator_4_false_1_acc_itm_2,
      lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_1);
  assign or_690_nl = (VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1[0]) | (~((VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1[1])
      & mux_293_nl));
  assign or_688_nl = lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_0 | VCOL_else_5_else_if_for_1_for_if_acc_itm_10;
  assign mux_292_nl = MUX_s_1_2_2((~ operator_4_false_acc_itm_3), or_688_nl, lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_1);
  assign or_689_nl = (VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1[0]) | (~((VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1[1])
      & mux_292_nl));
  assign mux_294_nl = MUX_s_1_2_2(or_690_nl, or_689_nl, operator_4_false_2_acc_itm_3);
  assign mux_295_nl = MUX_s_1_2_2(mux_294_nl, or_46_cse, exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1);
  assign mux_299_nl = MUX_s_1_2_2(mux_298_nl, mux_295_nl, VCOL_stage_0_2);
  assign and_229_nl = (~ mux_tmp_94) & nor_79_cse & VCOL_stage_0_1 & VCOL_else_5_else_if_for_1_for_if_acc_itm_10
      & (fsm_output[1]);
  assign nor_137_nl = ~((~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_1) | lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_0
      | operator_4_false_1_acc_itm_2 | operator_4_false_2_acc_itm_3 | VCOL_else_5_else_if_for_1_for_if_acc_itm_10);
  assign mux_129_nl = MUX_s_1_2_2(nor_137_nl, or_357_cse, or_40_cse);
  assign or_340_nl = (~(operator_4_false_1_acc_itm_2 | operator_4_false_2_acc_itm_3
      | VCOL_else_5_else_if_for_1_for_if_acc_itm_10 | (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_1)
      | lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_0)) | (VCOL_io_read_ctrl_signal_rsc_sft_lpi_3_dfm_st_1!=2'b10);
  assign mux_128_nl = MUX_s_1_2_2(or_340_nl, nor_62_cse, exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1);
  assign mux_130_nl = MUX_s_1_2_2(mux_129_nl, mux_128_nl, VCOL_stage_0_2);
  assign and_231_nl = mux_130_nl & VCOL_stage_0_1 & (fsm_output[1]);
  assign VCOL_and_53_nl = (~ VCOL_and_7_ssc_1) & (~ mux_4_cse) & VCOL_stage_0_1 &
      (fsm_output[1]);
  assign and_439_nl = or_52_cse & or_704_cse;
  assign mux_301_nl = MUX_s_1_2_2(and_439_nl, or_tmp_598, VCOL_else_5_else_if_for_1_for_if_acc_itm_10);
  assign nor_306_nl = ~(lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_0 | (~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_1)
      | mux_301_nl);
  assign mux_302_nl = MUX_s_1_2_2(or_357_cse, nor_306_nl, lfst_exitL_exit_VCOL_else_5_else_if_for_1_lpi_3);
  assign mux_303_nl = MUX_s_1_2_2(mux_302_nl, or_357_cse, exitL_exitL_exit_VCOL_else_5_else_if_for_1_sva);
  assign nor_307_nl = ~((~ lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_1) |
      lfst_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_4_1_0 | or_tmp_598);
  assign mux_300_nl = MUX_s_1_2_2(nor_307_nl, VCOL_else_4_else_aif_equal_tmp, exitL_exit_VCOL_else_5_else_if_for_1_lpi_3_dfm_1);
  assign mux_304_nl = MUX_s_1_2_2(mux_303_nl, mux_300_nl, VCOL_stage_0_2);
  assign or_250_nl = mux_tmp_94 | (~ VCOL_else_5_else_if_for_1_for_if_acc_itm_10);
  assign VROW_or_2_nl = (mux_tmp & (fsm_output[1])) | or_tmp_265;
  assign VROW_VROW_mux_1_nl = MUX_v_10_2_2(VROW_y_sva, (VCOL_x_sva_mx1[10:1]), VROW_or_2_nl);
  assign nl_z_out = VROW_VROW_mux_1_nl + conv_s2u_2_10({or_tmp_265 , 1'b1});
  assign z_out = nl_z_out[9:0];

  function automatic  MUX1HOT_s_1_3_2;
    input  input_2;
    input  input_1;
    input  input_0;
    input [2:0] sel;
    reg  result;
  begin
    result = input_0 & sel[0];
    result = result | (input_1 & sel[1]);
    result = result | (input_2 & sel[2]);
    MUX1HOT_s_1_3_2 = result;
  end
  endfunction


  function automatic [1:0] MUX1HOT_v_2_4_2;
    input [1:0] input_3;
    input [1:0] input_2;
    input [1:0] input_1;
    input [1:0] input_0;
    input [3:0] sel;
    reg [1:0] result;
  begin
    result = input_0 & {2{sel[0]}};
    result = result | (input_1 & {2{sel[1]}});
    result = result | (input_2 & {2{sel[2]}});
    result = result | (input_3 & {2{sel[3]}});
    MUX1HOT_v_2_4_2 = result;
  end
  endfunction


  function automatic [1:0] MUX1HOT_v_2_5_2;
    input [1:0] input_4;
    input [1:0] input_3;
    input [1:0] input_2;
    input [1:0] input_1;
    input [1:0] input_0;
    input [4:0] sel;
    reg [1:0] result;
  begin
    result = input_0 & {2{sel[0]}};
    result = result | (input_1 & {2{sel[1]}});
    result = result | (input_2 & {2{sel[2]}});
    result = result | (input_3 & {2{sel[3]}});
    result = result | (input_4 & {2{sel[4]}});
    MUX1HOT_v_2_5_2 = result;
  end
  endfunction


  function automatic [3:0] MUX1HOT_v_4_3_2;
    input [3:0] input_2;
    input [3:0] input_1;
    input [3:0] input_0;
    input [2:0] sel;
    reg [3:0] result;
  begin
    result = input_0 & {4{sel[0]}};
    result = result | (input_1 & {4{sel[1]}});
    result = result | (input_2 & {4{sel[2]}});
    MUX1HOT_v_4_3_2 = result;
  end
  endfunction


  function automatic [7:0] MUX1HOT_v_8_3_2;
    input [7:0] input_2;
    input [7:0] input_1;
    input [7:0] input_0;
    input [2:0] sel;
    reg [7:0] result;
  begin
    result = input_0 & {8{sel[0]}};
    result = result | (input_1 & {8{sel[1]}});
    result = result | (input_2 & {8{sel[2]}});
    MUX1HOT_v_8_3_2 = result;
  end
  endfunction


  function automatic [7:0] MUX1HOT_v_8_4_2;
    input [7:0] input_3;
    input [7:0] input_2;
    input [7:0] input_1;
    input [7:0] input_0;
    input [3:0] sel;
    reg [7:0] result;
  begin
    result = input_0 & {8{sel[0]}};
    result = result | (input_1 & {8{sel[1]}});
    result = result | (input_2 & {8{sel[2]}});
    result = result | (input_3 & {8{sel[3]}});
    MUX1HOT_v_8_4_2 = result;
  end
  endfunction


  function automatic [7:0] MUX1HOT_v_8_6_2;
    input [7:0] input_5;
    input [7:0] input_4;
    input [7:0] input_3;
    input [7:0] input_2;
    input [7:0] input_1;
    input [7:0] input_0;
    input [5:0] sel;
    reg [7:0] result;
  begin
    result = input_0 & {8{sel[0]}};
    result = result | (input_1 & {8{sel[1]}});
    result = result | (input_2 & {8{sel[2]}});
    result = result | (input_3 & {8{sel[3]}});
    result = result | (input_4 & {8{sel[4]}});
    result = result | (input_5 & {8{sel[5]}});
    MUX1HOT_v_8_6_2 = result;
  end
  endfunction


  function automatic [7:0] MUX1HOT_v_8_7_2;
    input [7:0] input_6;
    input [7:0] input_5;
    input [7:0] input_4;
    input [7:0] input_3;
    input [7:0] input_2;
    input [7:0] input_1;
    input [7:0] input_0;
    input [6:0] sel;
    reg [7:0] result;
  begin
    result = input_0 & {8{sel[0]}};
    result = result | (input_1 & {8{sel[1]}});
    result = result | (input_2 & {8{sel[2]}});
    result = result | (input_3 & {8{sel[3]}});
    result = result | (input_4 & {8{sel[4]}});
    result = result | (input_5 & {8{sel[5]}});
    result = result | (input_6 & {8{sel[6]}});
    MUX1HOT_v_8_7_2 = result;
  end
  endfunction


  function automatic  MUX_s_1_2_2;
    input  input_0;
    input  input_1;
    input  sel;
    reg  result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_s_1_2_2 = result;
  end
  endfunction


  function automatic [9:0] MUX_v_10_2_2;
    input [9:0] input_0;
    input [9:0] input_1;
    input  sel;
    reg [9:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_10_2_2 = result;
  end
  endfunction


  function automatic [10:0] MUX_v_11_2_2;
    input [10:0] input_0;
    input [10:0] input_1;
    input  sel;
    reg [10:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_11_2_2 = result;
  end
  endfunction


  function automatic [1:0] MUX_v_2_2_2;
    input [1:0] input_0;
    input [1:0] input_1;
    input  sel;
    reg [1:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_2_2_2 = result;
  end
  endfunction


  function automatic [1:0] MUX_v_2_9_2;
    input [1:0] input_0;
    input [1:0] input_1;
    input [1:0] input_2;
    input [1:0] input_3;
    input [1:0] input_4;
    input [1:0] input_5;
    input [1:0] input_6;
    input [1:0] input_7;
    input [1:0] input_8;
    input [3:0] sel;
    reg [1:0] result;
  begin
    case (sel)
      4'b0000 : begin
        result = input_0;
      end
      4'b0001 : begin
        result = input_1;
      end
      4'b0010 : begin
        result = input_2;
      end
      4'b0011 : begin
        result = input_3;
      end
      4'b0100 : begin
        result = input_4;
      end
      4'b0101 : begin
        result = input_5;
      end
      4'b0110 : begin
        result = input_6;
      end
      4'b0111 : begin
        result = input_7;
      end
      default : begin
        result = input_8;
      end
    endcase
    MUX_v_2_9_2 = result;
  end
  endfunction


  function automatic [2:0] MUX_v_3_2_2;
    input [2:0] input_0;
    input [2:0] input_1;
    input  sel;
    reg [2:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_3_2_2 = result;
  end
  endfunction


  function automatic [3:0] MUX_v_4_2_2;
    input [3:0] input_0;
    input [3:0] input_1;
    input  sel;
    reg [3:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_4_2_2 = result;
  end
  endfunction


  function automatic [7:0] MUX_v_8_2_2;
    input [7:0] input_0;
    input [7:0] input_1;
    input  sel;
    reg [7:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_8_2_2 = result;
  end
  endfunction


  function automatic [7:0] MUX_v_8_9_2;
    input [7:0] input_0;
    input [7:0] input_1;
    input [7:0] input_2;
    input [7:0] input_3;
    input [7:0] input_4;
    input [7:0] input_5;
    input [7:0] input_6;
    input [7:0] input_7;
    input [7:0] input_8;
    input [3:0] sel;
    reg [7:0] result;
  begin
    case (sel)
      4'b0000 : begin
        result = input_0;
      end
      4'b0001 : begin
        result = input_1;
      end
      4'b0010 : begin
        result = input_2;
      end
      4'b0011 : begin
        result = input_3;
      end
      4'b0100 : begin
        result = input_4;
      end
      4'b0101 : begin
        result = input_5;
      end
      4'b0110 : begin
        result = input_6;
      end
      4'b0111 : begin
        result = input_7;
      end
      default : begin
        result = input_8;
      end
    endcase
    MUX_v_8_9_2 = result;
  end
  endfunction


  function automatic [7:0] readslicef_10_8_2;
    input [9:0] vector;
    reg [9:0] tmp;
  begin
    tmp = vector >> 2;
    readslicef_10_8_2 = tmp[7:0];
  end
  endfunction


  function automatic [0:0] readslicef_11_1_10;
    input [10:0] vector;
    reg [10:0] tmp;
  begin
    tmp = vector >> 10;
    readslicef_11_1_10 = tmp[0:0];
  end
  endfunction


  function automatic [0:0] readslicef_12_1_11;
    input [11:0] vector;
    reg [11:0] tmp;
  begin
    tmp = vector >> 11;
    readslicef_12_1_11 = tmp[0:0];
  end
  endfunction


  function automatic [0:0] readslicef_3_1_2;
    input [2:0] vector;
    reg [2:0] tmp;
  begin
    tmp = vector >> 2;
    readslicef_3_1_2 = tmp[0:0];
  end
  endfunction


  function automatic [0:0] readslicef_4_1_3;
    input [3:0] vector;
    reg [3:0] tmp;
  begin
    tmp = vector >> 3;
    readslicef_4_1_3 = tmp[0:0];
  end
  endfunction


  function automatic [1:0] signext_2_1;
    input  vector;
  begin
    signext_2_1= {{1{vector}}, vector};
  end
  endfunction


  function automatic [3:0] signext_4_1;
    input  vector;
  begin
    signext_4_1= {{3{vector}}, vector};
  end
  endfunction


  function automatic [9:0] conv_s2u_2_10 ;
    input [1:0]  vector ;
  begin
    conv_s2u_2_10 = {{8{vector[1]}}, vector};
  end
  endfunction


  function automatic [10:0] conv_u2s_10_11 ;
    input [9:0]  vector ;
  begin
    conv_u2s_10_11 =  {1'b0, vector};
  end
  endfunction


  function automatic [11:0] conv_u2s_11_12 ;
    input [10:0]  vector ;
  begin
    conv_u2s_11_12 =  {1'b0, vector};
  end
  endfunction


  function automatic [9:0] conv_u2u_7_10 ;
    input [6:0]  vector ;
  begin
    conv_u2u_7_10 = {{3{1'b0}}, vector};
  end
  endfunction


  function automatic [9:0] conv_u2u_8_10 ;
    input [7:0]  vector ;
  begin
    conv_u2u_8_10 = {{2{1'b0}}, vector};
  end
  endfunction


  function automatic [10:0] conv_u2u_10_11 ;
    input [9:0]  vector ;
  begin
    conv_u2u_10_11 = {1'b0, vector};
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_Denoise_IP
// ------------------------------------------------------------------


module EdgeDetect_IP_Denoise_IP (
  clk, rst, arst_n, dat_in_rsc_dat, dat_in_rsc_vld, dat_in_rsc_rdy, widthIn, heightIn,
      dat_out_rsc_dat, dat_out_rsc_vld, dat_out_rsc_rdy, ctrl_signal_rsc_dat, ctrl_signal_triosy_lz,
      line_buf0_rsc_en, line_buf0_rsc_q, line_buf0_rsc_we, line_buf0_rsc_d, line_buf0_rsc_adr,
      line_buf1_rsc_en, line_buf1_rsc_q, line_buf1_rsc_we, line_buf1_rsc_d, line_buf1_rsc_adr
);
  input clk;
  input rst;
  input arst_n;
  input [7:0] dat_in_rsc_dat;
  input dat_in_rsc_vld;
  output dat_in_rsc_rdy;
  input [10:0] widthIn;
  input [9:0] heightIn;
  output [7:0] dat_out_rsc_dat;
  output dat_out_rsc_vld;
  input dat_out_rsc_rdy;
  input [1:0] ctrl_signal_rsc_dat;
  output ctrl_signal_triosy_lz;
  output line_buf0_rsc_en;
  input [15:0] line_buf0_rsc_q;
  output line_buf0_rsc_we;
  output [15:0] line_buf0_rsc_d;
  output [9:0] line_buf0_rsc_adr;
  output line_buf1_rsc_en;
  input [15:0] line_buf1_rsc_q;
  output line_buf1_rsc_we;
  output [15:0] line_buf1_rsc_d;
  output [9:0] line_buf1_rsc_adr;


  // Interconnect Declarations
  wire [15:0] line_buf0_rsci_d_d;
  wire line_buf0_rsci_en_d;
  wire [15:0] line_buf0_rsci_q_d;
  wire [15:0] line_buf1_rsci_d_d;
  wire line_buf1_rsci_en_d;
  wire [15:0] line_buf1_rsci_q_d;
  wire [9:0] line_buf0_rsci_adr_d_iff;
  wire line_buf0_rsci_we_d_iff;
  wire line_buf0_rsci_port_0_rw_ram_ir_internal_RMASK_B_d_iff;
  wire line_buf1_rsci_we_d_iff;


  // Interconnect Declarations for Component Instantiations 
  EdgeDetect_IP_Denoise_IP_ccs_sample_mem_ccs_ram_sync_singleport_rwport_en_6_16_10_963_963_16_5_gen
      line_buf0_rsci (
      .en(line_buf0_rsc_en),
      .q(line_buf0_rsc_q),
      .we(line_buf0_rsc_we),
      .d(line_buf0_rsc_d),
      .adr(line_buf0_rsc_adr),
      .adr_d(line_buf0_rsci_adr_d_iff),
      .d_d(line_buf0_rsci_d_d),
      .en_d(line_buf0_rsci_en_d),
      .we_d(line_buf0_rsci_we_d_iff),
      .q_d(line_buf0_rsci_q_d),
      .port_0_rw_ram_ir_internal_RMASK_B_d(line_buf0_rsci_port_0_rw_ram_ir_internal_RMASK_B_d_iff),
      .port_0_rw_ram_ir_internal_WMASK_B_d(line_buf0_rsci_we_d_iff)
    );
  EdgeDetect_IP_Denoise_IP_ccs_sample_mem_ccs_ram_sync_singleport_rwport_en_7_16_10_963_963_16_5_gen
      line_buf1_rsci (
      .en(line_buf1_rsc_en),
      .q(line_buf1_rsc_q),
      .we(line_buf1_rsc_we),
      .d(line_buf1_rsc_d),
      .adr(line_buf1_rsc_adr),
      .adr_d(line_buf0_rsci_adr_d_iff),
      .d_d(line_buf1_rsci_d_d),
      .en_d(line_buf1_rsci_en_d),
      .we_d(line_buf1_rsci_we_d_iff),
      .q_d(line_buf1_rsci_q_d),
      .port_0_rw_ram_ir_internal_RMASK_B_d(line_buf0_rsci_port_0_rw_ram_ir_internal_RMASK_B_d_iff),
      .port_0_rw_ram_ir_internal_WMASK_B_d(line_buf1_rsci_we_d_iff)
    );
  EdgeDetect_IP_Denoise_IP_run EdgeDetect_IP_Denoise_IP_run_inst (
      .clk(clk),
      .rst(rst),
      .arst_n(arst_n),
      .dat_in_rsc_dat(dat_in_rsc_dat),
      .dat_in_rsc_vld(dat_in_rsc_vld),
      .dat_in_rsc_rdy(dat_in_rsc_rdy),
      .widthIn(widthIn),
      .heightIn(heightIn),
      .dat_out_rsc_dat(dat_out_rsc_dat),
      .dat_out_rsc_vld(dat_out_rsc_vld),
      .dat_out_rsc_rdy(dat_out_rsc_rdy),
      .ctrl_signal_rsc_dat(ctrl_signal_rsc_dat),
      .ctrl_signal_triosy_lz(ctrl_signal_triosy_lz),
      .line_buf0_rsci_d_d(line_buf0_rsci_d_d),
      .line_buf0_rsci_en_d(line_buf0_rsci_en_d),
      .line_buf0_rsci_q_d(line_buf0_rsci_q_d),
      .line_buf1_rsci_d_d(line_buf1_rsci_d_d),
      .line_buf1_rsci_en_d(line_buf1_rsci_en_d),
      .line_buf1_rsci_q_d(line_buf1_rsci_q_d),
      .line_buf0_rsci_adr_d_pff(line_buf0_rsci_adr_d_iff),
      .line_buf0_rsci_we_d_pff(line_buf0_rsci_we_d_iff),
      .line_buf0_rsci_port_0_rw_ram_ir_internal_RMASK_B_d_pff(line_buf0_rsci_port_0_rw_ram_ir_internal_RMASK_B_d_iff),
      .line_buf1_rsci_we_d_pff(line_buf1_rsci_we_d_iff)
    );
endmodule




//------> ./rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    2024.1/1091966 Production Release
//  HLS Date:       Wed Feb 14 09:07:18 PST 2024
// 
//  Generated by:   m111061631@ws41
//  Generated date: Fri Jun  7 09:35:28 2024
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_Top
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_Top (
  clk, rst, arst_n, dat_in_rsc_dat, dat_in_rsc_vld, dat_in_rsc_rdy, widthIn, heightIn,
      dat_out_rsc_dat, dat_out_rsc_vld, dat_out_rsc_rdy, ctrl_denoise_rsc_dat, ctrl_denoise_triosy_lz,
      ctrl_edgedect_rsc_dat, ctrl_edgedect_triosy_lz, line_buf0_rsc_Denoise_inst_en,
      line_buf0_rsc_Denoise_inst_q, line_buf0_rsc_Denoise_inst_we, line_buf0_rsc_Denoise_inst_d,
      line_buf0_rsc_Denoise_inst_adr, line_buf1_rsc_Denoise_inst_en, line_buf1_rsc_Denoise_inst_q,
      line_buf1_rsc_Denoise_inst_we, line_buf1_rsc_Denoise_inst_d, line_buf1_rsc_Denoise_inst_adr,
      line_buf0_rsc_EdgeDetect_Filter_inst_en, line_buf0_rsc_EdgeDetect_Filter_inst_q,
      line_buf0_rsc_EdgeDetect_Filter_inst_we, line_buf0_rsc_EdgeDetect_Filter_inst_d,
      line_buf0_rsc_EdgeDetect_Filter_inst_adr, line_buf1_rsc_EdgeDetect_Filter_inst_en,
      line_buf1_rsc_EdgeDetect_Filter_inst_q, line_buf1_rsc_EdgeDetect_Filter_inst_we,
      line_buf1_rsc_EdgeDetect_Filter_inst_d, line_buf1_rsc_EdgeDetect_Filter_inst_adr
);
  input clk;
  input rst;
  input arst_n;
  input [7:0] dat_in_rsc_dat;
  input dat_in_rsc_vld;
  output dat_in_rsc_rdy;
  input [10:0] widthIn;
  input [9:0] heightIn;
  output [7:0] dat_out_rsc_dat;
  output dat_out_rsc_vld;
  input dat_out_rsc_rdy;
  input [1:0] ctrl_denoise_rsc_dat;
  output ctrl_denoise_triosy_lz;
  input [1:0] ctrl_edgedect_rsc_dat;
  output ctrl_edgedect_triosy_lz;
  output line_buf0_rsc_Denoise_inst_en;
  input [15:0] line_buf0_rsc_Denoise_inst_q;
  output line_buf0_rsc_Denoise_inst_we;
  output [15:0] line_buf0_rsc_Denoise_inst_d;
  output [9:0] line_buf0_rsc_Denoise_inst_adr;
  output line_buf1_rsc_Denoise_inst_en;
  input [15:0] line_buf1_rsc_Denoise_inst_q;
  output line_buf1_rsc_Denoise_inst_we;
  output [15:0] line_buf1_rsc_Denoise_inst_d;
  output [9:0] line_buf1_rsc_Denoise_inst_adr;
  output line_buf0_rsc_EdgeDetect_Filter_inst_en;
  input [15:0] line_buf0_rsc_EdgeDetect_Filter_inst_q;
  output line_buf0_rsc_EdgeDetect_Filter_inst_we;
  output [15:0] line_buf0_rsc_EdgeDetect_Filter_inst_d;
  output [9:0] line_buf0_rsc_EdgeDetect_Filter_inst_adr;
  output line_buf1_rsc_EdgeDetect_Filter_inst_en;
  input [15:0] line_buf1_rsc_EdgeDetect_Filter_inst_q;
  output line_buf1_rsc_EdgeDetect_Filter_inst_we;
  output [15:0] line_buf1_rsc_EdgeDetect_Filter_inst_d;
  output [9:0] line_buf1_rsc_EdgeDetect_Filter_inst_adr;


  // Interconnect Declarations
  wire [7:0] dat_out_rsc_dat_n_Denoise_inst;
  wire line_buf0_rsc_en_n_Denoise_inst;
  wire [15:0] line_buf0_rsc_d_n_Denoise_inst;
  wire [9:0] line_buf0_rsc_adr_n_Denoise_inst;
  wire line_buf1_rsc_en_n_Denoise_inst;
  wire [15:0] line_buf1_rsc_d_n_Denoise_inst;
  wire [9:0] line_buf1_rsc_adr_n_Denoise_inst;
  wire [7:0] dat_out_rsc_dat_n_EdgeDetect_Filter_inst;
  wire line_buf0_rsc_en_n_EdgeDetect_Filter_inst;
  wire [15:0] line_buf0_rsc_d_n_EdgeDetect_Filter_inst;
  wire [9:0] line_buf0_rsc_adr_n_EdgeDetect_Filter_inst;
  wire line_buf1_rsc_en_n_EdgeDetect_Filter_inst;
  wire [15:0] line_buf1_rsc_d_n_EdgeDetect_Filter_inst;
  wire [9:0] line_buf1_rsc_adr_n_EdgeDetect_Filter_inst;
  wire dat_in_rsc_rdy_n_Denoise_inst_bud;
  wire dat_out_rsc_vld_n_Denoise_inst_bud;
  wire dat_in_rsc_rdy_n_EdgeDetect_Filter_inst_bud;
  wire ctrl_signal_triosy_lz_n_Denoise_inst_bud;
  wire line_buf0_rsc_we_n_Denoise_inst_bud;
  wire line_buf1_rsc_we_n_Denoise_inst_bud;
  wire dat_out_rsc_vld_n_EdgeDetect_Filter_inst_bud;
  wire ctrl_signal_triosy_lz_n_EdgeDetect_Filter_inst_bud;
  wire line_buf0_rsc_we_n_EdgeDetect_Filter_inst_bud;
  wire line_buf1_rsc_we_n_EdgeDetect_Filter_inst_bud;


  // Interconnect Declarations for Component Instantiations 
  EdgeDetect_IP_Denoise_IP Denoise_inst (
      .clk(clk),
      .rst(rst),
      .arst_n(arst_n),
      .dat_in_rsc_dat(dat_in_rsc_dat),
      .dat_in_rsc_vld(dat_in_rsc_vld),
      .dat_in_rsc_rdy(dat_in_rsc_rdy_n_Denoise_inst_bud),
      .widthIn(widthIn),
      .heightIn(heightIn),
      .dat_out_rsc_dat(dat_out_rsc_dat_n_Denoise_inst),
      .dat_out_rsc_vld(dat_out_rsc_vld_n_Denoise_inst_bud),
      .dat_out_rsc_rdy(dat_in_rsc_rdy_n_EdgeDetect_Filter_inst_bud),
      .ctrl_signal_rsc_dat(ctrl_denoise_rsc_dat),
      .ctrl_signal_triosy_lz(ctrl_signal_triosy_lz_n_Denoise_inst_bud),
      .line_buf0_rsc_en(line_buf0_rsc_en_n_Denoise_inst),
      .line_buf0_rsc_q(line_buf0_rsc_Denoise_inst_q),
      .line_buf0_rsc_we(line_buf0_rsc_we_n_Denoise_inst_bud),
      .line_buf0_rsc_d(line_buf0_rsc_d_n_Denoise_inst),
      .line_buf0_rsc_adr(line_buf0_rsc_adr_n_Denoise_inst),
      .line_buf1_rsc_en(line_buf1_rsc_en_n_Denoise_inst),
      .line_buf1_rsc_q(line_buf1_rsc_Denoise_inst_q),
      .line_buf1_rsc_we(line_buf1_rsc_we_n_Denoise_inst_bud),
      .line_buf1_rsc_d(line_buf1_rsc_d_n_Denoise_inst),
      .line_buf1_rsc_adr(line_buf1_rsc_adr_n_Denoise_inst)
    );
  EdgeDetect_IP_EdgeDetect_Filter EdgeDetect_Filter_inst (
      .clk(clk),
      .rst(rst),
      .arst_n(arst_n),
      .dat_in_rsc_dat(dat_out_rsc_dat_n_Denoise_inst),
      .dat_in_rsc_vld(dat_out_rsc_vld_n_Denoise_inst_bud),
      .dat_in_rsc_rdy(dat_in_rsc_rdy_n_EdgeDetect_Filter_inst_bud),
      .widthIn(widthIn),
      .heightIn(heightIn),
      .dat_out_rsc_dat(dat_out_rsc_dat_n_EdgeDetect_Filter_inst),
      .dat_out_rsc_vld(dat_out_rsc_vld_n_EdgeDetect_Filter_inst_bud),
      .dat_out_rsc_rdy(dat_out_rsc_rdy),
      .ctrl_signal_rsc_dat(ctrl_edgedect_rsc_dat),
      .ctrl_signal_triosy_lz(ctrl_signal_triosy_lz_n_EdgeDetect_Filter_inst_bud),
      .line_buf0_rsc_en(line_buf0_rsc_en_n_EdgeDetect_Filter_inst),
      .line_buf0_rsc_q(line_buf0_rsc_EdgeDetect_Filter_inst_q),
      .line_buf0_rsc_we(line_buf0_rsc_we_n_EdgeDetect_Filter_inst_bud),
      .line_buf0_rsc_d(line_buf0_rsc_d_n_EdgeDetect_Filter_inst),
      .line_buf0_rsc_adr(line_buf0_rsc_adr_n_EdgeDetect_Filter_inst),
      .line_buf1_rsc_en(line_buf1_rsc_en_n_EdgeDetect_Filter_inst),
      .line_buf1_rsc_q(line_buf1_rsc_EdgeDetect_Filter_inst_q),
      .line_buf1_rsc_we(line_buf1_rsc_we_n_EdgeDetect_Filter_inst_bud),
      .line_buf1_rsc_d(line_buf1_rsc_d_n_EdgeDetect_Filter_inst),
      .line_buf1_rsc_adr(line_buf1_rsc_adr_n_EdgeDetect_Filter_inst)
    );
  assign dat_in_rsc_rdy = dat_in_rsc_rdy_n_Denoise_inst_bud;
  assign ctrl_denoise_triosy_lz = ctrl_signal_triosy_lz_n_Denoise_inst_bud;
  assign line_buf0_rsc_Denoise_inst_en = line_buf0_rsc_en_n_Denoise_inst;
  assign line_buf0_rsc_Denoise_inst_we = line_buf0_rsc_we_n_Denoise_inst_bud;
  assign line_buf0_rsc_Denoise_inst_d = line_buf0_rsc_d_n_Denoise_inst;
  assign line_buf0_rsc_Denoise_inst_adr = line_buf0_rsc_adr_n_Denoise_inst;
  assign line_buf1_rsc_Denoise_inst_en = line_buf1_rsc_en_n_Denoise_inst;
  assign line_buf1_rsc_Denoise_inst_we = line_buf1_rsc_we_n_Denoise_inst_bud;
  assign line_buf1_rsc_Denoise_inst_d = line_buf1_rsc_d_n_Denoise_inst;
  assign line_buf1_rsc_Denoise_inst_adr = line_buf1_rsc_adr_n_Denoise_inst;
  assign dat_out_rsc_vld = dat_out_rsc_vld_n_EdgeDetect_Filter_inst_bud;
  assign dat_out_rsc_dat = dat_out_rsc_dat_n_EdgeDetect_Filter_inst;
  assign ctrl_edgedect_triosy_lz = ctrl_signal_triosy_lz_n_EdgeDetect_Filter_inst_bud;
  assign line_buf0_rsc_EdgeDetect_Filter_inst_en = line_buf0_rsc_en_n_EdgeDetect_Filter_inst;
  assign line_buf0_rsc_EdgeDetect_Filter_inst_we = line_buf0_rsc_we_n_EdgeDetect_Filter_inst_bud;
  assign line_buf0_rsc_EdgeDetect_Filter_inst_d = line_buf0_rsc_d_n_EdgeDetect_Filter_inst;
  assign line_buf0_rsc_EdgeDetect_Filter_inst_adr = line_buf0_rsc_adr_n_EdgeDetect_Filter_inst;
  assign line_buf1_rsc_EdgeDetect_Filter_inst_en = line_buf1_rsc_en_n_EdgeDetect_Filter_inst;
  assign line_buf1_rsc_EdgeDetect_Filter_inst_we = line_buf1_rsc_we_n_EdgeDetect_Filter_inst_bud;
  assign line_buf1_rsc_EdgeDetect_Filter_inst_d = line_buf1_rsc_d_n_EdgeDetect_Filter_inst;
  assign line_buf1_rsc_EdgeDetect_Filter_inst_adr = line_buf1_rsc_adr_n_EdgeDetect_Filter_inst;
endmodule



