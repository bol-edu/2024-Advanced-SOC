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


assign sm_tid        = 3'b0;
`ifdef USER_PROJECT_SIDEBAND_SUPPORT
  assign sm_tupsb      = 5'b0;
`endif
assign sm_tstrb      = 4'b0;
assign sm_tkeep      = 1'b0;
assign low__pri_irq  = 1'b0;
assign High_pri_req  = 1'b0;
// assign la_data_o     = 24'b0;
assign la_data_o = la_out_reg;
reg count;
reg [15:0] la_out_reg;

always @(posedge axis_clk or negedge axi_reset_n) begin
    if (!axi_reset_n) begin
      count <= 1'b0;
      la_out_reg <= 16'b0;
    end else begin
      if (count == 0) begin
        la_out_reg <= sm_tdata[15:0];
        count <= 1;
      end
      else begin
        la_out_reg <= sm_tdata[31:16];
        count <= 0;
      end
    end
end

localparam	RD_IDLE = 1'b0;
localparam	RD_ADDR_DONE = 1'b1;

//[TODO] does tlast from FPGA to SOC need send to UP? or use upsb as UP's tlast?
`ifdef USER_PROJECT_SIDEBAND_SUPPORT
	localparam	FIFO_WIDTH = (pUSER_PROJECT_SIDEBAND_WIDTH + 4 + 4 + 1 + pDATA_WIDTH);		//upsb, tstrb, tkeep, tlast, tdata  
`else
	localparam	FIFO_WIDTH = (4 + 4 + 1 + pDATA_WIDTH);		//tstrb, tkeep, tlast, tdata
`endif

`ifdef USER_PROJECT_SIDEBAND_SUPPORT
wire [33:0] dat_in_rsc_dat = {ss_tupsb[1:0], ss_tdata[31:0]};
`else
wire [33:0] dat_in_rsc_dat = {2'b00,         ss_tdata[31:0]};
`endif

wire [33:0] dat_out_rsc_dat;

reg  [31:0]   reg_key1;
reg  [31:0]   reg_key2;
reg  [31:0]   reg_key3;
reg  [31:0]   reg_key4;
reg  [31:0]   reg_nonce1;
reg  [31:0]   reg_nonce2;
reg  [31:0]   reg_nonce3;
reg  [31:0]   reg_nonce4;
reg  [7:0]    reg_adlen;
reg  [7:0]    reg_plen;
reg           reg_rst;

wire awvalid_in;
wire wvalid_in;

reg [31:0] RegisterData;

//write addr channel
assign 	awvalid_in	= awvalid; 
wire awready_out;
assign awready = awready_out;

//write data channel
assign 	wvalid_in	= wvalid;
wire wready_out;
assign wready = wready_out;

// if both awvalid_in=1 and wvalid_in=1 then output awready_out = 1 and wready_out = 1
assign awready_out = (awvalid_in && wvalid_in) ? 1 : 0;
assign wready_out = (awvalid_in && wvalid_in) ? 1 : 0;

//write register
always @(posedge axi_clk or negedge axi_reset_n)  begin
  if ( !axi_reset_n ) begin
    reg_key1    <= 0;
    reg_key2    <= 0;
    reg_key3    <= 0;
    reg_key4    <= 0;
    reg_nonce1  <= 0;
    reg_nonce2  <= 0;
    reg_nonce3  <= 0;
    reg_nonce4  <= 0;
    reg_adlen   <= 0;
    reg_plen    <= 0;
    reg_rst     <= 0;
  end else begin
    if ( awvalid_in && wvalid_in ) begin		//when awvalid_in=1 and wvalid_in=1 means awready_out=1 and wready_out=1
      if          (awaddr[11:2] == 10'h000 ) begin //offset 0
        if ( wstrb[0] == 1) reg_rst           <= wdata[0];
      end else if (awaddr[11:2] == 10'h001 ) begin //offset 1
        if ( wstrb[0] == 1) reg_key1[7:0]     <= wdata[7:0];
        if ( wstrb[1] == 1) reg_key1[15:8]    <= wdata[15:8];
        if ( wstrb[2] == 1) reg_key1[23:16]   <= wdata[23:16];
        if ( wstrb[3] == 1) reg_key1[31:24]   <= wdata[31:24];
      end else if (awaddr[11:2] == 10'h002 ) begin //offset 2
        if ( wstrb[0] == 1) reg_key2[7:0]     <= wdata[7:0];
        if ( wstrb[1] == 1) reg_key2[15:8]    <= wdata[15:8];
        if ( wstrb[2] == 1) reg_key2[23:16]   <= wdata[23:16];
        if ( wstrb[3] == 1) reg_key2[31:24]   <= wdata[31:24];
      end else if (awaddr[11:2] == 10'h003 ) begin //offset 3
        if ( wstrb[0] == 1) reg_key3[7:0]     <= wdata[7:0];
        if ( wstrb[1] == 1) reg_key3[15:8]    <= wdata[15:8];
        if ( wstrb[2] == 1) reg_key3[23:16]   <= wdata[23:16];
        if ( wstrb[3] == 1) reg_key3[31:24]   <= wdata[31:24];
      end else if (awaddr[11:2] == 10'h004 ) begin //offset 4
        if ( wstrb[0] == 1) reg_key4[7:0]     <= wdata[7:0];
        if ( wstrb[1] == 1) reg_key4[15:8]    <= wdata[15:8];
        if ( wstrb[2] == 1) reg_key4[23:16]   <= wdata[23:16];
        if ( wstrb[3] == 1) reg_key4[31:24]   <= wdata[31:24];
      end else if (awaddr[11:2] == 10'h005 ) begin //offset 5
        if ( wstrb[0] == 1) reg_nonce1[7:0]     <= wdata[7:0];
        if ( wstrb[1] == 1) reg_nonce1[15:8]    <= wdata[15:8];
        if ( wstrb[2] == 1) reg_nonce1[23:16]   <= wdata[23:16];
        if ( wstrb[3] == 1) reg_nonce1[31:24]   <= wdata[31:24];
      end else if (awaddr[11:2] == 10'h006 ) begin //offset 6
        if ( wstrb[0] == 1) reg_nonce2[7:0]     <= wdata[7:0];
        if ( wstrb[1] == 1) reg_nonce2[15:8]    <= wdata[15:8];
        if ( wstrb[2] == 1) reg_nonce2[23:16]   <= wdata[23:16];
        if ( wstrb[3] == 1) reg_nonce2[31:24]   <= wdata[31:24];
      end else if (awaddr[11:2] == 10'h007 ) begin //offset 7
        if ( wstrb[0] == 1) reg_nonce3[7:0]     <= wdata[7:0];
        if ( wstrb[1] == 1) reg_nonce3[15:8]    <= wdata[15:8];
        if ( wstrb[2] == 1) reg_nonce3[23:16]   <= wdata[23:16];
        if ( wstrb[3] == 1) reg_nonce3[31:24]   <= wdata[31:24];
      end else if (awaddr[11:2] == 10'h008 ) begin //offset 8
        if ( wstrb[0] == 1) reg_nonce4[7:0]     <= wdata[7:0];
        if ( wstrb[1] == 1) reg_nonce4[15:8]    <= wdata[15:8];
        if ( wstrb[2] == 1) reg_nonce4[23:16]   <= wdata[23:16];
        if ( wstrb[3] == 1) reg_nonce4[31:24]   <= wdata[31:24];
      end else if (awaddr[11:2] == 10'h009 ) begin //offset 9
        if ( wstrb[0] == 1) reg_adlen[7:0]      <= wdata[7:0];
      end else if (awaddr[11:2] == 10'h00A ) begin //offset 10
        if ( wstrb[0] == 1) reg_plen[7:0]       <= wdata[7:0];
      end
    end
  end
end

//read register
reg [(pDATA_WIDTH-1) : 0] rdata_tmp;
assign arready = 1; //always assigned to 1, limitation: only support 1T in arvalid, if master issue 2T in arvalid then only 1st raddr is captured.
reg rvalid_out ;
assign rvalid = rvalid_out;
assign rdata =  rdata_tmp;
reg rd_state;
reg rd_next_state;
reg [pADDR_WIDTH-1:0] rd_addr;

always @(posedge axi_clk or negedge axi_reset_n)  begin
  if ( !axi_reset_n ) 
    rd_state <= RD_IDLE;
  else
    rd_state <= rd_next_state;
end

always@(*)begin
  case(rd_state)
    RD_IDLE:
      if(arvalid && arready) rd_next_state = RD_ADDR_DONE;
      else      rd_next_state = RD_IDLE;
    RD_ADDR_DONE:
      if(rready && rvalid_out) rd_next_state = RD_IDLE;
      else    rd_next_state = RD_ADDR_DONE;
    default:rd_next_state = RD_IDLE;
  endcase
end 

always @(posedge axi_clk or negedge axi_reset_n)  begin
  if ( !axi_reset_n ) begin
    rd_addr <= 0;
	  rvalid_out <= 0;
  end	
  else begin
    if (rd_state == RD_IDLE )
      if(arvalid && arready) begin
        rd_addr <= araddr;
        rvalid_out <= 1;
      end	
    if (rd_state == RD_ADDR_DONE ) 
      if(rready && rvalid_out)
        rvalid_out <= 0;
  end	
end
always @* begin
  if      (rd_addr[11:2] == 10'h000) rdata_tmp = reg_rst;
  else if (rd_addr[11:2] == 10'h001) rdata_tmp = reg_key1;
  else if (rd_addr[11:2] == 10'h002) rdata_tmp = reg_key2;
  else if (rd_addr[11:2] == 10'h003) rdata_tmp = reg_key3;
  else if (rd_addr[11:2] == 10'h004) rdata_tmp = reg_key4;
  else if (rd_addr[11:2] == 10'h005) rdata_tmp = reg_nonce1;
  else if (rd_addr[11:2] == 10'h006) rdata_tmp = reg_nonce2;
  else if (rd_addr[11:2] == 10'h007) rdata_tmp = reg_nonce3;
  else if (rd_addr[11:2] == 10'h008) rdata_tmp = reg_nonce4;
  else if (rd_addr[11:2] == 10'h009) rdata_tmp = reg_adlen;
  else if (rd_addr[11:2] == 10'h00A) rdata_tmp = reg_plen;
  else                              rdata_tmp = 0;
end

//DUT
assign sm_tdata  = dat_out_rsc_dat[31: 0]; 

`ifdef USER_PROJECT_SIDEBAND_SUPPORT
assign sm_tupsb = dat_out_rsc_dat[33:32];
`endif

assign {sm_tstrb, sm_tkeep, sm_tlast} = 0;

wire dat_in_rsc_rdy;

assign ss_tready = dat_in_rsc_rdy;

Encrypt_Top Encrypt_U0 (
  .clk(axi_clk),
  .rst(reg_rst),
  .arst_n(axi_reset_n),
  .key1(reg_key1),
  .key2(reg_key2),
  .key3(reg_key3),
  .key4(reg_key4),
  .nonce1(reg_nonce1),
  .nonce2(reg_nonce2),
  .nonce3(reg_nonce3),
  .nonce4(reg_nonce4),
  .adlen(reg_adlen),
  .plen(reg_plen),
  .data_in_rsc_dat(dat_in_rsc_dat),
  .data_in_rsc_vld(ss_tvalid),
  .data_in_rsc_rdy(dat_in_rsc_rdy),
  .data_out_rsc_dat(dat_out_rsc_dat),
  .data_out_rsc_vld(sm_tvalid),
  .data_out_rsc_rdy(sm_tready)
);

// reg [2:0] r_ptr;
// reg [2:0] w_ptr;
// reg [(FIFO_WIDTH-1) : 0] fifo[7:0];

// wire full;
// wire empty;

// assign empty = (r_ptr == w_ptr);
// assign full = (r_ptr == (w_ptr+1) );

// assign ss_tready = !full;

// //for push to fifo
// always @(posedge axis_clk or negedge axis_rst_n)  begin
//   if ( !axis_rst_n ) begin
//     w_ptr <= 0;
//   end
//   else begin
// 	if ( ss_tready && ss_tvalid) begin
// 		`ifdef USER_PROJECT_SIDEBAND_SUPPORT
// 			fifo[w_ptr] <= {ss_tupsb, ss_tstrb, ss_tkeep, ss_tlast, ss_tdata}; 
// 		`else
// 			fifo[w_ptr] <= {ss_tstrb, ss_tkeep, ss_tlast, ss_tdata}; 
// 		`endif
// 		w_ptr <= w_ptr + 1;
// 	end
//   end
// end  

// //for pop from fifo

// `ifdef USER_PROJECT_SIDEBAND_SUPPORT
// 	assign {sm_tupsb, sm_tstrb, sm_tkeep, sm_tlast, sm_tdata} = fifo[r_ptr];
// `else
// 	assign {sm_tstrb, sm_tkeep, sm_tlast, sm_tdata} = fifo[r_ptr];
// `endif

// assign sm_tvalid = !empty;
// always @(posedge axis_clk or negedge axis_rst_n)  begin
//   if ( !axis_rst_n ) begin
//     r_ptr <= 0;
//   end
//   else begin
// 	if ( sm_tready && sm_tvalid) begin
// 		r_ptr <= r_ptr + 1;
// 	end
//   end
// end  

endmodule // USER_PRJ0



