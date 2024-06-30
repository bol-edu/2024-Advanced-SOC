
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




//------> ./rtl.v 
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



