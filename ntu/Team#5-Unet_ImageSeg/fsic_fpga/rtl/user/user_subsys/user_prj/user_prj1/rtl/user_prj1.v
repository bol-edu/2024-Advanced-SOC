
module USER_PRJ1 #(
  parameter pUSER_PROJECT_SIDEBAND_WIDTH = 5,
  parameter pADDR_WIDTH = 12,
  parameter pDATA_WIDTH = 32
)
(
  output wire                        awready,
  output wire                        arready,
  output wire                        wready,
  output wire                        rvalid,
  output wire  [(pDATA_WIDTH-1) : 0] rdata,
  input  wire                        awvalid,
  input  wire                [11: 0] awaddr,
  input  wire                        arvalid,
  input  wire                [11: 0] araddr,
  input  wire                        wvalid,
  input  wire                 [3: 0] wstrb,
  input  wire  [(pDATA_WIDTH-1) : 0] wdata,
  input  wire                        rready,
  input  wire                        ss_tvalid,
  input  wire  [(pDATA_WIDTH-1) : 0] ss_tdata,
  input  wire                 [1: 0] ss_tuser,
    `ifdef USER_PROJECT_SIDEBAND_SUPPORT
  input  wire                 [pUSER_PROJECT_SIDEBAND_WIDTH-1: 0] ss_tupsb,
  `endif
  input  wire                 [3: 0] ss_tstrb,
  input  wire                 [3: 0] ss_tkeep,
  input  wire                        ss_tlast,
  input  wire                        sm_tready,
  output wire                        ss_tready,
  output wire                        sm_tvalid,
  output wire  [(pDATA_WIDTH-1) : 0] sm_tdata,
  output wire                 [2: 0] sm_tid,
  `ifdef USER_PROJECT_SIDEBAND_SUPPORT
  output  wire                 [pUSER_PROJECT_SIDEBAND_WIDTH-1: 0] sm_tupsb,
  `endif
  output wire                 [3: 0] sm_tstrb,
  output wire                 [3: 0] sm_tkeep,
  output wire                        sm_tlast,
  output wire                        low__pri_irq,
  output wire                        High_pri_req,
  output wire                [23: 0] la_data_o,
  input  wire                        axi_clk,
  input  wire                        axis_clk,
  input  wire                        axi_reset_n,
  input  wire                        axis_rst_n,
  input  wire                        user_clock2,
  input  wire                        uck2_rst_n
);

  `ifdef USER_PROJECT_SIDEBAND_SUPPORT
    assign sm_tupsb      = 5'b0;
  `endif
  assign sm_tid        = 3'b0;
  assign sm_tstrb      = 4'b0;
  assign sm_tkeep      = 1'b0;
  assign sm_tlast      = 1'b0;
  assign low__pri_irq  = 1'b0;
  assign High_pri_req  = 1'b0;
  assign la_data_o     = 24'b0;

  // tap_ram
  wire [3:0]  tap_WE;
  wire        tap_EN;
  wire [11:0] tap_A;
  wire [31:0] tap_Di, tap_Do;
  bram11 tap_ram(
    .clk   (axi_clk  ),
    .we    (|tap_WE  ),
    .re    (tap_EN   ),
    .waddr (tap_A    ),
    .raddr (tap_A    ),
    .wdi   (tap_Di   ),
    .rdo   (tap_Do   )
  );

  // data_ram
  wire [3:0]  data_WE;
  wire        data_EN;
  wire [11:0] data_A;
  wire [31:0] data_Di, data_Do;
  bram11 data_ram (
    .clk   (axi_clk  ),
    .we    (|data_WE ),
    .re    (data_EN  ),
    .waddr (data_A   ),
    .raddr (data_A   ),
    .wdi   (data_Di  ),
    .rdo   (data_Do  )
  );

  // fir_module
  reg [(pDATA_WIDTH-1) : 0] fir_wdata;
  always @(*) begin
    fir_wdata[  7:0] = wstrb[0] ? wdata[7:0] : 0;
    fir_wdata[ 15:8] = wstrb[1] ? wdata[15:8] : 0;
    fir_wdata[23:16] = wstrb[2] ? wdata[23:16] : 0;
    fir_wdata[31:24] = wstrb[3] ? wdata[31:24] : 0;
  end
  fir fir_inst (
    .awready   (awready   ),
    .wready    (wready    ),
    .awvalid   (awvalid   ),
    .awaddr    (awaddr    ),
    .wvalid    (wvalid    ),
    .wdata     (fir_wdata ),
    .arready   (arready   ),
    .rready    (rready    ),
    .arvalid   (arvalid   ),
    .araddr    (araddr    ),
    .rvalid    (rvalid    ),
    .rdata     (rdata     ),    
    .ss_tvalid (ss_tvalid ), 
    .ss_tdata  (ss_tdata  ), 
    .ss_tlast  (ss_tlast  ), 
    .ss_tready (ss_tready ), 
    .sm_tready (sm_tready ), 
    .sm_tvalid (sm_tvalid ), 
    .sm_tdata  (sm_tdata  ), 
    .sm_tlast  (          ), 
    
    .tap_WE (tap_WE ),
    .tap_EN (tap_EN ),
    .tap_Di (tap_Di ),
    .tap_A  (tap_A  ),
    .tap_Do (tap_Do ),
    
    .data_WE (data_WE ),
    .data_EN (data_EN ),
    .data_Di (data_Di ),
    .data_A  (data_A  ),
    .data_Do (data_Do ),

    .axis_clk   (axi_clk     ),
    .axis_rst_n (axi_reset_n )
  );

endmodule // USER_PRJ1
