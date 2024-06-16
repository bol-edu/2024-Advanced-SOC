// ccs_block_macros.h
#include "ccs_testbench.h"

#ifndef EXCLUDE_CCS_BLOCK_INTERCEPT
#ifndef INCLUDE_CCS_BLOCK_INTERCEPT
#define INCLUDE_CCS_BLOCK_INTERCEPT
#ifdef  CCS_DESIGN_FUNC_UNET_IP_batchnorm_relu_run_batch
#define ccs_intercept_batchnorm_relu_run_batch_21 \
  run_batch(ac_fixed<12, 8, true, AC_TRN, AC_WRAP> input[32768], ac_fixed<12, 8, true, AC_TRN, AC_WRAP> output[32768], ac_int<7, false> &channels, ac_int<7, false> &height, ac_int<7, false> &width, ac_int<10, false> &offset);\
  void ccs_real_run_batch
#else
#define ccs_intercept_batchnorm_relu_run_batch_21 run_batch
#endif //CCS_DESIGN_FUNC_UNET_IP_batchnorm_relu_run_batch
#endif //INCLUDE_CCS_BLOCK_INTERCEPT
#endif //EXCLUDE_CCS_BLOCK_INTERCEPT

// batchnorm_relu::run_batch 21 TOP
#define ccs_intercept_run_batch_21 ccs_intercept_batchnorm_relu_run_batch_21
// main::run 45 MODULE
#define ccs_intercept_run_45 run
#define ccs_intercept_main_run_45 run
// tranconv2d::run_tran 17 MODULE
#define ccs_intercept_run_tran_17 run_tran
#define ccs_intercept_tranconv2d_run_tran_17 run_tran
// maxpool::run_max 18 MODULE
#define ccs_intercept_run_max_18 run_max
#define ccs_intercept_maxpool_run_max_18 run_max
// conv2d::run_conv 17 MODULE
#define ccs_intercept_run_conv_17 run_conv
#define ccs_intercept_conv2d_run_conv_17 run_conv
