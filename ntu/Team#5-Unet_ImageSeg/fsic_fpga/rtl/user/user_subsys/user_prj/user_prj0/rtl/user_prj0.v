//`define USE_EDGEDETECT_IP

`timescale 1ns / 10ps

module USER_PRJ0 #(parameter pUSER_PROJECT_SIDEBAND_WIDTH   = 5,
                   parameter pADDR_WIDTH   = 12,
                   parameter pDATA_WIDTH   = 32
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
  input  wire  [pUSER_PROJECT_SIDEBAND_WIDTH-1: 0] ss_tupsb,
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
  output  wire [pUSER_PROJECT_SIDEBAND_WIDTH-1: 0] sm_tupsb,
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

// configuration registers
// 0x00: [bit 0] ap_start, [bit 1] ap_done, [bit 2] ap_idle
reg [2:0] ap_ctrl_r, ap_ctrl_w;

// FSM
localparam S_IDLE = 2'd0;  // config via axilite
localparam S_LOAD = 2'd1;  // stream in image
localparam S_WAIT = 2'd2;  // wait for output results
reg [1:0] state_r, state_w;

localparam INPUT_SIZE = 64 * 64 * 3;
localparam OUTPUT_SIZE = 64 * 64 * 3;
localparam CNT_I_BW = $clog2(INPUT_SIZE);
localparam CNT_O_BW = $clog2(OUTPUT_SIZE);
reg [(CNT_I_BW-1):0] cnt_in_r, cnt_in_w;
reg [(CNT_O_BW-1):0] cnt_out_r, cnt_out_w;

always @(*) begin
    state_w = state_r;
    case (state_r)
      S_IDLE: begin
          state_w = ap_ctrl_r[0] ? S_LOAD : state_r;
      end
      S_LOAD: begin
          state_w = (cnt_in_r == INPUT_SIZE) ? S_WAIT : state_r;
      end
      S_WAIT: begin
          state_w = (cnt_out_r == OUTPUT_SIZE) ? S_IDLE : state_r;
      end
      default: state_w = S_IDLE;
    endcase
end

always @(*) begin
    cnt_in_w  = cnt_in_r;
    cnt_out_w = cnt_out_r;
    case (state_r)
      S_LOAD: begin
          cnt_in_w = (ss_tvalid && ss_tready) ? (cnt_in_r + 1) : cnt_in_r;
      end
      S_WAIT: begin
          cnt_out_w = (sm_tvalid && sm_tready) ? (cnt_out_r + 1) : cnt_out_r;
      end
      default: begin
          cnt_in_w  = 0;
          cnt_out_w = 0;
      end
    endcase
end

// if both awvalid = 1 and wvalid = 1 then output awready = 1 and wready = 1
assign awready = (awvalid && wvalid) ? 1 : 0;
assign wready  = (awvalid && wvalid) ? 1 : 0;

// write register
// 12'h000: ap_start
always @(*) begin
    ap_ctrl_w = {(state_r == S_IDLE), (state_r == S_IDLE), 1'b0};
    if (awvalid && wvalid) begin  // when awvalid = 1 and wvalid = 1 means awready = 1 and wready = 1
        if (awaddr[11:2] == 10'h000) begin  // offset 0
            if (wstrb[0] == 1) ap_ctrl_w[0] = wdata[0];
        end
    end
end

always @(posedge axi_clk or negedge axi_reset_n)  begin
    if (~axi_reset_n) begin
        state_r   <= S_IDLE;
        ap_ctrl_r <= 0;
        cnt_in_r  <= 0;
        cnt_out_r <= 0;
    end
    else begin
        state_r   <= state_w;
        ap_ctrl_r <= ap_ctrl_w;
        cnt_in_r  <= cnt_in_w;
        cnt_out_r <= cnt_out_w;
    end
end

// reset signal for UNET IP
reg reg_rst;
always @(posedge axi_clk or negedge axi_reset_n)  begin
    if (~axi_reset_n) begin
        reg_rst <= 1;
    end
    else begin
        reg_rst <= (state_r == S_IDLE) ? 1 : 0;
    end
end

// read register
reg [(pDATA_WIDTH-1) : 0] rdata_tmp;
reg [(pADDR_WIDTH-1) : 0] rd_addr_r;
reg rvalid_r;
reg rd_state_r, rd_state_w;

assign rvalid  = rvalid_r;
assign rdata   = rdata_tmp;
assign arready = 1;          // always assigned to 1, limitation: only support 1T in arvalid, if master issue 2T in arvalid then only 1st raddr is captured.

localparam	RD_IDLE      = 1'b0;
localparam	RD_ADDR_DONE = 1'b1;

always @(*)begin
    case (rd_state_r)
        RD_IDLE:
            if (arvalid && arready) rd_state_w = RD_ADDR_DONE;
            else                    rd_state_w = RD_IDLE;
        RD_ADDR_DONE:
            if (rready && rvalid_r) rd_state_w = RD_IDLE;
            else                    rd_state_w = RD_ADDR_DONE;
        default: rd_state_w = RD_IDLE;
    endcase
end 

always @(posedge axi_clk or negedge axi_reset_n)  begin
    if (~axi_reset_n) 
        rd_state_r <= RD_IDLE;
    else
        rd_state_r <= rd_state_w;
end

always @(posedge axi_clk or negedge axi_reset_n)  begin
    if (~axi_reset_n) begin
        rd_addr_r <= 0;
        rvalid_r  <= 0;
    end	
    else begin
        if (rd_state_r == RD_IDLE) begin
            if (arvalid && arready) begin
                rd_addr_r <= araddr;
                rvalid_r  <= 1;
            end
        end
        if (rd_state_r == RD_ADDR_DONE) begin 
            if (rready && rvalid_r)
                rvalid_r <= 0;
        end
    end
end

always @(*) begin
  if (rd_addr_r[11:2] == 10'h000) rdata_tmp = {29'd0, ap_ctrl_r};
  else                            rdata_tmp = 0;
end

`ifdef USER_PROJECT_SIDEBAND_SUPPORT
assign sm_tupsb = 0;
`endif


// UNET IP I/O pins
reg  [11:0] input_rsc_dat;
reg         input_rsc_vld;
reg         output_rsc_rdy;
wire        input_rsc_rdy;
wire [11:0] output_rsc_dat;
wire        output_rsc_vld;

// output stream
assign sm_tvalid = output_rsc_vld;
assign sm_tdata  = {20'd0, output_rsc_dat};
assign ss_tready = input_rsc_rdy;
assign {sm_tstrb, sm_tkeep, sm_tlast} = 0;

// input stream
always @(*) begin
    input_rsc_dat  = ss_tdata[11:0];
    input_rsc_vld  = ss_tvalid;
    output_rsc_rdy = sm_tready;
end


UNET_IP_main UNET_IP_main_inst (
    .clk            (axi_clk        ),  // I
    .rst            (reg_rst        ),  // I
    .input_rsc_dat  (input_rsc_dat  ),  // I
    .input_rsc_vld  (input_rsc_vld  ),  // I
    .input_rsc_rdy  (input_rsc_rdy  ),  // O
    .output_rsc_dat (output_rsc_dat ),  // O
    .output_rsc_vld (output_rsc_vld ),  // O
    .output_rsc_rdy (output_rsc_rdy )   // I
);


endmodule // USER_PRJ0
