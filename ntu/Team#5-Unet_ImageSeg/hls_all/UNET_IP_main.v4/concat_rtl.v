
//------> /home/raid7_4/raid1_1/linux/mentor/Catapult/2023.2/Mgc_home/pkgs/siflibs/ccs_in_wait_v1.v 
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


//------> /home/raid7_4/raid1_1/linux/mentor/Catapult/2023.2/Mgc_home/pkgs/siflibs/ccs_out_wait_v1.v 
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

//------> ../td_ccore_solutions/leading_sign_22_0_d840c0cc3faff3dab9b8e63cb3d67e055661_0/rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    2023.2/1059873 Production Release
//  HLS Date:       Mon Aug  7 10:54:31 PDT 2023
// 
//  Generated by:   r12016@cad40
//  Generated date: Sat Jun 15 02:19:26 2024
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
  wire ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_42_4_sdt_4;
  wire ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_50_2_sdt_2;
  wire ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_50_2_sdt_1;
  wire c_h_1_8;
  wire ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_and_83_ssc;

  wire ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_or_1_nl;
  wire ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_or_2_nl;
  wire ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leadi000000;

  // Interconnect Declarations for Component Instantiations 
  assign ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_42_4_sdt_4
      = ~((mantissa[8:6]!=3'b000));
  assign ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_50_2_sdt_2
      = ~((mantissa[3:2]!=2'b00));
  assign ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_50_2_sdt_1
      = ~((mantissa[5:4]!=2'b00));
  assign c_h_1_8 = ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_50_2_sdt_1
      & ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_50_2_sdt_2;
  assign ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_and_83_ssc
      = (mantissa[1:0]==2'b00) & c_h_1_8 & ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_42_4_sdt_4;
  assign ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_or_1_nl
      = c_h_1_8 | (~ ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_42_4_sdt_4);
  assign ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_or_2_nl
      = (~((mantissa[8]) | ((~(ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_50_2_sdt_1
      & (~ ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_50_2_sdt_2)))
      & ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_42_4_sdt_4)))
      | ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_and_83_ssc;
  assign ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leadi000000
      = ~((~((mantissa[8:7]!=2'b01))) | ((~((~((mantissa[5]) | (~((mantissa[4:3]!=2'b01)))))
      & (~((mantissa[1]) & c_h_1_8)))) & ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_42_4_sdt_4)
      | ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_and_83_ssc);
  assign rtn = {ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_42_4_sdt_4
      , (~ ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_wrs_c_42_4_sdt_4)
      , ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_or_1_nl
      , ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_or_2_nl
      , ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leading_sign_22_0_rtn_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_leading_1_leadi000000};
endmodule




//------> /home/raid7_4/raid1_1/linux/mentor/Catapult/2023.2/Mgc_home/pkgs/ccs_xilinx/hdl/BLOCK_1R1W_RBW.v 
// Memory Type:            BLOCK
// Operating Mode:         Simple Dual Port (2-Port)
// Clock Mode:             Single Clock
// 
// RTL Code RW Resolution: RBW
// Catapult RW Resolution: RBW
// 
// HDL Work Library:       Xilinx_RAMS_lib
// Component Name:         BLOCK_1R1W_RBW
// Latency = 1:            RAM with no registers on inputs or outputs
//         = 2:            adds embedded register on RAM output
//         = 3:            adds fabric registers to non-clock input RAM pins
//         = 4:            adds fabric register to output (driven by embedded register from latency=2)
// suppress_sim_read_addr_range_errs:  0 - report errors  1 - suppress errors

module BLOCK_1R1W_RBW #(
  parameter addr_width = 8 ,
  parameter data_width = 7 ,
  parameter depth = 256 ,
  parameter latency = 1 ,
  parameter suppress_sim_read_addr_range_errs = 1 
  
)( clk,clken,d,q,radr,re,wadr,we);

  input  clk;
  input  clken;
  input [data_width-1:0] d;
  output [data_width-1:0] q;
  input [addr_width-1:0] radr;
  input  re;
  input [addr_width-1:0] wadr;
  input  we;
  
  (* ram_style = "block" , syn_ramstyle = "block" *)
  reg [data_width-1:0] mem [depth-1:0];
  integer j;
  initial for (j = 0; j < depth; j = j + 1) mem[j] = 0;
  
  reg [data_width-1:0] ramq;
  
  // Port Map
  // readA :: CLOCK clk ENABLE clken DATA_OUT q ADDRESS radr READ_ENABLE re
  // writeA :: CLOCK clk ENABLE clken DATA_IN d ADDRESS wadr WRITE_ENABLE we

  generate
    // Register all non-clock inputs (latency < 3)
    if (latency > 2 ) begin
      reg [addr_width-1:0] radr_reg;
      reg re_reg;
      reg [data_width-1:0] d_reg;
      reg [addr_width-1:0] wadr_reg;
      reg we_reg;
      
      always @(posedge clk) begin
        if (clken) begin
          radr_reg <= radr;
          re_reg <= re;
        end
      end
      always @(posedge clk) begin
        if (clken) begin
          d_reg <= d;
          wadr_reg <= wadr;
          we_reg <= we;
        end
      end
      
    // Access memory with registered inputs
      always @(posedge clk) begin
        if (clken) begin
            ramq <= mem[radr_reg];
            if (we_reg) begin
              mem[wadr_reg] <= d_reg;
            end
        end
      end
      
    end // END register inputs

    else begin
    // latency = 1||2: Access memory with non-registered inputs
      always @(posedge clk) begin
        if (clken) begin
            ramq <= mem[radr];
            if (we) begin
              mem[wadr] <= d;
            end
        end
      end
      
    end
  endgenerate //END input port generate 

  generate
    // latency=1: sequential RAM outputs drive module outputs
    if (latency == 1) begin
      assign q = ramq;
      
    end

    else if (latency == 2 || latency == 3) begin
    // latency=2: sequential (RAM output => tmp register => module output)
      reg [data_width-1:0] tmpq;
      
      always @(posedge clk) begin
        if (clken) begin
          tmpq <= ramq;
        end
      end
      
      assign q = tmpq;
      
    end
    else if (latency == 4) begin
    // latency=4: (RAM => tmp1 register => tmp2 fabric register => module output)
      reg [data_width-1:0] tmp1q;
      
      reg [data_width-1:0] tmp2q;
      
      always @(posedge clk) begin
        if (clken) begin
          tmp1q <= ramq;
        end
      end
      
      always @(posedge clk) begin
        if (clken) begin
          tmp2q <= tmp1q;
        end
      end
      
      assign q = tmp2q;
      
    end
    else begin
      //Add error check if latency > 4 or add N-pipeline regs
    end
  endgenerate //END output port generate

endmodule

//------> ./rtl_UNET_IP_mainmgc_rom_17_792_5_1.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    2023.2/1059873 Production Release
//  HLS Date:       Mon Aug  7 10:54:31 PDT 2023
// 
//  Generated by:   r12016@cad40
//  Generated date: Sat Jun 15 02:24:36 2024
// ----------------------------------------------------------------------

// 
module UNET_IP_mainmgc_rom_17_792_5_1 (addr, data_out
);
  input [9:0]addr ;
  output [4:0]data_out ;


  // Constants for ROM dimensions
  parameter n_width    = 5;
  parameter n_size     = 792;
  parameter n_numports = 1;
  parameter n_addr_w   = 10;
  parameter n_inreg    = 0;
  parameter n_outreg   = 0;

  // Declare storage for memory elements
  reg [4:0] mem [791:0];

  // Declare output registers
  reg [4:0] data_out_t;

  // Initialize ROM contents
  initial begin: rom_init_blk
    mem[0] <= 5'b00100;
    mem[1] <= 5'b01000;
    mem[2] <= 5'b11111;
    mem[3] <= 5'b11001;
    mem[4] <= 5'b10101;
    mem[5] <= 5'b11001;
    mem[6] <= 5'b01001;
    mem[7] <= 5'b00110;
    mem[8] <= 5'b00111;
    mem[9] <= 5'b00010;
    mem[10] <= 5'b00001;
    mem[11] <= 5'b00001;
    mem[12] <= 5'b11011;
    mem[13] <= 5'b11100;
    mem[14] <= 5'b01011;
    mem[15] <= 5'b00011;
    mem[16] <= 5'b11011;
    mem[17] <= 5'b00110;
    mem[18] <= 5'b00000;
    mem[19] <= 5'b00001;
    mem[20] <= 5'b10111;
    mem[21] <= 5'b11111;
    mem[22] <= 5'b11110;
    mem[23] <= 5'b10111;
    mem[24] <= 5'b11110;
    mem[25] <= 5'b11000;
    mem[26] <= 5'b11011;
    mem[27] <= 5'b01100;
    mem[28] <= 5'b00110;
    mem[29] <= 5'b00111;
    mem[30] <= 5'b11000;
    mem[31] <= 5'b11001;
    mem[32] <= 5'b10111;
    mem[33] <= 5'b11100;
    mem[34] <= 5'b01001;
    mem[35] <= 5'b00100;
    mem[36] <= 5'b11101;
    mem[37] <= 5'b11010;
    mem[38] <= 5'b11011;
    mem[39] <= 5'b01011;
    mem[40] <= 5'b01000;
    mem[41] <= 5'b00001;
    mem[42] <= 5'b10110;
    mem[43] <= 5'b01011;
    mem[44] <= 5'b11101;
    mem[45] <= 5'b01001;
    mem[46] <= 5'b00010;
    mem[47] <= 5'b11101;
    mem[48] <= 5'b11001;
    mem[49] <= 5'b11110;
    mem[50] <= 5'b00001;
    mem[51] <= 5'b10111;
    mem[52] <= 5'b10111;
    mem[53] <= 5'b01011;
    mem[54] <= 5'b01001;
    mem[55] <= 5'b00010;
    mem[56] <= 5'b00100;
    mem[57] <= 5'b11111;
    mem[58] <= 5'b11101;
    mem[59] <= 5'b11111;
    mem[60] <= 5'b00000;
    mem[61] <= 5'b11010;
    mem[62] <= 5'b01010;
    mem[63] <= 5'b11011;
    mem[64] <= 5'b00110;
    mem[65] <= 5'b00110;
    mem[66] <= 5'b00110;
    mem[67] <= 5'b11111;
    mem[68] <= 5'b01001;
    mem[69] <= 5'b01011;
    mem[70] <= 5'b10110;
    mem[71] <= 5'b01000;
    mem[72] <= 5'b10101;
    mem[73] <= 5'b01011;
    mem[74] <= 5'b11110;
    mem[75] <= 5'b11011;
    mem[76] <= 5'b00110;
    mem[77] <= 5'b10100;
    mem[78] <= 5'b11001;
    mem[79] <= 5'b10100;
    mem[80] <= 5'b10100;
    mem[81] <= 5'b11011;
    mem[82] <= 5'b11001;
    mem[83] <= 5'b00000;
    mem[84] <= 5'b00101;
    mem[85] <= 5'b11011;
    mem[86] <= 5'b11111;
    mem[87] <= 5'b10111;
    mem[88] <= 5'b01000;
    mem[89] <= 5'b10111;
    mem[90] <= 5'b11001;
    mem[91] <= 5'b00111;
    mem[92] <= 5'b11010;
    mem[93] <= 5'b10101;
    mem[94] <= 5'b10101;
    mem[95] <= 5'b11001;
    mem[96] <= 5'b11001;
    mem[97] <= 5'b10111;
    mem[98] <= 5'b01000;
    mem[99] <= 5'b00100;
    mem[100] <= 5'b10100;
    mem[101] <= 5'b01010;
    mem[102] <= 5'b11001;
    mem[103] <= 5'b00011;
    mem[104] <= 5'b00111;
    mem[105] <= 5'b01011;
    mem[106] <= 5'b11110;
    mem[107] <= 5'b11100;
    mem[108] <= 5'b10100;
    mem[109] <= 5'b01001;
    mem[110] <= 5'b00001;
    mem[111] <= 5'b01000;
    mem[112] <= 5'b11011;
    mem[113] <= 5'b11111;
    mem[114] <= 5'b00111;
    mem[115] <= 5'b00111;
    mem[116] <= 5'b00100;
    mem[117] <= 5'b01000;
    mem[118] <= 5'b00100;
    mem[119] <= 5'b01000;
    mem[120] <= 5'b01100;
    mem[121] <= 5'b11000;
    mem[122] <= 5'b01100;
    mem[123] <= 5'b00001;
    mem[124] <= 5'b00000;
    mem[125] <= 5'b01011;
    mem[126] <= 5'b00000;
    mem[127] <= 5'b10100;
    mem[128] <= 5'b11100;
    mem[129] <= 5'b01010;
    mem[130] <= 5'b01011;
    mem[131] <= 5'b11011;
    mem[132] <= 5'b10011;
    mem[133] <= 5'b00010;
    mem[134] <= 5'b10110;
    mem[135] <= 5'b00110;
    mem[136] <= 5'b11101;
    mem[137] <= 5'b01000;
    mem[138] <= 5'b11111;
    mem[139] <= 5'b00110;
    mem[140] <= 5'b00000;
    mem[141] <= 5'b01011;
    mem[142] <= 5'b00111;
    mem[143] <= 5'b01100;
    mem[144] <= 5'b01000;
    mem[145] <= 5'b00000;
    mem[146] <= 5'b11111;
    mem[147] <= 5'b11110;
    mem[148] <= 5'b00100;
    mem[149] <= 5'b11011;
    mem[150] <= 5'b00101;
    mem[151] <= 5'b00101;
    mem[152] <= 5'b01010;
    mem[153] <= 5'b01000;
    mem[154] <= 5'b01001;
    mem[155] <= 5'b11100;
    mem[156] <= 5'b01010;
    mem[157] <= 5'b10100;
    mem[158] <= 5'b11110;
    mem[159] <= 5'b10100;
    mem[160] <= 5'b11110;
    mem[161] <= 5'b11110;
    mem[162] <= 5'b11110;
    mem[163] <= 5'b10110;
    mem[164] <= 5'b00011;
    mem[165] <= 5'b00100;
    mem[166] <= 5'b10100;
    mem[167] <= 5'b01000;
    mem[168] <= 5'b11100;
    mem[169] <= 5'b11011;
    mem[170] <= 5'b10110;
    mem[171] <= 5'b00101;
    mem[172] <= 5'b01000;
    mem[173] <= 5'b00011;
    mem[174] <= 5'b11011;
    mem[175] <= 5'b10111;
    mem[176] <= 5'b10111;
    mem[177] <= 5'b11100;
    mem[178] <= 5'b00100;
    mem[179] <= 5'b00111;
    mem[180] <= 5'b01000;
    mem[181] <= 5'b00001;
    mem[182] <= 5'b11100;
    mem[183] <= 5'b01011;
    mem[184] <= 5'b10110;
    mem[185] <= 5'b01001;
    mem[186] <= 5'b00101;
    mem[187] <= 5'b01001;
    mem[188] <= 5'b10100;
    mem[189] <= 5'b00010;
    mem[190] <= 5'b11001;
    mem[191] <= 5'b01011;
    mem[192] <= 5'b10101;
    mem[193] <= 5'b11011;
    mem[194] <= 5'b11010;
    mem[195] <= 5'b10101;
    mem[196] <= 5'b10111;
    mem[197] <= 5'b11001;
    mem[198] <= 5'b10111;
    mem[199] <= 5'b00110;
    mem[200] <= 5'b00001;
    mem[201] <= 5'b11101;
    mem[202] <= 5'b00010;
    mem[203] <= 5'b11000;
    mem[204] <= 5'b01011;
    mem[205] <= 5'b11011;
    mem[206] <= 5'b00011;
    mem[207] <= 5'b00100;
    mem[208] <= 5'b00011;
    mem[209] <= 5'b00001;
    mem[210] <= 5'b00010;
    mem[211] <= 5'b11100;
    mem[212] <= 5'b00010;
    mem[213] <= 5'b01000;
    mem[214] <= 5'b01001;
    mem[215] <= 5'b01011;
    mem[216] <= 5'b00001;
    mem[217] <= 5'b11000;
    mem[218] <= 5'b00011;
    mem[219] <= 5'b00111;
    mem[220] <= 5'b11101;
    mem[221] <= 5'b11001;
    mem[222] <= 5'b11100;
    mem[223] <= 5'b00101;
    mem[224] <= 5'b11110;
    mem[225] <= 5'b11010;
    mem[226] <= 5'b00100;
    mem[227] <= 5'b00011;
    mem[228] <= 5'b00001;
    mem[229] <= 5'b11001;
    mem[230] <= 5'b11010;
    mem[231] <= 5'b11110;
    mem[232] <= 5'b11011;
    mem[233] <= 5'b11011;
    mem[234] <= 5'b00100;
    mem[235] <= 5'b00011;
    mem[236] <= 5'b11111;
    mem[237] <= 5'b11111;
    mem[238] <= 5'b00001;
    mem[239] <= 5'b11011;
    mem[240] <= 5'b11000;
    mem[241] <= 5'b00001;
    mem[242] <= 5'b00000;
    mem[243] <= 5'b00001;
    mem[244] <= 5'b00010;
    mem[245] <= 5'b11111;
    mem[246] <= 5'b11011;
    mem[247] <= 5'b11001;
    mem[248] <= 5'b11101;
    mem[249] <= 5'b11100;
    mem[250] <= 5'b00100;
    mem[251] <= 5'b00000;
    mem[252] <= 5'b11100;
    mem[253] <= 5'b00100;
    mem[254] <= 5'b11001;
    mem[255] <= 5'b00101;
    mem[256] <= 5'b00001;
    mem[257] <= 5'b11000;
    mem[258] <= 5'b11001;
    mem[259] <= 5'b11110;
    mem[260] <= 5'b00000;
    mem[261] <= 5'b11011;
    mem[262] <= 5'b11100;
    mem[263] <= 5'b11000;
    mem[264] <= 5'b00010;
    mem[265] <= 5'b11011;
    mem[266] <= 5'b11110;
    mem[267] <= 5'b11111;
    mem[268] <= 5'b00011;
    mem[269] <= 5'b00010;
    mem[270] <= 5'b00000;
    mem[271] <= 5'b00011;
    mem[272] <= 5'b11101;
    mem[273] <= 5'b11001;
    mem[274] <= 5'b11111;
    mem[275] <= 5'b00101;
    mem[276] <= 5'b00100;
    mem[277] <= 5'b11001;
    mem[278] <= 5'b11000;
    mem[279] <= 5'b00101;
    mem[280] <= 5'b11101;
    mem[281] <= 5'b11100;
    mem[282] <= 5'b11001;
    mem[283] <= 5'b11011;
    mem[284] <= 5'b11110;
    mem[285] <= 5'b00001;
    mem[286] <= 5'b11110;
    mem[287] <= 5'b00010;
    mem[288] <= 5'b11011;
    mem[289] <= 5'b00001;
    mem[290] <= 5'b00010;
    mem[291] <= 5'b11110;
    mem[292] <= 5'b11100;
    mem[293] <= 5'b11110;
    mem[294] <= 5'b11010;
    mem[295] <= 5'b00000;
    mem[296] <= 5'b00010;
    mem[297] <= 5'b11011;
    mem[298] <= 5'b11100;
    mem[299] <= 5'b00000;
    mem[300] <= 5'b11110;
    mem[301] <= 5'b00101;
    mem[302] <= 5'b11110;
    mem[303] <= 5'b11101;
    mem[304] <= 5'b00001;
    mem[305] <= 5'b11100;
    mem[306] <= 5'b11100;
    mem[307] <= 5'b11101;
    mem[308] <= 5'b11101;
    mem[309] <= 5'b00001;
    mem[310] <= 5'b11011;
    mem[311] <= 5'b00011;
    mem[312] <= 5'b11011;
    mem[313] <= 5'b11100;
    mem[314] <= 5'b00010;
    mem[315] <= 5'b11010;
    mem[316] <= 5'b00110;
    mem[317] <= 5'b11101;
    mem[318] <= 5'b00001;
    mem[319] <= 5'b00110;
    mem[320] <= 5'b00010;
    mem[321] <= 5'b11101;
    mem[322] <= 5'b11100;
    mem[323] <= 5'b00100;
    mem[324] <= 5'b11000;
    mem[325] <= 5'b11001;
    mem[326] <= 5'b11111;
    mem[327] <= 5'b11001;
    mem[328] <= 5'b11000;
    mem[329] <= 5'b00001;
    mem[330] <= 5'b00000;
    mem[331] <= 5'b00001;
    mem[332] <= 5'b00101;
    mem[333] <= 5'b11100;
    mem[334] <= 5'b11010;
    mem[335] <= 5'b11110;
    mem[336] <= 5'b00010;
    mem[337] <= 5'b11011;
    mem[338] <= 5'b00010;
    mem[339] <= 5'b11000;
    mem[340] <= 5'b00010;
    mem[341] <= 5'b11000;
    mem[342] <= 5'b00011;
    mem[343] <= 5'b11100;
    mem[344] <= 5'b11111;
    mem[345] <= 5'b00101;
    mem[346] <= 5'b00011;
    mem[347] <= 5'b11010;
    mem[348] <= 5'b00100;
    mem[349] <= 5'b00010;
    mem[350] <= 5'b00010;
    mem[351] <= 5'b00100;
    mem[352] <= 5'b11101;
    mem[353] <= 5'b11111;
    mem[354] <= 5'b11101;
    mem[355] <= 5'b00110;
    mem[356] <= 5'b00101;
    mem[357] <= 5'b11111;
    mem[358] <= 5'b00000;
    mem[359] <= 5'b00100;
    mem[360] <= 5'b00111;
    mem[361] <= 5'b00100;
    mem[362] <= 5'b11110;
    mem[363] <= 5'b11010;
    mem[364] <= 5'b11010;
    mem[365] <= 5'b11100;
    mem[366] <= 5'b00100;
    mem[367] <= 5'b00101;
    mem[368] <= 5'b11110;
    mem[369] <= 5'b11011;
    mem[370] <= 5'b00011;
    mem[371] <= 5'b11100;
    mem[372] <= 5'b00001;
    mem[373] <= 5'b00010;
    mem[374] <= 5'b00001;
    mem[375] <= 5'b11000;
    mem[376] <= 5'b11000;
    mem[377] <= 5'b00110;
    mem[378] <= 5'b11011;
    mem[379] <= 5'b11100;
    mem[380] <= 5'b00110;
    mem[381] <= 5'b11000;
    mem[382] <= 5'b00011;
    mem[383] <= 5'b11011;
    mem[384] <= 5'b00011;
    mem[385] <= 5'b11110;
    mem[386] <= 5'b11100;
    mem[387] <= 5'b11001;
    mem[388] <= 5'b11011;
    mem[389] <= 5'b00110;
    mem[390] <= 5'b11010;
    mem[391] <= 5'b11111;
    mem[392] <= 5'b11010;
    mem[393] <= 5'b00011;
    mem[394] <= 5'b00100;
    mem[395] <= 5'b00100;
    mem[396] <= 5'b11100;
    mem[397] <= 5'b00101;
    mem[398] <= 5'b10111;
    mem[399] <= 5'b00010;
    mem[400] <= 5'b11001;
    mem[401] <= 5'b00110;
    mem[402] <= 5'b11110;
    mem[403] <= 5'b11000;
    mem[404] <= 5'b11101;
    mem[405] <= 5'b11100;
    mem[406] <= 5'b11001;
    mem[407] <= 5'b11011;
    mem[408] <= 5'b00011;
    mem[409] <= 5'b00000;
    mem[410] <= 5'b00110;
    mem[411] <= 5'b11001;
    mem[412] <= 5'b00100;
    mem[413] <= 5'b11010;
    mem[414] <= 5'b11110;
    mem[415] <= 5'b00011;
    mem[416] <= 5'b00010;
    mem[417] <= 5'b00110;
    mem[418] <= 5'b00100;
    mem[419] <= 5'b11111;
    mem[420] <= 5'b00011;
    mem[421] <= 5'b11010;
    mem[422] <= 5'b00111;
    mem[423] <= 5'b00010;
    mem[424] <= 5'b00010;
    mem[425] <= 5'b11001;
    mem[426] <= 5'b00100;
    mem[427] <= 5'b11110;
    mem[428] <= 5'b00000;
    mem[429] <= 5'b11100;
    mem[430] <= 5'b11101;
    mem[431] <= 5'b00111;
    mem[432] <= 5'b00001;
    mem[433] <= 5'b11100;
    mem[434] <= 5'b11110;
    mem[435] <= 5'b11000;
    mem[436] <= 5'b00101;
    mem[437] <= 5'b11100;
    mem[438] <= 5'b11101;
    mem[439] <= 5'b00110;
    mem[440] <= 5'b11000;
    mem[441] <= 5'b11100;
    mem[442] <= 5'b00011;
    mem[443] <= 5'b00010;
    mem[444] <= 5'b11000;
    mem[445] <= 5'b11100;
    mem[446] <= 5'b00001;
    mem[447] <= 5'b11010;
    mem[448] <= 5'b00100;
    mem[449] <= 5'b00100;
    mem[450] <= 5'b11000;
    mem[451] <= 5'b11010;
    mem[452] <= 5'b11101;
    mem[453] <= 5'b11010;
    mem[454] <= 5'b10111;
    mem[455] <= 5'b00010;
    mem[456] <= 5'b11000;
    mem[457] <= 5'b11100;
    mem[458] <= 5'b11100;
    mem[459] <= 5'b00010;
    mem[460] <= 5'b00010;
    mem[461] <= 5'b11000;
    mem[462] <= 5'b00101;
    mem[463] <= 5'b00000;
    mem[464] <= 5'b00010;
    mem[465] <= 5'b11111;
    mem[466] <= 5'b11101;
    mem[467] <= 5'b11010;
    mem[468] <= 5'b11010;
    mem[469] <= 5'b00001;
    mem[470] <= 5'b00110;
    mem[471] <= 5'b11111;
    mem[472] <= 5'b00101;
    mem[473] <= 5'b00111;
    mem[474] <= 5'b11010;
    mem[475] <= 5'b11001;
    mem[476] <= 5'b00011;
    mem[477] <= 5'b00010;
    mem[478] <= 5'b11101;
    mem[479] <= 5'b00110;
    mem[480] <= 5'b00110;
    mem[481] <= 5'b11111;
    mem[482] <= 5'b11110;
    mem[483] <= 5'b11101;
    mem[484] <= 5'b00010;
    mem[485] <= 5'b11001;
    mem[486] <= 5'b11100;
    mem[487] <= 5'b00110;
    mem[488] <= 5'b11010;
    mem[489] <= 5'b00111;
    mem[490] <= 5'b11101;
    mem[491] <= 5'b11100;
    mem[492] <= 5'b00101;
    mem[493] <= 5'b11110;
    mem[494] <= 5'b00001;
    mem[495] <= 5'b11011;
    mem[496] <= 5'b00010;
    mem[497] <= 5'b00010;
    mem[498] <= 5'b11010;
    mem[499] <= 5'b00101;
    mem[500] <= 5'b11101;
    mem[501] <= 5'b00110;
    mem[502] <= 5'b11000;
    mem[503] <= 5'b00101;
    mem[504] <= 5'b11100;
    mem[505] <= 5'b01000;
    mem[506] <= 5'b11101;
    mem[507] <= 5'b00010;
    mem[508] <= 5'b00010;
    mem[509] <= 5'b00110;
    mem[510] <= 5'b00110;
    mem[511] <= 5'b11110;
    mem[512] <= 5'b01000;
    mem[513] <= 5'b11001;
    mem[514] <= 5'b11100;
    mem[515] <= 5'b00001;
    mem[516] <= 5'b00101;
    mem[517] <= 5'b00101;
    mem[518] <= 5'b00011;
    mem[519] <= 5'b11100;
    mem[520] <= 5'b11011;
    mem[521] <= 5'b11011;
    mem[522] <= 5'b00111;
    mem[523] <= 5'b11001;
    mem[524] <= 5'b00000;
    mem[525] <= 5'b00100;
    mem[526] <= 5'b11101;
    mem[527] <= 5'b00101;
    mem[528] <= 5'b00000;
    mem[529] <= 5'b00110;
    mem[530] <= 5'b00001;
    mem[531] <= 5'b00000;
    mem[532] <= 5'b00100;
    mem[533] <= 5'b11001;
    mem[534] <= 5'b00010;
    mem[535] <= 5'b11100;
    mem[536] <= 5'b00110;
    mem[537] <= 5'b00110;
    mem[538] <= 5'b11100;
    mem[539] <= 5'b00100;
    mem[540] <= 5'b00001;
    mem[541] <= 5'b00000;
    mem[542] <= 5'b00011;
    mem[543] <= 5'b00010;
    mem[544] <= 5'b11111;
    mem[545] <= 5'b00110;
    mem[546] <= 5'b00001;
    mem[547] <= 5'b00000;
    mem[548] <= 5'b00101;
    mem[549] <= 5'b11111;
    mem[550] <= 5'b11110;
    mem[551] <= 5'b00010;
    mem[552] <= 5'b10111;
    mem[553] <= 5'b11100;
    mem[554] <= 5'b00000;
    mem[555] <= 5'b11011;
    mem[556] <= 5'b00011;
    mem[557] <= 5'b11000;
    mem[558] <= 5'b00001;
    mem[559] <= 5'b11010;
    mem[560] <= 5'b00011;
    mem[561] <= 5'b11101;
    mem[562] <= 5'b11111;
    mem[563] <= 5'b00110;
    mem[564] <= 5'b11100;
    mem[565] <= 5'b11100;
    mem[566] <= 5'b11101;
    mem[567] <= 5'b11101;
    mem[568] <= 5'b00101;
    mem[569] <= 5'b11001;
    mem[570] <= 5'b11010;
    mem[571] <= 5'b00000;
    mem[572] <= 5'b00011;
    mem[573] <= 5'b11101;
    mem[574] <= 5'b00011;
    mem[575] <= 5'b11111;
    mem[576] <= 5'b00000;
    mem[577] <= 5'b00101;
    mem[578] <= 5'b11111;
    mem[579] <= 5'b00011;
    mem[580] <= 5'b00000;
    mem[581] <= 5'b00101;
    mem[582] <= 5'b11001;
    mem[583] <= 5'b11110;
    mem[584] <= 5'b00001;
    mem[585] <= 5'b11100;
    mem[586] <= 5'b11101;
    mem[587] <= 5'b11000;
    mem[588] <= 5'b11111;
    mem[589] <= 5'b11111;
    mem[590] <= 5'b11011;
    mem[591] <= 5'b00110;
    mem[592] <= 5'b00110;
    mem[593] <= 5'b00111;
    mem[594] <= 5'b11011;
    mem[595] <= 5'b11000;
    mem[596] <= 5'b11110;
    mem[597] <= 5'b11111;
    mem[598] <= 5'b00000;
    mem[599] <= 5'b11111;
    mem[600] <= 5'b00100;
    mem[601] <= 5'b11011;
    mem[602] <= 5'b11010;
    mem[603] <= 5'b11010;
    mem[604] <= 5'b11111;
    mem[605] <= 5'b00001;
    mem[606] <= 5'b11100;
    mem[607] <= 5'b00110;
    mem[608] <= 5'b11101;
    mem[609] <= 5'b00000;
    mem[610] <= 5'b11010;
    mem[611] <= 5'b11100;
    mem[612] <= 5'b00000;
    mem[613] <= 5'b00011;
    mem[614] <= 5'b11001;
    mem[615] <= 5'b11010;
    mem[616] <= 5'b11011;
    mem[617] <= 5'b00111;
    mem[618] <= 5'b00010;
    mem[619] <= 5'b11010;
    mem[620] <= 5'b11101;
    mem[621] <= 5'b00110;
    mem[622] <= 5'b00101;
    mem[623] <= 5'b00100;
    mem[624] <= 5'b11101;
    mem[625] <= 5'b00010;
    mem[626] <= 5'b11010;
    mem[627] <= 5'b11110;
    mem[628] <= 5'b11101;
    mem[629] <= 5'b11010;
    mem[630] <= 5'b11101;
    mem[631] <= 5'b00000;
    mem[632] <= 5'b00000;
    mem[633] <= 5'b11111;
    mem[634] <= 5'b00000;
    mem[635] <= 5'b11010;
    mem[636] <= 5'b11101;
    mem[637] <= 5'b11110;
    mem[638] <= 5'b11001;
    mem[639] <= 5'b00000;
    mem[640] <= 5'b00001;
    mem[641] <= 5'b00001;
    mem[642] <= 5'b11000;
    mem[643] <= 5'b11001;
    mem[644] <= 5'b11100;
    mem[645] <= 5'b11010;
    mem[646] <= 5'b11000;
    mem[647] <= 5'b11010;
    mem[648] <= 5'b00010;
    mem[649] <= 5'b11110;
    mem[650] <= 5'b11110;
    mem[651] <= 5'b00000;
    mem[652] <= 5'b00010;
    mem[653] <= 5'b00110;
    mem[654] <= 5'b00101;
    mem[655] <= 5'b11001;
    mem[656] <= 5'b00100;
    mem[657] <= 5'b00001;
    mem[658] <= 5'b00101;
    mem[659] <= 5'b00010;
    mem[660] <= 5'b00001;
    mem[661] <= 5'b00001;
    mem[662] <= 5'b11111;
    mem[663] <= 5'b11111;
    mem[664] <= 5'b00100;
    mem[665] <= 5'b00011;
    mem[666] <= 5'b11010;
    mem[667] <= 5'b11111;
    mem[668] <= 5'b11001;
    mem[669] <= 5'b00011;
    mem[670] <= 5'b00010;
    mem[671] <= 5'b00110;
    mem[672] <= 5'b11110;
    mem[673] <= 5'b00011;
    mem[674] <= 5'b11011;
    mem[675] <= 5'b11100;
    mem[676] <= 5'b00010;
    mem[677] <= 5'b00110;
    mem[678] <= 5'b11011;
    mem[679] <= 5'b11001;
    mem[680] <= 5'b11100;
    mem[681] <= 5'b00000;
    mem[682] <= 5'b11000;
    mem[683] <= 5'b00010;
    mem[684] <= 5'b00101;
    mem[685] <= 5'b11110;
    mem[686] <= 5'b00011;
    mem[687] <= 5'b00110;
    mem[688] <= 5'b00011;
    mem[689] <= 5'b11111;
    mem[690] <= 5'b11100;
    mem[691] <= 5'b11011;
    mem[692] <= 5'b11001;
    mem[693] <= 5'b00010;
    mem[694] <= 5'b11000;
    mem[695] <= 5'b00110;
    mem[696] <= 5'b00101;
    mem[697] <= 5'b11001;
    mem[698] <= 5'b11011;
    mem[699] <= 5'b00000;
    mem[700] <= 5'b11110;
    mem[701] <= 5'b00010;
    mem[702] <= 5'b11010;
    mem[703] <= 5'b11011;
    mem[704] <= 5'b11001;
    mem[705] <= 5'b00001;
    mem[706] <= 5'b11011;
    mem[707] <= 5'b00111;
    mem[708] <= 5'b00101;
    mem[709] <= 5'b11100;
    mem[710] <= 5'b00011;
    mem[711] <= 5'b11010;
    mem[712] <= 5'b11100;
    mem[713] <= 5'b00000;
    mem[714] <= 5'b00110;
    mem[715] <= 5'b11011;
    mem[716] <= 5'b00101;
    mem[717] <= 5'b11001;
    mem[718] <= 5'b11101;
    mem[719] <= 5'b11010;
    mem[720] <= 5'b11100;
    mem[721] <= 5'b11100;
    mem[722] <= 5'b00010;
    mem[723] <= 5'b00011;
    mem[724] <= 5'b00111;
    mem[725] <= 5'b11101;
    mem[726] <= 5'b00010;
    mem[727] <= 5'b11001;
    mem[728] <= 5'b00001;
    mem[729] <= 5'b00110;
    mem[730] <= 5'b00100;
    mem[731] <= 5'b00010;
    mem[732] <= 5'b11110;
    mem[733] <= 5'b11011;
    mem[734] <= 5'b00101;
    mem[735] <= 5'b00110;
    mem[736] <= 5'b00010;
    mem[737] <= 5'b11001;
    mem[738] <= 5'b00010;
    mem[739] <= 5'b00100;
    mem[740] <= 5'b11110;
    mem[741] <= 5'b11111;
    mem[742] <= 5'b00100;
    mem[743] <= 5'b11000;
    mem[744] <= 5'b00100;
    mem[745] <= 5'b00000;
    mem[746] <= 5'b11000;
    mem[747] <= 5'b11100;
    mem[748] <= 5'b11110;
    mem[749] <= 5'b00001;
    mem[750] <= 5'b11010;
    mem[751] <= 5'b11001;
    mem[752] <= 5'b11111;
    mem[753] <= 5'b11001;
    mem[754] <= 5'b11111;
    mem[755] <= 5'b11101;
    mem[756] <= 5'b11011;
    mem[757] <= 5'b11100;
    mem[758] <= 5'b11100;
    mem[759] <= 5'b11101;
    mem[760] <= 5'b11011;
    mem[761] <= 5'b00101;
    mem[762] <= 5'b11111;
    mem[763] <= 5'b11110;
    mem[764] <= 5'b00000;
    mem[765] <= 5'b00110;
    mem[766] <= 5'b00010;
    mem[767] <= 5'b00110;
    mem[768] <= 5'b00110;
    mem[769] <= 5'b00011;
    mem[770] <= 5'b00100;
    mem[771] <= 5'b11101;
    mem[772] <= 5'b00011;
    mem[773] <= 5'b11111;
    mem[774] <= 5'b11001;
    mem[775] <= 5'b11011;
    mem[776] <= 5'b11011;
    mem[777] <= 5'b00000;
    mem[778] <= 5'b11011;
    mem[779] <= 5'b11001;
    mem[780] <= 5'b11111;
    mem[781] <= 5'b00111;
    mem[782] <= 5'b11010;
    mem[783] <= 5'b11100;
    mem[784] <= 5'b11010;
    mem[785] <= 5'b11011;
    mem[786] <= 5'b00100;
    mem[787] <= 5'b11111;
    mem[788] <= 5'b00011;
    mem[789] <= 5'b00011;
    mem[790] <= 5'b00001;
    mem[791] <= 5'b11100;
  end


  // Combinational ROM read block
  always@(*)
  begin
    if ( addr >= 'd0 && addr < 'd792)
      data_out_t <= mem[addr];
    else
    begin
      data_out_t <= {(5){1'b0}};
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
//  Generated date: Sat Jun 15 02:24:36 2024
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    UNET_IP_main_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_6_15_12_32768_1_32768_12_1_gen
// ------------------------------------------------------------------


module UNET_IP_main_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_6_15_12_32768_1_32768_12_1_gen
    (
  clken, q, re, radr, we, d, wadr, clken_d, d_d, q_d, radr_d, re_d, wadr_d, we_d,
      writeA_w_ram_ir_internal_WMASK_B_d, readA_r_ram_ir_internal_RMASK_B_d
);
  output clken;
  input [11:0] q;
  output re;
  output [14:0] radr;
  output we;
  output [11:0] d;
  output [14:0] wadr;
  input clken_d;
  input [11:0] d_d;
  output [11:0] q_d;
  input [14:0] radr_d;
  input re_d;
  input [14:0] wadr_d;
  input we_d;
  input writeA_w_ram_ir_internal_WMASK_B_d;
  input readA_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign clken = (clken_d);
  assign q_d = q;
  assign re = (readA_r_ram_ir_internal_RMASK_B_d);
  assign radr = (radr_d);
  assign we = (writeA_w_ram_ir_internal_WMASK_B_d);
  assign d = (d_d);
  assign wadr = (wadr_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    UNET_IP_main_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_5_15_12_32768_1_32768_12_1_gen
// ------------------------------------------------------------------


module UNET_IP_main_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_5_15_12_32768_1_32768_12_1_gen
    (
  clken, q, re, radr, we, d, wadr, clken_d, d_d, q_d, radr_d, re_d, wadr_d, we_d,
      writeA_w_ram_ir_internal_WMASK_B_d, readA_r_ram_ir_internal_RMASK_B_d
);
  output clken;
  input [11:0] q;
  output re;
  output [14:0] radr;
  output we;
  output [11:0] d;
  output [14:0] wadr;
  input clken_d;
  input [11:0] d_d;
  output [11:0] q_d;
  input [14:0] radr_d;
  input re_d;
  input [14:0] wadr_d;
  input we_d;
  input writeA_w_ram_ir_internal_WMASK_B_d;
  input readA_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign clken = (clken_d);
  assign q_d = q;
  assign re = (readA_r_ram_ir_internal_RMASK_B_d);
  assign radr = (radr_d);
  assign we = (writeA_w_ram_ir_internal_WMASK_B_d);
  assign d = (d_d);
  assign wadr = (wadr_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    UNET_IP_main_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_4_14_12_13068_1_13068_12_1_gen
// ------------------------------------------------------------------


module UNET_IP_main_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_4_14_12_13068_1_13068_12_1_gen
    (
  clken, q, re, radr, we, d, wadr, clken_d, d_d, q_d, radr_d, re_d, wadr_d, we_d,
      writeA_w_ram_ir_internal_WMASK_B_d, readA_r_ram_ir_internal_RMASK_B_d
);
  output clken;
  input [11:0] q;
  output re;
  output [13:0] radr;
  output we;
  output [11:0] d;
  output [13:0] wadr;
  input clken_d;
  input [11:0] d_d;
  output [11:0] q_d;
  input [13:0] radr_d;
  input re_d;
  input [13:0] wadr_d;
  input we_d;
  input writeA_w_ram_ir_internal_WMASK_B_d;
  input readA_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign clken = (clken_d);
  assign q_d = q;
  assign re = (readA_r_ram_ir_internal_RMASK_B_d);
  assign radr = (radr_d);
  assign we = (writeA_w_ram_ir_internal_WMASK_B_d);
  assign d = (d_d);
  assign wadr = (wadr_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    UNET_IP_main_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_3_15_12_32768_1_32768_12_1_gen
// ------------------------------------------------------------------


module UNET_IP_main_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_3_15_12_32768_1_32768_12_1_gen
    (
  clken, q, re, radr, we, d, wadr, clken_d, d_d, q_d, radr_d, re_d, wadr_d, we_d,
      writeA_w_ram_ir_internal_WMASK_B_d, readA_r_ram_ir_internal_RMASK_B_d
);
  output clken;
  input [11:0] q;
  output re;
  output [14:0] radr;
  output we;
  output [11:0] d;
  output [14:0] wadr;
  input clken_d;
  input [11:0] d_d;
  output [11:0] q_d;
  input [14:0] radr_d;
  input re_d;
  input [14:0] wadr_d;
  input we_d;
  input writeA_w_ram_ir_internal_WMASK_B_d;
  input readA_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign clken = (clken_d);
  assign q_d = q;
  assign re = (readA_r_ram_ir_internal_RMASK_B_d);
  assign radr = (radr_d);
  assign we = (writeA_w_ram_ir_internal_WMASK_B_d);
  assign d = (d_d);
  assign wadr = (wadr_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    UNET_IP_main_run_run_fsm
//  FSM Module
// ------------------------------------------------------------------


module UNET_IP_main_run_run_fsm (
  clk, rst, run_wen, fsm_output, for_C_1_tr0, for_1_for_for_C_0_tr0, for_1_for_C_0_tr0,
      for_1_C_0_tr0, for_2_for_for_for_for_for_C_0_tr0, for_2_for_for_for_for_C_0_tr0,
      for_2_for_for_for_C_1_tr0, for_2_for_for_C_0_tr0, for_2_for_C_0_tr0, for_2_C_0_tr0,
      for_3_for_C_0_tr0, for_3_for_1_C_0_tr0, for_3_for_2_C_10_tr0, for_3_C_0_tr0,
      for_4_for_for_C_0_tr0, for_4_for_C_0_tr0, for_4_C_0_tr0, for_5_for_for_for_for_for_C_0_tr0,
      for_5_for_for_for_for_C_0_tr0, for_5_for_for_for_C_1_tr0, for_5_for_for_C_0_tr0,
      for_5_for_C_0_tr0, for_5_C_0_tr0, for_6_for_C_0_tr0, for_6_for_1_C_0_tr0, for_6_for_2_C_10_tr0,
      for_6_C_0_tr0, for_7_for_for_for_for_C_0_tr0, for_7_for_for_for_for_C_0_tr1,
      for_7_for_for_C_1_tr0, for_7_for_C_0_tr0, for_7_C_0_tr0, for_8_C_2_tr0
);
  input clk;
  input rst;
  input run_wen;
  output [59:0] fsm_output;
  reg [59:0] fsm_output;
  input for_C_1_tr0;
  input for_1_for_for_C_0_tr0;
  input for_1_for_C_0_tr0;
  input for_1_C_0_tr0;
  input for_2_for_for_for_for_for_C_0_tr0;
  input for_2_for_for_for_for_C_0_tr0;
  input for_2_for_for_for_C_1_tr0;
  input for_2_for_for_C_0_tr0;
  input for_2_for_C_0_tr0;
  input for_2_C_0_tr0;
  input for_3_for_C_0_tr0;
  input for_3_for_1_C_0_tr0;
  input for_3_for_2_C_10_tr0;
  input for_3_C_0_tr0;
  input for_4_for_for_C_0_tr0;
  input for_4_for_C_0_tr0;
  input for_4_C_0_tr0;
  input for_5_for_for_for_for_for_C_0_tr0;
  input for_5_for_for_for_for_C_0_tr0;
  input for_5_for_for_for_C_1_tr0;
  input for_5_for_for_C_0_tr0;
  input for_5_for_C_0_tr0;
  input for_5_C_0_tr0;
  input for_6_for_C_0_tr0;
  input for_6_for_1_C_0_tr0;
  input for_6_for_2_C_10_tr0;
  input for_6_C_0_tr0;
  input for_7_for_for_for_for_C_0_tr0;
  input for_7_for_for_for_for_C_0_tr1;
  input for_7_for_for_C_1_tr0;
  input for_7_for_C_0_tr0;
  input for_7_C_0_tr0;
  input for_8_C_2_tr0;


  // FSM State Type Declaration for UNET_IP_main_run_run_fsm_1
  parameter
    main_C_0 = 6'd0,
    for_C_0 = 6'd1,
    for_C_1 = 6'd2,
    for_1_for_for_C_0 = 6'd3,
    for_1_for_C_0 = 6'd4,
    for_1_C_0 = 6'd5,
    for_2_for_for_for_for_for_C_0 = 6'd6,
    for_2_for_for_for_for_C_0 = 6'd7,
    for_2_for_for_for_C_0 = 6'd8,
    for_2_for_for_for_C_1 = 6'd9,
    for_2_for_for_C_0 = 6'd10,
    for_2_for_C_0 = 6'd11,
    for_2_C_0 = 6'd12,
    for_3_for_C_0 = 6'd13,
    for_3_for_1_C_0 = 6'd14,
    for_3_for_2_C_0 = 6'd15,
    for_3_for_2_C_1 = 6'd16,
    for_3_for_2_C_2 = 6'd17,
    for_3_for_2_C_3 = 6'd18,
    for_3_for_2_C_4 = 6'd19,
    for_3_for_2_C_5 = 6'd20,
    for_3_for_2_C_6 = 6'd21,
    for_3_for_2_C_7 = 6'd22,
    for_3_for_2_C_8 = 6'd23,
    for_3_for_2_C_9 = 6'd24,
    for_3_for_2_C_10 = 6'd25,
    for_3_C_0 = 6'd26,
    for_4_for_for_C_0 = 6'd27,
    for_4_for_C_0 = 6'd28,
    for_4_C_0 = 6'd29,
    for_5_for_for_for_for_for_C_0 = 6'd30,
    for_5_for_for_for_for_C_0 = 6'd31,
    for_5_for_for_for_C_0 = 6'd32,
    for_5_for_for_for_C_1 = 6'd33,
    for_5_for_for_C_0 = 6'd34,
    for_5_for_C_0 = 6'd35,
    for_5_C_0 = 6'd36,
    for_6_for_C_0 = 6'd37,
    for_6_for_1_C_0 = 6'd38,
    for_6_for_2_C_0 = 6'd39,
    for_6_for_2_C_1 = 6'd40,
    for_6_for_2_C_2 = 6'd41,
    for_6_for_2_C_3 = 6'd42,
    for_6_for_2_C_4 = 6'd43,
    for_6_for_2_C_5 = 6'd44,
    for_6_for_2_C_6 = 6'd45,
    for_6_for_2_C_7 = 6'd46,
    for_6_for_2_C_8 = 6'd47,
    for_6_for_2_C_9 = 6'd48,
    for_6_for_2_C_10 = 6'd49,
    for_6_C_0 = 6'd50,
    for_7_for_for_for_for_C_0 = 6'd51,
    for_7_for_for_for_C_0 = 6'd52,
    for_7_for_for_C_0 = 6'd53,
    for_7_for_for_C_1 = 6'd54,
    for_7_for_C_0 = 6'd55,
    for_7_C_0 = 6'd56,
    for_8_C_0 = 6'd57,
    for_8_C_1 = 6'd58,
    for_8_C_2 = 6'd59;

  reg [5:0] state_var;
  reg [5:0] state_var_NS;


  // Interconnect Declarations for Component Instantiations 
  always @(*)
  begin : UNET_IP_main_run_run_fsm_1
    case (state_var)
      for_C_0 : begin
        fsm_output = 60'b000000000000000000000000000000000000000000000000000000000010;
        state_var_NS = for_C_1;
      end
      for_C_1 : begin
        fsm_output = 60'b000000000000000000000000000000000000000000000000000000000100;
        if ( for_C_1_tr0 ) begin
          state_var_NS = for_1_for_for_C_0;
        end
        else begin
          state_var_NS = for_C_0;
        end
      end
      for_1_for_for_C_0 : begin
        fsm_output = 60'b000000000000000000000000000000000000000000000000000000001000;
        if ( for_1_for_for_C_0_tr0 ) begin
          state_var_NS = for_1_for_C_0;
        end
        else begin
          state_var_NS = for_1_for_for_C_0;
        end
      end
      for_1_for_C_0 : begin
        fsm_output = 60'b000000000000000000000000000000000000000000000000000000010000;
        if ( for_1_for_C_0_tr0 ) begin
          state_var_NS = for_1_C_0;
        end
        else begin
          state_var_NS = for_1_for_for_C_0;
        end
      end
      for_1_C_0 : begin
        fsm_output = 60'b000000000000000000000000000000000000000000000000000000100000;
        if ( for_1_C_0_tr0 ) begin
          state_var_NS = for_2_for_for_for_for_for_C_0;
        end
        else begin
          state_var_NS = for_1_for_for_C_0;
        end
      end
      for_2_for_for_for_for_for_C_0 : begin
        fsm_output = 60'b000000000000000000000000000000000000000000000000000001000000;
        if ( for_2_for_for_for_for_for_C_0_tr0 ) begin
          state_var_NS = for_2_for_for_for_for_C_0;
        end
        else begin
          state_var_NS = for_2_for_for_for_for_for_C_0;
        end
      end
      for_2_for_for_for_for_C_0 : begin
        fsm_output = 60'b000000000000000000000000000000000000000000000000000010000000;
        if ( for_2_for_for_for_for_C_0_tr0 ) begin
          state_var_NS = for_2_for_for_for_C_0;
        end
        else begin
          state_var_NS = for_2_for_for_for_for_for_C_0;
        end
      end
      for_2_for_for_for_C_0 : begin
        fsm_output = 60'b000000000000000000000000000000000000000000000000000100000000;
        state_var_NS = for_2_for_for_for_C_1;
      end
      for_2_for_for_for_C_1 : begin
        fsm_output = 60'b000000000000000000000000000000000000000000000000001000000000;
        if ( for_2_for_for_for_C_1_tr0 ) begin
          state_var_NS = for_2_for_for_C_0;
        end
        else begin
          state_var_NS = for_2_for_for_for_for_for_C_0;
        end
      end
      for_2_for_for_C_0 : begin
        fsm_output = 60'b000000000000000000000000000000000000000000000000010000000000;
        if ( for_2_for_for_C_0_tr0 ) begin
          state_var_NS = for_2_for_C_0;
        end
        else begin
          state_var_NS = for_2_for_for_for_for_for_C_0;
        end
      end
      for_2_for_C_0 : begin
        fsm_output = 60'b000000000000000000000000000000000000000000000000100000000000;
        if ( for_2_for_C_0_tr0 ) begin
          state_var_NS = for_2_C_0;
        end
        else begin
          state_var_NS = for_2_for_for_for_for_for_C_0;
        end
      end
      for_2_C_0 : begin
        fsm_output = 60'b000000000000000000000000000000000000000000000001000000000000;
        if ( for_2_C_0_tr0 ) begin
          state_var_NS = for_3_for_C_0;
        end
        else begin
          state_var_NS = for_2_for_for_for_for_for_C_0;
        end
      end
      for_3_for_C_0 : begin
        fsm_output = 60'b000000000000000000000000000000000000000000000010000000000000;
        if ( for_3_for_C_0_tr0 ) begin
          state_var_NS = for_3_for_1_C_0;
        end
        else begin
          state_var_NS = for_3_for_C_0;
        end
      end
      for_3_for_1_C_0 : begin
        fsm_output = 60'b000000000000000000000000000000000000000000000100000000000000;
        if ( for_3_for_1_C_0_tr0 ) begin
          state_var_NS = for_3_for_2_C_0;
        end
        else begin
          state_var_NS = for_3_for_1_C_0;
        end
      end
      for_3_for_2_C_0 : begin
        fsm_output = 60'b000000000000000000000000000000000000000000001000000000000000;
        state_var_NS = for_3_for_2_C_1;
      end
      for_3_for_2_C_1 : begin
        fsm_output = 60'b000000000000000000000000000000000000000000010000000000000000;
        state_var_NS = for_3_for_2_C_2;
      end
      for_3_for_2_C_2 : begin
        fsm_output = 60'b000000000000000000000000000000000000000000100000000000000000;
        state_var_NS = for_3_for_2_C_3;
      end
      for_3_for_2_C_3 : begin
        fsm_output = 60'b000000000000000000000000000000000000000001000000000000000000;
        state_var_NS = for_3_for_2_C_4;
      end
      for_3_for_2_C_4 : begin
        fsm_output = 60'b000000000000000000000000000000000000000010000000000000000000;
        state_var_NS = for_3_for_2_C_5;
      end
      for_3_for_2_C_5 : begin
        fsm_output = 60'b000000000000000000000000000000000000000100000000000000000000;
        state_var_NS = for_3_for_2_C_6;
      end
      for_3_for_2_C_6 : begin
        fsm_output = 60'b000000000000000000000000000000000000001000000000000000000000;
        state_var_NS = for_3_for_2_C_7;
      end
      for_3_for_2_C_7 : begin
        fsm_output = 60'b000000000000000000000000000000000000010000000000000000000000;
        state_var_NS = for_3_for_2_C_8;
      end
      for_3_for_2_C_8 : begin
        fsm_output = 60'b000000000000000000000000000000000000100000000000000000000000;
        state_var_NS = for_3_for_2_C_9;
      end
      for_3_for_2_C_9 : begin
        fsm_output = 60'b000000000000000000000000000000000001000000000000000000000000;
        state_var_NS = for_3_for_2_C_10;
      end
      for_3_for_2_C_10 : begin
        fsm_output = 60'b000000000000000000000000000000000010000000000000000000000000;
        if ( for_3_for_2_C_10_tr0 ) begin
          state_var_NS = for_3_C_0;
        end
        else begin
          state_var_NS = for_3_for_2_C_0;
        end
      end
      for_3_C_0 : begin
        fsm_output = 60'b000000000000000000000000000000000100000000000000000000000000;
        if ( for_3_C_0_tr0 ) begin
          state_var_NS = for_4_for_for_C_0;
        end
        else begin
          state_var_NS = for_3_for_C_0;
        end
      end
      for_4_for_for_C_0 : begin
        fsm_output = 60'b000000000000000000000000000000001000000000000000000000000000;
        if ( for_4_for_for_C_0_tr0 ) begin
          state_var_NS = for_4_for_C_0;
        end
        else begin
          state_var_NS = for_4_for_for_C_0;
        end
      end
      for_4_for_C_0 : begin
        fsm_output = 60'b000000000000000000000000000000010000000000000000000000000000;
        if ( for_4_for_C_0_tr0 ) begin
          state_var_NS = for_4_C_0;
        end
        else begin
          state_var_NS = for_4_for_for_C_0;
        end
      end
      for_4_C_0 : begin
        fsm_output = 60'b000000000000000000000000000000100000000000000000000000000000;
        if ( for_4_C_0_tr0 ) begin
          state_var_NS = for_5_for_for_for_for_for_C_0;
        end
        else begin
          state_var_NS = for_4_for_for_C_0;
        end
      end
      for_5_for_for_for_for_for_C_0 : begin
        fsm_output = 60'b000000000000000000000000000001000000000000000000000000000000;
        if ( for_5_for_for_for_for_for_C_0_tr0 ) begin
          state_var_NS = for_5_for_for_for_for_C_0;
        end
        else begin
          state_var_NS = for_5_for_for_for_for_for_C_0;
        end
      end
      for_5_for_for_for_for_C_0 : begin
        fsm_output = 60'b000000000000000000000000000010000000000000000000000000000000;
        if ( for_5_for_for_for_for_C_0_tr0 ) begin
          state_var_NS = for_5_for_for_for_C_0;
        end
        else begin
          state_var_NS = for_5_for_for_for_for_for_C_0;
        end
      end
      for_5_for_for_for_C_0 : begin
        fsm_output = 60'b000000000000000000000000000100000000000000000000000000000000;
        state_var_NS = for_5_for_for_for_C_1;
      end
      for_5_for_for_for_C_1 : begin
        fsm_output = 60'b000000000000000000000000001000000000000000000000000000000000;
        if ( for_5_for_for_for_C_1_tr0 ) begin
          state_var_NS = for_5_for_for_C_0;
        end
        else begin
          state_var_NS = for_5_for_for_for_for_for_C_0;
        end
      end
      for_5_for_for_C_0 : begin
        fsm_output = 60'b000000000000000000000000010000000000000000000000000000000000;
        if ( for_5_for_for_C_0_tr0 ) begin
          state_var_NS = for_5_for_C_0;
        end
        else begin
          state_var_NS = for_5_for_for_for_for_for_C_0;
        end
      end
      for_5_for_C_0 : begin
        fsm_output = 60'b000000000000000000000000100000000000000000000000000000000000;
        if ( for_5_for_C_0_tr0 ) begin
          state_var_NS = for_5_C_0;
        end
        else begin
          state_var_NS = for_5_for_for_for_for_for_C_0;
        end
      end
      for_5_C_0 : begin
        fsm_output = 60'b000000000000000000000001000000000000000000000000000000000000;
        if ( for_5_C_0_tr0 ) begin
          state_var_NS = for_6_for_C_0;
        end
        else begin
          state_var_NS = for_5_for_for_for_for_for_C_0;
        end
      end
      for_6_for_C_0 : begin
        fsm_output = 60'b000000000000000000000010000000000000000000000000000000000000;
        if ( for_6_for_C_0_tr0 ) begin
          state_var_NS = for_6_for_1_C_0;
        end
        else begin
          state_var_NS = for_6_for_C_0;
        end
      end
      for_6_for_1_C_0 : begin
        fsm_output = 60'b000000000000000000000100000000000000000000000000000000000000;
        if ( for_6_for_1_C_0_tr0 ) begin
          state_var_NS = for_6_for_2_C_0;
        end
        else begin
          state_var_NS = for_6_for_1_C_0;
        end
      end
      for_6_for_2_C_0 : begin
        fsm_output = 60'b000000000000000000001000000000000000000000000000000000000000;
        state_var_NS = for_6_for_2_C_1;
      end
      for_6_for_2_C_1 : begin
        fsm_output = 60'b000000000000000000010000000000000000000000000000000000000000;
        state_var_NS = for_6_for_2_C_2;
      end
      for_6_for_2_C_2 : begin
        fsm_output = 60'b000000000000000000100000000000000000000000000000000000000000;
        state_var_NS = for_6_for_2_C_3;
      end
      for_6_for_2_C_3 : begin
        fsm_output = 60'b000000000000000001000000000000000000000000000000000000000000;
        state_var_NS = for_6_for_2_C_4;
      end
      for_6_for_2_C_4 : begin
        fsm_output = 60'b000000000000000010000000000000000000000000000000000000000000;
        state_var_NS = for_6_for_2_C_5;
      end
      for_6_for_2_C_5 : begin
        fsm_output = 60'b000000000000000100000000000000000000000000000000000000000000;
        state_var_NS = for_6_for_2_C_6;
      end
      for_6_for_2_C_6 : begin
        fsm_output = 60'b000000000000001000000000000000000000000000000000000000000000;
        state_var_NS = for_6_for_2_C_7;
      end
      for_6_for_2_C_7 : begin
        fsm_output = 60'b000000000000010000000000000000000000000000000000000000000000;
        state_var_NS = for_6_for_2_C_8;
      end
      for_6_for_2_C_8 : begin
        fsm_output = 60'b000000000000100000000000000000000000000000000000000000000000;
        state_var_NS = for_6_for_2_C_9;
      end
      for_6_for_2_C_9 : begin
        fsm_output = 60'b000000000001000000000000000000000000000000000000000000000000;
        state_var_NS = for_6_for_2_C_10;
      end
      for_6_for_2_C_10 : begin
        fsm_output = 60'b000000000010000000000000000000000000000000000000000000000000;
        if ( for_6_for_2_C_10_tr0 ) begin
          state_var_NS = for_6_C_0;
        end
        else begin
          state_var_NS = for_6_for_2_C_0;
        end
      end
      for_6_C_0 : begin
        fsm_output = 60'b000000000100000000000000000000000000000000000000000000000000;
        if ( for_6_C_0_tr0 ) begin
          state_var_NS = for_7_for_for_for_for_C_0;
        end
        else begin
          state_var_NS = for_6_for_C_0;
        end
      end
      for_7_for_for_for_for_C_0 : begin
        fsm_output = 60'b000000001000000000000000000000000000000000000000000000000000;
        if ( for_7_for_for_for_for_C_0_tr0 ) begin
          state_var_NS = for_7_for_for_C_0;
        end
        else if ( for_7_for_for_for_for_C_0_tr1 ) begin
          state_var_NS = for_7_for_for_for_for_C_0;
        end
        else begin
          state_var_NS = for_7_for_for_for_C_0;
        end
      end
      for_7_for_for_for_C_0 : begin
        fsm_output = 60'b000000010000000000000000000000000000000000000000000000000000;
        state_var_NS = for_7_for_for_for_for_C_0;
      end
      for_7_for_for_C_0 : begin
        fsm_output = 60'b000000100000000000000000000000000000000000000000000000000000;
        state_var_NS = for_7_for_for_C_1;
      end
      for_7_for_for_C_1 : begin
        fsm_output = 60'b000001000000000000000000000000000000000000000000000000000000;
        if ( for_7_for_for_C_1_tr0 ) begin
          state_var_NS = for_7_for_C_0;
        end
        else begin
          state_var_NS = for_7_for_for_for_for_C_0;
        end
      end
      for_7_for_C_0 : begin
        fsm_output = 60'b000010000000000000000000000000000000000000000000000000000000;
        if ( for_7_for_C_0_tr0 ) begin
          state_var_NS = for_7_C_0;
        end
        else begin
          state_var_NS = for_7_for_for_for_for_C_0;
        end
      end
      for_7_C_0 : begin
        fsm_output = 60'b000100000000000000000000000000000000000000000000000000000000;
        if ( for_7_C_0_tr0 ) begin
          state_var_NS = for_8_C_0;
        end
        else begin
          state_var_NS = for_7_for_for_for_for_C_0;
        end
      end
      for_8_C_0 : begin
        fsm_output = 60'b001000000000000000000000000000000000000000000000000000000000;
        state_var_NS = for_8_C_1;
      end
      for_8_C_1 : begin
        fsm_output = 60'b010000000000000000000000000000000000000000000000000000000000;
        state_var_NS = for_8_C_2;
      end
      for_8_C_2 : begin
        fsm_output = 60'b100000000000000000000000000000000000000000000000000000000000;
        if ( for_8_C_2_tr0 ) begin
          state_var_NS = main_C_0;
        end
        else begin
          state_var_NS = for_8_C_0;
        end
      end
      // main_C_0
      default : begin
        fsm_output = 60'b000000000000000000000000000000000000000000000000000000000001;
        state_var_NS = for_C_0;
      end
    endcase
  end

  always @(posedge clk) begin
    if ( rst ) begin
      state_var <= main_C_0;
    end
    else if ( run_wen ) begin
      state_var <= state_var_NS;
    end
  end

endmodule

// ------------------------------------------------------------------
//  Design Unit:    UNET_IP_main_run_staller
// ------------------------------------------------------------------


module UNET_IP_main_run_staller (
  run_wen, input_rsci_wen_comp, output_rsci_wen_comp
);
  output run_wen;
  input input_rsci_wen_comp;
  input output_rsci_wen_comp;



  // Interconnect Declarations for Component Instantiations 
  assign run_wen = input_rsci_wen_comp & output_rsci_wen_comp;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    UNET_IP_main_run_output_rsci_output_wait_ctrl
// ------------------------------------------------------------------


module UNET_IP_main_run_output_rsci_output_wait_ctrl (
  output_rsci_iswt0, output_rsci_biwt, output_rsci_irdy
);
  input output_rsci_iswt0;
  output output_rsci_biwt;
  input output_rsci_irdy;



  // Interconnect Declarations for Component Instantiations 
  assign output_rsci_biwt = output_rsci_iswt0 & output_rsci_irdy;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    UNET_IP_main_run_input_rsci_input_wait_ctrl
// ------------------------------------------------------------------


module UNET_IP_main_run_input_rsci_input_wait_ctrl (
  input_rsci_iswt0, input_rsci_biwt, input_rsci_ivld
);
  input input_rsci_iswt0;
  output input_rsci_biwt;
  input input_rsci_ivld;



  // Interconnect Declarations for Component Instantiations 
  assign input_rsci_biwt = input_rsci_iswt0 & input_rsci_ivld;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    UNET_IP_main_run_output_rsci
// ------------------------------------------------------------------


module UNET_IP_main_run_output_rsci (
  output_rsc_dat, output_rsc_vld, output_rsc_rdy, output_rsci_oswt, output_rsci_wen_comp,
      output_rsci_idat
);
  output [11:0] output_rsc_dat;
  output output_rsc_vld;
  input output_rsc_rdy;
  input output_rsci_oswt;
  output output_rsci_wen_comp;
  input [11:0] output_rsci_idat;


  // Interconnect Declarations
  wire output_rsci_biwt;
  wire output_rsci_irdy;


  // Interconnect Declarations for Component Instantiations 
  ccs_out_wait_v1 #(.rscid(32'sd2),
  .width(32'sd12)) output_rsci (
      .irdy(output_rsci_irdy),
      .ivld(output_rsci_oswt),
      .idat(output_rsci_idat),
      .rdy(output_rsc_rdy),
      .vld(output_rsc_vld),
      .dat(output_rsc_dat)
    );
  UNET_IP_main_run_output_rsci_output_wait_ctrl UNET_IP_main_run_output_rsci_output_wait_ctrl_inst
      (
      .output_rsci_iswt0(output_rsci_oswt),
      .output_rsci_biwt(output_rsci_biwt),
      .output_rsci_irdy(output_rsci_irdy)
    );
  assign output_rsci_wen_comp = (~ output_rsci_oswt) | output_rsci_biwt;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    UNET_IP_main_run_input_rsci
// ------------------------------------------------------------------


module UNET_IP_main_run_input_rsci (
  input_rsc_dat, input_rsc_vld, input_rsc_rdy, input_rsci_oswt, input_rsci_wen_comp,
      input_rsci_idat_mxwt
);
  input [11:0] input_rsc_dat;
  input input_rsc_vld;
  output input_rsc_rdy;
  input input_rsci_oswt;
  output input_rsci_wen_comp;
  output [11:0] input_rsci_idat_mxwt;


  // Interconnect Declarations
  wire input_rsci_biwt;
  wire input_rsci_ivld;
  wire [11:0] input_rsci_idat;


  // Interconnect Declarations for Component Instantiations 
  ccs_in_wait_v1 #(.rscid(32'sd1),
  .width(32'sd12)) input_rsci (
      .rdy(input_rsc_rdy),
      .vld(input_rsc_vld),
      .dat(input_rsc_dat),
      .irdy(input_rsci_oswt),
      .ivld(input_rsci_ivld),
      .idat(input_rsci_idat)
    );
  UNET_IP_main_run_input_rsci_input_wait_ctrl UNET_IP_main_run_input_rsci_input_wait_ctrl_inst
      (
      .input_rsci_iswt0(input_rsci_oswt),
      .input_rsci_biwt(input_rsci_biwt),
      .input_rsci_ivld(input_rsci_ivld)
    );
  assign input_rsci_idat_mxwt = input_rsci_idat;
  assign input_rsci_wen_comp = (~ input_rsci_oswt) | input_rsci_biwt;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    UNET_IP_main_run
// ------------------------------------------------------------------


module UNET_IP_main_run (
  clk, rst, input_rsc_dat, input_rsc_vld, input_rsc_rdy, output_rsc_dat, output_rsc_vld,
      output_rsc_rdy, buf1_rsci_clken_d, buf1_rsci_d_d, buf1_rsci_q_d, buf1_rsci_radr_d,
      buf1_rsci_wadr_d, padded_input_rsci_q_d, padded_input_rsci_radr_d, padded_input_rsci_wadr_d,
      buf2_rsci_d_d, buf2_rsci_q_d, buf2_rsci_radr_d, buf2_rsci_wadr_d, enc1_rsci_d_d,
      enc1_rsci_q_d, enc1_rsci_radr_d, enc1_rsci_wadr_d, buf1_rsci_re_d_pff, buf1_rsci_we_d_pff,
      padded_input_rsci_re_d_pff, padded_input_rsci_we_d_pff, buf2_rsci_re_d_pff,
      buf2_rsci_we_d_pff, enc1_rsci_re_d_pff, enc1_rsci_we_d_pff
);
  input clk;
  input rst;
  input [11:0] input_rsc_dat;
  input input_rsc_vld;
  output input_rsc_rdy;
  output [11:0] output_rsc_dat;
  output output_rsc_vld;
  input output_rsc_rdy;
  output buf1_rsci_clken_d;
  output [11:0] buf1_rsci_d_d;
  input [11:0] buf1_rsci_q_d;
  output [14:0] buf1_rsci_radr_d;
  output [14:0] buf1_rsci_wadr_d;
  input [11:0] padded_input_rsci_q_d;
  output [13:0] padded_input_rsci_radr_d;
  output [13:0] padded_input_rsci_wadr_d;
  output [11:0] buf2_rsci_d_d;
  input [11:0] buf2_rsci_q_d;
  output [14:0] buf2_rsci_radr_d;
  output [14:0] buf2_rsci_wadr_d;
  output [11:0] enc1_rsci_d_d;
  input [11:0] enc1_rsci_q_d;
  output [14:0] enc1_rsci_radr_d;
  output [14:0] enc1_rsci_wadr_d;
  output buf1_rsci_re_d_pff;
  output buf1_rsci_we_d_pff;
  output padded_input_rsci_re_d_pff;
  output padded_input_rsci_we_d_pff;
  output buf2_rsci_re_d_pff;
  output buf2_rsci_we_d_pff;
  output enc1_rsci_re_d_pff;
  output enc1_rsci_we_d_pff;


  // Interconnect Declarations
  wire run_wen;
  wire input_rsci_wen_comp;
  wire [11:0] input_rsci_idat_mxwt;
  wire output_rsci_wen_comp;
  reg [11:0] output_rsci_idat;
  wire [18:0] for_3_for_2_div_cmp_z;
  reg [12:0] for_3_for_2_div_cmp_a_18_6;
  wire [59:0] fsm_output;
  wire for_5_for_for_for_for_xor_tmp;
  wire for_2_for_for_2_for_xnor_tmp;
  wire or_dcpl_4;
  wire and_dcpl_2;
  wire and_dcpl_3;
  wire or_dcpl_94;
  wire or_dcpl_108;
  wire or_dcpl_109;
  wire or_dcpl_115;
  wire or_dcpl_122;
  wire or_dcpl_128;
  wire or_dcpl_130;
  wire or_dcpl_143;
  wire or_dcpl_151;
  wire or_dcpl_157;
  wire or_dcpl_159;
  wire or_dcpl_163;
  wire or_dcpl_168;
  wire or_dcpl_169;
  wire or_dcpl_170;
  wire or_dcpl_173;
  wire or_dcpl_216;
  wire or_dcpl_219;
  wire or_dcpl_223;
  wire or_dcpl_228;
  wire or_dcpl_231;
  wire or_dcpl_232;
  wire or_dcpl_239;
  wire or_dcpl_277;
  wire or_dcpl_278;
  wire or_tmp_64;
  wire or_tmp_134;
  wire and_410_cse;
  wire and_400_cse;
  wire and_399_cse;
  wire and_409_cse;
  reg ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp;
  reg ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_qr_0_lpi_3_dfm;
  wire [5:0] i_12_5_0_sva_2;
  wire [6:0] nl_i_12_5_0_sva_2;
  reg [27:0] var_tmp_33_6_sva;
  wire [3:0] out_c_3_3_0_sva_2;
  wire [4:0] nl_out_c_3_3_0_sva_2;
  reg for_2_for_for_for_slc_for_2_for_for_for_acc_6_itm;
  wire [3:0] out_c_2_3_0_sva_2;
  wire [4:0] nl_out_c_2_3_0_sva_2;
  wire [6:0] i_2_6_0_sva_2;
  wire [7:0] nl_i_2_6_0_sva_2;
  reg [27:0] var_tmp_33_6_1_sva;
  reg for_2_for_for_for_for_for_stage_0_2;
  reg for_2_for_for_for_for_for_stage_0_3;
  reg for_1_for_for_stage_0_2;
  reg for_7_for_for_for_for_land_lpi_6_dfm_st_1;
  reg y_asn_1_itm_2;
  reg for_2_for_for_for_for_for_stage_0_4;
  reg y_asn_1_itm_3;
  reg [18:0] for_6_for_2_acc_9_psp_1_sva;
  wire [19:0] nl_for_6_for_2_acc_9_psp_1_sva;
  reg [5:0] for_6_for_2_mul_1_psp_1_sva_5_0;
  reg [18:0] for_3_for_2_acc_9_psp_1_sva;
  wire [19:0] nl_for_3_for_2_acc_9_psp_1_sva;
  reg [5:0] for_3_for_2_mul_1_psp_1_sva_5_0;
  reg [11:0] i_10_12_0_sva_11_0;
  reg y_1_1_0_sva_0;
  reg y_1_1_0_sva_1;
  reg [8:0] reg_var_tmp_33_6_1_ftd;
  reg [8:0] reg_var_tmp_33_6_1_1_ftd;
  reg [4:0] ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_1_itm_9_5;
  reg [4:0] ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_1_itm_4_0;
  reg reg_output_rsci_iswt0_cse;
  reg reg_input_rsci_iswt0_cse;
  wire or_79_cse;
  wire or_cse;
  wire nor_5_cse;
  wire i_and_2_ssc;
  reg i_11_12_0_sva_1_12;
  reg [11:0] i_11_12_0_sva_1_11_0;
  wire for_5_for_for_for_for_for_xor_cse;
  reg [2:0] out_c_3_3_0_sva_2_0;
  wire or_329_ssc;
  reg [2:0] for_3_for_2_div_cmp_b_13_11;
  reg [10:0] for_3_for_2_div_cmp_b_10_0;
  wire for_1_for_for_or_1_cse;
  wire or_242_cse;
  wire j_j_nor_cse;
  wire for_1_for_for_or_cse;
  reg [4:0] ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_and_itm;
  reg [6:0] i_3_6_0_sva;
  reg [2:0] out_c_2_3_0_sva_2_0;
  reg [7:0] for_2_for_for_for_for_for_acc_itm_1_13_6;
  wire [8:0] nl_for_2_for_for_for_for_for_acc_itm_1_13_6;
  reg [5:0] ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_itm;
  reg [7:0] for_5_for_for_for_for_for_acc_25_itm_1_13_6;
  wire [8:0] nl_for_5_for_for_for_for_for_acc_25_itm_1_13_6;
  reg [2:0] for_5_for_for_for_for_for_mul_itm_1_8_6;
  reg [2:0] for_5_for_for_for_for_for_mul_itm_1_2_0;
  reg [11:0] temp_11_0_1_sva_1;
  reg [11:0] temp_11_0_sva_1;
  reg [13:0] i_1_13_0_sva;
  wire or_480_itm;
  wire or_481_itm;
  wire [5:0] z_out_1;
  wire [9:0] z_out_2;
  wire [7:0] z_out_3;
  wire [8:0] nl_z_out_3;
  wire [12:0] z_out_4;
  wire [13:0] nl_z_out_4;
  wire [4:0] data_out_out;
  wire [6:0] z_out_7;
  wire [7:0] nl_z_out_7;
  wire [20:0] z_out_9;
  wire [31:0] z_out_10;
  wire [4:0] rtn_out;
  wire [23:0] z_out_11;
  wire signed [25:0] nl_z_out_11;
  wire [11:0] z_out_12;
  wire [12:0] nl_z_out_12;
  wire [13:0] z_out_14;
  wire [14:0] nl_z_out_14;
  reg [1:0] in_c_1_1_0_sva;
  reg [11:0] temp_11_0_1_lpi_7;
  reg [12:0] ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_24_12_sva;
  wire [13:0] nl_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_24_12_sva;
  reg [11:0] temp_11_0_lpi_7;
  reg [3:0] for_5_for_for_for_for_for_acc_7_sdt_sva_1_9_6;
  wire [4:0] nl_for_5_for_for_for_for_for_acc_7_sdt_sva_1_9_6;
  reg [3:0] for_5_for_for_for_for_for_acc_7_sdt_sva_1_5_2;
  reg [7:0] for_2_for_for_for_for_for_acc_7_itm_1_7_0;
  wire [8:0] nl_for_2_for_for_for_for_for_acc_7_itm_1_7_0;
  wire [13:0] ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_and_itm_mx0w0;
  wire for_1_for_for_stage_0_2_mx0w2;
  wire ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp_mx0c0;
  wire ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp_mx0c3;
  wire ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_itm_mx0c0;
  wire ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_itm_mx0c1;
  wire in_c_1_1_0_sva_mx0c0;
  wire [1:0] out_c_1_1_0_sva_2;
  wire [2:0] nl_out_c_1_1_0_sva_2;
  wire [6:0] for_1_for_for_acc_14_psp_1;
  wire [7:0] nl_for_1_for_for_acc_14_psp_1;
  wire [11:0] temp_11_0_1_sva_1_mx1w0;
  wire [12:0] nl_temp_11_0_1_sva_1_mx1w0;
  wire out_c_2_3_0_sva_2_0_mx0c1;
  wire i_3_6_0_sva_mx0c0;
  wire i_3_6_0_sva_mx0c1;
  wire [6:0] i_3_6_0_sva_2;
  wire [7:0] nl_i_3_6_0_sva_2;
  wire x_1_sva_1_0_mx0c0;
  wire for_7_for_for_for_for_land_lpi_6_dfm_st_1_mx0w4;
  wire i_10_12_0_sva_11_0_mx0c1;
  wire i_10_12_0_sva_11_0_mx0c3;
  wire [3:0] for_2_for_for_for_for_for_acc_21_sdt_3_0_1;
  wire [4:0] nl_for_2_for_for_for_for_for_acc_21_sdt_3_0_1;
  wire [27:0] var_tmp_33_6_1_sva_1_mx1w0;
  wire [28:0] nl_var_tmp_33_6_1_sva_1_mx1w0;
  wire out_c_3_3_0_sva_2_0_mx0c1;
  wire [24:0] for_3_for_2_mul_1_psp_1_sva_2;
  wire signed [26:0] nl_for_3_for_2_mul_1_psp_1_sva_2;
  wire for_3_for_2_and_cse_1;
  wire for_3_for_2_and_2_cse_1;
  wire for_3_for_2_and_3_cse_1;
  wire for_3_for_2_mul_1_psp_1_sva_3;
  wire [11:0] temp_11_0_sva_1_mx1w0;
  wire [12:0] nl_temp_11_0_sva_1_mx1w0;
  wire [8:0] for_5_for_for_for_for_for_acc_23_sdt_1;
  wire [9:0] nl_for_5_for_for_for_for_for_acc_23_sdt_1;
  wire [5:0] for_5_for_for_for_for_for_acc_sdt_1;
  wire [6:0] nl_for_5_for_for_for_for_for_acc_sdt_1;
  wire [4:0] for_5_for_for_for_for_for_acc_19_sdt_1;
  wire [6:0] nl_for_5_for_for_for_for_for_acc_19_sdt_1;
  wire [27:0] var_tmp_33_6_sva_1_mx1w0;
  wire [28:0] nl_var_tmp_33_6_sva_1_mx1w0;
  wire [24:0] for_6_for_2_mul_1_psp_1_sva_1;
  wire signed [26:0] nl_for_6_for_2_mul_1_psp_1_sva_1;
  reg [5:0] for_3_for_2_asn_itm_18_13;
  reg [12:0] for_3_for_2_asn_itm_12_0;
  reg [2:0] ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mul_psp_sva_13_11;
  reg [10:0] ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mul_psp_sva_10_0;
  reg reg_j_2_ftd;
  reg [5:0] reg_j_2_ftd_1;
  wire or_288_tmp;
  wire [7:0] for_2_for_for_for_for_for_acc_17_sdt_1_8_1;
  wire [8:0] nl_for_2_for_for_for_for_for_acc_17_sdt_1_8_1;
  wire ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_or_3_cse;
  reg [13:0] reg_for_1_for_for_acc_1_itm_1_cse;
  wire [14:0] nl_reg_for_1_for_for_acc_1_itm_1_cse;
  reg [13:0] reg_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_qr_cse;
  wire for_1_for_for_or_3_cse;
  wire or_203_cse;
  wire [8:0] operator_22_0_false_AC_TRN_AC_WRAP_mux_cse;
  reg [1:0] reg_for_2_for_for_for_for_for_mul_itm_1_cse;
  wire ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_normalized_fixed_temp_or_cse;
  wire i_or_7_cse;
  wire or_601_itm;
  wire [24:0] ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_temp_mul_itm_35_11_1;
  wire [24:0] ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_temp_mul_itm_35_11_1;
  wire for_2_for_for_acc_3_itm_6_1;
  wire x_and_ssc;
  reg reg_x_1_sva_1_0_ftd;
  reg reg_x_1_sva_1_0_ftd_1;
  wire [6:0] for_5_for_for_for_for_for_acc_15_sdt;
  wire [7:0] nl_for_5_for_for_for_for_for_acc_15_sdt;
  wire ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_and_2_cse;
  wire z_out_8_32;
  wire or_324_cse;
  wire for_1_for_for_for_1_for_for_and_2_atp;

  wire[13:0] i_i_mux_1_nl;
  wire or_325_nl;
  wire nor_63_nl;
  wire operator_20_false_mux1h_nl;
  wire[2:0] operator_20_false_acc_1_nl;
  wire[3:0] nl_operator_20_false_acc_1_nl;
  wire ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_and_1_nl;
  wire ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_and_1_nl;
  wire or_442_nl;
  wire for_1_for_for_mux_8_nl;
  wire[6:0] for_1_for_for_acc_17_nl;
  wire[7:0] nl_for_1_for_for_acc_17_nl;
  wire for_1_for_for_mux1h_42_nl;
  wire ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_and_1_nl;
  wire ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_and_2_nl;
  wire ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_and_4_nl;
  wire[4:0] ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux1h_6_nl;
  wire ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux1h_25_nl;
  wire ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_not_nl;
  wire[1:0] in_c_mux_nl;
  wire in_c_not_nl;
  wire j_j_mux_nl;
  wire[5:0] for_1_for_for_1_for_and_nl;
  wire[5:0] for_1_for_mux_nl;
  wire[5:0] for_7_for_for_acc_3_nl;
  wire[6:0] nl_for_7_for_for_acc_3_nl;
  wire j_or_nl;
  wire or_478_nl;
  wire[11:0] temp_temp_mux1h_nl;
  wire temp_temp_nor_nl;
  wire temp_and_3_nl;
  wire nor_66_nl;
  wire j_and_nl;
  wire j_or_1_nl;
  wire y_mux_nl;
  wire for_1_for_for_mux_9_nl;
  wire for_1_for_for_mux1h_44_nl;
  wire or_510_nl;
  wire[3:0] for_2_for_for_for_for_for_acc_28_nl;
  wire[4:0] nl_for_2_for_for_for_for_for_acc_28_nl;
  wire[3:0] for_2_for_for_for_for_for_acc_27_nl;
  wire[4:0] nl_for_2_for_for_for_for_for_acc_27_nl;
  wire[7:0] for_2_for_for_for_for_for_mul_7_nl;
  wire[4:0] ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_mux1h_16_nl;
  wire[4:0] ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_qif_acc_nl;
  wire[5:0] nl_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_qif_acc_nl;
  wire[4:0] ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_qif_acc_nl;
  wire[5:0] nl_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_qif_acc_nl;
  wire or_515_nl;
  wire nor_69_nl;
  wire[12:0] for_7_for_for_for_for_else_acc_4_nl;
  wire[11:0] i_mux1h_19_nl;
  wire i_or_8_nl;
  wire i_and_4_nl;
  wire i_and_5_nl;
  wire nor_70_nl;
  wire[4:0] for_2_for_for_for_for_for_asn_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_1_itm_1_4_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_and_nl;
  wire[4:0] ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_mux_nl;
  wire nand_17_nl;
  wire nor_71_nl;
  wire[6:0] for_2_for_for_for_acc_13_nl;
  wire[7:0] nl_for_2_for_for_for_acc_13_nl;
  wire[27:0] var_tmp_mux_nl;
  wire[12:0] for_3_for_1_acc_4_nl;
  wire[13:0] nl_for_3_for_1_acc_4_nl;
  wire or_544_nl;
  wire[11:0] for_2_for_for_for_for_2_for_for_for_and_1_nl;
  wire ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_nor_nl;
  wire for_3_for_2_or_1_nl;
  wire[11:0] temp_temp_mux1h_1_nl;
  wire temp_temp_nor_1_nl;
  wire temp_and_5_nl;
  wire not_220_nl;
  wire[3:0] for_5_for_for_for_for_for_acc_36_nl;
  wire[4:0] nl_for_5_for_for_for_for_for_acc_36_nl;
  wire[1:0] for_5_for_for_for_for_for_acc_37_nl;
  wire[2:0] nl_for_5_for_for_for_for_for_acc_37_nl;
  wire[27:0] var_tmp_mux_3_nl;
  wire[1:0] for_2_for_for_for_for_for_acc_26_nl;
  wire[2:0] nl_for_2_for_for_for_for_for_acc_26_nl;
  wire[2:0] for_2_for_for_for_for_for_acc_19_nl;
  wire[3:0] nl_for_2_for_for_for_for_for_acc_19_nl;
  wire[35:0] ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_temp_mul_nl;
  wire[36:0] nl_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_temp_mul_nl;
  wire[7:0] for_5_for_for_for_for_for_acc_22_nl;
  wire[8:0] nl_for_5_for_for_for_for_for_acc_22_nl;
  wire[3:0] for_5_for_for_for_for_for_acc_30_nl;
  wire[4:0] nl_for_5_for_for_for_for_for_acc_30_nl;
  wire[4:0] for_5_for_for_for_for_for_acc_38_nl;
  wire[5:0] nl_for_5_for_for_for_for_for_acc_38_nl;
  wire[3:0] for_5_for_for_for_for_for_acc_27_nl;
  wire[4:0] nl_for_5_for_for_for_for_for_acc_27_nl;
  wire[35:0] ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_temp_mul_nl;
  wire[36:0] nl_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_temp_mul_nl;
  wire[6:0] for_2_for_for_acc_3_nl;
  wire[7:0] nl_for_2_for_for_acc_3_nl;
  wire[11:0] for_3_for_2_for_3_for_2_and_nl;
  wire for_for_and_nl;
  wire[1:0] for_mux1h_11_nl;
  wire[5:0] for_for_mux_nl;
  wire[5:0] for_for_mux_1_nl;
  wire for_for_and_1_nl;
  wire for_for_and_2_nl;
  wire for_mux_1_nl;
  wire for_mux1h_1_nl;
  wire[1:0] for_mux1h_14_nl;
  wire[4:0] for_mux1h_15_nl;
  wire[4:0] for_mux1h_16_nl;
  wire[11:0] for_2_for_for_for_for_for_acc_30_nl;
  wire[12:0] nl_for_2_for_for_for_for_for_acc_30_nl;
  wire[7:0] for_2_for_for_for_for_for_mux_12_nl;
  wire for_2_for_for_for_for_for_for_2_for_for_for_for_for_and_3_nl;
  wire for_2_for_for_for_for_for_for_2_for_for_for_for_for_and_4_nl;
  wire[11:0] for_2_for_for_for_for_2_for_for_for_mux_2_nl;
  wire or_379_nl;
  wire[8:0] for_2_for_for_for_acc_nl;
  wire[9:0] nl_for_2_for_for_for_acc_nl;
  wire[2:0] for_2_for_for_for_mux_6_nl;
  wire for_2_for_for_for_for_2_for_for_for_and_4_nl;
  wire for_2_for_for_for_for_2_for_for_for_and_5_nl;
  wire for_2_for_for_for_for_2_for_for_for_or_1_nl;
  wire[11:0] for_3_for_mux_3_nl;
  wire[32:0] operator_40_20_false_AC_TRN_AC_WRAP_acc_nl;
  wire[33:0] nl_operator_40_20_false_AC_TRN_AC_WRAP_acc_nl;
  wire[18:0] operator_40_20_false_AC_TRN_AC_WRAP_mux_4_nl;
  wire[5:0] operator_40_20_false_AC_TRN_AC_WRAP_mux_5_nl;
  wire ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_and_1_nl;
  wire ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux_3_nl;
  wire ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux1h_6_nl;
  wire[10:0] ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux1h_7_nl;
  wire[6:0] ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux1h_8_nl;
  wire[5:0] ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux1h_9_nl;
  wire[11:0] for_1_for_for_mul_nl;
  wire[12:0] nl_for_1_for_for_mul_nl;
  wire[1:0] for_1_for_for_mux_11_nl;
  wire[11:0] for_3_for_mux_4_nl;

  // Interconnect Declarations for Component Instantiations 
  wire [18:0] nl_for_3_for_2_div_cmp_a;
  assign nl_for_3_for_2_div_cmp_a = {for_3_for_2_div_cmp_a_18_6 , 6'b000000};
  wire [14:0] nl_for_3_for_2_div_cmp_b;
  assign nl_for_3_for_2_div_cmp_b = {1'b0 , for_3_for_2_div_cmp_b_13_11 , for_3_for_2_div_cmp_b_10_0};
  wire[1:0] for_2_for_for_for_for_for_for_2_for_for_for_for_for_and_2_nl;
  wire[4:0] for_2_for_for_for_for_for_mux_nl;
  wire for_2_for_for_for_for_for_mux_3_nl;
  wire[1:0] for_2_for_for_for_for_for_mux_4_nl;
  wire [9:0] nl_for_2_for_for_for_for_for_read_rom_UNET_IP_filters_pretrain_rom_map_1_rg_addr;
  assign for_2_for_for_for_for_for_for_2_for_for_for_for_for_and_2_nl = MUX_v_2_2_2(2'b00,
      (for_5_for_for_for_for_for_acc_15_sdt[6:5]), (fsm_output[30]));
  assign for_2_for_for_for_for_for_mux_nl = MUX_v_5_2_2((for_2_for_for_for_for_for_acc_7_itm_1_7_0[7:3]),
      (for_5_for_for_for_for_for_acc_15_sdt[4:0]), fsm_output[30]);
  assign for_2_for_for_for_for_for_mux_3_nl = MUX_s_1_2_2((for_2_for_for_for_for_for_acc_7_itm_1_7_0[2]),
      (for_5_for_for_for_for_for_acc_7_sdt_sva_1_5_2[0]), fsm_output[30]);
  assign for_2_for_for_for_for_for_mux_4_nl = MUX_v_2_2_2((for_2_for_for_for_for_for_acc_7_itm_1_7_0[1:0]),
      in_c_1_1_0_sva, fsm_output[30]);
  assign nl_for_2_for_for_for_for_for_read_rom_UNET_IP_filters_pretrain_rom_map_1_rg_addr
      = {for_2_for_for_for_for_for_for_2_for_for_for_for_for_and_2_nl , for_2_for_for_for_for_for_mux_nl
      , for_2_for_for_for_for_for_mux_3_nl , for_2_for_for_for_for_for_mux_4_nl};
  wire[12:0] ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_m1_mux1h_nl;
  wire ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_m1_and_nl;
  wire ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_m1_and_1_nl;
  wire[10:0] ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_m1_mux1h_1_nl;
  wire ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_m1_and_2_nl;
  wire ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_m1_and_3_nl;
  wire operator_32_8_false_AC_TRN_AC_WRAP_mux_2_nl;
  wire ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_m1_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_m1_and_nl;
  wire ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_m1_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_m1_and_nl;
  wire [24:0] nl_operator_32_8_false_AC_TRN_AC_WRAP_1_lshift_rg_a;
  assign ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_m1_and_nl
      = (~ (fsm_output[41])) & ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_qr_0_lpi_3_dfm;
  assign ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_m1_and_1_nl
      = (fsm_output[41]) & ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_qr_0_lpi_3_dfm;
  assign ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_m1_mux1h_nl
      = MUX1HOT_v_13_3_2(ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_24_12_sva,
      (ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_temp_mul_itm_35_11_1[24:12]),
      (ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_temp_mul_itm_35_11_1[24:12]),
      {(~ ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_qr_0_lpi_3_dfm)
      , ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_m1_and_nl
      , ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_m1_and_1_nl});
  assign ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_m1_and_2_nl
      = (~ (fsm_output[41])) & ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_qr_0_lpi_3_dfm;
  assign ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_m1_and_3_nl
      = (fsm_output[41]) & ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_qr_0_lpi_3_dfm;
  assign ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_m1_mux1h_1_nl
      = MUX1HOT_v_11_3_2(ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mul_psp_sva_10_0,
      (ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_temp_mul_itm_35_11_1[11:1]),
      (ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_temp_mul_itm_35_11_1[11:1]),
      {(~ ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_qr_0_lpi_3_dfm)
      , ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_m1_and_2_nl
      , ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_m1_and_3_nl});
  assign ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_m1_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_m1_and_nl
      = (ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_temp_mul_itm_35_11_1[0])
      & ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_qr_0_lpi_3_dfm;
  assign ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_m1_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_m1_and_nl
      = (ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_temp_mul_itm_35_11_1[0])
      & ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_qr_0_lpi_3_dfm;
  assign operator_32_8_false_AC_TRN_AC_WRAP_mux_2_nl = MUX_s_1_2_2(ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_m1_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_m1_and_nl,
      ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_m1_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_m1_and_nl,
      fsm_output[41]);
  assign nl_operator_32_8_false_AC_TRN_AC_WRAP_1_lshift_rg_a = {ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_m1_mux1h_nl
      , ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_m1_mux1h_1_nl
      , operator_32_8_false_AC_TRN_AC_WRAP_mux_2_nl};
  wire [21:0] nl_leading_sign_22_0_rg_mantissa;
  assign nl_leading_sign_22_0_rg_mantissa = {13'b0, operator_22_0_false_AC_TRN_AC_WRAP_mux_cse};
  wire  nl_UNET_IP_main_run_run_fsm_inst_for_C_1_tr0;
  assign nl_UNET_IP_main_run_run_fsm_inst_for_C_1_tr0 = ~ ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_qr_0_lpi_3_dfm;
  wire  nl_UNET_IP_main_run_run_fsm_inst_for_1_for_C_0_tr0;
  assign nl_UNET_IP_main_run_run_fsm_inst_for_1_for_C_0_tr0 = i_2_6_0_sva_2[6];
  wire  nl_UNET_IP_main_run_run_fsm_inst_for_2_for_for_for_C_1_tr0;
  assign nl_UNET_IP_main_run_run_fsm_inst_for_2_for_for_for_C_1_tr0 = ~ for_2_for_for_for_slc_for_2_for_for_for_acc_6_itm;
  wire  nl_UNET_IP_main_run_run_fsm_inst_for_2_for_for_C_0_tr0;
  assign nl_UNET_IP_main_run_run_fsm_inst_for_2_for_for_C_0_tr0 = ~ for_2_for_for_acc_3_itm_6_1;
  wire  nl_UNET_IP_main_run_run_fsm_inst_for_2_C_0_tr0;
  assign nl_UNET_IP_main_run_run_fsm_inst_for_2_C_0_tr0 = out_c_2_3_0_sva_2[3];
  wire  nl_UNET_IP_main_run_run_fsm_inst_for_3_for_C_0_tr0;
  assign nl_UNET_IP_main_run_run_fsm_inst_for_3_for_C_0_tr0 = ~ ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp;
  wire  nl_UNET_IP_main_run_run_fsm_inst_for_3_C_0_tr0;
  assign nl_UNET_IP_main_run_run_fsm_inst_for_3_C_0_tr0 = out_c_3_3_0_sva_2[3];
  wire  nl_UNET_IP_main_run_run_fsm_inst_for_4_for_C_0_tr0;
  assign nl_UNET_IP_main_run_run_fsm_inst_for_4_for_C_0_tr0 = i_2_6_0_sva_2[6];
  wire  nl_UNET_IP_main_run_run_fsm_inst_for_4_C_0_tr0;
  assign nl_UNET_IP_main_run_run_fsm_inst_for_4_C_0_tr0 = out_c_2_3_0_sva_2[3];
  wire  nl_UNET_IP_main_run_run_fsm_inst_for_5_for_for_for_C_1_tr0;
  assign nl_UNET_IP_main_run_run_fsm_inst_for_5_for_for_for_C_1_tr0 = ~ for_2_for_for_for_slc_for_2_for_for_for_acc_6_itm;
  wire  nl_UNET_IP_main_run_run_fsm_inst_for_5_for_for_C_0_tr0;
  assign nl_UNET_IP_main_run_run_fsm_inst_for_5_for_for_C_0_tr0 = ~ for_2_for_for_acc_3_itm_6_1;
  wire  nl_UNET_IP_main_run_run_fsm_inst_for_5_for_C_0_tr0;
  assign nl_UNET_IP_main_run_run_fsm_inst_for_5_for_C_0_tr0 = out_c_2_3_0_sva_2[3];
  wire  nl_UNET_IP_main_run_run_fsm_inst_for_5_C_0_tr0;
  assign nl_UNET_IP_main_run_run_fsm_inst_for_5_C_0_tr0 = out_c_3_3_0_sva_2[3];
  wire  nl_UNET_IP_main_run_run_fsm_inst_for_6_for_C_0_tr0;
  assign nl_UNET_IP_main_run_run_fsm_inst_for_6_for_C_0_tr0 = ~ ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp;
  wire  nl_UNET_IP_main_run_run_fsm_inst_for_6_C_0_tr0;
  assign nl_UNET_IP_main_run_run_fsm_inst_for_6_C_0_tr0 = out_c_3_3_0_sva_2[3];
  wire  nl_UNET_IP_main_run_run_fsm_inst_for_7_for_for_for_for_C_0_tr0;
  assign nl_UNET_IP_main_run_run_fsm_inst_for_7_for_for_for_for_C_0_tr0 = (~ ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp)
      & ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_qr_0_lpi_3_dfm;
  wire  nl_UNET_IP_main_run_run_fsm_inst_for_7_for_for_C_1_tr0;
  assign nl_UNET_IP_main_run_run_fsm_inst_for_7_for_for_C_1_tr0 = reg_j_2_ftd_1[5];
  wire  nl_UNET_IP_main_run_run_fsm_inst_for_7_for_C_0_tr0;
  assign nl_UNET_IP_main_run_run_fsm_inst_for_7_for_C_0_tr0 = i_12_5_0_sva_2[5];
  wire  nl_UNET_IP_main_run_run_fsm_inst_for_7_C_0_tr0;
  assign nl_UNET_IP_main_run_run_fsm_inst_for_7_C_0_tr0 = out_c_3_3_0_sva_2[3];
  wire  nl_UNET_IP_main_run_run_fsm_inst_for_8_C_2_tr0;
  assign nl_UNET_IP_main_run_run_fsm_inst_for_8_C_2_tr0 = ~ ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_qr_0_lpi_3_dfm;
  mgc_div #(.width_a(32'sd19),
  .width_b(32'sd15),
  .signd(32'sd1)) for_3_for_2_div_cmp (
      .a(nl_for_3_for_2_div_cmp_a[18:0]),
      .b(nl_for_3_for_2_div_cmp_b[14:0]),
      .z(for_3_for_2_div_cmp_z)
    );
  UNET_IP_mainmgc_rom_17_792_5_1  for_2_for_for_for_for_for_read_rom_UNET_IP_filters_pretrain_rom_map_1_rg
      (
      .addr(nl_for_2_for_for_for_for_for_read_rom_UNET_IP_filters_pretrain_rom_map_1_rg_addr[9:0]),
      .data_out(data_out_out)
    );
  mgc_shift_l_v5 #(.width_a(32'sd9),
  .signd_a(32'sd0),
  .width_s(32'sd5),
  .width_z(32'sd21)) operator_22_0_false_AC_TRN_AC_WRAP_1_lshift_rg (
      .a(operator_22_0_false_AC_TRN_AC_WRAP_mux_cse),
      .s(rtn_out),
      .z(z_out_9)
    );
  mgc_shift_bl_v5 #(.width_a(32'sd25),
  .signd_a(32'sd0),
  .width_s(32'sd5),
  .width_z(32'sd32)) operator_32_8_false_AC_TRN_AC_WRAP_1_lshift_rg (
      .a(nl_operator_32_8_false_AC_TRN_AC_WRAP_1_lshift_rg_a[24:0]),
      .s(ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_and_itm),
      .z(z_out_10)
    );
  leading_sign_22_0  leading_sign_22_0_rg (
      .mantissa(nl_leading_sign_22_0_rg_mantissa[21:0]),
      .rtn(rtn_out)
    );
  UNET_IP_main_run_input_rsci UNET_IP_main_run_input_rsci_inst (
      .input_rsc_dat(input_rsc_dat),
      .input_rsc_vld(input_rsc_vld),
      .input_rsc_rdy(input_rsc_rdy),
      .input_rsci_oswt(reg_input_rsci_iswt0_cse),
      .input_rsci_wen_comp(input_rsci_wen_comp),
      .input_rsci_idat_mxwt(input_rsci_idat_mxwt)
    );
  UNET_IP_main_run_output_rsci UNET_IP_main_run_output_rsci_inst (
      .output_rsc_dat(output_rsc_dat),
      .output_rsc_vld(output_rsc_vld),
      .output_rsc_rdy(output_rsc_rdy),
      .output_rsci_oswt(reg_output_rsci_iswt0_cse),
      .output_rsci_wen_comp(output_rsci_wen_comp),
      .output_rsci_idat(output_rsci_idat)
    );
  UNET_IP_main_run_staller UNET_IP_main_run_staller_inst (
      .run_wen(run_wen),
      .input_rsci_wen_comp(input_rsci_wen_comp),
      .output_rsci_wen_comp(output_rsci_wen_comp)
    );
  UNET_IP_main_run_run_fsm UNET_IP_main_run_run_fsm_inst (
      .clk(clk),
      .rst(rst),
      .run_wen(run_wen),
      .fsm_output(fsm_output),
      .for_C_1_tr0(nl_UNET_IP_main_run_run_fsm_inst_for_C_1_tr0),
      .for_1_for_for_C_0_tr0(and_dcpl_2),
      .for_1_for_C_0_tr0(nl_UNET_IP_main_run_run_fsm_inst_for_1_for_C_0_tr0),
      .for_1_C_0_tr0(for_2_for_for_2_for_xnor_tmp),
      .for_2_for_for_for_for_for_C_0_tr0(and_dcpl_3),
      .for_2_for_for_for_for_C_0_tr0(for_5_for_for_for_for_xor_tmp),
      .for_2_for_for_for_C_1_tr0(nl_UNET_IP_main_run_run_fsm_inst_for_2_for_for_for_C_1_tr0),
      .for_2_for_for_C_0_tr0(nl_UNET_IP_main_run_run_fsm_inst_for_2_for_for_C_0_tr0),
      .for_2_for_C_0_tr0(for_2_for_for_2_for_xnor_tmp),
      .for_2_C_0_tr0(nl_UNET_IP_main_run_run_fsm_inst_for_2_C_0_tr0),
      .for_3_for_C_0_tr0(nl_UNET_IP_main_run_run_fsm_inst_for_3_for_C_0_tr0),
      .for_3_for_1_C_0_tr0(nor_5_cse),
      .for_3_for_2_C_10_tr0(i_11_12_0_sva_1_12),
      .for_3_C_0_tr0(nl_UNET_IP_main_run_run_fsm_inst_for_3_C_0_tr0),
      .for_4_for_for_C_0_tr0(and_dcpl_2),
      .for_4_for_C_0_tr0(nl_UNET_IP_main_run_run_fsm_inst_for_4_for_C_0_tr0),
      .for_4_C_0_tr0(nl_UNET_IP_main_run_run_fsm_inst_for_4_C_0_tr0),
      .for_5_for_for_for_for_for_C_0_tr0(and_dcpl_3),
      .for_5_for_for_for_for_C_0_tr0(for_5_for_for_for_for_xor_tmp),
      .for_5_for_for_for_C_1_tr0(nl_UNET_IP_main_run_run_fsm_inst_for_5_for_for_for_C_1_tr0),
      .for_5_for_for_C_0_tr0(nl_UNET_IP_main_run_run_fsm_inst_for_5_for_for_C_0_tr0),
      .for_5_for_C_0_tr0(nl_UNET_IP_main_run_run_fsm_inst_for_5_for_C_0_tr0),
      .for_5_C_0_tr0(nl_UNET_IP_main_run_run_fsm_inst_for_5_C_0_tr0),
      .for_6_for_C_0_tr0(nl_UNET_IP_main_run_run_fsm_inst_for_6_for_C_0_tr0),
      .for_6_for_1_C_0_tr0(nor_5_cse),
      .for_6_for_2_C_10_tr0(i_11_12_0_sva_1_12),
      .for_6_C_0_tr0(nl_UNET_IP_main_run_run_fsm_inst_for_6_C_0_tr0),
      .for_7_for_for_for_for_C_0_tr0(nl_UNET_IP_main_run_run_fsm_inst_for_7_for_for_for_for_C_0_tr0),
      .for_7_for_for_for_for_C_0_tr1(ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp),
      .for_7_for_for_C_1_tr0(nl_UNET_IP_main_run_run_fsm_inst_for_7_for_for_C_1_tr0),
      .for_7_for_C_0_tr0(nl_UNET_IP_main_run_run_fsm_inst_for_7_for_C_0_tr0),
      .for_7_C_0_tr0(nl_UNET_IP_main_run_run_fsm_inst_for_7_C_0_tr0),
      .for_8_C_2_tr0(nl_UNET_IP_main_run_run_fsm_inst_for_8_C_2_tr0)
    );
  assign buf1_rsci_clken_d = run_wen;
  assign or_329_ssc = or_dcpl_130 | (fsm_output[21]) | or_dcpl_128 | (fsm_output[45]);
  assign or_324_cse = (fsm_output[1]) | (fsm_output[57]);
  assign for_1_for_for_or_1_cse = (fsm_output[6]) | (fsm_output[30]);
  assign for_1_for_for_or_cse = (fsm_output[3]) | (fsm_output[27]);
  assign for_1_for_for_or_3_cse = (fsm_output[14]) | (fsm_output[38]);
  assign ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_or_3_cse
      = (fsm_output[15]) | (fsm_output[39]);
  assign or_480_itm = or_dcpl_216 | (fsm_output[33]) | (fsm_output[9]) | (fsm_output[6])
      | (fsm_output[30]);
  assign or_481_itm = or_dcpl_168 | (fsm_output[35]) | or_dcpl_219 | (fsm_output[12])
      | and_409_cse | and_410_cse;
  assign or_242_cse = (~ for_2_for_for_for_for_for_stage_0_4) | y_asn_1_itm_3;
  assign j_j_nor_cse = ~((out_c_3_3_0_sva_2_0[1:0]!=2'b00));
  assign x_and_ssc = run_wen & (x_1_sva_1_0_mx0c0 | (fsm_output[7]) | (fsm_output[31]));
  assign for_5_for_for_for_for_for_xor_cse = y_1_1_0_sva_0 ^ y_1_1_0_sva_1;
  assign for_7_for_for_for_for_else_acc_4_nl = $signed((i_10_12_0_sva_11_0)) - $signed(enc1_rsci_q_d);
  assign or_288_tmp = (~((readslicef_13_1_12(for_7_for_for_for_for_else_acc_4_nl))
      | for_2_for_for_for_for_for_stage_0_4)) | (~((~(ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp
      & for_2_for_for_for_for_for_stage_0_3)) & for_1_for_for_stage_0_2));
  assign i_or_7_cse = (fsm_output[38:37]!=2'b00);
  assign i_and_2_ssc = run_wen & ((fsm_output[14:13]!=2'b00) | ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_or_3_cse);
  assign or_79_cse = (reg_var_tmp_33_6_1_1_ftd!=9'b000000000);
  assign or_cse = (reg_var_tmp_33_6_1_ftd!=9'b000000000);
  assign ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_normalized_fixed_temp_or_cse
      = (fsm_output[18]) | (fsm_output[42]);
  assign ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_and_2_cse
      = run_wen & (~(or_dcpl_130 | or_dcpl_128));
  assign or_203_cse = (fsm_output[16]) | (fsm_output[40]);
  assign ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_and_itm_mx0w0
      = MUX_v_14_2_2(14'b00000000000000, reg_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_qr_cse,
      ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp);
  assign for_1_for_for_stage_0_2_mx0w2 = ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp
      & (~(for_1_for_for_stage_0_2 & for_5_for_for_for_for_for_xor_cse));
  assign nl_out_c_1_1_0_sva_2 = in_c_1_1_0_sva + 2'b01;
  assign out_c_1_1_0_sva_2 = nl_out_c_1_1_0_sva_2[1:0];
  assign nl_for_1_for_for_acc_14_psp_1 = conv_u2u_6_7({1'b1 , (reg_j_2_ftd_1[5:1])})
      + conv_u2u_6_7(ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_itm);
  assign for_1_for_for_acc_14_psp_1 = nl_for_1_for_for_acc_14_psp_1[6:0];
  assign nl_i_2_6_0_sva_2 = conv_u2u_6_7(ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_itm)
      + 7'b0000001;
  assign i_2_6_0_sva_2 = nl_i_2_6_0_sva_2[6:0];
  assign nl_temp_11_0_1_sva_1_mx1w0 = temp_11_0_1_lpi_7 + conv_s2s_10_12(z_out_11[15:6]);
  assign temp_11_0_1_sva_1_mx1w0 = nl_temp_11_0_1_sva_1_mx1w0[11:0];
  assign nl_i_3_6_0_sva_2 = i_3_6_0_sva + 7'b0000001;
  assign i_3_6_0_sva_2 = nl_i_3_6_0_sva_2[6:0];
  assign for_7_for_for_for_for_land_lpi_6_dfm_st_1_mx0w4 = ~(for_2_for_for_for_for_for_stage_0_2
      | ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_qr_0_lpi_3_dfm);
  assign nl_for_2_for_for_for_for_for_acc_17_sdt_1_8_1 = conv_s2u_7_8(z_out_3[7:1])
      + conv_u2u_7_8(i_3_6_0_sva);
  assign for_2_for_for_for_for_for_acc_17_sdt_1_8_1 = nl_for_2_for_for_for_for_for_acc_17_sdt_1_8_1[7:0];
  assign nl_for_2_for_for_for_for_for_acc_26_nl = ({reg_x_1_sva_1_0_ftd , reg_x_1_sva_1_0_ftd_1})
      + conv_s2s_1_2(reg_x_1_sva_1_0_ftd);
  assign for_2_for_for_for_for_for_acc_26_nl = nl_for_2_for_for_for_for_for_acc_26_nl[1:0];
  assign nl_for_2_for_for_for_for_for_acc_19_nl = conv_s2s_2_3({y_1_1_0_sva_1 , y_1_1_0_sva_0})
      + conv_u2s_2_3(in_c_1_1_0_sva);
  assign for_2_for_for_for_for_for_acc_19_nl = nl_for_2_for_for_for_for_for_acc_19_nl[2:0];
  assign nl_for_2_for_for_for_for_for_acc_21_sdt_3_0_1 = conv_s2s_3_4({for_2_for_for_for_for_for_acc_26_nl
      , reg_x_1_sva_1_0_ftd_1}) + conv_s2s_3_4(for_2_for_for_for_for_for_acc_19_nl);
  assign for_2_for_for_for_for_for_acc_21_sdt_3_0_1 = nl_for_2_for_for_for_for_for_acc_21_sdt_3_0_1[3:0];
  assign nl_var_tmp_33_6_1_sva_1_mx1w0 = var_tmp_33_6_1_sva + conv_s2u_24_28(z_out_11);
  assign var_tmp_33_6_1_sva_1_mx1w0 = nl_var_tmp_33_6_1_sva_1_mx1w0[27:0];
  assign nl_out_c_2_3_0_sva_2 = conv_u2u_3_4(out_c_2_3_0_sva_2_0) + 4'b0001;
  assign out_c_2_3_0_sva_2 = nl_out_c_2_3_0_sva_2[3:0];
  assign nl_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_temp_mul_nl
      = 13'b1011010100001 * ({ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_24_12_sva
      , ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mul_psp_sva_10_0});
  assign ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_temp_mul_nl
      = nl_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_temp_mul_nl[35:0];
  assign ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_temp_mul_itm_35_11_1
      = readslicef_36_25_11(ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_temp_mul_nl);
  assign nl_for_3_for_2_mul_1_psp_1_sva_2 = $signed(conv_u2s_7_8({(~ for_3_for_2_mul_1_psp_1_sva_3)
      , for_3_for_2_mul_1_psp_1_sva_3 , for_3_for_2_mul_1_psp_1_sva_3 , for_3_for_2_mul_1_psp_1_sva_3
      , for_3_for_2_mul_1_psp_1_sva_3 , for_3_for_2_mul_1_psp_1_sva_3 , for_3_for_2_mul_1_psp_1_sva_3}))
      * $signed(({for_3_for_2_asn_itm_18_13 , for_3_for_2_asn_itm_12_0}));
  assign for_3_for_2_mul_1_psp_1_sva_2 = nl_for_3_for_2_mul_1_psp_1_sva_2[24:0];
  assign for_3_for_2_and_cse_1 = (out_c_3_3_0_sva_2_0==3'b001);
  assign for_3_for_2_and_2_cse_1 = (out_c_3_3_0_sva_2_0[2]) & j_j_nor_cse;
  assign for_3_for_2_and_3_cse_1 = (out_c_3_3_0_sva_2_0==3'b110);
  assign for_3_for_2_mul_1_psp_1_sva_3 = for_3_for_2_and_cse_1 | ((out_c_3_3_0_sva_2_0==3'b011))
      | for_3_for_2_and_2_cse_1 | for_3_for_2_and_3_cse_1 | ((out_c_3_3_0_sva_2_0==3'b111));
  assign nl_out_c_3_3_0_sva_2 = conv_u2u_3_4(out_c_3_3_0_sva_2_0) + 4'b0001;
  assign out_c_3_3_0_sva_2 = nl_out_c_3_3_0_sva_2[3:0];
  assign nl_temp_11_0_sva_1_mx1w0 = temp_11_0_lpi_7 + conv_s2s_10_12(z_out_11[15:6]);
  assign temp_11_0_sva_1_mx1w0 = nl_temp_11_0_sva_1_mx1w0[11:0];
  assign nl_for_5_for_for_for_for_for_acc_30_nl = conv_s2s_3_4({ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_qr_0_lpi_3_dfm
      , reg_x_1_sva_1_0_ftd , reg_x_1_sva_1_0_ftd_1}) + conv_s2s_1_4(y_1_1_0_sva_1);
  assign for_5_for_for_for_for_for_acc_30_nl = nl_for_5_for_for_for_for_for_acc_30_nl[3:0];
  assign nl_for_5_for_for_for_for_for_acc_22_nl = conv_u2s_7_8({reg_j_2_ftd , reg_j_2_ftd_1})
      + conv_s2s_5_8({for_5_for_for_for_for_for_acc_30_nl , y_1_1_0_sva_0});
  assign for_5_for_for_for_for_for_acc_22_nl = nl_for_5_for_for_for_for_for_acc_22_nl[7:0];
  assign nl_for_5_for_for_for_for_for_acc_23_sdt_1 = conv_s2s_8_9(for_5_for_for_for_for_for_acc_22_nl)
      + conv_u2s_8_9({i_3_6_0_sva , 1'b0});
  assign for_5_for_for_for_for_for_acc_23_sdt_1 = nl_for_5_for_for_for_for_for_acc_23_sdt_1[8:0];
  assign nl_for_5_for_for_for_for_for_acc_38_nl = conv_u2s_3_5(out_c_3_3_0_sva_2_0)
      + conv_s2s_2_5(for_5_for_for_for_for_for_acc_19_sdt_1[4:3]);
  assign for_5_for_for_for_for_for_acc_38_nl = nl_for_5_for_for_for_for_for_acc_38_nl[4:0];
  assign nl_for_5_for_for_for_for_for_acc_sdt_1 = ({for_5_for_for_for_for_for_acc_38_nl
      , (for_5_for_for_for_for_for_acc_19_sdt_1[2])}) + conv_u2u_4_6({out_c_2_3_0_sva_2_0
      , 1'b1});
  assign for_5_for_for_for_for_for_acc_sdt_1 = nl_for_5_for_for_for_for_for_acc_sdt_1[5:0];
  assign nl_for_5_for_for_for_for_for_acc_27_nl = conv_s2s_2_4({reg_x_1_sva_1_0_ftd
      , reg_x_1_sva_1_0_ftd_1}) + conv_u2s_2_4(out_c_2_3_0_sva_2_0[2:1]);
  assign for_5_for_for_for_for_for_acc_27_nl = nl_for_5_for_for_for_for_for_acc_27_nl[3:0];
  assign nl_for_5_for_for_for_for_for_acc_19_sdt_1 = ({for_5_for_for_for_for_for_acc_27_nl
      , (out_c_2_3_0_sva_2_0[0])}) + conv_s2s_2_5({reg_x_1_sva_1_0_ftd , reg_x_1_sva_1_0_ftd_1})
      + conv_s2s_2_5({y_1_1_0_sva_1 , y_1_1_0_sva_0});
  assign for_5_for_for_for_for_for_acc_19_sdt_1 = nl_for_5_for_for_for_for_for_acc_19_sdt_1[4:0];
  assign nl_var_tmp_33_6_sva_1_mx1w0 = var_tmp_33_6_sva + conv_s2u_24_28(z_out_11);
  assign var_tmp_33_6_sva_1_mx1w0 = nl_var_tmp_33_6_sva_1_mx1w0[27:0];
  assign nl_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_temp_mul_nl
      = 13'b1011010100001 * ({ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_24_12_sva
      , ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mul_psp_sva_10_0});
  assign ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_temp_mul_nl
      = nl_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_temp_mul_nl[35:0];
  assign ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_temp_mul_itm_35_11_1
      = readslicef_36_25_11(ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_temp_mul_nl);
  assign nl_for_6_for_2_mul_1_psp_1_sva_1 = $signed(conv_u2s_7_8(i_3_6_0_sva)) *
      $signed(({for_3_for_2_asn_itm_18_13 , for_3_for_2_asn_itm_12_0}));
  assign for_6_for_2_mul_1_psp_1_sva_1 = nl_for_6_for_2_mul_1_psp_1_sva_1[24:0];
  assign nl_i_12_5_0_sva_2 = conv_u2u_5_6(ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_and_itm)
      + 6'b000001;
  assign i_12_5_0_sva_2 = nl_i_12_5_0_sva_2[5:0];
  assign nl_for_2_for_for_acc_3_nl = i_3_6_0_sva_2 + 7'b0111111;
  assign for_2_for_for_acc_3_nl = nl_for_2_for_for_acc_3_nl[6:0];
  assign for_2_for_for_acc_3_itm_6_1 = readslicef_7_1_6(for_2_for_for_acc_3_nl);
  assign for_5_for_for_for_for_xor_tmp = reg_x_1_sva_1_0_ftd_1 ^ reg_x_1_sva_1_0_ftd;
  assign for_2_for_for_2_for_xnor_tmp = ~((out_c_1_1_0_sva_2[0]) ^ (out_c_1_1_0_sva_2[1]));
  assign or_dcpl_4 = (fsm_output[13]) | (fsm_output[37]);
  assign and_dcpl_2 = ~(ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp
      | for_1_for_for_stage_0_2);
  assign and_dcpl_3 = and_dcpl_2 & (~(for_2_for_for_for_for_for_stage_0_3 | for_2_for_for_for_for_for_stage_0_2));
  assign nor_5_cse = ~(ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp
      | for_2_for_for_for_for_for_stage_0_2);
  assign or_dcpl_94 = (fsm_output[39:38]!=2'b00);
  assign or_dcpl_108 = (fsm_output[49]) | (fsm_output[46]);
  assign or_dcpl_109 = (fsm_output[41]) | (fsm_output[43]);
  assign or_dcpl_115 = (fsm_output[17]) | (fsm_output[19]);
  assign or_dcpl_122 = (fsm_output[26]) | (fsm_output[12]);
  assign or_dcpl_128 = (fsm_output[44:43]!=2'b00);
  assign or_dcpl_130 = (fsm_output[20:19]!=2'b00);
  assign or_dcpl_143 = (fsm_output[36]) | (fsm_output[29]);
  assign or_dcpl_151 = (fsm_output[56]) | (fsm_output[50]);
  assign or_dcpl_157 = (fsm_output[56:55]!=2'b00);
  assign or_dcpl_159 = (fsm_output[54]) | (fsm_output[28]) | (fsm_output[4]);
  assign or_dcpl_163 = (fsm_output[35:34]!=2'b00);
  assign or_dcpl_168 = (fsm_output[11:10]!=2'b00);
  assign or_dcpl_169 = or_dcpl_168 | (fsm_output[31]);
  assign or_dcpl_170 = or_dcpl_169 | (fsm_output[7]) | (fsm_output[33]) | (fsm_output[9]);
  assign or_dcpl_173 = (fsm_output[50]) | (fsm_output[5]);
  assign or_dcpl_216 = (fsm_output[31]) | (fsm_output[7]);
  assign or_dcpl_219 = (fsm_output[34]) | (fsm_output[36]);
  assign or_dcpl_223 = (fsm_output[12]) | (fsm_output[5]);
  assign or_dcpl_228 = (fsm_output[36]) | (fsm_output[26]);
  assign or_dcpl_231 = (fsm_output[29]) | (fsm_output[12]);
  assign or_dcpl_232 = or_dcpl_231 | (fsm_output[5]);
  assign or_dcpl_239 = (fsm_output[9]) | (fsm_output[35]);
  assign or_dcpl_277 = (~ for_2_for_for_for_for_for_stage_0_3) | for_7_for_for_for_for_land_lpi_6_dfm_st_1;
  assign or_dcpl_278 = (fsm_output[36]) | (fsm_output[50]);
  assign or_tmp_64 = (fsm_output[8]) | (fsm_output[32]);
  assign or_tmp_134 = (fsm_output[35:33]!=3'b000) | or_dcpl_143;
  assign and_400_cse = ((out_c_1_1_0_sva_2[0]) ^ (out_c_1_1_0_sva_2[1])) & (fsm_output[5]);
  assign and_399_cse = (~ (out_c_2_3_0_sva_2[3])) & (fsm_output[29]);
  assign and_410_cse = for_2_for_for_2_for_xnor_tmp & (fsm_output[5]);
  assign and_409_cse = (out_c_2_3_0_sva_2[3]) & (fsm_output[29]);
  assign ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp_mx0c0
      = or_dcpl_159 | or_dcpl_169 | (fsm_output[7]) | (fsm_output[55]) | (fsm_output[56])
      | (fsm_output[33]) | (fsm_output[9]) | or_dcpl_163 | (fsm_output[52]) | or_dcpl_143
      | (fsm_output[2]) | (fsm_output[26]) | (fsm_output[12]) | or_dcpl_173 | ((~
      ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp) & or_dcpl_4);
  assign ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp_mx0c3
      = ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp & (z_out_4[12])
      & or_dcpl_4;
  assign ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_itm_mx0c0
      = (fsm_output[29]) | (fsm_output[2]) | (fsm_output[26]) | (fsm_output[5]);
  assign ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_itm_mx0c1
      = (fsm_output[28]) | (fsm_output[4]);
  assign in_c_1_1_0_sva_mx0c0 = and_410_cse | (fsm_output[2]) | (fsm_output[12]);
  assign out_c_2_3_0_sva_2_0_mx0c1 = (fsm_output[35]) | (fsm_output[12]) | and_399_cse;
  assign i_3_6_0_sva_mx0c0 = (fsm_output[11]) | (fsm_output[35]) | (fsm_output[36])
      | or_dcpl_232;
  assign i_3_6_0_sva_mx0c1 = (fsm_output[10]) | (fsm_output[34]);
  assign x_1_sva_1_0_mx0c0 = or_dcpl_168 | (fsm_output[33]) | or_dcpl_239 | or_dcpl_219
      | (fsm_output[29]) | or_dcpl_223;
  assign i_10_12_0_sva_11_0_mx0c1 = or_dcpl_228 | (fsm_output[12]) | (fsm_output[50])
      | (fsm_output[14]);
  assign i_10_12_0_sva_11_0_mx0c3 = (fsm_output[49]) | (fsm_output[25]);
  assign out_c_3_3_0_sva_2_0_mx0c1 = (fsm_output[56]) | (fsm_output[26]) | ((~ (out_c_3_3_0_sva_2[3]))
      & or_dcpl_278);
  assign for_3_for_2_for_3_for_2_and_nl = MUX_v_12_2_2(12'b000000000000, (for_3_for_2_acc_9_psp_1_sva[11:0]),
      z_out_8_32);
  assign buf1_rsci_d_d = MUX1HOT_v_12_3_2(input_rsci_idat_mxwt, for_3_for_2_for_3_for_2_and_nl,
      i_10_12_0_sva_11_0, {(fsm_output[1]) , (fsm_output[24]) , (fsm_output[53])});
  assign for_for_and_nl = (out_c_2_3_0_sva_2_0[2]) & (fsm_output[27]);
  assign for_mux1h_11_nl = MUX1HOT_v_2_3_2(in_c_1_1_0_sva, (out_c_2_3_0_sva_2_0[1:0]),
      (i_1_13_0_sva[13:12]), {(fsm_output[3]) , (fsm_output[27]) , (fsm_output[57])});
  assign for_for_mux_nl = MUX_v_6_2_2(ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_itm,
      (i_1_13_0_sva[11:6]), fsm_output[57]);
  assign for_for_mux_1_nl = MUX_v_6_2_2(reg_j_2_ftd_1, (i_1_13_0_sva[5:0]), fsm_output[57]);
  assign buf1_rsci_radr_d = {for_for_and_nl , for_mux1h_11_nl , for_for_mux_nl ,
      for_for_mux_1_nl};
  assign buf1_rsci_re_d_pff = (ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp
      & for_1_for_for_or_cse) | (fsm_output[57]);
  assign for_for_and_1_nl = (out_c_3_3_0_sva_2_0[2]) & (~((fsm_output[1]) | (fsm_output[53])));
  assign for_mux_1_nl = MUX_s_1_2_2((i_1_13_0_sva[13]), (out_c_3_3_0_sva_2_0[1]),
      fsm_output[24]);
  assign for_for_and_2_nl = for_mux_1_nl & (~ (fsm_output[53]));
  assign for_mux1h_1_nl = MUX1HOT_s_1_3_2((i_1_13_0_sva[12]), (out_c_3_3_0_sva_2_0[0]),
      (out_c_3_3_0_sva_2_0[2]), {(fsm_output[1]) , (fsm_output[24]) , (fsm_output[53])});
  assign for_mux1h_14_nl = MUX1HOT_v_2_3_2((i_1_13_0_sva[11:10]), (i_10_12_0_sva_11_0[11:10]),
      (out_c_3_3_0_sva_2_0[1:0]), {(fsm_output[1]) , (fsm_output[24]) , (fsm_output[53])});
  assign for_mux1h_15_nl = MUX1HOT_v_5_3_2((i_1_13_0_sva[9:5]), (i_10_12_0_sva_11_0[9:5]),
      ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_and_itm,
      {(fsm_output[1]) , (fsm_output[24]) , (fsm_output[53])});
  assign for_mux1h_16_nl = MUX1HOT_v_5_3_2((i_1_13_0_sva[4:0]), (i_10_12_0_sva_11_0[4:0]),
      ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_1_itm_4_0,
      {(fsm_output[1]) , (fsm_output[24]) , (fsm_output[53])});
  assign buf1_rsci_wadr_d = {for_for_and_1_nl , for_for_and_2_nl , for_mux1h_1_nl
      , for_mux1h_14_nl , for_mux1h_15_nl , for_mux1h_16_nl};
  assign buf1_rsci_we_d_pff = (fsm_output[1]) | (fsm_output[24]) | (fsm_output[53]);
  assign for_2_for_for_for_for_for_mux_12_nl = MUX_v_8_2_2(for_2_for_for_for_for_for_acc_itm_1_13_6,
      for_5_for_for_for_for_for_acc_25_itm_1_13_6, fsm_output[30]);
  assign for_2_for_for_for_for_for_for_2_for_for_for_for_for_and_3_nl = (for_5_for_for_for_for_for_mul_itm_1_8_6[2])
      & (fsm_output[30]);
  assign for_2_for_for_for_for_for_for_2_for_for_for_for_for_and_4_nl = (for_5_for_for_for_for_for_mul_itm_1_2_0[2])
      & (fsm_output[30]);
  assign nl_for_2_for_for_for_for_for_acc_30_nl = ({for_2_for_for_for_for_for_mux_12_nl
      , (ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_itm[5:2])})
      + ({reg_for_2_for_for_for_for_for_mul_itm_1_cse , 1'b0 , for_2_for_for_for_for_for_for_2_for_for_for_for_for_and_3_nl
      , (for_5_for_for_for_for_for_mul_itm_1_8_6[1:0]) , 3'b000 , for_2_for_for_for_for_for_for_2_for_for_for_for_for_and_4_nl
      , (for_5_for_for_for_for_for_mul_itm_1_2_0[1:0])});
  assign for_2_for_for_for_for_for_acc_30_nl = nl_for_2_for_for_for_for_for_acc_30_nl[11:0];
  assign padded_input_rsci_radr_d = {for_2_for_for_for_for_for_acc_30_nl , (ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_itm[1:0])};
  assign padded_input_rsci_re_d_pff = for_2_for_for_for_for_for_stage_0_2 & for_1_for_for_or_1_cse;
  assign padded_input_rsci_wadr_d = reg_for_1_for_for_acc_1_itm_1_cse;
  assign padded_input_rsci_we_d_pff = for_1_for_for_stage_0_2 & for_1_for_for_or_cse;
  assign buf2_rsci_d_d = MUX_v_12_2_2(temp_11_0_1_sva_1, temp_11_0_sva_1, fsm_output[32]);
  assign or_379_nl = or_dcpl_4 | (fsm_output[15]) | or_dcpl_94;
  assign for_2_for_for_for_for_2_for_for_for_mux_2_nl = MUX_v_12_2_2(i_11_12_0_sva_1_11_0,
      i_10_12_0_sva_11_0, or_379_nl);
  assign buf2_rsci_radr_d = {out_c_3_3_0_sva_2_0 , for_2_for_for_for_for_2_for_for_for_mux_2_nl};
  assign buf2_rsci_re_d_pff = ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_or_3_cse
      | (ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp & (or_dcpl_4
      | for_1_for_for_or_3_cse));
  assign for_2_for_for_for_mux_6_nl = MUX_v_3_2_2(out_c_2_3_0_sva_2_0, out_c_3_3_0_sva_2_0,
      fsm_output[32]);
  assign nl_for_2_for_for_for_acc_nl = conv_s2u_7_9({(~ (i_3_6_0_sva[6])) , (i_3_6_0_sva[5:0])})
      + ({for_2_for_for_for_mux_6_nl , 6'b111111});
  assign for_2_for_for_for_acc_nl = nl_for_2_for_for_for_acc_nl[8:0];
  assign buf2_rsci_wadr_d = {for_2_for_for_for_acc_nl , (z_out_7[5:0])};
  assign buf2_rsci_we_d_pff = or_tmp_64;
  assign enc1_rsci_d_d = MUX_v_12_2_2(12'b000000000000, (for_6_for_2_acc_9_psp_1_sva[11:0]),
      z_out_8_32);
  assign enc1_rsci_radr_d = {out_c_3_3_0_sva_2_0 , ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_and_itm
      , ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_qr_0_lpi_3_dfm ,
      ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_1_itm_4_0
      , for_2_for_for_for_for_for_stage_0_2};
  assign enc1_rsci_re_d_pff = ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp
      & (fsm_output[51]);
  assign enc1_rsci_wadr_d = {out_c_3_3_0_sva_2_0 , i_10_12_0_sva_11_0};
  assign enc1_rsci_we_d_pff = fsm_output[48];
  assign operator_22_0_false_AC_TRN_AC_WRAP_mux_cse = MUX_v_9_2_2(reg_var_tmp_33_6_1_1_ftd,
      reg_var_tmp_33_6_1_ftd, fsm_output[39]);
  assign nl_for_5_for_for_for_for_for_acc_15_sdt = ({for_5_for_for_for_for_for_acc_7_sdt_sva_1_9_6
      , (for_5_for_for_for_for_for_acc_7_sdt_sva_1_5_2[3:1])}) + 7'b0011011;
  assign for_5_for_for_for_for_for_acc_15_sdt = nl_for_5_for_for_for_for_for_acc_15_sdt[6:0];
  assign or_601_itm = (fsm_output[30]) | (fsm_output[27]);
  always @(posedge clk) begin
    if ( rst ) begin
      output_rsci_idat <= 12'b000000000000;
    end
    else if ( run_wen & (fsm_output[58]) ) begin
      output_rsci_idat <= buf1_rsci_q_d;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      i_1_13_0_sva <= 14'b00000000000000;
      for_3_for_2_div_cmp_b_13_11 <= 3'b000;
      for_3_for_2_div_cmp_b_10_0 <= 11'b00000000000;
      for_3_for_2_div_cmp_a_18_6 <= 13'b0000000000000;
      reg_output_rsci_iswt0_cse <= 1'b0;
      reg_input_rsci_iswt0_cse <= 1'b0;
      ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_qr_0_lpi_3_dfm <=
          1'b0;
      for_1_for_for_stage_0_2 <= 1'b0;
      reg_for_1_for_for_acc_1_itm_1_cse <= 14'b00000000000000;
      reg_j_2_ftd <= 1'b0;
      y_asn_1_itm_3 <= 1'b0;
      temp_11_0_1_lpi_7 <= 12'b000000000000;
      y_1_1_0_sva_0 <= 1'b0;
      y_1_1_0_sva_1 <= 1'b0;
      for_2_for_for_for_for_for_stage_0_2 <= 1'b0;
      for_2_for_for_for_for_for_stage_0_3 <= 1'b0;
      for_2_for_for_for_for_for_stage_0_4 <= 1'b0;
      for_2_for_for_for_for_for_acc_itm_1_13_6 <= 8'b00000000;
      reg_for_2_for_for_for_for_for_mul_itm_1_cse <= 2'b00;
      y_asn_1_itm_2 <= 1'b0;
      for_2_for_for_for_for_for_acc_7_itm_1_7_0 <= 8'b00000000;
      ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_and_itm
          <= 5'b00000;
      for_7_for_for_for_for_land_lpi_6_dfm_st_1 <= 1'b0;
      ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_1_itm_9_5
          <= 5'b00000;
      ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_1_itm_4_0
          <= 5'b00000;
      for_2_for_for_for_slc_for_2_for_for_for_acc_6_itm <= 1'b0;
      for_3_for_2_asn_itm_18_13 <= 6'b000000;
      ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_24_12_sva
          <= 13'b0000000000000;
      reg_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_qr_cse
          <= 14'b00000000000000;
      for_3_for_2_acc_9_psp_1_sva <= 19'b0000000000000000000;
      for_3_for_2_mul_1_psp_1_sva_5_0 <= 6'b000000;
      temp_11_0_lpi_7 <= 12'b000000000000;
      for_5_for_for_for_for_for_acc_25_itm_1_13_6 <= 8'b00000000;
      for_5_for_for_for_for_for_mul_itm_1_8_6 <= 3'b000;
      for_5_for_for_for_for_for_mul_itm_1_2_0 <= 3'b000;
      for_5_for_for_for_for_for_acc_7_sdt_sva_1_9_6 <= 4'b0000;
      for_5_for_for_for_for_for_acc_7_sdt_sva_1_5_2 <= 4'b0000;
      for_6_for_2_acc_9_psp_1_sva <= 19'b0000000000000000000;
      for_6_for_2_mul_1_psp_1_sva_5_0 <= 6'b000000;
    end
    else if ( run_wen ) begin
      i_1_13_0_sva <= MUX_v_14_2_2(14'b00000000000000, i_i_mux_1_nl, nor_63_nl);
      for_3_for_2_div_cmp_b_13_11 <= MUX_v_3_2_2((ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_and_itm_mx0w0[13:11]),
          ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mul_psp_sva_13_11,
          or_329_ssc);
      for_3_for_2_div_cmp_b_10_0 <= MUX_v_11_2_2((ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_and_itm_mx0w0[10:0]),
          ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mul_psp_sva_10_0,
          or_329_ssc);
      for_3_for_2_div_cmp_a_18_6 <= for_3_for_2_asn_itm_12_0;
      reg_output_rsci_iswt0_cse <= fsm_output[58];
      reg_input_rsci_iswt0_cse <= ~((~((fsm_output[0]) | (fsm_output[2]))) | ((~
          ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_qr_0_lpi_3_dfm)
          & (fsm_output[2])));
      ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_qr_0_lpi_3_dfm <=
          (operator_20_false_mux1h_nl & (~ (fsm_output[31])) & (~((fsm_output[55:54]!=2'b00)
          | or_dcpl_151))) | or_tmp_134 | ((~((fsm_output[58]) | (fsm_output[1])
          | (fsm_output[54]))) & (~((fsm_output[31]) | (fsm_output[55]))) & (~((fsm_output[56])
          | (fsm_output[33]) | (fsm_output[35]))) & (~((fsm_output[34]) | (fsm_output[57])))
          & (~((fsm_output[16]) | (fsm_output[40]) | (fsm_output[36]))) & (~((fsm_output[29])
          | (fsm_output[51]))) & (~((fsm_output[30]) | (fsm_output[15]))) & (~((fsm_output[39])
          | (fsm_output[50]))));
      for_1_for_for_stage_0_2 <= (for_1_for_for_mux_8_nl | or_dcpl_170 | or_dcpl_163
          | (fsm_output[13]) | (fsm_output[37]) | (fsm_output[51]) | and_409_cse
          | and_410_cse | ((~ (out_c_2_3_0_sva_2[3])) & (fsm_output[12])) | ((~ (out_c_3_3_0_sva_2[3]))
          & (fsm_output[36]))) & (~(or_dcpl_159 | or_dcpl_157 | (fsm_output[52])
          | (fsm_output[2]) | (fsm_output[26]) | (fsm_output[50]) | and_399_cse |
          and_400_cse | ((out_c_2_3_0_sva_2[3]) & (fsm_output[12])) | ((out_c_3_3_0_sva_2[3])
          & (fsm_output[36]))));
      reg_for_1_for_for_acc_1_itm_1_cse <= nl_reg_for_1_for_for_acc_1_itm_1_cse[13:0];
      reg_j_2_ftd <= j_j_mux_nl & (~ or_481_itm);
      y_asn_1_itm_3 <= y_asn_1_itm_2;
      temp_11_0_1_lpi_7 <= MUX_v_12_2_2(12'b000000000000, temp_temp_mux1h_nl, nor_66_nl);
      y_1_1_0_sva_0 <= y_mux_nl | (~ for_1_for_for_or_1_cse);
      y_1_1_0_sva_1 <= ~((~(y_1_1_0_sva_1 & (~ for_1_for_for_stage_0_2))) & for_1_for_for_or_1_cse);
      for_2_for_for_for_for_for_stage_0_2 <= (for_1_for_for_mux_9_nl | (fsm_output[51]))
          & (~((fsm_output[54]) | (fsm_output[11]) | (fsm_output[10]) | or_dcpl_216
          | or_dcpl_157 | (fsm_output[33]) | or_dcpl_239 | (fsm_output[34]) | (fsm_output[52])
          | (fsm_output[13]) | (fsm_output[37]) | (fsm_output[36]) | or_dcpl_231
          | or_dcpl_173));
      for_2_for_for_for_for_for_stage_0_3 <= for_2_for_for_for_for_for_stage_0_2
          & ((fsm_output[6]) | (fsm_output[51]) | (fsm_output[30]) | for_1_for_for_or_3_cse);
      for_2_for_for_for_for_for_stage_0_4 <= for_1_for_for_mux1h_44_nl & (~(or_dcpl_170
          | or_dcpl_163 | (fsm_output[36]) | or_dcpl_232));
      for_2_for_for_for_for_for_acc_itm_1_13_6 <= nl_for_2_for_for_for_for_for_acc_itm_1_13_6[7:0];
      reg_for_2_for_for_for_for_for_mul_itm_1_cse <= z_out_12[11:10];
      y_asn_1_itm_2 <= for_7_for_for_for_for_land_lpi_6_dfm_st_1;
      for_2_for_for_for_for_for_acc_7_itm_1_7_0 <= nl_for_2_for_for_for_for_for_acc_7_itm_1_7_0[7:0];
      ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_and_itm
          <= MUX_v_5_2_2(5'b00000, ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_mux1h_16_nl,
          nor_69_nl);
      for_7_for_for_for_for_land_lpi_6_dfm_st_1 <= MUX1HOT_s_1_3_2(for_5_for_for_for_for_for_xor_cse,
          for_2_for_for_for_for_for_stage_0_4, for_7_for_for_for_for_land_lpi_6_dfm_st_1_mx0w4,
          {for_1_for_for_or_1_cse , for_1_for_for_or_3_cse , (fsm_output[51])});
      ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_1_itm_9_5
          <= z_out_2[9:5];
      ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_1_itm_4_0
          <= MUX1HOT_v_5_3_2(for_2_for_for_for_for_for_asn_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_1_itm_1_4_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_and_nl,
          (z_out_2[4:0]), ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_and_itm,
          {nor_71_nl , ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_or_3_cse
          , for_1_for_for_or_1_cse});
      for_2_for_for_for_slc_for_2_for_for_for_acc_6_itm <= readslicef_7_1_6(for_2_for_for_for_acc_13_nl);
      for_3_for_2_asn_itm_18_13 <= for_3_for_2_div_cmp_z[18:13];
      ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_24_12_sva
          <= nl_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_24_12_sva[12:0];
      reg_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_qr_cse
          <= z_out_10[31:18];
      for_3_for_2_acc_9_psp_1_sva <= nl_for_3_for_2_acc_9_psp_1_sva[18:0];
      for_3_for_2_mul_1_psp_1_sva_5_0 <= for_3_for_2_mul_1_psp_1_sva_2[5:0];
      temp_11_0_lpi_7 <= MUX_v_12_2_2(12'b000000000000, temp_temp_mux1h_1_nl, not_220_nl);
      for_5_for_for_for_for_for_acc_25_itm_1_13_6 <= nl_for_5_for_for_for_for_for_acc_25_itm_1_13_6[7:0];
      for_5_for_for_for_for_for_mul_itm_1_8_6 <= z_out_12[8:6];
      for_5_for_for_for_for_for_mul_itm_1_2_0 <= z_out_12[2:0];
      for_5_for_for_for_for_for_acc_7_sdt_sva_1_9_6 <= nl_for_5_for_for_for_for_for_acc_7_sdt_sva_1_9_6[3:0];
      for_5_for_for_for_for_for_acc_7_sdt_sva_1_5_2 <= for_5_for_for_for_for_for_acc_sdt_1[3:0];
      for_6_for_2_acc_9_psp_1_sva <= nl_for_6_for_2_acc_9_psp_1_sva[18:0];
      for_6_for_2_mul_1_psp_1_sva_5_0 <= for_6_for_2_mul_1_psp_1_sva_1[5:0];
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp <= 1'b0;
    end
    else if ( run_wen & (ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp_mx0c0
        | (fsm_output[3]) | (fsm_output[6]) | ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp_mx0c3
        | (fsm_output[14]) | (fsm_output[15]) | (fsm_output[27]) | (fsm_output[30])
        | (fsm_output[38]) | (fsm_output[39]) | (fsm_output[51])) ) begin
      ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp <= ~((~(for_1_for_for_mux1h_42_nl
          | ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp_mx0c0))
          | ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp_mx0c3);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_itm
          <= 6'b000000;
    end
    else if ( run_wen & (ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_itm_mx0c0
        | ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_itm_mx0c1
        | (fsm_output[6]) | (fsm_output[15]) | (fsm_output[30]) | (fsm_output[39]))
        ) begin
      ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_itm
          <= MUX_v_6_2_2(6'b000000, ({ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux1h_6_nl
          , ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux1h_25_nl}),
          ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_not_nl);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      in_c_1_1_0_sva <= 2'b00;
    end
    else if ( run_wen & (in_c_1_1_0_sva_mx0c0 | (fsm_output[11]) | and_400_cse |
        (fsm_output[30])) ) begin
      in_c_1_1_0_sva <= MUX_v_2_2_2(2'b00, in_c_mux_nl, in_c_not_nl);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      reg_j_2_ftd_1 <= 6'b000000;
    end
    else if ( run_wen & (~ or_480_itm) ) begin
      reg_j_2_ftd_1 <= MUX1HOT_v_6_3_2(for_1_for_for_1_for_and_nl, (z_out_3[5:0]),
          6'b000001, {or_478_nl , or_tmp_64 , or_481_itm});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      temp_11_0_1_sva_1 <= 12'b000000000000;
    end
    else if ( run_wen & (~ (fsm_output[7])) & for_2_for_for_for_for_for_stage_0_4
        ) begin
      temp_11_0_1_sva_1 <= temp_11_0_1_sva_1_mx1w0;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      out_c_2_3_0_sva_2_0 <= 3'b000;
    end
    else if ( run_wen & (and_409_cse | or_dcpl_228 | (fsm_output[5]) | out_c_2_3_0_sva_2_0_mx0c1)
        ) begin
      out_c_2_3_0_sva_2_0 <= MUX_v_3_2_2(3'b000, (out_c_2_3_0_sva_2[2:0]), out_c_2_3_0_sva_2_0_mx0c1);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      i_3_6_0_sva <= 7'b0000000;
    end
    else if ( run_wen & (i_3_6_0_sva_mx0c0 | i_3_6_0_sva_mx0c1 | (fsm_output[39]))
        ) begin
      i_3_6_0_sva <= MUX1HOT_v_7_4_2(7'b0000001, i_3_6_0_sva_2, 7'b1000000, 7'b0111111,
          {i_3_6_0_sva_mx0c0 , i_3_6_0_sva_mx0c1 , j_and_nl , j_or_1_nl});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      reg_x_1_sva_1_0_ftd <= 1'b0;
      reg_x_1_sva_1_0_ftd_1 <= 1'b0;
    end
    else if ( x_and_ssc ) begin
      reg_x_1_sva_1_0_ftd <= x_1_sva_1_0_mx0c0;
      reg_x_1_sva_1_0_ftd_1 <= (~ reg_x_1_sva_1_0_ftd_1) | x_1_sva_1_0_mx0c0;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      i_10_12_0_sva_11_0 <= 12'b000000000000;
    end
    else if ( run_wen & (for_1_for_for_or_1_cse | i_10_12_0_sva_11_0_mx0c1 | (fsm_output[13])
        | i_10_12_0_sva_11_0_mx0c3 | (fsm_output[37]) | (fsm_output[38]) | (fsm_output[51]))
        ) begin
      i_10_12_0_sva_11_0 <= MUX_v_12_2_2(12'b000000000000, i_mux1h_19_nl, nor_70_nl);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      var_tmp_33_6_1_sva <= 28'b0000000000000000000000000000;
    end
    else if ( run_wen & (or_dcpl_122 | (fsm_output[14])) ) begin
      var_tmp_33_6_1_sva <= MUX_v_28_2_2(28'b0000000000000000000000000000, var_tmp_mux_nl,
          (fsm_output[14]));
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      out_c_3_3_0_sva_2_0 <= 3'b000;
    end
    else if ( run_wen & (or_dcpl_231 | ((out_c_3_3_0_sva_2[3]) & or_dcpl_278) | out_c_3_3_0_sva_2_0_mx0c1)
        ) begin
      out_c_3_3_0_sva_2_0 <= MUX_v_3_2_2(3'b000, (out_c_3_3_0_sva_2[2:0]), out_c_3_3_0_sva_2_0_mx0c1);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      for_3_for_2_asn_itm_12_0 <= 13'b0000000000000;
    end
    else if ( run_wen & (~(or_dcpl_115 | (fsm_output[20]) | (fsm_output[44]) | or_dcpl_109
        | (fsm_output[18]) | (fsm_output[42]))) ) begin
      for_3_for_2_asn_itm_12_0 <= MUX_v_13_2_2(for_3_for_1_acc_4_nl, (for_3_for_2_div_cmp_z[12:0]),
          or_544_nl);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      i_11_12_0_sva_1_12 <= 1'b0;
      i_11_12_0_sva_1_11_0 <= 12'b000000000000;
    end
    else if ( i_and_2_ssc ) begin
      i_11_12_0_sva_1_12 <= z_out_4[12];
      i_11_12_0_sva_1_11_0 <= MUX_v_12_2_2(for_2_for_for_for_for_2_for_for_for_and_1_nl,
          (z_out_4[11:0]), ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_or_3_cse);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mul_psp_sva_13_11
          <= 3'b000;
      ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mul_psp_sva_10_0
          <= 11'b00000000000;
    end
    else if ( ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_and_2_cse
        ) begin
      ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mul_psp_sva_13_11
          <= MUX_v_3_2_2((z_out_9[20:18]), (ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_and_itm_mx0w0[13:11]),
          ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_normalized_fixed_temp_or_cse);
      ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mul_psp_sva_10_0
          <= MUX1HOT_v_11_3_2((z_out_9[17:7]), (ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_and_itm_mx0w0[10:0]),
          (z_out_11[10:0]), {ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_nor_nl
          , ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_normalized_fixed_temp_or_cse
          , or_203_cse});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      temp_11_0_sva_1 <= 12'b000000000000;
    end
    else if ( run_wen & (~ (fsm_output[31])) & for_2_for_for_for_for_for_stage_0_4
        ) begin
      temp_11_0_sva_1 <= temp_11_0_sva_1_mx1w0;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      var_tmp_33_6_sva <= 28'b0000000000000000000000000000;
    end
    else if ( run_wen & ((fsm_output[38]) | or_dcpl_278) ) begin
      var_tmp_33_6_sva <= MUX_v_28_2_2(28'b0000000000000000000000000000, var_tmp_mux_3_nl,
          (fsm_output[38]));
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      reg_var_tmp_33_6_1_1_ftd <= 9'b000000000;
    end
    else if ( run_wen & for_2_for_for_for_for_for_stage_0_3 & (~(or_dcpl_115 | (fsm_output[20])
        | (fsm_output[23]) | (fsm_output[22]) | (fsm_output[21]) | (fsm_output[25])
        | (fsm_output[18]) | (fsm_output[24]) | (fsm_output[16]) | (fsm_output[15])))
        ) begin
      reg_var_tmp_33_6_1_1_ftd <= var_tmp_33_6_1_sva_1_mx1w0[27:19];
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      reg_var_tmp_33_6_1_ftd <= 9'b000000000;
    end
    else if ( run_wen & for_2_for_for_for_for_for_stage_0_3 & (~((fsm_output[44])
        | (fsm_output[41]) | (fsm_output[43]) | or_dcpl_108 | (fsm_output[47]) |
        (fsm_output[45]) | (fsm_output[48]) | (fsm_output[42]) | (fsm_output[40])
        | (fsm_output[39]))) ) begin
      reg_var_tmp_33_6_1_ftd <= var_tmp_33_6_sva_1_mx1w0[27:19];
    end
  end
  assign or_325_nl = or_dcpl_115 | (fsm_output[20]) | (fsm_output[23]) | (fsm_output[22])
      | (fsm_output[21]) | (fsm_output[44]) | or_dcpl_109 | or_dcpl_108 | (fsm_output[47])
      | (fsm_output[45]) | (fsm_output[25]) | (fsm_output[59]) | (fsm_output[48])
      | (fsm_output[58]) | (fsm_output[18]) | (fsm_output[42]) | (fsm_output[24])
      | (fsm_output[16]) | (fsm_output[40]) | (fsm_output[2]) | (fsm_output[15])
      | or_dcpl_94 | (fsm_output[14]) | ((~((~(ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp
      & for_2_for_for_for_for_for_stage_0_4)) & for_1_for_for_stage_0_2)) & or_dcpl_4);
  assign i_i_mux_1_nl = MUX_v_14_2_2(z_out_14, i_1_13_0_sva, or_325_nl);
  assign nor_63_nl = ~((fsm_output[0]) | (fsm_output[56]) | (fsm_output[36]) | or_dcpl_122
      | (fsm_output[50]));
  assign nl_operator_20_false_acc_1_nl = ({1'b1 , (z_out_14[13:12])}) + 3'b001;
  assign operator_20_false_acc_1_nl = nl_operator_20_false_acc_1_nl[2:0];
  assign ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_and_1_nl
      = (~ (rtn_out[0])) & or_79_cse;
  assign ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_and_1_nl
      = (~ (rtn_out[0])) & or_cse;
  assign or_442_nl = (fsm_output[58]) | (fsm_output[16]) | (fsm_output[40]) | (fsm_output[51])
      | (fsm_output[30]);
  assign operator_20_false_mux1h_nl = MUX1HOT_s_1_4_2((readslicef_3_1_2(operator_20_false_acc_1_nl)),
      ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_and_1_nl,
      ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_qr_0_lpi_3_dfm, ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_and_1_nl,
      {or_324_cse , (fsm_output[15]) , or_442_nl , (fsm_output[39])});
  assign for_1_for_for_mux_8_nl = MUX_s_1_2_2(ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp,
      for_1_for_for_stage_0_2_mx0w2, for_1_for_for_or_1_cse);
  assign nl_for_1_for_for_acc_17_nl = conv_u2u_6_7(ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_itm)
      + conv_u2u_2_7(for_1_for_for_acc_14_psp_1[6:5]);
  assign for_1_for_for_acc_17_nl = nl_for_1_for_for_acc_17_nl[6:0];
  assign nl_reg_for_1_for_for_acc_1_itm_1_cse  = ({z_out_12 , 2'b11}) + conv_u2u_13_14({for_1_for_for_acc_17_nl
      , (for_1_for_for_acc_14_psp_1[4:0]) , (reg_j_2_ftd_1[0])});
  assign j_j_mux_nl = MUX_s_1_2_2((z_out_3[6]), reg_j_2_ftd, or_480_itm);
  assign temp_temp_nor_nl = ~(or_242_cse | (fsm_output[7]));
  assign temp_and_3_nl = or_242_cse & (~ (fsm_output[7]));
  assign temp_temp_mux1h_nl = MUX1HOT_v_12_3_2(temp_11_0_1_sva_1_mx1w0, temp_11_0_1_lpi_7,
      temp_11_0_1_sva_1, {temp_temp_nor_nl , temp_and_3_nl , (fsm_output[7])});
  assign nor_66_nl = ~(or_dcpl_168 | (fsm_output[9]) | or_dcpl_223);
  assign y_mux_nl = MUX_s_1_2_2(y_1_1_0_sva_0, (~ y_1_1_0_sva_0), for_1_for_for_stage_0_2);
  assign for_1_for_for_mux_9_nl = MUX_s_1_2_2(for_1_for_for_stage_0_2, ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp,
      for_1_for_for_or_3_cse);
  assign or_510_nl = or_dcpl_4 | (fsm_output[38]);
  assign for_1_for_for_mux1h_44_nl = MUX1HOT_s_1_4_2(for_2_for_for_for_for_for_stage_0_3,
      (z_out_4[12]), (z_out_4[12]), for_7_for_for_for_for_land_lpi_6_dfm_st_1_mx0w4,
      {for_1_for_for_or_1_cse , or_510_nl , (fsm_output[14]) , (fsm_output[51])});
  assign nl_for_2_for_for_for_for_for_acc_28_nl = conv_s2s_3_4(for_2_for_for_for_for_for_acc_17_sdt_1_8_1[7:5])
      + conv_s2s_2_4({reg_x_1_sva_1_0_ftd , reg_x_1_sva_1_0_ftd_1});
  assign for_2_for_for_for_for_for_acc_28_nl = nl_for_2_for_for_for_for_for_acc_28_nl[3:0];
  assign nl_for_2_for_for_for_for_for_acc_itm_1_13_6  = conv_s2u_4_8(for_2_for_for_for_for_for_acc_28_nl)
      + conv_u2u_7_8(i_3_6_0_sva);
  assign nl_for_2_for_for_for_for_for_acc_27_nl = conv_s2s_2_4(for_2_for_for_for_for_for_acc_21_sdt_3_0_1[3:2])
      + conv_u2s_3_4({in_c_1_1_0_sva , 1'b1});
  assign for_2_for_for_for_for_for_acc_27_nl = nl_for_2_for_for_for_for_for_acc_27_nl[3:0];
  assign for_2_for_for_for_for_for_mul_7_nl = out_c_2_3_0_sva_2_0 * 5'b11011;
  assign nl_for_2_for_for_for_for_for_acc_7_itm_1_7_0  = conv_s2s_6_8({for_2_for_for_for_for_for_acc_27_nl
      , (for_2_for_for_for_for_for_acc_21_sdt_3_0_1[1:0])}) + for_2_for_for_for_for_for_mul_7_nl;
  assign nl_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_qif_acc_nl = ({1'b1
      , (~ (rtn_out[4:1]))}) + 5'b01001;
  assign ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_qif_acc_nl = nl_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_qif_acc_nl[4:0];
  assign nl_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_qif_acc_nl =
      ({1'b1 , (~ (rtn_out[4:1]))}) + 5'b01001;
  assign ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_qif_acc_nl = nl_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_qif_acc_nl[4:0];
  assign or_515_nl = (fsm_output[54]) | (fsm_output[16]) | (fsm_output[40]) | (fsm_output[52])
      | (fsm_output[51]) | (fsm_output[53]);
  assign ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_mux1h_16_nl = MUX1HOT_v_5_5_2(data_out_out,
      ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_expret_qif_acc_nl, ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_and_itm,
      ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_qif_acc_nl, (i_12_5_0_sva_2[4:0]),
      {for_1_for_for_or_1_cse , (fsm_output[15]) , or_515_nl , (fsm_output[39]) ,
      (fsm_output[55])});
  assign nor_69_nl = ~(or_dcpl_151 | ((~ or_79_cse) & (fsm_output[15])) | ((~ or_cse)
      & (fsm_output[39])));
  assign ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_mux_nl
      = MUX_v_5_2_2(ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_1_itm_4_0,
      (reg_j_2_ftd_1[4:0]), fsm_output[54]);
  assign nand_17_nl = ~((~((fsm_output[54]) | (fsm_output[6]))) & (~((fsm_output[52:51]!=2'b00))));
  assign for_2_for_for_for_for_for_asn_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_1_itm_1_4_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_and_nl
      = MUX_v_5_2_2(5'b00000, ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_mux_nl,
      nand_17_nl);
  assign nor_71_nl = ~(ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_or_3_cse
      | for_1_for_for_or_1_cse);
  assign nl_for_2_for_for_for_acc_13_nl = (z_out_3[6:0]) + 7'b0111111;
  assign for_2_for_for_for_acc_13_nl = nl_for_2_for_for_for_acc_13_nl[6:0];
  assign nl_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_24_12_sva
      = conv_u2u_9_13(z_out_11[19:11]) + conv_u2u_12_13({1'b1 , ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_1_itm_9_5
      , ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_1_itm_4_0
      , 1'b1});
  assign for_3_for_2_or_1_nl = (~((out_c_3_3_0_sva_2_0!=3'b000))) | for_3_for_2_and_cse_1
      | for_3_for_2_and_2_cse_1 | for_3_for_2_and_3_cse_1;
  assign nl_for_3_for_2_acc_9_psp_1_sva  = (for_3_for_2_mul_1_psp_1_sva_2[24:6])
      + conv_s2s_1_19(for_3_for_2_or_1_nl);
  assign temp_temp_nor_1_nl = ~(or_242_cse | (fsm_output[31]));
  assign temp_and_5_nl = or_242_cse & (~ (fsm_output[31]));
  assign temp_temp_mux1h_1_nl = MUX1HOT_v_12_3_2(temp_11_0_sva_1_mx1w0, temp_11_0_lpi_7,
      temp_11_0_sva_1, {temp_temp_nor_1_nl , temp_and_5_nl , (fsm_output[31])});
  assign not_220_nl = ~ or_tmp_134;
  assign nl_for_5_for_for_for_for_for_acc_37_nl = conv_s2s_1_2(for_5_for_for_for_for_for_acc_23_sdt_1[8])
      + conv_u2s_1_2(~ ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_qr_0_lpi_3_dfm);
  assign for_5_for_for_for_for_for_acc_37_nl = nl_for_5_for_for_for_for_for_acc_37_nl[1:0];
  assign nl_for_5_for_for_for_for_for_acc_36_nl = ({for_5_for_for_for_for_for_acc_37_nl
      , (for_5_for_for_for_for_for_acc_23_sdt_1[7:6])}) + conv_s2s_3_4({1'b1 , reg_x_1_sva_1_0_ftd
      , reg_x_1_sva_1_0_ftd_1});
  assign for_5_for_for_for_for_for_acc_36_nl = nl_for_5_for_for_for_for_for_acc_36_nl[3:0];
  assign nl_for_5_for_for_for_for_for_acc_25_itm_1_13_6  = conv_s2u_4_8(for_5_for_for_for_for_for_acc_36_nl)
      + conv_u2u_7_8(i_3_6_0_sva);
  assign nl_for_5_for_for_for_for_for_acc_7_sdt_sva_1_9_6  = conv_s2u_2_4(for_5_for_for_for_for_for_acc_sdt_1[5:4])
      + conv_u2u_3_4(out_c_3_3_0_sva_2_0);
  assign nl_for_6_for_2_acc_9_psp_1_sva  = (for_6_for_2_mul_1_psp_1_sva_1[24:6])
      + conv_s2s_1_19(for_3_for_2_and_3_cse_1);
  assign ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_and_1_nl
      = ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp & (~
      (z_out_7[6]));
  assign ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_and_2_nl
      = ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp & (~
      (z_out_4[12]));
  assign ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_and_4_nl
      = ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp & (~
      for_2_for_for_for_for_for_stage_0_2);
  assign for_1_for_for_mux1h_42_nl = MUX1HOT_s_1_6_2(ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_and_1_nl,
      for_1_for_for_stage_0_2_mx0w2, ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_and_2_nl,
      or_79_cse, or_cse, ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_and_4_nl,
      {for_1_for_for_or_cse , for_1_for_for_or_1_cse , for_1_for_for_or_3_cse , (fsm_output[15])
      , (fsm_output[39]) , (fsm_output[51])});
  assign ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux1h_6_nl
      = MUX1HOT_v_5_4_2((i_2_6_0_sva_2[5:1]), (for_2_for_for_for_for_for_acc_17_sdt_1_8_1[4:0]),
      (z_out_1[5:1]), (for_5_for_for_for_for_for_acc_23_sdt_1[5:1]), {ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_itm_mx0c1
      , (fsm_output[6]) , ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_or_3_cse
      , (fsm_output[30])});
  assign ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux1h_25_nl
      = MUX1HOT_s_1_4_2((i_2_6_0_sva_2[0]), (z_out_3[0]), (z_out_1[0]), (for_5_for_for_for_for_for_acc_23_sdt_1[0]),
      {ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_itm_mx0c1
      , (fsm_output[6]) , ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_or_3_cse
      , (fsm_output[30])});
  assign ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_not_nl
      = ~ ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_itm_mx0c0;
  assign in_c_mux_nl = MUX_v_2_2_2(out_c_1_1_0_sva_2, (for_5_for_for_for_for_for_acc_19_sdt_1[1:0]),
      fsm_output[30]);
  assign in_c_not_nl = ~ in_c_1_1_0_sva_mx0c0;
  assign nl_for_7_for_for_acc_3_nl = conv_u2u_5_6(ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_1_itm_4_0)
      + 6'b000001;
  assign for_7_for_for_acc_3_nl = nl_for_7_for_for_acc_3_nl[5:0];
  assign for_1_for_mux_nl = MUX_v_6_2_2((z_out_7[5:0]), for_7_for_for_acc_3_nl, fsm_output[53]);
  assign j_or_nl = (fsm_output[3]) | (fsm_output[27]) | (fsm_output[53]);
  assign for_1_for_for_1_for_and_nl = MUX_v_6_2_2(6'b000000, for_1_for_mux_nl, j_or_nl);
  assign or_478_nl = (fsm_output[3]) | (fsm_output[28]) | (fsm_output[27]) | (fsm_output[4])
      | (fsm_output[53]) | (fsm_output[2]) | (fsm_output[26]) | and_399_cse | and_400_cse;
  assign j_and_nl = j_j_nor_cse & (fsm_output[39]);
  assign j_or_1_nl = ((out_c_3_3_0_sva_2_0[1:0]==2'b01) & (fsm_output[39])) | ((out_c_3_3_0_sva_2_0[1:0]==2'b10)
      & (fsm_output[39])) | ((out_c_3_3_0_sva_2_0[1:0]==2'b11) & (fsm_output[39]));
  assign i_or_8_nl = (fsm_output[13]) | i_or_7_cse;
  assign i_and_4_nl = (~ or_288_tmp) & (fsm_output[51]);
  assign i_and_5_nl = or_288_tmp & (fsm_output[51]);
  assign i_mux1h_19_nl = MUX1HOT_v_12_5_2(padded_input_rsci_q_d, (z_out_4[11:0]),
      i_11_12_0_sva_1_11_0, enc1_rsci_q_d, i_10_12_0_sva_11_0, {for_1_for_for_or_1_cse
      , i_or_8_nl , i_10_12_0_sva_11_0_mx0c3 , i_and_4_nl , i_and_5_nl});
  assign nor_70_nl = ~(i_10_12_0_sva_11_0_mx0c1 | ((~ ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_1_expret_unequal_tmp)
      & i_or_7_cse));
  assign var_tmp_mux_nl = MUX_v_28_2_2(var_tmp_33_6_1_sva_1_mx1w0, var_tmp_33_6_1_sva,
      or_dcpl_277);
  assign nl_for_3_for_1_acc_4_nl = conv_s2s_12_13(buf2_rsci_q_d) + conv_s2s_3_13({1'b1
      , (~ (i_1_13_0_sva[13:12]))}) + 13'b0000000000001;
  assign for_3_for_1_acc_4_nl = nl_for_3_for_1_acc_4_nl[12:0];
  assign or_544_nl = (fsm_output[22]) | (fsm_output[46]);
  assign for_2_for_for_for_for_2_for_for_for_and_1_nl = MUX_v_12_2_2(12'b000000000000,
      (z_out_4[11:0]), (fsm_output[14]));
  assign ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_nor_nl
      = ~(ac_math_ac_normalize_22_17_false_AC_TRN_AC_WRAP_normalized_fixed_temp_or_cse
      | or_203_cse);
  assign var_tmp_mux_3_nl = MUX_v_28_2_2(var_tmp_33_6_sva_1_mx1w0, var_tmp_33_6_sva,
      or_dcpl_277);
  assign for_2_for_for_for_for_2_for_for_for_and_4_nl = ((reg_x_1_sva_1_0_ftd_1 &
      y_1_1_0_sva_1) ^ reg_x_1_sva_1_0_ftd ^ y_1_1_0_sva_1) & (fsm_output[6]);
  assign for_2_for_for_for_for_2_for_for_for_and_5_nl = (reg_x_1_sva_1_0_ftd_1 ^
      y_1_1_0_sva_1) & (fsm_output[6]);
  assign for_2_for_for_for_for_2_for_for_for_or_1_nl = y_1_1_0_sva_0 | (~ (fsm_output[6]));
  assign nl_z_out_3 = conv_u2u_7_8({reg_j_2_ftd , reg_j_2_ftd_1}) + conv_s2u_3_8({for_2_for_for_for_for_2_for_for_for_and_4_nl
      , for_2_for_for_for_for_2_for_for_for_and_5_nl , for_2_for_for_for_for_2_for_for_for_or_1_nl});
  assign z_out_3 = nl_z_out_3[7:0];
  assign for_3_for_mux_3_nl = MUX_v_12_2_2(i_10_12_0_sva_11_0, i_11_12_0_sva_1_11_0,
      fsm_output[14]);
  assign nl_z_out_4 = conv_u2u_12_13(for_3_for_mux_3_nl) + 13'b0000000000001;
  assign z_out_4 = nl_z_out_4[12:0];
  assign nl_z_out_7 = conv_u2u_6_7(reg_j_2_ftd_1) + conv_s2u_2_7({or_tmp_64 , 1'b1});
  assign z_out_7 = nl_z_out_7[6:0];
  assign operator_40_20_false_AC_TRN_AC_WRAP_mux_4_nl = MUX_v_19_2_2((~ for_3_for_2_acc_9_psp_1_sva),
      (~ for_6_for_2_acc_9_psp_1_sva), fsm_output[48]);
  assign operator_40_20_false_AC_TRN_AC_WRAP_mux_5_nl = MUX_v_6_2_2((~ for_3_for_2_mul_1_psp_1_sva_5_0),
      (~ for_6_for_2_mul_1_psp_1_sva_5_0), fsm_output[48]);
  assign nl_operator_40_20_false_AC_TRN_AC_WRAP_acc_nl = ({1'b1 , (signext_26_19(operator_40_20_false_AC_TRN_AC_WRAP_mux_4_nl))
      , operator_40_20_false_AC_TRN_AC_WRAP_mux_5_nl}) + 33'b000000000000000000000000000000001;
  assign operator_40_20_false_AC_TRN_AC_WRAP_acc_nl = nl_operator_40_20_false_AC_TRN_AC_WRAP_acc_nl[32:0];
  assign z_out_8_32 = readslicef_33_1_32(operator_40_20_false_AC_TRN_AC_WRAP_acc_nl);
  assign ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux_3_nl
      = MUX_s_1_2_2((i_10_12_0_sva_11_0[11]), (for_3_for_2_asn_itm_12_0[12]), for_1_for_for_or_3_cse);
  assign ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_and_1_nl
      = ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux_3_nl
      & (~ or_203_cse);
  assign ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux1h_6_nl
      = MUX1HOT_s_1_3_2((ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mul_psp_sva_13_11[0]),
      (i_10_12_0_sva_11_0[11]), (for_3_for_2_asn_itm_12_0[11]), {or_203_cse , for_1_for_for_or_1_cse
      , for_1_for_for_or_3_cse});
  assign ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux1h_7_nl
      = MUX1HOT_v_11_3_2(ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mul_psp_sva_10_0,
      (i_10_12_0_sva_11_0[10:0]), (for_3_for_2_asn_itm_12_0[10:0]), {or_203_cse ,
      for_1_for_for_or_1_cse , for_1_for_for_or_3_cse});
  assign ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux1h_8_nl
      = MUX1HOT_v_7_3_2(7'b0000010, (signext_7_1(ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_1_itm_4_0[4])),
      (for_3_for_2_asn_itm_12_0[12:6]), {or_203_cse , for_1_for_for_or_1_cse , for_1_for_for_or_3_cse});
  assign ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux1h_9_nl
      = MUX1HOT_v_6_3_2(ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_itm,
      ({{1{ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_1_itm_4_0[4]}},
      ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_1_normalized_output_mux_1_itm_4_0}),
      (for_3_for_2_asn_itm_12_0[5:0]), {or_203_cse , for_1_for_for_or_1_cse , for_1_for_for_or_3_cse});
  assign nl_z_out_11 = $signed(({ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_and_1_nl
      , ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux1h_6_nl
      , ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux1h_7_nl}))
      * $signed(({ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux1h_8_nl
      , ac_math_ac_sqrt_pwl_AC_TRN_22_17_AC_TRN_AC_WRAP_14_8_AC_TRN_AC_WRAP_normalized_output_mux1h_9_nl}));
  assign z_out_11 = nl_z_out_11[23:0];
  assign for_1_for_for_for_1_for_for_and_2_atp = (out_c_2_3_0_sva_2_0[2]) & or_601_itm;
  assign for_1_for_for_mux_11_nl = MUX_v_2_2_2(in_c_1_1_0_sva, (out_c_2_3_0_sva_2_0[1:0]),
      or_601_itm);
  assign nl_for_1_for_for_mul_nl = for_1_for_for_mux_11_nl * 11'b10001000001;
  assign for_1_for_for_mul_nl = nl_for_1_for_for_mul_nl[11:0];
  assign nl_z_out_12 = for_1_for_for_mul_nl + conv_u2u_9_12({for_1_for_for_for_1_for_for_and_2_atp
      , 5'b00000 , for_1_for_for_for_1_for_for_and_2_atp , 2'b00});
  assign z_out_12 = nl_z_out_12[11:0];
  assign for_3_for_mux_4_nl = MUX_v_12_2_2(buf2_rsci_q_d, 12'b000000000001, or_324_cse);
  assign nl_z_out_14 = i_1_13_0_sva + conv_s2u_12_14(for_3_for_mux_4_nl);
  assign z_out_14 = nl_z_out_14[13:0];
  assign z_out_1 = MUX_v_6_4_2(6'b101011, 6'b011010, 6'b001110, 6'b000100, z_out_9[20:19]);
  assign z_out_2 = MUX_v_10_4_2(10'b0110101001, 10'b1001010100, 10'b1011101110, 10'b1101111100,
      z_out_9[20:19]);

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


  function automatic  MUX1HOT_s_1_6_2;
    input  input_5;
    input  input_4;
    input  input_3;
    input  input_2;
    input  input_1;
    input  input_0;
    input [5:0] sel;
    reg  result;
  begin
    result = input_0 & sel[0];
    result = result | (input_1 & sel[1]);
    result = result | (input_2 & sel[2]);
    result = result | (input_3 & sel[3]);
    result = result | (input_4 & sel[4]);
    result = result | (input_5 & sel[5]);
    MUX1HOT_s_1_6_2 = result;
  end
  endfunction


  function automatic [10:0] MUX1HOT_v_11_3_2;
    input [10:0] input_2;
    input [10:0] input_1;
    input [10:0] input_0;
    input [2:0] sel;
    reg [10:0] result;
  begin
    result = input_0 & {11{sel[0]}};
    result = result | (input_1 & {11{sel[1]}});
    result = result | (input_2 & {11{sel[2]}});
    MUX1HOT_v_11_3_2 = result;
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


  function automatic [11:0] MUX1HOT_v_12_5_2;
    input [11:0] input_4;
    input [11:0] input_3;
    input [11:0] input_2;
    input [11:0] input_1;
    input [11:0] input_0;
    input [4:0] sel;
    reg [11:0] result;
  begin
    result = input_0 & {12{sel[0]}};
    result = result | (input_1 & {12{sel[1]}});
    result = result | (input_2 & {12{sel[2]}});
    result = result | (input_3 & {12{sel[3]}});
    result = result | (input_4 & {12{sel[4]}});
    MUX1HOT_v_12_5_2 = result;
  end
  endfunction


  function automatic [12:0] MUX1HOT_v_13_3_2;
    input [12:0] input_2;
    input [12:0] input_1;
    input [12:0] input_0;
    input [2:0] sel;
    reg [12:0] result;
  begin
    result = input_0 & {13{sel[0]}};
    result = result | (input_1 & {13{sel[1]}});
    result = result | (input_2 & {13{sel[2]}});
    MUX1HOT_v_13_3_2 = result;
  end
  endfunction


  function automatic [1:0] MUX1HOT_v_2_3_2;
    input [1:0] input_2;
    input [1:0] input_1;
    input [1:0] input_0;
    input [2:0] sel;
    reg [1:0] result;
  begin
    result = input_0 & {2{sel[0]}};
    result = result | (input_1 & {2{sel[1]}});
    result = result | (input_2 & {2{sel[2]}});
    MUX1HOT_v_2_3_2 = result;
  end
  endfunction


  function automatic [4:0] MUX1HOT_v_5_3_2;
    input [4:0] input_2;
    input [4:0] input_1;
    input [4:0] input_0;
    input [2:0] sel;
    reg [4:0] result;
  begin
    result = input_0 & {5{sel[0]}};
    result = result | (input_1 & {5{sel[1]}});
    result = result | (input_2 & {5{sel[2]}});
    MUX1HOT_v_5_3_2 = result;
  end
  endfunction


  function automatic [4:0] MUX1HOT_v_5_4_2;
    input [4:0] input_3;
    input [4:0] input_2;
    input [4:0] input_1;
    input [4:0] input_0;
    input [3:0] sel;
    reg [4:0] result;
  begin
    result = input_0 & {5{sel[0]}};
    result = result | (input_1 & {5{sel[1]}});
    result = result | (input_2 & {5{sel[2]}});
    result = result | (input_3 & {5{sel[3]}});
    MUX1HOT_v_5_4_2 = result;
  end
  endfunction


  function automatic [4:0] MUX1HOT_v_5_5_2;
    input [4:0] input_4;
    input [4:0] input_3;
    input [4:0] input_2;
    input [4:0] input_1;
    input [4:0] input_0;
    input [4:0] sel;
    reg [4:0] result;
  begin
    result = input_0 & {5{sel[0]}};
    result = result | (input_1 & {5{sel[1]}});
    result = result | (input_2 & {5{sel[2]}});
    result = result | (input_3 & {5{sel[3]}});
    result = result | (input_4 & {5{sel[4]}});
    MUX1HOT_v_5_5_2 = result;
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


  function automatic [0:0] readslicef_13_1_12;
    input [12:0] vector;
    reg [12:0] tmp;
  begin
    tmp = vector >> 12;
    readslicef_13_1_12 = tmp[0:0];
  end
  endfunction


  function automatic [0:0] readslicef_33_1_32;
    input [32:0] vector;
    reg [32:0] tmp;
  begin
    tmp = vector >> 32;
    readslicef_33_1_32 = tmp[0:0];
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


  function automatic [0:0] readslicef_3_1_2;
    input [2:0] vector;
    reg [2:0] tmp;
  begin
    tmp = vector >> 2;
    readslicef_3_1_2 = tmp[0:0];
  end
  endfunction


  function automatic [0:0] readslicef_7_1_6;
    input [6:0] vector;
    reg [6:0] tmp;
  begin
    tmp = vector >> 6;
    readslicef_7_1_6 = tmp[0:0];
  end
  endfunction


  function automatic [25:0] signext_26_19;
    input [18:0] vector;
  begin
    signext_26_19= {{7{vector[18]}}, vector};
  end
  endfunction


  function automatic [6:0] signext_7_1;
    input  vector;
  begin
    signext_7_1= {{6{vector}}, vector};
  end
  endfunction


  function automatic [1:0] conv_s2s_1_2 ;
    input [0:0]  vector ;
  begin
    conv_s2s_1_2 = {vector[0], vector};
  end
  endfunction


  function automatic [3:0] conv_s2s_1_4 ;
    input [0:0]  vector ;
  begin
    conv_s2s_1_4 = {{3{vector[0]}}, vector};
  end
  endfunction


  function automatic [18:0] conv_s2s_1_19 ;
    input [0:0]  vector ;
  begin
    conv_s2s_1_19 = {{18{vector[0]}}, vector};
  end
  endfunction


  function automatic [2:0] conv_s2s_2_3 ;
    input [1:0]  vector ;
  begin
    conv_s2s_2_3 = {vector[1], vector};
  end
  endfunction


  function automatic [3:0] conv_s2s_2_4 ;
    input [1:0]  vector ;
  begin
    conv_s2s_2_4 = {{2{vector[1]}}, vector};
  end
  endfunction


  function automatic [4:0] conv_s2s_2_5 ;
    input [1:0]  vector ;
  begin
    conv_s2s_2_5 = {{3{vector[1]}}, vector};
  end
  endfunction


  function automatic [3:0] conv_s2s_3_4 ;
    input [2:0]  vector ;
  begin
    conv_s2s_3_4 = {vector[2], vector};
  end
  endfunction


  function automatic [12:0] conv_s2s_3_13 ;
    input [2:0]  vector ;
  begin
    conv_s2s_3_13 = {{10{vector[2]}}, vector};
  end
  endfunction


  function automatic [7:0] conv_s2s_5_8 ;
    input [4:0]  vector ;
  begin
    conv_s2s_5_8 = {{3{vector[4]}}, vector};
  end
  endfunction


  function automatic [7:0] conv_s2s_6_8 ;
    input [5:0]  vector ;
  begin
    conv_s2s_6_8 = {{2{vector[5]}}, vector};
  end
  endfunction


  function automatic [8:0] conv_s2s_8_9 ;
    input [7:0]  vector ;
  begin
    conv_s2s_8_9 = {vector[7], vector};
  end
  endfunction


  function automatic [11:0] conv_s2s_10_12 ;
    input [9:0]  vector ;
  begin
    conv_s2s_10_12 = {{2{vector[9]}}, vector};
  end
  endfunction


  function automatic [12:0] conv_s2s_12_13 ;
    input [11:0]  vector ;
  begin
    conv_s2s_12_13 = {vector[11], vector};
  end
  endfunction


  function automatic [3:0] conv_s2u_2_4 ;
    input [1:0]  vector ;
  begin
    conv_s2u_2_4 = {{2{vector[1]}}, vector};
  end
  endfunction


  function automatic [6:0] conv_s2u_2_7 ;
    input [1:0]  vector ;
  begin
    conv_s2u_2_7 = {{5{vector[1]}}, vector};
  end
  endfunction


  function automatic [7:0] conv_s2u_3_8 ;
    input [2:0]  vector ;
  begin
    conv_s2u_3_8 = {{5{vector[2]}}, vector};
  end
  endfunction


  function automatic [7:0] conv_s2u_4_8 ;
    input [3:0]  vector ;
  begin
    conv_s2u_4_8 = {{4{vector[3]}}, vector};
  end
  endfunction


  function automatic [7:0] conv_s2u_7_8 ;
    input [6:0]  vector ;
  begin
    conv_s2u_7_8 = {vector[6], vector};
  end
  endfunction


  function automatic [8:0] conv_s2u_7_9 ;
    input [6:0]  vector ;
  begin
    conv_s2u_7_9 = {{2{vector[6]}}, vector};
  end
  endfunction


  function automatic [13:0] conv_s2u_12_14 ;
    input [11:0]  vector ;
  begin
    conv_s2u_12_14 = {{2{vector[11]}}, vector};
  end
  endfunction


  function automatic [27:0] conv_s2u_24_28 ;
    input [23:0]  vector ;
  begin
    conv_s2u_24_28 = {{4{vector[23]}}, vector};
  end
  endfunction


  function automatic [1:0] conv_u2s_1_2 ;
    input [0:0]  vector ;
  begin
    conv_u2s_1_2 =  {1'b0, vector};
  end
  endfunction


  function automatic [2:0] conv_u2s_2_3 ;
    input [1:0]  vector ;
  begin
    conv_u2s_2_3 =  {1'b0, vector};
  end
  endfunction


  function automatic [3:0] conv_u2s_2_4 ;
    input [1:0]  vector ;
  begin
    conv_u2s_2_4 = {{2{1'b0}}, vector};
  end
  endfunction


  function automatic [3:0] conv_u2s_3_4 ;
    input [2:0]  vector ;
  begin
    conv_u2s_3_4 =  {1'b0, vector};
  end
  endfunction


  function automatic [4:0] conv_u2s_3_5 ;
    input [2:0]  vector ;
  begin
    conv_u2s_3_5 = {{2{1'b0}}, vector};
  end
  endfunction


  function automatic [7:0] conv_u2s_7_8 ;
    input [6:0]  vector ;
  begin
    conv_u2s_7_8 =  {1'b0, vector};
  end
  endfunction


  function automatic [8:0] conv_u2s_8_9 ;
    input [7:0]  vector ;
  begin
    conv_u2s_8_9 =  {1'b0, vector};
  end
  endfunction


  function automatic [6:0] conv_u2u_2_7 ;
    input [1:0]  vector ;
  begin
    conv_u2u_2_7 = {{5{1'b0}}, vector};
  end
  endfunction


  function automatic [3:0] conv_u2u_3_4 ;
    input [2:0]  vector ;
  begin
    conv_u2u_3_4 = {1'b0, vector};
  end
  endfunction


  function automatic [5:0] conv_u2u_4_6 ;
    input [3:0]  vector ;
  begin
    conv_u2u_4_6 = {{2{1'b0}}, vector};
  end
  endfunction


  function automatic [5:0] conv_u2u_5_6 ;
    input [4:0]  vector ;
  begin
    conv_u2u_5_6 = {1'b0, vector};
  end
  endfunction


  function automatic [6:0] conv_u2u_6_7 ;
    input [5:0]  vector ;
  begin
    conv_u2u_6_7 = {1'b0, vector};
  end
  endfunction


  function automatic [7:0] conv_u2u_7_8 ;
    input [6:0]  vector ;
  begin
    conv_u2u_7_8 = {1'b0, vector};
  end
  endfunction


  function automatic [11:0] conv_u2u_9_12 ;
    input [8:0]  vector ;
  begin
    conv_u2u_9_12 = {{3{1'b0}}, vector};
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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    UNET_IP_main
// ------------------------------------------------------------------


module UNET_IP_main (
  clk, rst, input_rsc_dat, input_rsc_vld, input_rsc_rdy, output_rsc_dat, output_rsc_vld,
      output_rsc_rdy
);
  input clk;
  input rst;
  input [11:0] input_rsc_dat;
  input input_rsc_vld;
  output input_rsc_rdy;
  output [11:0] output_rsc_dat;
  output output_rsc_vld;
  input output_rsc_rdy;


  // Interconnect Declarations
  wire buf1_rsci_clken_d;
  wire [11:0] buf1_rsci_d_d;
  wire [11:0] buf1_rsci_q_d;
  wire [14:0] buf1_rsci_radr_d;
  wire [14:0] buf1_rsci_wadr_d;
  wire [11:0] padded_input_rsci_q_d;
  wire [13:0] padded_input_rsci_radr_d;
  wire [13:0] padded_input_rsci_wadr_d;
  wire [11:0] buf2_rsci_d_d;
  wire [11:0] buf2_rsci_q_d;
  wire [14:0] buf2_rsci_radr_d;
  wire [14:0] buf2_rsci_wadr_d;
  wire [11:0] enc1_rsci_d_d;
  wire [11:0] enc1_rsci_q_d;
  wire [14:0] enc1_rsci_radr_d;
  wire [14:0] enc1_rsci_wadr_d;
  wire buf1_rsc_clken;
  wire [11:0] buf1_rsc_q;
  wire buf1_rsc_re;
  wire [14:0] buf1_rsc_radr;
  wire buf1_rsc_we;
  wire [11:0] buf1_rsc_d;
  wire [14:0] buf1_rsc_wadr;
  wire padded_input_rsc_clken;
  wire [11:0] padded_input_rsc_q;
  wire padded_input_rsc_re;
  wire [13:0] padded_input_rsc_radr;
  wire padded_input_rsc_we;
  wire [11:0] padded_input_rsc_d;
  wire [13:0] padded_input_rsc_wadr;
  wire buf2_rsc_clken;
  wire [11:0] buf2_rsc_q;
  wire buf2_rsc_re;
  wire [14:0] buf2_rsc_radr;
  wire buf2_rsc_we;
  wire [11:0] buf2_rsc_d;
  wire [14:0] buf2_rsc_wadr;
  wire enc1_rsc_clken;
  wire [11:0] enc1_rsc_q;
  wire enc1_rsc_re;
  wire [14:0] enc1_rsc_radr;
  wire enc1_rsc_we;
  wire [11:0] enc1_rsc_d;
  wire [14:0] enc1_rsc_wadr;
  wire buf1_rsci_re_d_iff;
  wire buf1_rsci_we_d_iff;
  wire padded_input_rsci_re_d_iff;
  wire padded_input_rsci_we_d_iff;
  wire buf2_rsci_re_d_iff;
  wire buf2_rsci_we_d_iff;
  wire enc1_rsci_re_d_iff;
  wire enc1_rsci_we_d_iff;


  // Interconnect Declarations for Component Instantiations 
  BLOCK_1R1W_RBW #(.addr_width(32'sd15),
  .data_width(32'sd12),
  .depth(32'sd32768),
  .latency(32'sd1),
  .suppress_sim_read_addr_range_errs(32'sd1)) buf1_rsc_comp (
      .clk(clk),
      .clken(buf1_rsc_clken),
      .d(buf1_rsc_d),
      .q(buf1_rsc_q),
      .radr(buf1_rsc_radr),
      .re(buf1_rsc_re),
      .wadr(buf1_rsc_wadr),
      .we(buf1_rsc_we)
    );
  BLOCK_1R1W_RBW #(.addr_width(32'sd14),
  .data_width(32'sd12),
  .depth(32'sd13068),
  .latency(32'sd1),
  .suppress_sim_read_addr_range_errs(32'sd1)) padded_input_rsc_comp (
      .clk(clk),
      .clken(padded_input_rsc_clken),
      .d(padded_input_rsc_d),
      .q(padded_input_rsc_q),
      .radr(padded_input_rsc_radr),
      .re(padded_input_rsc_re),
      .wadr(padded_input_rsc_wadr),
      .we(padded_input_rsc_we)
    );
  BLOCK_1R1W_RBW #(.addr_width(32'sd15),
  .data_width(32'sd12),
  .depth(32'sd32768),
  .latency(32'sd1),
  .suppress_sim_read_addr_range_errs(32'sd1)) buf2_rsc_comp (
      .clk(clk),
      .clken(buf2_rsc_clken),
      .d(buf2_rsc_d),
      .q(buf2_rsc_q),
      .radr(buf2_rsc_radr),
      .re(buf2_rsc_re),
      .wadr(buf2_rsc_wadr),
      .we(buf2_rsc_we)
    );
  BLOCK_1R1W_RBW #(.addr_width(32'sd15),
  .data_width(32'sd12),
  .depth(32'sd32768),
  .latency(32'sd1),
  .suppress_sim_read_addr_range_errs(32'sd1)) enc1_rsc_comp (
      .clk(clk),
      .clken(enc1_rsc_clken),
      .d(enc1_rsc_d),
      .q(enc1_rsc_q),
      .radr(enc1_rsc_radr),
      .re(enc1_rsc_re),
      .wadr(enc1_rsc_wadr),
      .we(enc1_rsc_we)
    );
  UNET_IP_main_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_3_15_12_32768_1_32768_12_1_gen
      buf1_rsci (
      .clken(buf1_rsc_clken),
      .q(buf1_rsc_q),
      .re(buf1_rsc_re),
      .radr(buf1_rsc_radr),
      .we(buf1_rsc_we),
      .d(buf1_rsc_d),
      .wadr(buf1_rsc_wadr),
      .clken_d(buf1_rsci_clken_d),
      .d_d(buf1_rsci_d_d),
      .q_d(buf1_rsci_q_d),
      .radr_d(buf1_rsci_radr_d),
      .re_d(buf1_rsci_re_d_iff),
      .wadr_d(buf1_rsci_wadr_d),
      .we_d(buf1_rsci_we_d_iff),
      .writeA_w_ram_ir_internal_WMASK_B_d(buf1_rsci_we_d_iff),
      .readA_r_ram_ir_internal_RMASK_B_d(buf1_rsci_re_d_iff)
    );
  UNET_IP_main_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_4_14_12_13068_1_13068_12_1_gen
      padded_input_rsci (
      .clken(padded_input_rsc_clken),
      .q(padded_input_rsc_q),
      .re(padded_input_rsc_re),
      .radr(padded_input_rsc_radr),
      .we(padded_input_rsc_we),
      .d(padded_input_rsc_d),
      .wadr(padded_input_rsc_wadr),
      .clken_d(buf1_rsci_clken_d),
      .d_d(buf1_rsci_q_d),
      .q_d(padded_input_rsci_q_d),
      .radr_d(padded_input_rsci_radr_d),
      .re_d(padded_input_rsci_re_d_iff),
      .wadr_d(padded_input_rsci_wadr_d),
      .we_d(padded_input_rsci_we_d_iff),
      .writeA_w_ram_ir_internal_WMASK_B_d(padded_input_rsci_we_d_iff),
      .readA_r_ram_ir_internal_RMASK_B_d(padded_input_rsci_re_d_iff)
    );
  UNET_IP_main_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_5_15_12_32768_1_32768_12_1_gen
      buf2_rsci (
      .clken(buf2_rsc_clken),
      .q(buf2_rsc_q),
      .re(buf2_rsc_re),
      .radr(buf2_rsc_radr),
      .we(buf2_rsc_we),
      .d(buf2_rsc_d),
      .wadr(buf2_rsc_wadr),
      .clken_d(buf1_rsci_clken_d),
      .d_d(buf2_rsci_d_d),
      .q_d(buf2_rsci_q_d),
      .radr_d(buf2_rsci_radr_d),
      .re_d(buf2_rsci_re_d_iff),
      .wadr_d(buf2_rsci_wadr_d),
      .we_d(buf2_rsci_we_d_iff),
      .writeA_w_ram_ir_internal_WMASK_B_d(buf2_rsci_we_d_iff),
      .readA_r_ram_ir_internal_RMASK_B_d(buf2_rsci_re_d_iff)
    );
  UNET_IP_main_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_6_15_12_32768_1_32768_12_1_gen
      enc1_rsci (
      .clken(enc1_rsc_clken),
      .q(enc1_rsc_q),
      .re(enc1_rsc_re),
      .radr(enc1_rsc_radr),
      .we(enc1_rsc_we),
      .d(enc1_rsc_d),
      .wadr(enc1_rsc_wadr),
      .clken_d(buf1_rsci_clken_d),
      .d_d(enc1_rsci_d_d),
      .q_d(enc1_rsci_q_d),
      .radr_d(enc1_rsci_radr_d),
      .re_d(enc1_rsci_re_d_iff),
      .wadr_d(enc1_rsci_wadr_d),
      .we_d(enc1_rsci_we_d_iff),
      .writeA_w_ram_ir_internal_WMASK_B_d(enc1_rsci_we_d_iff),
      .readA_r_ram_ir_internal_RMASK_B_d(enc1_rsci_re_d_iff)
    );
  UNET_IP_main_run UNET_IP_main_run_inst (
      .clk(clk),
      .rst(rst),
      .input_rsc_dat(input_rsc_dat),
      .input_rsc_vld(input_rsc_vld),
      .input_rsc_rdy(input_rsc_rdy),
      .output_rsc_dat(output_rsc_dat),
      .output_rsc_vld(output_rsc_vld),
      .output_rsc_rdy(output_rsc_rdy),
      .buf1_rsci_clken_d(buf1_rsci_clken_d),
      .buf1_rsci_d_d(buf1_rsci_d_d),
      .buf1_rsci_q_d(buf1_rsci_q_d),
      .buf1_rsci_radr_d(buf1_rsci_radr_d),
      .buf1_rsci_wadr_d(buf1_rsci_wadr_d),
      .padded_input_rsci_q_d(padded_input_rsci_q_d),
      .padded_input_rsci_radr_d(padded_input_rsci_radr_d),
      .padded_input_rsci_wadr_d(padded_input_rsci_wadr_d),
      .buf2_rsci_d_d(buf2_rsci_d_d),
      .buf2_rsci_q_d(buf2_rsci_q_d),
      .buf2_rsci_radr_d(buf2_rsci_radr_d),
      .buf2_rsci_wadr_d(buf2_rsci_wadr_d),
      .enc1_rsci_d_d(enc1_rsci_d_d),
      .enc1_rsci_q_d(enc1_rsci_q_d),
      .enc1_rsci_radr_d(enc1_rsci_radr_d),
      .enc1_rsci_wadr_d(enc1_rsci_wadr_d),
      .buf1_rsci_re_d_pff(buf1_rsci_re_d_iff),
      .buf1_rsci_we_d_pff(buf1_rsci_we_d_iff),
      .padded_input_rsci_re_d_pff(padded_input_rsci_re_d_iff),
      .padded_input_rsci_we_d_pff(padded_input_rsci_we_d_iff),
      .buf2_rsci_re_d_pff(buf2_rsci_re_d_iff),
      .buf2_rsci_we_d_pff(buf2_rsci_we_d_iff),
      .enc1_rsci_re_d_pff(enc1_rsci_re_d_iff),
      .enc1_rsci_we_d_pff(enc1_rsci_we_d_iff)
    );
endmodule



