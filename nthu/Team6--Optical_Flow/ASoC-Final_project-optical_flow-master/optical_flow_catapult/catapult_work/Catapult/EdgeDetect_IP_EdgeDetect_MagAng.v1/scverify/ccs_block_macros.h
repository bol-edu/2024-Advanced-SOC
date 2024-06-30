// ccs_block_macros.h
#include "ccs_testbench.h"

#ifndef EXCLUDE_CCS_BLOCK_INTERCEPT
#ifndef INCLUDE_CCS_BLOCK_INTERCEPT
#define INCLUDE_CCS_BLOCK_INTERCEPT
#ifdef  CCS_DESIGN_FUNC_EdgeDetect_IP_EdgeDetect_MagAng_run
#define ccs_intercept_EdgeDetect_MagAng_run_45 \
  run(ac_channel<ac_int<9, true> > &dx_in, ac_channel<ac_int<9, true> > &dy_in, ac_int<11, false> &widthIn, ac_int<10, false> &heightIn, ac_channel<ac_int<9, false> > &magn, ac_channel<ac_fixed<8, 3, true, AC_TRN, AC_WRAP> > &angle);\
  void ccs_real_run
#else
#define ccs_intercept_EdgeDetect_MagAng_run_45 run
#endif //CCS_DESIGN_FUNC_EdgeDetect_IP_EdgeDetect_MagAng_run
#endif //INCLUDE_CCS_BLOCK_INTERCEPT
#endif //EXCLUDE_CCS_BLOCK_INTERCEPT

// EdgeDetect_MagAng::run 45 TOP
#define ccs_intercept_run_45 ccs_intercept_EdgeDetect_MagAng_run_45
// EdgeDetect_Top::run 62 MODULE
#define ccs_intercept_run_62 run
#define ccs_intercept_EdgeDetect_Top_run_62 run
// EdgeDetect_HorDer::run 44 MODULE
#define ccs_intercept_run_44 run
#define ccs_intercept_EdgeDetect_HorDer_run_44 run
// EdgeDetect_VerDer::run 47 MODULE
#define ccs_intercept_run_47 run
#define ccs_intercept_EdgeDetect_VerDer_run_47 run
