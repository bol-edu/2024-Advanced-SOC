-- ==============================================================
-- RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.1 (64-bit)
-- Version: 2022.1
-- Copyright (C) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity userdma_sendoutstream is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_continue : IN STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    outbuf_dout : IN STD_LOGIC_VECTOR (39 downto 0);
    outbuf_num_data_valid : IN STD_LOGIC_VECTOR (10 downto 0);
    outbuf_fifo_cap : IN STD_LOGIC_VECTOR (10 downto 0);
    outbuf_empty_n : IN STD_LOGIC;
    outbuf_read : OUT STD_LOGIC;
    outcount48_dout : IN STD_LOGIC_VECTOR (31 downto 0);
    outcount48_num_data_valid : IN STD_LOGIC_VECTOR (6 downto 0);
    outcount48_fifo_cap : IN STD_LOGIC_VECTOR (6 downto 0);
    outcount48_empty_n : IN STD_LOGIC;
    outcount48_read : OUT STD_LOGIC;
    in_en_clrsts_dout : IN STD_LOGIC_VECTOR (0 downto 0);
    in_en_clrsts_num_data_valid : IN STD_LOGIC_VECTOR (1 downto 0);
    in_en_clrsts_fifo_cap : IN STD_LOGIC_VECTOR (1 downto 0);
    in_en_clrsts_empty_n : IN STD_LOGIC;
    in_en_clrsts_read : OUT STD_LOGIC;
    m2s_buf_sts : OUT STD_LOGIC_VECTOR (0 downto 0);
    m2s_buf_sts_ap_vld : OUT STD_LOGIC;
    sts_clear_dout : IN STD_LOGIC_VECTOR (0 downto 0);
    sts_clear_num_data_valid : IN STD_LOGIC_VECTOR (2 downto 0);
    sts_clear_fifo_cap : IN STD_LOGIC_VECTOR (2 downto 0);
    sts_clear_empty_n : IN STD_LOGIC;
    sts_clear_read : OUT STD_LOGIC;
    outStreamTop_TDATA : OUT STD_LOGIC_VECTOR (31 downto 0);
    outStreamTop_TVALID : OUT STD_LOGIC;
    outStreamTop_TREADY : IN STD_LOGIC;
    outStreamTop_TKEEP : OUT STD_LOGIC_VECTOR (3 downto 0);
    outStreamTop_TSTRB : OUT STD_LOGIC_VECTOR (3 downto 0);
    outStreamTop_TUSER : OUT STD_LOGIC_VECTOR (6 downto 0);
    outStreamTop_TLAST : OUT STD_LOGIC_VECTOR (0 downto 0) );
end;


architecture behav of userdma_sendoutstream is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_state1 : STD_LOGIC_VECTOR (4 downto 0) := "00001";
    constant ap_ST_fsm_state2 : STD_LOGIC_VECTOR (4 downto 0) := "00010";
    constant ap_ST_fsm_state3 : STD_LOGIC_VECTOR (4 downto 0) := "00100";
    constant ap_ST_fsm_state4 : STD_LOGIC_VECTOR (4 downto 0) := "01000";
    constant ap_ST_fsm_state5 : STD_LOGIC_VECTOR (4 downto 0) := "10000";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv32_1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000001";
    constant ap_const_lv32_2 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000010";
    constant ap_const_lv32_3 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000011";
    constant ap_const_lv32_4 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000100";
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv11_0 : STD_LOGIC_VECTOR (10 downto 0) := "00000000000";

attribute shreg_extract : string;
    signal ap_done_reg : STD_LOGIC := '0';
    signal ap_CS_fsm : STD_LOGIC_VECTOR (4 downto 0) := "00001";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_state1 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state1 : signal is "none";
    signal outcount48_blk_n : STD_LOGIC;
    signal ap_CS_fsm_state2 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state2 : signal is "none";
    signal in_en_clrsts_blk_n : STD_LOGIC;
    signal sts_clear_blk_n : STD_LOGIC;
    signal in_en_clrsts_read_read_fu_74_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal in_en_clrsts_read_reg_138 : STD_LOGIC_VECTOR (0 downto 0);
    signal tmp_reg_151 : STD_LOGIC_VECTOR (31 downto 0);
    signal grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_ap_start : STD_LOGIC;
    signal grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_ap_done : STD_LOGIC;
    signal grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_ap_idle : STD_LOGIC;
    signal grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_ap_ready : STD_LOGIC;
    signal grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_outbuf_read : STD_LOGIC;
    signal grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_outStreamTop_TDATA : STD_LOGIC_VECTOR (31 downto 0);
    signal grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_outStreamTop_TVALID : STD_LOGIC;
    signal grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_outStreamTop_TREADY : STD_LOGIC;
    signal grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_outStreamTop_TKEEP : STD_LOGIC_VECTOR (3 downto 0);
    signal grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_outStreamTop_TSTRB : STD_LOGIC_VECTOR (3 downto 0);
    signal grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_outStreamTop_TUSER : STD_LOGIC_VECTOR (6 downto 0);
    signal grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_outStreamTop_TLAST : STD_LOGIC_VECTOR (0 downto 0);
    signal grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_p_phi_out : STD_LOGIC_VECTOR (0 downto 0);
    signal grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_p_phi_out_ap_vld : STD_LOGIC;
    signal grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_ap_start_reg : STD_LOGIC := '0';
    signal ap_CS_fsm_state3 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state3 : signal is "none";
    signal ap_CS_fsm_state4 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state4 : signal is "none";
    signal p_phi_loc_fu_66 : STD_LOGIC_VECTOR (0 downto 0);
    signal p_phi_loc_load_load_fu_124_p1 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_CS_fsm_state5 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state5 : signal is "none";
    signal out_val_last_V_fu_70 : STD_LOGIC_VECTOR (0 downto 0);
    signal regslice_both_outStreamTop_V_data_V_U_apdone_blk : STD_LOGIC;
    signal ap_block_state1 : BOOLEAN;
    signal sts_clear_read_read_fu_80_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal m2s_buf_sts_preg : STD_LOGIC_VECTOR (0 downto 0) := "0";
    signal ap_NS_fsm : STD_LOGIC_VECTOR (4 downto 0);
    signal ap_ST_fsm_state1_blk : STD_LOGIC;
    signal ap_ST_fsm_state2_blk : STD_LOGIC;
    signal ap_ST_fsm_state3_blk : STD_LOGIC;
    signal ap_ST_fsm_state4_blk : STD_LOGIC;
    signal ap_ST_fsm_state5_blk : STD_LOGIC;
    signal outStreamTop_TVALID_int_regslice : STD_LOGIC;
    signal outStreamTop_TREADY_int_regslice : STD_LOGIC;
    signal regslice_both_outStreamTop_V_data_V_U_vld_out : STD_LOGIC;
    signal regslice_both_outStreamTop_V_keep_V_U_apdone_blk : STD_LOGIC;
    signal regslice_both_outStreamTop_V_keep_V_U_ack_in_dummy : STD_LOGIC;
    signal regslice_both_outStreamTop_V_keep_V_U_vld_out : STD_LOGIC;
    signal regslice_both_outStreamTop_V_strb_V_U_apdone_blk : STD_LOGIC;
    signal regslice_both_outStreamTop_V_strb_V_U_ack_in_dummy : STD_LOGIC;
    signal regslice_both_outStreamTop_V_strb_V_U_vld_out : STD_LOGIC;
    signal regslice_both_outStreamTop_V_user_V_U_apdone_blk : STD_LOGIC;
    signal regslice_both_outStreamTop_V_user_V_U_ack_in_dummy : STD_LOGIC;
    signal regslice_both_outStreamTop_V_user_V_U_vld_out : STD_LOGIC;
    signal regslice_both_outStreamTop_V_last_V_U_apdone_blk : STD_LOGIC;
    signal regslice_both_outStreamTop_V_last_V_U_ack_in_dummy : STD_LOGIC;
    signal regslice_both_outStreamTop_V_last_V_U_vld_out : STD_LOGIC;
    signal ap_ce_reg : STD_LOGIC;

    component userdma_sendoutstream_Pipeline_VITIS_LOOP_155_2 IS
    port (
        ap_clk : IN STD_LOGIC;
        ap_rst : IN STD_LOGIC;
        ap_start : IN STD_LOGIC;
        ap_done : OUT STD_LOGIC;
        ap_idle : OUT STD_LOGIC;
        ap_ready : OUT STD_LOGIC;
        out_val_last_V : IN STD_LOGIC_VECTOR (0 downto 0);
        tmp : IN STD_LOGIC_VECTOR (31 downto 0);
        outbuf_dout : IN STD_LOGIC_VECTOR (39 downto 0);
        outbuf_num_data_valid : IN STD_LOGIC_VECTOR (10 downto 0);
        outbuf_fifo_cap : IN STD_LOGIC_VECTOR (10 downto 0);
        outbuf_empty_n : IN STD_LOGIC;
        outbuf_read : OUT STD_LOGIC;
        outStreamTop_TDATA : OUT STD_LOGIC_VECTOR (31 downto 0);
        outStreamTop_TVALID : OUT STD_LOGIC;
        outStreamTop_TREADY : IN STD_LOGIC;
        outStreamTop_TKEEP : OUT STD_LOGIC_VECTOR (3 downto 0);
        outStreamTop_TSTRB : OUT STD_LOGIC_VECTOR (3 downto 0);
        outStreamTop_TUSER : OUT STD_LOGIC_VECTOR (6 downto 0);
        outStreamTop_TLAST : OUT STD_LOGIC_VECTOR (0 downto 0);
        p_phi_out : OUT STD_LOGIC_VECTOR (0 downto 0);
        p_phi_out_ap_vld : OUT STD_LOGIC );
    end component;


    component userdma_regslice_both IS
    generic (
        DataWidth : INTEGER );
    port (
        ap_clk : IN STD_LOGIC;
        ap_rst : IN STD_LOGIC;
        data_in : IN STD_LOGIC_VECTOR (DataWidth-1 downto 0);
        vld_in : IN STD_LOGIC;
        ack_in : OUT STD_LOGIC;
        data_out : OUT STD_LOGIC_VECTOR (DataWidth-1 downto 0);
        vld_out : OUT STD_LOGIC;
        ack_out : IN STD_LOGIC;
        apdone_blk : OUT STD_LOGIC );
    end component;



begin
    grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101 : component userdma_sendoutstream_Pipeline_VITIS_LOOP_155_2
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        ap_start => grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_ap_start,
        ap_done => grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_ap_done,
        ap_idle => grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_ap_idle,
        ap_ready => grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_ap_ready,
        out_val_last_V => out_val_last_V_fu_70,
        tmp => tmp_reg_151,
        outbuf_dout => outbuf_dout,
        outbuf_num_data_valid => ap_const_lv11_0,
        outbuf_fifo_cap => ap_const_lv11_0,
        outbuf_empty_n => outbuf_empty_n,
        outbuf_read => grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_outbuf_read,
        outStreamTop_TDATA => grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_outStreamTop_TDATA,
        outStreamTop_TVALID => grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_outStreamTop_TVALID,
        outStreamTop_TREADY => grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_outStreamTop_TREADY,
        outStreamTop_TKEEP => grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_outStreamTop_TKEEP,
        outStreamTop_TSTRB => grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_outStreamTop_TSTRB,
        outStreamTop_TUSER => grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_outStreamTop_TUSER,
        outStreamTop_TLAST => grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_outStreamTop_TLAST,
        p_phi_out => grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_p_phi_out,
        p_phi_out_ap_vld => grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_p_phi_out_ap_vld);

    regslice_both_outStreamTop_V_data_V_U : component userdma_regslice_both
    generic map (
        DataWidth => 32)
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        data_in => grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_outStreamTop_TDATA,
        vld_in => grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_outStreamTop_TVALID,
        ack_in => outStreamTop_TREADY_int_regslice,
        data_out => outStreamTop_TDATA,
        vld_out => regslice_both_outStreamTop_V_data_V_U_vld_out,
        ack_out => outStreamTop_TREADY,
        apdone_blk => regslice_both_outStreamTop_V_data_V_U_apdone_blk);

    regslice_both_outStreamTop_V_keep_V_U : component userdma_regslice_both
    generic map (
        DataWidth => 4)
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        data_in => grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_outStreamTop_TKEEP,
        vld_in => grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_outStreamTop_TVALID,
        ack_in => regslice_both_outStreamTop_V_keep_V_U_ack_in_dummy,
        data_out => outStreamTop_TKEEP,
        vld_out => regslice_both_outStreamTop_V_keep_V_U_vld_out,
        ack_out => outStreamTop_TREADY,
        apdone_blk => regslice_both_outStreamTop_V_keep_V_U_apdone_blk);

    regslice_both_outStreamTop_V_strb_V_U : component userdma_regslice_both
    generic map (
        DataWidth => 4)
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        data_in => grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_outStreamTop_TSTRB,
        vld_in => grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_outStreamTop_TVALID,
        ack_in => regslice_both_outStreamTop_V_strb_V_U_ack_in_dummy,
        data_out => outStreamTop_TSTRB,
        vld_out => regslice_both_outStreamTop_V_strb_V_U_vld_out,
        ack_out => outStreamTop_TREADY,
        apdone_blk => regslice_both_outStreamTop_V_strb_V_U_apdone_blk);

    regslice_both_outStreamTop_V_user_V_U : component userdma_regslice_both
    generic map (
        DataWidth => 7)
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        data_in => grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_outStreamTop_TUSER,
        vld_in => grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_outStreamTop_TVALID,
        ack_in => regslice_both_outStreamTop_V_user_V_U_ack_in_dummy,
        data_out => outStreamTop_TUSER,
        vld_out => regslice_both_outStreamTop_V_user_V_U_vld_out,
        ack_out => outStreamTop_TREADY,
        apdone_blk => regslice_both_outStreamTop_V_user_V_U_apdone_blk);

    regslice_both_outStreamTop_V_last_V_U : component userdma_regslice_both
    generic map (
        DataWidth => 1)
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        data_in => grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_outStreamTop_TLAST,
        vld_in => grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_outStreamTop_TVALID,
        ack_in => regslice_both_outStreamTop_V_last_V_U_ack_in_dummy,
        data_out => outStreamTop_TLAST,
        vld_out => regslice_both_outStreamTop_V_last_V_U_vld_out,
        ack_out => outStreamTop_TREADY,
        apdone_blk => regslice_both_outStreamTop_V_last_V_U_apdone_blk);





    ap_CS_fsm_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_CS_fsm <= ap_ST_fsm_state1;
            else
                ap_CS_fsm <= ap_NS_fsm;
            end if;
        end if;
    end process;


    ap_done_reg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_done_reg <= ap_const_logic_0;
            else
                if ((ap_continue = ap_const_logic_1)) then 
                    ap_done_reg <= ap_const_logic_0;
                elsif (((ap_const_logic_1 = ap_CS_fsm_state5) and (regslice_both_outStreamTop_V_data_V_U_apdone_blk = ap_const_logic_0) and ((in_en_clrsts_read_reg_138 = ap_const_lv1_1) or (p_phi_loc_load_load_fu_124_p1 = ap_const_lv1_1)))) then 
                    ap_done_reg <= ap_const_logic_1;
                end if; 
            end if;
        end if;
    end process;


    grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_ap_start_reg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_ap_start_reg <= ap_const_logic_0;
            else
                if ((ap_const_logic_1 = ap_CS_fsm_state3)) then 
                    grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_ap_start_reg <= ap_const_logic_1;
                elsif ((grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_ap_ready = ap_const_logic_1)) then 
                    grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_ap_start_reg <= ap_const_logic_0;
                end if; 
            end if;
        end if;
    end process;


    m2s_buf_sts_preg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                m2s_buf_sts_preg <= ap_const_lv1_0;
            else
                if (((in_en_clrsts_read_reg_138 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state5) and (regslice_both_outStreamTop_V_data_V_U_apdone_blk = ap_const_logic_0) and (p_phi_loc_load_load_fu_124_p1 = ap_const_lv1_1))) then 
                    m2s_buf_sts_preg <= ap_const_lv1_1;
                elsif ((not(((sts_clear_empty_n = ap_const_logic_0) or (in_en_clrsts_empty_n = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or (ap_start = ap_const_logic_0))) and (in_en_clrsts_read_read_fu_74_p2 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state1) and (sts_clear_read_read_fu_80_p2 = ap_const_lv1_1))) then 
                    m2s_buf_sts_preg <= ap_const_lv1_0;
                end if; 
            end if;
        end if;
    end process;

    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_logic_1 = ap_CS_fsm_state1)) then
                in_en_clrsts_read_reg_138 <= in_en_clrsts_dout;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((in_en_clrsts_read_reg_138 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state5) and (regslice_both_outStreamTop_V_data_V_U_apdone_blk = ap_const_logic_0))) then
                out_val_last_V_fu_70 <= p_phi_loc_fu_66;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_p_phi_out_ap_vld = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_state4))) then
                p_phi_loc_fu_66 <= grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_p_phi_out;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_logic_1 = ap_CS_fsm_state2)) then
                tmp_reg_151 <= outcount48_dout;
            end if;
        end if;
    end process;

    ap_NS_fsm_assign_proc : process (ap_start, ap_done_reg, ap_CS_fsm, ap_CS_fsm_state1, outcount48_empty_n, in_en_clrsts_empty_n, sts_clear_empty_n, ap_CS_fsm_state2, in_en_clrsts_read_read_fu_74_p2, in_en_clrsts_read_reg_138, grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_ap_done, ap_CS_fsm_state4, p_phi_loc_load_load_fu_124_p1, ap_CS_fsm_state5, regslice_both_outStreamTop_V_data_V_U_apdone_blk)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_state1 => 
                if ((not(((sts_clear_empty_n = ap_const_logic_0) or (in_en_clrsts_empty_n = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or (ap_start = ap_const_logic_0))) and (in_en_clrsts_read_read_fu_74_p2 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state1))) then
                    ap_NS_fsm <= ap_ST_fsm_state5;
                elsif ((not(((sts_clear_empty_n = ap_const_logic_0) or (in_en_clrsts_empty_n = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or (ap_start = ap_const_logic_0))) and (in_en_clrsts_read_read_fu_74_p2 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state1))) then
                    ap_NS_fsm <= ap_ST_fsm_state2;
                else
                    ap_NS_fsm <= ap_ST_fsm_state1;
                end if;
            when ap_ST_fsm_state2 => 
                if (((outcount48_empty_n = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_state2))) then
                    ap_NS_fsm <= ap_ST_fsm_state3;
                else
                    ap_NS_fsm <= ap_ST_fsm_state2;
                end if;
            when ap_ST_fsm_state3 => 
                ap_NS_fsm <= ap_ST_fsm_state4;
            when ap_ST_fsm_state4 => 
                if (((grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_ap_done = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_state4))) then
                    ap_NS_fsm <= ap_ST_fsm_state5;
                else
                    ap_NS_fsm <= ap_ST_fsm_state4;
                end if;
            when ap_ST_fsm_state5 => 
                if (((ap_const_logic_1 = ap_CS_fsm_state5) and (regslice_both_outStreamTop_V_data_V_U_apdone_blk = ap_const_logic_0) and ((in_en_clrsts_read_reg_138 = ap_const_lv1_1) or (p_phi_loc_load_load_fu_124_p1 = ap_const_lv1_1)))) then
                    ap_NS_fsm <= ap_ST_fsm_state1;
                elsif (((in_en_clrsts_read_reg_138 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state5) and (regslice_both_outStreamTop_V_data_V_U_apdone_blk = ap_const_logic_0) and (p_phi_loc_load_load_fu_124_p1 = ap_const_lv1_0))) then
                    ap_NS_fsm <= ap_ST_fsm_state2;
                else
                    ap_NS_fsm <= ap_ST_fsm_state5;
                end if;
            when others =>  
                ap_NS_fsm <= "XXXXX";
        end case;
    end process;
    ap_CS_fsm_state1 <= ap_CS_fsm(0);
    ap_CS_fsm_state2 <= ap_CS_fsm(1);
    ap_CS_fsm_state3 <= ap_CS_fsm(2);
    ap_CS_fsm_state4 <= ap_CS_fsm(3);
    ap_CS_fsm_state5 <= ap_CS_fsm(4);

    ap_ST_fsm_state1_blk_assign_proc : process(ap_start, ap_done_reg, in_en_clrsts_empty_n, sts_clear_empty_n)
    begin
        if (((sts_clear_empty_n = ap_const_logic_0) or (in_en_clrsts_empty_n = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or (ap_start = ap_const_logic_0))) then 
            ap_ST_fsm_state1_blk <= ap_const_logic_1;
        else 
            ap_ST_fsm_state1_blk <= ap_const_logic_0;
        end if; 
    end process;


    ap_ST_fsm_state2_blk_assign_proc : process(outcount48_empty_n)
    begin
        if ((outcount48_empty_n = ap_const_logic_0)) then 
            ap_ST_fsm_state2_blk <= ap_const_logic_1;
        else 
            ap_ST_fsm_state2_blk <= ap_const_logic_0;
        end if; 
    end process;

    ap_ST_fsm_state3_blk <= ap_const_logic_0;

    ap_ST_fsm_state4_blk_assign_proc : process(grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_ap_done)
    begin
        if ((grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_ap_done = ap_const_logic_0)) then 
            ap_ST_fsm_state4_blk <= ap_const_logic_1;
        else 
            ap_ST_fsm_state4_blk <= ap_const_logic_0;
        end if; 
    end process;


    ap_ST_fsm_state5_blk_assign_proc : process(regslice_both_outStreamTop_V_data_V_U_apdone_blk)
    begin
        if ((regslice_both_outStreamTop_V_data_V_U_apdone_blk = ap_const_logic_1)) then 
            ap_ST_fsm_state5_blk <= ap_const_logic_1;
        else 
            ap_ST_fsm_state5_blk <= ap_const_logic_0;
        end if; 
    end process;


    ap_block_state1_assign_proc : process(ap_start, ap_done_reg, in_en_clrsts_empty_n, sts_clear_empty_n)
    begin
                ap_block_state1 <= ((sts_clear_empty_n = ap_const_logic_0) or (in_en_clrsts_empty_n = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or (ap_start = ap_const_logic_0));
    end process;


    ap_done_assign_proc : process(ap_done_reg, in_en_clrsts_read_reg_138, p_phi_loc_load_load_fu_124_p1, ap_CS_fsm_state5, regslice_both_outStreamTop_V_data_V_U_apdone_blk)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state5) and (regslice_both_outStreamTop_V_data_V_U_apdone_blk = ap_const_logic_0) and ((in_en_clrsts_read_reg_138 = ap_const_lv1_1) or (p_phi_loc_load_load_fu_124_p1 = ap_const_lv1_1)))) then 
            ap_done <= ap_const_logic_1;
        else 
            ap_done <= ap_done_reg;
        end if; 
    end process;


    ap_idle_assign_proc : process(ap_start, ap_CS_fsm_state1)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start = ap_const_logic_0))) then 
            ap_idle <= ap_const_logic_1;
        else 
            ap_idle <= ap_const_logic_0;
        end if; 
    end process;


    ap_ready_assign_proc : process(in_en_clrsts_read_reg_138, p_phi_loc_load_load_fu_124_p1, ap_CS_fsm_state5, regslice_both_outStreamTop_V_data_V_U_apdone_blk)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state5) and (regslice_both_outStreamTop_V_data_V_U_apdone_blk = ap_const_logic_0) and ((in_en_clrsts_read_reg_138 = ap_const_lv1_1) or (p_phi_loc_load_load_fu_124_p1 = ap_const_lv1_1)))) then 
            ap_ready <= ap_const_logic_1;
        else 
            ap_ready <= ap_const_logic_0;
        end if; 
    end process;

    grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_ap_start <= grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_ap_start_reg;
    grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_outStreamTop_TREADY <= (outStreamTop_TREADY_int_regslice and ap_CS_fsm_state4);

    in_en_clrsts_blk_n_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_state1, in_en_clrsts_empty_n)
    begin
        if ((not(((ap_done_reg = ap_const_logic_1) or (ap_start = ap_const_logic_0))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            in_en_clrsts_blk_n <= in_en_clrsts_empty_n;
        else 
            in_en_clrsts_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    in_en_clrsts_read_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_state1, in_en_clrsts_empty_n, sts_clear_empty_n)
    begin
        if ((not(((sts_clear_empty_n = ap_const_logic_0) or (in_en_clrsts_empty_n = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or (ap_start = ap_const_logic_0))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            in_en_clrsts_read <= ap_const_logic_1;
        else 
            in_en_clrsts_read <= ap_const_logic_0;
        end if; 
    end process;

    in_en_clrsts_read_read_fu_74_p2 <= in_en_clrsts_dout;

    m2s_buf_sts_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_state1, in_en_clrsts_empty_n, sts_clear_empty_n, in_en_clrsts_read_read_fu_74_p2, in_en_clrsts_read_reg_138, p_phi_loc_load_load_fu_124_p1, ap_CS_fsm_state5, regslice_both_outStreamTop_V_data_V_U_apdone_blk, sts_clear_read_read_fu_80_p2, m2s_buf_sts_preg)
    begin
        if (((in_en_clrsts_read_reg_138 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state5) and (regslice_both_outStreamTop_V_data_V_U_apdone_blk = ap_const_logic_0) and (p_phi_loc_load_load_fu_124_p1 = ap_const_lv1_1))) then 
            m2s_buf_sts <= ap_const_lv1_1;
        elsif ((not(((sts_clear_empty_n = ap_const_logic_0) or (in_en_clrsts_empty_n = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or (ap_start = ap_const_logic_0))) and (in_en_clrsts_read_read_fu_74_p2 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state1) and (sts_clear_read_read_fu_80_p2 = ap_const_lv1_1))) then 
            m2s_buf_sts <= ap_const_lv1_0;
        else 
            m2s_buf_sts <= m2s_buf_sts_preg;
        end if; 
    end process;


    m2s_buf_sts_ap_vld_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_state1, in_en_clrsts_empty_n, sts_clear_empty_n, in_en_clrsts_read_read_fu_74_p2, in_en_clrsts_read_reg_138, p_phi_loc_load_load_fu_124_p1, ap_CS_fsm_state5, regslice_both_outStreamTop_V_data_V_U_apdone_blk, sts_clear_read_read_fu_80_p2)
    begin
        if (((not(((sts_clear_empty_n = ap_const_logic_0) or (in_en_clrsts_empty_n = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or (ap_start = ap_const_logic_0))) and (in_en_clrsts_read_read_fu_74_p2 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state1) and (sts_clear_read_read_fu_80_p2 = ap_const_lv1_1)) or ((in_en_clrsts_read_reg_138 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state5) and (regslice_both_outStreamTop_V_data_V_U_apdone_blk = ap_const_logic_0) and (p_phi_loc_load_load_fu_124_p1 = ap_const_lv1_1)))) then 
            m2s_buf_sts_ap_vld <= ap_const_logic_1;
        else 
            m2s_buf_sts_ap_vld <= ap_const_logic_0;
        end if; 
    end process;

    outStreamTop_TVALID <= regslice_both_outStreamTop_V_data_V_U_vld_out;
    outStreamTop_TVALID_int_regslice <= grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_outStreamTop_TVALID;

    outbuf_read_assign_proc : process(grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_outbuf_read, ap_CS_fsm_state4)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state4)) then 
            outbuf_read <= grp_sendoutstream_Pipeline_VITIS_LOOP_155_2_fu_101_outbuf_read;
        else 
            outbuf_read <= ap_const_logic_0;
        end if; 
    end process;


    outcount48_blk_n_assign_proc : process(outcount48_empty_n, ap_CS_fsm_state2)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state2)) then 
            outcount48_blk_n <= outcount48_empty_n;
        else 
            outcount48_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    outcount48_read_assign_proc : process(outcount48_empty_n, ap_CS_fsm_state2)
    begin
        if (((outcount48_empty_n = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_state2))) then 
            outcount48_read <= ap_const_logic_1;
        else 
            outcount48_read <= ap_const_logic_0;
        end if; 
    end process;

    p_phi_loc_load_load_fu_124_p1 <= p_phi_loc_fu_66;

    sts_clear_blk_n_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_state1, sts_clear_empty_n)
    begin
        if ((not(((ap_done_reg = ap_const_logic_1) or (ap_start = ap_const_logic_0))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            sts_clear_blk_n <= sts_clear_empty_n;
        else 
            sts_clear_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    sts_clear_read_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_state1, in_en_clrsts_empty_n, sts_clear_empty_n)
    begin
        if ((not(((sts_clear_empty_n = ap_const_logic_0) or (in_en_clrsts_empty_n = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or (ap_start = ap_const_logic_0))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            sts_clear_read <= ap_const_logic_1;
        else 
            sts_clear_read <= ap_const_logic_0;
        end if; 
    end process;

    sts_clear_read_read_fu_80_p2 <= sts_clear_dout;
end behav;
