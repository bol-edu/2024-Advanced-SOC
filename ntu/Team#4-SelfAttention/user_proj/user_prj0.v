module USER_PRJ0 #( 
    parameter pUSER_PROJECT_SIDEBAND_WIDTH   = 5,
    parameter pADDR_WIDTH   = 12,
    parameter pDATA_WIDTH   = 32
)(
  output reg                         awready,
  output wire                        arready,
  output reg                         wready,
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


assign arready       = 1'b0;
assign rvalid        = 1'b0;
assign rdata         = {pDATA_WIDTH{1'b0}};
assign sm_tid        = 3'b0;
`ifdef USER_PROJECT_SIDEBAND_SUPPORT
  assign sm_tupsb      = 5'b0;
`endif
assign sm_tstrb      = 4'b0;
assign sm_tkeep      = 1'b0;
assign sm_tlast      = 1'b0;
assign low__pri_irq  = 1'b0;
assign High_pri_req  = 1'b0;
assign la_data_o     = 24'b0;


reg    [3:0]	head;
reg    [5:0] 	length;
reg    [6:0]  	dim;

ATTENTION_IP_Attention_Top attention_inst(
	.clk(axis_clk),
	.rst(!axis_rst_n),
	.arst_n(axis_rst_n),
	.head(head),
	.length(length),
	.dim(dim),
	.din_chan_rsc_dat(ss_tdata[15:0]),
	.din_chan_rsc_vld(ss_tvalid),
	.din_chan_rsc_rdy(ss_tready),
	.dout_chan_rsc_dat(sm_tdata[15:0]),
	.dout_chan_rsc_vld(sm_tvalid),
	.dout_chan_rsc_rdy(sm_tready)
);

// deal with axi_lite write
always @(posedge axis_clk or negedge axis_rst_n) begin
	if (!axis_rst_n) begin
		awready <= 0;
		wready <= 0;
	end
	else begin
		awready <= 1;
		wready <= 1;
	end
end

// write head, dim, length
always @(posedge axis_clk or negedge axis_rst_n) begin
	if (!axis_rst_n) begin
		head <= 0;
		dim <= 0;
		length <= 0;
	end
	else begin
		head <= head;
		dim <= dim;
		length <= length;
		if (awready && wready && awvalid && wvalid) begin
			case (awaddr[11:0])
				12'd4: begin
					head <= wdata;
				end
				12'd8: begin
					dim <= wdata;
				end
				12'd12: begin
					length <= wdata;
				end
			endcase
		end
	end
end

endmodule // USER_PRJ0
