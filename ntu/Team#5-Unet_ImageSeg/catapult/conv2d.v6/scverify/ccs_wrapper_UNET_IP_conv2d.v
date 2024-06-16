// SCVerify DUT wrapper used for SystemC > HDL interface bindings


module ccs_wrapper (
  clk, rst, arst_n, input_rsc_radr, input_rsc_re, input_rsc_q, input_rsc_clken, input_triosy_lz, padded_input_rsc_wadr,
      padded_input_rsc_d, padded_input_rsc_we, padded_input_rsc_radr, padded_input_rsc_re, padded_input_rsc_q,
      padded_input_rsc_clken, padded_input_triosy_lz, output_rsc_wadr, output_rsc_d, output_rsc_we, output_rsc_clken,
      output_triosy_lz, height, width, kernel_size, padding, filter_offset, in_channels, out_channels
);
  input clk;
  input rst;
  input arst_n;
  output [14:0] input_rsc_radr;
  output input_rsc_re;
  input [11:0] input_rsc_q;
  output input_rsc_clken;
  output input_triosy_lz;
  output [15:0] padded_input_rsc_wadr;
  output [11:0] padded_input_rsc_d;
  output padded_input_rsc_we;
  output [15:0] padded_input_rsc_radr;
  output padded_input_rsc_re;
  input [11:0] padded_input_rsc_q;
  output padded_input_rsc_clken;
  output padded_input_triosy_lz;
  output [14:0] output_rsc_wadr;
  output [11:0] output_rsc_d;
  output output_rsc_we;
  output output_rsc_clken;
  output output_triosy_lz;
  input [6:0] height;
  input [6:0] width;
  input [1:0] kernel_size;
  input [1:0] padding;
  input [19:0] filter_offset;
  input [6:0] in_channels;
  input [6:0] out_channels;


  UNET_IP_conv2d dut_inst (
    .clk(clk),
    .rst(rst),
    .arst_n(arst_n),
    .input_rsc_radr(input_rsc_radr),
    .input_rsc_re(input_rsc_re),
    .input_rsc_q(input_rsc_q),
    .input_rsc_clken(input_rsc_clken),
    .input_triosy_lz(input_triosy_lz),
    .padded_input_rsc_wadr(padded_input_rsc_wadr),
    .padded_input_rsc_d(padded_input_rsc_d),
    .padded_input_rsc_we(padded_input_rsc_we),
    .padded_input_rsc_radr(padded_input_rsc_radr),
    .padded_input_rsc_re(padded_input_rsc_re),
    .padded_input_rsc_q(padded_input_rsc_q),
    .padded_input_rsc_clken(padded_input_rsc_clken),
    .padded_input_triosy_lz(padded_input_triosy_lz),
    .output_rsc_wadr(output_rsc_wadr),
    .output_rsc_d(output_rsc_d),
    .output_rsc_we(output_rsc_we),
    .output_rsc_clken(output_rsc_clken),
    .output_triosy_lz(output_triosy_lz),
    .height(height),
    .width(width),
    .kernel_size(kernel_size),
    .padding(padding),
    .filter_offset(filter_offset),
    .in_channels(in_channels),
    .out_channels(out_channels)
  );

endmodule

