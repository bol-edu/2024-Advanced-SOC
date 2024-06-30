
//------> /usr/cadtool/mentor/Catapult/2023.1/Mgc_home/pkgs/siflibs/ccs_in_wait_v1.v 
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


module ccs_in_wait_v1 (idat, rdy, ivld, dat, irdy, vld);

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

  localparam stallOff = 0; 
  wire                  stall_ctrl;
  assign stall_ctrl = stallOff;

  assign idat = dat;
  assign rdy = irdy && !stall_ctrl;
  assign ivld = vld && !stall_ctrl;

endmodule


//------> /usr/cadtool/mentor/Catapult/2023.1/Mgc_home/pkgs/siflibs/ccs_out_wait_v1.v 
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



//------> /usr/cadtool/mentor/Catapult/2023.1/Mgc_home/pkgs/siflibs/mgc_io_sync_v2.v 
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


//------> /usr/cadtool/mentor/Catapult/2023.1/Mgc_home/pkgs/siflibs/ccs_in_v1.v 
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


//------> /usr/cadtool/mentor/Catapult/2023.1/Mgc_home/pkgs/siflibs/mgc_shift_bl_beh_v5.v 
module mgc_shift_bl_v5(a,s,z);
   parameter    width_a = 4;
   parameter    signd_a = 1;
   parameter    width_s = 2;
   parameter    width_z = 8;

   input [width_a-1:0] a;
   input [width_s-1:0] s;
   output [width_z -1:0] z;

   generate if ( signd_a )
   begin: SGNED
     assign z = fshl_s(a,s,a[width_a-1]);
   end
   else
   begin: UNSGNED
     assign z = fshl_s(a,s,1'b0);
   end
   endgenerate

   //Shift-left - unsigned shift argument one bit more
   function [width_z-1:0] fshl_u_1;
      input [width_a  :0] arg1;
      input [width_s-1:0] arg2;
      input sbit;
      parameter olen = width_z;
      parameter ilen = width_a+1;
      parameter len = (ilen >= olen) ? ilen : olen;
      reg [len-1:0] result;
      reg [len-1:0] result_t;
      begin
        result_t = {(len){sbit}};
        result_t[ilen-1:0] = arg1;
        result = result_t <<< arg2;
        fshl_u_1 =  result[olen-1:0];
      end
   endfunction // fshl_u

   //Shift-left - unsigned shift argument
   function [width_z-1:0] fshl_u;
      input [width_a-1:0] arg1;
      input [width_s-1:0] arg2;
      input sbit;
      fshl_u = fshl_u_1({sbit,arg1} ,arg2, sbit);
   endfunction // fshl_u

   //Shift right - unsigned shift argument
   function [width_z-1:0] fshr_u;
      input [width_a-1:0] arg1;
      input [width_s-1:0] arg2;
      input sbit;
      parameter olen = width_z;
      parameter ilen = signd_a ? width_a : width_a+1;
      parameter len = (ilen >= olen) ? ilen : olen;
      reg signed [len-1:0] result;
      reg signed [len-1:0] result_t;
      begin
        result_t = $signed( {(len){sbit}} );
        result_t[width_a-1:0] = arg1;
        result = result_t >>> arg2;
        fshr_u =  result[olen-1:0];
      end
   endfunction // fshl_u

   //Shift left - signed shift argument
   function [width_z-1:0] fshl_s;
      input [width_a-1:0] arg1;
      input [width_s-1:0] arg2;
      input sbit;
      reg [width_a:0] sbit_arg1;
      begin
        // Ignoring the possibility that arg2[width_s-1] could be X
        // because of customer complaints regarding X'es in simulation results
        if ( arg2[width_s-1] == 1'b0 )
        begin
          sbit_arg1[width_a:0] = {(width_a+1){1'b0}};
          fshl_s = fshl_u(arg1, arg2, sbit);
        end
        else
        begin
          sbit_arg1[width_a] = sbit;
          sbit_arg1[width_a-1:0] = arg1;
          fshl_s = fshr_u(sbit_arg1[width_a:1], ~arg2, sbit);
        end
      end
   endfunction

endmodule

//------> /usr/cadtool/mentor/Catapult/2023.1/Mgc_home/pkgs/siflibs/mgc_shift_l_beh_v5.v 
module mgc_shift_l_v5(a,s,z);
   parameter    width_a = 4;
   parameter    signd_a = 1;
   parameter    width_s = 2;
   parameter    width_z = 8;

   input [width_a-1:0] a;
   input [width_s-1:0] s;
   output [width_z -1:0] z;

   generate
   if (signd_a)
   begin: SGNED
      assign z = fshl_u(a,s,a[width_a-1]);
   end
   else
   begin: UNSGNED
      assign z = fshl_u(a,s,1'b0);
   end
   endgenerate

   //Shift-left - unsigned shift argument one bit more
   function [width_z-1:0] fshl_u_1;
      input [width_a  :0] arg1;
      input [width_s-1:0] arg2;
      input sbit;
      parameter olen = width_z;
      parameter ilen = width_a+1;
      parameter len = (ilen >= olen) ? ilen : olen;
      reg [len-1:0] result;
      reg [len-1:0] result_t;
      begin
        result_t = {(len){sbit}};
        result_t[ilen-1:0] = arg1;
        result = result_t <<< arg2;
        fshl_u_1 =  result[olen-1:0];
      end
   endfunction // fshl_u

   //Shift-left - unsigned shift argument
   function [width_z-1:0] fshl_u;
      input [width_a-1:0] arg1;
      input [width_s-1:0] arg2;
      input sbit;
      fshl_u = fshl_u_1({sbit,arg1} ,arg2, sbit);
   endfunction // fshl_u

endmodule

//------> ../td_ccore_solutions/leading_sign_19_0_db8a43ecf0ceb544432782a6d06851306744_0/rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    2023.1/1033555 Production Release
//  HLS Date:       Mon Feb 13 11:32:25 PST 2023
// 
//  Generated by:   m111061545@ws41
//  Generated date: Sun Feb  4 23:03:18 2024
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    leading_sign_19_0
// ------------------------------------------------------------------


module leading_sign_19_0 (
  mantissa, rtn
);
  input [18:0] mantissa;
  output [4:0] rtn;


  // Interconnect Declarations
  wire ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_wrs_c_6_2_sdt_2;
  wire ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_wrs_c_18_3_sdt_3;
  wire ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_wrs_c_26_2_sdt_2;
  wire ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_wrs_c_42_4_sdt_4;
  wire ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_wrs_c_48_2_sdt_1;
  wire ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_wrs_c_6_2_sdt_1;
  wire ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_wrs_c_14_2_sdt_1;
  wire ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_wrs_c_26_2_sdt_1;
  wire ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_wrs_c_34_2_sdt_1;
  wire c_h_1_2;
  wire c_h_1_5;
  wire c_h_1_6;
  wire c_h_1_8;

  wire ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_and_nl;
  wire ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_and_1_nl;
  wire ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_and_76_nl;
  wire ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_or_1_nl;

  // Interconnect Declarations for Component Instantiations 
  assign ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_wrs_c_6_2_sdt_2
      = ~((mantissa[16:15]!=2'b00));
  assign ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_wrs_c_6_2_sdt_1
      = ~((mantissa[18:17]!=2'b00));
  assign ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_wrs_c_14_2_sdt_1
      = ~((mantissa[14:13]!=2'b00));
  assign c_h_1_2 = ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_wrs_c_6_2_sdt_1
      & ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_wrs_c_6_2_sdt_2;
  assign ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_wrs_c_18_3_sdt_3
      = (mantissa[12:11]==2'b00) & ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_wrs_c_14_2_sdt_1;
  assign ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_wrs_c_26_2_sdt_2
      = ~((mantissa[8:7]!=2'b00));
  assign ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_wrs_c_26_2_sdt_1
      = ~((mantissa[10:9]!=2'b00));
  assign ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_wrs_c_34_2_sdt_1
      = ~((mantissa[6:5]!=2'b00));
  assign c_h_1_5 = ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_wrs_c_26_2_sdt_1
      & ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_wrs_c_26_2_sdt_2;
  assign c_h_1_6 = c_h_1_2 & ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_wrs_c_18_3_sdt_3;
  assign ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_wrs_c_42_4_sdt_4
      = (mantissa[4:3]==2'b00) & ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_wrs_c_34_2_sdt_1
      & c_h_1_5;
  assign ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_wrs_c_48_2_sdt_1
      = ~((mantissa[2:1]!=2'b00));
  assign c_h_1_8 = c_h_1_6 & ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_wrs_c_42_4_sdt_4;
  assign ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_and_nl
      = c_h_1_6 & (~ ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_wrs_c_42_4_sdt_4);
  assign ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_and_1_nl
      = c_h_1_2 & (c_h_1_5 | (~ ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_wrs_c_18_3_sdt_3))
      & (~ c_h_1_8);
  assign ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_and_76_nl
      = ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_wrs_c_6_2_sdt_1
      & (ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_wrs_c_14_2_sdt_1
      | (~ ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_wrs_c_6_2_sdt_2))
      & (~((~(ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_wrs_c_26_2_sdt_1
      & (ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_wrs_c_34_2_sdt_1
      | (~ ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_wrs_c_26_2_sdt_2))))
      & c_h_1_6)) & (ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_wrs_c_48_2_sdt_1
      | (~ c_h_1_8));
  assign ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_or_1_nl
      = ((~((mantissa[18]) | (~((mantissa[17:16]!=2'b01))))) & (~(((mantissa[14])
      | (~((mantissa[13:12]!=2'b01)))) & c_h_1_2)) & (~((~((~((mantissa[10]) | (~((mantissa[9:8]!=2'b01)))))
      & (~(((mantissa[6]) | (~((mantissa[5:4]!=2'b01)))) & c_h_1_5)))) & c_h_1_6))
      & (~((~((mantissa[2:1]==2'b01))) & c_h_1_8))) | ((~ (mantissa[0])) & ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_wrs_c_48_2_sdt_1
      & c_h_1_8);
  assign rtn = {c_h_1_8 , ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_and_nl
      , ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_and_1_nl
      , ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_and_76_nl
      , ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_leading_sign_19_0_rtn_or_1_nl};
endmodule




//------> ../EdgeDetect_IP_EdgeDetect_MagAng.v1/rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    2023.1/1033555 Production Release
//  HLS Date:       Mon Feb 13 11:32:25 PST 2023
// 
//  Generated by:   m111061545@ws41
//  Generated date: Mon Feb 26 23:43:37 2024
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_MagAng_run_run_fsm
//  FSM Module
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_MagAng_run_run_fsm (
  clk, rst, arst_n, run_wen, fsm_output, MCOL_C_0_tr0, MROW_C_0_tr0
);
  input clk;
  input rst;
  input arst_n;
  input run_wen;
  output [3:0] fsm_output;
  reg [3:0] fsm_output;
  input MCOL_C_0_tr0;
  input MROW_C_0_tr0;


  // FSM State Type Declaration for EdgeDetect_IP_EdgeDetect_MagAng_run_run_fsm_1
  parameter
    main_C_0 = 2'd0,
    MCOL_C_0 = 2'd1,
    MROW_C_0 = 2'd2,
    main_C_1 = 2'd3;

  reg [1:0] state_var;
  reg [1:0] state_var_NS;


  // Interconnect Declarations for Component Instantiations 
  always @(*)
  begin : EdgeDetect_IP_EdgeDetect_MagAng_run_run_fsm_1
    case (state_var)
      MCOL_C_0 : begin
        fsm_output = 4'b0010;
        if ( MCOL_C_0_tr0 ) begin
          state_var_NS = MROW_C_0;
        end
        else begin
          state_var_NS = MCOL_C_0;
        end
      end
      MROW_C_0 : begin
        fsm_output = 4'b0100;
        if ( MROW_C_0_tr0 ) begin
          state_var_NS = main_C_1;
        end
        else begin
          state_var_NS = MCOL_C_0;
        end
      end
      main_C_1 : begin
        fsm_output = 4'b1000;
        state_var_NS = main_C_0;
      end
      // main_C_0
      default : begin
        fsm_output = 4'b0001;
        state_var_NS = MCOL_C_0;
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
//  Design Unit:    EdgeDetect_IP_EdgeDetect_MagAng_run_staller
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_MagAng_run_staller (
  clk, rst, arst_n, run_wen, run_wten, dx_in_rsci_wen_comp, dy_in_rsci_wen_comp,
      magn_rsci_wen_comp, angle_rsci_wen_comp
);
  input clk;
  input rst;
  input arst_n;
  output run_wen;
  output run_wten;
  reg run_wten;
  input dx_in_rsci_wen_comp;
  input dy_in_rsci_wen_comp;
  input magn_rsci_wen_comp;
  input angle_rsci_wen_comp;



  // Interconnect Declarations for Component Instantiations 
  assign run_wen = dx_in_rsci_wen_comp & dy_in_rsci_wen_comp & magn_rsci_wen_comp
      & angle_rsci_wen_comp;
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
//  Design Unit:    EdgeDetect_IP_EdgeDetect_MagAng_run_heightIn_triosy_obj_heightIn_triosy_wait_ctrl
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_MagAng_run_heightIn_triosy_obj_heightIn_triosy_wait_ctrl
    (
  run_wten, heightIn_triosy_obj_iswt0, heightIn_triosy_obj_biwt
);
  input run_wten;
  input heightIn_triosy_obj_iswt0;
  output heightIn_triosy_obj_biwt;



  // Interconnect Declarations for Component Instantiations 
  assign heightIn_triosy_obj_biwt = (~ run_wten) & heightIn_triosy_obj_iswt0;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_MagAng_run_widthIn_triosy_obj_widthIn_triosy_wait_ctrl
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_MagAng_run_widthIn_triosy_obj_widthIn_triosy_wait_ctrl
    (
  run_wten, widthIn_triosy_obj_iswt0, widthIn_triosy_obj_biwt
);
  input run_wten;
  input widthIn_triosy_obj_iswt0;
  output widthIn_triosy_obj_biwt;



  // Interconnect Declarations for Component Instantiations 
  assign widthIn_triosy_obj_biwt = (~ run_wten) & widthIn_triosy_obj_iswt0;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_MagAng_run_angle_rsci_angle_wait_dp
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_MagAng_run_angle_rsci_angle_wait_dp (
  clk, rst, arst_n, angle_rsci_oswt, angle_rsci_wen_comp, angle_rsci_biwt, angle_rsci_bdwt,
      angle_rsci_bcwt
);
  input clk;
  input rst;
  input arst_n;
  input angle_rsci_oswt;
  output angle_rsci_wen_comp;
  input angle_rsci_biwt;
  input angle_rsci_bdwt;
  output angle_rsci_bcwt;
  reg angle_rsci_bcwt;



  // Interconnect Declarations for Component Instantiations 
  assign angle_rsci_wen_comp = (~ angle_rsci_oswt) | angle_rsci_biwt | angle_rsci_bcwt;
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      angle_rsci_bcwt <= 1'b0;
    end
    else if ( rst ) begin
      angle_rsci_bcwt <= 1'b0;
    end
    else begin
      angle_rsci_bcwt <= ~((~(angle_rsci_bcwt | angle_rsci_biwt)) | angle_rsci_bdwt);
    end
  end
endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_MagAng_run_angle_rsci_angle_wait_ctrl
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_MagAng_run_angle_rsci_angle_wait_ctrl (
  run_wen, angle_rsci_oswt, angle_rsci_biwt, angle_rsci_bdwt, angle_rsci_bcwt, angle_rsci_irdy,
      angle_rsci_ivld_run_sct
);
  input run_wen;
  input angle_rsci_oswt;
  output angle_rsci_biwt;
  output angle_rsci_bdwt;
  input angle_rsci_bcwt;
  input angle_rsci_irdy;
  output angle_rsci_ivld_run_sct;


  // Interconnect Declarations
  wire angle_rsci_ogwt;


  // Interconnect Declarations for Component Instantiations 
  assign angle_rsci_bdwt = angle_rsci_oswt & run_wen;
  assign angle_rsci_biwt = angle_rsci_ogwt & angle_rsci_irdy;
  assign angle_rsci_ogwt = angle_rsci_oswt & (~ angle_rsci_bcwt);
  assign angle_rsci_ivld_run_sct = angle_rsci_ogwt;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_MagAng_run_magn_rsci_magn_wait_dp
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_MagAng_run_magn_rsci_magn_wait_dp (
  clk, rst, arst_n, magn_rsci_oswt, magn_rsci_wen_comp, magn_rsci_biwt, magn_rsci_bdwt,
      magn_rsci_bcwt
);
  input clk;
  input rst;
  input arst_n;
  input magn_rsci_oswt;
  output magn_rsci_wen_comp;
  input magn_rsci_biwt;
  input magn_rsci_bdwt;
  output magn_rsci_bcwt;
  reg magn_rsci_bcwt;



  // Interconnect Declarations for Component Instantiations 
  assign magn_rsci_wen_comp = (~ magn_rsci_oswt) | magn_rsci_biwt | magn_rsci_bcwt;
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      magn_rsci_bcwt <= 1'b0;
    end
    else if ( rst ) begin
      magn_rsci_bcwt <= 1'b0;
    end
    else begin
      magn_rsci_bcwt <= ~((~(magn_rsci_bcwt | magn_rsci_biwt)) | magn_rsci_bdwt);
    end
  end
endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_MagAng_run_magn_rsci_magn_wait_ctrl
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_MagAng_run_magn_rsci_magn_wait_ctrl (
  run_wen, magn_rsci_oswt, magn_rsci_biwt, magn_rsci_bdwt, magn_rsci_bcwt, magn_rsci_irdy,
      magn_rsci_ivld_run_sct
);
  input run_wen;
  input magn_rsci_oswt;
  output magn_rsci_biwt;
  output magn_rsci_bdwt;
  input magn_rsci_bcwt;
  input magn_rsci_irdy;
  output magn_rsci_ivld_run_sct;


  // Interconnect Declarations
  wire magn_rsci_ogwt;


  // Interconnect Declarations for Component Instantiations 
  assign magn_rsci_bdwt = magn_rsci_oswt & run_wen;
  assign magn_rsci_biwt = magn_rsci_ogwt & magn_rsci_irdy;
  assign magn_rsci_ogwt = magn_rsci_oswt & (~ magn_rsci_bcwt);
  assign magn_rsci_ivld_run_sct = magn_rsci_ogwt;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp (
  clk, rst, arst_n, dy_in_rsci_oswt, dy_in_rsci_wen_comp, dy_in_rsci_idat_mxwt, dy_in_rsci_biwt,
      dy_in_rsci_bdwt, dy_in_rsci_bcwt, dy_in_rsci_idat
);
  input clk;
  input rst;
  input arst_n;
  input dy_in_rsci_oswt;
  output dy_in_rsci_wen_comp;
  output [8:0] dy_in_rsci_idat_mxwt;
  input dy_in_rsci_biwt;
  input dy_in_rsci_bdwt;
  output dy_in_rsci_bcwt;
  reg dy_in_rsci_bcwt;
  input [8:0] dy_in_rsci_idat;


  // Interconnect Declarations
  reg [8:0] dy_in_rsci_idat_bfwt;


  // Interconnect Declarations for Component Instantiations 
  assign dy_in_rsci_wen_comp = (~ dy_in_rsci_oswt) | dy_in_rsci_biwt | dy_in_rsci_bcwt;
  assign dy_in_rsci_idat_mxwt = MUX_v_9_2_2(dy_in_rsci_idat, dy_in_rsci_idat_bfwt,
      dy_in_rsci_bcwt);
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      dy_in_rsci_bcwt <= 1'b0;
    end
    else if ( rst ) begin
      dy_in_rsci_bcwt <= 1'b0;
    end
    else begin
      dy_in_rsci_bcwt <= ~((~(dy_in_rsci_bcwt | dy_in_rsci_biwt)) | dy_in_rsci_bdwt);
    end
  end
  always @(posedge clk) begin
    if ( dy_in_rsci_biwt ) begin
      dy_in_rsci_idat_bfwt <= dy_in_rsci_idat;
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_ctrl
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_ctrl (
  run_wen, dy_in_rsci_oswt, dy_in_rsci_biwt, dy_in_rsci_bdwt, dy_in_rsci_bcwt, dy_in_rsci_irdy_run_sct,
      dy_in_rsci_ivld
);
  input run_wen;
  input dy_in_rsci_oswt;
  output dy_in_rsci_biwt;
  output dy_in_rsci_bdwt;
  input dy_in_rsci_bcwt;
  output dy_in_rsci_irdy_run_sct;
  input dy_in_rsci_ivld;


  // Interconnect Declarations
  wire dy_in_rsci_ogwt;


  // Interconnect Declarations for Component Instantiations 
  assign dy_in_rsci_bdwt = dy_in_rsci_oswt & run_wen;
  assign dy_in_rsci_biwt = dy_in_rsci_ogwt & dy_in_rsci_ivld;
  assign dy_in_rsci_ogwt = dy_in_rsci_oswt & (~ dy_in_rsci_bcwt);
  assign dy_in_rsci_irdy_run_sct = dy_in_rsci_ogwt;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp (
  clk, rst, arst_n, dx_in_rsci_oswt, dx_in_rsci_wen_comp, dx_in_rsci_idat_mxwt, dx_in_rsci_biwt,
      dx_in_rsci_bdwt, dx_in_rsci_bcwt, dx_in_rsci_idat
);
  input clk;
  input rst;
  input arst_n;
  input dx_in_rsci_oswt;
  output dx_in_rsci_wen_comp;
  output [8:0] dx_in_rsci_idat_mxwt;
  input dx_in_rsci_biwt;
  input dx_in_rsci_bdwt;
  output dx_in_rsci_bcwt;
  reg dx_in_rsci_bcwt;
  input [8:0] dx_in_rsci_idat;


  // Interconnect Declarations
  reg [8:0] dx_in_rsci_idat_bfwt;


  // Interconnect Declarations for Component Instantiations 
  assign dx_in_rsci_wen_comp = (~ dx_in_rsci_oswt) | dx_in_rsci_biwt | dx_in_rsci_bcwt;
  assign dx_in_rsci_idat_mxwt = MUX_v_9_2_2(dx_in_rsci_idat, dx_in_rsci_idat_bfwt,
      dx_in_rsci_bcwt);
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      dx_in_rsci_bcwt <= 1'b0;
    end
    else if ( rst ) begin
      dx_in_rsci_bcwt <= 1'b0;
    end
    else begin
      dx_in_rsci_bcwt <= ~((~(dx_in_rsci_bcwt | dx_in_rsci_biwt)) | dx_in_rsci_bdwt);
    end
  end
  always @(posedge clk) begin
    if ( dx_in_rsci_biwt ) begin
      dx_in_rsci_idat_bfwt <= dx_in_rsci_idat;
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_ctrl
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_ctrl (
  run_wen, dx_in_rsci_oswt, dx_in_rsci_biwt, dx_in_rsci_bdwt, dx_in_rsci_bcwt, dx_in_rsci_irdy_run_sct,
      dx_in_rsci_ivld
);
  input run_wen;
  input dx_in_rsci_oswt;
  output dx_in_rsci_biwt;
  output dx_in_rsci_bdwt;
  input dx_in_rsci_bcwt;
  output dx_in_rsci_irdy_run_sct;
  input dx_in_rsci_ivld;


  // Interconnect Declarations
  wire dx_in_rsci_ogwt;


  // Interconnect Declarations for Component Instantiations 
  assign dx_in_rsci_bdwt = dx_in_rsci_oswt & run_wen;
  assign dx_in_rsci_biwt = dx_in_rsci_ogwt & dx_in_rsci_ivld;
  assign dx_in_rsci_ogwt = dx_in_rsci_oswt & (~ dx_in_rsci_bcwt);
  assign dx_in_rsci_irdy_run_sct = dx_in_rsci_ogwt;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_MagAng_run_heightIn_triosy_obj
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_MagAng_run_heightIn_triosy_obj (
  heightIn_triosy_lz, run_wten, heightIn_triosy_obj_iswt0
);
  output heightIn_triosy_lz;
  input run_wten;
  input heightIn_triosy_obj_iswt0;


  // Interconnect Declarations
  wire heightIn_triosy_obj_biwt;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) heightIn_triosy_obj (
      .ld(heightIn_triosy_obj_biwt),
      .lz(heightIn_triosy_lz)
    );
  EdgeDetect_IP_EdgeDetect_MagAng_run_heightIn_triosy_obj_heightIn_triosy_wait_ctrl
      EdgeDetect_IP_EdgeDetect_MagAng_run_heightIn_triosy_obj_heightIn_triosy_wait_ctrl_inst
      (
      .run_wten(run_wten),
      .heightIn_triosy_obj_iswt0(heightIn_triosy_obj_iswt0),
      .heightIn_triosy_obj_biwt(heightIn_triosy_obj_biwt)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_MagAng_run_widthIn_triosy_obj
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_MagAng_run_widthIn_triosy_obj (
  widthIn_triosy_lz, run_wten, widthIn_triosy_obj_iswt0
);
  output widthIn_triosy_lz;
  input run_wten;
  input widthIn_triosy_obj_iswt0;


  // Interconnect Declarations
  wire widthIn_triosy_obj_biwt;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) widthIn_triosy_obj (
      .ld(widthIn_triosy_obj_biwt),
      .lz(widthIn_triosy_lz)
    );
  EdgeDetect_IP_EdgeDetect_MagAng_run_widthIn_triosy_obj_widthIn_triosy_wait_ctrl
      EdgeDetect_IP_EdgeDetect_MagAng_run_widthIn_triosy_obj_widthIn_triosy_wait_ctrl_inst
      (
      .run_wten(run_wten),
      .widthIn_triosy_obj_iswt0(widthIn_triosy_obj_iswt0),
      .widthIn_triosy_obj_biwt(widthIn_triosy_obj_biwt)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_MagAng_run_angle_rsci
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_MagAng_run_angle_rsci (
  clk, rst, arst_n, angle_rsc_dat, angle_rsc_vld, angle_rsc_rdy, run_wen, angle_rsci_oswt,
      angle_rsci_wen_comp, angle_rsci_idat
);
  input clk;
  input rst;
  input arst_n;
  output [7:0] angle_rsc_dat;
  output angle_rsc_vld;
  input angle_rsc_rdy;
  input run_wen;
  input angle_rsci_oswt;
  output angle_rsci_wen_comp;
  input [7:0] angle_rsci_idat;


  // Interconnect Declarations
  wire angle_rsci_biwt;
  wire angle_rsci_bdwt;
  wire angle_rsci_bcwt;
  wire angle_rsci_irdy;
  wire angle_rsci_ivld_run_sct;


  // Interconnect Declarations for Component Instantiations 
  ccs_out_wait_v1 #(.rscid(32'sd6),
  .width(32'sd8)) angle_rsci (
      .irdy(angle_rsci_irdy),
      .ivld(angle_rsci_ivld_run_sct),
      .idat(angle_rsci_idat),
      .rdy(angle_rsc_rdy),
      .vld(angle_rsc_vld),
      .dat(angle_rsc_dat)
    );
  EdgeDetect_IP_EdgeDetect_MagAng_run_angle_rsci_angle_wait_ctrl EdgeDetect_IP_EdgeDetect_MagAng_run_angle_rsci_angle_wait_ctrl_inst
      (
      .run_wen(run_wen),
      .angle_rsci_oswt(angle_rsci_oswt),
      .angle_rsci_biwt(angle_rsci_biwt),
      .angle_rsci_bdwt(angle_rsci_bdwt),
      .angle_rsci_bcwt(angle_rsci_bcwt),
      .angle_rsci_irdy(angle_rsci_irdy),
      .angle_rsci_ivld_run_sct(angle_rsci_ivld_run_sct)
    );
  EdgeDetect_IP_EdgeDetect_MagAng_run_angle_rsci_angle_wait_dp EdgeDetect_IP_EdgeDetect_MagAng_run_angle_rsci_angle_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .arst_n(arst_n),
      .angle_rsci_oswt(angle_rsci_oswt),
      .angle_rsci_wen_comp(angle_rsci_wen_comp),
      .angle_rsci_biwt(angle_rsci_biwt),
      .angle_rsci_bdwt(angle_rsci_bdwt),
      .angle_rsci_bcwt(angle_rsci_bcwt)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_MagAng_run_magn_rsci
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_MagAng_run_magn_rsci (
  clk, rst, arst_n, magn_rsc_dat, magn_rsc_vld, magn_rsc_rdy, run_wen, magn_rsci_oswt,
      magn_rsci_wen_comp, magn_rsci_idat
);
  input clk;
  input rst;
  input arst_n;
  output [8:0] magn_rsc_dat;
  output magn_rsc_vld;
  input magn_rsc_rdy;
  input run_wen;
  input magn_rsci_oswt;
  output magn_rsci_wen_comp;
  input [8:0] magn_rsci_idat;


  // Interconnect Declarations
  wire magn_rsci_biwt;
  wire magn_rsci_bdwt;
  wire magn_rsci_bcwt;
  wire magn_rsci_irdy;
  wire magn_rsci_ivld_run_sct;


  // Interconnect Declarations for Component Instantiations 
  ccs_out_wait_v1 #(.rscid(32'sd5),
  .width(32'sd9)) magn_rsci (
      .irdy(magn_rsci_irdy),
      .ivld(magn_rsci_ivld_run_sct),
      .idat(magn_rsci_idat),
      .rdy(magn_rsc_rdy),
      .vld(magn_rsc_vld),
      .dat(magn_rsc_dat)
    );
  EdgeDetect_IP_EdgeDetect_MagAng_run_magn_rsci_magn_wait_ctrl EdgeDetect_IP_EdgeDetect_MagAng_run_magn_rsci_magn_wait_ctrl_inst
      (
      .run_wen(run_wen),
      .magn_rsci_oswt(magn_rsci_oswt),
      .magn_rsci_biwt(magn_rsci_biwt),
      .magn_rsci_bdwt(magn_rsci_bdwt),
      .magn_rsci_bcwt(magn_rsci_bcwt),
      .magn_rsci_irdy(magn_rsci_irdy),
      .magn_rsci_ivld_run_sct(magn_rsci_ivld_run_sct)
    );
  EdgeDetect_IP_EdgeDetect_MagAng_run_magn_rsci_magn_wait_dp EdgeDetect_IP_EdgeDetect_MagAng_run_magn_rsci_magn_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .arst_n(arst_n),
      .magn_rsci_oswt(magn_rsci_oswt),
      .magn_rsci_wen_comp(magn_rsci_wen_comp),
      .magn_rsci_biwt(magn_rsci_biwt),
      .magn_rsci_bdwt(magn_rsci_bdwt),
      .magn_rsci_bcwt(magn_rsci_bcwt)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci (
  clk, rst, arst_n, dy_in_rsc_dat, dy_in_rsc_vld, dy_in_rsc_rdy, run_wen, dy_in_rsci_oswt,
      dy_in_rsci_wen_comp, dy_in_rsci_idat_mxwt
);
  input clk;
  input rst;
  input arst_n;
  input [8:0] dy_in_rsc_dat;
  input dy_in_rsc_vld;
  output dy_in_rsc_rdy;
  input run_wen;
  input dy_in_rsci_oswt;
  output dy_in_rsci_wen_comp;
  output [8:0] dy_in_rsci_idat_mxwt;


  // Interconnect Declarations
  wire dy_in_rsci_biwt;
  wire dy_in_rsci_bdwt;
  wire dy_in_rsci_bcwt;
  wire dy_in_rsci_irdy_run_sct;
  wire dy_in_rsci_ivld;
  wire [8:0] dy_in_rsci_idat;


  // Interconnect Declarations for Component Instantiations 
  ccs_in_wait_v1 #(.rscid(32'sd2),
  .width(32'sd9)) dy_in_rsci (
      .rdy(dy_in_rsc_rdy),
      .vld(dy_in_rsc_vld),
      .dat(dy_in_rsc_dat),
      .irdy(dy_in_rsci_irdy_run_sct),
      .ivld(dy_in_rsci_ivld),
      .idat(dy_in_rsci_idat)
    );
  EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_ctrl EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_ctrl_inst
      (
      .run_wen(run_wen),
      .dy_in_rsci_oswt(dy_in_rsci_oswt),
      .dy_in_rsci_biwt(dy_in_rsci_biwt),
      .dy_in_rsci_bdwt(dy_in_rsci_bdwt),
      .dy_in_rsci_bcwt(dy_in_rsci_bcwt),
      .dy_in_rsci_irdy_run_sct(dy_in_rsci_irdy_run_sct),
      .dy_in_rsci_ivld(dy_in_rsci_ivld)
    );
  EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_dy_in_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .arst_n(arst_n),
      .dy_in_rsci_oswt(dy_in_rsci_oswt),
      .dy_in_rsci_wen_comp(dy_in_rsci_wen_comp),
      .dy_in_rsci_idat_mxwt(dy_in_rsci_idat_mxwt),
      .dy_in_rsci_biwt(dy_in_rsci_biwt),
      .dy_in_rsci_bdwt(dy_in_rsci_bdwt),
      .dy_in_rsci_bcwt(dy_in_rsci_bcwt),
      .dy_in_rsci_idat(dy_in_rsci_idat)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci (
  clk, rst, arst_n, dx_in_rsc_dat, dx_in_rsc_vld, dx_in_rsc_rdy, run_wen, dx_in_rsci_oswt,
      dx_in_rsci_wen_comp, dx_in_rsci_idat_mxwt
);
  input clk;
  input rst;
  input arst_n;
  input [8:0] dx_in_rsc_dat;
  input dx_in_rsc_vld;
  output dx_in_rsc_rdy;
  input run_wen;
  input dx_in_rsci_oswt;
  output dx_in_rsci_wen_comp;
  output [8:0] dx_in_rsci_idat_mxwt;


  // Interconnect Declarations
  wire dx_in_rsci_biwt;
  wire dx_in_rsci_bdwt;
  wire dx_in_rsci_bcwt;
  wire dx_in_rsci_irdy_run_sct;
  wire dx_in_rsci_ivld;
  wire [8:0] dx_in_rsci_idat;


  // Interconnect Declarations for Component Instantiations 
  ccs_in_wait_v1 #(.rscid(32'sd1),
  .width(32'sd9)) dx_in_rsci (
      .rdy(dx_in_rsc_rdy),
      .vld(dx_in_rsc_vld),
      .dat(dx_in_rsc_dat),
      .irdy(dx_in_rsci_irdy_run_sct),
      .ivld(dx_in_rsci_ivld),
      .idat(dx_in_rsci_idat)
    );
  EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_ctrl EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_ctrl_inst
      (
      .run_wen(run_wen),
      .dx_in_rsci_oswt(dx_in_rsci_oswt),
      .dx_in_rsci_biwt(dx_in_rsci_biwt),
      .dx_in_rsci_bdwt(dx_in_rsci_bdwt),
      .dx_in_rsci_bcwt(dx_in_rsci_bcwt),
      .dx_in_rsci_irdy_run_sct(dx_in_rsci_irdy_run_sct),
      .dx_in_rsci_ivld(dx_in_rsci_ivld)
    );
  EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_dx_in_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .arst_n(arst_n),
      .dx_in_rsci_oswt(dx_in_rsci_oswt),
      .dx_in_rsci_wen_comp(dx_in_rsci_wen_comp),
      .dx_in_rsci_idat_mxwt(dx_in_rsci_idat_mxwt),
      .dx_in_rsci_biwt(dx_in_rsci_biwt),
      .dx_in_rsci_bdwt(dx_in_rsci_bdwt),
      .dx_in_rsci_bcwt(dx_in_rsci_bcwt),
      .dx_in_rsci_idat(dx_in_rsci_idat)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_MagAng_run
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_MagAng_run (
  clk, rst, arst_n, dx_in_rsc_dat, dx_in_rsc_vld, dx_in_rsc_rdy, dy_in_rsc_dat, dy_in_rsc_vld,
      dy_in_rsc_rdy, widthIn_rsc_dat, widthIn_triosy_lz, heightIn_rsc_dat, heightIn_triosy_lz,
      magn_rsc_dat, magn_rsc_vld, magn_rsc_rdy, angle_rsc_dat, angle_rsc_vld, angle_rsc_rdy
);
  input clk;
  input rst;
  input arst_n;
  input [8:0] dx_in_rsc_dat;
  input dx_in_rsc_vld;
  output dx_in_rsc_rdy;
  input [8:0] dy_in_rsc_dat;
  input dy_in_rsc_vld;
  output dy_in_rsc_rdy;
  input [10:0] widthIn_rsc_dat;
  output widthIn_triosy_lz;
  input [9:0] heightIn_rsc_dat;
  output heightIn_triosy_lz;
  output [8:0] magn_rsc_dat;
  output magn_rsc_vld;
  input magn_rsc_rdy;
  output [7:0] angle_rsc_dat;
  output angle_rsc_vld;
  input angle_rsc_rdy;


  // Interconnect Declarations
  wire run_wen;
  wire run_wten;
  wire dx_in_rsci_wen_comp;
  wire [8:0] dx_in_rsci_idat_mxwt;
  wire dy_in_rsci_wen_comp;
  wire [8:0] dy_in_rsci_idat_mxwt;
  wire [10:0] widthIn_rsci_idat;
  wire [9:0] heightIn_rsci_idat;
  wire magn_rsci_wen_comp;
  reg [8:0] magn_rsci_idat;
  wire angle_rsci_wen_comp;
  reg angle_rsci_idat_5;
  reg angle_rsci_idat_4;
  reg angle_rsci_idat_3;
  reg angle_rsci_idat_2;
  reg angle_rsci_idat_1;
  reg angle_rsci_idat_0;
  wire [3:0] fsm_output;
  wire MROW_equal_tmp;
  wire and_11_cse;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_and_1_m1c_1;
  wire ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_expret_unequal_tmp_1;
  wire [18:0] sum_sva_1;
  wire [19:0] nl_sum_sva_1;
  reg MCOL_stage_0;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_else_unequal_tmp_1;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_unequal_tmp_1;
  wire [18:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_6_24_1_lpi_3_dfm_23_5_mx0;
  wire [14:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_5_24_6_lpi_3_dfm_18_4_mx0;
  wire [11:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_4_24_10_lpi_3_dfm_14_3_mx0;
  wire [9:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_3_24_13_lpi_3_dfm_11_2_mx0;
  wire [8:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_2_24_15_lpi_3_dfm_9_1_mx0;
  wire [8:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_1_24_16_lpi_3_dfm_mx0;
  reg reg_dy_in_rsci_oswt_cse;
  reg reg_magn_rsci_oswt_cse;
  reg reg_widthIn_triosy_obj_iswt0_cse;
  wire nand_cse;
  reg [10:0] MCOL_x_sva;
  wire MCOL_and_cse;
  wire mux_cse;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_6_24_1_lpi_3_dfm_4_mx0;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_6_24_1_lpi_3_dfm_3_mx0;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_6_24_1_lpi_3_dfm_2_mx0;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_6_24_1_lpi_3_dfm_1_mx0;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_6_24_1_lpi_3_dfm_0_mx0;
  wire [19:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_25_6_lpi_3_dfm_mx0;
  wire [32:0] operator_33_9_false_AC_TRN_AC_WRAP_lshift_itm;
  wire [8:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_qif_acc_itm;
  wire [9:0] nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_qif_acc_itm;
  wire [17:0] operator_19_0_false_AC_TRN_AC_WRAP_lshift_itm;
  wire [8:0] z_out;
  wire [9:0] nl_z_out;
  wire or_tmp_20;
  wire [9:0] z_out_1;
  wire [14:0] z_out_2;
  wire or_tmp_24;
  wire [18:0] z_out_3;
  wire or_tmp_26;
  wire [15:0] z_out_4;
  wire [24:0] z_out_5;
  reg [9:0] MROW_y_sva;
  wire [24:0] ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_temp_sva_1;
  wire [25:0] nl_ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_temp_sva_1;
  wire [12:0] ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_24_12_sva_1;
  wire [13:0] nl_ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_24_12_sva_1;
  wire [19:0] ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_mul_psp_sva_1;
  wire [1:0] ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_expret_qr_1_0_lpi_3_dfm_1;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_2_24_15_lpi_3_dfm_0_mx0;
  wire [9:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_2_25_15_lpi_3_dfm_10_1_mx0;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_2_25_15_lpi_3_dfm_0_mx0;
  wire [10:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_2_25_15_sva_1;
  wire [11:0] nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_2_25_15_sva_1;
  wire [9:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_2_24_15_sva_2;
  wire [10:0] nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_2_24_15_sva_2;
  wire [11:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_pmx_13_1_lpi_3_dfm_12_1_mx0w1;
  wire [12:0] nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_pmx_13_1_lpi_3_dfm_12_1_mx0w1;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_pmx_13_1_lpi_3_dfm_0_mx0;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_3_24_13_lpi_3_dfm_0_mx0;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_3_24_13_lpi_3_dfm_1_mx0;
  wire [10:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_3_25_13_lpi_3_dfm_12_2_mx0;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_3_25_13_lpi_3_dfm_0_mx0;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_3_25_13_lpi_3_dfm_1_mx0;
  wire [12:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_pmx_13_1_sva_1;
  wire [13:0] nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_pmx_13_1_sva_1;
  wire [12:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_3_25_13_sva_1;
  wire [13:0] nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_3_25_13_sva_1;
  wire [11:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_3_24_13_sva_2;
  wire [12:0] nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_3_24_13_sva_2;
  wire [11:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_1_pmx_13_1_lpi_3_dfm_12_1_mx0;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_1_pmx_13_1_lpi_3_dfm_0_mx0;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_4_24_10_lpi_3_dfm_0_mx0;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_4_24_10_lpi_3_dfm_2_mx0;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_4_24_10_lpi_3_dfm_1_mx0;
  wire [12:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_4_25_10_lpi_3_dfm_15_3_mx0;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_4_25_10_lpi_3_dfm_0_mx0;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_4_25_10_lpi_3_dfm_2_mx0;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_4_25_10_lpi_3_dfm_1_mx0;
  wire [12:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_1_pmx_13_1_sva_1;
  wire [13:0] nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_1_pmx_13_1_sva_1;
  wire [5:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_4_pmx_13_1_lpi_3_dfm_12_7_mx0;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_4_pmx_13_1_lpi_3_dfm_0_mx0;
  wire [5:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_4_pmx_13_1_lpi_3_dfm_6_1_mx0;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_5_24_6_lpi_3_dfm_0_mx0;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_5_24_6_lpi_3_dfm_3_mx0;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_5_24_6_lpi_3_dfm_1_mx0;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_5_24_6_lpi_3_dfm_2_mx0;
  wire [15:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_5_25_6_lpi_3_dfm_19_4_mx0;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_5_25_6_lpi_3_dfm_0_mx0;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_5_25_6_lpi_3_dfm_3_mx0;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_5_25_6_lpi_3_dfm_1_mx0;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_5_25_6_lpi_3_dfm_2_mx0;
  wire [19:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_5_25_6_sva_1;
  wire [20:0] nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_5_25_6_sva_1;
  wire [6:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_2_pmx_13_1_lpi_3_dfm_12_6_mx0;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_2_pmx_13_1_lpi_3_dfm_0_mx0;
  wire [4:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_2_pmx_13_1_lpi_3_dfm_5_1_mx0;
  wire [12:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_2_pmx_13_1_sva_2;
  wire [13:0] nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_2_pmx_13_1_sva_2;
  wire [7:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_5_pmx_13_1_lpi_3_dfm_12_5_mx0;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_5_pmx_13_1_lpi_3_dfm_0_mx0;
  wire [3:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_5_pmx_13_1_lpi_3_dfm_4_1_mx0;
  wire [12:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_3_pmx_13_1_sva_2;
  wire [13:0] nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_3_pmx_13_1_sva_2;
  wire [8:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_3_pmx_13_1_lpi_3_dfm_12_4_mx0;
  wire [12:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_5_pmx_13_1_sva_1;
  wire [13:0] nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_5_pmx_13_1_sva_1;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_and_ssc_1;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_and_2_ssc_1;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_and_3_ssc_1;
  wire [1:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_pmx_13_5_lpi_3_dfm_mx0_5_4;
  wire [8:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_pmx_13_1_lpi_3_dfm_12_1_mx0_11_3;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_pmx_13_1_lpi_3_dfm_12_1_mx0_2;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_pmx_13_1_lpi_3_dfm_12_1_mx0_1;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_pmx_13_1_lpi_3_dfm_12_1_mx0_0;
  wire [4:0] leading_sign_19_0_27819ab0b53864e60fe49417cb28f42d22ee_1;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_qr_24_16_lpi_3_dfm_mx0_8;
  wire [7:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_qr_24_16_lpi_3_dfm_mx0_7_0;
  reg angle_rsci_idat_7;
  reg angle_rsci_idat_6;
  wire MROW_y_or_cse;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_and_itm;
  wire [7:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_else_else_if_acc_itm_15_8_1;

  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_mux1h_nl;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_mux1h_2_nl;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_mux1h_3_nl;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_mux1h_5_nl;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_mux1h_6_nl;
  wire MROW_y_not_1_nl;
  wire[10:0] operator_11_false_acc_nl;
  wire[11:0] nl_operator_11_false_acc_nl;
  wire[10:0] MCOL_acc_1_nl;
  wire[11:0] nl_MCOL_acc_1_nl;
  wire not_85_nl;
  wire[23:0] ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_temp_slc_ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_temp_ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TR000000;
  wire[24:0] nl_ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_temp_slc_ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_temp_ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TR000000;
  wire[24:0] ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_temp_acc_8_nl;
  wire[25:0] nl_ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_temp_acc_8_nl;
  wire[26:0] ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_temp_acc_3_nl;
  wire[27:0] nl_ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_temp_acc_3_nl;
  wire[25:0] ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_temp_acc_2_nl;
  wire[26:0] nl_ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_temp_acc_2_nl;
  wire[23:0] ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_temp_acc_1_nl;
  wire[24:0] nl_ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_temp_acc_1_nl;
  wire[9:0] ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_mux_3_nl;
  wire[5:0] ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_mux_4_nl;
  wire[1:0] ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_not_1_nl;
  wire[8:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_acc_3_nl;
  wire[9:0] nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_acc_3_nl;
  wire[8:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_nl;
  wire[9:0] nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_nl;
  wire[8:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_18_nl;
  wire[9:0] nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_18_nl;
  wire[9:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_acc_13_nl;
  wire[10:0] nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_acc_13_nl;
  wire[9:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_20_nl;
  wire[10:0] nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_20_nl;
  wire[10:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_acc_17_nl;
  wire[11:0] nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_acc_17_nl;
  wire[11:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_acc_7_nl;
  wire[12:0] nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_acc_7_nl;
  wire[11:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_23_nl;
  wire[12:0] nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_23_nl;
  wire[5:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_acc_8_nl;
  wire[6:0] nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_acc_8_nl;
  wire[14:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_25_nl;
  wire[15:0] nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_25_nl;
  wire[15:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_acc_22_nl;
  wire[16:0] nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_acc_22_nl;
  wire[6:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_15_nl;
  wire[7:0] nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_15_nl;
  wire[18:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_26_nl;
  wire[19:0] nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_26_nl;
  wire[19:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_acc_24_nl;
  wire[20:0] nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_acc_24_nl;
  wire[25:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_6_if_acc_nl;
  wire[26:0] nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_6_if_acc_nl;
  wire[7:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_acc_11_nl;
  wire[8:0] nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_acc_11_nl;
  wire[24:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_7_else_acc_1_nl;
  wire[25:0] nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_7_else_acc_1_nl;
  wire[23:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_27_nl;
  wire[24:0] nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_27_nl;
  wire[8:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_21_nl;
  wire[9:0] nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_21_nl;
  wire[15:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_else_else_if_acc_nl;
  wire[16:0] nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_else_else_if_acc_nl;
  wire[2:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_mux_21_nl;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_mux_55_nl;
  wire[17:0] MCOL_mul_nl;
  wire[17:0] MCOL_mul_1_nl;
  wire[5:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_mux_37_nl;
  wire and_66_nl;
  wire[10:0] acc_1_nl;
  wire[11:0] nl_acc_1_nl;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_or_3_nl;
  wire[7:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_mux_21_nl;
  wire[15:0] acc_2_nl;
  wire[16:0] nl_acc_2_nl;
  wire[3:0] MROW_MROW_and_4_nl;
  wire[4:0] MROW_mux_8_nl;
  wire MROW_mux_9_nl;
  wire MROW_mux_10_nl;
  wire[2:0] MROW_MROW_and_5_nl;
  wire MROW_not_3_nl;
  wire[10:0] MROW_MROW_MROW_nor_1_nl;
  wire MROW_not_4_nl;
  wire MROW_MROW_and_6_nl;
  wire MROW_MROW_MROW_nand_1_nl;
  wire[19:0] acc_3_nl;
  wire[20:0] nl_acc_3_nl;
  wire[10:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_mux_38_nl;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_mux_39_nl;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_mux_40_nl;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_mux_41_nl;
  wire[2:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_and_6_nl;
  wire not_94_nl;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_and_7_nl;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_or_1_nl;
  wire[12:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_mux_42_nl;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_and_8_nl;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_and_9_nl;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_A000000;
  wire[16:0] acc_4_nl;
  wire[17:0] nl_acc_4_nl;
  wire[2:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_and_6_nl;
  wire[7:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_mux_22_nl;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_mux_23_nl;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_mux_24_nl;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_and_7_nl;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_and_8_nl;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_and_9_nl;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_or_4_nl;
  wire[2:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_nor_1_nl;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_not_3_nl;
  wire[5:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_mux_25_nl;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_mux_26_nl;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_mux_27_nl;
  wire[25:0] acc_5_nl;
  wire[26:0] nl_acc_5_nl;
  wire[13:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_and_10_nl;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_not_4_nl;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_mux_28_nl;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_mux_29_nl;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_mux_30_nl;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_mux_31_nl;
  wire[5:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_and_11_nl;
  wire[15:0] ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9000000;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_not_5_nl;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_or_5_nl;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_or_6_nl;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_or_7_nl;
  wire ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_or_8_nl;

  // Interconnect Declarations for Component Instantiations 
  wire[12:0] ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_m1_mux_1_nl;
  wire[10:0] ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_m1_mux_2_nl;
  wire ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_m1_ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_m1_and_nl;
  wire [24:0] nl_operator_33_9_false_AC_TRN_AC_WRAP_lshift_rg_a;
  assign ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_m1_mux_1_nl
      = MUX_v_13_2_2(ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_24_12_sva_1,
      (ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_temp_sva_1[24:12]),
      ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_expret_qr_1_0_lpi_3_dfm_1[0]);
  assign ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_m1_mux_2_nl
      = MUX_v_11_2_2((ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_mul_psp_sva_1[10:0]),
      (ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_temp_sva_1[11:1]),
      ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_expret_qr_1_0_lpi_3_dfm_1[0]);
  assign ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_m1_ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_m1_and_nl
      = (ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_temp_sva_1[0])
      & (ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_expret_qr_1_0_lpi_3_dfm_1[0]);
  assign nl_operator_33_9_false_AC_TRN_AC_WRAP_lshift_rg_a = {ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_m1_mux_1_nl
      , ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_m1_mux_2_nl
      , ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_m1_ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_m1_and_nl};
  wire[3:0] ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_expret_ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_expret_and_nl;
  wire[3:0] ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_expret_qif_acc_nl;
  wire[4:0] nl_ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_expret_qif_acc_nl;
  wire [4:0] nl_operator_33_9_false_AC_TRN_AC_WRAP_lshift_rg_s;
  assign nl_ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_expret_qif_acc_nl = ({1'b1
      , (~ (leading_sign_19_0_27819ab0b53864e60fe49417cb28f42d22ee_1[4:2]))}) + 4'b0101;
  assign ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_expret_qif_acc_nl = nl_ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_expret_qif_acc_nl[3:0];
  assign ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_expret_ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_expret_and_nl
      = MUX_v_4_2_2(4'b0000, ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_expret_qif_acc_nl,
      ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_expret_unequal_tmp_1);
  assign nl_operator_33_9_false_AC_TRN_AC_WRAP_lshift_rg_s = {ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_expret_ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_expret_and_nl
      , (ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_expret_qr_1_0_lpi_3_dfm_1[1])};
  wire [17:0] nl_operator_19_0_false_AC_TRN_AC_WRAP_lshift_rg_a;
  assign nl_operator_19_0_false_AC_TRN_AC_WRAP_lshift_rg_a = sum_sva_1[17:0];
  wire [7:0] nl_EdgeDetect_IP_EdgeDetect_MagAng_run_angle_rsci_inst_angle_rsci_idat;
  assign nl_EdgeDetect_IP_EdgeDetect_MagAng_run_angle_rsci_inst_angle_rsci_idat =
      {angle_rsci_idat_7 , angle_rsci_idat_6 , angle_rsci_idat_5 , angle_rsci_idat_4
      , angle_rsci_idat_3 , angle_rsci_idat_2 , angle_rsci_idat_1 , angle_rsci_idat_0};
  wire  nl_EdgeDetect_IP_EdgeDetect_MagAng_run_run_fsm_inst_MCOL_C_0_tr0;
  assign nl_EdgeDetect_IP_EdgeDetect_MagAng_run_run_fsm_inst_MCOL_C_0_tr0 = ~ MCOL_stage_0;
  ccs_in_v1 #(.rscid(32'sd3),
  .width(32'sd11)) widthIn_rsci (
      .dat(widthIn_rsc_dat),
      .idat(widthIn_rsci_idat)
    );
  ccs_in_v1 #(.rscid(32'sd4),
  .width(32'sd10)) heightIn_rsci (
      .dat(heightIn_rsc_dat),
      .idat(heightIn_rsci_idat)
    );
  mgc_shift_bl_v5 #(.width_a(32'sd25),
  .signd_a(32'sd0),
  .width_s(32'sd5),
  .width_z(32'sd33)) operator_33_9_false_AC_TRN_AC_WRAP_lshift_rg (
      .a(nl_operator_33_9_false_AC_TRN_AC_WRAP_lshift_rg_a[24:0]),
      .s(nl_operator_33_9_false_AC_TRN_AC_WRAP_lshift_rg_s[4:0]),
      .z(operator_33_9_false_AC_TRN_AC_WRAP_lshift_itm)
    );
  mgc_shift_l_v5 #(.width_a(32'sd18),
  .signd_a(32'sd0),
  .width_s(32'sd5),
  .width_z(32'sd18)) operator_19_0_false_AC_TRN_AC_WRAP_lshift_rg (
      .a(nl_operator_19_0_false_AC_TRN_AC_WRAP_lshift_rg_a[17:0]),
      .s(leading_sign_19_0_27819ab0b53864e60fe49417cb28f42d22ee_1),
      .z(operator_19_0_false_AC_TRN_AC_WRAP_lshift_itm)
    );
  leading_sign_19_0  leading_sign_19_0_rg (
      .mantissa(sum_sva_1),
      .rtn(leading_sign_19_0_27819ab0b53864e60fe49417cb28f42d22ee_1)
    );
  EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci EdgeDetect_IP_EdgeDetect_MagAng_run_dx_in_rsci_inst
      (
      .clk(clk),
      .rst(rst),
      .arst_n(arst_n),
      .dx_in_rsc_dat(dx_in_rsc_dat),
      .dx_in_rsc_vld(dx_in_rsc_vld),
      .dx_in_rsc_rdy(dx_in_rsc_rdy),
      .run_wen(run_wen),
      .dx_in_rsci_oswt(reg_dy_in_rsci_oswt_cse),
      .dx_in_rsci_wen_comp(dx_in_rsci_wen_comp),
      .dx_in_rsci_idat_mxwt(dx_in_rsci_idat_mxwt)
    );
  EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci EdgeDetect_IP_EdgeDetect_MagAng_run_dy_in_rsci_inst
      (
      .clk(clk),
      .rst(rst),
      .arst_n(arst_n),
      .dy_in_rsc_dat(dy_in_rsc_dat),
      .dy_in_rsc_vld(dy_in_rsc_vld),
      .dy_in_rsc_rdy(dy_in_rsc_rdy),
      .run_wen(run_wen),
      .dy_in_rsci_oswt(reg_dy_in_rsci_oswt_cse),
      .dy_in_rsci_wen_comp(dy_in_rsci_wen_comp),
      .dy_in_rsci_idat_mxwt(dy_in_rsci_idat_mxwt)
    );
  EdgeDetect_IP_EdgeDetect_MagAng_run_magn_rsci EdgeDetect_IP_EdgeDetect_MagAng_run_magn_rsci_inst
      (
      .clk(clk),
      .rst(rst),
      .arst_n(arst_n),
      .magn_rsc_dat(magn_rsc_dat),
      .magn_rsc_vld(magn_rsc_vld),
      .magn_rsc_rdy(magn_rsc_rdy),
      .run_wen(run_wen),
      .magn_rsci_oswt(reg_magn_rsci_oswt_cse),
      .magn_rsci_wen_comp(magn_rsci_wen_comp),
      .magn_rsci_idat(magn_rsci_idat)
    );
  EdgeDetect_IP_EdgeDetect_MagAng_run_angle_rsci EdgeDetect_IP_EdgeDetect_MagAng_run_angle_rsci_inst
      (
      .clk(clk),
      .rst(rst),
      .arst_n(arst_n),
      .angle_rsc_dat(angle_rsc_dat),
      .angle_rsc_vld(angle_rsc_vld),
      .angle_rsc_rdy(angle_rsc_rdy),
      .run_wen(run_wen),
      .angle_rsci_oswt(reg_magn_rsci_oswt_cse),
      .angle_rsci_wen_comp(angle_rsci_wen_comp),
      .angle_rsci_idat(nl_EdgeDetect_IP_EdgeDetect_MagAng_run_angle_rsci_inst_angle_rsci_idat[7:0])
    );
  EdgeDetect_IP_EdgeDetect_MagAng_run_widthIn_triosy_obj EdgeDetect_IP_EdgeDetect_MagAng_run_widthIn_triosy_obj_inst
      (
      .widthIn_triosy_lz(widthIn_triosy_lz),
      .run_wten(run_wten),
      .widthIn_triosy_obj_iswt0(reg_widthIn_triosy_obj_iswt0_cse)
    );
  EdgeDetect_IP_EdgeDetect_MagAng_run_heightIn_triosy_obj EdgeDetect_IP_EdgeDetect_MagAng_run_heightIn_triosy_obj_inst
      (
      .heightIn_triosy_lz(heightIn_triosy_lz),
      .run_wten(run_wten),
      .heightIn_triosy_obj_iswt0(reg_widthIn_triosy_obj_iswt0_cse)
    );
  EdgeDetect_IP_EdgeDetect_MagAng_run_staller EdgeDetect_IP_EdgeDetect_MagAng_run_staller_inst
      (
      .clk(clk),
      .rst(rst),
      .arst_n(arst_n),
      .run_wen(run_wen),
      .run_wten(run_wten),
      .dx_in_rsci_wen_comp(dx_in_rsci_wen_comp),
      .dy_in_rsci_wen_comp(dy_in_rsci_wen_comp),
      .magn_rsci_wen_comp(magn_rsci_wen_comp),
      .angle_rsci_wen_comp(angle_rsci_wen_comp)
    );
  EdgeDetect_IP_EdgeDetect_MagAng_run_run_fsm EdgeDetect_IP_EdgeDetect_MagAng_run_run_fsm_inst
      (
      .clk(clk),
      .rst(rst),
      .arst_n(arst_n),
      .run_wen(run_wen),
      .fsm_output(fsm_output),
      .MCOL_C_0_tr0(nl_EdgeDetect_IP_EdgeDetect_MagAng_run_run_fsm_inst_MCOL_C_0_tr0),
      .MROW_C_0_tr0(MROW_equal_tmp)
    );
  assign MCOL_and_cse = run_wen & (fsm_output[1]) & MCOL_stage_0;
  assign MROW_y_or_cse = (fsm_output[0]) | (fsm_output[2]);
  assign nl_operator_11_false_acc_nl = widthIn_rsci_idat + 11'b11111111111;
  assign operator_11_false_acc_nl = nl_operator_11_false_acc_nl[10:0];
  assign nand_cse = ~(MCOL_stage_0 & (MCOL_x_sva == operator_11_false_acc_nl));
  assign nl_ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_temp_acc_1_nl
      = ({ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_24_12_sva_1
      , (ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_mul_psp_sva_1[10:0])})
      + conv_u2u_19_24({(ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_mul_psp_sva_1[10:0])
      , 2'b00 , (ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_mul_psp_sva_1[10:5])});
  assign ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_temp_acc_1_nl
      = nl_ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_temp_acc_1_nl[23:0];
  assign nl_ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_temp_acc_2_nl
      = ({ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_24_12_sva_1
      , (ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_mul_psp_sva_1[10:0])
      , 2'b00}) + conv_u2u_24_26(ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_temp_acc_1_nl);
  assign ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_temp_acc_2_nl
      = nl_ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_temp_acc_2_nl[25:0];
  assign nl_ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_temp_acc_3_nl
      = ({(~ (ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_24_12_sva_1[11:0]))
      , (~ (ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_mul_psp_sva_1[10:0]))
      , 4'b0000}) + conv_u2u_26_27(ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_temp_acc_2_nl);
  assign ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_temp_acc_3_nl
      = nl_ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_temp_acc_3_nl[26:0];
  assign nl_ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_temp_acc_8_nl
      = ({(~ (ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_24_12_sva_1[11:0]))
      , (~ (ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_mul_psp_sva_1[10:0]))
      , 2'b01}) + conv_u2u_24_25({1'b1 , (readslicef_27_23_4(ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_temp_acc_3_nl))});
  assign ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_temp_acc_8_nl
      = nl_ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_temp_acc_8_nl[24:0];
  assign nl_ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_temp_slc_ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_temp_ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TR000000
      = ({1'b1 , (readslicef_25_23_2(ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_temp_acc_8_nl))})
      + 24'b110000000000000000000001;
  assign ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_temp_slc_ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_temp_ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TR000000
      = nl_ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_temp_slc_ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_temp_ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TR000000[23:0];
  assign nl_ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_temp_sva_1
      = ({1'b1 , ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_temp_slc_ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_temp_ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TR000000})
      + ({(ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_24_12_sva_1[11:0])
      , ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_24_12_sva_1});
  assign ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_temp_sva_1
      = nl_ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_temp_sva_1[24:0];
  assign ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_mux_3_nl
      = MUX_v_10_4_2(10'b0110101001, 10'b1001010100, 10'b1011101110, 10'b1101111100,
      operator_19_0_false_AC_TRN_AC_WRAP_lshift_itm[17:16]);
  assign nl_ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_24_12_sva_1
      = conv_u2u_9_13(ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_mul_psp_sva_1[19:11])
      + conv_u2u_12_13({1'b1 , ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_mux_3_nl
      , 1'b1});
  assign ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_24_12_sva_1
      = nl_ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_24_12_sva_1[12:0];
  assign ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_mux_4_nl
      = MUX_v_6_4_2(6'b101011, 6'b011010, 6'b001110, 6'b000100, operator_19_0_false_AC_TRN_AC_WRAP_lshift_itm[17:16]);
  assign ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_mul_psp_sva_1
      = (operator_19_0_false_AC_TRN_AC_WRAP_lshift_itm[15:4]) * ({2'b10 , ac_math_ac_sqrt_pwl_AC_TRN_19_19_AC_TRN_AC_WRAP_16_9_AC_TRN_AC_WRAP_normalized_output_mux_4_nl});
  assign ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_not_1_nl = ~ (leading_sign_19_0_27819ab0b53864e60fe49417cb28f42d22ee_1[1:0]);
  assign ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_expret_qr_1_0_lpi_3_dfm_1
      = MUX_v_2_2_2(2'b00, ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_leading_1_not_1_nl,
      ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_expret_unequal_tmp_1);
  assign ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_expret_unequal_tmp_1 = (sum_sva_1!=19'b0000000000000000000);
  assign nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_qif_acc_itm
      = conv_u2u_8_9(~ (dx_in_rsci_idat_mxwt[7:0])) + 9'b000000001;
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_qif_acc_itm
      = nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_qif_acc_itm[8:0];
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_qr_24_16_lpi_3_dfm_mx0_8
      = (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_qif_acc_itm[8])
      & (dx_in_rsci_idat_mxwt[8]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_qr_24_16_lpi_3_dfm_mx0_7_0
      = MUX_v_8_2_2((dx_in_rsci_idat_mxwt[7:0]), (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_qif_acc_itm[7:0]),
      dx_in_rsci_idat_mxwt[8]);
  assign nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_acc_3_nl
      = ({(~ ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_qr_24_16_lpi_3_dfm_mx0_8)
      , (~ ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_qr_24_16_lpi_3_dfm_mx0_7_0)})
      + conv_u2s_8_9(dy_in_rsci_idat_mxwt[7:0]) + 9'b000000001;
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_acc_3_nl
      = nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_acc_3_nl[8:0];
  assign nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_nl
      = ({1'b1 , (dy_in_rsci_idat_mxwt[7:0])}) + ({ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_qr_24_16_lpi_3_dfm_mx0_8
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_qr_24_16_lpi_3_dfm_mx0_7_0});
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_nl
      = nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_nl[8:0];
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_1_24_16_lpi_3_dfm_mx0
      = MUX_v_9_2_2(ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_acc_3_nl,
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_nl,
      dy_in_rsci_idat_mxwt[8]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_and_itm
      = (z_out_1[9]) & (dy_in_rsci_idat_mxwt[8]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_pmx_13_5_lpi_3_dfm_mx0_5_4
      = MUX_v_2_2_2(2'b01, 2'b10, ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_1_24_16_lpi_3_dfm_mx0[8]);
  assign nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_18_nl
      = ({1'b1 , (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_1_24_16_lpi_3_dfm_mx0[7:0])})
      + ({ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_and_itm
      , (z_out_1[8:1])});
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_18_nl
      = nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_18_nl[8:0];
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_2_24_15_lpi_3_dfm_9_1_mx0
      = MUX_v_9_2_2((ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_2_24_15_sva_2[9:1]),
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_18_nl,
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_1_24_16_lpi_3_dfm_mx0[8]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_2_24_15_lpi_3_dfm_0_mx0
      = MUX_s_1_2_2((ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_2_24_15_sva_2[0]),
      (z_out_1[0]), ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_1_24_16_lpi_3_dfm_mx0[8]);
  assign nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_acc_13_nl
      = ({ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_and_itm
      , (z_out_1[8:0])}) + conv_u2u_7_10(ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_1_24_16_lpi_3_dfm_mx0[7:1]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_acc_13_nl
      = nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_acc_13_nl[9:0];
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_2_25_15_lpi_3_dfm_10_1_mx0
      = MUX_v_10_2_2(ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_acc_13_nl,
      (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_2_25_15_sva_1[10:1]),
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_1_24_16_lpi_3_dfm_mx0[8]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_2_25_15_lpi_3_dfm_0_mx0
      = MUX_s_1_2_2((ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_1_24_16_lpi_3_dfm_mx0[0]),
      (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_2_25_15_sva_1[0]),
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_1_24_16_lpi_3_dfm_mx0[8]);
  assign nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_2_25_15_sva_1
      = ({ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_and_itm
      , (z_out_1[8:0]) , 1'b0}) + conv_u2u_8_11(~ (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_1_24_16_lpi_3_dfm_mx0[7:0]))
      + 11'b00000000001;
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_2_25_15_sva_1
      = nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_2_25_15_sva_1[10:0];
  assign nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_2_24_15_sva_2
      = ({(~ ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_and_itm)
      , (~ (z_out_1[8:0]))}) + conv_u2s_9_10({(ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_1_24_16_lpi_3_dfm_mx0[7:0])
      , 1'b0}) + 10'b0000000001;
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_2_24_15_sva_2
      = nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_2_24_15_sva_2[9:0];
  assign nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_pmx_13_1_lpi_3_dfm_12_1_mx0w1
      = ({(z_out[8]) , (~ (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_1_24_16_lpi_3_dfm_mx0[8]))
      , (z_out[6]) , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_pmx_13_5_lpi_3_dfm_mx0_5_4
      , (z_out[3]) , (signext_2_1(~ (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_1_24_16_lpi_3_dfm_mx0[8])))
      , (z_out[0]) , (signext_3_2({(~ (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_1_24_16_lpi_3_dfm_mx0[8]))
      , (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_1_24_16_lpi_3_dfm_mx0[8])}))})
      + 12'b000011111011;
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_pmx_13_1_lpi_3_dfm_12_1_mx0w1
      = nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_pmx_13_1_lpi_3_dfm_12_1_mx0w1[11:0];
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_pmx_13_1_lpi_3_dfm_12_1_mx0_11_3
      = MUX_v_9_2_2((ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_pmx_13_1_lpi_3_dfm_12_1_mx0w1[11:3]),
      (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_pmx_13_1_sva_1[12:4]),
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_2_24_15_lpi_3_dfm_9_1_mx0[8]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_pmx_13_1_lpi_3_dfm_12_1_mx0_2
      = (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_pmx_13_1_lpi_3_dfm_12_1_mx0w1[2])
      | (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_2_24_15_lpi_3_dfm_9_1_mx0[8]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_pmx_13_1_lpi_3_dfm_12_1_mx0_1
      = (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_pmx_13_1_sva_1[2])
      & (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_2_24_15_lpi_3_dfm_9_1_mx0[8]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_pmx_13_1_lpi_3_dfm_12_1_mx0_0
      = (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_pmx_13_1_lpi_3_dfm_12_1_mx0w1[0])
      & (~ (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_2_24_15_lpi_3_dfm_9_1_mx0[8]));
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_pmx_13_1_lpi_3_dfm_0_mx0
      = MUX_s_1_2_2((~ (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_1_24_16_lpi_3_dfm_mx0[8])),
      (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_pmx_13_1_sva_1[0]),
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_2_24_15_lpi_3_dfm_9_1_mx0[8]);
  assign nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_20_nl
      = ({1'b1 , (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_2_24_15_lpi_3_dfm_9_1_mx0[7:0])
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_2_24_15_lpi_3_dfm_0_mx0})
      + conv_u2s_9_10(ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_2_25_15_lpi_3_dfm_10_1_mx0[9:1]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_20_nl
      = nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_20_nl[9:0];
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_3_24_13_lpi_3_dfm_11_2_mx0
      = MUX_v_10_2_2((ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_3_24_13_sva_2[11:2]),
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_20_nl,
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_2_24_15_lpi_3_dfm_9_1_mx0[8]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_3_24_13_lpi_3_dfm_0_mx0
      = MUX_s_1_2_2((ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_3_24_13_sva_2[0]),
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_2_25_15_lpi_3_dfm_0_mx0,
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_2_24_15_lpi_3_dfm_9_1_mx0[8]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_3_24_13_lpi_3_dfm_1_mx0
      = MUX_s_1_2_2((ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_3_24_13_sva_2[1]),
      (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_2_25_15_lpi_3_dfm_10_1_mx0[0]),
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_2_24_15_lpi_3_dfm_9_1_mx0[8]);
  assign nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_acc_17_nl
      = ({ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_2_25_15_lpi_3_dfm_10_1_mx0
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_2_25_15_lpi_3_dfm_0_mx0})
      + conv_u2u_7_11(ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_2_24_15_lpi_3_dfm_9_1_mx0[7:1]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_acc_17_nl
      = nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_acc_17_nl[10:0];
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_3_25_13_lpi_3_dfm_12_2_mx0
      = MUX_v_11_2_2(ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_acc_17_nl,
      (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_3_25_13_sva_1[12:2]),
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_2_24_15_lpi_3_dfm_9_1_mx0[8]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_3_25_13_lpi_3_dfm_0_mx0
      = MUX_s_1_2_2(ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_2_24_15_lpi_3_dfm_0_mx0,
      (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_3_25_13_sva_1[0]),
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_2_24_15_lpi_3_dfm_9_1_mx0[8]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_3_25_13_lpi_3_dfm_1_mx0
      = MUX_s_1_2_2((ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_2_24_15_lpi_3_dfm_9_1_mx0[0]),
      (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_3_25_13_sva_1[1]),
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_2_24_15_lpi_3_dfm_9_1_mx0[8]);
  assign nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_pmx_13_1_sva_1
      = ({(z_out[8]) , (~ (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_1_24_16_lpi_3_dfm_mx0[8]))
      , (z_out[6]) , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_pmx_13_5_lpi_3_dfm_mx0_5_4
      , (z_out[3]) , (signext_2_1(~ (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_1_24_16_lpi_3_dfm_mx0[8])))
      , (z_out[0]) , (signext_4_3({(~ (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_1_24_16_lpi_3_dfm_mx0[8]))
      , (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_1_24_16_lpi_3_dfm_mx0[8])
      , (~ (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_1_24_16_lpi_3_dfm_mx0[8]))}))})
      + 13'b1111000001011;
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_pmx_13_1_sva_1
      = nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_pmx_13_1_sva_1[12:0];
  assign nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_3_25_13_sva_1
      = ({ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_2_25_15_lpi_3_dfm_10_1_mx0
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_2_25_15_lpi_3_dfm_0_mx0
      , 2'b00}) + conv_u2u_9_13({(~ (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_2_24_15_lpi_3_dfm_9_1_mx0[7:0]))
      , (~ ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_2_24_15_lpi_3_dfm_0_mx0)})
      + 13'b0000000000001;
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_3_25_13_sva_1
      = nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_3_25_13_sva_1[12:0];
  assign nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_3_24_13_sva_2
      = ({1'b1 , (~ ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_2_25_15_lpi_3_dfm_10_1_mx0)
      , (~ ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_2_25_15_lpi_3_dfm_0_mx0)})
      + conv_u2s_11_12({(ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_2_24_15_lpi_3_dfm_9_1_mx0[7:0])
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_2_24_15_lpi_3_dfm_0_mx0
      , 2'b00}) + 12'b000000000001;
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_3_24_13_sva_2
      = nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_3_24_13_sva_2[11:0];
  assign nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_acc_7_nl
      = ({ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_pmx_13_1_lpi_3_dfm_12_1_mx0_11_3
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_pmx_13_1_lpi_3_dfm_12_1_mx0_2
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_pmx_13_1_lpi_3_dfm_12_1_mx0_1
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_pmx_13_1_lpi_3_dfm_12_1_mx0_0})
      + 12'b000001111111;
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_acc_7_nl
      = nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_acc_7_nl[11:0];
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_1_pmx_13_1_lpi_3_dfm_12_1_mx0
      = MUX_v_12_2_2(ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_acc_7_nl,
      (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_1_pmx_13_1_sva_1[12:1]),
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_3_24_13_lpi_3_dfm_11_2_mx0[9]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_1_pmx_13_1_lpi_3_dfm_0_mx0
      = MUX_s_1_2_2(ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_pmx_13_1_lpi_3_dfm_0_mx0,
      (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_1_pmx_13_1_sva_1[0]),
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_3_24_13_lpi_3_dfm_11_2_mx0[9]);
  assign nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_23_nl
      = ({1'b1 , (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_3_24_13_lpi_3_dfm_11_2_mx0[8:0])
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_3_24_13_lpi_3_dfm_1_mx0
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_3_24_13_lpi_3_dfm_0_mx0})
      + conv_u2s_10_12(ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_3_25_13_lpi_3_dfm_12_2_mx0[10:1]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_23_nl
      = nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_23_nl[11:0];
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_4_24_10_lpi_3_dfm_14_3_mx0
      = MUX_v_12_2_2((z_out_2[14:3]), ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_23_nl,
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_3_24_13_lpi_3_dfm_11_2_mx0[9]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_4_24_10_lpi_3_dfm_0_mx0
      = MUX_s_1_2_2((z_out_2[0]), ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_3_25_13_lpi_3_dfm_0_mx0,
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_3_24_13_lpi_3_dfm_11_2_mx0[9]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_4_24_10_lpi_3_dfm_2_mx0
      = MUX_s_1_2_2((z_out_2[2]), (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_3_25_13_lpi_3_dfm_12_2_mx0[0]),
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_3_24_13_lpi_3_dfm_11_2_mx0[9]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_4_24_10_lpi_3_dfm_1_mx0
      = MUX_s_1_2_2((z_out_2[1]), ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_3_25_13_lpi_3_dfm_1_mx0,
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_3_24_13_lpi_3_dfm_11_2_mx0[9]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_4_25_10_lpi_3_dfm_15_3_mx0
      = MUX_v_13_2_2((z_out_4[12:0]), (z_out_4[15:3]), ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_3_24_13_lpi_3_dfm_11_2_mx0[9]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_4_25_10_lpi_3_dfm_0_mx0
      = MUX_s_1_2_2(ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_3_24_13_lpi_3_dfm_0_mx0,
      (z_out_4[0]), ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_3_24_13_lpi_3_dfm_11_2_mx0[9]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_4_25_10_lpi_3_dfm_2_mx0
      = MUX_s_1_2_2((ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_3_24_13_lpi_3_dfm_11_2_mx0[0]),
      (z_out_4[2]), ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_3_24_13_lpi_3_dfm_11_2_mx0[9]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_4_25_10_lpi_3_dfm_1_mx0
      = MUX_s_1_2_2(ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_3_24_13_lpi_3_dfm_1_mx0,
      (z_out_4[1]), ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_3_24_13_lpi_3_dfm_11_2_mx0[9]);
  assign nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_1_pmx_13_1_sva_1
      = ({ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_pmx_13_1_lpi_3_dfm_12_1_mx0_11_3
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_pmx_13_1_lpi_3_dfm_12_1_mx0_2
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_pmx_13_1_lpi_3_dfm_12_1_mx0_1
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_pmx_13_1_lpi_3_dfm_12_1_mx0_0
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_pmx_13_1_lpi_3_dfm_0_mx0})
      + 13'b1111100000001;
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_1_pmx_13_1_sva_1
      = nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_1_pmx_13_1_sva_1[12:0];
  assign nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_acc_8_nl
      = (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_1_pmx_13_1_lpi_3_dfm_12_1_mx0[11:6])
      + 6'b000001;
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_acc_8_nl
      = nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_acc_8_nl[5:0];
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_4_pmx_13_1_lpi_3_dfm_12_7_mx0
      = MUX_v_6_2_2(ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_acc_8_nl,
      (z_out_3[12:7]), ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_4_24_10_lpi_3_dfm_14_3_mx0[11]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_4_pmx_13_1_lpi_3_dfm_0_mx0
      = MUX_s_1_2_2(ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_1_pmx_13_1_lpi_3_dfm_0_mx0,
      (z_out_3[0]), ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_4_24_10_lpi_3_dfm_14_3_mx0[11]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_4_pmx_13_1_lpi_3_dfm_6_1_mx0
      = MUX_v_6_2_2((signext_6_5(ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_1_pmx_13_1_lpi_3_dfm_12_1_mx0[4:0])),
      (z_out_3[6:1]), ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_4_24_10_lpi_3_dfm_14_3_mx0[11]);
  assign nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_25_nl
      = ({1'b1 , (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_4_24_10_lpi_3_dfm_14_3_mx0[10:0])
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_4_24_10_lpi_3_dfm_2_mx0
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_4_24_10_lpi_3_dfm_1_mx0
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_4_24_10_lpi_3_dfm_0_mx0})
      + conv_u2s_12_15(ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_4_25_10_lpi_3_dfm_15_3_mx0[12:1]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_25_nl
      = nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_25_nl[14:0];
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_5_24_6_lpi_3_dfm_18_4_mx0
      = MUX_v_15_2_2((z_out_3[18:4]), ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_25_nl,
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_4_24_10_lpi_3_dfm_14_3_mx0[11]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_5_24_6_lpi_3_dfm_0_mx0
      = MUX_s_1_2_2((z_out_3[0]), ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_4_25_10_lpi_3_dfm_0_mx0,
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_4_24_10_lpi_3_dfm_14_3_mx0[11]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_5_24_6_lpi_3_dfm_3_mx0
      = MUX_s_1_2_2((z_out_3[3]), (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_4_25_10_lpi_3_dfm_15_3_mx0[0]),
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_4_24_10_lpi_3_dfm_14_3_mx0[11]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_5_24_6_lpi_3_dfm_1_mx0
      = MUX_s_1_2_2((z_out_3[1]), ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_4_25_10_lpi_3_dfm_1_mx0,
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_4_24_10_lpi_3_dfm_14_3_mx0[11]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_5_24_6_lpi_3_dfm_2_mx0
      = MUX_s_1_2_2((z_out_3[2]), ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_4_25_10_lpi_3_dfm_2_mx0,
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_4_24_10_lpi_3_dfm_14_3_mx0[11]);
  assign nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_acc_22_nl
      = ({ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_4_25_10_lpi_3_dfm_15_3_mx0
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_4_25_10_lpi_3_dfm_2_mx0
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_4_25_10_lpi_3_dfm_1_mx0
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_4_25_10_lpi_3_dfm_0_mx0})
      + conv_u2u_10_16(ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_4_24_10_lpi_3_dfm_14_3_mx0[10:1]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_acc_22_nl
      = nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_acc_22_nl[15:0];
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_5_25_6_lpi_3_dfm_19_4_mx0
      = MUX_v_16_2_2(ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_acc_22_nl,
      (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_5_25_6_sva_1[19:4]),
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_4_24_10_lpi_3_dfm_14_3_mx0[11]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_5_25_6_lpi_3_dfm_0_mx0
      = MUX_s_1_2_2(ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_4_24_10_lpi_3_dfm_0_mx0,
      (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_5_25_6_sva_1[0]),
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_4_24_10_lpi_3_dfm_14_3_mx0[11]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_5_25_6_lpi_3_dfm_3_mx0
      = MUX_s_1_2_2((ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_4_24_10_lpi_3_dfm_14_3_mx0[0]),
      (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_5_25_6_sva_1[3]),
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_4_24_10_lpi_3_dfm_14_3_mx0[11]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_5_25_6_lpi_3_dfm_1_mx0
      = MUX_s_1_2_2(ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_4_24_10_lpi_3_dfm_1_mx0,
      (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_5_25_6_sva_1[1]),
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_4_24_10_lpi_3_dfm_14_3_mx0[11]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_5_25_6_lpi_3_dfm_2_mx0
      = MUX_s_1_2_2(ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_4_24_10_lpi_3_dfm_2_mx0,
      (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_5_25_6_sva_1[2]),
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_4_24_10_lpi_3_dfm_14_3_mx0[11]);
  assign nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_5_25_6_sva_1
      = ({ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_4_25_10_lpi_3_dfm_15_3_mx0
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_4_25_10_lpi_3_dfm_2_mx0
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_4_25_10_lpi_3_dfm_1_mx0
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_4_25_10_lpi_3_dfm_0_mx0
      , 4'b0000}) + conv_u2u_14_20({(~ (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_4_24_10_lpi_3_dfm_14_3_mx0[10:0]))
      , (~ ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_4_24_10_lpi_3_dfm_2_mx0)
      , (~ ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_4_24_10_lpi_3_dfm_1_mx0)
      , (~ ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_4_24_10_lpi_3_dfm_0_mx0)})
      + 20'b00000000000000000001;
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_5_25_6_sva_1
      = nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_5_25_6_sva_1[19:0];
  assign nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_15_nl
      = ({ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_4_pmx_13_1_lpi_3_dfm_12_7_mx0
      , (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_4_pmx_13_1_lpi_3_dfm_6_1_mx0[5])})
      + 7'b1111111;
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_15_nl
      = nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_15_nl[6:0];
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_2_pmx_13_1_lpi_3_dfm_12_6_mx0
      = MUX_v_7_2_2((ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_2_pmx_13_1_sva_2[12:6]),
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_15_nl,
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_5_24_6_lpi_3_dfm_18_4_mx0[14]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_2_pmx_13_1_lpi_3_dfm_0_mx0
      = MUX_s_1_2_2((ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_2_pmx_13_1_sva_2[0]),
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_4_pmx_13_1_lpi_3_dfm_0_mx0,
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_5_24_6_lpi_3_dfm_18_4_mx0[14]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_2_pmx_13_1_lpi_3_dfm_5_1_mx0
      = MUX_v_5_2_2((ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_2_pmx_13_1_sva_2[5:1]),
      (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_4_pmx_13_1_lpi_3_dfm_6_1_mx0[4:0]),
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_5_24_6_lpi_3_dfm_18_4_mx0[14]);
  assign nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_26_nl
      = ({1'b1 , (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_5_24_6_lpi_3_dfm_18_4_mx0[13:0])
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_5_24_6_lpi_3_dfm_3_mx0
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_5_24_6_lpi_3_dfm_2_mx0
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_5_24_6_lpi_3_dfm_1_mx0
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_5_24_6_lpi_3_dfm_0_mx0})
      + conv_u2s_15_19(ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_5_25_6_lpi_3_dfm_19_4_mx0[15:1]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_26_nl
      = nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_26_nl[18:0];
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_6_24_1_lpi_3_dfm_23_5_mx0
      = MUX_v_19_2_2((z_out_5[24:6]), ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_26_nl,
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_5_24_6_lpi_3_dfm_18_4_mx0[14]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_6_24_1_lpi_3_dfm_0_mx0
      = MUX_s_1_2_2((z_out_5[1]), ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_5_25_6_lpi_3_dfm_0_mx0,
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_5_24_6_lpi_3_dfm_18_4_mx0[14]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_6_24_1_lpi_3_dfm_4_mx0
      = MUX_s_1_2_2((z_out_5[5]), (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_5_25_6_lpi_3_dfm_19_4_mx0[0]),
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_5_24_6_lpi_3_dfm_18_4_mx0[14]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_6_24_1_lpi_3_dfm_1_mx0
      = MUX_s_1_2_2((z_out_5[2]), ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_5_25_6_lpi_3_dfm_1_mx0,
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_5_24_6_lpi_3_dfm_18_4_mx0[14]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_6_24_1_lpi_3_dfm_3_mx0
      = MUX_s_1_2_2((z_out_5[4]), ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_5_25_6_lpi_3_dfm_3_mx0,
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_5_24_6_lpi_3_dfm_18_4_mx0[14]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_6_24_1_lpi_3_dfm_2_mx0
      = MUX_s_1_2_2((z_out_5[3]), ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_5_25_6_lpi_3_dfm_2_mx0,
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_5_24_6_lpi_3_dfm_18_4_mx0[14]);
  assign nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_acc_24_nl
      = ({ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_5_25_6_lpi_3_dfm_19_4_mx0
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_5_25_6_lpi_3_dfm_3_mx0
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_5_25_6_lpi_3_dfm_2_mx0
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_5_25_6_lpi_3_dfm_1_mx0
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_5_25_6_lpi_3_dfm_0_mx0})
      + conv_u2u_13_20(ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_5_24_6_lpi_3_dfm_18_4_mx0[13:1]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_acc_24_nl
      = nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_acc_24_nl[19:0];
  assign nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_6_if_acc_nl
      = ({ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_5_25_6_lpi_3_dfm_19_4_mx0
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_5_25_6_lpi_3_dfm_3_mx0
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_5_25_6_lpi_3_dfm_2_mx0
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_5_25_6_lpi_3_dfm_1_mx0
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_5_25_6_lpi_3_dfm_0_mx0
      , 6'b000000}) + conv_u2u_19_26({(~ (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_5_24_6_lpi_3_dfm_18_4_mx0[13:0]))
      , (~ ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_5_24_6_lpi_3_dfm_3_mx0)
      , (~ ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_5_24_6_lpi_3_dfm_2_mx0)
      , (~ ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_5_24_6_lpi_3_dfm_1_mx0)
      , (~ ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_5_24_6_lpi_3_dfm_0_mx0)
      , 1'b1}) + 26'b00000000000000000000000001;
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_6_if_acc_nl
      = nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_6_if_acc_nl[25:0];
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_25_6_lpi_3_dfm_mx0
      = MUX_v_20_2_2(ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_acc_24_nl,
      (readslicef_26_20_6(ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_6_if_acc_nl)),
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_5_24_6_lpi_3_dfm_18_4_mx0[14]);
  assign nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_2_pmx_13_1_sva_2
      = ({ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_4_pmx_13_1_lpi_3_dfm_12_7_mx0
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_4_pmx_13_1_lpi_3_dfm_6_1_mx0
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_4_pmx_13_1_lpi_3_dfm_0_mx0})
      + 13'b0000000111111;
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_2_pmx_13_1_sva_2
      = nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_2_pmx_13_1_sva_2[12:0];
  assign nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_acc_11_nl
      = ({ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_2_pmx_13_1_lpi_3_dfm_12_6_mx0
      , (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_2_pmx_13_1_lpi_3_dfm_5_1_mx0[4])})
      + 8'b00000001;
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_acc_11_nl
      = nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_acc_11_nl[7:0];
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_5_pmx_13_1_lpi_3_dfm_12_5_mx0
      = MUX_v_8_2_2(ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_acc_11_nl,
      (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_5_pmx_13_1_sva_1[12:5]),
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_6_24_1_lpi_3_dfm_23_5_mx0[18]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_5_pmx_13_1_lpi_3_dfm_0_mx0
      = MUX_s_1_2_2(ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_2_pmx_13_1_lpi_3_dfm_0_mx0,
      (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_5_pmx_13_1_sva_1[0]),
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_6_24_1_lpi_3_dfm_23_5_mx0[18]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_5_pmx_13_1_lpi_3_dfm_4_1_mx0
      = MUX_v_4_2_2((ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_2_pmx_13_1_lpi_3_dfm_5_1_mx0[3:0]),
      (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_5_pmx_13_1_sva_1[4:1]),
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_6_24_1_lpi_3_dfm_23_5_mx0[18]);
  assign nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_3_pmx_13_1_sva_2
      = ({ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_5_pmx_13_1_lpi_3_dfm_12_5_mx0
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_5_pmx_13_1_lpi_3_dfm_4_1_mx0
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_5_pmx_13_1_lpi_3_dfm_0_mx0})
      + 13'b0000000001111;
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_3_pmx_13_1_sva_2
      = nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_3_pmx_13_1_sva_2[12:0];
  assign nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_7_else_acc_1_nl
      = conv_u2s_24_25({(ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_6_24_1_lpi_3_dfm_23_5_mx0[17:0])
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_6_24_1_lpi_3_dfm_4_mx0
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_6_24_1_lpi_3_dfm_3_mx0
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_6_24_1_lpi_3_dfm_2_mx0
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_6_24_1_lpi_3_dfm_1_mx0
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_6_24_1_lpi_3_dfm_0_mx0
      , 1'b0}) + conv_s2s_21_25({1'b1 , (~ ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_25_6_lpi_3_dfm_mx0)})
      + 25'b0000000000000000000000001;
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_7_else_acc_1_nl
      = nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_7_else_acc_1_nl[24:0];
  assign nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_27_nl
      = ({1'b1 , (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_6_24_1_lpi_3_dfm_23_5_mx0[17:0])
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_6_24_1_lpi_3_dfm_4_mx0
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_6_24_1_lpi_3_dfm_3_mx0
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_6_24_1_lpi_3_dfm_2_mx0
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_6_24_1_lpi_3_dfm_1_mx0
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_6_24_1_lpi_3_dfm_0_mx0})
      + conv_u2s_19_24(ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_25_6_lpi_3_dfm_mx0[19:1]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_27_nl
      = nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_27_nl[23:0];
  assign mux_cse = MUX_s_1_2_2((readslicef_25_1_24(ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_7_else_acc_1_nl)),
      (readslicef_24_1_23(ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_27_nl)),
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_6_24_1_lpi_3_dfm_23_5_mx0[18]);
  assign nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_21_nl
      = ({ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_5_pmx_13_1_lpi_3_dfm_12_5_mx0
      , (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_5_pmx_13_1_lpi_3_dfm_4_1_mx0[3])})
      + 9'b111111111;
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_21_nl
      = nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_21_nl[8:0];
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_3_pmx_13_1_lpi_3_dfm_12_4_mx0
      = MUX_v_9_2_2((ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_3_pmx_13_1_sva_2[12:4]),
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_acc_21_nl,
      mux_cse);
  assign nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_5_pmx_13_1_sva_1
      = ({ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_2_pmx_13_1_lpi_3_dfm_12_6_mx0
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_2_pmx_13_1_lpi_3_dfm_5_1_mx0
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_2_pmx_13_1_lpi_3_dfm_0_mx0})
      + 13'b1111111100001;
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_5_pmx_13_1_sva_1
      = nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_5_pmx_13_1_sva_1[12:0];
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_mux_21_nl
      = MUX_v_3_2_2((ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_3_pmx_13_1_sva_2[3:1]),
      (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_5_pmx_13_1_lpi_3_dfm_4_1_mx0[2:0]),
      mux_cse);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_mux_55_nl
      = MUX_s_1_2_2((ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_3_pmx_13_1_sva_2[0]),
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_5_pmx_13_1_lpi_3_dfm_0_mx0,
      mux_cse);
  assign nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_else_else_if_acc_nl
      = ({(dy_in_rsci_idat_mxwt[8]) , (~ (dy_in_rsci_idat_mxwt[8])) , (~ (dy_in_rsci_idat_mxwt[8]))
      , (dy_in_rsci_idat_mxwt[8]) , (dy_in_rsci_idat_mxwt[8]) , (~ (dy_in_rsci_idat_mxwt[8]))
      , (dy_in_rsci_idat_mxwt[8]) , (dy_in_rsci_idat_mxwt[8]) , (~ (dy_in_rsci_idat_mxwt[8]))
      , (dy_in_rsci_idat_mxwt[8]) , (dy_in_rsci_idat_mxwt[8]) , (dy_in_rsci_idat_mxwt[8])
      , (dy_in_rsci_idat_mxwt[8]) , (~ (dy_in_rsci_idat_mxwt[8])) , (~ (dy_in_rsci_idat_mxwt[8]))
      , (~ (dy_in_rsci_idat_mxwt[8]))}) + conv_s2s_15_16({(~ ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_3_pmx_13_1_lpi_3_dfm_12_4_mx0)
      , (~ ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_mux_21_nl)
      , (~ ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_mux_55_nl)
      , 2'b01}) + 16'b0000000000000001;
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_else_else_if_acc_nl
      = nl_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_else_else_if_acc_nl[15:0];
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_else_else_if_acc_itm_15_8_1
      = readslicef_16_8_8(ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_else_else_if_acc_nl);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_else_unequal_tmp_1
      = (dx_in_rsci_idat_mxwt!=9'b000000000);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_unequal_tmp_1
      = (dy_in_rsci_idat_mxwt!=9'b000000000);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_and_ssc_1
      = (~ ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_else_unequal_tmp_1)
      & ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_unequal_tmp_1;
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_and_2_ssc_1
      = (~ (dx_in_rsci_idat_mxwt[8])) & ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_and_1_m1c_1;
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_and_3_ssc_1
      = (dx_in_rsci_idat_mxwt[8]) & ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_and_1_m1c_1;
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_and_1_m1c_1
      = ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_else_unequal_tmp_1
      & ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_unequal_tmp_1;
  assign MCOL_mul_nl = $signed((dx_in_rsci_idat_mxwt)) * $signed((dx_in_rsci_idat_mxwt));
  assign MCOL_mul_1_nl = $signed((dy_in_rsci_idat_mxwt)) * $signed((dy_in_rsci_idat_mxwt));
  assign nl_sum_sva_1 = conv_u2u_18_19(MCOL_mul_nl) + conv_u2u_18_19(MCOL_mul_1_nl);
  assign sum_sva_1 = nl_sum_sva_1[18:0];
  assign MROW_equal_tmp = MROW_y_sva == (z_out_5[9:0]);
  assign and_11_cse = MROW_equal_tmp & (fsm_output[2]);
  assign or_tmp_20 = (dy_in_rsci_idat_mxwt[8]) & (fsm_output[1]);
  assign or_tmp_24 = (~ (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_4_24_10_lpi_3_dfm_14_3_mx0[11]))
      & (fsm_output[1]);
  assign or_tmp_26 = (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_3_24_13_lpi_3_dfm_11_2_mx0[9])
      & (fsm_output[1]);
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      reg_dy_in_rsci_oswt_cse <= 1'b0;
      MCOL_stage_0 <= 1'b0;
      reg_magn_rsci_oswt_cse <= 1'b0;
      reg_widthIn_triosy_obj_iswt0_cse <= 1'b0;
    end
    else if ( rst ) begin
      reg_dy_in_rsci_oswt_cse <= 1'b0;
      MCOL_stage_0 <= 1'b0;
      reg_magn_rsci_oswt_cse <= 1'b0;
      reg_widthIn_triosy_obj_iswt0_cse <= 1'b0;
    end
    else if ( run_wen ) begin
      reg_dy_in_rsci_oswt_cse <= ~((fsm_output[3]) | ((~(nand_cse & MCOL_stage_0))
          & (fsm_output[1])) | and_11_cse);
      MCOL_stage_0 <= (MCOL_stage_0 & nand_cse) | MROW_y_or_cse;
      reg_magn_rsci_oswt_cse <= MCOL_stage_0 & (fsm_output[1]);
      reg_widthIn_triosy_obj_iswt0_cse <= and_11_cse;
    end
  end
  always @(posedge clk) begin
    if ( MCOL_and_cse ) begin
      magn_rsci_idat <= MUX_v_9_2_2(9'b000000000, (operator_33_9_false_AC_TRN_AC_WRAP_lshift_itm[32:24]),
          ac_math_ac_normalize_19_19_false_AC_TRN_AC_WRAP_expret_unequal_tmp_1);
      angle_rsci_idat_3 <= ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_mux1h_nl
          & ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_unequal_tmp_1;
      angle_rsci_idat_2 <= MUX1HOT_s_1_4_2((dx_in_rsci_idat_mxwt[8]), (dy_in_rsci_idat_mxwt[8]),
          (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_3_pmx_13_1_lpi_3_dfm_12_4_mx0[4]),
          (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_else_else_if_acc_itm_15_8_1[2]),
          {(~ ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_unequal_tmp_1)
          , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_and_ssc_1
          , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_and_2_ssc_1
          , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_and_3_ssc_1});
      angle_rsci_idat_4 <= ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_mux1h_2_nl
          & ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_unequal_tmp_1;
      angle_rsci_idat_1 <= ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_mux1h_3_nl
          & ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_unequal_tmp_1;
      angle_rsci_idat_5 <= MUX1HOT_s_1_4_2((dx_in_rsci_idat_mxwt[8]), (~ (dy_in_rsci_idat_mxwt[8])),
          (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_3_pmx_13_1_lpi_3_dfm_12_4_mx0[7]),
          (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_else_else_if_acc_itm_15_8_1[5]),
          {(~ ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_unequal_tmp_1)
          , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_and_ssc_1
          , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_and_2_ssc_1
          , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_and_3_ssc_1});
      angle_rsci_idat_0 <= ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_mux1h_5_nl
          & ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_unequal_tmp_1;
      angle_rsci_idat_7 <= ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_mux1h_6_nl
          & ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_unequal_tmp_1;
      angle_rsci_idat_6 <= MUX1HOT_s_1_4_2((dx_in_rsci_idat_mxwt[8]), (dy_in_rsci_idat_mxwt[8]),
          (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_3_pmx_13_1_lpi_3_dfm_12_4_mx0[8]),
          (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_else_else_if_acc_itm_15_8_1[6]),
          {(~ ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_unequal_tmp_1)
          , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_and_ssc_1
          , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_and_2_ssc_1
          , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_and_3_ssc_1});
    end
  end
  always @(posedge clk) begin
    if ( run_wen & MROW_y_or_cse ) begin
      MROW_y_sva <= MUX_v_10_2_2(10'b0000000000, (z_out_2[9:0]), MROW_y_not_1_nl);
    end
  end
  always @(posedge clk) begin
    if ( run_wen & (MCOL_stage_0 | MROW_y_or_cse) ) begin
      MCOL_x_sva <= MUX_v_11_2_2(11'b00000000000, MCOL_acc_1_nl, not_85_nl);
    end
  end
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_mux1h_nl
      = MUX1HOT_s_1_3_2((dy_in_rsci_idat_mxwt[8]), (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_3_pmx_13_1_lpi_3_dfm_12_4_mx0[5]),
      (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_else_else_if_acc_itm_15_8_1[3]),
      {ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_and_ssc_1
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_and_2_ssc_1
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_and_3_ssc_1});
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_mux1h_2_nl
      = MUX1HOT_s_1_3_2((~ (dy_in_rsci_idat_mxwt[8])), (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_3_pmx_13_1_lpi_3_dfm_12_4_mx0[6]),
      (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_else_else_if_acc_itm_15_8_1[4]),
      {ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_and_ssc_1
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_and_2_ssc_1
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_and_3_ssc_1});
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_mux1h_3_nl
      = MUX1HOT_s_1_3_2((~ (dy_in_rsci_idat_mxwt[8])), (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_3_pmx_13_1_lpi_3_dfm_12_4_mx0[3]),
      (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_else_else_if_acc_itm_15_8_1[1]),
      {ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_and_ssc_1
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_and_2_ssc_1
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_and_3_ssc_1});
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_mux1h_5_nl
      = MUX1HOT_s_1_3_2((dy_in_rsci_idat_mxwt[8]), (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_3_pmx_13_1_lpi_3_dfm_12_4_mx0[2]),
      (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_else_else_if_acc_itm_15_8_1[0]),
      {ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_and_ssc_1
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_and_2_ssc_1
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_and_3_ssc_1});
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_mux1h_6_nl
      = MUX1HOT_s_1_3_2((dy_in_rsci_idat_mxwt[8]), (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_3_pmx_13_1_lpi_3_dfm_12_4_mx0[8]),
      (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_else_else_if_acc_itm_15_8_1[7]),
      {ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_and_ssc_1
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_and_2_ssc_1
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_and_3_ssc_1});
  assign MROW_y_not_1_nl = ~ (fsm_output[0]);
  assign nl_MCOL_acc_1_nl = MCOL_x_sva + 11'b00000000001;
  assign MCOL_acc_1_nl = nl_MCOL_acc_1_nl[10:0];
  assign not_85_nl = ~ MROW_y_or_cse;
  assign and_66_nl = (~ (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_1_24_16_lpi_3_dfm_mx0[8]))
      & (fsm_output[1]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_mux_37_nl
      = MUX_v_6_2_2(6'b100010, 6'b011101, and_66_nl);
  assign nl_z_out = conv_s2u_8_9({(dy_in_rsci_idat_mxwt[8]) , (~ (dy_in_rsci_idat_mxwt[8]))
      , (~ (dy_in_rsci_idat_mxwt[8])) , (dy_in_rsci_idat_mxwt[8]) , (dy_in_rsci_idat_mxwt[8])
      , (~ (dy_in_rsci_idat_mxwt[8])) , (dy_in_rsci_idat_mxwt[8]) , (dy_in_rsci_idat_mxwt[8])})
      + conv_s2u_7_9({ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_mux_37_nl
      , 1'b1});
  assign z_out = nl_z_out[8:0];
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_or_3_nl
      = (~((~ (dy_in_rsci_idat_mxwt[8])) & (fsm_output[1]))) | or_tmp_20;
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_mux_21_nl
      = MUX_v_8_2_2((dy_in_rsci_idat_mxwt[7:0]), (~ (dy_in_rsci_idat_mxwt[7:0])),
      or_tmp_20);
  assign nl_acc_1_nl = conv_u2u_10_11({ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_qr_24_16_lpi_3_dfm_mx0_8
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_qr_24_16_lpi_3_dfm_mx0_7_0
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_or_3_nl})
      + conv_u2u_9_11({ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_mux_21_nl
      , 1'b1});
  assign acc_1_nl = nl_acc_1_nl[10:0];
  assign z_out_1 = readslicef_11_10_1(acc_1_nl);
  assign MROW_MROW_and_4_nl = MUX_v_4_2_2(4'b0000, (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_3_24_13_lpi_3_dfm_11_2_mx0[8:5]),
      (fsm_output[1]));
  assign MROW_mux_8_nl = MUX_v_5_2_2((MROW_y_sva[9:5]), (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_3_24_13_lpi_3_dfm_11_2_mx0[4:0]),
      fsm_output[1]);
  assign MROW_mux_9_nl = MUX_s_1_2_2((MROW_y_sva[4]), ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_3_24_13_lpi_3_dfm_1_mx0,
      fsm_output[1]);
  assign MROW_mux_10_nl = MUX_s_1_2_2((MROW_y_sva[3]), ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_3_24_13_lpi_3_dfm_0_mx0,
      fsm_output[1]);
  assign MROW_not_3_nl = ~ (fsm_output[1]);
  assign MROW_MROW_and_5_nl = MUX_v_3_2_2(3'b000, (MROW_y_sva[2:0]), MROW_not_3_nl);
  assign MROW_not_4_nl = ~ (fsm_output[1]);
  assign MROW_MROW_MROW_nor_1_nl = ~(MUX_v_11_2_2(ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_3_25_13_lpi_3_dfm_12_2_mx0,
      11'b11111111111, MROW_not_4_nl));
  assign MROW_MROW_and_6_nl = (~ ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_3_25_13_lpi_3_dfm_1_mx0)
      & (fsm_output[1]);
  assign MROW_MROW_MROW_nand_1_nl = ~(ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_3_25_13_lpi_3_dfm_0_mx0
      & (fsm_output[1]));
  assign nl_acc_2_nl = conv_u2u_15_16({MROW_MROW_and_4_nl , MROW_mux_8_nl , MROW_mux_9_nl
      , MROW_mux_10_nl , MROW_MROW_and_5_nl , (~ (fsm_output[2]))}) + conv_s2u_15_16({(fsm_output[1])
      , MROW_MROW_MROW_nor_1_nl , MROW_MROW_and_6_nl , MROW_MROW_MROW_nand_1_nl ,
      1'b1});
  assign acc_2_nl = nl_acc_2_nl[15:0];
  assign z_out_2 = readslicef_16_15_1(acc_2_nl);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_mux_38_nl
      = MUX_v_11_2_2((signext_11_6(ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_1_pmx_13_1_lpi_3_dfm_12_1_mx0[11:6])),
      (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_4_24_10_lpi_3_dfm_14_3_mx0[10:0]),
      or_tmp_24);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_mux_39_nl
      = MUX_s_1_2_2((ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_1_pmx_13_1_lpi_3_dfm_12_1_mx0[5]),
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_4_24_10_lpi_3_dfm_2_mx0,
      or_tmp_24);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_mux_40_nl
      = MUX_s_1_2_2((ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_1_pmx_13_1_lpi_3_dfm_12_1_mx0[4]),
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_4_24_10_lpi_3_dfm_1_mx0,
      or_tmp_24);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_mux_41_nl
      = MUX_s_1_2_2((ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_1_pmx_13_1_lpi_3_dfm_12_1_mx0[3]),
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_4_24_10_lpi_3_dfm_0_mx0,
      or_tmp_24);
  assign not_94_nl = ~ or_tmp_24;
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_and_6_nl
      = MUX_v_3_2_2(3'b000, (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_1_pmx_13_1_lpi_3_dfm_12_1_mx0[2:0]),
      not_94_nl);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_and_7_nl
      = ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_conc_1_pmx_13_1_lpi_3_dfm_0_mx0
      & (~ or_tmp_24);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_or_1_nl
      = (~((ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_4_24_10_lpi_3_dfm_14_3_mx0[11])
      & (fsm_output[1]))) | or_tmp_24;
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_mux_42_nl
      = MUX_v_13_2_2(13'b1111111110000, (~ ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_4_25_10_lpi_3_dfm_15_3_mx0),
      or_tmp_24);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_and_8_nl
      = (~ ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_4_25_10_lpi_3_dfm_2_mx0)
      & or_tmp_24;
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_and_9_nl
      = (~ ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_4_25_10_lpi_3_dfm_1_mx0)
      & or_tmp_24;
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_A000000
      = ~(ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_4_25_10_lpi_3_dfm_0_mx0
      & or_tmp_24);
  assign nl_acc_3_nl = conv_u2u_19_20({ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_mux_38_nl
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_mux_39_nl
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_mux_40_nl
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_mux_41_nl
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_and_6_nl
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_and_7_nl
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_or_1_nl})
      + conv_s2u_18_20({1'b1 , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_mux_42_nl
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_and_8_nl
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_and_9_nl
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_if_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_A000000
      , 1'b1});
  assign acc_3_nl = nl_acc_3_nl[19:0];
  assign z_out_3 = readslicef_20_19_1(acc_3_nl);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_and_6_nl
      = MUX_v_3_2_2(3'b000, (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_3_25_13_lpi_3_dfm_12_2_mx0[10:8]),
      or_tmp_26);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_mux_22_nl
      = MUX_v_8_2_2((ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_3_25_13_lpi_3_dfm_12_2_mx0[10:3]),
      (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_3_25_13_lpi_3_dfm_12_2_mx0[7:0]),
      or_tmp_26);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_mux_23_nl
      = MUX_s_1_2_2((ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_3_25_13_lpi_3_dfm_12_2_mx0[2]),
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_3_25_13_lpi_3_dfm_1_mx0,
      or_tmp_26);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_mux_24_nl
      = MUX_s_1_2_2((ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_3_25_13_lpi_3_dfm_12_2_mx0[1]),
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_3_25_13_lpi_3_dfm_0_mx0,
      or_tmp_26);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_and_7_nl
      = (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_3_25_13_lpi_3_dfm_12_2_mx0[0])
      & (~ or_tmp_26);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_and_8_nl
      = ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_3_25_13_lpi_3_dfm_1_mx0
      & (~ or_tmp_26);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_and_9_nl
      = ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_3_25_13_lpi_3_dfm_0_mx0
      & (~ or_tmp_26);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_or_4_nl
      = (~((~ (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_3_24_13_lpi_3_dfm_11_2_mx0[9]))
      & (fsm_output[1]))) | or_tmp_26;
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_not_3_nl
      = ~ or_tmp_26;
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_nor_1_nl
      = ~(MUX_v_3_2_2((ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_3_24_13_lpi_3_dfm_11_2_mx0[8:6]),
      3'b111, ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_not_3_nl));
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_mux_25_nl
      = MUX_v_6_2_2((ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_3_24_13_lpi_3_dfm_11_2_mx0[8:3]),
      (~ (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_3_24_13_lpi_3_dfm_11_2_mx0[5:0])),
      or_tmp_26);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_mux_26_nl
      = MUX_s_1_2_2((ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_3_24_13_lpi_3_dfm_11_2_mx0[2]),
      (~ ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_3_24_13_lpi_3_dfm_1_mx0),
      or_tmp_26);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_mux_27_nl
      = MUX_s_1_2_2((ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_3_24_13_lpi_3_dfm_11_2_mx0[1]),
      (~ ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_3_24_13_lpi_3_dfm_0_mx0),
      or_tmp_26);
  assign nl_acc_4_nl = ({ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_and_6_nl
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_mux_22_nl
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_mux_23_nl
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_mux_24_nl
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_and_7_nl
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_and_8_nl
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_and_9_nl
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_or_4_nl})
      + conv_u2u_12_17({ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_nor_1_nl
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_mux_25_nl
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_mux_26_nl
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_mux_27_nl
      , 1'b1});
  assign acc_4_nl = nl_acc_4_nl[16:0];
  assign z_out_4 = readslicef_17_16_1(acc_4_nl);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_not_4_nl
      = ~ (fsm_output[2]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_and_10_nl
      = MUX_v_14_2_2(14'b00000000000000, (ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_5_24_6_lpi_3_dfm_18_4_mx0[13:0]),
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_not_4_nl);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_mux_28_nl
      = MUX_s_1_2_2(ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_5_24_6_lpi_3_dfm_3_mx0,
      (heightIn_rsci_idat[9]), fsm_output[2]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_mux_29_nl
      = MUX_s_1_2_2(ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_5_24_6_lpi_3_dfm_2_mx0,
      (heightIn_rsci_idat[8]), fsm_output[2]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_mux_30_nl
      = MUX_s_1_2_2(ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_5_24_6_lpi_3_dfm_1_mx0,
      (heightIn_rsci_idat[7]), fsm_output[2]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_mux_31_nl
      = MUX_s_1_2_2(ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_y1_5_24_6_lpi_3_dfm_0_mx0,
      (heightIn_rsci_idat[6]), fsm_output[2]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_and_11_nl
      = MUX_v_6_2_2(6'b000000, (heightIn_rsci_idat[5:0]), (fsm_output[2]));
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_not_5_nl
      = ~ (fsm_output[2]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9000000
      = ~(MUX_v_16_2_2(16'b0000000000000000, ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_5_25_6_lpi_3_dfm_19_4_mx0,
      ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_not_5_nl));
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_or_5_nl
      = (~ ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_5_25_6_lpi_3_dfm_3_mx0)
      | (fsm_output[2]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_or_6_nl
      = (~ ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_5_25_6_lpi_3_dfm_2_mx0)
      | (fsm_output[2]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_or_7_nl
      = (~ ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_5_25_6_lpi_3_dfm_1_mx0)
      | (fsm_output[2]);
  assign ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_or_8_nl
      = (~ ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_x1_5_25_6_lpi_3_dfm_0_mx0)
      | (fsm_output[2]);
  assign nl_acc_5_nl = conv_u2u_25_26({ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_and_10_nl
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_mux_28_nl
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_mux_29_nl
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_mux_30_nl
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_mux_31_nl
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_and_11_nl
      , (~ (fsm_output[2]))}) + conv_s2u_23_26({1'b1 , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9000000
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_or_5_nl
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_or_6_nl
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_or_7_nl
      , ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_ac_math_ac_atan2_cordic_9_9_AC_TRN_AC_WRAP_9_9_AC_TRN_AC_WRAP_8_3_AC_TRN_AC_WRAP_for_else_or_8_nl
      , 2'b11});
  assign acc_5_nl = nl_acc_5_nl[25:0];
  assign z_out_5 = readslicef_26_25_1(acc_5_nl);

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


  function automatic  MUX1HOT_s_1_4_2;
    input  input_3;
    input  input_2;
    input  input_1;
    input  input_0;
    input [3:0] sel;
    reg  result;
  begin
    result = input_0 & sel[0];
    result = result | (input_1 & sel[1]);
    result = result | (input_2 & sel[2]);
    result = result | (input_3 & sel[3]);
    MUX1HOT_s_1_4_2 = result;
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


  function automatic [9:0] MUX_v_10_4_2;
    input [9:0] input_0;
    input [9:0] input_1;
    input [9:0] input_2;
    input [9:0] input_3;
    input [1:0] sel;
    reg [9:0] result;
  begin
    case (sel)
      2'b00 : begin
        result = input_0;
      end
      2'b01 : begin
        result = input_1;
      end
      2'b10 : begin
        result = input_2;
      end
      default : begin
        result = input_3;
      end
    endcase
    MUX_v_10_4_2 = result;
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


  function automatic [11:0] MUX_v_12_2_2;
    input [11:0] input_0;
    input [11:0] input_1;
    input  sel;
    reg [11:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_12_2_2 = result;
  end
  endfunction


  function automatic [12:0] MUX_v_13_2_2;
    input [12:0] input_0;
    input [12:0] input_1;
    input  sel;
    reg [12:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_13_2_2 = result;
  end
  endfunction


  function automatic [13:0] MUX_v_14_2_2;
    input [13:0] input_0;
    input [13:0] input_1;
    input  sel;
    reg [13:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_14_2_2 = result;
  end
  endfunction


  function automatic [14:0] MUX_v_15_2_2;
    input [14:0] input_0;
    input [14:0] input_1;
    input  sel;
    reg [14:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_15_2_2 = result;
  end
  endfunction


  function automatic [15:0] MUX_v_16_2_2;
    input [15:0] input_0;
    input [15:0] input_1;
    input  sel;
    reg [15:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_16_2_2 = result;
  end
  endfunction


  function automatic [18:0] MUX_v_19_2_2;
    input [18:0] input_0;
    input [18:0] input_1;
    input  sel;
    reg [18:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_19_2_2 = result;
  end
  endfunction


  function automatic [19:0] MUX_v_20_2_2;
    input [19:0] input_0;
    input [19:0] input_1;
    input  sel;
    reg [19:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_20_2_2 = result;
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


  function automatic [4:0] MUX_v_5_2_2;
    input [4:0] input_0;
    input [4:0] input_1;
    input  sel;
    reg [4:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_5_2_2 = result;
  end
  endfunction


  function automatic [5:0] MUX_v_6_2_2;
    input [5:0] input_0;
    input [5:0] input_1;
    input  sel;
    reg [5:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_6_2_2 = result;
  end
  endfunction


  function automatic [5:0] MUX_v_6_4_2;
    input [5:0] input_0;
    input [5:0] input_1;
    input [5:0] input_2;
    input [5:0] input_3;
    input [1:0] sel;
    reg [5:0] result;
  begin
    case (sel)
      2'b00 : begin
        result = input_0;
      end
      2'b01 : begin
        result = input_1;
      end
      2'b10 : begin
        result = input_2;
      end
      default : begin
        result = input_3;
      end
    endcase
    MUX_v_6_4_2 = result;
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


  function automatic [9:0] readslicef_11_10_1;
    input [10:0] vector;
    reg [10:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_11_10_1 = tmp[9:0];
  end
  endfunction


  function automatic [14:0] readslicef_16_15_1;
    input [15:0] vector;
    reg [15:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_16_15_1 = tmp[14:0];
  end
  endfunction


  function automatic [7:0] readslicef_16_8_8;
    input [15:0] vector;
    reg [15:0] tmp;
  begin
    tmp = vector >> 8;
    readslicef_16_8_8 = tmp[7:0];
  end
  endfunction


  function automatic [15:0] readslicef_17_16_1;
    input [16:0] vector;
    reg [16:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_17_16_1 = tmp[15:0];
  end
  endfunction


  function automatic [18:0] readslicef_20_19_1;
    input [19:0] vector;
    reg [19:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_20_19_1 = tmp[18:0];
  end
  endfunction


  function automatic [0:0] readslicef_24_1_23;
    input [23:0] vector;
    reg [23:0] tmp;
  begin
    tmp = vector >> 23;
    readslicef_24_1_23 = tmp[0:0];
  end
  endfunction


  function automatic [0:0] readslicef_25_1_24;
    input [24:0] vector;
    reg [24:0] tmp;
  begin
    tmp = vector >> 24;
    readslicef_25_1_24 = tmp[0:0];
  end
  endfunction


  function automatic [22:0] readslicef_25_23_2;
    input [24:0] vector;
    reg [24:0] tmp;
  begin
    tmp = vector >> 2;
    readslicef_25_23_2 = tmp[22:0];
  end
  endfunction


  function automatic [19:0] readslicef_26_20_6;
    input [25:0] vector;
    reg [25:0] tmp;
  begin
    tmp = vector >> 6;
    readslicef_26_20_6 = tmp[19:0];
  end
  endfunction


  function automatic [24:0] readslicef_26_25_1;
    input [25:0] vector;
    reg [25:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_26_25_1 = tmp[24:0];
  end
  endfunction


  function automatic [22:0] readslicef_27_23_4;
    input [26:0] vector;
    reg [26:0] tmp;
  begin
    tmp = vector >> 4;
    readslicef_27_23_4 = tmp[22:0];
  end
  endfunction


  function automatic [10:0] signext_11_6;
    input [5:0] vector;
  begin
    signext_11_6= {{5{vector[5]}}, vector};
  end
  endfunction


  function automatic [1:0] signext_2_1;
    input  vector;
  begin
    signext_2_1= {{1{vector}}, vector};
  end
  endfunction


  function automatic [2:0] signext_3_2;
    input [1:0] vector;
  begin
    signext_3_2= {{1{vector[1]}}, vector};
  end
  endfunction


  function automatic [3:0] signext_4_3;
    input [2:0] vector;
  begin
    signext_4_3= {{1{vector[2]}}, vector};
  end
  endfunction


  function automatic [5:0] signext_6_5;
    input [4:0] vector;
  begin
    signext_6_5= {{1{vector[4]}}, vector};
  end
  endfunction


  function automatic [15:0] conv_s2s_15_16 ;
    input [14:0]  vector ;
  begin
    conv_s2s_15_16 = {vector[14], vector};
  end
  endfunction


  function automatic [24:0] conv_s2s_21_25 ;
    input [20:0]  vector ;
  begin
    conv_s2s_21_25 = {{4{vector[20]}}, vector};
  end
  endfunction


  function automatic [8:0] conv_s2u_7_9 ;
    input [6:0]  vector ;
  begin
    conv_s2u_7_9 = {{2{vector[6]}}, vector};
  end
  endfunction


  function automatic [8:0] conv_s2u_8_9 ;
    input [7:0]  vector ;
  begin
    conv_s2u_8_9 = {vector[7], vector};
  end
  endfunction


  function automatic [15:0] conv_s2u_15_16 ;
    input [14:0]  vector ;
  begin
    conv_s2u_15_16 = {vector[14], vector};
  end
  endfunction


  function automatic [19:0] conv_s2u_18_20 ;
    input [17:0]  vector ;
  begin
    conv_s2u_18_20 = {{2{vector[17]}}, vector};
  end
  endfunction


  function automatic [25:0] conv_s2u_23_26 ;
    input [22:0]  vector ;
  begin
    conv_s2u_23_26 = {{3{vector[22]}}, vector};
  end
  endfunction


  function automatic [8:0] conv_u2s_8_9 ;
    input [7:0]  vector ;
  begin
    conv_u2s_8_9 =  {1'b0, vector};
  end
  endfunction


  function automatic [9:0] conv_u2s_9_10 ;
    input [8:0]  vector ;
  begin
    conv_u2s_9_10 =  {1'b0, vector};
  end
  endfunction


  function automatic [11:0] conv_u2s_10_12 ;
    input [9:0]  vector ;
  begin
    conv_u2s_10_12 = {{2{1'b0}}, vector};
  end
  endfunction


  function automatic [11:0] conv_u2s_11_12 ;
    input [10:0]  vector ;
  begin
    conv_u2s_11_12 =  {1'b0, vector};
  end
  endfunction


  function automatic [14:0] conv_u2s_12_15 ;
    input [11:0]  vector ;
  begin
    conv_u2s_12_15 = {{3{1'b0}}, vector};
  end
  endfunction


  function automatic [18:0] conv_u2s_15_19 ;
    input [14:0]  vector ;
  begin
    conv_u2s_15_19 = {{4{1'b0}}, vector};
  end
  endfunction


  function automatic [23:0] conv_u2s_19_24 ;
    input [18:0]  vector ;
  begin
    conv_u2s_19_24 = {{5{1'b0}}, vector};
  end
  endfunction


  function automatic [24:0] conv_u2s_24_25 ;
    input [23:0]  vector ;
  begin
    conv_u2s_24_25 =  {1'b0, vector};
  end
  endfunction


  function automatic [9:0] conv_u2u_7_10 ;
    input [6:0]  vector ;
  begin
    conv_u2u_7_10 = {{3{1'b0}}, vector};
  end
  endfunction


  function automatic [10:0] conv_u2u_7_11 ;
    input [6:0]  vector ;
  begin
    conv_u2u_7_11 = {{4{1'b0}}, vector};
  end
  endfunction


  function automatic [8:0] conv_u2u_8_9 ;
    input [7:0]  vector ;
  begin
    conv_u2u_8_9 = {1'b0, vector};
  end
  endfunction


  function automatic [10:0] conv_u2u_8_11 ;
    input [7:0]  vector ;
  begin
    conv_u2u_8_11 = {{3{1'b0}}, vector};
  end
  endfunction


  function automatic [10:0] conv_u2u_9_11 ;
    input [8:0]  vector ;
  begin
    conv_u2u_9_11 = {{2{1'b0}}, vector};
  end
  endfunction


  function automatic [12:0] conv_u2u_9_13 ;
    input [8:0]  vector ;
  begin
    conv_u2u_9_13 = {{4{1'b0}}, vector};
  end
  endfunction


  function automatic [10:0] conv_u2u_10_11 ;
    input [9:0]  vector ;
  begin
    conv_u2u_10_11 = {1'b0, vector};
  end
  endfunction


  function automatic [15:0] conv_u2u_10_16 ;
    input [9:0]  vector ;
  begin
    conv_u2u_10_16 = {{6{1'b0}}, vector};
  end
  endfunction


  function automatic [12:0] conv_u2u_12_13 ;
    input [11:0]  vector ;
  begin
    conv_u2u_12_13 = {1'b0, vector};
  end
  endfunction


  function automatic [16:0] conv_u2u_12_17 ;
    input [11:0]  vector ;
  begin
    conv_u2u_12_17 = {{5{1'b0}}, vector};
  end
  endfunction


  function automatic [19:0] conv_u2u_13_20 ;
    input [12:0]  vector ;
  begin
    conv_u2u_13_20 = {{7{1'b0}}, vector};
  end
  endfunction


  function automatic [19:0] conv_u2u_14_20 ;
    input [13:0]  vector ;
  begin
    conv_u2u_14_20 = {{6{1'b0}}, vector};
  end
  endfunction


  function automatic [15:0] conv_u2u_15_16 ;
    input [14:0]  vector ;
  begin
    conv_u2u_15_16 = {1'b0, vector};
  end
  endfunction


  function automatic [18:0] conv_u2u_18_19 ;
    input [17:0]  vector ;
  begin
    conv_u2u_18_19 = {1'b0, vector};
  end
  endfunction


  function automatic [19:0] conv_u2u_19_20 ;
    input [18:0]  vector ;
  begin
    conv_u2u_19_20 = {1'b0, vector};
  end
  endfunction


  function automatic [23:0] conv_u2u_19_24 ;
    input [18:0]  vector ;
  begin
    conv_u2u_19_24 = {{5{1'b0}}, vector};
  end
  endfunction


  function automatic [25:0] conv_u2u_19_26 ;
    input [18:0]  vector ;
  begin
    conv_u2u_19_26 = {{7{1'b0}}, vector};
  end
  endfunction


  function automatic [24:0] conv_u2u_24_25 ;
    input [23:0]  vector ;
  begin
    conv_u2u_24_25 = {1'b0, vector};
  end
  endfunction


  function automatic [25:0] conv_u2u_24_26 ;
    input [23:0]  vector ;
  begin
    conv_u2u_24_26 = {{2{1'b0}}, vector};
  end
  endfunction


  function automatic [25:0] conv_u2u_25_26 ;
    input [24:0]  vector ;
  begin
    conv_u2u_25_26 = {1'b0, vector};
  end
  endfunction


  function automatic [26:0] conv_u2u_26_27 ;
    input [25:0]  vector ;
  begin
    conv_u2u_26_27 = {1'b0, vector};
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_MagAng
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_MagAng (
  clk, rst, arst_n, dx_in_rsc_dat, dx_in_rsc_vld, dx_in_rsc_rdy, dy_in_rsc_dat, dy_in_rsc_vld,
      dy_in_rsc_rdy, widthIn_rsc_dat, widthIn_triosy_lz, heightIn_rsc_dat, heightIn_triosy_lz,
      magn_rsc_dat, magn_rsc_vld, magn_rsc_rdy, angle_rsc_dat, angle_rsc_vld, angle_rsc_rdy
);
  input clk;
  input rst;
  input arst_n;
  input [8:0] dx_in_rsc_dat;
  input dx_in_rsc_vld;
  output dx_in_rsc_rdy;
  input [8:0] dy_in_rsc_dat;
  input dy_in_rsc_vld;
  output dy_in_rsc_rdy;
  input [10:0] widthIn_rsc_dat;
  output widthIn_triosy_lz;
  input [9:0] heightIn_rsc_dat;
  output heightIn_triosy_lz;
  output [8:0] magn_rsc_dat;
  output magn_rsc_vld;
  input magn_rsc_rdy;
  output [7:0] angle_rsc_dat;
  output angle_rsc_vld;
  input angle_rsc_rdy;



  // Interconnect Declarations for Component Instantiations 
  EdgeDetect_IP_EdgeDetect_MagAng_run EdgeDetect_IP_EdgeDetect_MagAng_run_inst (
      .clk(clk),
      .rst(rst),
      .arst_n(arst_n),
      .dx_in_rsc_dat(dx_in_rsc_dat),
      .dx_in_rsc_vld(dx_in_rsc_vld),
      .dx_in_rsc_rdy(dx_in_rsc_rdy),
      .dy_in_rsc_dat(dy_in_rsc_dat),
      .dy_in_rsc_vld(dy_in_rsc_vld),
      .dy_in_rsc_rdy(dy_in_rsc_rdy),
      .widthIn_rsc_dat(widthIn_rsc_dat),
      .widthIn_triosy_lz(widthIn_triosy_lz),
      .heightIn_rsc_dat(heightIn_rsc_dat),
      .heightIn_triosy_lz(heightIn_triosy_lz),
      .magn_rsc_dat(magn_rsc_dat),
      .magn_rsc_vld(magn_rsc_vld),
      .magn_rsc_rdy(magn_rsc_rdy),
      .angle_rsc_dat(angle_rsc_dat),
      .angle_rsc_vld(angle_rsc_vld),
      .angle_rsc_rdy(angle_rsc_rdy)
    );
endmodule




//------> /usr/cadtool/mentor/Catapult/2023.1/Mgc_home/pkgs/siflibs/ccs_in_wait_coupled_v1.v 
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


//------> ../EdgeDetect_IP_EdgeDetect_HorDer.v1/rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    2023.1/1033555 Production Release
//  HLS Date:       Mon Feb 13 11:32:25 PST 2023
// 
//  Generated by:   m111061545@ws41
//  Generated date: Mon Feb 26 23:42:41 2024
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_HorDer_run_run_fsm
//  FSM Module
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_HorDer_run_run_fsm (
  clk, rst, arst_n, run_wen, fsm_output, HCOL_C_0_tr0, HROW_C_0_tr0
);
  input clk;
  input rst;
  input arst_n;
  input run_wen;
  output [3:0] fsm_output;
  reg [3:0] fsm_output;
  input HCOL_C_0_tr0;
  input HROW_C_0_tr0;


  // FSM State Type Declaration for EdgeDetect_IP_EdgeDetect_HorDer_run_run_fsm_1
  parameter
    main_C_0 = 2'd0,
    HCOL_C_0 = 2'd1,
    HROW_C_0 = 2'd2,
    main_C_1 = 2'd3;

  reg [1:0] state_var;
  reg [1:0] state_var_NS;


  // Interconnect Declarations for Component Instantiations 
  always @(*)
  begin : EdgeDetect_IP_EdgeDetect_HorDer_run_run_fsm_1
    case (state_var)
      HCOL_C_0 : begin
        fsm_output = 4'b0010;
        if ( HCOL_C_0_tr0 ) begin
          state_var_NS = HROW_C_0;
        end
        else begin
          state_var_NS = HCOL_C_0;
        end
      end
      HROW_C_0 : begin
        fsm_output = 4'b0100;
        if ( HROW_C_0_tr0 ) begin
          state_var_NS = main_C_1;
        end
        else begin
          state_var_NS = HCOL_C_0;
        end
      end
      main_C_1 : begin
        fsm_output = 4'b1000;
        state_var_NS = main_C_0;
      end
      // main_C_0
      default : begin
        fsm_output = 4'b0001;
        state_var_NS = HCOL_C_0;
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
//  Design Unit:    EdgeDetect_IP_EdgeDetect_HorDer_run_staller
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_HorDer_run_staller (
  run_wen, dat_in_rsci_wen_comp, dx_rsci_wen_comp
);
  output run_wen;
  input dat_in_rsci_wen_comp;
  input dx_rsci_wen_comp;



  // Interconnect Declarations for Component Instantiations 
  assign run_wen = dat_in_rsci_wen_comp & dx_rsci_wen_comp;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_HorDer_run_dx_rsci_dx_wait_dp
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_HorDer_run_dx_rsci_dx_wait_dp (
  clk, rst, arst_n, dx_rsci_oswt, dx_rsci_wen_comp, dx_rsci_biwt, dx_rsci_bdwt, dx_rsci_bcwt
);
  input clk;
  input rst;
  input arst_n;
  input dx_rsci_oswt;
  output dx_rsci_wen_comp;
  input dx_rsci_biwt;
  input dx_rsci_bdwt;
  output dx_rsci_bcwt;
  reg dx_rsci_bcwt;



  // Interconnect Declarations for Component Instantiations 
  assign dx_rsci_wen_comp = (~ dx_rsci_oswt) | dx_rsci_biwt | dx_rsci_bcwt;
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      dx_rsci_bcwt <= 1'b0;
    end
    else if ( rst ) begin
      dx_rsci_bcwt <= 1'b0;
    end
    else begin
      dx_rsci_bcwt <= ~((~(dx_rsci_bcwt | dx_rsci_biwt)) | dx_rsci_bdwt);
    end
  end
endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_HorDer_run_dx_rsci_dx_wait_ctrl
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_HorDer_run_dx_rsci_dx_wait_ctrl (
  run_wen, dx_rsci_oswt, dx_rsci_biwt, dx_rsci_bdwt, dx_rsci_bcwt, dx_rsci_irdy,
      dx_rsci_ivld_run_sct
);
  input run_wen;
  input dx_rsci_oswt;
  output dx_rsci_biwt;
  output dx_rsci_bdwt;
  input dx_rsci_bcwt;
  input dx_rsci_irdy;
  output dx_rsci_ivld_run_sct;


  // Interconnect Declarations
  wire dx_rsci_ogwt;


  // Interconnect Declarations for Component Instantiations 
  assign dx_rsci_bdwt = dx_rsci_oswt & run_wen;
  assign dx_rsci_biwt = dx_rsci_ogwt & dx_rsci_irdy;
  assign dx_rsci_ogwt = dx_rsci_oswt & (~ dx_rsci_bcwt);
  assign dx_rsci_ivld_run_sct = dx_rsci_ogwt;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_HorDer_run_dat_in_rsci_dat_in_wait_ctrl
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_HorDer_run_dat_in_rsci_dat_in_wait_ctrl (
  run_wen, dat_in_rsci_iswt0, dat_in_rsci_irdy_run_sct
);
  input run_wen;
  input dat_in_rsci_iswt0;
  output dat_in_rsci_irdy_run_sct;



  // Interconnect Declarations for Component Instantiations 
  assign dat_in_rsci_irdy_run_sct = dat_in_rsci_iswt0 & run_wen;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_HorDer_run_dx_rsci
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_HorDer_run_dx_rsci (
  clk, rst, arst_n, dx_rsc_dat, dx_rsc_vld, dx_rsc_rdy, run_wen, dx_rsci_oswt, dx_rsci_wen_comp,
      dx_rsci_idat
);
  input clk;
  input rst;
  input arst_n;
  output [8:0] dx_rsc_dat;
  output dx_rsc_vld;
  input dx_rsc_rdy;
  input run_wen;
  input dx_rsci_oswt;
  output dx_rsci_wen_comp;
  input [8:0] dx_rsci_idat;


  // Interconnect Declarations
  wire dx_rsci_biwt;
  wire dx_rsci_bdwt;
  wire dx_rsci_bcwt;
  wire dx_rsci_irdy;
  wire dx_rsci_ivld_run_sct;


  // Interconnect Declarations for Component Instantiations 
  ccs_out_wait_v1 #(.rscid(32'sd4),
  .width(32'sd9)) dx_rsci (
      .irdy(dx_rsci_irdy),
      .ivld(dx_rsci_ivld_run_sct),
      .idat(dx_rsci_idat),
      .rdy(dx_rsc_rdy),
      .vld(dx_rsc_vld),
      .dat(dx_rsc_dat)
    );
  EdgeDetect_IP_EdgeDetect_HorDer_run_dx_rsci_dx_wait_ctrl EdgeDetect_IP_EdgeDetect_HorDer_run_dx_rsci_dx_wait_ctrl_inst
      (
      .run_wen(run_wen),
      .dx_rsci_oswt(dx_rsci_oswt),
      .dx_rsci_biwt(dx_rsci_biwt),
      .dx_rsci_bdwt(dx_rsci_bdwt),
      .dx_rsci_bcwt(dx_rsci_bcwt),
      .dx_rsci_irdy(dx_rsci_irdy),
      .dx_rsci_ivld_run_sct(dx_rsci_ivld_run_sct)
    );
  EdgeDetect_IP_EdgeDetect_HorDer_run_dx_rsci_dx_wait_dp EdgeDetect_IP_EdgeDetect_HorDer_run_dx_rsci_dx_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .arst_n(arst_n),
      .dx_rsci_oswt(dx_rsci_oswt),
      .dx_rsci_wen_comp(dx_rsci_wen_comp),
      .dx_rsci_biwt(dx_rsci_biwt),
      .dx_rsci_bdwt(dx_rsci_bdwt),
      .dx_rsci_bcwt(dx_rsci_bcwt)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_HorDer_run_dat_in_rsci
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_HorDer_run_dat_in_rsci (
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
  EdgeDetect_IP_EdgeDetect_HorDer_run_dat_in_rsci_dat_in_wait_ctrl EdgeDetect_IP_EdgeDetect_HorDer_run_dat_in_rsci_dat_in_wait_ctrl_inst
      (
      .run_wen(run_wen),
      .dat_in_rsci_iswt0(dat_in_rsci_oswt),
      .dat_in_rsci_irdy_run_sct(dat_in_rsci_irdy_run_sct)
    );
  assign dat_in_rsci_idat_mxwt = dat_in_rsci_idat;
  assign dat_in_rsci_wen_comp = (~ dat_in_rsci_oswt) | dat_in_rsci_ivld;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_HorDer_run
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_HorDer_run (
  clk, rst, arst_n, dat_in_rsc_dat, dat_in_rsc_vld, dat_in_rsc_rdy, widthIn, heightIn,
      dx_rsc_dat, dx_rsc_vld, dx_rsc_rdy
);
  input clk;
  input rst;
  input arst_n;
  input [7:0] dat_in_rsc_dat;
  input dat_in_rsc_vld;
  output dat_in_rsc_rdy;
  input [10:0] widthIn;
  input [9:0] heightIn;
  output [8:0] dx_rsc_dat;
  output dx_rsc_vld;
  input dx_rsc_rdy;


  // Interconnect Declarations
  wire run_wen;
  wire dat_in_rsci_wen_comp;
  wire [7:0] dat_in_rsci_idat_mxwt;
  wire dx_rsci_wen_comp;
  reg [8:0] dx_rsci_idat;
  wire [9:0] nl_dx_rsci_idat;
  wire [3:0] fsm_output;
  wire HCOL_equal_tmp;
  wire HCOL_nor_1_tmp;
  wire and_dcpl_17;
  reg HCOL_stage_0_2;
  reg HCOL_stage_0_1;
  reg [10:0] HCOL_x_sva;
  reg [10:0] HCOL_asn_1_itm_1;
  reg HCOL_if_slc_HCOL_acc_11_svs_1;
  reg reg_dat_in_rsci_oswt_cse;
  reg reg_dx_rsci_oswt_cse;
  wire [10:0] HCOL_x_mux_2_cse;
  wire nand_cse;
  wire HCOL_HCOL_and_cse;
  wire [10:0] z_out;
  wire [11:0] nl_z_out;
  reg [9:0] HROW_y_sva;
  reg [7:0] pix0_lpi_3;
  reg [7:0] pix_buf1_lpi_3;
  reg [7:0] pix_buf0_lpi_3;
  reg HCOL_nor_1_itm_1;
  wire HROW_y_or_cse;
  wire operator_11_false_acc_itm_11_1;

  wire[7:0] HCOL_mux_1_nl;
  wire HCOL_HCOL_nand_nl;
  wire[7:0] pix0_mux_nl;
  wire not_nl;
  wire HROW_y_not_1_nl;
  wire pix0_not_2_nl;
  wire mux_2_nl;
  wire nor_1_nl;
  wire mux_5_nl;
  wire or_nl;
  wire nor_4_nl;
  wire pix_buf0_and_1_nl;
  wire[11:0] operator_11_false_acc_nl;
  wire[12:0] nl_operator_11_false_acc_nl;
  wire HROW_HROW_and_1_nl;
  wire[9:0] HROW_mux_2_nl;

  // Interconnect Declarations for Component Instantiations 
  wire  nl_EdgeDetect_IP_EdgeDetect_HorDer_run_run_fsm_inst_HCOL_C_0_tr0;
  assign nl_EdgeDetect_IP_EdgeDetect_HorDer_run_run_fsm_inst_HCOL_C_0_tr0 = ~(HCOL_stage_0_2
      | HCOL_stage_0_1);
  wire[9:0] operator_10_false_acc_nl;
  wire[10:0] nl_operator_10_false_acc_nl;
  wire  nl_EdgeDetect_IP_EdgeDetect_HorDer_run_run_fsm_inst_HROW_C_0_tr0;
  assign nl_operator_10_false_acc_nl = heightIn + 10'b1111111111;
  assign operator_10_false_acc_nl = nl_operator_10_false_acc_nl[9:0];
  assign nl_EdgeDetect_IP_EdgeDetect_HorDer_run_run_fsm_inst_HROW_C_0_tr0 = HROW_y_sva
      == operator_10_false_acc_nl;
  EdgeDetect_IP_EdgeDetect_HorDer_run_dat_in_rsci EdgeDetect_IP_EdgeDetect_HorDer_run_dat_in_rsci_inst
      (
      .dat_in_rsc_dat(dat_in_rsc_dat),
      .dat_in_rsc_vld(dat_in_rsc_vld),
      .dat_in_rsc_rdy(dat_in_rsc_rdy),
      .run_wen(run_wen),
      .dat_in_rsci_oswt(reg_dat_in_rsci_oswt_cse),
      .dat_in_rsci_wen_comp(dat_in_rsci_wen_comp),
      .dat_in_rsci_idat_mxwt(dat_in_rsci_idat_mxwt)
    );
  EdgeDetect_IP_EdgeDetect_HorDer_run_dx_rsci EdgeDetect_IP_EdgeDetect_HorDer_run_dx_rsci_inst
      (
      .clk(clk),
      .rst(rst),
      .arst_n(arst_n),
      .dx_rsc_dat(dx_rsc_dat),
      .dx_rsc_vld(dx_rsc_vld),
      .dx_rsc_rdy(dx_rsc_rdy),
      .run_wen(run_wen),
      .dx_rsci_oswt(reg_dx_rsci_oswt_cse),
      .dx_rsci_wen_comp(dx_rsci_wen_comp),
      .dx_rsci_idat(dx_rsci_idat)
    );
  EdgeDetect_IP_EdgeDetect_HorDer_run_staller EdgeDetect_IP_EdgeDetect_HorDer_run_staller_inst
      (
      .run_wen(run_wen),
      .dat_in_rsci_wen_comp(dat_in_rsci_wen_comp),
      .dx_rsci_wen_comp(dx_rsci_wen_comp)
    );
  EdgeDetect_IP_EdgeDetect_HorDer_run_run_fsm EdgeDetect_IP_EdgeDetect_HorDer_run_run_fsm_inst
      (
      .clk(clk),
      .rst(rst),
      .arst_n(arst_n),
      .run_wen(run_wen),
      .fsm_output(fsm_output),
      .HCOL_C_0_tr0(nl_EdgeDetect_IP_EdgeDetect_HorDer_run_run_fsm_inst_HCOL_C_0_tr0),
      .HROW_C_0_tr0(nl_EdgeDetect_IP_EdgeDetect_HorDer_run_run_fsm_inst_HROW_C_0_tr0)
    );
  assign HROW_y_or_cse = (fsm_output[0]) | (fsm_output[2]);
  assign HCOL_x_mux_2_cse = MUX_v_11_2_2(HCOL_x_sva, z_out, HCOL_stage_0_2);
  assign HCOL_HCOL_and_cse = HCOL_stage_0_1 & nand_cse;
  assign HCOL_nor_1_tmp = ~((HCOL_x_mux_2_cse[10:1]!=10'b0000000000));
  assign nl_operator_11_false_acc_nl = ({1'b1 , widthIn}) + conv_u2s_11_12(~ HCOL_x_mux_2_cse);
  assign operator_11_false_acc_nl = nl_operator_11_false_acc_nl[11:0];
  assign operator_11_false_acc_itm_11_1 = readslicef_12_1_11(operator_11_false_acc_nl);
  assign HCOL_equal_tmp = HCOL_x_sva == widthIn;
  assign nand_cse = ~(HCOL_equal_tmp & HCOL_stage_0_2);
  assign and_dcpl_17 = ~(HCOL_if_slc_HCOL_acc_11_svs_1 | HCOL_equal_tmp);
  always @(posedge clk) begin
    if ( run_wen & (fsm_output[1]) & (~((HCOL_asn_1_itm_1==11'b00000000000))) & HCOL_stage_0_2
        ) begin
      dx_rsci_idat <= nl_dx_rsci_idat[8:0];
    end
  end
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      HCOL_x_sva <= 11'b00000000000;
    end
    else if ( rst ) begin
      HCOL_x_sva <= 11'b00000000000;
    end
    else if ( (HCOL_stage_0_2 | (fsm_output[2]) | (fsm_output[0])) & run_wen ) begin
      HCOL_x_sva <= MUX_v_11_2_2(11'b00000000000, HCOL_x_mux_2_cse, not_nl);
    end
  end
  always @(posedge clk) begin
    if ( run_wen & HROW_y_or_cse ) begin
      HROW_y_sva <= MUX_v_10_2_2(10'b0000000000, (z_out[9:0]), HROW_y_not_1_nl);
    end
  end
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      HCOL_stage_0_1 <= 1'b0;
      HCOL_asn_1_itm_1 <= 11'b00000000000;
      HCOL_stage_0_2 <= 1'b0;
      reg_dat_in_rsci_oswt_cse <= 1'b0;
      reg_dx_rsci_oswt_cse <= 1'b0;
    end
    else if ( rst ) begin
      HCOL_stage_0_1 <= 1'b0;
      HCOL_asn_1_itm_1 <= 11'b00000000000;
      HCOL_stage_0_2 <= 1'b0;
      reg_dat_in_rsci_oswt_cse <= 1'b0;
      reg_dx_rsci_oswt_cse <= 1'b0;
    end
    else if ( run_wen ) begin
      HCOL_stage_0_1 <= HCOL_HCOL_and_cse | HROW_y_or_cse;
      HCOL_asn_1_itm_1 <= HCOL_x_mux_2_cse;
      HCOL_stage_0_2 <= HCOL_HCOL_and_cse & (~ HROW_y_or_cse);
      reg_dat_in_rsci_oswt_cse <= nand_cse & (~ operator_11_false_acc_itm_11_1) &
          HCOL_stage_0_1 & (fsm_output[1]);
      reg_dx_rsci_oswt_cse <= ((HCOL_asn_1_itm_1!=11'b00000000000)) & HCOL_stage_0_2
          & (fsm_output[1]);
    end
  end
  always @(posedge clk) begin
    if ( run_wen & ((fsm_output[0]) | (and_dcpl_17 & HCOL_stage_0_2 & (fsm_output[1])))
        ) begin
      pix0_lpi_3 <= MUX_v_8_2_2(8'b00000000, dat_in_rsci_idat_mxwt, pix0_not_2_nl);
    end
  end
  always @(posedge clk) begin
    if ( run_wen & (~(HCOL_equal_tmp | mux_2_nl)) & HCOL_stage_0_1 & HCOL_stage_0_2
        ) begin
      pix_buf1_lpi_3 <= pix_buf0_lpi_3;
    end
  end
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      HCOL_nor_1_itm_1 <= 1'b0;
    end
    else if ( rst ) begin
      HCOL_nor_1_itm_1 <= 1'b0;
    end
    else if ( run_wen & mux_5_nl & HCOL_stage_0_1 ) begin
      HCOL_nor_1_itm_1 <= HCOL_nor_1_tmp;
    end
  end
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      HCOL_if_slc_HCOL_acc_11_svs_1 <= 1'b0;
    end
    else if ( rst ) begin
      HCOL_if_slc_HCOL_acc_11_svs_1 <= 1'b0;
    end
    else if ( run_wen & HCOL_HCOL_and_cse ) begin
      HCOL_if_slc_HCOL_acc_11_svs_1 <= operator_11_false_acc_itm_11_1;
    end
  end
  always @(posedge clk) begin
    if ( run_wen & (HCOL_stage_0_2 | HROW_y_or_cse) ) begin
      pix_buf0_lpi_3 <= MUX_v_8_2_2(pix0_lpi_3, dat_in_rsci_idat_mxwt, pix_buf0_and_1_nl);
    end
  end
  assign HCOL_HCOL_nand_nl = ~((HCOL_x_sva[0]) & HCOL_nor_1_itm_1);
  assign HCOL_mux_1_nl = MUX_v_8_2_2(pix0_lpi_3, pix_buf1_lpi_3, HCOL_HCOL_nand_nl);
  assign pix0_mux_nl = MUX_v_8_2_2(pix0_lpi_3, dat_in_rsci_idat_mxwt, and_dcpl_17);
  assign nl_dx_rsci_idat  = ({1'b1 , HCOL_mux_1_nl}) + conv_u2s_8_9(~ pix0_mux_nl)
      + 9'b000000001;
  assign not_nl = ~ HROW_y_or_cse;
  assign HROW_y_not_1_nl = ~ (fsm_output[0]);
  assign pix0_not_2_nl = ~ (fsm_output[0]);
  assign nor_1_nl = ~((z_out[10:1]!=10'b0000000000));
  assign mux_2_nl = MUX_s_1_2_2(nor_1_nl, HCOL_nor_1_tmp, z_out[0]);
  assign or_nl = (HCOL_x_sva!=11'b00000000000);
  assign nor_4_nl = ~((~((z_out!=11'b00000000000))) | HCOL_equal_tmp);
  assign mux_5_nl = MUX_s_1_2_2(or_nl, nor_4_nl, HCOL_stage_0_2);
  assign pix_buf0_and_1_nl = (~ HCOL_if_slc_HCOL_acc_11_svs_1) & HCOL_stage_0_2 &
      (~ HROW_y_or_cse);
  assign HROW_HROW_and_1_nl = (HCOL_x_sva[10]) & (fsm_output[1]);
  assign HROW_mux_2_nl = MUX_v_10_2_2(HROW_y_sva, (HCOL_x_sva[9:0]), fsm_output[1]);
  assign nl_z_out = ({HROW_HROW_and_1_nl , HROW_mux_2_nl}) + 11'b00000000001;
  assign z_out = nl_z_out[10:0];

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


  function automatic [0:0] readslicef_12_1_11;
    input [11:0] vector;
    reg [11:0] tmp;
  begin
    tmp = vector >> 11;
    readslicef_12_1_11 = tmp[0:0];
  end
  endfunction


  function automatic [8:0] conv_u2s_8_9 ;
    input [7:0]  vector ;
  begin
    conv_u2s_8_9 =  {1'b0, vector};
  end
  endfunction


  function automatic [11:0] conv_u2s_11_12 ;
    input [10:0]  vector ;
  begin
    conv_u2s_11_12 =  {1'b0, vector};
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_HorDer
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_HorDer (
  clk, rst, arst_n, dat_in_rsc_dat, dat_in_rsc_vld, dat_in_rsc_rdy, widthIn, heightIn,
      dx_rsc_dat, dx_rsc_vld, dx_rsc_rdy
);
  input clk;
  input rst;
  input arst_n;
  input [7:0] dat_in_rsc_dat;
  input dat_in_rsc_vld;
  output dat_in_rsc_rdy;
  input [10:0] widthIn;
  input [9:0] heightIn;
  output [8:0] dx_rsc_dat;
  output dx_rsc_vld;
  input dx_rsc_rdy;



  // Interconnect Declarations for Component Instantiations 
  EdgeDetect_IP_EdgeDetect_HorDer_run EdgeDetect_IP_EdgeDetect_HorDer_run_inst (
      .clk(clk),
      .rst(rst),
      .arst_n(arst_n),
      .dat_in_rsc_dat(dat_in_rsc_dat),
      .dat_in_rsc_vld(dat_in_rsc_vld),
      .dat_in_rsc_rdy(dat_in_rsc_rdy),
      .widthIn(widthIn),
      .heightIn(heightIn),
      .dx_rsc_dat(dx_rsc_dat),
      .dx_rsc_vld(dx_rsc_vld),
      .dx_rsc_rdy(dx_rsc_rdy)
    );
endmodule




//------> ../EdgeDetect_IP_EdgeDetect_VerDer.v1/rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    2023.1/1033555 Production Release
//  HLS Date:       Mon Feb 13 11:32:25 PST 2023
// 
//  Generated by:   m111061545@ws41
//  Generated date: Mon Feb 26 23:42:24 2024
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_VerDer_ccs_sample_mem_ccs_ram_sync_singleport_rwport_en_7_16_10_963_963_16_5_gen
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_VerDer_ccs_sample_mem_ccs_ram_sync_singleport_rwport_en_7_16_10_963_963_16_5_gen
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
//  Design Unit:    EdgeDetect_IP_EdgeDetect_VerDer_ccs_sample_mem_ccs_ram_sync_singleport_rwport_en_6_16_10_963_963_16_5_gen
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_VerDer_ccs_sample_mem_ccs_ram_sync_singleport_rwport_en_6_16_10_963_963_16_5_gen
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
//  Design Unit:    EdgeDetect_IP_EdgeDetect_VerDer_run_run_fsm
//  FSM Module
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_VerDer_run_run_fsm (
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


  // FSM State Type Declaration for EdgeDetect_IP_EdgeDetect_VerDer_run_run_fsm_1
  parameter
    main_C_0 = 2'd0,
    VCOL_C_0 = 2'd1,
    VROW_C_0 = 2'd2,
    main_C_1 = 2'd3;

  reg [1:0] state_var;
  reg [1:0] state_var_NS;


  // Interconnect Declarations for Component Instantiations 
  always @(*)
  begin : EdgeDetect_IP_EdgeDetect_VerDer_run_run_fsm_1
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
//  Design Unit:    EdgeDetect_IP_EdgeDetect_VerDer_run_staller
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_VerDer_run_staller (
  run_wen, dat_in_rsci_wen_comp, dat_out_rsci_wen_comp, dy_rsci_wen_comp
);
  output run_wen;
  input dat_in_rsci_wen_comp;
  input dat_out_rsci_wen_comp;
  input dy_rsci_wen_comp;



  // Interconnect Declarations for Component Instantiations 
  assign run_wen = dat_in_rsci_wen_comp & dat_out_rsci_wen_comp & dy_rsci_wen_comp;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_VerDer_run_wait_dp
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_VerDer_run_wait_dp (
  line_buf0_rsci_en_d, run_wen, line_buf0_rsci_cgo, line_buf0_rsci_cgo_ir_unreg
);
  output line_buf0_rsci_en_d;
  input run_wen;
  input line_buf0_rsci_cgo;
  input line_buf0_rsci_cgo_ir_unreg;



  // Interconnect Declarations for Component Instantiations 
  assign line_buf0_rsci_en_d = run_wen & (line_buf0_rsci_cgo | line_buf0_rsci_cgo_ir_unreg);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_VerDer_run_dy_rsci_dy_wait_dp
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_VerDer_run_dy_rsci_dy_wait_dp (
  clk, rst, arst_n, dy_rsci_oswt, dy_rsci_wen_comp, dy_rsci_biwt, dy_rsci_bdwt, dy_rsci_bcwt
);
  input clk;
  input rst;
  input arst_n;
  input dy_rsci_oswt;
  output dy_rsci_wen_comp;
  input dy_rsci_biwt;
  input dy_rsci_bdwt;
  output dy_rsci_bcwt;
  reg dy_rsci_bcwt;



  // Interconnect Declarations for Component Instantiations 
  assign dy_rsci_wen_comp = (~ dy_rsci_oswt) | dy_rsci_biwt | dy_rsci_bcwt;
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      dy_rsci_bcwt <= 1'b0;
    end
    else if ( rst ) begin
      dy_rsci_bcwt <= 1'b0;
    end
    else begin
      dy_rsci_bcwt <= ~((~(dy_rsci_bcwt | dy_rsci_biwt)) | dy_rsci_bdwt);
    end
  end
endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_VerDer_run_dy_rsci_dy_wait_ctrl
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_VerDer_run_dy_rsci_dy_wait_ctrl (
  run_wen, dy_rsci_oswt, dy_rsci_biwt, dy_rsci_bdwt, dy_rsci_bcwt, dy_rsci_irdy,
      dy_rsci_ivld_run_sct
);
  input run_wen;
  input dy_rsci_oswt;
  output dy_rsci_biwt;
  output dy_rsci_bdwt;
  input dy_rsci_bcwt;
  input dy_rsci_irdy;
  output dy_rsci_ivld_run_sct;


  // Interconnect Declarations
  wire dy_rsci_ogwt;


  // Interconnect Declarations for Component Instantiations 
  assign dy_rsci_bdwt = dy_rsci_oswt & run_wen;
  assign dy_rsci_biwt = dy_rsci_ogwt & dy_rsci_irdy;
  assign dy_rsci_ogwt = dy_rsci_oswt & (~ dy_rsci_bcwt);
  assign dy_rsci_ivld_run_sct = dy_rsci_ogwt;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_VerDer_run_dat_out_rsci_dat_out_wait_dp
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_VerDer_run_dat_out_rsci_dat_out_wait_dp (
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
//  Design Unit:    EdgeDetect_IP_EdgeDetect_VerDer_run_dat_out_rsci_dat_out_wait_ctrl
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_VerDer_run_dat_out_rsci_dat_out_wait_ctrl (
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
//  Design Unit:    EdgeDetect_IP_EdgeDetect_VerDer_run_dat_in_rsci_dat_in_wait_ctrl
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_VerDer_run_dat_in_rsci_dat_in_wait_ctrl (
  run_wen, dat_in_rsci_iswt0, dat_in_rsci_irdy_run_sct
);
  input run_wen;
  input dat_in_rsci_iswt0;
  output dat_in_rsci_irdy_run_sct;



  // Interconnect Declarations for Component Instantiations 
  assign dat_in_rsci_irdy_run_sct = dat_in_rsci_iswt0 & run_wen;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_VerDer_run_dy_rsci
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_VerDer_run_dy_rsci (
  clk, rst, arst_n, dy_rsc_dat, dy_rsc_vld, dy_rsc_rdy, run_wen, dy_rsci_oswt, dy_rsci_wen_comp,
      dy_rsci_idat
);
  input clk;
  input rst;
  input arst_n;
  output [8:0] dy_rsc_dat;
  output dy_rsc_vld;
  input dy_rsc_rdy;
  input run_wen;
  input dy_rsci_oswt;
  output dy_rsci_wen_comp;
  input [8:0] dy_rsci_idat;


  // Interconnect Declarations
  wire dy_rsci_biwt;
  wire dy_rsci_bdwt;
  wire dy_rsci_bcwt;
  wire dy_rsci_irdy;
  wire dy_rsci_ivld_run_sct;


  // Interconnect Declarations for Component Instantiations 
  ccs_out_wait_v1 #(.rscid(32'sd5),
  .width(32'sd9)) dy_rsci (
      .irdy(dy_rsci_irdy),
      .ivld(dy_rsci_ivld_run_sct),
      .idat(dy_rsci_idat),
      .rdy(dy_rsc_rdy),
      .vld(dy_rsc_vld),
      .dat(dy_rsc_dat)
    );
  EdgeDetect_IP_EdgeDetect_VerDer_run_dy_rsci_dy_wait_ctrl EdgeDetect_IP_EdgeDetect_VerDer_run_dy_rsci_dy_wait_ctrl_inst
      (
      .run_wen(run_wen),
      .dy_rsci_oswt(dy_rsci_oswt),
      .dy_rsci_biwt(dy_rsci_biwt),
      .dy_rsci_bdwt(dy_rsci_bdwt),
      .dy_rsci_bcwt(dy_rsci_bcwt),
      .dy_rsci_irdy(dy_rsci_irdy),
      .dy_rsci_ivld_run_sct(dy_rsci_ivld_run_sct)
    );
  EdgeDetect_IP_EdgeDetect_VerDer_run_dy_rsci_dy_wait_dp EdgeDetect_IP_EdgeDetect_VerDer_run_dy_rsci_dy_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .arst_n(arst_n),
      .dy_rsci_oswt(dy_rsci_oswt),
      .dy_rsci_wen_comp(dy_rsci_wen_comp),
      .dy_rsci_biwt(dy_rsci_biwt),
      .dy_rsci_bdwt(dy_rsci_bdwt),
      .dy_rsci_bcwt(dy_rsci_bcwt)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_VerDer_run_dat_out_rsci
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_VerDer_run_dat_out_rsci (
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
  EdgeDetect_IP_EdgeDetect_VerDer_run_dat_out_rsci_dat_out_wait_ctrl EdgeDetect_IP_EdgeDetect_VerDer_run_dat_out_rsci_dat_out_wait_ctrl_inst
      (
      .run_wen(run_wen),
      .dat_out_rsci_oswt(dat_out_rsci_oswt),
      .dat_out_rsci_biwt(dat_out_rsci_biwt),
      .dat_out_rsci_bdwt(dat_out_rsci_bdwt),
      .dat_out_rsci_bcwt(dat_out_rsci_bcwt),
      .dat_out_rsci_irdy(dat_out_rsci_irdy),
      .dat_out_rsci_ivld_run_sct(dat_out_rsci_ivld_run_sct)
    );
  EdgeDetect_IP_EdgeDetect_VerDer_run_dat_out_rsci_dat_out_wait_dp EdgeDetect_IP_EdgeDetect_VerDer_run_dat_out_rsci_dat_out_wait_dp_inst
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
//  Design Unit:    EdgeDetect_IP_EdgeDetect_VerDer_run_dat_in_rsci
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_VerDer_run_dat_in_rsci (
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
  EdgeDetect_IP_EdgeDetect_VerDer_run_dat_in_rsci_dat_in_wait_ctrl EdgeDetect_IP_EdgeDetect_VerDer_run_dat_in_rsci_dat_in_wait_ctrl_inst
      (
      .run_wen(run_wen),
      .dat_in_rsci_iswt0(dat_in_rsci_oswt),
      .dat_in_rsci_irdy_run_sct(dat_in_rsci_irdy_run_sct)
    );
  assign dat_in_rsci_idat_mxwt = dat_in_rsci_idat;
  assign dat_in_rsci_wen_comp = (~ dat_in_rsci_oswt) | dat_in_rsci_ivld;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_VerDer_run
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_VerDer_run (
  clk, rst, arst_n, dat_in_rsc_dat, dat_in_rsc_vld, dat_in_rsc_rdy, widthIn, heightIn,
      dat_out_rsc_dat, dat_out_rsc_vld, dat_out_rsc_rdy, dy_rsc_dat, dy_rsc_vld,
      dy_rsc_rdy, line_buf0_rsci_d_d, line_buf0_rsci_en_d, line_buf0_rsci_q_d, line_buf1_rsci_d_d,
      line_buf1_rsci_q_d, line_buf0_rsci_adr_d_pff, line_buf0_rsci_we_d_pff, line_buf0_rsci_port_0_rw_ram_ir_internal_RMASK_B_d_pff
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
  output [8:0] dy_rsc_dat;
  output dy_rsc_vld;
  input dy_rsc_rdy;
  output [15:0] line_buf0_rsci_d_d;
  output line_buf0_rsci_en_d;
  input [15:0] line_buf0_rsci_q_d;
  output [15:0] line_buf1_rsci_d_d;
  input [15:0] line_buf1_rsci_q_d;
  output [9:0] line_buf0_rsci_adr_d_pff;
  output line_buf0_rsci_we_d_pff;
  output line_buf0_rsci_port_0_rw_ram_ir_internal_RMASK_B_d_pff;


  // Interconnect Declarations
  wire run_wen;
  wire dat_in_rsci_wen_comp;
  wire [7:0] dat_in_rsci_idat_mxwt;
  wire dat_out_rsci_wen_comp;
  reg [7:0] dat_out_rsci_idat;
  wire dy_rsci_wen_comp;
  reg [8:0] dy_rsci_idat;
  wire [3:0] fsm_output;
  wire VROW_equal_tmp;
  wire VCOL_equal_1_tmp;
  wire or_dcpl_40;
  wire or_dcpl_45;
  wire and_dcpl_30;
  wire and_dcpl_36;
  reg [9:0] VROW_y_sva;
  reg VCOL_nor_1_itm_2;
  wire [10:0] VCOL_x_sva_2;
  wire [11:0] nl_VCOL_x_sva_2;
  reg VCOL_stage_0_2;
  reg VCOL_stage_0_1;
  reg [9:0] VCOL_asn_4_itm_1;
  reg [10:0] VCOL_x_sva;
  reg [9:0] VCOL_asn_4_itm;
  reg VCOL_stage_0_3;
  reg [9:0] VCOL_asn_4_itm_2;
  reg VCOL_if_slc_VCOL_acc_10_svs_1;
  reg operator_11_false_operator_11_false_slc_VCOL_x_0_33_itm_1;
  reg VCOL_asn_16_itm_1;
  reg reg_dat_in_rsci_oswt_cse;
  reg reg_dat_out_rsci_oswt_cse;
  reg reg_line_buf0_rsci_cgo_cse;
  wire nand_3_cse;
  reg operator_11_false_operator_11_false_slc_VCOL_x_0_36_itm_1;
  reg [15:0] reg_line_buf1_rsci_d_d_cse;
  wire VCOL_VCOL_and_cse;
  wire and_38_m1c;
  wire rdbuf0_pix_or_cse;
  wire and_84_rmff;
  wire [7:0] pix0_lpi_3_dfm_mx1;
  reg [7:0] wrbuf0_pix_7_0_lpi_4;
  wire [15:0] rdbuf0_pix_mux_itm;
  wire [9:0] z_out;
  reg [7:0] pix0_lpi_3;
  reg [7:0] pix0_lpi_3_dfm_1;
  reg VCOL_nor_1_itm_1;
  reg [7:0] rdbuf1_pix_lpi_3_15_8;
  wire dat_out_rsci_idat_mx0c1;
  wire [10:0] VCOL_x_sva_mx1;
  wire [7:0] pix0_lpi_3_mx1;
  wire [7:0] pix0_lpi_3_dfm_2_mx0;
  wire [7:0] VCOL_qr_1_lpi_3_dfm_mx0;
  wire VCOL_VCOL_nand_tmp_1;
  wire pix0_or_1_rgt;
  wire VCOL_and_2_cse;
  wire VCOL_and_4_cse;
  wire VROW_y_or_cse;
  wire or_tmp_35;
  wire operator_10_false_acc_itm_10;

  wire VROW_y_not_2_nl;
  wire not_66_nl;
  wire[9:0] VROW_y_mux_nl;
  wire VCOL_nor_nl;
  wire and_43_nl;
  wire and_44_nl;
  wire and_46_nl;
  wire and_47_nl;
  wire mux_3_nl;
  wire mux_nl;
  wire and_121_nl;
  wire[10:0] operator_11_false_acc_nl;
  wire[11:0] nl_operator_11_false_acc_nl;
  wire[10:0] operator_10_false_acc_nl;
  wire[11:0] nl_operator_10_false_acc_nl;
  wire[10:0] acc_nl;
  wire[11:0] nl_acc_nl;
  wire[1:0] operator_8_false_2_operator_8_false_2_or_1_nl;
  wire operator_8_false_2_not_4_nl;
  wire[7:0] operator_8_false_2_operator_8_false_2_mux1h_1_nl;
  wire operator_8_false_2_operator_8_false_2_nor_1_nl;
  wire VCOL_and_7_nl;
  wire VCOL_and_8_nl;
  wire operator_8_false_2_or_1_nl;
  wire[7:0] operator_8_false_2_mux_3_nl;

  // Interconnect Declarations for Component Instantiations 
  wire  nl_EdgeDetect_IP_EdgeDetect_VerDer_run_run_fsm_inst_VCOL_C_0_tr0;
  assign nl_EdgeDetect_IP_EdgeDetect_VerDer_run_run_fsm_inst_VCOL_C_0_tr0 = ~(VCOL_stage_0_2
      | VCOL_stage_0_3 | VCOL_stage_0_1);
  EdgeDetect_IP_EdgeDetect_VerDer_run_dat_in_rsci EdgeDetect_IP_EdgeDetect_VerDer_run_dat_in_rsci_inst
      (
      .dat_in_rsc_dat(dat_in_rsc_dat),
      .dat_in_rsc_vld(dat_in_rsc_vld),
      .dat_in_rsc_rdy(dat_in_rsc_rdy),
      .run_wen(run_wen),
      .dat_in_rsci_oswt(reg_dat_in_rsci_oswt_cse),
      .dat_in_rsci_wen_comp(dat_in_rsci_wen_comp),
      .dat_in_rsci_idat_mxwt(dat_in_rsci_idat_mxwt)
    );
  EdgeDetect_IP_EdgeDetect_VerDer_run_dat_out_rsci EdgeDetect_IP_EdgeDetect_VerDer_run_dat_out_rsci_inst
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
  EdgeDetect_IP_EdgeDetect_VerDer_run_dy_rsci EdgeDetect_IP_EdgeDetect_VerDer_run_dy_rsci_inst
      (
      .clk(clk),
      .rst(rst),
      .arst_n(arst_n),
      .dy_rsc_dat(dy_rsc_dat),
      .dy_rsc_vld(dy_rsc_vld),
      .dy_rsc_rdy(dy_rsc_rdy),
      .run_wen(run_wen),
      .dy_rsci_oswt(reg_dat_out_rsci_oswt_cse),
      .dy_rsci_wen_comp(dy_rsci_wen_comp),
      .dy_rsci_idat(dy_rsci_idat)
    );
  EdgeDetect_IP_EdgeDetect_VerDer_run_wait_dp EdgeDetect_IP_EdgeDetect_VerDer_run_wait_dp_inst
      (
      .line_buf0_rsci_en_d(line_buf0_rsci_en_d),
      .run_wen(run_wen),
      .line_buf0_rsci_cgo(reg_line_buf0_rsci_cgo_cse),
      .line_buf0_rsci_cgo_ir_unreg(and_84_rmff)
    );
  EdgeDetect_IP_EdgeDetect_VerDer_run_staller EdgeDetect_IP_EdgeDetect_VerDer_run_staller_inst
      (
      .run_wen(run_wen),
      .dat_in_rsci_wen_comp(dat_in_rsci_wen_comp),
      .dat_out_rsci_wen_comp(dat_out_rsci_wen_comp),
      .dy_rsci_wen_comp(dy_rsci_wen_comp)
    );
  EdgeDetect_IP_EdgeDetect_VerDer_run_run_fsm EdgeDetect_IP_EdgeDetect_VerDer_run_run_fsm_inst
      (
      .clk(clk),
      .rst(rst),
      .arst_n(arst_n),
      .run_wen(run_wen),
      .fsm_output(fsm_output),
      .VCOL_C_0_tr0(nl_EdgeDetect_IP_EdgeDetect_VerDer_run_run_fsm_inst_VCOL_C_0_tr0),
      .VROW_C_0_tr0(VROW_equal_tmp)
    );
  assign VROW_y_or_cse = (fsm_output[0]) | (fsm_output[2]);
  assign VCOL_and_2_cse = run_wen & VCOL_stage_0_2;
  assign VCOL_and_4_cse = run_wen & VCOL_VCOL_and_cse;
  assign and_84_rmff = (VCOL_stage_0_3 | VCOL_stage_0_2) & (fsm_output[1]);
  assign rdbuf0_pix_or_cse = operator_11_false_operator_11_false_slc_VCOL_x_0_36_itm_1
      | or_dcpl_45;
  assign rdbuf0_pix_mux_itm = MUX_v_16_2_2(line_buf0_rsci_q_d, reg_line_buf1_rsci_d_d_cse,
      rdbuf0_pix_or_cse);
  assign and_38_m1c = VCOL_stage_0_3 & (~ VCOL_asn_16_itm_1) & VCOL_stage_0_1;
  assign pix0_or_1_rgt = (VROW_equal_tmp & and_38_m1c) | (and_dcpl_30 & VROW_equal_tmp);
  assign nand_3_cse = ~(VCOL_equal_1_tmp & VCOL_stage_0_2);
  assign nl_operator_11_false_acc_nl = widthIn + 11'b11111111111;
  assign operator_11_false_acc_nl = nl_operator_11_false_acc_nl[10:0];
  assign VCOL_equal_1_tmp = VCOL_x_sva == operator_11_false_acc_nl;
  assign VCOL_VCOL_and_cse = VCOL_stage_0_1 & nand_3_cse;
  assign VCOL_x_sva_mx1 = MUX_v_11_2_2(VCOL_x_sva, VCOL_x_sva_2, VCOL_stage_0_2);
  assign pix0_lpi_3_dfm_mx1 = MUX_v_8_2_2(dat_in_rsci_idat_mxwt, pix0_lpi_3_mx1,
      VCOL_if_slc_VCOL_acc_10_svs_1);
  assign pix0_lpi_3_mx1 = MUX_v_8_2_2(pix0_lpi_3_dfm_2_mx0, pix0_lpi_3, or_dcpl_45);
  assign nl_operator_10_false_acc_nl = ({1'b1 , heightIn}) + conv_u2s_10_11(~ VROW_y_sva);
  assign operator_10_false_acc_nl = nl_operator_10_false_acc_nl[10:0];
  assign operator_10_false_acc_itm_10 = readslicef_11_1_10(operator_10_false_acc_nl);
  assign pix0_lpi_3_dfm_2_mx0 = MUX_v_8_2_2(pix0_lpi_3_dfm_1, VCOL_qr_1_lpi_3_dfm_mx0,
      VROW_equal_tmp);
  assign VCOL_qr_1_lpi_3_dfm_mx0 = MUX_v_8_2_2((line_buf0_rsci_q_d[7:0]), (reg_line_buf1_rsci_d_d_cse[15:8]),
      operator_11_false_operator_11_false_slc_VCOL_x_0_36_itm_1);
  assign VCOL_VCOL_nand_tmp_1 = ~((VROW_y_sva[0]) & VCOL_nor_1_itm_2);
  assign nl_VCOL_x_sva_2 = VCOL_x_sva + 11'b00000000001;
  assign VCOL_x_sva_2 = nl_VCOL_x_sva_2[10:0];
  assign VROW_equal_tmp = VROW_y_sva == heightIn;
  assign or_dcpl_40 = (VCOL_asn_4_itm_2!=10'b0000000000);
  assign or_dcpl_45 = (~ VCOL_stage_0_3) | VCOL_asn_16_itm_1;
  assign and_dcpl_30 = VCOL_stage_0_3 & (~ VCOL_stage_0_1);
  assign and_dcpl_36 = (~ VCOL_stage_0_2) & VCOL_stage_0_3;
  assign dat_out_rsci_idat_mx0c1 = or_dcpl_40 & VCOL_stage_0_3 & (~ operator_11_false_operator_11_false_slc_VCOL_x_0_36_itm_1)
      & (fsm_output[1]);
  assign line_buf0_rsci_adr_d_pff = VCOL_x_sva[10:1];
  assign line_buf0_rsci_d_d = {pix0_lpi_3_dfm_mx1 , wrbuf0_pix_7_0_lpi_4};
  assign line_buf0_rsci_we_d_pff = VCOL_stage_0_2 & operator_11_false_operator_11_false_slc_VCOL_x_0_33_itm_1
      & (fsm_output[1]);
  assign line_buf0_rsci_port_0_rw_ram_ir_internal_RMASK_B_d_pff = VCOL_stage_0_2
      & (~ operator_11_false_operator_11_false_slc_VCOL_x_0_33_itm_1) & (fsm_output[1]);
  assign line_buf1_rsci_d_d = rdbuf0_pix_mux_itm;
  assign or_tmp_35 = (~ VCOL_if_slc_VCOL_acc_10_svs_1) | VCOL_asn_16_itm_1 | VROW_equal_tmp
      | (~ VCOL_stage_0_3);
  always @(posedge clk) begin
    if ( run_wen & (fsm_output[1]) & (~((VCOL_asn_4_itm_2==10'b0000000000))) & VCOL_stage_0_3
        ) begin
      dy_rsci_idat <= z_out[8:0];
    end
  end
  always @(posedge clk) begin
    if ( run_wen & ((or_dcpl_40 & VCOL_stage_0_3 & operator_11_false_operator_11_false_slc_VCOL_x_0_36_itm_1
        & (fsm_output[1])) | dat_out_rsci_idat_mx0c1) ) begin
      dat_out_rsci_idat <= MUX_v_8_2_2((reg_line_buf1_rsci_d_d_cse[15:8]), (line_buf0_rsci_q_d[7:0]),
          dat_out_rsci_idat_mx0c1);
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
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      VCOL_asn_16_itm_1 <= 1'b0;
      VCOL_asn_4_itm_2 <= 10'b0000000000;
      operator_11_false_operator_11_false_slc_VCOL_x_0_36_itm_1 <= 1'b0;
    end
    else if ( rst ) begin
      VCOL_asn_16_itm_1 <= 1'b0;
      VCOL_asn_4_itm_2 <= 10'b0000000000;
      operator_11_false_operator_11_false_slc_VCOL_x_0_36_itm_1 <= 1'b0;
    end
    else if ( VCOL_and_2_cse ) begin
      VCOL_asn_16_itm_1 <= VCOL_equal_1_tmp;
      VCOL_asn_4_itm_2 <= VCOL_asn_4_itm_1;
      operator_11_false_operator_11_false_slc_VCOL_x_0_36_itm_1 <= VCOL_x_sva[0];
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
      VCOL_asn_4_itm <= 10'b0000000000;
    end
    else if ( rst ) begin
      VCOL_stage_0_1 <= 1'b0;
      VCOL_stage_0_2 <= 1'b0;
      VCOL_stage_0_3 <= 1'b0;
      reg_dat_in_rsci_oswt_cse <= 1'b0;
      reg_dat_out_rsci_oswt_cse <= 1'b0;
      reg_line_buf0_rsci_cgo_cse <= 1'b0;
      VCOL_asn_4_itm <= 10'b0000000000;
    end
    else if ( run_wen ) begin
      VCOL_stage_0_1 <= VCOL_VCOL_and_cse | VROW_y_or_cse;
      VCOL_stage_0_2 <= VCOL_VCOL_and_cse & (~ VROW_y_or_cse);
      VCOL_stage_0_3 <= VCOL_stage_0_2 & (~ VROW_y_or_cse);
      reg_dat_in_rsci_oswt_cse <= nand_3_cse & VCOL_stage_0_1 & (~ operator_10_false_acc_itm_10)
          & (fsm_output[1]);
      reg_dat_out_rsci_oswt_cse <= or_dcpl_40 & VCOL_stage_0_3 & (fsm_output[1]);
      reg_line_buf0_rsci_cgo_cse <= and_84_rmff;
      VCOL_asn_4_itm <= MUX_v_10_2_2(10'b0000000000, VROW_y_mux_nl, VCOL_nor_nl);
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
      VCOL_x_sva <= MUX_v_11_2_2(11'b00000000000, VCOL_x_sva_mx1, not_66_nl);
    end
  end
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      VCOL_asn_4_itm_1 <= 10'b0000000000;
      operator_11_false_operator_11_false_slc_VCOL_x_0_33_itm_1 <= 1'b0;
      VCOL_if_slc_VCOL_acc_10_svs_1 <= 1'b0;
    end
    else if ( rst ) begin
      VCOL_asn_4_itm_1 <= 10'b0000000000;
      operator_11_false_operator_11_false_slc_VCOL_x_0_33_itm_1 <= 1'b0;
      VCOL_if_slc_VCOL_acc_10_svs_1 <= 1'b0;
    end
    else if ( VCOL_and_4_cse ) begin
      VCOL_asn_4_itm_1 <= VCOL_asn_4_itm;
      operator_11_false_operator_11_false_slc_VCOL_x_0_33_itm_1 <= VCOL_x_sva_mx1[0];
      VCOL_if_slc_VCOL_acc_10_svs_1 <= operator_10_false_acc_itm_10;
    end
  end
  always @(posedge clk) begin
    if ( VCOL_stage_0_3 & (~ VCOL_asn_16_itm_1) & (~ operator_11_false_operator_11_false_slc_VCOL_x_0_36_itm_1)
        & run_wen ) begin
      reg_line_buf1_rsci_d_d_cse <= rdbuf0_pix_mux_itm;
    end
  end
  always @(posedge clk) begin
    if ( run_wen & (fsm_output[1]) & (~((~(operator_10_false_acc_itm_10 | (~ VCOL_stage_0_1)))
        | VCOL_stage_0_2)) & (((~ VROW_equal_tmp) & and_38_m1c) | (and_dcpl_30 &
        (~ VROW_equal_tmp)) | pix0_or_1_rgt) ) begin
      pix0_lpi_3 <= MUX_v_8_2_2(pix0_lpi_3_dfm_1, VCOL_qr_1_lpi_3_dfm_mx0, pix0_or_1_rgt);
    end
  end
  always @(posedge clk) begin
    if ( run_wen & ((~ rdbuf0_pix_or_cse) | VROW_y_or_cse) ) begin
      rdbuf1_pix_lpi_3_15_8 <= MUX_v_8_2_2((line_buf1_rsci_q_d[15:8]), pix0_lpi_3_dfm_1,
          VROW_y_or_cse);
    end
  end
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      VCOL_nor_1_itm_2 <= 1'b0;
    end
    else if ( rst ) begin
      VCOL_nor_1_itm_2 <= 1'b0;
    end
    else if ( run_wen & ((VCOL_asn_4_itm_1!=10'b0000000000)) & VCOL_stage_0_2 ) begin
      VCOL_nor_1_itm_2 <= VCOL_nor_1_itm_1;
    end
  end
  always @(posedge clk) begin
    if ( mux_3_nl & (fsm_output[3:2]==2'b00) & run_wen ) begin
      pix0_lpi_3_dfm_1 <= MUX1HOT_v_8_4_2(pix0_lpi_3_mx1, dat_in_rsci_idat_mxwt,
          rdbuf1_pix_lpi_3_15_8, (line_buf1_rsci_q_d[15:8]), {and_43_nl , and_44_nl
          , and_46_nl , and_47_nl});
    end
  end
  always @(posedge clk) begin
    if ( run_wen & (~(VCOL_equal_1_tmp | (~ VCOL_stage_0_2))) & (VCOL_x_sva_2[0])
        & VCOL_stage_0_1 & (~ (VCOL_x_sva[0])) ) begin
      wrbuf0_pix_7_0_lpi_4 <= pix0_lpi_3_dfm_mx1;
    end
  end
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      VCOL_nor_1_itm_1 <= 1'b0;
    end
    else if ( rst ) begin
      VCOL_nor_1_itm_1 <= 1'b0;
    end
    else if ( run_wen & ((VCOL_asn_4_itm!=10'b0000000000)) & nand_3_cse & VCOL_stage_0_1
        ) begin
      VCOL_nor_1_itm_1 <= ~((VROW_y_sva[9:1]!=9'b000000000));
    end
  end
  assign VROW_y_not_2_nl = ~ (fsm_output[0]);
  assign VROW_y_mux_nl = MUX_v_10_2_2(VROW_y_sva, z_out, fsm_output[2]);
  assign VCOL_nor_nl = ~((fsm_output[0]) | (fsm_output[3]));
  assign not_66_nl = ~ VROW_y_or_cse;
  assign and_43_nl = VCOL_stage_0_2 & VCOL_if_slc_VCOL_acc_10_svs_1;
  assign and_44_nl = VCOL_stage_0_2 & (~ VCOL_if_slc_VCOL_acc_10_svs_1);
  assign and_46_nl = and_dcpl_36 & operator_11_false_operator_11_false_slc_VCOL_x_0_36_itm_1;
  assign and_47_nl = and_dcpl_36 & (~ operator_11_false_operator_11_false_slc_VCOL_x_0_36_itm_1);
  assign mux_nl = MUX_s_1_2_2(VCOL_stage_0_3, or_tmp_35, VCOL_stage_0_2);
  assign and_121_nl = ((VCOL_asn_4_itm_1!=10'b0000000000) | VCOL_equal_1_tmp | operator_10_false_acc_itm_10)
      & VCOL_stage_0_2 & or_tmp_35;
  assign mux_3_nl = MUX_s_1_2_2(mux_nl, and_121_nl, VCOL_stage_0_1);
  assign operator_8_false_2_not_4_nl = ~ (fsm_output[2]);
  assign operator_8_false_2_operator_8_false_2_or_1_nl = MUX_v_2_2_2((VROW_y_sva[9:8]),
      2'b11, operator_8_false_2_not_4_nl);
  assign operator_8_false_2_operator_8_false_2_nor_1_nl = ~(VCOL_VCOL_nand_tmp_1
      | (fsm_output[2]));
  assign VCOL_and_7_nl = (~ operator_11_false_operator_11_false_slc_VCOL_x_0_36_itm_1)
      & VCOL_VCOL_nand_tmp_1 & (~ (fsm_output[2]));
  assign VCOL_and_8_nl = operator_11_false_operator_11_false_slc_VCOL_x_0_36_itm_1
      & VCOL_VCOL_nand_tmp_1 & (~ (fsm_output[2]));
  assign operator_8_false_2_operator_8_false_2_mux1h_1_nl = MUX1HOT_v_8_4_2(VCOL_qr_1_lpi_3_dfm_mx0,
      (line_buf1_rsci_q_d[7:0]), rdbuf1_pix_lpi_3_15_8, (VROW_y_sva[7:0]), {operator_8_false_2_operator_8_false_2_nor_1_nl
      , VCOL_and_7_nl , VCOL_and_8_nl , (fsm_output[2])});
  assign operator_8_false_2_or_1_nl = (fsm_output[2:1]!=2'b10);
  assign operator_8_false_2_mux_3_nl = MUX_v_8_2_2((~ pix0_lpi_3_dfm_2_mx0), 8'b00000001,
      fsm_output[2]);
  assign nl_acc_nl = ({operator_8_false_2_operator_8_false_2_or_1_nl , operator_8_false_2_operator_8_false_2_mux1h_1_nl
      , operator_8_false_2_or_1_nl}) + conv_u2u_9_11({operator_8_false_2_mux_3_nl
      , 1'b1});
  assign acc_nl = nl_acc_nl[10:0];
  assign z_out = readslicef_11_10_1(acc_nl);

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


  function automatic [15:0] MUX_v_16_2_2;
    input [15:0] input_0;
    input [15:0] input_1;
    input  sel;
    reg [15:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_16_2_2 = result;
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


  function automatic [10:0] conv_u2s_10_11 ;
    input [9:0]  vector ;
  begin
    conv_u2s_10_11 =  {1'b0, vector};
  end
  endfunction


  function automatic [10:0] conv_u2u_9_11 ;
    input [8:0]  vector ;
  begin
    conv_u2u_9_11 = {{2{1'b0}}, vector};
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_VerDer
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_VerDer (
  clk, rst, arst_n, dat_in_rsc_dat, dat_in_rsc_vld, dat_in_rsc_rdy, widthIn, heightIn,
      dat_out_rsc_dat, dat_out_rsc_vld, dat_out_rsc_rdy, dy_rsc_dat, dy_rsc_vld,
      dy_rsc_rdy, line_buf0_rsc_en, line_buf0_rsc_q, line_buf0_rsc_we, line_buf0_rsc_d,
      line_buf0_rsc_adr, line_buf1_rsc_en, line_buf1_rsc_q, line_buf1_rsc_we, line_buf1_rsc_d,
      line_buf1_rsc_adr
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
  output [8:0] dy_rsc_dat;
  output dy_rsc_vld;
  input dy_rsc_rdy;
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
  wire [15:0] line_buf1_rsci_q_d;
  wire [9:0] line_buf0_rsci_adr_d_iff;
  wire line_buf0_rsci_we_d_iff;
  wire line_buf0_rsci_port_0_rw_ram_ir_internal_RMASK_B_d_iff;


  // Interconnect Declarations for Component Instantiations 
  EdgeDetect_IP_EdgeDetect_VerDer_ccs_sample_mem_ccs_ram_sync_singleport_rwport_en_6_16_10_963_963_16_5_gen
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
  EdgeDetect_IP_EdgeDetect_VerDer_ccs_sample_mem_ccs_ram_sync_singleport_rwport_en_7_16_10_963_963_16_5_gen
      line_buf1_rsci (
      .en(line_buf1_rsc_en),
      .q(line_buf1_rsc_q),
      .we(line_buf1_rsc_we),
      .d(line_buf1_rsc_d),
      .adr(line_buf1_rsc_adr),
      .adr_d(line_buf0_rsci_adr_d_iff),
      .d_d(line_buf1_rsci_d_d),
      .en_d(line_buf0_rsci_en_d),
      .we_d(line_buf0_rsci_we_d_iff),
      .q_d(line_buf1_rsci_q_d),
      .port_0_rw_ram_ir_internal_RMASK_B_d(line_buf0_rsci_port_0_rw_ram_ir_internal_RMASK_B_d_iff),
      .port_0_rw_ram_ir_internal_WMASK_B_d(line_buf0_rsci_we_d_iff)
    );
  EdgeDetect_IP_EdgeDetect_VerDer_run EdgeDetect_IP_EdgeDetect_VerDer_run_inst (
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
      .dy_rsc_dat(dy_rsc_dat),
      .dy_rsc_vld(dy_rsc_vld),
      .dy_rsc_rdy(dy_rsc_rdy),
      .line_buf0_rsci_d_d(line_buf0_rsci_d_d),
      .line_buf0_rsci_en_d(line_buf0_rsci_en_d),
      .line_buf0_rsci_q_d(line_buf0_rsci_q_d),
      .line_buf1_rsci_d_d(line_buf1_rsci_d_d),
      .line_buf1_rsci_q_d(line_buf1_rsci_q_d),
      .line_buf0_rsci_adr_d_pff(line_buf0_rsci_adr_d_iff),
      .line_buf0_rsci_we_d_pff(line_buf0_rsci_we_d_iff),
      .line_buf0_rsci_port_0_rw_ram_ir_internal_RMASK_B_d_pff(line_buf0_rsci_port_0_rw_ram_ir_internal_RMASK_B_d_iff)
    );
endmodule




//------> /usr/cadtool/mentor/Catapult/2023.1/Mgc_home/pkgs/siflibs/ccs_genreg_v1.v 
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

module ccs_genreg_v1 (clk, en, arst, srst, d, z);
    parameter integer width   = 1;
    parameter integer ph_clk  = 1;
    parameter integer ph_en   = 1;
    parameter integer ph_arst = 0;
    parameter integer ph_srst = 1;
    parameter         has_en  = 1'b1;

    input clk;
    input en;
    input arst;
    input srst;
    input      [width-1:0] d;
    output reg [width-1:0] z;

    //  Generate parameters
    //  ph_clk | ph_arst | has_en     Label:
    //    1        1          1       GEN_CLK1_ARST1_EN1
    //    1        1          0       GEN_CLK1_ARST1_EN0
    //    1        0          1       GEN_CLK1_ARST0_EN1
    //    1        0          0       GEN_CLK1_ARST0_EN0
    //    0        1          1       GEN_CLK0_ARST1_EN1
    //    0        1          0       GEN_CLK0_ARST1_EN0
    //    0        0          1       GEN_CLK0_ARST0_EN1
    //    0        0          0       GEN_CLK0_ARST0_EN0
    
    generate 
      // Pos edge clock, pos edge async reset, has enable
      if (ph_clk == 1 & ph_arst == 1 & has_en == 1)
      begin: GEN_CLK1_ARST1_EN1
        always @(posedge clk or posedge arst)
          if (arst == 1'b1)
            z <= {width{1'b0}};
          else if (srst == $unsigned(ph_srst))
            z <= {width{1'b0}};
          else if (en == $unsigned(ph_en))
            z <= d;
      end  //GEN_CLK1_ARST1_EN1

      // Pos edge clock, pos edge async reset, no enable
      else if (ph_clk == 1 & ph_arst == 1 & has_en == 0)
      begin: GEN_CLK1_ARST1_EN0
        always @(posedge clk or posedge arst)
          if (arst == 1'b1)
            z <= {width{1'b0}};
          else if (srst == $unsigned(ph_srst))
            z <= {width{1'b0}};
          else
            z <= d;
      end  //GEN_CLK1_ARST1_EN0

      // Pos edge clock, neg edge async reset, has enable
      else if (ph_clk == 1 & ph_arst == 0 & has_en == 1)
      begin: GEN_CLK1_ARST0_EN1
        always @(posedge clk or negedge arst)
          if (arst == 1'b0)
            z <= {width{1'b0}};
          else if (srst == $unsigned(ph_srst))
            z <= {width{1'b0}};
          else if (en == $unsigned(ph_en))
            z <= d;
      end  //GEN_CLK1_ARST0_EN1

      // Pos edge clock, neg edge async reset, no enable
      else if (ph_clk == 1 & ph_arst == 0 & has_en == 0)
      begin: GEN_CLK1_ARST0_EN0
        always @(posedge clk or negedge arst)
          if (arst == 1'b0)
            z <= {width{1'b0}};
          else if (srst == $unsigned(ph_srst))
            z <= {width{1'b0}};
          else
            z <= d;
      end  //GEN_CLK1_ARST0_EN0


      // Neg edge clock, pos edge async reset, has enable
      if (ph_clk == 0 & ph_arst == 1 & has_en == 1)
      begin: GEN_CLK0_ARST1_EN1
        always @(negedge clk or posedge arst)
          if (arst == 1'b1)
            z <= {width{1'b0}};
          else if (srst == $unsigned(ph_srst))
            z <= {width{1'b0}};
          else if (en == $unsigned(ph_en))
            z <= d;
      end  //GEN_CLK0_ARST1_EN1

      // Neg edge clock, pos edge async reset, no enable
      else if (ph_clk == 0 & ph_arst == 1 & has_en == 0)
      begin: GEN_CLK0_ARST1_EN0
        always @(negedge clk or posedge arst)
          if (arst == 1'b1)
            z <= {width{1'b0}};
          else if (srst == $unsigned(ph_srst))
            z <= {width{1'b0}};
          else
            z <= d;
      end  //GEN_CLK0_ARST1_EN0

      // Neg edge clock, neg edge async reset, has enable
      else if (ph_clk == 0 & ph_arst == 0 & has_en == 1)
      begin: GEN_CLK0_ARST0_EN1
        always @(negedge clk or negedge arst)
          if (arst == 1'b0)
            z <= {width{1'b0}};
          else if (srst == $unsigned(ph_srst))
            z <= {width{1'b0}};
          else if (en == $unsigned(ph_en))
            z <= d;
      end  //GEN_CLK0_ARST0_EN1

      // Neg edge clock, neg edge async reset, no enable
      else if (ph_clk == 0 & ph_arst == 0 & has_en == 0)
      begin: GEN_CLK0_ARST0_EN0
        always @(negedge clk or negedge arst)
          if (arst == 1'b0)
            z <= {width{1'b0}};
          else if (srst == $unsigned(ph_srst))
            z <= {width{1'b0}};
          else
            z <= d;
      end  //GEN_CLK0_ARST0_EN0
    endgenerate
endmodule


//------> /usr/cadtool/mentor/Catapult/2023.1/Mgc_home/pkgs/siflibs/ccs_fifo_wait_core_v5.v 
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

/*
 *            _________________________________________________
 * WRITER    |                                                 |   READER
 *           |               ccs_fifo_wait_core                |
 *           |             _____________________               |
 *        --<|  din_rdy --<|  ---------------- <|--- dout_rdy <|---
 *           |             |       FIFO         |              |
 *        ---|> din_vld ---|> ----------------  |>-- dout_vld  |>--
 *        ---|>     din ---|> ----------------  |>-- dout      |>--
 *           |             |____________________|              |
 *           |_________________________________________________|
 *
 *    rdy    - can be considered as a notFULL signal
 *    vld    - can be considered as a notEMPTY signal
 *    is_idle - clk can be safely gated
 *
 * Change History:
 *    2019-01-24 - Add assertion to verify rdy signal behavior under reset.
 *                 Fix bug in that behavior.
 */

module ccs_fifo_wait_core_v5 (clk, en, arst, srst, din_vld, din_rdy, din, dout_vld, dout_rdy, dout, sd, is_idle);

    parameter integer rscid    = 0;     // resource ID
    parameter integer width    = 8;     // fifo width
    parameter integer sz_width = 8;     // size of port for elements in fifo
    parameter integer fifo_sz  = 8;     // fifo depth
    parameter integer ph_clk   = 1;     // clock polarity 1=rising edge, 0=falling edge
    parameter integer ph_en    = 1;     // clock enable polarity
    parameter integer ph_arst  = 1;     // async reset polarity
    parameter integer ph_srst  = 1;     // sync reset polarity
    parameter integer ph_log2  = 3;     // log2(fifo_sz)

    input                 clk;
    input                 en;
    input                 arst;
    input                 srst;
    input                 din_vld;    // writer has valid data
    output                din_rdy;    // fifo ready for data (not full)
    input  [width-1:0]    din;
    output                dout_vld;   // fifo has valid data (not empty)
    input                 dout_rdy;   // reader ready for data
    output [width-1:0]    dout;
    output [sz_width-1:0] sd;
    output                is_idle;

    localparam integer fifo_b  = width * fifo_sz;
    localparam integer fifo_mx = (fifo_sz > 0) ? (fifo_sz-1) : 0 ;
    localparam integer fifo_mx_over_8 = fifo_mx / 8 ;

    reg      [fifo_mx:0] stat_pre;
    wire     [fifo_mx:0] stat;
    reg      [( (fifo_b > 0) ? fifo_b : 1)-1:0] buff_pre;
    wire     [( (fifo_b > 0) ? fifo_b : 1)-1:0] buff;
    reg      [fifo_mx:0] en_l;
    reg      [fifo_mx_over_8:0] en_l_s;

    reg      [width-1:0] buff_nxt;

    reg                  stat_nxt;
    reg                  stat_behind;
    reg                  stat_ahead;
    reg                  stat_tail;
    reg                  en_l_var;

    integer              i;
    genvar               eni;

    wire [32:0]          size_t;
    reg  [31:0]          count;
    reg  [31:0]          count_t;
    reg  [32:0]          n_elem;
    wire                 din_rdy_drv;
    wire                 dout_vld_drv;
    wire                 din_vld_int;
    wire                 hs_init;
    wire                 active;
    wire                 is_idle_drv;

    // synopsys translate_off
    reg  [31:0]          peak;
    initial
    begin
      count = 32'b0;
      peak  = 32'b0;
    end
    // synopsys translate_on

    assign din_rdy = din_rdy_drv;
    assign dout_vld = dout_vld_drv;
    assign is_idle = is_idle_drv;

    generate
    if ( fifo_sz > 0 )
    begin: FIFO_REG
      assign din_vld_int = din_vld & hs_init;
      assign din_rdy_drv = (dout_rdy | (~stat[0])) & hs_init;
      assign dout_vld_drv = din_vld_int | stat[fifo_sz-1];

      assign active = (din_vld_int & din_rdy_drv) | (dout_rdy & dout_vld_drv);
      assign is_idle_drv = (~active) & hs_init;

      assign size_t = (count - {31'b0, (dout_rdy & stat[fifo_sz-1])}) + {31'b0, din_vld_int};
      assign sd = size_t[sz_width-1:0];

      assign dout = (stat[fifo_sz-1]) ? buff[fifo_b-1:width*(fifo_sz-1)] : din;

      always @(*)
      begin: FIFOPROC
        n_elem = 33'b0;
        for (i = fifo_sz-1; i >= 0; i = i - 1)
        begin
          stat_behind = (i != 0) ? stat[i-1] : 1'b0;
          stat_ahead  = (i != (fifo_sz-1)) ? stat[i+1] : 1'b1;

          // Determine if this buffer element will have data
          stat_nxt = stat_ahead &                       // valid element ahead of this one (or head)
                       (stat_behind                     // valid element behind this one
                         | (stat[i] & (~dout_rdy))      // valid element and output not ready (in use and not shifted)
                         | (stat[i] & din_vld_int)      // valid element and input has data
                         | (din_vld_int & (~dout_rdy))  // input has data and output not ready
                       );
          stat_pre[i] = stat_nxt;

          // First empty elem when not shifting or last valid elem after shifting (assumes stat_behind == 0)
          stat_tail = stat_ahead & (((~stat[i]) & (~dout_rdy)) | (stat[i] & dout_rdy));

          if (dout_rdy & stat_behind)
          begin
            // shift valid element
            buff_nxt[0+:width] = buff[width*(i-1)+:width];
            en_l_var = 1'b1;
          end
          else if (din_vld_int & stat_tail)
          begin
            // update tail with input data
            buff_nxt = din;
            en_l_var = 1'b1;
          end
          else
          begin
            // no-op, disable register
            buff_nxt = din; // Don't care input to disabled flop
            en_l_var = 1'b0;
          end
          buff_pre[width*i+:width] = buff_nxt[0+:width];

          if (ph_en != 0)
            en_l[i] = en & en_l_var;
          else
            en_l[i] = en | ~en_l_var;

          if ((stat_ahead == 1'b1) & (stat[i] == 1'b0))
            //found tail, update the number of elements for count
            n_elem = ($unsigned(fifo_sz) - 1) - $unsigned(i);
        end //for loop

        // Enable for stat registers (partitioned into banks of eight)
        // Take care of the head first
        if (ph_en != 0)
          en_l_s[(((fifo_sz > 0) ? fifo_sz : 1)-1)/8] = en & active;
        else
          en_l_s[(((fifo_sz > 0) ? fifo_sz : 1)-1)/8] = en | ~active;

        // Now every eight
        for (i = fifo_sz-1; i >= 7; i = i - 1)
        begin
          if (($unsigned(i) % 32'd8) == 0)
          begin
            if (ph_en != 0)
              en_l_s[(i/8)-1] = en & (stat[i]) & (active);
            else
              en_l_s[(i/8)-1] = (en) | (~stat[i]) | (~active);
          end
        end

        // Update count and peak
        if ( stat[fifo_sz-1] == 1'b0 )
          count_t = 32'b0;
        else if ( stat[0] == 1'b1 )
          count_t = fifo_sz;
        else
          count_t = n_elem[31:0];
        count = count_t;
        // synopsys translate_off
        peak = (peak < count) ? count : peak;
        // synopsys translate_on
      end //FIFOPROC

      // Handshake valid after reset
      ccs_genreg_v1
      #(
        .width   (1),
        .ph_clk  (ph_clk),
        .ph_en   (1),
        .ph_arst (ph_arst),
        .ph_srst (ph_srst),
        .has_en  (1'b0)
      )
      HS_INIT_REG
      (
        .clk     (clk),
        .en      (1'b1),
        .arst    (arst),
        .srst    (srst),
        .d       (1'b1),
        .z       (hs_init)
      );

      // Buffer and status registers
      for (eni = fifo_sz-1; eni >= 0; eni = eni - 1)
      begin: GEN_REGS
        ccs_genreg_v1
        #(
          .width   (1),
          .ph_clk  (ph_clk),
          .ph_en   (ph_en),
          .ph_arst (ph_arst),
          .ph_srst (ph_srst),
          .has_en  (1'b1)
        )
        STATREG
        (
          .clk     (clk),
          .en      (en_l_s[eni/8]),
          .arst    (arst),
          .srst    (srst),
          .d       (stat_pre[eni]),
          .z       (stat[eni])
        );

        ccs_genreg_v1
        #(
          .width   (width),
          .ph_clk  (ph_clk),
          .ph_en   (ph_en),
          .ph_arst (ph_arst),
          .ph_srst (ph_srst),
          .has_en  (1'b1)
        )
        BUFREG
        (
          .clk     (clk),
          .en      (en_l[eni]),
          .arst    (arst),
          .srst    (srst),
          .d       (buff_pre[width*eni+:width]),
          .z       (buff[width*eni+:width])
        );
      end

    end
    else
    begin: FEED_THRU
      assign din_rdy_drv  = dout_rdy;
      assign dout_vld_drv = din_vld;
      assign dout     = din;
      // non-blocking is not II=1 when fifo_sz=0
      assign sd = {{(sz_width-1){1'b0}}, (din_vld & ~dout_rdy)};
      assign is_idle_drv = ~(din_vld & dout_rdy);
    end
    endgenerate

`ifdef RDY_ASRT
    generate
    if (ph_clk==1)
    begin: POS_CLK_ASSERT

       property rdyAsrt ;
         @(posedge clk) (srst==ph_srst) |=> (din_rdy==0);
       endproperty
       a1Pos: assert property(rdyAsrt);

       property rdyAsrtASync ;
         @(posedge clk) (arst==ph_arst) |-> (din_rdy==0);
       endproperty
       a2Pos: assert property(rdyAsrtASync);

    end else if (ph_clk==0)
    begin: NEG_CLK_ASSERT

       property rdyAsrt ;
         @(negedge clk) ((srst==ph_srst) || (arst==ph_arst)) |=> (din_rdy==0);
       endproperty
       a1Neg: assert property(rdyAsrt);

       property rdyAsrtASync ;
         @(negedge clk) (arst==ph_arst) |-> (din_rdy==0);
       endproperty
       a2Neg: assert property(rdyAsrtASync);

    end
    endgenerate
`endif

endmodule

//------> /usr/cadtool/mentor/Catapult/2023.1/Mgc_home/pkgs/siflibs/ccs_pipe_v6.v 
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
/*
 *
 *            _______________________________________________
 * WRITER    |                                              |          READER
 *           |                 ccs_pipe                     |
 *           |            ______________________            |
 *        --<| din_rdy --<|  ---------------- <|---dout_rdy<|---
 *           |            |       FIFO         |            |
 *        ---|>din_vld ---|> ----------------  |>--dout_vld |>--
 *        ---|>din -------|> ----------------  |> -----dout |>--
 *           |            |____________________|            |
 *           |______________________________________________|
 *
 *    din_rdy     - can be considered as a notFULL signal
 *    dout_vld    - can be considered as a notEMPTY signal
 *    write_stall - an internal debug signal formed from din_vld & !din_rdy
 *    read_stall  - an internal debug signal formed from dout_rdy & !dout_vld
 *    is_idle     - indicates the clock can be safely gated
 *    stall_ctrl  - Stall the pipe(fifo).  Used by STALL_FLAG_SV directive
 */

module ccs_pipe_v6 (clk, en, arst, srst, din_rdy, din_vld, din, dout_rdy, dout_vld, dout, 
                    sz, sz_req, is_idle);

    parameter integer rscid    = 0; // resource ID
    parameter integer width    = 8; // fifo width
    parameter integer sz_width = 8; // width of size of elements in fifo
    parameter integer fifo_sz  = 8; // fifo depth
    parameter integer log2_sz  = 3; // log2(fifo_sz)
    parameter integer ph_clk   = 1; // clock polarity 1=rising edge, 0=falling edge
    parameter integer ph_en    = 1; // clock enable polarity
    parameter integer ph_arst  = 1; // async reset polarity
    parameter integer ph_srst  = 1; // sync reset polarity

    // clock 
    input              clk;
    input              en;
    input              arst;
    input              srst;

    // writer
    output             din_rdy;
    input              din_vld;
    input  [width-1:0] din;

    // reader
    input              dout_rdy;
    output             dout_vld;
    output [width-1:0] dout;

    // size
    output [sz_width-1:0] sz;
    input                 sz_req;
    output                is_idle;

    localparam stallOff = 0; 
    wire                  stall_ctrl;
    assign stall_ctrl = stallOff;
   
    // synopsys translate_off
    wire   write_stall;
    wire   read_stall;
    assign write_stall = (din_vld & !din_rdy) | stall_ctrl;
    assign read_stall  = (dout_rdy & !dout_vld) | stall_ctrl;
    // synopsys translate_on

    wire    tmp_din_rdy;
    assign  din_rdy = tmp_din_rdy & !stall_ctrl;
    wire    tmp_dout_vld;
    assign  dout_vld = tmp_dout_vld & !stall_ctrl;
   
    ccs_fifo_wait_core_v5
    #(
        .rscid    (rscid),
        .width    (width),
        .sz_width (sz_width),
        .fifo_sz  (fifo_sz),
        .ph_clk   (ph_clk),
        .ph_en    (ph_en),
        .ph_arst  (ph_arst),
        .ph_srst  (ph_srst),
        .ph_log2  (log2_sz)
    )
    FIFO
    (
        .clk      (clk),
        .en       (en),
        .arst     (arst),
        .srst     (srst),
        .din_vld  (din_vld & !stall_ctrl),
        .din_rdy  (tmp_din_rdy),
        .din      (din),
        .dout_vld (tmp_dout_vld),
        .dout_rdy (dout_rdy & !stall_ctrl),
        .dout     (dout),
        .sd       (sz),
        .is_idle  (is_idle)
    );

endmodule


//------> ./rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    2023.1/1033555 Production Release
//  HLS Date:       Mon Feb 13 11:32:25 PST 2023
// 
//  Generated by:   m111061545@ws41
//  Generated date: Mon Feb 26 23:43:55 2024
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    EdgeDetect_IP_EdgeDetect_Top
// ------------------------------------------------------------------


module EdgeDetect_IP_EdgeDetect_Top (
  clk, rst, arst_n, dat_in_rsc_dat, dat_in_rsc_vld, dat_in_rsc_rdy, widthIn, heightIn,
      magn_rsc_dat, magn_rsc_vld, magn_rsc_rdy, angle_rsc_dat, angle_rsc_vld, angle_rsc_rdy,
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
  output [8:0] magn_rsc_dat;
  output magn_rsc_vld;
  input magn_rsc_rdy;
  output [7:0] angle_rsc_dat;
  output angle_rsc_vld;
  input angle_rsc_rdy;
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
  wire [7:0] dat_out_rsc_dat_n_VerDer_inst;
  wire [8:0] dy_rsc_dat_n_VerDer_inst;
  wire dy_rsc_rdy_n_VerDer_inst;
  wire line_buf0_rsc_en_n_VerDer_inst;
  wire [15:0] line_buf0_rsc_d_n_VerDer_inst;
  wire [9:0] line_buf0_rsc_adr_n_VerDer_inst;
  wire line_buf1_rsc_en_n_VerDer_inst;
  wire [15:0] line_buf1_rsc_d_n_VerDer_inst;
  wire [9:0] line_buf1_rsc_adr_n_VerDer_inst;
  wire [8:0] dx_rsc_dat_n_HorDer_inst;
  wire [8:0] dy_in_rsc_dat_n_MagAng_inst;
  wire dy_in_rsc_vld_n_MagAng_inst;
  wire [8:0] magn_rsc_dat_n_MagAng_inst;
  wire [7:0] angle_rsc_dat_n_MagAng_inst;
  wire dat_in_rsc_rdy_n_VerDer_inst_bud;
  wire dat_out_rsc_vld_n_VerDer_inst_bud;
  wire dat_in_rsc_rdy_n_HorDer_inst_bud;
  wire dy_rsc_vld_n_VerDer_inst_bud;
  wire dy_in_rsc_rdy_n_MagAng_inst_bud;
  wire line_buf0_rsc_we_n_VerDer_inst_bud;
  wire line_buf1_rsc_we_n_VerDer_inst_bud;
  wire dx_rsc_vld_n_HorDer_inst_bud;
  wire dx_in_rsc_rdy_n_MagAng_inst_bud;
  wire magn_rsc_vld_n_MagAng_inst_bud;
  wire angle_rsc_vld_n_MagAng_inst_bud;
  wire widthIn_triosy_lz_n_MagAng_inst_bud;
  wire heightIn_triosy_lz_n_MagAng_inst_bud;
  wire dy_unc_1;
  wire dy_idle;


  // Interconnect Declarations for Component Instantiations 
  ccs_pipe_v6 #(.rscid(32'sd26),
  .width(32'sd9),
  .sz_width(32'sd1),
  .fifo_sz(32'sd2),
  .log2_sz(32'sd1),
  .ph_clk(32'sd1),
  .ph_en(32'sd0),
  .ph_arst(32'sd0),
  .ph_srst(32'sd1)) dy_cns_pipe (
      .clk(clk),
      .en(1'b0),
      .arst(arst_n),
      .srst(rst),
      .din_rdy(dy_rsc_rdy_n_VerDer_inst),
      .din_vld(dy_rsc_vld_n_VerDer_inst_bud),
      .din(dy_rsc_dat_n_VerDer_inst),
      .dout_rdy(dy_in_rsc_rdy_n_MagAng_inst_bud),
      .dout_vld(dy_in_rsc_vld_n_MagAng_inst),
      .dout(dy_in_rsc_dat_n_MagAng_inst),
      .sz(dy_unc_1),
      .sz_req(1'b0),
      .is_idle(dy_idle)
    );
  EdgeDetect_IP_EdgeDetect_VerDer VerDer_inst (
      .clk(clk),
      .rst(rst),
      .arst_n(arst_n),
      .dat_in_rsc_dat(dat_in_rsc_dat),
      .dat_in_rsc_vld(dat_in_rsc_vld),
      .dat_in_rsc_rdy(dat_in_rsc_rdy_n_VerDer_inst_bud),
      .widthIn(widthIn),
      .heightIn(heightIn),
      .dat_out_rsc_dat(dat_out_rsc_dat_n_VerDer_inst),
      .dat_out_rsc_vld(dat_out_rsc_vld_n_VerDer_inst_bud),
      .dat_out_rsc_rdy(dat_in_rsc_rdy_n_HorDer_inst_bud),
      .dy_rsc_dat(dy_rsc_dat_n_VerDer_inst),
      .dy_rsc_vld(dy_rsc_vld_n_VerDer_inst_bud),
      .dy_rsc_rdy(dy_rsc_rdy_n_VerDer_inst),
      .line_buf0_rsc_en(line_buf0_rsc_en_n_VerDer_inst),
      .line_buf0_rsc_q(line_buf0_rsc_q),
      .line_buf0_rsc_we(line_buf0_rsc_we_n_VerDer_inst_bud),
      .line_buf0_rsc_d(line_buf0_rsc_d_n_VerDer_inst),
      .line_buf0_rsc_adr(line_buf0_rsc_adr_n_VerDer_inst),
      .line_buf1_rsc_en(line_buf1_rsc_en_n_VerDer_inst),
      .line_buf1_rsc_q(line_buf1_rsc_q),
      .line_buf1_rsc_we(line_buf1_rsc_we_n_VerDer_inst_bud),
      .line_buf1_rsc_d(line_buf1_rsc_d_n_VerDer_inst),
      .line_buf1_rsc_adr(line_buf1_rsc_adr_n_VerDer_inst)
    );
  EdgeDetect_IP_EdgeDetect_HorDer HorDer_inst (
      .clk(clk),
      .rst(rst),
      .arst_n(arst_n),
      .dat_in_rsc_dat(dat_out_rsc_dat_n_VerDer_inst),
      .dat_in_rsc_vld(dat_out_rsc_vld_n_VerDer_inst_bud),
      .dat_in_rsc_rdy(dat_in_rsc_rdy_n_HorDer_inst_bud),
      .widthIn(widthIn),
      .heightIn(heightIn),
      .dx_rsc_dat(dx_rsc_dat_n_HorDer_inst),
      .dx_rsc_vld(dx_rsc_vld_n_HorDer_inst_bud),
      .dx_rsc_rdy(dx_in_rsc_rdy_n_MagAng_inst_bud)
    );
  EdgeDetect_IP_EdgeDetect_MagAng MagAng_inst (
      .clk(clk),
      .rst(rst),
      .arst_n(arst_n),
      .dx_in_rsc_dat(dx_rsc_dat_n_HorDer_inst),
      .dx_in_rsc_vld(dx_rsc_vld_n_HorDer_inst_bud),
      .dx_in_rsc_rdy(dx_in_rsc_rdy_n_MagAng_inst_bud),
      .dy_in_rsc_dat(dy_in_rsc_dat_n_MagAng_inst),
      .dy_in_rsc_vld(dy_in_rsc_vld_n_MagAng_inst),
      .dy_in_rsc_rdy(dy_in_rsc_rdy_n_MagAng_inst_bud),
      .widthIn_rsc_dat(11'b00000000000),
      .widthIn_triosy_lz(widthIn_triosy_lz_n_MagAng_inst_bud),
      .heightIn_rsc_dat(10'b0000000000),
      .heightIn_triosy_lz(heightIn_triosy_lz_n_MagAng_inst_bud),
      .magn_rsc_dat(magn_rsc_dat_n_MagAng_inst),
      .magn_rsc_vld(magn_rsc_vld_n_MagAng_inst_bud),
      .magn_rsc_rdy(magn_rsc_rdy),
      .angle_rsc_dat(angle_rsc_dat_n_MagAng_inst),
      .angle_rsc_vld(angle_rsc_vld_n_MagAng_inst_bud),
      .angle_rsc_rdy(angle_rsc_rdy)
    );
  assign dat_in_rsc_rdy = dat_in_rsc_rdy_n_VerDer_inst_bud;
  assign line_buf0_rsc_en = line_buf0_rsc_en_n_VerDer_inst;
  assign line_buf0_rsc_we = line_buf0_rsc_we_n_VerDer_inst_bud;
  assign line_buf0_rsc_d = line_buf0_rsc_d_n_VerDer_inst;
  assign line_buf0_rsc_adr = line_buf0_rsc_adr_n_VerDer_inst;
  assign line_buf1_rsc_en = line_buf1_rsc_en_n_VerDer_inst;
  assign line_buf1_rsc_we = line_buf1_rsc_we_n_VerDer_inst_bud;
  assign line_buf1_rsc_d = line_buf1_rsc_d_n_VerDer_inst;
  assign line_buf1_rsc_adr = line_buf1_rsc_adr_n_VerDer_inst;
  assign magn_rsc_vld = magn_rsc_vld_n_MagAng_inst_bud;
  assign magn_rsc_dat = magn_rsc_dat_n_MagAng_inst;
  assign angle_rsc_vld = angle_rsc_vld_n_MagAng_inst_bud;
  assign angle_rsc_dat = angle_rsc_dat_n_MagAng_inst;
endmodule



