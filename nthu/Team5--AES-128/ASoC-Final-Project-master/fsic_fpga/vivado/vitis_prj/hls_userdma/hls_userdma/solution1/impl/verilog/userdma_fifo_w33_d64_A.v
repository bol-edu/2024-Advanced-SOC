// ==============================================================
// Generated by Vitis HLS v2023.2
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// ==============================================================
// 67d7842dbbe25473c3c32b93c0da8047785f30d78e8a024de1b57352245f9689

`timescale 1ns/1ps
//RAW latency 2 

module userdma_fifo_w33_d64_A
#(parameter
    MEM_STYLE    = "auto",
    DATA_WIDTH   = 33,
    ADDR_WIDTH   = 6,
    DEPTH        = 63)
(
    // system signal
    input  wire                  clk,
    input  wire                  reset,

    // write
    output wire                  if_full_n,
    input  wire                  if_write_ce,
    input  wire                  if_write,
    input  wire [DATA_WIDTH-1:0] if_din,
    
    // read 
    output wire [ADDR_WIDTH:0]   if_num_data_valid, // for FRP
    output wire [ADDR_WIDTH:0]   if_fifo_cap,       // for FRP

    output wire                  if_empty_n,
    input  wire                  if_read_ce,
    input  wire                  if_read,
    output wire [DATA_WIDTH-1:0] if_dout
);
//------------------------Parameter----------------------

//------------------------Local signal-------------------
    reg  [ADDR_WIDTH-1:0] waddr;
    reg  [ADDR_WIDTH-1:0] raddr;
    wire [ADDR_WIDTH-1:0] wnext;
    wire [ADDR_WIDTH-1:0] rnext;
    wire                  push;
    wire                  pop;
    reg  [ADDR_WIDTH:0]   mOutPtr;
    reg                   empty_n = 1'b0;
    reg                   full_n = 1'b1;
    // has num_data_valid? 
    wire                  num_extra_words;//yes
    reg  [ADDR_WIDTH:0]   num_data_valid; //yes 

    wire                  pop_dout;
    reg  [ADDR_WIDTH:0]   num_data_cnt;
    reg                   dout_vld = 1'b0;

//------------------------Instantiation------------------
    userdma_fifo_w33_d64_A_ram 
    #(  .MEM_STYLE  (MEM_STYLE),
        .DATA_WIDTH (DATA_WIDTH),
        .ADDR_WIDTH (ADDR_WIDTH),
        .DEPTH      (DEPTH)
    ) U_userdma_fifo_w33_d64_A_ram (
        .clk        (clk),
        .reset      (reset),
        .we         (push),
        .waddr      (waddr),
        .din        (if_din),
        .raddr      (raddr),
        .rden       (pop),
        .dout       (if_dout)
    );

//------------------------Task and function--------------

//------------------------Body---------------------------
    // num_data_valid 
    assign if_num_data_valid = num_data_valid;
    assign if_fifo_cap = DEPTH + 1;

    // almost full/empty 

    // program full/empty 

    assign if_full_n  = full_n;
    assign if_empty_n = dout_vld;

    assign push       = full_n & if_write_ce & if_write;
    assign pop        = empty_n & (pop_dout | ~dout_vld);
    assign pop_dout   = dout_vld & if_read_ce & if_read;
    
    assign wnext      = !push                ? waddr :
                        (waddr == DEPTH - 1) ? 1'b0  :
                        waddr + 1'b1;
    assign rnext      = !pop                 ? raddr :
                        (raddr == DEPTH - 1) ? 1'b0  :
                        raddr + 1'b1;

    // waddr
    always @(posedge clk) begin
        if (reset)
            waddr <= {ADDR_WIDTH{1'b0}};
        else
            waddr <= wnext;
    end

    // raddr
    always @(posedge clk) begin
        if (reset)
            raddr <= {ADDR_WIDTH{1'b0}};
        else
            raddr <= rnext;
    end

    // mOutPtr
    always @(posedge clk) begin
        if (reset)
            mOutPtr <= {ADDR_WIDTH+1{1'b0}};
        else if (push & ~pop)
            mOutPtr <= mOutPtr + 1'b1;
        else if (~push & pop)
            mOutPtr <= mOutPtr - 1'b1;
    end

    // full_n 
    always @(posedge clk) begin
        if (reset)
            full_n <= 1'b1;
        else if ((push & ~pop_dout) && (num_data_cnt == DEPTH))
            full_n <= 1'b0;
        else if (~push & pop_dout)
            full_n <= 1'b1;
    end

    // empty_n
    always @(posedge clk) begin
        if (reset)
            empty_n <= 1'b0;
        else if (push & ~pop)
            empty_n <= 1'b1;
        else if ((~push & pop) && (mOutPtr == 1))
            empty_n <= 1'b0;
    end

    // almost_full_n 

    // almost_empty_n 

    // prog_full_n 

    // prog_empty_n 

    // num_data_cnt
    always @(posedge clk) begin
        if (reset)
            num_data_cnt <= {ADDR_WIDTH+1{1'b0}};
        else if ( push & ~pop_dout)
            num_data_cnt <= num_data_cnt + 1'b1;
        else if (~push & pop_dout)
            num_data_cnt <= num_data_cnt - 1'b1;
    end

    // num_data_valid 
    assign num_extra_words = (dout_vld & ~pop_dout) ? 1 : 0;
                             
    always @(posedge clk) begin
        if (reset)
            num_data_valid <= {ADDR_WIDTH+1{1'b0}};
        else if (empty_n | (dout_vld & ~pop_dout))
            num_data_valid <= push + mOutPtr + num_extra_words;
        else
            num_data_valid <= num_extra_words;
    end // 

    // dout_vld
    always @(posedge clk) begin
        if (reset)
            dout_vld <= 1'b0;
        else if (pop)
            dout_vld <= 1'b1;
        else if (pop_dout)
            dout_vld <= 1'b0;
    end

endmodule


module userdma_fifo_w33_d64_A_ram
#(parameter
    MEM_STYLE   = "auto",
    DATA_WIDTH  = 33,
    ADDR_WIDTH  = 6,
    DEPTH       = 63)
(
    input  wire                  clk,
    input  wire                  reset,
    input  wire                  we,
    input  wire [ADDR_WIDTH-1:0] waddr,
    input  wire [DATA_WIDTH-1:0] din,
    input  wire [ADDR_WIDTH-1:0] raddr,
    input  wire                  rden,
    output wire [DATA_WIDTH-1:0] dout
);

    (* ram_style = MEM_STYLE *)
    reg  [DATA_WIDTH-1:0] mem[0:DEPTH-1];
    reg  [DATA_WIDTH-1:0] mem_reg;

    always @(posedge clk) begin
        if (we)
            mem[waddr] <= din;
    end

    always @(posedge clk) begin
        if (reset)
            mem_reg <= 0;
        else if (rden)
            mem_reg <= mem[raddr];
    end
    
    assign dout = mem_reg;

endmodule