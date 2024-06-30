// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.1 (lin64) Build 3526262 Mon Apr 18 15:47:01 MDT 2022
// Date        : Mon Jun 17 12:22:23 2024
// Host        : ubuntu2004 running 64-bit Ubuntu 20.04.4 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/ubuntu/SoC_Design/homework/ASOC/ASoC-Final_project-optical_flow/vivado/vvd_caravel_fpga/vvd_caravel_fpga.gen/sources_1/bd/design_1/ip/design_1_blk_mem_gen_0_0/design_1_blk_mem_gen_0_0_sim_netlist.v
// Design      : design_1_blk_mem_gen_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_1_blk_mem_gen_0_0,blk_mem_gen_v8_4_5,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_5,Vivado 2022.1" *) 
(* NotValidForBitStream *)
module design_1_blk_mem_gen_0_0
   (clka,
    rsta,
    ena,
    wea,
    addra,
    dina,
    douta,
    clkb,
    rstb,
    enb,
    web,
    addrb,
    dinb,
    doutb,
    rsta_busy,
    rstb_busy);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE BRAM_CTRL, READ_WRITE_MODE READ_WRITE, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA RST" *) input rsta;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [3:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [31:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [31:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [31:0]douta;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE BRAM_CTRL, READ_WRITE_MODE READ_WRITE, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB RST" *) input rstb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB EN" *) input enb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB WE" *) input [3:0]web;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [31:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DIN" *) input [31:0]dinb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [31:0]doutb;
  output rsta_busy;
  output rstb_busy;

  wire [31:0]addra;
  wire [31:0]addrb;
  wire clka;
  wire clkb;
  wire [31:0]dina;
  wire [31:0]dinb;
  wire [31:0]douta;
  wire [31:0]doutb;
  wire ena;
  wire enb;
  wire rsta;
  wire rsta_busy;
  wire rstb;
  wire rstb_busy;
  wire [3:0]wea;
  wire [3:0]web;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [31:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [31:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [31:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "32" *) 
  (* C_ADDRB_WIDTH = "32" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "8" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "0" *) 
  (* C_COUNT_36K_BRAM = "2" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "1" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "1" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     10.7492 mW" *) 
  (* C_FAMILY = "zynq" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "1" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "1" *) 
  (* C_HAS_RSTB = "1" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "NONE" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "2" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "2048" *) 
  (* C_READ_DEPTH_B = "2048" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "32" *) 
  (* C_READ_WIDTH_B = "32" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "1" *) 
  (* C_USE_BYTE_WEA = "1" *) 
  (* C_USE_BYTE_WEB = "1" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "4" *) 
  (* C_WEB_WIDTH = "4" *) 
  (* C_WRITE_DEPTH_A = "2048" *) 
  (* C_WRITE_DEPTH_B = "2048" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "32" *) 
  (* C_WRITE_WIDTH_B = "32" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  design_1_blk_mem_gen_0_0_blk_mem_gen_v8_4_5 U0
       (.addra({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,addra[12:2],1'b0,1'b0}),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,addrb[12:2],1'b0,1'b0}),
        .clka(clka),
        .clkb(clkb),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb(dinb),
        .douta(douta),
        .doutb(doutb),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(enb),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[31:0]),
        .regcea(1'b0),
        .regceb(1'b0),
        .rsta(rsta),
        .rsta_busy(rsta_busy),
        .rstb(rstb),
        .rstb_busy(rstb_busy),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[31:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[31:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web(web));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2022.1"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
RgPKnWr9n0dGgttm3akiFhAlfB96usOQYxnEmPhGyTGg1AbizYAjGPWLXBWl50n/d0IA71ci4aJB
wt6mtfyNADm3ZReK7D3mKu037BOgxryoEwwf1kiC6q/PllxsdAgEMfQrfHJ3E2AzSpdYjoxVYito
y0JW6CUDcWvWa4WV0EA=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
M0l6KpOGH3jL8eRt3NCD7e2USYnkg5H9GAnE1PKmnjiouFN3Y8kjWA2PZDAQLm9UW+TsC1HeVlzO
WjNCHkjR/6ubCsIcWfpPZWdIuAenlsyq8Y9l6b8vMj8JSbDEOiFF/GHSbKsn22MJdDJKEhHFK6GV
s8gR2vywRFwG69gIRE4qGhVB+WIg8GJrDpDMYH6lCjMkTrjXuKDUcNlJN3NPLuhJ7tsditwf1pr5
moJRmGpJnip/rGm0g4o4A6ev4CtePjoao8C1wFtzHkERX9oenhh7cGjDMejU5IrLv8NxFnLj1FpB
9MuF1beTU20NI5oAn6zLiLiOtXjf0ghU3AN4DA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
hAsrUfp6Qgjm8yBjNYTEtQmVQmMxzL8TE/3oiQSxSI3+yEkXAbQCXkT9mo+LCdv+fGECOB0istHd
eLtbsiYbxjxNxYkXiUrRE5O+aSxynIray+uF9DJigTEUZu8JJXUbzxK4DDUu1Lm9tpGps4+Prz1m
0gkj13RT/Y/418s2VTw=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
BP/54Wm/GJmb1jy0bxWJJX4aiKyiWPVh4X3VL30BQrmX4PlEsNKzBJH3Qu8IIYERfnFP0ifAgboa
vypMQ5Ed0BrMePGkWIgT6I8hxJCMFpHdkSK7m1giSKyZzFfTOrVqoNFXE+qdzLfY1J5hBWCvouYo
jllavK4N3gF9FLScH2AUWYVMcVth2QPaTAU2NLnAUNH8kgtBjBfc8/KbPPTznD1QNVqvFstzcbTA
hGQ1ETVPvINQ0KqxxAG5PRhtQD4+pC+hr/Tvk+RSvGyBOfy9zE86OXkJiYs9dSFhNiMFmCPL9DBO
se4OxNNC0/7aBtb1mkSEA9YFDYEb9jS7Jasy2A==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
SnzT9DVH3xlEN8nrr2YrlvTO5qj7L22d7WaBcuKyTaiHoIwwFHrC4HQbfs0TAwkdWcOgmJoATPSF
F6qm0KiddbrlERF3MfKUldeGBJtqLdX+zGw7+3JD7S+HB9dIMOFOHy+IiCZp1/Pz8epKpi238cel
rcVoJQKz406wmXDvOo8KsT+XhRLs9BVCrBErPGGXKYDk6NXAp0duOgQE9DbslzMU83M/kUC7uERV
tQW02240peKQFp2elEZC7Tetvgp0TaFTtJiKN45REi8GQUCKGa85JjNIk1qb/+k95TIIP1xrHirc
6iX7qbwnPetv8TVu2NjkZ0WDEK5RXdOXcxBwHA==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2021_07", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
erkR82V0jX8ytva+9MzEs0c75Z7j7TsgxWRLNAUfbbU28i+U9YzuZlSfYU75M0f9jx1gvxtBrfKv
cNHVdkR+i5zfHDZsDwfMEEBhs8wzDCKqe+eex6BBEvlIOesCPXrr2RozQgaQ1PBh/os2Arfu+873
BjsVxFJkbhpzIqlddOo/XZV9Yi+eih7A7pXXEBR6IL7Poo4Ka49MiVQU0xJrDTm+ddOuMPDRRD7g
dsxS/uzdcBcO2myV6g/7YH/C2Ce9s6+UywJN/0JeXSqwA7bsBqqnfFicVAT0lckLopMLiuzK7dsN
EwhFeqoetciFrDIj9+o0xDMWBZhgNP1u68vURA==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
R+BI65BKLT0I9hEtsxGnDyM5XY9gzULeTPOSDXvd3KWOzZJAx6C0xlbyZcFZhAEG/QIK2yd0wAi6
IUWxyF/sx3HsqKjhVi5KxnpuXDBOZVoj811O7JukedFVmDW7OHGtBkuiJ5X5irw7mfsEKRQmF/1i
V6lj9HYHZEjxtDeZjACsLY4y1QxWalSKT4HIMOHznBLL8dLbGMlS+ZmFuFn0gcwZavVl7gTkTtkf
W0gn01A9ru7NKsf+iLX0kj4dgItPu9N2g02M1vWQ9UUQEVvfV7lUc7GY1suibrD8aEkhH9S7lZ7n
bFsT4qxyvzg8ML6v4g4v7N6VuyhEtgFgNd725Q==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
jNUVKiwH68vHsU54idgvKwaVJcoxTUuxfgrQpbpmM/IpesWA3wHsGzYClwAxkKzw3KRnFyQqTWcZ
yj1EQ2CMBxlJ0kyNbZW8OK8pXzeigToZ0U6Aq3Gy+j7wBbhe83wE1Ygn82sK8dHTEulvaRLn/c5r
ispy1s7jMKIvYNzoUuZrgyBQyfaYmdqUia8XlQjFd+VwzhTXKwzvmaqHWyaHjfBKeCooO7+oUxMG
OJg83W54EVe9ronFQ8Wr9EOL8ia7qelCAgyQe/bC0HHCoMAm8apI7sX23iMR/wMiPP5V2bQzycy+
rBX/+SWkqSeIE1FLm+muFPvrE7iLwJaW8d1fzdFFjAZ5aIXArbWNfwbK8S0TczXc9lEzmpb69rwA
UJIrs4alo81qGQ32UFhjuMQjX75O9Od1HWHDj5PFaT/Ja5Ly+bK8Cc3gfO6dCE81m7d+B2JBZ/Hl
tBA19QuOAYwT2EIPOdpaVtCULb33cWODWu3qQFhZMmDzKTb3kwpcr0LL

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
MnzcA2swaxH1LRacKDou0ZmiiMRETbWIdHgeBgyQz7ILronsXLoB/C20WuFNGEVSiL2/51EZ6MXZ
vMHI8fFcMQCJcuTBDBibUMKv6bXI9s8fTbtrBZppbF/R1icG5JYhqmX4aRnv4W/dxJRjI2L35nLN
Y48E9OfgfkD1sr+IRwx8WEKFmUhuk8dLe0VOK7ywe3XEcneYvrz+HhPj16bGmNfMwNnDgZ3gKKZD
hRnys+jzvAX3HyISrErWXhMKrhWMxXeTNFJCqNQ0LWAVHQYwyKnF5xVpyXSuGNSIrva+QXqOrZBG
3VNLirNVtMRiKLfwZeMaqvswkqBDAa53utlAAA==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
d0xXkKtsKM8GvXhDZr16p1+oE3uBtD04BJ76eGGIEj/CFECfHVy9qsJ43oSKjas0+AJr4GFFnVb6
X7gJV6MmX/OboC9ier5joUCGz0mxVzkRZK9a+LPEDcg0K6+cLE36kr+FfxW9Uk2816EHBCMCf5mK
A4eAhSmAb5Nq74F/q0quiG416npbny7faiQ+xmPDfYYiM3UuMKaD4iE8ODlz1w5xThPllWESf3LZ
NTkw6fozyTqZ47vvE21O3dgIGAY1v+C6BwlCK24VwPJa1xs9csY+qTk31j5jjAc1ExlB6QF7t9UH
lk70qdNPWxT87OH7kFT8UvPO1D6BTC3/WkDZfA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
LYhdzKTvo93uJrAaiP5OfCDuOnu2BSvPnxlv6I7h2n1+xHtj34LNNKzWEgOg9dUV9cYDaHYUjjEt
DKdWcz6mZ61d5qyxAhpv67fc90v7JVgtOAcT94/Yb+AuLxXFcGA6Gic7uoJtUgz6JmTnb22Dxdjc
KuIewDj4IOTfP8XGXKTaF+cNp0CFrQgTAcVSQFyLFxr0I/9h3S+GZLecA7ntEeHEOfCJzPvy0ddi
7MCdQWECLb+fXC0IAn8V95TumcpINiRAX1BHi9IGJ4QoMrb3jOCrPkFhDMTJj2aiImUWdi/l/0QE
d7wcXlgIEYVeoKYUOJ4mqy+zZPUbLNeOPADUDQ==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 59888)
`pragma protect data_block
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
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
