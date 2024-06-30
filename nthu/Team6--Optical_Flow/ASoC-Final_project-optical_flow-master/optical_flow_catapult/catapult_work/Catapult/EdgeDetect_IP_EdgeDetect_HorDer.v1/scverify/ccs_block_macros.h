// ccs_block_macros.h
#include "ccs_testbench.h"

#ifndef EXCLUDE_CCS_BLOCK_INTERCEPT
#ifndef INCLUDE_CCS_BLOCK_INTERCEPT
#define INCLUDE_CCS_BLOCK_INTERCEPT
#ifdef  CCS_DESIGN_FUNC_EdgeDetect_IP_EdgeDetect_HorDer_run
#define ccs_intercept_EdgeDetect_HorDer_run_44 \
  run(ac_channel<ac_int<8, false> > &dat_in, ac_int<11, false> &widthIn, ac_int<10, false> &heightIn, ac_channel<ac_int<9, true> > &dx);\
  void ccs_real_run
#else
#define ccs_intercept_EdgeDetect_HorDer_run_44 run
#endif //CCS_DESIGN_FUNC_EdgeDetect_IP_EdgeDetect_HorDer_run
#endif //INCLUDE_CCS_BLOCK_INTERCEPT
#endif //EXCLUDE_CCS_BLOCK_INTERCEPT

// EdgeDetect_HorDer::run 44 TOP
#define ccs_intercept_run_44 ccs_intercept_EdgeDetect_HorDer_run_44
// EdgeDetect_Top::run 62 MODULE
#define ccs_intercept_run_62 run
#define ccs_intercept_EdgeDetect_Top_run_62 run
// EdgeDetect_MagAng::run 45 MODULE
#define ccs_intercept_run_45 run
#define ccs_intercept_EdgeDetect_MagAng_run_45 run
// EdgeDetect_VerDer::run 47 MODULE
#define ccs_intercept_run_47 run
#define ccs_intercept_EdgeDetect_VerDer_run_47 run
