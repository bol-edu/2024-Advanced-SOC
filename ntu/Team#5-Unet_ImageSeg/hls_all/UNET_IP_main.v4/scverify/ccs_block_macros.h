// ccs_block_macros.h
#include "ccs_testbench.h"

#ifndef EXCLUDE_CCS_BLOCK_INTERCEPT
#ifndef INCLUDE_CCS_BLOCK_INTERCEPT
#define INCLUDE_CCS_BLOCK_INTERCEPT
#ifdef  CCS_DESIGN_FUNC_UNET_IP_main_run
#define ccs_intercept_main_run_35 \
  run(ac_channel<ac_fixed<12, 6, true, AC_TRN, AC_WRAP> > &input, ac_channel<ac_fixed<12, 6, true, AC_TRN, AC_WRAP> > &output);\
  void ccs_real_run
#else
#define ccs_intercept_main_run_35 run
#endif //CCS_DESIGN_FUNC_UNET_IP_main_run
#endif //INCLUDE_CCS_BLOCK_INTERCEPT
#endif //EXCLUDE_CCS_BLOCK_INTERCEPT

// main::run 35 TOP
#define ccs_intercept_run_35 ccs_intercept_main_run_35
