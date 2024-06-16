module fir # (
    parameter pADDR_WIDTH = 12,
    parameter pDATA_WIDTH = 32,
    parameter Tape_Num    = 11
)
(
    // AXI-Lite (configuration)
    output  wire                     awready,
    output  wire                     wready,
    input   wire                     awvalid,
    input   wire [(pADDR_WIDTH-1):0] awaddr,
    input   wire                     wvalid,
    input   wire [(pDATA_WIDTH-1):0] wdata,
    output  wire                     arready,
    input   wire                     rready,
    input   wire                     arvalid,
    input   wire [(pADDR_WIDTH-1):0] araddr,
    output  wire                     rvalid,
    output  wire [(pDATA_WIDTH-1):0] rdata,    
    // AXI-Stream slave (for input data)
    input   wire                     ss_tvalid, 
    input   wire [(pDATA_WIDTH-1):0] ss_tdata, 
    input   wire                     ss_tlast, 
    output  wire                     ss_tready, 
    // AXI-Stream master (for output data)
    input   wire                     sm_tready, 
    output  wire                     sm_tvalid, 
    output  wire [(pDATA_WIDTH-1):0] sm_tdata, 
    output  wire                     sm_tlast, 
    
    // bram for tap RAM
    output  reg  [3:0]               tap_WE,
    output  wire                     tap_EN,
    output  reg  [(pDATA_WIDTH-1):0] tap_Di,
    output  reg  [(pADDR_WIDTH-1):0] tap_A,
    input   wire [(pDATA_WIDTH-1):0] tap_Do,

    // bram for data RAM
    output  reg  [3:0]               data_WE,
    output  wire                     data_EN,
    output  reg  [(pDATA_WIDTH-1):0] data_Di,
    output  reg  [(pADDR_WIDTH-1):0] data_A,
    input   wire [(pDATA_WIDTH-1):0] data_Do,

    input   wire                     axis_clk,
    input   wire                     axis_rst_n
);

    // AXI-Lite output assignmnet
    reg awready_r, awready_w;
    reg wready_r, wready_w;
    reg arready_r, arready_w;
    reg rvalid_r, rvalid_w;
    reg [(pDATA_WIDTH-1):0] rdata_r, rdata_w;

    assign awready = awready_r;
    assign wready  = wready_r;
    assign arready = arready_r;
    assign rvalid  = rvalid_r;
    assign rdata   = rdata_r;

    // AXI-Stream output assignmnet
    reg ss_tready_r, ss_tready_w;
    reg sm_tvalid_r, sm_tvalid_w;
    reg sm_tlast_r, sm_tlast_w;
    reg [(pDATA_WIDTH-1):0] sm_tdata_r, sm_tdata_w;

    assign ss_tready = ss_tready_r;
    assign sm_tvalid = sm_tvalid_r;
    assign sm_tlast  = sm_tlast_r;
    assign sm_tdata  = sm_tdata_r;

    // configuration registers
    // 0x00: [bit 0] ap_start, [bit 1] ap_done, [bit 2] ap_idle
    // 0x10-0x14: data length
    // 0x20-0xFF: tap coefficients (store in bram)
    reg [31:0] ap_ctrl_r, ap_ctrl_w;
    reg [31:0] data_len_r, data_len_w;

    // FIR: y[n] = sum(h[i] * x[n-i]), i = 0-10
    // FIR control
    localparam ID_BW = $clog2(Tape_Num);
    reg  [(ID_BW-1):0]       data_first_id_r, data_first_id_w;  // address of x[n-10]
    reg  [(ID_BW-1):0]       data_last_id_r, data_last_id_w;    // address of x[n]
    reg  [(ID_BW-1):0]       num_data_r, num_data_w;            // number of data stored in the memory (RAM) (i.e. 0 ~ 10)
    reg  [(pADDR_WIDTH-1):0] tap_addr_r, tap_addr_w;            // pointer to read out tap coefficient from memory (RAM)
    reg  [(pADDR_WIDTH-1):0] data_addr_r, data_addr_w;          // pointer to read out data from memory (RAM)
    reg  [(pDATA_WIDTH-1):0] psum_r, psum_w;                    // accumulation result
    reg  [(ID_BW-1):0]       counter_r, counter_w;              // count number of accumulated data
    reg                      last_flag_r, last_flag_w;          // last data flag

    // Main FSM
    localparam S_IDLE      = 3'd0;
    localparam S_LOAD      = 3'd1;
    localparam S_PROC      = 3'd2;
    localparam S_OUTPUT    = 3'd3;
    localparam S_DONE      = 3'd4;
    localparam S_DONE_WAIT = 3'd5;
    reg  [2:0] state_r, state_w;
    reg        read_ap_ctrl_r, read_ap_ctrl_w;  // flag indicates if tb reads the control register
    wire       fir_idle, fir_done;
    assign fir_idle = (state_r == S_IDLE);
    assign fir_done = (state_r == S_DONE) || (state_r == S_DONE_WAIT);

    // AXI-Lite (configuration)
    localparam S_AXI_AR   = 2'd0;
    localparam S_AXI_R    = 2'd1;
    localparam S_AXI_WAIT = 2'd2;
    reg [1:0]               axil_rstate_r, axil_rstate_w;
    reg [(pADDR_WIDTH-1):0] axil_raddr_r, axil_raddr_w;

    // mux signals for tap RAM control
    reg  [3:0]               idle_tap_WE;
    reg  [(pDATA_WIDTH-1):0] idle_tap_Di;
    reg  [(pADDR_WIDTH-1):0] idle_tap_A_R, idle_tap_A_W;  // address for read/write channel
    always @(*) begin
        if (state_r != S_IDLE) begin
            tap_WE = 0;
            tap_Di = 0;
            tap_A  = tap_addr_w;  // set read_addr 1 cycle earlier
        end
        else begin
            tap_WE = idle_tap_WE;
            tap_Di = idle_tap_Di;
            tap_A  = (arready_w) ? idle_tap_A_R : idle_tap_A_W;  // give priority to read channel
        end
    end

    // main control
    assign data_EN = 1;
    always @(*) begin
        state_w = state_r;

        ss_tready_w = 0;
        sm_tvalid_w = 0;
        sm_tdata_w  = sm_tdata_r;
        sm_tlast_w  = 0;

        data_WE = 0;
        data_Di = 0;
        data_A  = 0;

        data_first_id_w = data_first_id_r;
        data_last_id_w  = data_last_id_r;
        num_data_w  = num_data_r;
        tap_addr_w  = tap_addr_r;
        data_addr_w = data_addr_r;
        psum_w      = psum_r;
        counter_w   = counter_r;
        last_flag_w = last_flag_r;

        case (state_r)
            S_LOAD: begin
                if (ss_tvalid && (~ss_tready_r)) begin
                    ss_tready_w = 1;
                    data_WE     = 4'hf;
                    data_Di     = ss_tdata;
                    data_A      = data_last_id_r * 4;  // write 4-byte data
                    state_w     = S_PROC;

                    data_last_id_w = (data_last_id_r < (Tape_Num-1)) ? (data_last_id_r + 1) : 0;
                    num_data_w  = (num_data_r < Tape_Num) ? (num_data_r + 1) : num_data_r;
                    tap_addr_w  = (num_data_r < Tape_Num) ? (num_data_r * 4) : ((Tape_Num-1) * 4);  // 4-byte tap coefficient, addr <= 0x28
                    data_addr_w = data_first_id_r * 4;
                    psum_w      = 0;
                    counter_w   = 0;
                    last_flag_w = ss_tlast;
                end
            end
            S_PROC: begin
                data_addr_w = (data_addr_r >= ((Tape_Num-1) * 4)) ? 0 : (data_addr_r + 4);  // 4-byte data, addr <= 0x28
                data_A      = data_addr_r;
                counter_w   = counter_r + 1;
                if (counter_r != 0) begin
                    tap_addr_w = tap_addr_r - 4;               // 4-byte tap coefficient
                    psum_w     = psum_r + (tap_Do * data_Do);
                end
                if (counter_r == num_data_r) begin
                    state_w = S_OUTPUT;
                end
            end
            S_OUTPUT: begin
                sm_tvalid_w = 1;
                sm_tdata_w  = psum_r;
                sm_tlast_w  = last_flag_r;
                
                if (sm_tready && ((~last_flag_r) || (axil_rstate_r == S_AXI_AR))) begin  // wait for axil_rstate_r to be S_AXI_AR, and then output the last data
                    sm_tvalid_w = ~sm_tvalid_r;
                    
                    if (num_data_r >= Tape_Num) begin
                        // pop out data
                        data_first_id_w = (data_first_id_r < (Tape_Num-1)) ? (data_first_id_r + 1) : 0;
                    end
                    else begin
                        data_first_id_w = data_first_id_r;
                    end

                    // reset
                    tap_addr_w  = 0;
                    data_addr_w = 0;
                    psum_w      = 0;
                    counter_w   = 0;
                    last_flag_w = 0;

                    if (last_flag_r) begin
                        state_w = S_DONE;
                    end
                    else begin
                        state_w = S_LOAD;
                    end
                end
            end
            S_DONE: begin
                // reset
                data_first_id_w = 0;
                data_last_id_w  = 0;
                num_data_w  = 0;
                tap_addr_w  = 0;
                data_addr_w = 0;
                psum_w      = 0;
                counter_w   = 0;
                last_flag_w = 0;
                
                state_w = S_DONE_WAIT;
            end
            S_DONE_WAIT: begin
                // wait for ctrl reg to be read
                if (read_ap_ctrl_r)
                    state_w = S_IDLE;
                else
                    state_w = state_r;
            end
            default: begin  // S_IDLE
                if (ap_ctrl_r[0])
                    state_w = S_LOAD;
                else
                    state_w = state_r;
            end
        endcase
    end

    always @(posedge axis_clk or negedge axis_rst_n) begin
        if (~axis_rst_n) begin
            data_first_id_r <= 0;
            data_last_id_r  <= 0;
            num_data_r      <= 0;
            tap_addr_r      <= 0;
            data_addr_r     <= 0;
            psum_r          <= 0;
            counter_r       <= 0;
            last_flag_r     <= 0;
        end
        else begin
            data_first_id_r <= data_first_id_w;
            data_last_id_r  <= data_last_id_w;
            num_data_r      <= num_data_w;
            tap_addr_r      <= tap_addr_w;
            data_addr_r     <= data_addr_w;
            psum_r          <= psum_w;
            counter_r       <= counter_w;
            last_flag_r     <= last_flag_w;
        end
    end

    // AXI-Stream
    always @(posedge axis_clk or negedge axis_rst_n) begin
        if (~axis_rst_n) begin
            ss_tready_r <= 0;
            sm_tvalid_r <= 0;
            sm_tlast_r  <= 0;
            sm_tdata_r  <= 0;
        end
        else begin
            ss_tready_r <= ss_tready_w;
            sm_tvalid_r <= sm_tvalid_w;
            sm_tlast_r  <= sm_tlast_w;
            sm_tdata_r  <= sm_tdata_w;
        end
    end

    // AXI-Lite control
    // write channel (effective only when fir is idle)
    assign tap_EN = 1;
    always @(*) begin
        ap_ctrl_w  = {ap_ctrl_r[31:3], fir_idle, fir_done, ap_ctrl_r[0]};
        data_len_w = data_len_r;

        awready_w = 0;
        wready_w  = 0;

        idle_tap_WE  = 0;
        idle_tap_Di  = 0;
        idle_tap_A_W = 0;
        if (fir_idle) begin
            if (awvalid && wvalid && (~awready_r) && (~wready_r) && (~arready_w)) begin  // give priority to read channel
                awready_w = 1;
                wready_w  = 1;
                if (awaddr == 'h00) begin
                    ap_ctrl_w = wdata;
                end
                else if ((awaddr >= 'h10) && (awaddr < 'h14)) begin
                    data_len_w = wdata;
                end
                else if (awaddr >= 'h20) begin
                    idle_tap_WE  = 4'hf;
                    idle_tap_Di  = wdata;
                    idle_tap_A_W = (awaddr - 'h20);
                end
            end
        end
        else begin
            ap_ctrl_w = {ap_ctrl_r[31:3], fir_idle, fir_done, 1'b0};  // reset ap_start
        end
    end
    // read channel
    always @(*) begin
        arready_w = 0;
        rvalid_w  = rvalid_r;
        rdata_w   = rdata_r;

        axil_raddr_w  = axil_raddr_r;
        axil_rstate_w = axil_rstate_r;
        
        read_ap_ctrl_w = read_ap_ctrl_r;

        idle_tap_A_R = 0;

        case (axil_rstate_r)
            S_AXI_R: begin
                axil_rstate_w = S_AXI_WAIT;
                if (axil_raddr_r == 'h00) begin
                    rvalid_w       = 1;
                    rdata_w        = ap_ctrl_r;
                    read_ap_ctrl_w = 1;
                end
                else if ((axil_raddr_r >= 'h10) && (axil_raddr_r < 'h14)) begin
                    rvalid_w = 1;
                    rdata_w  = data_len_r;
                end
                else if (axil_raddr_r >= 'h20) begin
                    rvalid_w = 1;
                    rdata_w  = tap_Do;
                end
            end
            S_AXI_WAIT: begin
                if (rvalid_r && rready) begin
                    axil_rstate_w  = S_AXI_AR;
                    rvalid_w       = 0;
                    rdata_w        = 0;
                    read_ap_ctrl_w = 0;
                end
            end
            default: begin // S_AXI_AR
                // disable read channel when (state_r == S_OUTPUT) or (state_r == S_DONE)
                if (((araddr < 'h14) || fir_idle) && (state_r != S_OUTPUT) && (state_r != S_DONE)) begin
                    if (arvalid && (~arready_r)) begin
                        arready_w     = 1;
                        axil_raddr_w  = araddr;
                        axil_rstate_w = S_AXI_R;
                        idle_tap_A_R  = (fir_idle && (araddr >= 'h20)) ? (araddr - 'h20) : 0;
                    end
                end
            end
        endcase
    end

    always @(posedge axis_clk or negedge axis_rst_n) begin
        if (~axis_rst_n) begin
            awready_r <= 0;
            wready_r  <= 0;
            arready_r <= 0;
            rvalid_r  <= 0;
            rdata_r   <= 0;

            axil_rstate_r <= S_AXI_AR;
            axil_raddr_r  <= 0;

            read_ap_ctrl_r <= 0;
        end
        else begin
            awready_r <= awready_w;
            wready_r  <= wready_w;
            arready_r <= arready_w;
            rvalid_r  <= rvalid_w;
            rdata_r   <= rdata_w;

            axil_rstate_r <= axil_rstate_w;
            axil_raddr_r  <= axil_raddr_w;

            read_ap_ctrl_r <= read_ap_ctrl_w;
        end
    end

    always @(posedge axis_clk or negedge axis_rst_n) begin
        if (~axis_rst_n) begin
            state_r    <= S_IDLE;
            ap_ctrl_r  <= 0;
            data_len_r <= 0;
        end
        else begin
            state_r    <= state_w;
            ap_ctrl_r  <= ap_ctrl_w;
            data_len_r <= data_len_w;
        end
    end

endmodule