// SCVerify DUT wrapper used for SystemC > HDL interface bindings


module ccs_wrapper (
  clk, rst, input_rsc_dat, input_rsc_vld, input_rsc_rdy, output_rsc_dat, output_rsc_vld, output_rsc_rdy
);
  input clk;
  input rst;
  input [11:0] input_rsc_dat;
  input input_rsc_vld;
  output input_rsc_rdy;
  output [11:0] output_rsc_dat;
  output output_rsc_vld;
  input output_rsc_rdy;


  UNET_IP_main dut_inst (
    .clk(clk),
    .rst(rst),
    .input_rsc_dat(input_rsc_dat),
    .input_rsc_vld(input_rsc_vld),
    .input_rsc_rdy(input_rsc_rdy),
    .output_rsc_dat(output_rsc_dat),
    .output_rsc_vld(output_rsc_vld),
    .output_rsc_rdy(output_rsc_rdy)
  );

endmodule

