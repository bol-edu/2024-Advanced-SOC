void mc_testbench_capture_IN( ac_fixed<12, 8, true, AC_TRN, AC_WRAP> input[32768], ac_fixed<12, 8, true, AC_TRN, AC_WRAP> output[32768], ac_int<7, false> &channels, ac_int<7, false> &height, ac_int<7, false> &width, ac_int<10, false> &offset ) {
  mc_testbench::capture_IN(input, output, channels, height, width, offset);
}
void mc_testbench_capture_OUT( ac_fixed<12, 8, true, AC_TRN, AC_WRAP> input[32768], ac_fixed<12, 8, true, AC_TRN, AC_WRAP> output[32768], ac_int<7, false> &channels, ac_int<7, false> &height, ac_int<7, false> &width, ac_int<10, false> &offset ) {
  mc_testbench::capture_OUT(input, output, channels, height, width, offset);
}

class ccs_intercept
{
  public:
  void capture_THIS( void* _this ) {
    cur_inst = _this;
    if ( !dut_inst_set() ) dut = mc_testbench_set_dut_inst(cur_inst);
    if ( capture_msg && dut != NULL && dut == cur_inst ) {
      std::cout << "SCVerify intercepting C++ function 'UNET_IP::batchnorm_relu::run_batch' for RTL block 'UNET_IP_batchnorm_relu'" << std::endl;
      std::cout << "                      DUT instance '" << dut << "'" << std::endl;
      capture_msg = false;
    }
  }
  void capture_IN( ac_fixed<12, 8, true, AC_TRN, AC_WRAP> input[32768], ac_fixed<12, 8, true, AC_TRN, AC_WRAP> output[32768], ac_int<7, false> &channels, ac_int<7, false> &height, ac_int<7, false> &width, ac_int<10, false> &offset ) {
    if ( dut != NULL && dut == cur_inst )
      mc_testbench_capture_IN(input, output, channels, height, width, offset);
  }
  void capture_OUT( ac_fixed<12, 8, true, AC_TRN, AC_WRAP> input[32768], ac_fixed<12, 8, true, AC_TRN, AC_WRAP> output[32768], ac_int<7, false> &channels, ac_int<7, false> &height, ac_int<7, false> &width, ac_int<10, false> &offset ) {
    if ( dut != NULL && dut == cur_inst )
      mc_testbench_capture_OUT(input, output, channels, height, width, offset);
  }
  void wait_for_idle_sync() {
    if ( dut != NULL && dut == cur_inst )
      mc_testbench_wait_for_idle_sync();
  }
  ccs_intercept(): dut(NULL), cur_inst(NULL), capture_msg(true){}
  ~ccs_intercept() {
    if ( capture_msg )
      std::cout << "Error: The CCS_BLOCK intercept did not occur for DUT instance '" << dut << "'" << std::endl
                << "       Make sure the applied pointer is for class 'UNET_IP::batchnorm_relu'" << std::endl;
  }
  private:
  bool dut_inst_set() {
    if ( dut == NULL && !!mc_testbench_dut_inst() )
      dut = mc_testbench_dut_inst();
    return dut != NULL;
  }
  void *dut, *cur_inst;
  bool capture_msg;
};


namespace UNET_IP {
  void batchnorm_relu::run_batch(ac_fixed<12, 8, true, AC_TRN, AC_WRAP> input[32768], ac_fixed<12, 8, true, AC_TRN, AC_WRAP> output[32768], ac_int<7, false> &channels, ac_int<7, false> &height, ac_int<7, false> &width, ac_int<10, false> &offset) {
    static ccs_intercept ccs_intercept_inst;
    ccs_intercept_inst.capture_THIS(this);
    ccs_intercept_inst.wait_for_idle_sync();
    ccs_intercept_inst.capture_IN(input, output, channels, height, width, offset);
    ccs_real_run_batch(input, output, channels, height, width, offset);
    ccs_intercept_inst.capture_OUT(input, output, channels, height, width, offset);
  }
}

