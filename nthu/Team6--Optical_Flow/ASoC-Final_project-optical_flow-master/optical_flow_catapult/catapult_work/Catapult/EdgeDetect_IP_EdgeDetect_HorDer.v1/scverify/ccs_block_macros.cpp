void mc_testbench_capture_IN( ac_channel<ac_int<8, false> > &dat_in, ac_int<11, false> &widthIn, ac_int<10, false> &heightIn, ac_channel<ac_int<9, true> > &dx ) {
  mc_testbench::capture_IN(dat_in, widthIn, heightIn, dx);
}
void mc_testbench_capture_OUT( ac_channel<ac_int<8, false> > &dat_in, ac_int<11, false> &widthIn, ac_int<10, false> &heightIn, ac_channel<ac_int<9, true> > &dx ) {
  mc_testbench::capture_OUT(dat_in, widthIn, heightIn, dx);
}

class ccs_intercept
{
  public:
  void capture_THIS( void* _this ) {
    cur_inst = _this;
    if ( !dut_inst_set() ) dut = mc_testbench_set_dut_inst(cur_inst);
    if ( capture_msg && dut != NULL && dut == cur_inst ) {
      std::cout << "SCVerify intercepting C++ function 'EdgeDetect_IP::EdgeDetect_HorDer::run' for RTL block 'EdgeDetect_IP_EdgeDetect_HorDer'" << std::endl;
      std::cout << "                      DUT instance '" << dut << "'" << std::endl;
      capture_msg = false;
    }
  }
  void capture_IN( ac_channel<ac_int<8, false> > &dat_in, ac_int<11, false> &widthIn, ac_int<10, false> &heightIn, ac_channel<ac_int<9, true> > &dx ) {
    if ( dut != NULL && dut == cur_inst )
      mc_testbench_capture_IN(dat_in, widthIn, heightIn, dx);
  }
  void capture_OUT( ac_channel<ac_int<8, false> > &dat_in, ac_int<11, false> &widthIn, ac_int<10, false> &heightIn, ac_channel<ac_int<9, true> > &dx ) {
    if ( dut != NULL && dut == cur_inst )
      mc_testbench_capture_OUT(dat_in, widthIn, heightIn, dx);
  }
  void wait_for_idle_sync() {
    if ( dut != NULL && dut == cur_inst )
      mc_testbench_wait_for_idle_sync();
  }
  ccs_intercept(): dut(NULL), cur_inst(NULL), capture_msg(true){}
  ~ccs_intercept() {
    if ( capture_msg )
      std::cout << "Error: The CCS_BLOCK intercept did not occur for DUT instance '" << dut << "'" << std::endl
                << "       Make sure the applied pointer is for class 'EdgeDetect_IP::EdgeDetect_HorDer'" << std::endl;
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


namespace EdgeDetect_IP {
  void EdgeDetect_HorDer::run(ac_channel<ac_int<8, false> > &dat_in, ac_int<11, false> &widthIn, ac_int<10, false> &heightIn, ac_channel<ac_int<9, true> > &dx) {
    static ccs_intercept ccs_intercept_inst;
    ccs_intercept_inst.capture_THIS(this);
    ccs_intercept_inst.wait_for_idle_sync();
    ccs_intercept_inst.capture_IN(dat_in, widthIn, heightIn, dx);
    ccs_real_run(dat_in, widthIn, heightIn, dx);
    ccs_intercept_inst.capture_OUT(dat_in, widthIn, heightIn, dx);
  }
}

