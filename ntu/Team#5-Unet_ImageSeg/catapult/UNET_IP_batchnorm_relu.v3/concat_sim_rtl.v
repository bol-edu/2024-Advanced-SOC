
//------> /home/raid7_4/raid1_1/linux/mentor/Catapult/2023.2/Mgc_home/pkgs/siflibs/mgc_io_sync_v2.v 
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


//------> /home/raid7_4/raid1_1/linux/mentor/Catapult/2023.2/Mgc_home/pkgs/hls_pkgs/mgc_comps_src/mgc_div_beh.v 
module mgc_div(a,b,z);
   parameter width_a = 8;
   parameter width_b = 8;
   parameter signd = 1;
   input [width_a-1:0] a;
   input [width_b-1:0] b; 
   output [width_a-1:0] z;  
   reg  [width_a-1:0] z;

   always@(a or b)
     begin
	if(signd)
	  div_s(a,b,z);
	else
          div_u(a,b,z);
     end


//-----------------------------------------------------------------
//     -- Vectorized Overloaded Arithmetic Operators
//-----------------------------------------------------------------
   
   function [width_a-1:0] fabs_l; 
      input [width_a-1:0] arg1;
      begin
         case(arg1[width_a-1])
            1'b1:
               fabs_l = {(width_a){1'b0}} - arg1;
            default: // was: 1'b0:
               fabs_l = arg1;
         endcase
      end
   endfunction
   
   function [width_b-1:0] fabs_r; 
      input [width_b-1:0] arg1;
      begin
         case (arg1[width_b-1])
            1'b1:
               fabs_r =  {(width_b){1'b0}} - arg1;
            default: // was: 1'b0:
               fabs_r = arg1;
         endcase
      end
   endfunction

   function [width_b:0] minus;
     input [width_b:0] in1;
     input [width_b:0] in2;
     reg [width_b+1:0] tmp;
     begin
       tmp = in1 - in2;
       minus = tmp[width_b:0];
     end
   endfunction

   
   task divmod;
      input [width_a-1:0] l;
      input [width_b-1:0] r;
      output [width_a-1:0] rdiv;
      output [width_b-1:0] rmod;
      
      parameter llen = width_a;
      parameter rlen = width_b;
      reg [(llen+rlen)-1:0] lbuf;
      reg [rlen:0] diff;
	  integer i;
      begin
	 lbuf = {(llen+rlen){1'b0}};
//64'b0;
	 lbuf[llen-1:0] = l;
	 for(i=width_a-1;i>=0;i=i-1)
	   begin
              diff = minus(lbuf[(llen+rlen)-1:llen-1], {1'b0,r});
	      rdiv[i] = ~diff[rlen];
	      if(diff[rlen] == 0)
		lbuf[(llen+rlen)-1:llen-1] = diff;
	      lbuf[(llen+rlen)-1:1] = lbuf[(llen+rlen)-2:0];
	   end
	 rmod = lbuf[(llen+rlen)-1:llen];
      end
   endtask
      

   task div_u;
      input [width_a-1:0] l;
      input [width_b-1:0] r;
      output [width_a-1:0] rdiv;
      
      reg [width_a-01:0] rdiv;
      reg [width_b-1:0] rmod;
      begin
	 divmod(l, r, rdiv, rmod);
      end
   endtask
   
   task mod_u;
      input [width_a-1:0] l;
      input [width_b-1:0] r;
      output [width_b-1:0] rmod;
      
      reg [width_a-01:0] rdiv;
      reg [width_b-1:0] rmod;
      begin
	 divmod(l, r, rdiv, rmod);
      end
   endtask

   task rem_u; 
      input [width_a-1:0] l;
      input [width_b-1:0] r;    
      output [width_b-1:0] rmod;
      begin
	 mod_u(l,r,rmod);
      end
   endtask // rem_u

   task div_s;
      input [width_a-1:0] l;
      input [width_b-1:0] r;
      output [width_a-1:0] rdiv;
      
      reg [width_a-01:0] rdiv;
      reg [width_b-1:0] rmod;
      begin
	 divmod(fabs_l(l), fabs_r(r),rdiv,rmod);
	 if(l[width_a-1] != r[width_b-1])
	   rdiv = {(width_a){1'b0}} - rdiv;
      end
   endtask

   task mod_s;
      input [width_a-1:0] l;
      input [width_b-1:0] r;
      output [width_b-1:0] rmod;
      
      reg [width_a-01:0] rdiv;
      reg [width_b-1:0] rmod;
      reg [width_b-1:0] rnul;
      reg [width_b:0] rmod_t;
      begin
         rnul = {width_b{1'b0}};
	 divmod(fabs_l(l), fabs_r(r), rdiv, rmod);
         if (l[width_a-1])
	   rmod = {(width_b){1'b0}} - rmod;
	 if((rmod != rnul) && (l[width_a-1] != r[width_b-1]))
            begin
               rmod_t = r + rmod;
               rmod = rmod_t[width_b-1:0];
            end
      end
   endtask // mod_s
   
   task rem_s; 
      input [width_a-1:0] l;
      input [width_b-1:0] r;    
      output [width_b-1:0] rmod;   
      reg [width_a-01:0] rdiv;
      reg [width_b-1:0] rmod;
      begin
	 divmod(fabs_l(l),fabs_r(r),rdiv,rmod);
	 if(l[width_a-1])
	   rmod = {(width_b){1'b0}} - rmod;
      end
   endtask

  endmodule

//------> /home/raid7_4/raid1_1/linux/mentor/Catapult/2023.2/Mgc_home/pkgs/siflibs/mgc_shift_bl_beh_v5.v 
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

//------> ../td_ccore_solutions/leading_sign_22_0_dc00658b4b4575636e73bb7f99c473ff6c07_0/rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    2023.2/1059873 Production Release
//  HLS Date:       Mon Aug  7 10:54:31 PDT 2023
// 
//  Generated by:   r12016@cad40
//  Generated date: Thu Jun 13 03:06:16 2024
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    leading_sign_22_0
// ------------------------------------------------------------------


module leading_sign_22_0 (
  mantissa, rtn
);
  input [21:0] mantissa;
  output [4:0] rtn;


  // Interconnect Declarations
  wire ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_6_2_sdt_2;
  wire ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_18_3_sdt_3;
  wire ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_26_2_sdt_2;
  wire ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_42_4_sdt_4;
  wire ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_50_2_sdt_2;
  wire ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_14_2_sdt_1;
  wire ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_26_2_sdt_1;
  wire ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_34_2_sdt_1;
  wire ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_50_2_sdt_1;
  wire c_h_1_2;
  wire c_h_1_5;
  wire c_h_1_6;
  wire c_h_1_8;
  wire c_h_1_9;
  wire ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_and_83_ssc;

  wire ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_and_nl;
  wire ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_and_77_nl;
  wire ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_or_2_nl;
  wire ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leadi000000;

  // Interconnect Declarations for Component Instantiations 
  assign ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_6_2_sdt_2
      = ~((mantissa[19:18]!=2'b00));
  assign ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_14_2_sdt_1
      = ~((mantissa[17:16]!=2'b00));
  assign c_h_1_2 = (~ (mantissa[20])) & ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_6_2_sdt_2;
  assign ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_18_3_sdt_3
      = (mantissa[15:14]==2'b00) & ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_14_2_sdt_1;
  assign ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_26_2_sdt_2
      = ~((mantissa[11:10]!=2'b00));
  assign ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_26_2_sdt_1
      = ~((mantissa[13:12]!=2'b00));
  assign ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_34_2_sdt_1
      = ~((mantissa[9:8]!=2'b00));
  assign c_h_1_5 = ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_26_2_sdt_1
      & ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_26_2_sdt_2;
  assign c_h_1_6 = c_h_1_2 & ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_18_3_sdt_3;
  assign ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_42_4_sdt_4
      = (mantissa[7:6]==2'b00) & ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_34_2_sdt_1
      & c_h_1_5;
  assign ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_50_2_sdt_2
      = ~((mantissa[3:2]!=2'b00));
  assign ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_50_2_sdt_1
      = ~((mantissa[5:4]!=2'b00));
  assign c_h_1_8 = ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_50_2_sdt_1
      & ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_50_2_sdt_2;
  assign c_h_1_9 = c_h_1_6 & ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_42_4_sdt_4;
  assign ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_and_83_ssc
      = (mantissa[1:0]==2'b00) & c_h_1_8 & c_h_1_9;
  assign ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_and_nl
      = c_h_1_6 & (~ ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_42_4_sdt_4);
  assign ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_and_77_nl
      = c_h_1_2 & (c_h_1_5 | (~ ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_18_3_sdt_3))
      & (c_h_1_8 | (~ c_h_1_9));
  assign ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_or_2_nl
      = (~((mantissa[20]) | (~(ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_14_2_sdt_1
      | (~ ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_6_2_sdt_2)))
      | ((~(ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_26_2_sdt_1
      & (ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_34_2_sdt_1
      | (~ ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_26_2_sdt_2))))
      & c_h_1_6) | ((~(ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_50_2_sdt_1
      & (~ ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_50_2_sdt_2)))
      & c_h_1_9))) | ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_and_83_ssc;
  assign ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leadi000000
      = ~((~((mantissa[20:19]!=2'b01))) | (((mantissa[17]) | (~((mantissa[16:15]!=2'b01))))
      & c_h_1_2) | ((~((~((mantissa[13]) | (~((mantissa[12:11]!=2'b01))))) & (~(((mantissa[9])
      | (~((mantissa[8:7]!=2'b01)))) & c_h_1_5)))) & c_h_1_6) | ((~((~((mantissa[5])
      | (~((mantissa[4:3]!=2'b01))))) & (~((mantissa[1]) & c_h_1_8)))) & c_h_1_9)
      | ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_and_83_ssc);
  assign rtn = {c_h_1_9 , ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_and_nl
      , ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_and_77_nl
      , ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_or_2_nl
      , ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leadi000000};
endmodule




//------> /home/raid7_4/raid1_1/linux/mentor/Catapult/2023.2/Mgc_home/pkgs/siflibs/mgc_shift_l_beh_v5.v 
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

//------> ./rtl_UNET_IP_batchnorm_relumgc_rom_11_736_5_1.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    2023.2/1059873 Production Release
//  HLS Date:       Mon Aug  7 10:54:31 PDT 2023
// 
//  Generated by:   r12016@cad40
//  Generated date: Thu Jun 13 03:09:42 2024
// ----------------------------------------------------------------------

// 
module UNET_IP_batchnorm_relumgc_rom_11_736_5_1 (addr, data_out
);
  input [9:0]addr ;
  output [4:0]data_out ;


  // Constants for ROM dimensions
  parameter n_width    = 5;
  parameter n_size     = 736;
  parameter n_numports = 1;
  parameter n_addr_w   = 10;
  parameter n_inreg    = 0;
  parameter n_outreg   = 0;

  // Declare storage for memory elements
  reg [4:0] mem [735:0];

  // Declare output registers
  reg [4:0] data_out_t;

  // Initialize ROM contents
  initial begin: rom_init_blk
    mem[0] <= 5'b10000;
    mem[1] <= 5'b01111;
    mem[2] <= 5'b10000;
    mem[3] <= 5'b01111;
    mem[4] <= 5'b01111;
    mem[5] <= 5'b10000;
    mem[6] <= 5'b01111;
    mem[7] <= 5'b01111;
    mem[8] <= 5'b10000;
    mem[9] <= 5'b01111;
    mem[10] <= 5'b01111;
    mem[11] <= 5'b01111;
    mem[12] <= 5'b10000;
    mem[13] <= 5'b01111;
    mem[14] <= 5'b01111;
    mem[15] <= 5'b01111;
    mem[16] <= 5'b10000;
    mem[17] <= 5'b01111;
    mem[18] <= 5'b01111;
    mem[19] <= 5'b10000;
    mem[20] <= 5'b10000;
    mem[21] <= 5'b01111;
    mem[22] <= 5'b10000;
    mem[23] <= 5'b01111;
    mem[24] <= 5'b01111;
    mem[25] <= 5'b10000;
    mem[26] <= 5'b10000;
    mem[27] <= 5'b01111;
    mem[28] <= 5'b01111;
    mem[29] <= 5'b10000;
    mem[30] <= 5'b10000;
    mem[31] <= 5'b10000;
    mem[32] <= 5'b01111;
    mem[33] <= 5'b10000;
    mem[34] <= 5'b01111;
    mem[35] <= 5'b10000;
    mem[36] <= 5'b10000;
    mem[37] <= 5'b01111;
    mem[38] <= 5'b01111;
    mem[39] <= 5'b10000;
    mem[40] <= 5'b10000;
    mem[41] <= 5'b10000;
    mem[42] <= 5'b10000;
    mem[43] <= 5'b10000;
    mem[44] <= 5'b10000;
    mem[45] <= 5'b10000;
    mem[46] <= 5'b01111;
    mem[47] <= 5'b01111;
    mem[48] <= 5'b01111;
    mem[49] <= 5'b01111;
    mem[50] <= 5'b10000;
    mem[51] <= 5'b10000;
    mem[52] <= 5'b10000;
    mem[53] <= 5'b10000;
    mem[54] <= 5'b01111;
    mem[55] <= 5'b01111;
    mem[56] <= 5'b10000;
    mem[57] <= 5'b10000;
    mem[58] <= 5'b10000;
    mem[59] <= 5'b10000;
    mem[60] <= 5'b01111;
    mem[61] <= 5'b10000;
    mem[62] <= 5'b10000;
    mem[63] <= 5'b10000;
    mem[64] <= 5'b01111;
    mem[65] <= 5'b01111;
    mem[66] <= 5'b01111;
    mem[67] <= 5'b10000;
    mem[68] <= 5'b01111;
    mem[69] <= 5'b10000;
    mem[70] <= 5'b10000;
    mem[71] <= 5'b01111;
    mem[72] <= 5'b10000;
    mem[73] <= 5'b01111;
    mem[74] <= 5'b01111;
    mem[75] <= 5'b10000;
    mem[76] <= 5'b10000;
    mem[77] <= 5'b01111;
    mem[78] <= 5'b10000;
    mem[79] <= 5'b10000;
    mem[80] <= 5'b10000;
    mem[81] <= 5'b01111;
    mem[82] <= 5'b10000;
    mem[83] <= 5'b10000;
    mem[84] <= 5'b01111;
    mem[85] <= 5'b01111;
    mem[86] <= 5'b10000;
    mem[87] <= 5'b01111;
    mem[88] <= 5'b10000;
    mem[89] <= 5'b10000;
    mem[90] <= 5'b01111;
    mem[91] <= 5'b10000;
    mem[92] <= 5'b01111;
    mem[93] <= 5'b10000;
    mem[94] <= 5'b10000;
    mem[95] <= 5'b01111;
    mem[96] <= 5'b10000;
    mem[97] <= 5'b01111;
    mem[98] <= 5'b01111;
    mem[99] <= 5'b01111;
    mem[100] <= 5'b10000;
    mem[101] <= 5'b01111;
    mem[102] <= 5'b10000;
    mem[103] <= 5'b01111;
    mem[104] <= 5'b10000;
    mem[105] <= 5'b01111;
    mem[106] <= 5'b01111;
    mem[107] <= 5'b10000;
    mem[108] <= 5'b10000;
    mem[109] <= 5'b01111;
    mem[110] <= 5'b10000;
    mem[111] <= 5'b10000;
    mem[112] <= 5'b10000;
    mem[113] <= 5'b10000;
    mem[114] <= 5'b01111;
    mem[115] <= 5'b01111;
    mem[116] <= 5'b10000;
    mem[117] <= 5'b10000;
    mem[118] <= 5'b10000;
    mem[119] <= 5'b01111;
    mem[120] <= 5'b01111;
    mem[121] <= 5'b01111;
    mem[122] <= 5'b10000;
    mem[123] <= 5'b01111;
    mem[124] <= 5'b01111;
    mem[125] <= 5'b01111;
    mem[126] <= 5'b10000;
    mem[127] <= 5'b10000;
    mem[128] <= 5'b01111;
    mem[129] <= 5'b10000;
    mem[130] <= 5'b10000;
    mem[131] <= 5'b10000;
    mem[132] <= 5'b10000;
    mem[133] <= 5'b10000;
    mem[134] <= 5'b10000;
    mem[135] <= 5'b01111;
    mem[136] <= 5'b01111;
    mem[137] <= 5'b10000;
    mem[138] <= 5'b01111;
    mem[139] <= 5'b10000;
    mem[140] <= 5'b10000;
    mem[141] <= 5'b01111;
    mem[142] <= 5'b01111;
    mem[143] <= 5'b10000;
    mem[144] <= 5'b01111;
    mem[145] <= 5'b10000;
    mem[146] <= 5'b01111;
    mem[147] <= 5'b10000;
    mem[148] <= 5'b01111;
    mem[149] <= 5'b01111;
    mem[150] <= 5'b01111;
    mem[151] <= 5'b10000;
    mem[152] <= 5'b01111;
    mem[153] <= 5'b01111;
    mem[154] <= 5'b01111;
    mem[155] <= 5'b10000;
    mem[156] <= 5'b01111;
    mem[157] <= 5'b10000;
    mem[158] <= 5'b01111;
    mem[159] <= 5'b01111;
    mem[160] <= 5'b10000;
    mem[161] <= 5'b01111;
    mem[162] <= 5'b01111;
    mem[163] <= 5'b10000;
    mem[164] <= 5'b01111;
    mem[165] <= 5'b10000;
    mem[166] <= 5'b10000;
    mem[167] <= 5'b01111;
    mem[168] <= 5'b01111;
    mem[169] <= 5'b10000;
    mem[170] <= 5'b10000;
    mem[171] <= 5'b01111;
    mem[172] <= 5'b01111;
    mem[173] <= 5'b01111;
    mem[174] <= 5'b01111;
    mem[175] <= 5'b10000;
    mem[176] <= 5'b10000;
    mem[177] <= 5'b01111;
    mem[178] <= 5'b01111;
    mem[179] <= 5'b01111;
    mem[180] <= 5'b01111;
    mem[181] <= 5'b10000;
    mem[182] <= 5'b01111;
    mem[183] <= 5'b01111;
    mem[184] <= 5'b10000;
    mem[185] <= 5'b10000;
    mem[186] <= 5'b10000;
    mem[187] <= 5'b01111;
    mem[188] <= 5'b01111;
    mem[189] <= 5'b10000;
    mem[190] <= 5'b10000;
    mem[191] <= 5'b01111;
    mem[192] <= 5'b01111;
    mem[193] <= 5'b10000;
    mem[194] <= 5'b01111;
    mem[195] <= 5'b01111;
    mem[196] <= 5'b01111;
    mem[197] <= 5'b10000;
    mem[198] <= 5'b10000;
    mem[199] <= 5'b01111;
    mem[200] <= 5'b01111;
    mem[201] <= 5'b01111;
    mem[202] <= 5'b01111;
    mem[203] <= 5'b01111;
    mem[204] <= 5'b10000;
    mem[205] <= 5'b01111;
    mem[206] <= 5'b01111;
    mem[207] <= 5'b10000;
    mem[208] <= 5'b10000;
    mem[209] <= 5'b01111;
    mem[210] <= 5'b10000;
    mem[211] <= 5'b01111;
    mem[212] <= 5'b10000;
    mem[213] <= 5'b10000;
    mem[214] <= 5'b01111;
    mem[215] <= 5'b01111;
    mem[216] <= 5'b01111;
    mem[217] <= 5'b01111;
    mem[218] <= 5'b10000;
    mem[219] <= 5'b01111;
    mem[220] <= 5'b10000;
    mem[221] <= 5'b01111;
    mem[222] <= 5'b01111;
    mem[223] <= 5'b01111;
    mem[224] <= 5'b01111;
    mem[225] <= 5'b10000;
    mem[226] <= 5'b01111;
    mem[227] <= 5'b10000;
    mem[228] <= 5'b01111;
    mem[229] <= 5'b10000;
    mem[230] <= 5'b01111;
    mem[231] <= 5'b10000;
    mem[232] <= 5'b10000;
    mem[233] <= 5'b01111;
    mem[234] <= 5'b01111;
    mem[235] <= 5'b01111;
    mem[236] <= 5'b01111;
    mem[237] <= 5'b01111;
    mem[238] <= 5'b01111;
    mem[239] <= 5'b10000;
    mem[240] <= 5'b01111;
    mem[241] <= 5'b01111;
    mem[242] <= 5'b01111;
    mem[243] <= 5'b01111;
    mem[244] <= 5'b10000;
    mem[245] <= 5'b01111;
    mem[246] <= 5'b01111;
    mem[247] <= 5'b10000;
    mem[248] <= 5'b01111;
    mem[249] <= 5'b01111;
    mem[250] <= 5'b01111;
    mem[251] <= 5'b10000;
    mem[252] <= 5'b10000;
    mem[253] <= 5'b01111;
    mem[254] <= 5'b01111;
    mem[255] <= 5'b01111;
    mem[256] <= 5'b01111;
    mem[257] <= 5'b01111;
    mem[258] <= 5'b01111;
    mem[259] <= 5'b10000;
    mem[260] <= 5'b01111;
    mem[261] <= 5'b01111;
    mem[262] <= 5'b01111;
    mem[263] <= 5'b10000;
    mem[264] <= 5'b10000;
    mem[265] <= 5'b01111;
    mem[266] <= 5'b01111;
    mem[267] <= 5'b01111;
    mem[268] <= 5'b01111;
    mem[269] <= 5'b01111;
    mem[270] <= 5'b01111;
    mem[271] <= 5'b01111;
    mem[272] <= 5'b01111;
    mem[273] <= 5'b10000;
    mem[274] <= 5'b01111;
    mem[275] <= 5'b01111;
    mem[276] <= 5'b01111;
    mem[277] <= 5'b01111;
    mem[278] <= 5'b01111;
    mem[279] <= 5'b10000;
    mem[280] <= 5'b01111;
    mem[281] <= 5'b01111;
    mem[282] <= 5'b01111;
    mem[283] <= 5'b01111;
    mem[284] <= 5'b01111;
    mem[285] <= 5'b01111;
    mem[286] <= 5'b01111;
    mem[287] <= 5'b01111;
    mem[288] <= 5'b01111;
    mem[289] <= 5'b01111;
    mem[290] <= 5'b01111;
    mem[291] <= 5'b01111;
    mem[292] <= 5'b10000;
    mem[293] <= 5'b01111;
    mem[294] <= 5'b01111;
    mem[295] <= 5'b01111;
    mem[296] <= 5'b10000;
    mem[297] <= 5'b10000;
    mem[298] <= 5'b10000;
    mem[299] <= 5'b01111;
    mem[300] <= 5'b01111;
    mem[301] <= 5'b01111;
    mem[302] <= 5'b10000;
    mem[303] <= 5'b10000;
    mem[304] <= 5'b01111;
    mem[305] <= 5'b10000;
    mem[306] <= 5'b10000;
    mem[307] <= 5'b01111;
    mem[308] <= 5'b10000;
    mem[309] <= 5'b01111;
    mem[310] <= 5'b10000;
    mem[311] <= 5'b10000;
    mem[312] <= 5'b01111;
    mem[313] <= 5'b01111;
    mem[314] <= 5'b10000;
    mem[315] <= 5'b01111;
    mem[316] <= 5'b01111;
    mem[317] <= 5'b01111;
    mem[318] <= 5'b01111;
    mem[319] <= 5'b10000;
    mem[320] <= 5'b01111;
    mem[321] <= 5'b10000;
    mem[322] <= 5'b01111;
    mem[323] <= 5'b01111;
    mem[324] <= 5'b10000;
    mem[325] <= 5'b01111;
    mem[326] <= 5'b01111;
    mem[327] <= 5'b01111;
    mem[328] <= 5'b01111;
    mem[329] <= 5'b01111;
    mem[330] <= 5'b01111;
    mem[331] <= 5'b01111;
    mem[332] <= 5'b10000;
    mem[333] <= 5'b01111;
    mem[334] <= 5'b10000;
    mem[335] <= 5'b01111;
    mem[336] <= 5'b01111;
    mem[337] <= 5'b01111;
    mem[338] <= 5'b10000;
    mem[339] <= 5'b01111;
    mem[340] <= 5'b10000;
    mem[341] <= 5'b01111;
    mem[342] <= 5'b01111;
    mem[343] <= 5'b01111;
    mem[344] <= 5'b01111;
    mem[345] <= 5'b10000;
    mem[346] <= 5'b01111;
    mem[347] <= 5'b01111;
    mem[348] <= 5'b01111;
    mem[349] <= 5'b01111;
    mem[350] <= 5'b01111;
    mem[351] <= 5'b01111;
    mem[352] <= 5'b01111;
    mem[353] <= 5'b01111;
    mem[354] <= 5'b01111;
    mem[355] <= 5'b10000;
    mem[356] <= 5'b01111;
    mem[357] <= 5'b01111;
    mem[358] <= 5'b01111;
    mem[359] <= 5'b10000;
    mem[360] <= 5'b01111;
    mem[361] <= 5'b10000;
    mem[362] <= 5'b10000;
    mem[363] <= 5'b01111;
    mem[364] <= 5'b01111;
    mem[365] <= 5'b01111;
    mem[366] <= 5'b01111;
    mem[367] <= 5'b10000;
    mem[368] <= 5'b01111;
    mem[369] <= 5'b10000;
    mem[370] <= 5'b01111;
    mem[371] <= 5'b01111;
    mem[372] <= 5'b01111;
    mem[373] <= 5'b01111;
    mem[374] <= 5'b01111;
    mem[375] <= 5'b01111;
    mem[376] <= 5'b01111;
    mem[377] <= 5'b01111;
    mem[378] <= 5'b10000;
    mem[379] <= 5'b10000;
    mem[380] <= 5'b01111;
    mem[381] <= 5'b01111;
    mem[382] <= 5'b10000;
    mem[383] <= 5'b01111;
    mem[384] <= 5'b01111;
    mem[385] <= 5'b01111;
    mem[386] <= 5'b01111;
    mem[387] <= 5'b01111;
    mem[388] <= 5'b01111;
    mem[389] <= 5'b10000;
    mem[390] <= 5'b01111;
    mem[391] <= 5'b10000;
    mem[392] <= 5'b01111;
    mem[393] <= 5'b01111;
    mem[394] <= 5'b01111;
    mem[395] <= 5'b01111;
    mem[396] <= 5'b01111;
    mem[397] <= 5'b01111;
    mem[398] <= 5'b01111;
    mem[399] <= 5'b01111;
    mem[400] <= 5'b01111;
    mem[401] <= 5'b01111;
    mem[402] <= 5'b01111;
    mem[403] <= 5'b10000;
    mem[404] <= 5'b01111;
    mem[405] <= 5'b01111;
    mem[406] <= 5'b01111;
    mem[407] <= 5'b10000;
    mem[408] <= 5'b01111;
    mem[409] <= 5'b01111;
    mem[410] <= 5'b01111;
    mem[411] <= 5'b01111;
    mem[412] <= 5'b10000;
    mem[413] <= 5'b01111;
    mem[414] <= 5'b01111;
    mem[415] <= 5'b10000;
    mem[416] <= 5'b01111;
    mem[417] <= 5'b10000;
    mem[418] <= 5'b10000;
    mem[419] <= 5'b10000;
    mem[420] <= 5'b10000;
    mem[421] <= 5'b10000;
    mem[422] <= 5'b01111;
    mem[423] <= 5'b01111;
    mem[424] <= 5'b01111;
    mem[425] <= 5'b01111;
    mem[426] <= 5'b01111;
    mem[427] <= 5'b10000;
    mem[428] <= 5'b01111;
    mem[429] <= 5'b01111;
    mem[430] <= 5'b01111;
    mem[431] <= 5'b01111;
    mem[432] <= 5'b01111;
    mem[433] <= 5'b01111;
    mem[434] <= 5'b01111;
    mem[435] <= 5'b10000;
    mem[436] <= 5'b01111;
    mem[437] <= 5'b01111;
    mem[438] <= 5'b01111;
    mem[439] <= 5'b01111;
    mem[440] <= 5'b10000;
    mem[441] <= 5'b01111;
    mem[442] <= 5'b01111;
    mem[443] <= 5'b10000;
    mem[444] <= 5'b01111;
    mem[445] <= 5'b01111;
    mem[446] <= 5'b01111;
    mem[447] <= 5'b01111;
    mem[448] <= 5'b01111;
    mem[449] <= 5'b01111;
    mem[450] <= 5'b01111;
    mem[451] <= 5'b01111;
    mem[452] <= 5'b01111;
    mem[453] <= 5'b01111;
    mem[454] <= 5'b01111;
    mem[455] <= 5'b01111;
    mem[456] <= 5'b01111;
    mem[457] <= 5'b10000;
    mem[458] <= 5'b10000;
    mem[459] <= 5'b10000;
    mem[460] <= 5'b01111;
    mem[461] <= 5'b01111;
    mem[462] <= 5'b01111;
    mem[463] <= 5'b10000;
    mem[464] <= 5'b01111;
    mem[465] <= 5'b01111;
    mem[466] <= 5'b10000;
    mem[467] <= 5'b01111;
    mem[468] <= 5'b01111;
    mem[469] <= 5'b10000;
    mem[470] <= 5'b01111;
    mem[471] <= 5'b01111;
    mem[472] <= 5'b01111;
    mem[473] <= 5'b01111;
    mem[474] <= 5'b01111;
    mem[475] <= 5'b01111;
    mem[476] <= 5'b01111;
    mem[477] <= 5'b01111;
    mem[478] <= 5'b01111;
    mem[479] <= 5'b01111;
    mem[480] <= 5'b01111;
    mem[481] <= 5'b01111;
    mem[482] <= 5'b01111;
    mem[483] <= 5'b01111;
    mem[484] <= 5'b01111;
    mem[485] <= 5'b01111;
    mem[486] <= 5'b01111;
    mem[487] <= 5'b01111;
    mem[488] <= 5'b10000;
    mem[489] <= 5'b10000;
    mem[490] <= 5'b01111;
    mem[491] <= 5'b01111;
    mem[492] <= 5'b01111;
    mem[493] <= 5'b01111;
    mem[494] <= 5'b01111;
    mem[495] <= 5'b01111;
    mem[496] <= 5'b01111;
    mem[497] <= 5'b10000;
    mem[498] <= 5'b01111;
    mem[499] <= 5'b01111;
    mem[500] <= 5'b01111;
    mem[501] <= 5'b10000;
    mem[502] <= 5'b10000;
    mem[503] <= 5'b01111;
    mem[504] <= 5'b01111;
    mem[505] <= 5'b01111;
    mem[506] <= 5'b01111;
    mem[507] <= 5'b10000;
    mem[508] <= 5'b01111;
    mem[509] <= 5'b10000;
    mem[510] <= 5'b01111;
    mem[511] <= 5'b10000;
    mem[512] <= 5'b10000;
    mem[513] <= 5'b10000;
    mem[514] <= 5'b10000;
    mem[515] <= 5'b01111;
    mem[516] <= 5'b01111;
    mem[517] <= 5'b10000;
    mem[518] <= 5'b01111;
    mem[519] <= 5'b10000;
    mem[520] <= 5'b10000;
    mem[521] <= 5'b10000;
    mem[522] <= 5'b10000;
    mem[523] <= 5'b01111;
    mem[524] <= 5'b01111;
    mem[525] <= 5'b10000;
    mem[526] <= 5'b10000;
    mem[527] <= 5'b01111;
    mem[528] <= 5'b10000;
    mem[529] <= 5'b10000;
    mem[530] <= 5'b01111;
    mem[531] <= 5'b10000;
    mem[532] <= 5'b01111;
    mem[533] <= 5'b10000;
    mem[534] <= 5'b01111;
    mem[535] <= 5'b01111;
    mem[536] <= 5'b01111;
    mem[537] <= 5'b01111;
    mem[538] <= 5'b01111;
    mem[539] <= 5'b01111;
    mem[540] <= 5'b01111;
    mem[541] <= 5'b01111;
    mem[542] <= 5'b01111;
    mem[543] <= 5'b10000;
    mem[544] <= 5'b01111;
    mem[545] <= 5'b01111;
    mem[546] <= 5'b01111;
    mem[547] <= 5'b01111;
    mem[548] <= 5'b01111;
    mem[549] <= 5'b10000;
    mem[550] <= 5'b01111;
    mem[551] <= 5'b10000;
    mem[552] <= 5'b01111;
    mem[553] <= 5'b10000;
    mem[554] <= 5'b01111;
    mem[555] <= 5'b10000;
    mem[556] <= 5'b10000;
    mem[557] <= 5'b10000;
    mem[558] <= 5'b10000;
    mem[559] <= 5'b01111;
    mem[560] <= 5'b10000;
    mem[561] <= 5'b01111;
    mem[562] <= 5'b01111;
    mem[563] <= 5'b01111;
    mem[564] <= 5'b01111;
    mem[565] <= 5'b01111;
    mem[566] <= 5'b01111;
    mem[567] <= 5'b10000;
    mem[568] <= 5'b10000;
    mem[569] <= 5'b01111;
    mem[570] <= 5'b01111;
    mem[571] <= 5'b10000;
    mem[572] <= 5'b01111;
    mem[573] <= 5'b10000;
    mem[574] <= 5'b10000;
    mem[575] <= 5'b01111;
    mem[576] <= 5'b10000;
    mem[577] <= 5'b01111;
    mem[578] <= 5'b01111;
    mem[579] <= 5'b01111;
    mem[580] <= 5'b10000;
    mem[581] <= 5'b01111;
    mem[582] <= 5'b01111;
    mem[583] <= 5'b01111;
    mem[584] <= 5'b10000;
    mem[585] <= 5'b01111;
    mem[586] <= 5'b10000;
    mem[587] <= 5'b01111;
    mem[588] <= 5'b10000;
    mem[589] <= 5'b10000;
    mem[590] <= 5'b01111;
    mem[591] <= 5'b01111;
    mem[592] <= 5'b10000;
    mem[593] <= 5'b01111;
    mem[594] <= 5'b01111;
    mem[595] <= 5'b10000;
    mem[596] <= 5'b10000;
    mem[597] <= 5'b01111;
    mem[598] <= 5'b10000;
    mem[599] <= 5'b01111;
    mem[600] <= 5'b01111;
    mem[601] <= 5'b01111;
    mem[602] <= 5'b01111;
    mem[603] <= 5'b01111;
    mem[604] <= 5'b01111;
    mem[605] <= 5'b10000;
    mem[606] <= 5'b01111;
    mem[607] <= 5'b01111;
    mem[608] <= 5'b01111;
    mem[609] <= 5'b01111;
    mem[610] <= 5'b01111;
    mem[611] <= 5'b01111;
    mem[612] <= 5'b01111;
    mem[613] <= 5'b01111;
    mem[614] <= 5'b01111;
    mem[615] <= 5'b01111;
    mem[616] <= 5'b01111;
    mem[617] <= 5'b01111;
    mem[618] <= 5'b01111;
    mem[619] <= 5'b10000;
    mem[620] <= 5'b01111;
    mem[621] <= 5'b10000;
    mem[622] <= 5'b01111;
    mem[623] <= 5'b10000;
    mem[624] <= 5'b01111;
    mem[625] <= 5'b10000;
    mem[626] <= 5'b01111;
    mem[627] <= 5'b01111;
    mem[628] <= 5'b01111;
    mem[629] <= 5'b01111;
    mem[630] <= 5'b10000;
    mem[631] <= 5'b01111;
    mem[632] <= 5'b10000;
    mem[633] <= 5'b10000;
    mem[634] <= 5'b01111;
    mem[635] <= 5'b01111;
    mem[636] <= 5'b10000;
    mem[637] <= 5'b01111;
    mem[638] <= 5'b10000;
    mem[639] <= 5'b01111;
    mem[640] <= 5'b10000;
    mem[641] <= 5'b10000;
    mem[642] <= 5'b10000;
    mem[643] <= 5'b10000;
    mem[644] <= 5'b01111;
    mem[645] <= 5'b01111;
    mem[646] <= 5'b01111;
    mem[647] <= 5'b01111;
    mem[648] <= 5'b10000;
    mem[649] <= 5'b01111;
    mem[650] <= 5'b10000;
    mem[651] <= 5'b01111;
    mem[652] <= 5'b01111;
    mem[653] <= 5'b10000;
    mem[654] <= 5'b01111;
    mem[655] <= 5'b10000;
    mem[656] <= 5'b01111;
    mem[657] <= 5'b10000;
    mem[658] <= 5'b01111;
    mem[659] <= 5'b10000;
    mem[660] <= 5'b01111;
    mem[661] <= 5'b01111;
    mem[662] <= 5'b01111;
    mem[663] <= 5'b01111;
    mem[664] <= 5'b01111;
    mem[665] <= 5'b01111;
    mem[666] <= 5'b10000;
    mem[667] <= 5'b01111;
    mem[668] <= 5'b01111;
    mem[669] <= 5'b01111;
    mem[670] <= 5'b01111;
    mem[671] <= 5'b01111;
    mem[672] <= 5'b01111;
    mem[673] <= 5'b01111;
    mem[674] <= 5'b01111;
    mem[675] <= 5'b01111;
    mem[676] <= 5'b01111;
    mem[677] <= 5'b01111;
    mem[678] <= 5'b01111;
    mem[679] <= 5'b01111;
    mem[680] <= 5'b01111;
    mem[681] <= 5'b01111;
    mem[682] <= 5'b01111;
    mem[683] <= 5'b01111;
    mem[684] <= 5'b01111;
    mem[685] <= 5'b01111;
    mem[686] <= 5'b01111;
    mem[687] <= 5'b01111;
    mem[688] <= 5'b10000;
    mem[689] <= 5'b01111;
    mem[690] <= 5'b01111;
    mem[691] <= 5'b10000;
    mem[692] <= 5'b01111;
    mem[693] <= 5'b01111;
    mem[694] <= 5'b01111;
    mem[695] <= 5'b01111;
    mem[696] <= 5'b01111;
    mem[697] <= 5'b01111;
    mem[698] <= 5'b01111;
    mem[699] <= 5'b10000;
    mem[700] <= 5'b10000;
    mem[701] <= 5'b10000;
    mem[702] <= 5'b10000;
    mem[703] <= 5'b01111;
    mem[704] <= 5'b01111;
    mem[705] <= 5'b01111;
    mem[706] <= 5'b01111;
    mem[707] <= 5'b10000;
    mem[708] <= 5'b10000;
    mem[709] <= 5'b01111;
    mem[710] <= 5'b10000;
    mem[711] <= 5'b10000;
    mem[712] <= 5'b01111;
    mem[713] <= 5'b01111;
    mem[714] <= 5'b01111;
    mem[715] <= 5'b01111;
    mem[716] <= 5'b01111;
    mem[717] <= 5'b01111;
    mem[718] <= 5'b01111;
    mem[719] <= 5'b01111;
    mem[720] <= 5'b01111;
    mem[721] <= 5'b01111;
    mem[722] <= 5'b10000;
    mem[723] <= 5'b01111;
    mem[724] <= 5'b01111;
    mem[725] <= 5'b01111;
    mem[726] <= 5'b10000;
    mem[727] <= 5'b10000;
    mem[728] <= 5'b10011;
    mem[729] <= 5'b01111;
    mem[730] <= 5'b01111;
    mem[731] <= 5'b01111;
    mem[732] <= 5'b10010;
    mem[733] <= 5'b10000;
    mem[734] <= 5'b10011;
    mem[735] <= 5'b01111;
  end


  // Combinational ROM read block
  always@(*)
  begin
    if ( addr >= 'd0 && addr < 'd736)
      data_out_t <= mem[addr];
    else
    begin
      data_out_t <= {(5){1'b0}};
    end
  end

  // Output register assignment
  assign data_out = data_out_t;

endmodule



//------> ./rtl_UNET_IP_batchnorm_relumgc_rom_12_736_4_1.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    2023.2/1059873 Production Release
//  HLS Date:       Mon Aug  7 10:54:31 PDT 2023
// 
//  Generated by:   r12016@cad40
//  Generated date: Thu Jun 13 03:09:42 2024
// ----------------------------------------------------------------------

// 
module UNET_IP_batchnorm_relumgc_rom_12_736_4_1 (addr, data_out
);
  input [9:0]addr ;
  output [3:0]data_out ;


  // Constants for ROM dimensions
  parameter n_width    = 4;
  parameter n_size     = 736;
  parameter n_numports = 1;
  parameter n_addr_w   = 10;
  parameter n_inreg    = 0;
  parameter n_outreg   = 0;

  // Declare storage for memory elements
  reg [3:0] mem [735:0];

  // Declare output registers
  reg [3:0] data_out_t;

  // Initialize ROM contents
  initial begin: rom_init_blk
    mem[0] <= 4'b1111;
    mem[1] <= 4'b1111;
    mem[2] <= 4'b0000;
    mem[3] <= 4'b0000;
    mem[4] <= 4'b1111;
    mem[5] <= 4'b0000;
    mem[6] <= 4'b1111;
    mem[7] <= 4'b0000;
    mem[8] <= 4'b0000;
    mem[9] <= 4'b0000;
    mem[10] <= 4'b0000;
    mem[11] <= 4'b0000;
    mem[12] <= 4'b0000;
    mem[13] <= 4'b0000;
    mem[14] <= 4'b1111;
    mem[15] <= 4'b0000;
    mem[16] <= 4'b0000;
    mem[17] <= 4'b1111;
    mem[18] <= 4'b1111;
    mem[19] <= 4'b0000;
    mem[20] <= 4'b0000;
    mem[21] <= 4'b1111;
    mem[22] <= 4'b0000;
    mem[23] <= 4'b1111;
    mem[24] <= 4'b1111;
    mem[25] <= 4'b0000;
    mem[26] <= 4'b0000;
    mem[27] <= 4'b1111;
    mem[28] <= 4'b0000;
    mem[29] <= 4'b0000;
    mem[30] <= 4'b0000;
    mem[31] <= 4'b0000;
    mem[32] <= 4'b1111;
    mem[33] <= 4'b0000;
    mem[34] <= 4'b0000;
    mem[35] <= 4'b0000;
    mem[36] <= 4'b0000;
    mem[37] <= 4'b1111;
    mem[38] <= 4'b1111;
    mem[39] <= 4'b0000;
    mem[40] <= 4'b1111;
    mem[41] <= 4'b0000;
    mem[42] <= 4'b0000;
    mem[43] <= 4'b0000;
    mem[44] <= 4'b0000;
    mem[45] <= 4'b1111;
    mem[46] <= 4'b0000;
    mem[47] <= 4'b0000;
    mem[48] <= 4'b0000;
    mem[49] <= 4'b1111;
    mem[50] <= 4'b0000;
    mem[51] <= 4'b0000;
    mem[52] <= 4'b0000;
    mem[53] <= 4'b0000;
    mem[54] <= 4'b1111;
    mem[55] <= 4'b1111;
    mem[56] <= 4'b0000;
    mem[57] <= 4'b1111;
    mem[58] <= 4'b0000;
    mem[59] <= 4'b0000;
    mem[60] <= 4'b1111;
    mem[61] <= 4'b0000;
    mem[62] <= 4'b0000;
    mem[63] <= 4'b0000;
    mem[64] <= 4'b1111;
    mem[65] <= 4'b1111;
    mem[66] <= 4'b1111;
    mem[67] <= 4'b0000;
    mem[68] <= 4'b1111;
    mem[69] <= 4'b0000;
    mem[70] <= 4'b0000;
    mem[71] <= 4'b1111;
    mem[72] <= 4'b0000;
    mem[73] <= 4'b1111;
    mem[74] <= 4'b1111;
    mem[75] <= 4'b1111;
    mem[76] <= 4'b0000;
    mem[77] <= 4'b1111;
    mem[78] <= 4'b0000;
    mem[79] <= 4'b1111;
    mem[80] <= 4'b0000;
    mem[81] <= 4'b1111;
    mem[82] <= 4'b0000;
    mem[83] <= 4'b0000;
    mem[84] <= 4'b1111;
    mem[85] <= 4'b1111;
    mem[86] <= 4'b0000;
    mem[87] <= 4'b1111;
    mem[88] <= 4'b0000;
    mem[89] <= 4'b0000;
    mem[90] <= 4'b1111;
    mem[91] <= 4'b0000;
    mem[92] <= 4'b1111;
    mem[93] <= 4'b1111;
    mem[94] <= 4'b0000;
    mem[95] <= 4'b1111;
    mem[96] <= 4'b0000;
    mem[97] <= 4'b1111;
    mem[98] <= 4'b0000;
    mem[99] <= 4'b1111;
    mem[100] <= 4'b0000;
    mem[101] <= 4'b0000;
    mem[102] <= 4'b1111;
    mem[103] <= 4'b1111;
    mem[104] <= 4'b1111;
    mem[105] <= 4'b1111;
    mem[106] <= 4'b1111;
    mem[107] <= 4'b0000;
    mem[108] <= 4'b0000;
    mem[109] <= 4'b1111;
    mem[110] <= 4'b0000;
    mem[111] <= 4'b0000;
    mem[112] <= 4'b0000;
    mem[113] <= 4'b0000;
    mem[114] <= 4'b1111;
    mem[115] <= 4'b0000;
    mem[116] <= 4'b0000;
    mem[117] <= 4'b0000;
    mem[118] <= 4'b1111;
    mem[119] <= 4'b1111;
    mem[120] <= 4'b1111;
    mem[121] <= 4'b1111;
    mem[122] <= 4'b0000;
    mem[123] <= 4'b0000;
    mem[124] <= 4'b0000;
    mem[125] <= 4'b1111;
    mem[126] <= 4'b0000;
    mem[127] <= 4'b0000;
    mem[128] <= 4'b0000;
    mem[129] <= 4'b0000;
    mem[130] <= 4'b0000;
    mem[131] <= 4'b0000;
    mem[132] <= 4'b0000;
    mem[133] <= 4'b0000;
    mem[134] <= 4'b0000;
    mem[135] <= 4'b1111;
    mem[136] <= 4'b1111;
    mem[137] <= 4'b0000;
    mem[138] <= 4'b1111;
    mem[139] <= 4'b0000;
    mem[140] <= 4'b0000;
    mem[141] <= 4'b1111;
    mem[142] <= 4'b0000;
    mem[143] <= 4'b0000;
    mem[144] <= 4'b1111;
    mem[145] <= 4'b0000;
    mem[146] <= 4'b1111;
    mem[147] <= 4'b1111;
    mem[148] <= 4'b1111;
    mem[149] <= 4'b1111;
    mem[150] <= 4'b0000;
    mem[151] <= 4'b1111;
    mem[152] <= 4'b1111;
    mem[153] <= 4'b1111;
    mem[154] <= 4'b0000;
    mem[155] <= 4'b0000;
    mem[156] <= 4'b1111;
    mem[157] <= 4'b1111;
    mem[158] <= 4'b1111;
    mem[159] <= 4'b0000;
    mem[160] <= 4'b0000;
    mem[161] <= 4'b0000;
    mem[162] <= 4'b1111;
    mem[163] <= 4'b0000;
    mem[164] <= 4'b1111;
    mem[165] <= 4'b0000;
    mem[166] <= 4'b0000;
    mem[167] <= 4'b1111;
    mem[168] <= 4'b1111;
    mem[169] <= 4'b0000;
    mem[170] <= 4'b1111;
    mem[171] <= 4'b1111;
    mem[172] <= 4'b1111;
    mem[173] <= 4'b1111;
    mem[174] <= 4'b1111;
    mem[175] <= 4'b0000;
    mem[176] <= 4'b0000;
    mem[177] <= 4'b0000;
    mem[178] <= 4'b0000;
    mem[179] <= 4'b1111;
    mem[180] <= 4'b1111;
    mem[181] <= 4'b0000;
    mem[182] <= 4'b0000;
    mem[183] <= 4'b1111;
    mem[184] <= 4'b0000;
    mem[185] <= 4'b1111;
    mem[186] <= 4'b0000;
    mem[187] <= 4'b1111;
    mem[188] <= 4'b1111;
    mem[189] <= 4'b0000;
    mem[190] <= 4'b0000;
    mem[191] <= 4'b1111;
    mem[192] <= 4'b0000;
    mem[193] <= 4'b1111;
    mem[194] <= 4'b1111;
    mem[195] <= 4'b1111;
    mem[196] <= 4'b1111;
    mem[197] <= 4'b0000;
    mem[198] <= 4'b0000;
    mem[199] <= 4'b1111;
    mem[200] <= 4'b1111;
    mem[201] <= 4'b0000;
    mem[202] <= 4'b0000;
    mem[203] <= 4'b1111;
    mem[204] <= 4'b0000;
    mem[205] <= 4'b0000;
    mem[206] <= 4'b1111;
    mem[207] <= 4'b0000;
    mem[208] <= 4'b0000;
    mem[209] <= 4'b1111;
    mem[210] <= 4'b0000;
    mem[211] <= 4'b1111;
    mem[212] <= 4'b1111;
    mem[213] <= 4'b0000;
    mem[214] <= 4'b0000;
    mem[215] <= 4'b1111;
    mem[216] <= 4'b1111;
    mem[217] <= 4'b1111;
    mem[218] <= 4'b0000;
    mem[219] <= 4'b0000;
    mem[220] <= 4'b0000;
    mem[221] <= 4'b0000;
    mem[222] <= 4'b1111;
    mem[223] <= 4'b0000;
    mem[224] <= 4'b1111;
    mem[225] <= 4'b0000;
    mem[226] <= 4'b0000;
    mem[227] <= 4'b0000;
    mem[228] <= 4'b0000;
    mem[229] <= 4'b0000;
    mem[230] <= 4'b1111;
    mem[231] <= 4'b0000;
    mem[232] <= 4'b0000;
    mem[233] <= 4'b1111;
    mem[234] <= 4'b1111;
    mem[235] <= 4'b1111;
    mem[236] <= 4'b0000;
    mem[237] <= 4'b1111;
    mem[238] <= 4'b1111;
    mem[239] <= 4'b0000;
    mem[240] <= 4'b1111;
    mem[241] <= 4'b0000;
    mem[242] <= 4'b0000;
    mem[243] <= 4'b0000;
    mem[244] <= 4'b0000;
    mem[245] <= 4'b1111;
    mem[246] <= 4'b1111;
    mem[247] <= 4'b1111;
    mem[248] <= 4'b0000;
    mem[249] <= 4'b1111;
    mem[250] <= 4'b1111;
    mem[251] <= 4'b0000;
    mem[252] <= 4'b1111;
    mem[253] <= 4'b1111;
    mem[254] <= 4'b1111;
    mem[255] <= 4'b1111;
    mem[256] <= 4'b1111;
    mem[257] <= 4'b0000;
    mem[258] <= 4'b0000;
    mem[259] <= 4'b0000;
    mem[260] <= 4'b0000;
    mem[261] <= 4'b1111;
    mem[262] <= 4'b0000;
    mem[263] <= 4'b0000;
    mem[264] <= 4'b0000;
    mem[265] <= 4'b0000;
    mem[266] <= 4'b1111;
    mem[267] <= 4'b0000;
    mem[268] <= 4'b1111;
    mem[269] <= 4'b1111;
    mem[270] <= 4'b1111;
    mem[271] <= 4'b1111;
    mem[272] <= 4'b0000;
    mem[273] <= 4'b0000;
    mem[274] <= 4'b0000;
    mem[275] <= 4'b0000;
    mem[276] <= 4'b0000;
    mem[277] <= 4'b0000;
    mem[278] <= 4'b0000;
    mem[279] <= 4'b0000;
    mem[280] <= 4'b0000;
    mem[281] <= 4'b0000;
    mem[282] <= 4'b1111;
    mem[283] <= 4'b0000;
    mem[284] <= 4'b0000;
    mem[285] <= 4'b0000;
    mem[286] <= 4'b1111;
    mem[287] <= 4'b1111;
    mem[288] <= 4'b1111;
    mem[289] <= 4'b0000;
    mem[290] <= 4'b0000;
    mem[291] <= 4'b1111;
    mem[292] <= 4'b0000;
    mem[293] <= 4'b0000;
    mem[294] <= 4'b0000;
    mem[295] <= 4'b0000;
    mem[296] <= 4'b0000;
    mem[297] <= 4'b0000;
    mem[298] <= 4'b0000;
    mem[299] <= 4'b0000;
    mem[300] <= 4'b1111;
    mem[301] <= 4'b1111;
    mem[302] <= 4'b0000;
    mem[303] <= 4'b0000;
    mem[304] <= 4'b1111;
    mem[305] <= 4'b0000;
    mem[306] <= 4'b0000;
    mem[307] <= 4'b1111;
    mem[308] <= 4'b1111;
    mem[309] <= 4'b0000;
    mem[310] <= 4'b0000;
    mem[311] <= 4'b0000;
    mem[312] <= 4'b0000;
    mem[313] <= 4'b0000;
    mem[314] <= 4'b1111;
    mem[315] <= 4'b0000;
    mem[316] <= 4'b1111;
    mem[317] <= 4'b1111;
    mem[318] <= 4'b0000;
    mem[319] <= 4'b0000;
    mem[320] <= 4'b0000;
    mem[321] <= 4'b0000;
    mem[322] <= 4'b1111;
    mem[323] <= 4'b0000;
    mem[324] <= 4'b0000;
    mem[325] <= 4'b1111;
    mem[326] <= 4'b1111;
    mem[327] <= 4'b0000;
    mem[328] <= 4'b1111;
    mem[329] <= 4'b0000;
    mem[330] <= 4'b1111;
    mem[331] <= 4'b0000;
    mem[332] <= 4'b0000;
    mem[333] <= 4'b1111;
    mem[334] <= 4'b1111;
    mem[335] <= 4'b0000;
    mem[336] <= 4'b0000;
    mem[337] <= 4'b0000;
    mem[338] <= 4'b0000;
    mem[339] <= 4'b1111;
    mem[340] <= 4'b0000;
    mem[341] <= 4'b1111;
    mem[342] <= 4'b1111;
    mem[343] <= 4'b0000;
    mem[344] <= 4'b1111;
    mem[345] <= 4'b0000;
    mem[346] <= 4'b0000;
    mem[347] <= 4'b0000;
    mem[348] <= 4'b0000;
    mem[349] <= 4'b1111;
    mem[350] <= 4'b0000;
    mem[351] <= 4'b1111;
    mem[352] <= 4'b1111;
    mem[353] <= 4'b1111;
    mem[354] <= 4'b1111;
    mem[355] <= 4'b0000;
    mem[356] <= 4'b1111;
    mem[357] <= 4'b0000;
    mem[358] <= 4'b0000;
    mem[359] <= 4'b0000;
    mem[360] <= 4'b1111;
    mem[361] <= 4'b0000;
    mem[362] <= 4'b0000;
    mem[363] <= 4'b0000;
    mem[364] <= 4'b1111;
    mem[365] <= 4'b1111;
    mem[366] <= 4'b0000;
    mem[367] <= 4'b0000;
    mem[368] <= 4'b1111;
    mem[369] <= 4'b0000;
    mem[370] <= 4'b1111;
    mem[371] <= 4'b0000;
    mem[372] <= 4'b0000;
    mem[373] <= 4'b0000;
    mem[374] <= 4'b1111;
    mem[375] <= 4'b0000;
    mem[376] <= 4'b0000;
    mem[377] <= 4'b1111;
    mem[378] <= 4'b0000;
    mem[379] <= 4'b0000;
    mem[380] <= 4'b0000;
    mem[381] <= 4'b0000;
    mem[382] <= 4'b0000;
    mem[383] <= 4'b0000;
    mem[384] <= 4'b0000;
    mem[385] <= 4'b1111;
    mem[386] <= 4'b1111;
    mem[387] <= 4'b1111;
    mem[388] <= 4'b0000;
    mem[389] <= 4'b0000;
    mem[390] <= 4'b1111;
    mem[391] <= 4'b0000;
    mem[392] <= 4'b1111;
    mem[393] <= 4'b1111;
    mem[394] <= 4'b0000;
    mem[395] <= 4'b0000;
    mem[396] <= 4'b0000;
    mem[397] <= 4'b0000;
    mem[398] <= 4'b1111;
    mem[399] <= 4'b1111;
    mem[400] <= 4'b0000;
    mem[401] <= 4'b0000;
    mem[402] <= 4'b0000;
    mem[403] <= 4'b0000;
    mem[404] <= 4'b0000;
    mem[405] <= 4'b1111;
    mem[406] <= 4'b1111;
    mem[407] <= 4'b0000;
    mem[408] <= 4'b0000;
    mem[409] <= 4'b1111;
    mem[410] <= 4'b1111;
    mem[411] <= 4'b0000;
    mem[412] <= 4'b0000;
    mem[413] <= 4'b1111;
    mem[414] <= 4'b0000;
    mem[415] <= 4'b0000;
    mem[416] <= 4'b0000;
    mem[417] <= 4'b0000;
    mem[418] <= 4'b1111;
    mem[419] <= 4'b0000;
    mem[420] <= 4'b0000;
    mem[421] <= 4'b0000;
    mem[422] <= 4'b0000;
    mem[423] <= 4'b1111;
    mem[424] <= 4'b0000;
    mem[425] <= 4'b1111;
    mem[426] <= 4'b1111;
    mem[427] <= 4'b0000;
    mem[428] <= 4'b0000;
    mem[429] <= 4'b1111;
    mem[430] <= 4'b1111;
    mem[431] <= 4'b1111;
    mem[432] <= 4'b0000;
    mem[433] <= 4'b0000;
    mem[434] <= 4'b1111;
    mem[435] <= 4'b0000;
    mem[436] <= 4'b0000;
    mem[437] <= 4'b1111;
    mem[438] <= 4'b1111;
    mem[439] <= 4'b1111;
    mem[440] <= 4'b0000;
    mem[441] <= 4'b0000;
    mem[442] <= 4'b0000;
    mem[443] <= 4'b0000;
    mem[444] <= 4'b1111;
    mem[445] <= 4'b1111;
    mem[446] <= 4'b0000;
    mem[447] <= 4'b0000;
    mem[448] <= 4'b0000;
    mem[449] <= 4'b0000;
    mem[450] <= 4'b1111;
    mem[451] <= 4'b1111;
    mem[452] <= 4'b1111;
    mem[453] <= 4'b0000;
    mem[454] <= 4'b1111;
    mem[455] <= 4'b1111;
    mem[456] <= 4'b1111;
    mem[457] <= 4'b0000;
    mem[458] <= 4'b0000;
    mem[459] <= 4'b0000;
    mem[460] <= 4'b0000;
    mem[461] <= 4'b1111;
    mem[462] <= 4'b1111;
    mem[463] <= 4'b0000;
    mem[464] <= 4'b1111;
    mem[465] <= 4'b1111;
    mem[466] <= 4'b0000;
    mem[467] <= 4'b1111;
    mem[468] <= 4'b0000;
    mem[469] <= 4'b0000;
    mem[470] <= 4'b0000;
    mem[471] <= 4'b1111;
    mem[472] <= 4'b1111;
    mem[473] <= 4'b0000;
    mem[474] <= 4'b0000;
    mem[475] <= 4'b0000;
    mem[476] <= 4'b0000;
    mem[477] <= 4'b0000;
    mem[478] <= 4'b1111;
    mem[479] <= 4'b0000;
    mem[480] <= 4'b1111;
    mem[481] <= 4'b1111;
    mem[482] <= 4'b1111;
    mem[483] <= 4'b0000;
    mem[484] <= 4'b1111;
    mem[485] <= 4'b1111;
    mem[486] <= 4'b0000;
    mem[487] <= 4'b1111;
    mem[488] <= 4'b0000;
    mem[489] <= 4'b0000;
    mem[490] <= 4'b0000;
    mem[491] <= 4'b1111;
    mem[492] <= 4'b1111;
    mem[493] <= 4'b0000;
    mem[494] <= 4'b1111;
    mem[495] <= 4'b0000;
    mem[496] <= 4'b1111;
    mem[497] <= 4'b0000;
    mem[498] <= 4'b0000;
    mem[499] <= 4'b1111;
    mem[500] <= 4'b1111;
    mem[501] <= 4'b0000;
    mem[502] <= 4'b1111;
    mem[503] <= 4'b1111;
    mem[504] <= 4'b1111;
    mem[505] <= 4'b0000;
    mem[506] <= 4'b1111;
    mem[507] <= 4'b0000;
    mem[508] <= 4'b0000;
    mem[509] <= 4'b0000;
    mem[510] <= 4'b1111;
    mem[511] <= 4'b0000;
    mem[512] <= 4'b0000;
    mem[513] <= 4'b0000;
    mem[514] <= 4'b0000;
    mem[515] <= 4'b1111;
    mem[516] <= 4'b1111;
    mem[517] <= 4'b0000;
    mem[518] <= 4'b1111;
    mem[519] <= 4'b0000;
    mem[520] <= 4'b0000;
    mem[521] <= 4'b0000;
    mem[522] <= 4'b0000;
    mem[523] <= 4'b1111;
    mem[524] <= 4'b1111;
    mem[525] <= 4'b1111;
    mem[526] <= 4'b0000;
    mem[527] <= 4'b0000;
    mem[528] <= 4'b0000;
    mem[529] <= 4'b0000;
    mem[530] <= 4'b1111;
    mem[531] <= 4'b0000;
    mem[532] <= 4'b1111;
    mem[533] <= 4'b0000;
    mem[534] <= 4'b1111;
    mem[535] <= 4'b0000;
    mem[536] <= 4'b0000;
    mem[537] <= 4'b1111;
    mem[538] <= 4'b1111;
    mem[539] <= 4'b0000;
    mem[540] <= 4'b1111;
    mem[541] <= 4'b1111;
    mem[542] <= 4'b1111;
    mem[543] <= 4'b0000;
    mem[544] <= 4'b1111;
    mem[545] <= 4'b1111;
    mem[546] <= 4'b0000;
    mem[547] <= 4'b1111;
    mem[548] <= 4'b0000;
    mem[549] <= 4'b0000;
    mem[550] <= 4'b1111;
    mem[551] <= 4'b1111;
    mem[552] <= 4'b1111;
    mem[553] <= 4'b0000;
    mem[554] <= 4'b0000;
    mem[555] <= 4'b0000;
    mem[556] <= 4'b0000;
    mem[557] <= 4'b0000;
    mem[558] <= 4'b0000;
    mem[559] <= 4'b1111;
    mem[560] <= 4'b0000;
    mem[561] <= 4'b0000;
    mem[562] <= 4'b1111;
    mem[563] <= 4'b1111;
    mem[564] <= 4'b0000;
    mem[565] <= 4'b1111;
    mem[566] <= 4'b1111;
    mem[567] <= 4'b0000;
    mem[568] <= 4'b0000;
    mem[569] <= 4'b1111;
    mem[570] <= 4'b1111;
    mem[571] <= 4'b0000;
    mem[572] <= 4'b0000;
    mem[573] <= 4'b1111;
    mem[574] <= 4'b0000;
    mem[575] <= 4'b0000;
    mem[576] <= 4'b0000;
    mem[577] <= 4'b1111;
    mem[578] <= 4'b1111;
    mem[579] <= 4'b1111;
    mem[580] <= 4'b0000;
    mem[581] <= 4'b0000;
    mem[582] <= 4'b0000;
    mem[583] <= 4'b1111;
    mem[584] <= 4'b0000;
    mem[585] <= 4'b1111;
    mem[586] <= 4'b0000;
    mem[587] <= 4'b0000;
    mem[588] <= 4'b0000;
    mem[589] <= 4'b1111;
    mem[590] <= 4'b1111;
    mem[591] <= 4'b1111;
    mem[592] <= 4'b1111;
    mem[593] <= 4'b1111;
    mem[594] <= 4'b1111;
    mem[595] <= 4'b0000;
    mem[596] <= 4'b0000;
    mem[597] <= 4'b1111;
    mem[598] <= 4'b0000;
    mem[599] <= 4'b1111;
    mem[600] <= 4'b1111;
    mem[601] <= 4'b0000;
    mem[602] <= 4'b1111;
    mem[603] <= 4'b1111;
    mem[604] <= 4'b1111;
    mem[605] <= 4'b0000;
    mem[606] <= 4'b1111;
    mem[607] <= 4'b1111;
    mem[608] <= 4'b1111;
    mem[609] <= 4'b1111;
    mem[610] <= 4'b0000;
    mem[611] <= 4'b1111;
    mem[612] <= 4'b1111;
    mem[613] <= 4'b1111;
    mem[614] <= 4'b1111;
    mem[615] <= 4'b1111;
    mem[616] <= 4'b0000;
    mem[617] <= 4'b1111;
    mem[618] <= 4'b0000;
    mem[619] <= 4'b0000;
    mem[620] <= 4'b1111;
    mem[621] <= 4'b0000;
    mem[622] <= 4'b1111;
    mem[623] <= 4'b0000;
    mem[624] <= 4'b1111;
    mem[625] <= 4'b1111;
    mem[626] <= 4'b1111;
    mem[627] <= 4'b1111;
    mem[628] <= 4'b1111;
    mem[629] <= 4'b1111;
    mem[630] <= 4'b0000;
    mem[631] <= 4'b1111;
    mem[632] <= 4'b0000;
    mem[633] <= 4'b0000;
    mem[634] <= 4'b1111;
    mem[635] <= 4'b1111;
    mem[636] <= 4'b0000;
    mem[637] <= 4'b1111;
    mem[638] <= 4'b0000;
    mem[639] <= 4'b1111;
    mem[640] <= 4'b0000;
    mem[641] <= 4'b0000;
    mem[642] <= 4'b0000;
    mem[643] <= 4'b0000;
    mem[644] <= 4'b1111;
    mem[645] <= 4'b1111;
    mem[646] <= 4'b1111;
    mem[647] <= 4'b0000;
    mem[648] <= 4'b0000;
    mem[649] <= 4'b1111;
    mem[650] <= 4'b0000;
    mem[651] <= 4'b1111;
    mem[652] <= 4'b1111;
    mem[653] <= 4'b0000;
    mem[654] <= 4'b0000;
    mem[655] <= 4'b0000;
    mem[656] <= 4'b1111;
    mem[657] <= 4'b0000;
    mem[658] <= 4'b1111;
    mem[659] <= 4'b0000;
    mem[660] <= 4'b1111;
    mem[661] <= 4'b1111;
    mem[662] <= 4'b0000;
    mem[663] <= 4'b1111;
    mem[664] <= 4'b1111;
    mem[665] <= 4'b1111;
    mem[666] <= 4'b1111;
    mem[667] <= 4'b1111;
    mem[668] <= 4'b1111;
    mem[669] <= 4'b1111;
    mem[670] <= 4'b1111;
    mem[671] <= 4'b1111;
    mem[672] <= 4'b1111;
    mem[673] <= 4'b1111;
    mem[674] <= 4'b1111;
    mem[675] <= 4'b1111;
    mem[676] <= 4'b1111;
    mem[677] <= 4'b1111;
    mem[678] <= 4'b1111;
    mem[679] <= 4'b1111;
    mem[680] <= 4'b1111;
    mem[681] <= 4'b0000;
    mem[682] <= 4'b1111;
    mem[683] <= 4'b1111;
    mem[684] <= 4'b1111;
    mem[685] <= 4'b0000;
    mem[686] <= 4'b1111;
    mem[687] <= 4'b1111;
    mem[688] <= 4'b0000;
    mem[689] <= 4'b1111;
    mem[690] <= 4'b0000;
    mem[691] <= 4'b0000;
    mem[692] <= 4'b1111;
    mem[693] <= 4'b0000;
    mem[694] <= 4'b1111;
    mem[695] <= 4'b1111;
    mem[696] <= 4'b0000;
    mem[697] <= 4'b1111;
    mem[698] <= 4'b0000;
    mem[699] <= 4'b0000;
    mem[700] <= 4'b0000;
    mem[701] <= 4'b1111;
    mem[702] <= 4'b1111;
    mem[703] <= 4'b1111;
    mem[704] <= 4'b1111;
    mem[705] <= 4'b0000;
    mem[706] <= 4'b0000;
    mem[707] <= 4'b0000;
    mem[708] <= 4'b0000;
    mem[709] <= 4'b1111;
    mem[710] <= 4'b0000;
    mem[711] <= 4'b0000;
    mem[712] <= 4'b0000;
    mem[713] <= 4'b1111;
    mem[714] <= 4'b1111;
    mem[715] <= 4'b1111;
    mem[716] <= 4'b1111;
    mem[717] <= 4'b1111;
    mem[718] <= 4'b0000;
    mem[719] <= 4'b1111;
    mem[720] <= 4'b1111;
    mem[721] <= 4'b1111;
    mem[722] <= 4'b0000;
    mem[723] <= 4'b0000;
    mem[724] <= 4'b1111;
    mem[725] <= 4'b1111;
    mem[726] <= 4'b0000;
    mem[727] <= 4'b0000;
    mem[728] <= 4'b0100;
    mem[729] <= 4'b0000;
    mem[730] <= 4'b1111;
    mem[731] <= 4'b1110;
    mem[732] <= 4'b0101;
    mem[733] <= 4'b0000;
    mem[734] <= 4'b0100;
    mem[735] <= 4'b1111;
  end


  // Combinational ROM read block
  always@(*)
  begin
    if ( addr >= 'd0 && addr < 'd736)
      data_out_t <= mem[addr];
    else
    begin
      data_out_t <= {(4){1'b0}};
    end
  end

  // Output register assignment
  assign data_out = data_out_t;

endmodule



//------> ./rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    2023.2/1059873 Production Release
//  HLS Date:       Mon Aug  7 10:54:31 PDT 2023
// 
//  Generated by:   r12016@cad40
//  Generated date: Thu Jun 13 03:09:42 2024
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    UNET_IP_batchnorm_relu_Xilinx_RAMS_BLOCK_1R1W_RBW_wport_en_2_15_12_32768_1_32768_12_1_gen
// ------------------------------------------------------------------


module UNET_IP_batchnorm_relu_Xilinx_RAMS_BLOCK_1R1W_RBW_wport_en_2_15_12_32768_1_32768_12_1_gen
    (
  clken, we, d, wadr, clken_d, d_d, wadr_d, we_d, writeA_w_ram_ir_internal_WMASK_B_d
);
  output clken;
  output we;
  output [11:0] d;
  output [14:0] wadr;
  input clken_d;
  input [11:0] d_d;
  input [14:0] wadr_d;
  input we_d;
  input writeA_w_ram_ir_internal_WMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign clken = (clken_d);
  assign we = (writeA_w_ram_ir_internal_WMASK_B_d);
  assign d = (d_d);
  assign wadr = (wadr_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    UNET_IP_batchnorm_relu_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_en_1_15_12_32768_1_32768_12_1_gen
// ------------------------------------------------------------------


module UNET_IP_batchnorm_relu_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_en_1_15_12_32768_1_32768_12_1_gen
    (
  clken, q, re, radr, clken_d, q_d, radr_d, re_d, readA_r_ram_ir_internal_RMASK_B_d
);
  output clken;
  input [11:0] q;
  output re;
  output [14:0] radr;
  input clken_d;
  output [11:0] q_d;
  input [14:0] radr_d;
  input re_d;
  input readA_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign clken = (clken_d);
  assign q_d = q;
  assign re = (readA_r_ram_ir_internal_RMASK_B_d);
  assign radr = (radr_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    UNET_IP_batchnorm_relu_run_batch_run_batch_fsm
//  FSM Module
// ------------------------------------------------------------------


module UNET_IP_batchnorm_relu_run_batch_run_batch_fsm (
  clk, rst, arst_n, fsm_output, main_C_0_tr0, LOOP_MEAN_C_0_tr0, LOOP_CH_C_5_tr0,
      LOOP_VAR_C_3_tr0, LOOP_OUT_C_0_tr0, LOOP_CH_C_12_tr0
);
  input clk;
  input rst;
  input arst_n;
  output [20:0] fsm_output;
  reg [20:0] fsm_output;
  input main_C_0_tr0;
  input LOOP_MEAN_C_0_tr0;
  input LOOP_CH_C_5_tr0;
  input LOOP_VAR_C_3_tr0;
  input LOOP_OUT_C_0_tr0;
  input LOOP_CH_C_12_tr0;


  // FSM State Type Declaration for UNET_IP_batchnorm_relu_run_batch_run_batch_fsm_1
  parameter
    main_C_0 = 5'd0,
    LOOP_MEAN_C_0 = 5'd1,
    LOOP_CH_C_0 = 5'd2,
    LOOP_CH_C_1 = 5'd3,
    LOOP_CH_C_2 = 5'd4,
    LOOP_CH_C_3 = 5'd5,
    LOOP_CH_C_4 = 5'd6,
    LOOP_CH_C_5 = 5'd7,
    LOOP_VAR_C_0 = 5'd8,
    LOOP_VAR_C_1 = 5'd9,
    LOOP_VAR_C_2 = 5'd10,
    LOOP_VAR_C_3 = 5'd11,
    LOOP_CH_C_6 = 5'd12,
    LOOP_CH_C_7 = 5'd13,
    LOOP_CH_C_8 = 5'd14,
    LOOP_CH_C_9 = 5'd15,
    LOOP_CH_C_10 = 5'd16,
    LOOP_CH_C_11 = 5'd17,
    LOOP_OUT_C_0 = 5'd18,
    LOOP_CH_C_12 = 5'd19,
    main_C_1 = 5'd20;

  reg [4:0] state_var;
  reg [4:0] state_var_NS;


  // Interconnect Declarations for Component Instantiations 
  always @(*)
  begin : UNET_IP_batchnorm_relu_run_batch_run_batch_fsm_1
    case (state_var)
      LOOP_MEAN_C_0 : begin
        fsm_output = 21'b000000000000000000010;
        if ( LOOP_MEAN_C_0_tr0 ) begin
          state_var_NS = LOOP_CH_C_0;
        end
        else begin
          state_var_NS = LOOP_MEAN_C_0;
        end
      end
      LOOP_CH_C_0 : begin
        fsm_output = 21'b000000000000000000100;
        state_var_NS = LOOP_CH_C_1;
      end
      LOOP_CH_C_1 : begin
        fsm_output = 21'b000000000000000001000;
        state_var_NS = LOOP_CH_C_2;
      end
      LOOP_CH_C_2 : begin
        fsm_output = 21'b000000000000000010000;
        state_var_NS = LOOP_CH_C_3;
      end
      LOOP_CH_C_3 : begin
        fsm_output = 21'b000000000000000100000;
        state_var_NS = LOOP_CH_C_4;
      end
      LOOP_CH_C_4 : begin
        fsm_output = 21'b000000000000001000000;
        state_var_NS = LOOP_CH_C_5;
      end
      LOOP_CH_C_5 : begin
        fsm_output = 21'b000000000000010000000;
        if ( LOOP_CH_C_5_tr0 ) begin
          state_var_NS = LOOP_CH_C_6;
        end
        else begin
          state_var_NS = LOOP_VAR_C_0;
        end
      end
      LOOP_VAR_C_0 : begin
        fsm_output = 21'b000000000000100000000;
        state_var_NS = LOOP_VAR_C_1;
      end
      LOOP_VAR_C_1 : begin
        fsm_output = 21'b000000000001000000000;
        state_var_NS = LOOP_VAR_C_2;
      end
      LOOP_VAR_C_2 : begin
        fsm_output = 21'b000000000010000000000;
        state_var_NS = LOOP_VAR_C_3;
      end
      LOOP_VAR_C_3 : begin
        fsm_output = 21'b000000000100000000000;
        if ( LOOP_VAR_C_3_tr0 ) begin
          state_var_NS = LOOP_CH_C_6;
        end
        else begin
          state_var_NS = LOOP_VAR_C_0;
        end
      end
      LOOP_CH_C_6 : begin
        fsm_output = 21'b000000001000000000000;
        state_var_NS = LOOP_CH_C_7;
      end
      LOOP_CH_C_7 : begin
        fsm_output = 21'b000000010000000000000;
        state_var_NS = LOOP_CH_C_8;
      end
      LOOP_CH_C_8 : begin
        fsm_output = 21'b000000100000000000000;
        state_var_NS = LOOP_CH_C_9;
      end
      LOOP_CH_C_9 : begin
        fsm_output = 21'b000001000000000000000;
        state_var_NS = LOOP_CH_C_10;
      end
      LOOP_CH_C_10 : begin
        fsm_output = 21'b000010000000000000000;
        state_var_NS = LOOP_CH_C_11;
      end
      LOOP_CH_C_11 : begin
        fsm_output = 21'b000100000000000000000;
        state_var_NS = LOOP_OUT_C_0;
      end
      LOOP_OUT_C_0 : begin
        fsm_output = 21'b001000000000000000000;
        if ( LOOP_OUT_C_0_tr0 ) begin
          state_var_NS = LOOP_CH_C_12;
        end
        else begin
          state_var_NS = LOOP_OUT_C_0;
        end
      end
      LOOP_CH_C_12 : begin
        fsm_output = 21'b010000000000000000000;
        if ( LOOP_CH_C_12_tr0 ) begin
          state_var_NS = main_C_1;
        end
        else begin
          state_var_NS = LOOP_MEAN_C_0;
        end
      end
      main_C_1 : begin
        fsm_output = 21'b100000000000000000000;
        state_var_NS = main_C_0;
      end
      // main_C_0
      default : begin
        fsm_output = 21'b000000000000000000001;
        if ( main_C_0_tr0 ) begin
          state_var_NS = main_C_1;
        end
        else begin
          state_var_NS = LOOP_MEAN_C_0;
        end
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
    else begin
      state_var <= state_var_NS;
    end
  end

endmodule

// ------------------------------------------------------------------
//  Design Unit:    UNET_IP_batchnorm_relu_run_batch_wait_dp
// ------------------------------------------------------------------


module UNET_IP_batchnorm_relu_run_batch_wait_dp (
  clk, rst, arst_n, operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z, operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z_oreg
);
  input clk;
  input rst;
  input arst_n;
  input [33:0] operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z;
  output [27:0] operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z_oreg;


  // Interconnect Declarations
  reg [27:0] operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z_oreg_pconst_33_6;


  // Interconnect Declarations for Component Instantiations 
  assign operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z_oreg = operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z_oreg_pconst_33_6;
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z_oreg_pconst_33_6 <= 28'b0000000000000000000000000000;
    end
    else if ( rst ) begin
      operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z_oreg_pconst_33_6 <= 28'b0000000000000000000000000000;
    end
    else begin
      operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z_oreg_pconst_33_6 <= operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z[33:6];
    end
  end
endmodule

// ------------------------------------------------------------------
//  Design Unit:    UNET_IP_batchnorm_relu_run_batch
// ------------------------------------------------------------------


module UNET_IP_batchnorm_relu_run_batch (
  clk, rst, arst_n, input_triosy_lz, output_triosy_lz, channels, height, width, offset,
      input_rsci_q_d, input_rsci_radr_d, output_rsci_d_d, output_rsci_wadr_d, operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a,
      operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_b, operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z,
      input_rsci_re_d_pff, output_rsci_we_d_pff
);
  input clk;
  input rst;
  input arst_n;
  output input_triosy_lz;
  output output_triosy_lz;
  input [6:0] channels;
  input [6:0] height;
  input [6:0] width;
  input [9:0] offset;
  input [11:0] input_rsci_q_d;
  output [14:0] input_rsci_radr_d;
  output [11:0] output_rsci_d_d;
  wire [12:0] nl_output_rsci_d_d;
  output [14:0] output_rsci_wadr_d;
  output [33:0] operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a;
  output [12:0] operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_b;
  reg [12:0] operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_b;
  input [33:0] operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z;
  output input_rsci_re_d_pff;
  output output_rsci_we_d_pff;


  // Interconnect Declarations
  wire [21:0] LOOP_OUT_div_5_cmp_z;
  wire [21:0] LOOP_OUT_div_5_cmp_1_z;
  wire [21:0] LOOP_OUT_div_5_cmp_2_z;
  wire [21:0] LOOP_OUT_div_5_cmp_3_z;
  wire [21:0] LOOP_OUT_div_5_cmp_4_z;
  wire [27:0] operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z_oreg;
  reg [15:0] LOOP_OUT_div_5_cmp_a_21_6;
  reg [13:0] LOOP_OUT_div_5_cmp_b_13_0;
  reg [15:0] LOOP_OUT_div_5_cmp_1_a_21_6;
  reg [13:0] LOOP_OUT_div_5_cmp_1_b_13_0;
  reg [15:0] LOOP_OUT_div_5_cmp_2_a_21_6;
  reg [13:0] LOOP_OUT_div_5_cmp_2_b_13_0;
  reg [15:0] LOOP_OUT_div_5_cmp_3_a_21_6;
  reg [13:0] LOOP_OUT_div_5_cmp_3_b_13_0;
  reg [15:0] LOOP_OUT_div_5_cmp_4_a_21_6;
  reg [13:0] LOOP_OUT_div_5_cmp_4_b_13_0;
  wire [20:0] fsm_output;
  wire [2:0] LOOP_OUT_LOOP_OUT_acc_tmp;
  wire [3:0] nl_LOOP_OUT_LOOP_OUT_acc_tmp;
  wire ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_or_tmp;
  wire and_dcpl_45;
  wire and_dcpl_46;
  wire and_dcpl_49;
  wire and_dcpl_50;
  wire or_dcpl_54;
  wire or_dcpl_55;
  wire or_dcpl_56;
  wire or_dcpl_58;
  wire or_dcpl_60;
  wire and_dcpl_63;
  wire and_dcpl_65;
  wire or_dcpl_62;
  wire or_dcpl_64;
  wire and_dcpl_77;
  wire and_dcpl_79;
  wire and_dcpl_84;
  wire and_dcpl_85;
  wire and_dcpl_87;
  wire and_dcpl_89;
  wire and_dcpl_91;
  wire and_dcpl_92;
  wire and_dcpl_94;
  reg LOOP_MEAN_stage_0;
  wire exit_LOOP_CH_sva_mx0;
  reg LOOP_MEAN_stage_0_2;
  reg LOOP_OUT_stage_0;
  reg exit_LOOP_OUT_sva_st_8;
  reg exit_LOOP_OUT_sva_st_7;
  reg exit_LOOP_OUT_sva_st_6;
  reg exit_LOOP_OUT_sva_st_5;
  reg exit_LOOP_OUT_sva_st_4;
  reg LOOP_OUT_stage_0_5;
  reg exit_LOOP_OUT_sva_st_3;
  reg exit_LOOP_OUT_sva_st_2;
  reg exit_LOOP_OUT_sva_st_1;
  reg LOOP_MEAN_stage_0_3;
  reg LOOP_MEAN_asn_6_itm_2;
  reg [2:0] LOOP_OUT_div_5cyc_st_4;
  reg LOOP_OUT_stage_0_8;
  reg ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_qr_0_lpi_3_dfm_1;
  reg ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_or_itm_1;
  reg [20:0] LOOP_CH_var_21_1_sva;
  reg [2:0] LOOP_OUT_div_5cyc_st_1;
  reg LOOP_OUT_stage_0_4;
  reg exit_LOOP_OUT_sva_st_9;
  reg ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_or_itm_3;
  reg [2:0] LOOP_OUT_div_5cyc_st_5;
  reg LOOP_OUT_stage_0_9;
  reg reg_output_triosy_obj_ld_cse;
  wire nor_4_cse;
  wire or_cse;
  wire or_123_ssc;
  reg [13:0] reg_operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a_ftd;
  reg [11:0] reg_operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a_ftd_1;
  reg [1:0] reg_operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a_ftd_2;
  wire or_159_cse;
  wire nor_21_cse;
  reg [14:0] LOOP_MEAN_mul_itm_1;
  reg [12:0] LOOP_MEAN_asn_3_itm_1;
  reg [14:0] LOOP_VAR_acc_1_itm;
  wire [15:0] nl_LOOP_VAR_acc_1_itm;
  reg [11:0] LOOP_OUT_slc_LOOP_OUT_mul_sdt_25_4_21_2_itm_1_11_0;
  reg [3:0] LOOP_OUT_read_rom_UNET_IP_beta_pretrain_rom_map_1_itm_2;
  wire [31:0] operator_32_8_false_AC_TRN_AC_WRAP_lshift_itm;
  wire [4:0] LOOP_OUT_read_rom_UNET_IP_gamma_pretrain_rom_map_1_itm;
  wire [3:0] LOOP_OUT_read_rom_UNET_IP_beta_pretrain_rom_map_1_itm;
  wire [20:0] operator_22_0_false_AC_TRN_AC_WRAP_lshift_itm;
  wire [19:0] z_out;
  wire [20:0] nl_z_out;
  wire [14:0] z_out_1;
  wire [15:0] nl_z_out_1;
  reg [12:0] num_elements_sva;
  reg [7:0] LOOP_CH_c_sva;
  reg [27:0] LOOP_CH_var_tmp_33_6_sva;
  reg [12:0] LOOP_CH_i_1_sva;
  reg [13:0] LOOP_CH_mean_sva;
  reg [2:0] LOOP_OUT_div_5cyc;
  reg LOOP_OUT_stage_0_6;
  reg LOOP_OUT_stage_0_7;
  reg [13:0] ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_qr_sva_1_1;
  reg ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_qr_0_lpi_3_dfm_2;
  reg [12:0] ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_24_12_sva_1;
  wire [13:0] nl_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_24_12_sva_1;
  reg [14:0] LOOP_OUT_mul_itm_1;
  reg [11:0] ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_normalized_fixed_temp_slc_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_normalized_fixed_temp_1_20_7_11_0_itm_1;
  reg [5:0] ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux_itm_1;
  reg [9:0] ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux_1_itm_1;
  reg [4:0] ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_and_itm_1;
  reg [4:0] ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_and_itm_2;
  reg [4:0] LOOP_OUT_read_rom_UNET_IP_gamma_pretrain_rom_map_1_itm_1;
  reg [15:0] LOOP_OUT_acc_5_itm_1;
  reg [3:0] LOOP_OUT_read_rom_UNET_IP_beta_pretrain_rom_map_1_itm_1;
  reg [2:0] LOOP_OUT_div_5cyc_st_2;
  reg [2:0] LOOP_OUT_div_5cyc_st_3;
  reg [13:0] mut_1_1_13_0;
  reg [17:0] LOOP_OUT_div_tmp_duc_17_0;
  wire LOOP_OUT_div_5_cmp_4_b_13_0_mx0c1;
  wire LOOP_OUT_div_5_cmp_3_b_13_0_mx0c1;
  wire LOOP_OUT_div_5_cmp_2_b_13_0_mx0c1;
  wire LOOP_OUT_div_5_cmp_1_b_13_0_mx0c1;
  wire LOOP_OUT_div_5_cmp_b_13_0_mx0c1;
  wire [7:0] LOOP_CH_c_sva_2;
  wire [8:0] nl_LOOP_CH_c_sva_2;
  wire [27:0] LOOP_CH_var_tmp_33_6_sva_mx0w1;
  wire [28:0] nl_LOOP_CH_var_tmp_33_6_sva_mx0w1;
  wire [12:0] LOOP_CH_i_1_sva_2;
  wire [13:0] nl_LOOP_CH_i_1_sva_2;
  wire [15:0] LOOP_VAR_acc_4_cse_sva_mx0w1;
  wire [16:0] nl_LOOP_VAR_acc_4_cse_sva_mx0w1;
  wire [11:0] LOOP_CH_mean_tmp_19_8_sva_2;
  wire [12:0] nl_LOOP_CH_mean_tmp_19_8_sva_2;
  wire [13:0] ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_and_tmp_1;
  wire [14:0] LOOP_VAR_mul_4;
  wire [19:0] nl_LOOP_VAR_mul_4;
  wire [2:0] LOOP_OUT_acc_imod_1;
  wire [3:0] nl_LOOP_OUT_acc_imod_1;
  wire [2:0] LOOP_OUT_acc_idiv_1;
  wire [3:0] nl_LOOP_OUT_acc_idiv_1;
  wire [9:0] LOOP_OUT_acc_3_cse_sva_1;
  wire [10:0] nl_LOOP_OUT_acc_3_cse_sva_1;
  reg [2:0] LOOP_VAR_acc_4_cse_sva_14_12;
  reg [11:0] LOOP_VAR_acc_4_cse_sva_11_0;
  wire [4:0] leading_sign_22_0_c5945fbeaae02c4edab24e6eca5e07cb263f_1;
  wire and_107_rgt;
  wire and_108_rgt;
  wire and_109_rgt;
  wire and_110_rgt;
  wire and_111_rgt;
  reg [2:0] reg_LOOP_CH_idx_14_0_sva_2_ftd;
  reg [11:0] reg_LOOP_CH_idx_14_0_sva_2_ftd_1;
  reg [2:0] LOOP_CH_idx_14_0_sva_3_14_12;
  reg [11:0] LOOP_CH_idx_14_0_sva_3_11_0;
  wire LOOP_CH_c_or_cse;
  reg [2:0] reg_LOOP_CH_idx_14_0_sva_4_ftd;
  reg [11:0] reg_LOOP_CH_idx_14_0_sva_4_ftd_1;
  reg [2:0] LOOP_CH_idx_14_0_sva_5_14_12;
  reg [11:0] LOOP_CH_idx_14_0_sva_5_11_0;
  reg [2:0] reg_LOOP_CH_idx_14_0_sva_6_ftd;
  reg [11:0] reg_LOOP_CH_idx_14_0_sva_6_ftd_1;
  reg [2:0] LOOP_CH_idx_14_0_sva_7_14_12;
  reg [11:0] LOOP_CH_idx_14_0_sva_7_11_0;
  reg [2:0] reg_LOOP_CH_idx_14_0_sva_8_ftd;
  reg [11:0] reg_LOOP_CH_idx_14_0_sva_8_ftd_1;
  wire [24:0] ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_temp_mul_itm_35_11_1;
  wire LOOP_OUT_acc_10_itm_13_1;

  wire[13:0] operator_20_8_false_AC_TRN_AC_WRAP_13_false_mux_nl;
  wire operator_20_8_false_AC_TRN_AC_WRAP_13_false_or_1_nl;
  wire operator_20_8_false_AC_TRN_AC_WRAP_13_false_and_5_nl;
  wire operator_20_8_false_AC_TRN_AC_WRAP_13_false_or_nl;
  wire[1:0] operator_20_8_false_AC_TRN_AC_WRAP_13_false_mux_1_nl;
  wire LOOP_MEAN_mux1h_8_nl;
  wire LOOP_OUT_LOOP_OUT_and_nl;
  wire[13:0] LOOP_VAR_acc_7_nl;
  wire[14:0] nl_LOOP_VAR_acc_7_nl;
  wire[13:0] LOOP_VAR_acc_8_nl;
  wire[14:0] nl_LOOP_VAR_acc_8_nl;
  wire nor_29_nl;
  wire LOOP_MEAN_mux_3_nl;
  wire LOOP_OUT_mux_nl;
  wire[11:0] LOOP_CH_mean_tmp_LOOP_CH_mean_tmp_and_nl;
  wire[11:0] LOOP_CH_mean_tmp_mux_1_nl;
  wire and_159_nl;
  wire LOOP_CH_mean_tmp_nand_nl;
  wire or_164_nl;
  wire[17:0] LOOP_OUT_LOOP_OUT_mul_nl;
  wire signed [23:0] nl_LOOP_OUT_LOOP_OUT_mul_nl;
  wire[17:0] LOOP_OUT_mux1h_6_nl;
  wire and_105_nl;
  wire[2:0] LOOP_OUT_mux_10_nl;
  wire[4:0] ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_qif_acc_nl;
  wire[5:0] nl_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_qif_acc_nl;
  wire[7:0] LOOP_CH_acc_2_nl;
  wire[8:0] nl_LOOP_CH_acc_2_nl;
  wire[8:0] LOOP_CH_acc_3_nl;
  wire[9:0] nl_LOOP_CH_acc_3_nl;
  wire[27:0] LOOP_VAR_mul_2_nl;
  wire signed [31:0] nl_LOOP_VAR_mul_2_nl;
  wire[35:0] ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_temp_mul_nl;
  wire[36:0] nl_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_temp_mul_nl;
  wire[13:0] LOOP_OUT_acc_10_nl;
  wire[14:0] nl_LOOP_OUT_acc_10_nl;
  wire num_elements_num_elements_or_1_nl;
  wire num_elements_num_elements_and_3_nl;
  wire num_elements_mux_2_nl;
  wire[5:0] num_elements_mux1h_6_nl;
  wire num_elements_num_elements_and_4_nl;
  wire[4:0] num_elements_num_elements_and_5_nl;
  wire[4:0] num_elements_mux_3_nl;
  wire not_150_nl;
  wire[6:0] num_elements_mux1h_7_nl;
  wire[14:0] LOOP_OUT_mux_18_nl;

  // Interconnect Declarations for Component Instantiations 
  wire [21:0] nl_LOOP_OUT_div_5_cmp_a;
  assign nl_LOOP_OUT_div_5_cmp_a = {LOOP_OUT_div_5_cmp_a_21_6 , 6'b000000};
  wire [14:0] nl_LOOP_OUT_div_5_cmp_b;
  assign nl_LOOP_OUT_div_5_cmp_b = {1'b0, LOOP_OUT_div_5_cmp_b_13_0};
  wire [21:0] nl_LOOP_OUT_div_5_cmp_1_a;
  assign nl_LOOP_OUT_div_5_cmp_1_a = {LOOP_OUT_div_5_cmp_1_a_21_6 , 6'b000000};
  wire [14:0] nl_LOOP_OUT_div_5_cmp_1_b;
  assign nl_LOOP_OUT_div_5_cmp_1_b = {1'b0, LOOP_OUT_div_5_cmp_1_b_13_0};
  wire [21:0] nl_LOOP_OUT_div_5_cmp_2_a;
  assign nl_LOOP_OUT_div_5_cmp_2_a = {LOOP_OUT_div_5_cmp_2_a_21_6 , 6'b000000};
  wire [14:0] nl_LOOP_OUT_div_5_cmp_2_b;
  assign nl_LOOP_OUT_div_5_cmp_2_b = {1'b0, LOOP_OUT_div_5_cmp_2_b_13_0};
  wire [21:0] nl_LOOP_OUT_div_5_cmp_3_a;
  assign nl_LOOP_OUT_div_5_cmp_3_a = {LOOP_OUT_div_5_cmp_3_a_21_6 , 6'b000000};
  wire [14:0] nl_LOOP_OUT_div_5_cmp_3_b;
  assign nl_LOOP_OUT_div_5_cmp_3_b = {1'b0, LOOP_OUT_div_5_cmp_3_b_13_0};
  wire [21:0] nl_LOOP_OUT_div_5_cmp_4_a;
  assign nl_LOOP_OUT_div_5_cmp_4_a = {LOOP_OUT_div_5_cmp_4_a_21_6 , 6'b000000};
  wire [14:0] nl_LOOP_OUT_div_5_cmp_4_b;
  assign nl_LOOP_OUT_div_5_cmp_4_b = {1'b0, LOOP_OUT_div_5_cmp_4_b_13_0};
  wire[12:0] ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_m1_mux_1_nl;
  wire[10:0] ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_m1_mux_2_nl;
  wire ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_m1_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_m1_and_nl;
  wire [24:0] nl_operator_32_8_false_AC_TRN_AC_WRAP_lshift_rg_a;
  assign ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_m1_mux_1_nl
      = MUX_v_13_2_2(ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_24_12_sva_1,
      (ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_temp_mul_itm_35_11_1[24:12]),
      ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_qr_0_lpi_3_dfm_2);
  assign ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_m1_mux_2_nl
      = MUX_v_11_2_2((LOOP_MEAN_mul_itm_1[10:0]), (ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_temp_mul_itm_35_11_1[11:1]),
      ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_qr_0_lpi_3_dfm_2);
  assign ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_m1_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_m1_and_nl
      = (ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_temp_mul_itm_35_11_1[0])
      & ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_qr_0_lpi_3_dfm_2;
  assign nl_operator_32_8_false_AC_TRN_AC_WRAP_lshift_rg_a = {ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_m1_mux_1_nl
      , ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_m1_mux_2_nl
      , ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_m1_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_m1_and_nl};
  wire [21:0] nl_leading_sign_22_0_rg_mantissa;
  assign nl_leading_sign_22_0_rg_mantissa = {1'b0 , LOOP_CH_var_21_1_sva};
  wire  nl_UNET_IP_batchnorm_relu_run_batch_run_batch_fsm_inst_LOOP_CH_C_5_tr0;
  assign nl_UNET_IP_batchnorm_relu_run_batch_run_batch_fsm_inst_LOOP_CH_C_5_tr0 =
      ~ LOOP_MEAN_stage_0;
  wire  nl_UNET_IP_batchnorm_relu_run_batch_run_batch_fsm_inst_LOOP_OUT_C_0_tr0;
  assign nl_UNET_IP_batchnorm_relu_run_batch_run_batch_fsm_inst_LOOP_OUT_C_0_tr0
      = ~(LOOP_OUT_stage_0 | LOOP_MEAN_stage_0_2 | LOOP_MEAN_stage_0_3 | LOOP_OUT_stage_0_4
      | LOOP_OUT_stage_0_5 | LOOP_OUT_stage_0_6 | LOOP_OUT_stage_0_7 | LOOP_OUT_stage_0_8
      | LOOP_OUT_stage_0_9 | LOOP_MEAN_stage_0);
  mgc_io_sync_v2 #(.valid(32'sd0)) input_triosy_obj (
      .ld(reg_output_triosy_obj_ld_cse),
      .lz(input_triosy_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) output_triosy_obj (
      .ld(reg_output_triosy_obj_ld_cse),
      .lz(output_triosy_lz)
    );
  mgc_div #(.width_a(32'sd22),
  .width_b(32'sd15),
  .signd(32'sd1)) LOOP_OUT_div_5_cmp (
      .a(nl_LOOP_OUT_div_5_cmp_a[21:0]),
      .b(nl_LOOP_OUT_div_5_cmp_b[14:0]),
      .z(LOOP_OUT_div_5_cmp_z)
    );
  mgc_div #(.width_a(32'sd22),
  .width_b(32'sd15),
  .signd(32'sd1)) LOOP_OUT_div_5_cmp_1 (
      .a(nl_LOOP_OUT_div_5_cmp_1_a[21:0]),
      .b(nl_LOOP_OUT_div_5_cmp_1_b[14:0]),
      .z(LOOP_OUT_div_5_cmp_1_z)
    );
  mgc_div #(.width_a(32'sd22),
  .width_b(32'sd15),
  .signd(32'sd1)) LOOP_OUT_div_5_cmp_2 (
      .a(nl_LOOP_OUT_div_5_cmp_2_a[21:0]),
      .b(nl_LOOP_OUT_div_5_cmp_2_b[14:0]),
      .z(LOOP_OUT_div_5_cmp_2_z)
    );
  mgc_div #(.width_a(32'sd22),
  .width_b(32'sd15),
  .signd(32'sd1)) LOOP_OUT_div_5_cmp_3 (
      .a(nl_LOOP_OUT_div_5_cmp_3_a[21:0]),
      .b(nl_LOOP_OUT_div_5_cmp_3_b[14:0]),
      .z(LOOP_OUT_div_5_cmp_3_z)
    );
  mgc_div #(.width_a(32'sd22),
  .width_b(32'sd15),
  .signd(32'sd1)) LOOP_OUT_div_5_cmp_4 (
      .a(nl_LOOP_OUT_div_5_cmp_4_a[21:0]),
      .b(nl_LOOP_OUT_div_5_cmp_4_b[14:0]),
      .z(LOOP_OUT_div_5_cmp_4_z)
    );
  mgc_shift_bl_v5 #(.width_a(32'sd25),
  .signd_a(32'sd0),
  .width_s(32'sd5),
  .width_z(32'sd32)) operator_32_8_false_AC_TRN_AC_WRAP_lshift_rg (
      .a(nl_operator_32_8_false_AC_TRN_AC_WRAP_lshift_rg_a[24:0]),
      .s(ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_and_itm_2),
      .z(operator_32_8_false_AC_TRN_AC_WRAP_lshift_itm)
    );
  UNET_IP_batchnorm_relumgc_rom_11_736_5_1  LOOP_OUT_read_rom_UNET_IP_gamma_pretrain_rom_map_1_rg
      (
      .addr(LOOP_OUT_acc_3_cse_sva_1),
      .data_out(LOOP_OUT_read_rom_UNET_IP_gamma_pretrain_rom_map_1_itm)
    );
  UNET_IP_batchnorm_relumgc_rom_12_736_4_1  LOOP_OUT_read_rom_UNET_IP_beta_pretrain_rom_map_1_rg
      (
      .addr(LOOP_OUT_acc_3_cse_sva_1),
      .data_out(LOOP_OUT_read_rom_UNET_IP_beta_pretrain_rom_map_1_itm)
    );
  leading_sign_22_0  leading_sign_22_0_rg (
      .mantissa(nl_leading_sign_22_0_rg_mantissa[21:0]),
      .rtn(leading_sign_22_0_c5945fbeaae02c4edab24e6eca5e07cb263f_1)
    );
  mgc_shift_l_v5 #(.width_a(32'sd21),
  .signd_a(32'sd0),
  .width_s(32'sd5),
  .width_z(32'sd21)) operator_22_0_false_AC_TRN_AC_WRAP_lshift_rg (
      .a(LOOP_CH_var_21_1_sva),
      .s(leading_sign_22_0_c5945fbeaae02c4edab24e6eca5e07cb263f_1),
      .z(operator_22_0_false_AC_TRN_AC_WRAP_lshift_itm)
    );
  UNET_IP_batchnorm_relu_run_batch_wait_dp UNET_IP_batchnorm_relu_run_batch_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .arst_n(arst_n),
      .operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z(operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z),
      .operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z_oreg(operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z_oreg)
    );
  UNET_IP_batchnorm_relu_run_batch_run_batch_fsm UNET_IP_batchnorm_relu_run_batch_run_batch_fsm_inst
      (
      .clk(clk),
      .rst(rst),
      .arst_n(arst_n),
      .fsm_output(fsm_output),
      .main_C_0_tr0(exit_LOOP_CH_sva_mx0),
      .LOOP_MEAN_C_0_tr0(nor_4_cse),
      .LOOP_CH_C_5_tr0(nl_UNET_IP_batchnorm_relu_run_batch_run_batch_fsm_inst_LOOP_CH_C_5_tr0),
      .LOOP_VAR_C_3_tr0(LOOP_MEAN_stage_0),
      .LOOP_OUT_C_0_tr0(nl_UNET_IP_batchnorm_relu_run_batch_run_batch_fsm_inst_LOOP_OUT_C_0_tr0),
      .LOOP_CH_C_12_tr0(exit_LOOP_CH_sva_mx0)
    );
  assign nor_4_cse = ~(LOOP_MEAN_stage_0_2 | LOOP_MEAN_stage_0);
  assign or_123_ssc = (fsm_output[5:2]!=4'b0000);
  assign operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a = {reg_operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a_ftd
      , reg_operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a_ftd_1 , reg_operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a_ftd_2
      , 6'b000000};
  assign LOOP_CH_c_or_cse = (fsm_output[0]) | (fsm_output[19]);
  assign and_107_rgt = and_dcpl_85 & and_dcpl_94;
  assign and_108_rgt = and_dcpl_87 & and_dcpl_94;
  assign and_109_rgt = and_dcpl_89 & and_dcpl_94;
  assign and_110_rgt = and_dcpl_91 & and_dcpl_94;
  assign and_111_rgt = and_dcpl_92 & and_dcpl_94;
  assign nor_21_cse = ~((fsm_output[19]) | (fsm_output[0]));
  assign or_159_cse = (fsm_output[1]) | (fsm_output[18]);
  assign nl_LOOP_CH_acc_2_nl = ({1'b1 , (~ channels)}) + 8'b00000001;
  assign LOOP_CH_acc_2_nl = nl_LOOP_CH_acc_2_nl[7:0];
  assign nl_LOOP_CH_acc_3_nl = ({1'b1 , LOOP_CH_c_sva_2}) + conv_u2u_8_9({1'b1 ,
      (~ channels)}) + 9'b000000001;
  assign LOOP_CH_acc_3_nl = nl_LOOP_CH_acc_3_nl[8:0];
  assign exit_LOOP_CH_sva_mx0 = MUX_s_1_2_2((~ (readslicef_8_1_7(LOOP_CH_acc_2_nl))),
      (~ (readslicef_9_1_8(LOOP_CH_acc_3_nl))), fsm_output[19]);
  assign nl_LOOP_CH_c_sva_2 = conv_u2u_7_8(LOOP_CH_c_sva[6:0]) + 8'b00000001;
  assign LOOP_CH_c_sva_2 = nl_LOOP_CH_c_sva_2[7:0];
  assign nl_LOOP_VAR_mul_2_nl = $signed(({(LOOP_OUT_acc_5_itm_1[15]) , LOOP_VAR_acc_4_cse_sva_14_12
      , LOOP_VAR_acc_4_cse_sva_11_0})) * $signed(({(LOOP_OUT_acc_5_itm_1[15]) , LOOP_VAR_acc_4_cse_sva_14_12
      , LOOP_VAR_acc_4_cse_sva_11_0}));
  assign LOOP_VAR_mul_2_nl = nl_LOOP_VAR_mul_2_nl[27:0];
  assign nl_LOOP_CH_var_tmp_33_6_sva_mx0w1 = LOOP_CH_var_tmp_33_6_sva + LOOP_VAR_mul_2_nl;
  assign LOOP_CH_var_tmp_33_6_sva_mx0w1 = nl_LOOP_CH_var_tmp_33_6_sva_mx0w1[27:0];
  assign nl_LOOP_CH_i_1_sva_2 = LOOP_CH_i_1_sva + 13'b0000000000001;
  assign LOOP_CH_i_1_sva_2 = nl_LOOP_CH_i_1_sva_2[12:0];
  assign nl_LOOP_VAR_acc_4_cse_sva_mx0w1 = conv_s2s_15_16({1'b1 , (~ LOOP_CH_mean_sva)})
      + conv_s2s_14_16({input_rsci_q_d , 2'b00}) + 16'b0000000000000001;
  assign LOOP_VAR_acc_4_cse_sva_mx0w1 = nl_LOOP_VAR_acc_4_cse_sva_mx0w1[15:0];
  assign nl_LOOP_CH_mean_tmp_19_8_sva_2 = LOOP_VAR_acc_4_cse_sva_11_0 + input_rsci_q_d;
  assign LOOP_CH_mean_tmp_19_8_sva_2 = nl_LOOP_CH_mean_tmp_19_8_sva_2[11:0];
  assign or_cse = (LOOP_OUT_LOOP_OUT_acc_tmp[1:0]!=2'b00);
  assign ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_and_tmp_1
      = MUX_v_14_2_2(14'b00000000000000, ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_qr_sva_1_1,
      ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_or_itm_3);
  assign nl_LOOP_OUT_LOOP_OUT_acc_tmp = conv_u2u_1_3(LOOP_OUT_acc_imod_1[2]) + conv_u2u_2_3(LOOP_OUT_acc_imod_1[1:0]);
  assign LOOP_OUT_LOOP_OUT_acc_tmp = nl_LOOP_OUT_LOOP_OUT_acc_tmp[2:0];
  assign nl_LOOP_VAR_mul_4 = (LOOP_CH_c_sva[6:0]) * num_elements_sva;
  assign LOOP_VAR_mul_4 = nl_LOOP_VAR_mul_4[14:0];
  assign ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_or_tmp
      = (LOOP_CH_var_21_1_sva!=21'b000000000000000000000);
  assign nl_LOOP_OUT_acc_imod_1 = conv_s2s_1_3(LOOP_OUT_acc_idiv_1[2]) + conv_u2s_2_3(LOOP_OUT_acc_idiv_1[1:0]);
  assign LOOP_OUT_acc_imod_1 = nl_LOOP_OUT_acc_imod_1[2:0];
  assign nl_LOOP_OUT_acc_idiv_1 = LOOP_OUT_div_5cyc + 3'b001;
  assign LOOP_OUT_acc_idiv_1 = nl_LOOP_OUT_acc_idiv_1[2:0];
  assign nl_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_temp_mul_nl
      = 13'b1011010100001 * ({ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_24_12_sva_1
      , (LOOP_MEAN_mul_itm_1[10:0])});
  assign ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_temp_mul_nl
      = nl_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_temp_mul_nl[35:0];
  assign ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_temp_mul_itm_35_11_1
      = readslicef_36_25_11(ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_temp_mul_nl);
  assign nl_LOOP_OUT_acc_3_cse_sva_1 = conv_u2u_7_10(LOOP_CH_c_sva[6:0]) + offset;
  assign LOOP_OUT_acc_3_cse_sva_1 = nl_LOOP_OUT_acc_3_cse_sva_1[9:0];
  assign nl_LOOP_OUT_acc_10_nl = ({1'b1 , LOOP_CH_i_1_sva}) + conv_u2u_13_14(~ num_elements_sva)
      + 14'b00000000000001;
  assign LOOP_OUT_acc_10_nl = nl_LOOP_OUT_acc_10_nl[13:0];
  assign LOOP_OUT_acc_10_itm_13_1 = readslicef_14_1_13(LOOP_OUT_acc_10_nl);
  assign and_dcpl_45 = LOOP_OUT_stage_0_4 & (~ exit_LOOP_OUT_sva_st_3);
  assign and_dcpl_46 = and_dcpl_45 & (~ (LOOP_OUT_LOOP_OUT_acc_tmp[2]));
  assign and_dcpl_49 = LOOP_OUT_stage_0_5 & (~ exit_LOOP_OUT_sva_st_4);
  assign and_dcpl_50 = and_dcpl_49 & (~ (LOOP_OUT_div_5cyc_st_1[2]));
  assign or_dcpl_54 = (~ LOOP_OUT_stage_0_4) | exit_LOOP_OUT_sva_st_3;
  assign or_dcpl_55 = or_dcpl_54 | (LOOP_OUT_LOOP_OUT_acc_tmp[2]);
  assign or_dcpl_56 = or_dcpl_55 | (LOOP_OUT_LOOP_OUT_acc_tmp[1:0]!=2'b11);
  assign or_dcpl_58 = or_dcpl_55 | (LOOP_OUT_LOOP_OUT_acc_tmp[1:0]!=2'b10);
  assign or_dcpl_60 = or_dcpl_55 | (LOOP_OUT_LOOP_OUT_acc_tmp[1:0]!=2'b01);
  assign and_dcpl_63 = ~((LOOP_OUT_LOOP_OUT_acc_tmp[1:0]!=2'b00));
  assign and_dcpl_65 = ~((LOOP_OUT_div_5cyc_st_1[1:0]!=2'b00));
  assign or_dcpl_62 = or_dcpl_55 | or_cse;
  assign or_dcpl_64 = or_dcpl_54 | (~ (LOOP_OUT_LOOP_OUT_acc_tmp[2])) | or_cse;
  assign and_dcpl_77 = LOOP_MEAN_stage_0_3 & (~ ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_or_itm_3);
  assign and_dcpl_79 = ~((fsm_output[4:3]!=2'b00));
  assign and_dcpl_84 = ~((LOOP_OUT_div_5cyc_st_5[1:0]!=2'b00));
  assign and_dcpl_85 = and_dcpl_84 & (~ (LOOP_OUT_div_5cyc_st_5[2]));
  assign and_dcpl_87 = (LOOP_OUT_div_5cyc_st_5==3'b001);
  assign and_dcpl_89 = (LOOP_OUT_div_5cyc_st_5==3'b010);
  assign and_dcpl_91 = (LOOP_OUT_div_5cyc_st_5==3'b011);
  assign and_dcpl_92 = and_dcpl_84 & (LOOP_OUT_div_5cyc_st_5[2]);
  assign and_dcpl_94 = LOOP_OUT_stage_0_9 & (~ exit_LOOP_OUT_sva_st_8);
  assign LOOP_OUT_div_5_cmp_4_b_13_0_mx0c1 = or_dcpl_56 & and_dcpl_50 & (LOOP_OUT_div_5cyc_st_1[1:0]==2'b11);
  assign LOOP_OUT_div_5_cmp_3_b_13_0_mx0c1 = or_dcpl_58 & and_dcpl_50 & (LOOP_OUT_div_5cyc_st_1[1:0]==2'b10);
  assign LOOP_OUT_div_5_cmp_2_b_13_0_mx0c1 = or_dcpl_60 & and_dcpl_50 & (LOOP_OUT_div_5cyc_st_1[1:0]==2'b01);
  assign LOOP_OUT_div_5_cmp_1_b_13_0_mx0c1 = or_dcpl_62 & and_dcpl_50 & and_dcpl_65;
  assign LOOP_OUT_div_5_cmp_b_13_0_mx0c1 = or_dcpl_64 & and_dcpl_49 & (LOOP_OUT_div_5cyc_st_1[2])
      & and_dcpl_65;
  assign input_rsci_radr_d = MUX_v_15_2_2(z_out_1, LOOP_VAR_acc_1_itm, fsm_output[9]);
  assign input_rsci_re_d_pff = (fsm_output[9]) | (LOOP_MEAN_stage_0_2 & (~ LOOP_OUT_stage_0_4)
      & (fsm_output[1])) | (LOOP_MEAN_stage_0_2 & (~ exit_LOOP_OUT_sva_st_1) & (fsm_output[18]));
  assign nl_output_rsci_d_d = LOOP_OUT_slc_LOOP_OUT_mul_sdt_25_4_21_2_itm_1_11_0
      + conv_s2u_4_12(LOOP_OUT_read_rom_UNET_IP_beta_pretrain_rom_map_1_itm_2);
  assign output_rsci_d_d = nl_output_rsci_d_d[11:0];
  assign output_rsci_wadr_d = {reg_LOOP_CH_idx_14_0_sva_8_ftd , reg_LOOP_CH_idx_14_0_sva_8_ftd_1};
  assign output_rsci_we_d_pff = LOOP_MEAN_stage_0 & (~ exit_LOOP_OUT_sva_st_9) &
      (fsm_output[18]);
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      LOOP_OUT_div_5_cmp_4_b_13_0 <= 14'b00000000000000;
    end
    else if ( rst ) begin
      LOOP_OUT_div_5_cmp_4_b_13_0 <= 14'b00000000000000;
    end
    else if ( (and_dcpl_46 & (LOOP_OUT_LOOP_OUT_acc_tmp[1:0]==2'b11)) | LOOP_OUT_div_5_cmp_4_b_13_0_mx0c1
        ) begin
      LOOP_OUT_div_5_cmp_4_b_13_0 <= MUX_v_14_2_2(ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_and_tmp_1,
          mut_1_1_13_0, LOOP_OUT_div_5_cmp_4_b_13_0_mx0c1);
    end
  end
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      LOOP_OUT_div_5_cmp_4_a_21_6 <= 16'b0000000000000000;
    end
    else if ( rst ) begin
      LOOP_OUT_div_5_cmp_4_a_21_6 <= 16'b0000000000000000;
    end
    else if ( ~ or_dcpl_56 ) begin
      LOOP_OUT_div_5_cmp_4_a_21_6 <= LOOP_OUT_acc_5_itm_1;
    end
  end
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      LOOP_OUT_div_5_cmp_3_b_13_0 <= 14'b00000000000000;
    end
    else if ( rst ) begin
      LOOP_OUT_div_5_cmp_3_b_13_0 <= 14'b00000000000000;
    end
    else if ( (and_dcpl_46 & (LOOP_OUT_LOOP_OUT_acc_tmp[1:0]==2'b10)) | LOOP_OUT_div_5_cmp_3_b_13_0_mx0c1
        ) begin
      LOOP_OUT_div_5_cmp_3_b_13_0 <= MUX_v_14_2_2(ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_and_tmp_1,
          mut_1_1_13_0, LOOP_OUT_div_5_cmp_3_b_13_0_mx0c1);
    end
  end
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      LOOP_OUT_div_5_cmp_3_a_21_6 <= 16'b0000000000000000;
    end
    else if ( rst ) begin
      LOOP_OUT_div_5_cmp_3_a_21_6 <= 16'b0000000000000000;
    end
    else if ( ~ or_dcpl_58 ) begin
      LOOP_OUT_div_5_cmp_3_a_21_6 <= LOOP_OUT_acc_5_itm_1;
    end
  end
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      LOOP_OUT_div_5_cmp_2_b_13_0 <= 14'b00000000000000;
    end
    else if ( rst ) begin
      LOOP_OUT_div_5_cmp_2_b_13_0 <= 14'b00000000000000;
    end
    else if ( (and_dcpl_46 & (LOOP_OUT_LOOP_OUT_acc_tmp[1:0]==2'b01)) | LOOP_OUT_div_5_cmp_2_b_13_0_mx0c1
        ) begin
      LOOP_OUT_div_5_cmp_2_b_13_0 <= MUX_v_14_2_2(ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_and_tmp_1,
          mut_1_1_13_0, LOOP_OUT_div_5_cmp_2_b_13_0_mx0c1);
    end
  end
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      LOOP_OUT_div_5_cmp_2_a_21_6 <= 16'b0000000000000000;
    end
    else if ( rst ) begin
      LOOP_OUT_div_5_cmp_2_a_21_6 <= 16'b0000000000000000;
    end
    else if ( ~ or_dcpl_60 ) begin
      LOOP_OUT_div_5_cmp_2_a_21_6 <= LOOP_OUT_acc_5_itm_1;
    end
  end
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      LOOP_OUT_div_5_cmp_1_b_13_0 <= 14'b00000000000000;
    end
    else if ( rst ) begin
      LOOP_OUT_div_5_cmp_1_b_13_0 <= 14'b00000000000000;
    end
    else if ( (and_dcpl_46 & and_dcpl_63) | LOOP_OUT_div_5_cmp_1_b_13_0_mx0c1 ) begin
      LOOP_OUT_div_5_cmp_1_b_13_0 <= MUX_v_14_2_2(ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_and_tmp_1,
          mut_1_1_13_0, LOOP_OUT_div_5_cmp_1_b_13_0_mx0c1);
    end
  end
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      LOOP_OUT_div_5_cmp_1_a_21_6 <= 16'b0000000000000000;
    end
    else if ( rst ) begin
      LOOP_OUT_div_5_cmp_1_a_21_6 <= 16'b0000000000000000;
    end
    else if ( ~ or_dcpl_62 ) begin
      LOOP_OUT_div_5_cmp_1_a_21_6 <= LOOP_OUT_acc_5_itm_1;
    end
  end
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      LOOP_OUT_div_5_cmp_b_13_0 <= 14'b00000000000000;
    end
    else if ( rst ) begin
      LOOP_OUT_div_5_cmp_b_13_0 <= 14'b00000000000000;
    end
    else if ( (and_dcpl_45 & (LOOP_OUT_LOOP_OUT_acc_tmp[2]) & and_dcpl_63) | LOOP_OUT_div_5_cmp_b_13_0_mx0c1
        ) begin
      LOOP_OUT_div_5_cmp_b_13_0 <= MUX_v_14_2_2(ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_and_tmp_1,
          mut_1_1_13_0, LOOP_OUT_div_5_cmp_b_13_0_mx0c1);
    end
  end
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      LOOP_OUT_div_5_cmp_a_21_6 <= 16'b0000000000000000;
    end
    else if ( rst ) begin
      LOOP_OUT_div_5_cmp_a_21_6 <= 16'b0000000000000000;
    end
    else if ( ~ or_dcpl_64 ) begin
      LOOP_OUT_div_5_cmp_a_21_6 <= LOOP_OUT_acc_5_itm_1;
    end
  end
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      reg_output_triosy_obj_ld_cse <= 1'b0;
      operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_b <= 13'b0000000000000;
      reg_operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a_ftd <= 14'b00000000000000;
      reg_operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a_ftd_1 <= 12'b000000000000;
      reg_operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a_ftd_2 <= 2'b00;
      LOOP_MEAN_asn_6_itm_2 <= 1'b0;
      LOOP_MEAN_stage_0_2 <= 1'b0;
      LOOP_MEAN_stage_0_3 <= 1'b0;
      LOOP_MEAN_mul_itm_1 <= 15'b000000000000000;
      LOOP_MEAN_asn_3_itm_1 <= 13'b0000000000000;
      LOOP_OUT_stage_0_4 <= 1'b0;
      ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_or_itm_3
          <= 1'b0;
      LOOP_VAR_acc_4_cse_sva_14_12 <= 3'b000;
      LOOP_VAR_acc_4_cse_sva_11_0 <= 12'b000000000000;
      LOOP_VAR_acc_1_itm <= 15'b000000000000000;
      LOOP_OUT_slc_LOOP_OUT_mul_sdt_25_4_21_2_itm_1_11_0 <= 12'b000000000000;
      LOOP_OUT_read_rom_UNET_IP_beta_pretrain_rom_map_1_itm_2 <= 4'b0000;
      reg_LOOP_CH_idx_14_0_sva_8_ftd <= 3'b000;
      reg_LOOP_CH_idx_14_0_sva_8_ftd_1 <= 12'b000000000000;
      exit_LOOP_OUT_sva_st_9 <= 1'b0;
      LOOP_OUT_div_5cyc_st_5 <= 3'b000;
      exit_LOOP_OUT_sva_st_8 <= 1'b0;
      LOOP_OUT_div_5cyc_st_4 <= 3'b000;
      exit_LOOP_OUT_sva_st_7 <= 1'b0;
      LOOP_OUT_div_5cyc_st_3 <= 3'b000;
      exit_LOOP_OUT_sva_st_6 <= 1'b0;
      LOOP_OUT_div_5cyc_st_2 <= 3'b000;
      exit_LOOP_OUT_sva_st_5 <= 1'b0;
      mut_1_1_13_0 <= 14'b00000000000000;
      LOOP_OUT_div_5cyc_st_1 <= 3'b000;
      exit_LOOP_OUT_sva_st_4 <= 1'b0;
      LOOP_OUT_acc_5_itm_1 <= 16'b0000000000000000;
      LOOP_OUT_div_5cyc <= 3'b000;
      ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_qr_sva_1_1
          <= 14'b00000000000000;
      exit_LOOP_OUT_sva_st_3 <= 1'b0;
      exit_LOOP_OUT_sva_st_2 <= 1'b0;
      LOOP_OUT_mul_itm_1 <= 15'b000000000000000;
      exit_LOOP_OUT_sva_st_1 <= 1'b0;
      LOOP_OUT_stage_0 <= 1'b0;
      LOOP_OUT_stage_0_5 <= 1'b0;
      LOOP_OUT_stage_0_6 <= 1'b0;
      LOOP_OUT_stage_0_7 <= 1'b0;
      LOOP_OUT_stage_0_8 <= 1'b0;
      LOOP_OUT_stage_0_9 <= 1'b0;
      LOOP_OUT_read_rom_UNET_IP_gamma_pretrain_rom_map_1_itm_1 <= 5'b00000;
      ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_24_12_sva_1
          <= 13'b0000000000000;
      ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_qr_0_lpi_3_dfm_2 <=
          1'b0;
      ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_and_itm_2
          <= 5'b00000;
      LOOP_OUT_read_rom_UNET_IP_beta_pretrain_rom_map_1_itm_1 <= 4'b0000;
      LOOP_CH_idx_14_0_sva_7_14_12 <= 3'b000;
      LOOP_CH_idx_14_0_sva_7_11_0 <= 12'b000000000000;
      ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux_1_itm_1
          <= 10'b0000000000;
      ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_normalized_fixed_temp_slc_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_normalized_fixed_temp_1_20_7_11_0_itm_1
          <= 12'b000000000000;
      ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux_itm_1
          <= 6'b000000;
      ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_or_itm_1
          <= 1'b0;
      ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_and_itm_1
          <= 5'b00000;
      ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_qr_0_lpi_3_dfm_1 <=
          1'b0;
      reg_LOOP_CH_idx_14_0_sva_6_ftd <= 3'b000;
      reg_LOOP_CH_idx_14_0_sva_6_ftd_1 <= 12'b000000000000;
      LOOP_CH_idx_14_0_sva_5_14_12 <= 3'b000;
      LOOP_CH_idx_14_0_sva_5_11_0 <= 12'b000000000000;
      reg_LOOP_CH_idx_14_0_sva_4_ftd <= 3'b000;
      reg_LOOP_CH_idx_14_0_sva_4_ftd_1 <= 12'b000000000000;
      LOOP_CH_idx_14_0_sva_3_14_12 <= 3'b000;
      LOOP_CH_idx_14_0_sva_3_11_0 <= 12'b000000000000;
      reg_LOOP_CH_idx_14_0_sva_2_ftd <= 3'b000;
      reg_LOOP_CH_idx_14_0_sva_2_ftd_1 <= 12'b000000000000;
    end
    else if ( rst ) begin
      reg_output_triosy_obj_ld_cse <= 1'b0;
      operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_b <= 13'b0000000000000;
      reg_operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a_ftd <= 14'b00000000000000;
      reg_operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a_ftd_1 <= 12'b000000000000;
      reg_operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a_ftd_2 <= 2'b00;
      LOOP_MEAN_asn_6_itm_2 <= 1'b0;
      LOOP_MEAN_stage_0_2 <= 1'b0;
      LOOP_MEAN_stage_0_3 <= 1'b0;
      LOOP_MEAN_mul_itm_1 <= 15'b000000000000000;
      LOOP_MEAN_asn_3_itm_1 <= 13'b0000000000000;
      LOOP_OUT_stage_0_4 <= 1'b0;
      ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_or_itm_3
          <= 1'b0;
      LOOP_VAR_acc_4_cse_sva_14_12 <= 3'b000;
      LOOP_VAR_acc_4_cse_sva_11_0 <= 12'b000000000000;
      LOOP_VAR_acc_1_itm <= 15'b000000000000000;
      LOOP_OUT_slc_LOOP_OUT_mul_sdt_25_4_21_2_itm_1_11_0 <= 12'b000000000000;
      LOOP_OUT_read_rom_UNET_IP_beta_pretrain_rom_map_1_itm_2 <= 4'b0000;
      reg_LOOP_CH_idx_14_0_sva_8_ftd <= 3'b000;
      reg_LOOP_CH_idx_14_0_sva_8_ftd_1 <= 12'b000000000000;
      exit_LOOP_OUT_sva_st_9 <= 1'b0;
      LOOP_OUT_div_5cyc_st_5 <= 3'b000;
      exit_LOOP_OUT_sva_st_8 <= 1'b0;
      LOOP_OUT_div_5cyc_st_4 <= 3'b000;
      exit_LOOP_OUT_sva_st_7 <= 1'b0;
      LOOP_OUT_div_5cyc_st_3 <= 3'b000;
      exit_LOOP_OUT_sva_st_6 <= 1'b0;
      LOOP_OUT_div_5cyc_st_2 <= 3'b000;
      exit_LOOP_OUT_sva_st_5 <= 1'b0;
      mut_1_1_13_0 <= 14'b00000000000000;
      LOOP_OUT_div_5cyc_st_1 <= 3'b000;
      exit_LOOP_OUT_sva_st_4 <= 1'b0;
      LOOP_OUT_acc_5_itm_1 <= 16'b0000000000000000;
      LOOP_OUT_div_5cyc <= 3'b000;
      ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_qr_sva_1_1
          <= 14'b00000000000000;
      exit_LOOP_OUT_sva_st_3 <= 1'b0;
      exit_LOOP_OUT_sva_st_2 <= 1'b0;
      LOOP_OUT_mul_itm_1 <= 15'b000000000000000;
      exit_LOOP_OUT_sva_st_1 <= 1'b0;
      LOOP_OUT_stage_0 <= 1'b0;
      LOOP_OUT_stage_0_5 <= 1'b0;
      LOOP_OUT_stage_0_6 <= 1'b0;
      LOOP_OUT_stage_0_7 <= 1'b0;
      LOOP_OUT_stage_0_8 <= 1'b0;
      LOOP_OUT_stage_0_9 <= 1'b0;
      LOOP_OUT_read_rom_UNET_IP_gamma_pretrain_rom_map_1_itm_1 <= 5'b00000;
      ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_24_12_sva_1
          <= 13'b0000000000000;
      ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_qr_0_lpi_3_dfm_2 <=
          1'b0;
      ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_and_itm_2
          <= 5'b00000;
      LOOP_OUT_read_rom_UNET_IP_beta_pretrain_rom_map_1_itm_1 <= 4'b0000;
      LOOP_CH_idx_14_0_sva_7_14_12 <= 3'b000;
      LOOP_CH_idx_14_0_sva_7_11_0 <= 12'b000000000000;
      ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux_1_itm_1
          <= 10'b0000000000;
      ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_normalized_fixed_temp_slc_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_normalized_fixed_temp_1_20_7_11_0_itm_1
          <= 12'b000000000000;
      ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux_itm_1
          <= 6'b000000;
      ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_or_itm_1
          <= 1'b0;
      ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_and_itm_1
          <= 5'b00000;
      ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_qr_0_lpi_3_dfm_1 <=
          1'b0;
      reg_LOOP_CH_idx_14_0_sva_6_ftd <= 3'b000;
      reg_LOOP_CH_idx_14_0_sva_6_ftd_1 <= 12'b000000000000;
      LOOP_CH_idx_14_0_sva_5_14_12 <= 3'b000;
      LOOP_CH_idx_14_0_sva_5_11_0 <= 12'b000000000000;
      reg_LOOP_CH_idx_14_0_sva_4_ftd <= 3'b000;
      reg_LOOP_CH_idx_14_0_sva_4_ftd_1 <= 12'b000000000000;
      LOOP_CH_idx_14_0_sva_3_14_12 <= 3'b000;
      LOOP_CH_idx_14_0_sva_3_11_0 <= 12'b000000000000;
      reg_LOOP_CH_idx_14_0_sva_2_ftd <= 3'b000;
      reg_LOOP_CH_idx_14_0_sva_2_ftd_1 <= 12'b000000000000;
    end
    else begin
      reg_output_triosy_obj_ld_cse <= ~(nor_21_cse | (~ exit_LOOP_CH_sva_mx0));
      operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_b <= num_elements_sva;
      reg_operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a_ftd <= operator_20_8_false_AC_TRN_AC_WRAP_13_false_mux_nl
          & (signext_14_1(~ (fsm_output[1]))) & (signext_14_1(~ or_123_ssc));
      reg_operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a_ftd_1 <= MUX1HOT_v_12_4_2(LOOP_VAR_acc_4_cse_sva_11_0,
          LOOP_CH_mean_tmp_19_8_sva_2, (LOOP_CH_var_tmp_33_6_sva[13:2]), (LOOP_CH_var_tmp_33_6_sva_mx0w1[13:2]),
          {operator_20_8_false_AC_TRN_AC_WRAP_13_false_or_1_nl , operator_20_8_false_AC_TRN_AC_WRAP_13_false_and_5_nl
          , operator_20_8_false_AC_TRN_AC_WRAP_13_false_or_nl , (fsm_output[11])});
      reg_operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a_ftd_2 <= operator_20_8_false_AC_TRN_AC_WRAP_13_false_mux_1_nl
          & (signext_2_1(~ (fsm_output[1]))) & (signext_2_1(~ or_123_ssc));
      LOOP_MEAN_asn_6_itm_2 <= MUX_s_1_2_2(LOOP_OUT_stage_0_4, ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_or_itm_1,
          fsm_output[18]);
      LOOP_MEAN_stage_0_2 <= LOOP_MEAN_mux_3_nl & (~((fsm_output[17]) | (fsm_output[19])
          | (fsm_output[0])));
      LOOP_MEAN_stage_0_3 <= LOOP_MEAN_stage_0_2 & or_159_cse;
      LOOP_MEAN_mul_itm_1 <= z_out[14:0];
      LOOP_MEAN_asn_3_itm_1 <= LOOP_CH_i_1_sva;
      LOOP_OUT_stage_0_4 <= LOOP_OUT_mux_nl & or_159_cse;
      ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_or_itm_3
          <= MUX_s_1_2_2(LOOP_OUT_stage_0_4, LOOP_MEAN_asn_6_itm_2, fsm_output[18]);
      LOOP_VAR_acc_4_cse_sva_14_12 <= MUX_v_3_2_2((LOOP_VAR_acc_4_cse_sva_mx0w1[14:12]),
          (z_out_1[14:12]), fsm_output[18]);
      LOOP_VAR_acc_4_cse_sva_11_0 <= MUX1HOT_v_12_3_2(LOOP_CH_mean_tmp_LOOP_CH_mean_tmp_and_nl,
          (LOOP_VAR_acc_4_cse_sva_mx0w1[11:0]), (z_out_1[11:0]), {or_164_nl , (fsm_output[10])
          , (fsm_output[18])});
      LOOP_VAR_acc_1_itm <= nl_LOOP_VAR_acc_1_itm[14:0];
      LOOP_OUT_slc_LOOP_OUT_mul_sdt_25_4_21_2_itm_1_11_0 <= readslicef_18_12_6(LOOP_OUT_LOOP_OUT_mul_nl);
      LOOP_OUT_read_rom_UNET_IP_beta_pretrain_rom_map_1_itm_2 <= LOOP_OUT_read_rom_UNET_IP_beta_pretrain_rom_map_1_itm_1;
      reg_LOOP_CH_idx_14_0_sva_8_ftd <= LOOP_CH_idx_14_0_sva_7_14_12;
      reg_LOOP_CH_idx_14_0_sva_8_ftd_1 <= LOOP_CH_idx_14_0_sva_7_11_0;
      exit_LOOP_OUT_sva_st_9 <= exit_LOOP_OUT_sva_st_8;
      LOOP_OUT_div_5cyc_st_5 <= LOOP_OUT_div_5cyc_st_4;
      exit_LOOP_OUT_sva_st_8 <= exit_LOOP_OUT_sva_st_7;
      LOOP_OUT_div_5cyc_st_4 <= LOOP_OUT_div_5cyc_st_3;
      exit_LOOP_OUT_sva_st_7 <= exit_LOOP_OUT_sva_st_6;
      LOOP_OUT_div_5cyc_st_3 <= LOOP_OUT_div_5cyc_st_2;
      exit_LOOP_OUT_sva_st_6 <= exit_LOOP_OUT_sva_st_5;
      LOOP_OUT_div_5cyc_st_2 <= LOOP_OUT_div_5cyc_st_1;
      exit_LOOP_OUT_sva_st_5 <= exit_LOOP_OUT_sva_st_4;
      mut_1_1_13_0 <= ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_and_tmp_1;
      LOOP_OUT_div_5cyc_st_1 <= LOOP_OUT_LOOP_OUT_acc_tmp;
      exit_LOOP_OUT_sva_st_4 <= exit_LOOP_OUT_sva_st_3;
      LOOP_OUT_acc_5_itm_1 <= LOOP_VAR_acc_4_cse_sva_mx0w1;
      LOOP_OUT_div_5cyc <= MUX_v_3_2_2(3'b000, LOOP_OUT_mux_10_nl, (fsm_output[18]));
      ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_qr_sva_1_1
          <= operator_32_8_false_AC_TRN_AC_WRAP_lshift_itm[31:18];
      exit_LOOP_OUT_sva_st_3 <= exit_LOOP_OUT_sva_st_2;
      exit_LOOP_OUT_sva_st_2 <= exit_LOOP_OUT_sva_st_1;
      LOOP_OUT_mul_itm_1 <= LOOP_VAR_mul_4;
      exit_LOOP_OUT_sva_st_1 <= ~ LOOP_OUT_acc_10_itm_13_1;
      LOOP_OUT_stage_0 <= ~((~(LOOP_OUT_stage_0 & LOOP_OUT_acc_10_itm_13_1)) & (fsm_output[18]));
      LOOP_OUT_stage_0_5 <= LOOP_OUT_stage_0_4 & (fsm_output[18]);
      LOOP_OUT_stage_0_6 <= LOOP_OUT_stage_0_5 & (fsm_output[18]);
      LOOP_OUT_stage_0_7 <= LOOP_OUT_stage_0_6 & (fsm_output[18]);
      LOOP_OUT_stage_0_8 <= LOOP_OUT_stage_0_7 & (fsm_output[18]);
      LOOP_OUT_stage_0_9 <= LOOP_OUT_stage_0_8 & (fsm_output[18]);
      LOOP_OUT_read_rom_UNET_IP_gamma_pretrain_rom_map_1_itm_1 <= LOOP_OUT_read_rom_UNET_IP_gamma_pretrain_rom_map_1_itm;
      ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_24_12_sva_1
          <= nl_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_24_12_sva_1[12:0];
      ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_qr_0_lpi_3_dfm_2 <=
          ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_qr_0_lpi_3_dfm_1;
      ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_and_itm_2
          <= ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_and_itm_1;
      LOOP_OUT_read_rom_UNET_IP_beta_pretrain_rom_map_1_itm_1 <= LOOP_OUT_read_rom_UNET_IP_beta_pretrain_rom_map_1_itm;
      LOOP_CH_idx_14_0_sva_7_14_12 <= reg_LOOP_CH_idx_14_0_sva_6_ftd;
      LOOP_CH_idx_14_0_sva_7_11_0 <= reg_LOOP_CH_idx_14_0_sva_6_ftd_1;
      ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux_1_itm_1
          <= MUX_v_10_4_2(10'b0110101001, 10'b1001010100, 10'b1011101110, 10'b1101111100,
          operator_22_0_false_AC_TRN_AC_WRAP_lshift_itm[20:19]);
      ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_normalized_fixed_temp_slc_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_normalized_fixed_temp_1_20_7_11_0_itm_1
          <= operator_22_0_false_AC_TRN_AC_WRAP_lshift_itm[18:7];
      ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux_itm_1
          <= MUX_v_6_4_2(6'b101011, 6'b011010, 6'b001110, 6'b000100, operator_22_0_false_AC_TRN_AC_WRAP_lshift_itm[20:19]);
      ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_or_itm_1
          <= ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_or_tmp;
      ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_and_itm_1
          <= MUX_v_5_2_2(5'b00000, ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_qif_acc_nl,
          ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_or_tmp);
      ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_qr_0_lpi_3_dfm_1 <=
          (~ (leading_sign_22_0_c5945fbeaae02c4edab24e6eca5e07cb263f_1[0])) & ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_or_tmp;
      reg_LOOP_CH_idx_14_0_sva_6_ftd <= LOOP_CH_idx_14_0_sva_5_14_12;
      reg_LOOP_CH_idx_14_0_sva_6_ftd_1 <= LOOP_CH_idx_14_0_sva_5_11_0;
      LOOP_CH_idx_14_0_sva_5_14_12 <= reg_LOOP_CH_idx_14_0_sva_4_ftd;
      LOOP_CH_idx_14_0_sva_5_11_0 <= reg_LOOP_CH_idx_14_0_sva_4_ftd_1;
      reg_LOOP_CH_idx_14_0_sva_4_ftd <= LOOP_CH_idx_14_0_sva_3_14_12;
      reg_LOOP_CH_idx_14_0_sva_4_ftd_1 <= LOOP_CH_idx_14_0_sva_3_11_0;
      LOOP_CH_idx_14_0_sva_3_14_12 <= reg_LOOP_CH_idx_14_0_sva_2_ftd;
      LOOP_CH_idx_14_0_sva_3_11_0 <= reg_LOOP_CH_idx_14_0_sva_2_ftd_1;
      reg_LOOP_CH_idx_14_0_sva_2_ftd <= LOOP_VAR_acc_4_cse_sva_14_12;
      reg_LOOP_CH_idx_14_0_sva_2_ftd_1 <= LOOP_VAR_acc_4_cse_sva_11_0;
    end
  end
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      num_elements_sva <= 13'b0000000000000;
    end
    else if ( rst ) begin
      num_elements_sva <= 13'b0000000000000;
    end
    else if ( (fsm_output[20]) | (fsm_output[0]) ) begin
      num_elements_sva <= z_out[12:0];
    end
  end
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      LOOP_CH_c_sva <= 8'b00000000;
    end
    else if ( rst ) begin
      LOOP_CH_c_sva <= 8'b00000000;
    end
    else if ( LOOP_CH_c_or_cse ) begin
      LOOP_CH_c_sva <= MUX_v_8_2_2(8'b00000000, LOOP_CH_c_sva_2, (fsm_output[19]));
    end
  end
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      LOOP_OUT_div_tmp_duc_17_0 <= 18'b000000000000000000;
    end
    else if ( rst ) begin
      LOOP_OUT_div_tmp_duc_17_0 <= 18'b000000000000000000;
    end
    else if ( (fsm_output[18]) & (and_107_rgt | and_108_rgt | and_109_rgt | and_110_rgt
        | and_111_rgt) ) begin
      LOOP_OUT_div_tmp_duc_17_0 <= MUX1HOT_v_18_5_2((LOOP_OUT_div_5_cmp_1_z[17:0]),
          (LOOP_OUT_div_5_cmp_2_z[17:0]), (LOOP_OUT_div_5_cmp_3_z[17:0]), (LOOP_OUT_div_5_cmp_4_z[17:0]),
          (LOOP_OUT_div_5_cmp_z[17:0]), {and_107_rgt , and_108_rgt , and_109_rgt
          , and_110_rgt , and_111_rgt});
    end
  end
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      LOOP_CH_var_tmp_33_6_sva <= 28'b0000000000000000000000000000;
    end
    else if ( rst ) begin
      LOOP_CH_var_tmp_33_6_sva <= 28'b0000000000000000000000000000;
    end
    else if ( (fsm_output[11]) | LOOP_CH_c_or_cse ) begin
      LOOP_CH_var_tmp_33_6_sva <= MUX_v_28_2_2(28'b0000000000000000000000000000,
          LOOP_CH_var_tmp_33_6_sva_mx0w1, (fsm_output[11]));
    end
  end
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      LOOP_MEAN_stage_0 <= 1'b0;
    end
    else if ( rst ) begin
      LOOP_MEAN_stage_0 <= 1'b0;
    end
    else if ( LOOP_CH_c_or_cse | (fsm_output[1]) | (fsm_output[2]) | (fsm_output[8])
        | (fsm_output[17]) | (fsm_output[18]) ) begin
      LOOP_MEAN_stage_0 <= ~((~(LOOP_MEAN_mux1h_8_nl | LOOP_CH_c_or_cse)) | (fsm_output[17]));
    end
  end
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      LOOP_CH_i_1_sva <= 13'b0000000000000;
    end
    else if ( rst ) begin
      LOOP_CH_i_1_sva <= 13'b0000000000000;
    end
    else if ( ~((fsm_output[11:9]!=3'b000)) ) begin
      LOOP_CH_i_1_sva <= MUX_v_13_2_2(13'b0000000000000, LOOP_CH_i_1_sva_2, nor_29_nl);
    end
  end
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      LOOP_CH_mean_sva <= 14'b00000000000000;
    end
    else if ( rst ) begin
      LOOP_CH_mean_sva <= 14'b00000000000000;
    end
    else if ( ~((~((fsm_output[5]) | (fsm_output[6]) | (fsm_output[20]))) & and_dcpl_79
        & (~((fsm_output[2]) | (fsm_output[7]) | (fsm_output[1]))) & nor_21_cse)
        ) begin
      LOOP_CH_mean_sva <= operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z_oreg[13:0];
    end
  end
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      LOOP_CH_var_21_1_sva <= 21'b000000000000000000000;
    end
    else if ( rst ) begin
      LOOP_CH_var_21_1_sva <= 21'b000000000000000000000;
    end
    else if ( ~ (fsm_output[18]) ) begin
      LOOP_CH_var_21_1_sva <= operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z_oreg[27:7];
    end
  end
  assign operator_20_8_false_AC_TRN_AC_WRAP_13_false_mux_nl = MUX_v_14_2_2((LOOP_CH_var_tmp_33_6_sva[27:14]),
      (LOOP_CH_var_tmp_33_6_sva_mx0w1[27:14]), fsm_output[11]);
  assign operator_20_8_false_AC_TRN_AC_WRAP_13_false_or_1_nl = ((~ and_dcpl_77) &
      (fsm_output[1])) | or_123_ssc;
  assign operator_20_8_false_AC_TRN_AC_WRAP_13_false_and_5_nl = and_dcpl_77 & (fsm_output[1]);
  assign operator_20_8_false_AC_TRN_AC_WRAP_13_false_or_nl = (fsm_output[7]) | (fsm_output[15])
      | (fsm_output[14]) | (fsm_output[13]) | (fsm_output[12]);
  assign operator_20_8_false_AC_TRN_AC_WRAP_13_false_mux_1_nl = MUX_v_2_2_2((LOOP_CH_var_tmp_33_6_sva[1:0]),
      (LOOP_CH_var_tmp_33_6_sva_mx0w1[1:0]), fsm_output[11]);
  assign LOOP_MEAN_mux_3_nl = MUX_s_1_2_2(LOOP_MEAN_stage_0, LOOP_OUT_stage_0, fsm_output[18]);
  assign LOOP_OUT_mux_nl = MUX_s_1_2_2((~ LOOP_OUT_acc_10_itm_13_1), LOOP_MEAN_stage_0_3,
      fsm_output[18]);
  assign and_159_nl = (nor_4_cse | (~ LOOP_MEAN_asn_6_itm_2)) & and_dcpl_77 & (fsm_output[1]);
  assign LOOP_CH_mean_tmp_mux_1_nl = MUX_v_12_2_2(LOOP_VAR_acc_4_cse_sva_11_0, LOOP_CH_mean_tmp_19_8_sva_2,
      and_159_nl);
  assign LOOP_CH_mean_tmp_nand_nl = ~(and_dcpl_79 & (fsm_output[2:1]==2'b00));
  assign LOOP_CH_mean_tmp_LOOP_CH_mean_tmp_and_nl = MUX_v_12_2_2(12'b000000000000,
      LOOP_CH_mean_tmp_mux_1_nl, LOOP_CH_mean_tmp_nand_nl);
  assign or_164_nl = (fsm_output[4]) | (fsm_output[3]) | (fsm_output[2]) | (fsm_output[1])
      | (fsm_output[19]) | (fsm_output[0]);
  assign nl_LOOP_VAR_acc_1_itm  = LOOP_VAR_mul_4 + conv_u2u_13_15(LOOP_CH_i_1_sva);
  assign and_105_nl = ((LOOP_OUT_div_5cyc_st_5[1:0]!=2'b00)) & (LOOP_OUT_div_5cyc_st_5[2]);
  assign LOOP_OUT_mux1h_6_nl = MUX1HOT_v_18_6_2((LOOP_OUT_div_5_cmp_1_z[17:0]), (LOOP_OUT_div_5_cmp_2_z[17:0]),
      (LOOP_OUT_div_5_cmp_3_z[17:0]), (LOOP_OUT_div_5_cmp_4_z[17:0]), (LOOP_OUT_div_5_cmp_z[17:0]),
      LOOP_OUT_div_tmp_duc_17_0, {and_dcpl_85 , and_dcpl_87 , and_dcpl_89 , and_dcpl_91
      , and_dcpl_92 , and_105_nl});
  assign nl_LOOP_OUT_LOOP_OUT_mul_nl = $signed(conv_u2s_5_6(LOOP_OUT_read_rom_UNET_IP_gamma_pretrain_rom_map_1_itm_1))
      * $signed(LOOP_OUT_mux1h_6_nl);
  assign LOOP_OUT_LOOP_OUT_mul_nl = nl_LOOP_OUT_LOOP_OUT_mul_nl[17:0];
  assign LOOP_OUT_mux_10_nl = MUX_v_3_2_2(LOOP_OUT_LOOP_OUT_acc_tmp, LOOP_OUT_div_5cyc,
      or_dcpl_54);
  assign nl_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_24_12_sva_1
      = conv_u2u_9_13(z_out[19:11]) + conv_u2u_12_13({1'b1 , ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux_1_itm_1
      , 1'b1});
  assign nl_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_qif_acc_nl = ({1'b1
      , (~ (leading_sign_22_0_c5945fbeaae02c4edab24e6eca5e07cb263f_1[4:1]))}) + 5'b01001;
  assign ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_qif_acc_nl = nl_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_qif_acc_nl[4:0];
  assign LOOP_OUT_LOOP_OUT_and_nl = LOOP_MEAN_stage_0 & LOOP_OUT_acc_10_itm_13_1;
  assign nl_LOOP_VAR_acc_7_nl = ({1'b1 , (~ num_elements_sva)}) + 14'b00000000000001;
  assign LOOP_VAR_acc_7_nl = nl_LOOP_VAR_acc_7_nl[13:0];
  assign nl_LOOP_VAR_acc_8_nl = ({1'b1 , LOOP_CH_i_1_sva_2}) + conv_u2u_13_14(~ num_elements_sva)
      + 14'b00000000000001;
  assign LOOP_VAR_acc_8_nl = nl_LOOP_VAR_acc_8_nl[13:0];
  assign LOOP_MEAN_mux1h_8_nl = MUX1HOT_s_1_4_2(LOOP_OUT_LOOP_OUT_and_nl, (readslicef_14_1_13(LOOP_VAR_acc_7_nl)),
      (~ (readslicef_14_1_13(LOOP_VAR_acc_8_nl))), LOOP_OUT_stage_0_9, {(fsm_output[1])
      , (fsm_output[2]) , (fsm_output[8]) , (fsm_output[18])});
  assign nor_29_nl = ~((fsm_output[17]) | (fsm_output[7]) | LOOP_CH_c_or_cse);
  assign num_elements_num_elements_or_1_nl = ((LOOP_CH_c_sva[7]) & (~ (fsm_output[0])))
      | (fsm_output[18]);
  assign num_elements_mux_2_nl = MUX_s_1_2_2((width[6]), (LOOP_CH_c_sva[6]), fsm_output[1]);
  assign num_elements_num_elements_and_3_nl = num_elements_mux_2_nl & (~ (fsm_output[18]));
  assign num_elements_mux1h_6_nl = MUX1HOT_v_6_3_2((width[5:0]), (LOOP_CH_c_sva[5:0]),
      ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux_itm_1,
      {(fsm_output[0]) , (fsm_output[1]) , (fsm_output[18])});
  assign num_elements_num_elements_and_4_nl = (num_elements_sva[12]) & (~((fsm_output[0])
      | (fsm_output[18])));
  assign num_elements_mux_3_nl = MUX_v_5_2_2((num_elements_sva[11:7]), (ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_normalized_fixed_temp_slc_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_normalized_fixed_temp_1_20_7_11_0_itm_1[11:7]),
      fsm_output[18]);
  assign not_150_nl = ~ (fsm_output[0]);
  assign num_elements_num_elements_and_5_nl = MUX_v_5_2_2(5'b00000, num_elements_mux_3_nl,
      not_150_nl);
  assign num_elements_mux1h_7_nl = MUX1HOT_v_7_3_2(height, (num_elements_sva[6:0]),
      (ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_normalized_fixed_temp_slc_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_normalized_fixed_temp_1_20_7_11_0_itm_1[6:0]),
      {(fsm_output[0]) , (fsm_output[1]) , (fsm_output[18])});
  assign nl_z_out = ({num_elements_num_elements_or_1_nl , num_elements_num_elements_and_3_nl
      , num_elements_mux1h_6_nl}) * ({num_elements_num_elements_and_4_nl , num_elements_num_elements_and_5_nl
      , num_elements_mux1h_7_nl});
  assign z_out = nl_z_out[19:0];
  assign LOOP_OUT_mux_18_nl = MUX_v_15_2_2(LOOP_OUT_mul_itm_1, LOOP_MEAN_mul_itm_1,
      fsm_output[1]);
  assign nl_z_out_1 = LOOP_OUT_mux_18_nl + conv_u2u_13_15(LOOP_MEAN_asn_3_itm_1);
  assign z_out_1 = nl_z_out_1[14:0];

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


  function automatic [11:0] MUX1HOT_v_12_3_2;
    input [11:0] input_2;
    input [11:0] input_1;
    input [11:0] input_0;
    input [2:0] sel;
    reg [11:0] result;
  begin
    result = input_0 & {12{sel[0]}};
    result = result | (input_1 & {12{sel[1]}});
    result = result | (input_2 & {12{sel[2]}});
    MUX1HOT_v_12_3_2 = result;
  end
  endfunction


  function automatic [11:0] MUX1HOT_v_12_4_2;
    input [11:0] input_3;
    input [11:0] input_2;
    input [11:0] input_1;
    input [11:0] input_0;
    input [3:0] sel;
    reg [11:0] result;
  begin
    result = input_0 & {12{sel[0]}};
    result = result | (input_1 & {12{sel[1]}});
    result = result | (input_2 & {12{sel[2]}});
    result = result | (input_3 & {12{sel[3]}});
    MUX1HOT_v_12_4_2 = result;
  end
  endfunction


  function automatic [17:0] MUX1HOT_v_18_5_2;
    input [17:0] input_4;
    input [17:0] input_3;
    input [17:0] input_2;
    input [17:0] input_1;
    input [17:0] input_0;
    input [4:0] sel;
    reg [17:0] result;
  begin
    result = input_0 & {18{sel[0]}};
    result = result | (input_1 & {18{sel[1]}});
    result = result | (input_2 & {18{sel[2]}});
    result = result | (input_3 & {18{sel[3]}});
    result = result | (input_4 & {18{sel[4]}});
    MUX1HOT_v_18_5_2 = result;
  end
  endfunction


  function automatic [17:0] MUX1HOT_v_18_6_2;
    input [17:0] input_5;
    input [17:0] input_4;
    input [17:0] input_3;
    input [17:0] input_2;
    input [17:0] input_1;
    input [17:0] input_0;
    input [5:0] sel;
    reg [17:0] result;
  begin
    result = input_0 & {18{sel[0]}};
    result = result | (input_1 & {18{sel[1]}});
    result = result | (input_2 & {18{sel[2]}});
    result = result | (input_3 & {18{sel[3]}});
    result = result | (input_4 & {18{sel[4]}});
    result = result | (input_5 & {18{sel[5]}});
    MUX1HOT_v_18_6_2 = result;
  end
  endfunction


  function automatic [5:0] MUX1HOT_v_6_3_2;
    input [5:0] input_2;
    input [5:0] input_1;
    input [5:0] input_0;
    input [2:0] sel;
    reg [5:0] result;
  begin
    result = input_0 & {6{sel[0]}};
    result = result | (input_1 & {6{sel[1]}});
    result = result | (input_2 & {6{sel[2]}});
    MUX1HOT_v_6_3_2 = result;
  end
  endfunction


  function automatic [6:0] MUX1HOT_v_7_3_2;
    input [6:0] input_2;
    input [6:0] input_1;
    input [6:0] input_0;
    input [2:0] sel;
    reg [6:0] result;
  begin
    result = input_0 & {7{sel[0]}};
    result = result | (input_1 & {7{sel[1]}});
    result = result | (input_2 & {7{sel[2]}});
    MUX1HOT_v_7_3_2 = result;
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


  function automatic [27:0] MUX_v_28_2_2;
    input [27:0] input_0;
    input [27:0] input_1;
    input  sel;
    reg [27:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_28_2_2 = result;
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


  function automatic [0:0] readslicef_14_1_13;
    input [13:0] vector;
    reg [13:0] tmp;
  begin
    tmp = vector >> 13;
    readslicef_14_1_13 = tmp[0:0];
  end
  endfunction


  function automatic [11:0] readslicef_18_12_6;
    input [17:0] vector;
    reg [17:0] tmp;
  begin
    tmp = vector >> 6;
    readslicef_18_12_6 = tmp[11:0];
  end
  endfunction


  function automatic [24:0] readslicef_36_25_11;
    input [35:0] vector;
    reg [35:0] tmp;
  begin
    tmp = vector >> 11;
    readslicef_36_25_11 = tmp[24:0];
  end
  endfunction


  function automatic [0:0] readslicef_8_1_7;
    input [7:0] vector;
    reg [7:0] tmp;
  begin
    tmp = vector >> 7;
    readslicef_8_1_7 = tmp[0:0];
  end
  endfunction


  function automatic [0:0] readslicef_9_1_8;
    input [8:0] vector;
    reg [8:0] tmp;
  begin
    tmp = vector >> 8;
    readslicef_9_1_8 = tmp[0:0];
  end
  endfunction


  function automatic [13:0] signext_14_1;
    input  vector;
  begin
    signext_14_1= {{13{vector}}, vector};
  end
  endfunction


  function automatic [1:0] signext_2_1;
    input  vector;
  begin
    signext_2_1= {{1{vector}}, vector};
  end
  endfunction


  function automatic [2:0] conv_s2s_1_3 ;
    input [0:0]  vector ;
  begin
    conv_s2s_1_3 = {{2{vector[0]}}, vector};
  end
  endfunction


  function automatic [15:0] conv_s2s_14_16 ;
    input [13:0]  vector ;
  begin
    conv_s2s_14_16 = {{2{vector[13]}}, vector};
  end
  endfunction


  function automatic [15:0] conv_s2s_15_16 ;
    input [14:0]  vector ;
  begin
    conv_s2s_15_16 = {vector[14], vector};
  end
  endfunction


  function automatic [11:0] conv_s2u_4_12 ;
    input [3:0]  vector ;
  begin
    conv_s2u_4_12 = {{8{vector[3]}}, vector};
  end
  endfunction


  function automatic [2:0] conv_u2s_2_3 ;
    input [1:0]  vector ;
  begin
    conv_u2s_2_3 =  {1'b0, vector};
  end
  endfunction


  function automatic [5:0] conv_u2s_5_6 ;
    input [4:0]  vector ;
  begin
    conv_u2s_5_6 =  {1'b0, vector};
  end
  endfunction


  function automatic [2:0] conv_u2u_1_3 ;
    input [0:0]  vector ;
  begin
    conv_u2u_1_3 = {{2{1'b0}}, vector};
  end
  endfunction


  function automatic [2:0] conv_u2u_2_3 ;
    input [1:0]  vector ;
  begin
    conv_u2u_2_3 = {1'b0, vector};
  end
  endfunction


  function automatic [7:0] conv_u2u_7_8 ;
    input [6:0]  vector ;
  begin
    conv_u2u_7_8 = {1'b0, vector};
  end
  endfunction


  function automatic [9:0] conv_u2u_7_10 ;
    input [6:0]  vector ;
  begin
    conv_u2u_7_10 = {{3{1'b0}}, vector};
  end
  endfunction


  function automatic [8:0] conv_u2u_8_9 ;
    input [7:0]  vector ;
  begin
    conv_u2u_8_9 = {1'b0, vector};
  end
  endfunction


  function automatic [12:0] conv_u2u_9_13 ;
    input [8:0]  vector ;
  begin
    conv_u2u_9_13 = {{4{1'b0}}, vector};
  end
  endfunction


  function automatic [12:0] conv_u2u_12_13 ;
    input [11:0]  vector ;
  begin
    conv_u2u_12_13 = {1'b0, vector};
  end
  endfunction


  function automatic [13:0] conv_u2u_13_14 ;
    input [12:0]  vector ;
  begin
    conv_u2u_13_14 = {1'b0, vector};
  end
  endfunction


  function automatic [14:0] conv_u2u_13_15 ;
    input [12:0]  vector ;
  begin
    conv_u2u_13_15 = {{2{1'b0}}, vector};
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    UNET_IP_batchnorm_relu
// ------------------------------------------------------------------


module UNET_IP_batchnorm_relu (
  clk, rst, arst_n, input_rsc_radr, input_rsc_re, input_rsc_q, input_rsc_clken, input_triosy_lz,
      output_rsc_wadr, output_rsc_d, output_rsc_we, output_rsc_clken, output_triosy_lz,
      channels, height, width, offset
);
  input clk;
  input rst;
  input arst_n;
  output [14:0] input_rsc_radr;
  output input_rsc_re;
  input [11:0] input_rsc_q;
  output input_rsc_clken;
  output input_triosy_lz;
  output [14:0] output_rsc_wadr;
  output [11:0] output_rsc_d;
  output output_rsc_we;
  output output_rsc_clken;
  output output_triosy_lz;
  input [6:0] channels;
  input [6:0] height;
  input [6:0] width;
  input [9:0] offset;


  // Interconnect Declarations
  wire [11:0] input_rsci_q_d;
  wire [14:0] input_rsci_radr_d;
  wire [11:0] output_rsci_d_d;
  wire [14:0] output_rsci_wadr_d;
  wire [33:0] operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a;
  wire [12:0] operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_b;
  wire [33:0] operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z;
  wire input_rsci_re_d_iff;
  wire output_rsci_we_d_iff;


  // Interconnect Declarations for Component Instantiations 
  mgc_div #(.width_a(32'sd34),
  .width_b(32'sd13),
  .signd(32'sd0)) operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp (
      .a(operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a),
      .b(operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_b),
      .z(operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z)
    );
  UNET_IP_batchnorm_relu_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_en_1_15_12_32768_1_32768_12_1_gen
      input_rsci (
      .clken(input_rsc_clken),
      .q(input_rsc_q),
      .re(input_rsc_re),
      .radr(input_rsc_radr),
      .clken_d(1'b1),
      .q_d(input_rsci_q_d),
      .radr_d(input_rsci_radr_d),
      .re_d(input_rsci_re_d_iff),
      .readA_r_ram_ir_internal_RMASK_B_d(input_rsci_re_d_iff)
    );
  UNET_IP_batchnorm_relu_Xilinx_RAMS_BLOCK_1R1W_RBW_wport_en_2_15_12_32768_1_32768_12_1_gen
      output_rsci (
      .clken(output_rsc_clken),
      .we(output_rsc_we),
      .d(output_rsc_d),
      .wadr(output_rsc_wadr),
      .clken_d(1'b1),
      .d_d(output_rsci_d_d),
      .wadr_d(output_rsci_wadr_d),
      .we_d(output_rsci_we_d_iff),
      .writeA_w_ram_ir_internal_WMASK_B_d(output_rsci_we_d_iff)
    );
  UNET_IP_batchnorm_relu_run_batch UNET_IP_batchnorm_relu_run_batch_inst (
      .clk(clk),
      .rst(rst),
      .arst_n(arst_n),
      .input_triosy_lz(input_triosy_lz),
      .output_triosy_lz(output_triosy_lz),
      .channels(channels),
      .height(height),
      .width(width),
      .offset(offset),
      .input_rsci_q_d(input_rsci_q_d),
      .input_rsci_radr_d(input_rsci_radr_d),
      .output_rsci_d_d(output_rsci_d_d),
      .output_rsci_wadr_d(output_rsci_wadr_d),
      .operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a(operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_a),
      .operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_b(operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_b),
      .operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z(operator_20_8_false_AC_TRN_AC_WRAP_13_false_div_cmp_z),
      .input_rsci_re_d_pff(input_rsci_re_d_iff),
      .output_rsci_we_d_pff(output_rsci_we_d_iff)
    );
endmodule



