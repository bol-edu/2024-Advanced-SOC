-- SCVerify DUT wrapper used for SystemC > HDL interface bindings

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY ccs_wrapper IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    arst_n : IN STD_LOGIC;
    input_rsc_radr : OUT STD_LOGIC_VECTOR(14 DOWNTO 0);
    input_rsc_re : OUT STD_LOGIC;
    input_rsc_q : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
    input_triosy_lz : OUT STD_LOGIC;
    output_rsc_wadr : OUT STD_LOGIC_VECTOR(14 DOWNTO 0);
    output_rsc_d : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
    output_rsc_we : OUT STD_LOGIC;
    output_rsc_radr : OUT STD_LOGIC_VECTOR(14 DOWNTO 0);
    output_rsc_re : OUT STD_LOGIC;
    output_rsc_q : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
    output_triosy_lz : OUT STD_LOGIC;
    height_rsc_dat : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
    height_triosy_lz : OUT STD_LOGIC;
    width_rsc_dat : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
    width_triosy_lz : OUT STD_LOGIC;
    kernel_size_rsc_dat : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    kernel_size_triosy_lz : OUT STD_LOGIC;
    filter_offset_rsc_dat : IN STD_LOGIC_VECTOR(19 DOWNTO 0);
    filter_offset_triosy_lz : OUT STD_LOGIC;
    in_channels_rsc_dat : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
    in_channels_triosy_lz : OUT STD_LOGIC;
    out_channels_rsc_dat : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
    out_channels_triosy_lz : OUT STD_LOGIC;
    stride_rsc_dat : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    stride_triosy_lz : OUT STD_LOGIC
  );
END ccs_wrapper;

ARCHITECTURE wrap OF ccs_wrapper IS
  COMPONENT UNET_IP_tranconv2d
    PORT (
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      arst_n : IN STD_LOGIC;
      input_rsc_radr : OUT STD_LOGIC_VECTOR(14 DOWNTO 0);
      input_rsc_re : OUT STD_LOGIC;
      input_rsc_q : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
      input_triosy_lz : OUT STD_LOGIC;
      output_rsc_wadr : OUT STD_LOGIC_VECTOR(14 DOWNTO 0);
      output_rsc_d : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
      output_rsc_we : OUT STD_LOGIC;
      output_rsc_radr : OUT STD_LOGIC_VECTOR(14 DOWNTO 0);
      output_rsc_re : OUT STD_LOGIC;
      output_rsc_q : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
      output_triosy_lz : OUT STD_LOGIC;
      height_rsc_dat : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
      height_triosy_lz : OUT STD_LOGIC;
      width_rsc_dat : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
      width_triosy_lz : OUT STD_LOGIC;
      kernel_size_rsc_dat : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      kernel_size_triosy_lz : OUT STD_LOGIC;
      filter_offset_rsc_dat : IN STD_LOGIC_VECTOR(19 DOWNTO 0);
      filter_offset_triosy_lz : OUT STD_LOGIC;
      in_channels_rsc_dat : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
      in_channels_triosy_lz : OUT STD_LOGIC;
      out_channels_rsc_dat : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
      out_channels_triosy_lz : OUT STD_LOGIC;
      stride_rsc_dat : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      stride_triosy_lz : OUT STD_LOGIC
    );
  END COMPONENT;

BEGIN

  dut_inst : UNET_IP_tranconv2d
    PORT MAP (
      clk => clk,
      rst => rst,
      arst_n => arst_n,
      input_rsc_radr => input_rsc_radr,
      input_rsc_re => input_rsc_re,
      input_rsc_q => input_rsc_q,
      input_triosy_lz => input_triosy_lz,
      output_rsc_wadr => output_rsc_wadr,
      output_rsc_d => output_rsc_d,
      output_rsc_we => output_rsc_we,
      output_rsc_radr => output_rsc_radr,
      output_rsc_re => output_rsc_re,
      output_rsc_q => output_rsc_q,
      output_triosy_lz => output_triosy_lz,
      height_rsc_dat => height_rsc_dat,
      height_triosy_lz => height_triosy_lz,
      width_rsc_dat => width_rsc_dat,
      width_triosy_lz => width_triosy_lz,
      kernel_size_rsc_dat => kernel_size_rsc_dat,
      kernel_size_triosy_lz => kernel_size_triosy_lz,
      filter_offset_rsc_dat => filter_offset_rsc_dat,
      filter_offset_triosy_lz => filter_offset_triosy_lz,
      in_channels_rsc_dat => in_channels_rsc_dat,
      in_channels_triosy_lz => in_channels_triosy_lz,
      out_channels_rsc_dat => out_channels_rsc_dat,
      out_channels_triosy_lz => out_channels_triosy_lz,
      stride_rsc_dat => stride_rsc_dat,
      stride_triosy_lz => stride_triosy_lz
    );

END wrap;

