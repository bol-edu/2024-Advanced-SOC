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
    input_rsc_clken : OUT STD_LOGIC;
    input_triosy_lz : OUT STD_LOGIC;
    output_rsc_wadr : OUT STD_LOGIC_VECTOR(14 DOWNTO 0);
    output_rsc_d : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
    output_rsc_we : OUT STD_LOGIC;
    output_rsc_clken : OUT STD_LOGIC;
    output_triosy_lz : OUT STD_LOGIC;
    channels : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
    height : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
    width : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
    offset : IN STD_LOGIC_VECTOR(9 DOWNTO 0)
  );
END ccs_wrapper;

ARCHITECTURE wrap OF ccs_wrapper IS
  COMPONENT UNET_IP_batchnorm_relu
    PORT (
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      arst_n : IN STD_LOGIC;
      input_rsc_radr : OUT STD_LOGIC_VECTOR(14 DOWNTO 0);
      input_rsc_re : OUT STD_LOGIC;
      input_rsc_q : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
      input_rsc_clken : OUT STD_LOGIC;
      input_triosy_lz : OUT STD_LOGIC;
      output_rsc_wadr : OUT STD_LOGIC_VECTOR(14 DOWNTO 0);
      output_rsc_d : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
      output_rsc_we : OUT STD_LOGIC;
      output_rsc_clken : OUT STD_LOGIC;
      output_triosy_lz : OUT STD_LOGIC;
      channels : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
      height : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
      width : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
      offset : IN STD_LOGIC_VECTOR(9 DOWNTO 0)
    );
  END COMPONENT;

BEGIN

  dut_inst : UNET_IP_batchnorm_relu
    PORT MAP (
      clk => clk,
      rst => rst,
      arst_n => arst_n,
      input_rsc_radr => input_rsc_radr,
      input_rsc_re => input_rsc_re,
      input_rsc_q => input_rsc_q,
      input_rsc_clken => input_rsc_clken,
      input_triosy_lz => input_triosy_lz,
      output_rsc_wadr => output_rsc_wadr,
      output_rsc_d => output_rsc_d,
      output_rsc_we => output_rsc_we,
      output_rsc_clken => output_rsc_clken,
      output_triosy_lz => output_triosy_lz,
      channels => channels,
      height => height,
      width => width,
      offset => offset
    );

END wrap;

