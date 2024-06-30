-- ==============================================================
-- RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.1 (64-bit)
-- Version: 2022.1
-- Copyright (C) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity fiFFNTT_u_mul is
port (
    ap_ready : OUT STD_LOGIC;
    a : IN STD_LOGIC_VECTOR (15 downto 0);
    ap_return : OUT STD_LOGIC_VECTOR (21 downto 0) );
end;


architecture behav of fiFFNTT_u_mul is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv6_0 : STD_LOGIC_VECTOR (5 downto 0) := "000000";
    constant ap_const_logic_0 : STD_LOGIC := '0';

attribute shreg_extract : string;


begin



    ap_ready <= ap_const_logic_1;
    ap_return <= (a & ap_const_lv6_0);
end behav;
