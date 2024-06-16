// ccs_block_macros.h
#include "ccs_testbench.h"

#ifndef EXCLUDE_CCS_BLOCK_INTERCEPT
#ifndef INCLUDE_CCS_BLOCK_INTERCEPT
#define INCLUDE_CCS_BLOCK_INTERCEPT
#ifdef  CCS_DESIGN_FUNC_UNET_IP_maxpool_run_max
#define ccs_intercept_maxpool_run_max_18 \
  run_max(ac_fixed<12, 8, true, AC_TRN, AC_WRAP> input[32768], ac_fixed<12, 8, true, AC_TRN, AC_WRAP> output[32768], ac_int<7, false> &channels, ac_int<7, false> &height, ac_int<7, false> &width, ac_int<3, false> &pool_size, ac_int<3, false> &stride);\
  void ccs_real_run_max
#else
#define ccs_intercept_maxpool_run_max_18 run_max
#endif //CCS_DESIGN_FUNC_UNET_IP_maxpool_run_max
#endif //INCLUDE_CCS_BLOCK_INTERCEPT
#endif //EXCLUDE_CCS_BLOCK_INTERCEPT

// maxpool::run_max 18 TOP
#define ccs_intercept_run_max_18 ccs_intercept_maxpool_run_max_18
// main::run 45 MODULE
#define ccs_intercept_run_45 run
#define ccs_intercept_main_run_45 run
// tranconv2d::run_tran 17 MODULE
#define ccs_intercept_run_tran_17 run_tran
#define ccs_intercept_tranconv2d_run_tran_17 run_tran
// batchnorm_relu::run_batch 21 MODULE
#define ccs_intercept_run_batch_21 run_batch
#define ccs_intercept_batchnorm_relu_run_batch_21 run_batch
// conv2d::run_conv 17 MODULE
#define ccs_intercept_run_conv_17 run_conv
#define ccs_intercept_conv2d_run_conv_17 run_conv
