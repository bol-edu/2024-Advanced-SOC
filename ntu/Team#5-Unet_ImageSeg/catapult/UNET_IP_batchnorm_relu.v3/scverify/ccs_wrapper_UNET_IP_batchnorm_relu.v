// SCVerify DUT wrapper used for SystemC > HDL interface bindings


module ccs_wrapper (
  clk, rst, arst_n, input_rsc_radr, input_rsc_re, input_rsc_q, input_rsc_clken, input_triosy_lz, output_rsc_wadr,
      output_rsc_d, output_rsc_we, output_rsc_clken, output_triosy_lz, channels, height, width, offset
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


  UNET_IP_batchnorm_relu dut_inst (
    .clk(clk),
    .rst(rst),
    .arst_n(arst_n),
    .input_rsc_radr(input_rsc_radr),
    .input_rsc_re(input_rsc_re),
    .input_rsc_q(input_rsc_q),
    .input_rsc_clken(input_rsc_clken),
    .input_triosy_lz(input_triosy_lz),
    .output_rsc_wadr(output_rsc_wadr),
    .output_rsc_d(output_rsc_d),
    .output_rsc_we(output_rsc_we),
    .output_rsc_clken(output_rsc_clken),
    .output_triosy_lz(output_triosy_lz),
    .channels(channels),
    .height(height),
    .width(width),
    .offset(offset)
  );

endmodule

