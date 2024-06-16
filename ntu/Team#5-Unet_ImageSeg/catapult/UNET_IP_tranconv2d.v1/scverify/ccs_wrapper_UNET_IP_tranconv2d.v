// SCVerify DUT wrapper used for SystemC > HDL interface bindings


module ccs_wrapper (
  clk, rst, arst_n, input_rsc_radr, input_rsc_re, input_rsc_q, input_triosy_lz, output_rsc_wadr, output_rsc_d,
      output_rsc_we, output_rsc_radr, output_rsc_re, output_rsc_q, output_triosy_lz, height_rsc_dat, height_triosy_lz,
      width_rsc_dat, width_triosy_lz, kernel_size_rsc_dat, kernel_size_triosy_lz, filter_offset_rsc_dat, filter_offset_triosy_lz,
      in_channels_rsc_dat, in_channels_triosy_lz, out_channels_rsc_dat, out_channels_triosy_lz, stride_rsc_dat,
      stride_triosy_lz
);
  input clk;
  input rst;
  input arst_n;
  output [14:0] input_rsc_radr;
  output input_rsc_re;
  input [11:0] input_rsc_q;
  output input_triosy_lz;
  output [14:0] output_rsc_wadr;
  output [11:0] output_rsc_d;
  output output_rsc_we;
  output [14:0] output_rsc_radr;
  output output_rsc_re;
  input [11:0] output_rsc_q;
  output output_triosy_lz;
  input [6:0] height_rsc_dat;
  output height_triosy_lz;
  input [6:0] width_rsc_dat;
  output width_triosy_lz;
  input [1:0] kernel_size_rsc_dat;
  output kernel_size_triosy_lz;
  input [19:0] filter_offset_rsc_dat;
  output filter_offset_triosy_lz;
  input [6:0] in_channels_rsc_dat;
  output in_channels_triosy_lz;
  input [6:0] out_channels_rsc_dat;
  output out_channels_triosy_lz;
  input [2:0] stride_rsc_dat;
  output stride_triosy_lz;


  UNET_IP_tranconv2d dut_inst (
    .clk(clk),
    .rst(rst),
    .arst_n(arst_n),
    .input_rsc_radr(input_rsc_radr),
    .input_rsc_re(input_rsc_re),
    .input_rsc_q(input_rsc_q),
    .input_triosy_lz(input_triosy_lz),
    .output_rsc_wadr(output_rsc_wadr),
    .output_rsc_d(output_rsc_d),
    .output_rsc_we(output_rsc_we),
    .output_rsc_radr(output_rsc_radr),
    .output_rsc_re(output_rsc_re),
    .output_rsc_q(output_rsc_q),
    .output_triosy_lz(output_triosy_lz),
    .height_rsc_dat(height_rsc_dat),
    .height_triosy_lz(height_triosy_lz),
    .width_rsc_dat(width_rsc_dat),
    .width_triosy_lz(width_triosy_lz),
    .kernel_size_rsc_dat(kernel_size_rsc_dat),
    .kernel_size_triosy_lz(kernel_size_triosy_lz),
    .filter_offset_rsc_dat(filter_offset_rsc_dat),
    .filter_offset_triosy_lz(filter_offset_triosy_lz),
    .in_channels_rsc_dat(in_channels_rsc_dat),
    .in_channels_triosy_lz(in_channels_triosy_lz),
    .out_channels_rsc_dat(out_channels_rsc_dat),
    .out_channels_triosy_lz(out_channels_triosy_lz),
    .stride_rsc_dat(stride_rsc_dat),
    .stride_triosy_lz(stride_triosy_lz)
  );

endmodule

