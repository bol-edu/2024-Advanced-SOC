// ccs_block_macros.h
#include "ccs_testbench.h"

#ifndef EXCLUDE_CCS_BLOCK_INTERCEPT
#ifndef INCLUDE_CCS_BLOCK_INTERCEPT
#define INCLUDE_CCS_BLOCK_INTERCEPT
#ifdef  CCS_DESIGN_FUNC_UNET_IP_conv2d_run_conv
#define ccs_intercept_conv2d_run_conv_17 \
  run_conv(ac_fixed<12, 8, true, AC_TRN, AC_WRAP> input[32768], ac_fixed<12, 8, true, AC_TRN, AC_WRAP> padded_input[34848], ac_fixed<12, 8, true, AC_TRN, AC_WRAP> output[32768], ac_int<7, false> &height, ac_int<7, false> &width, ac_int<2, false> &kernel_size, ac_int<2, false> &padding, ac_int<20, false> &filter_offset, ac_int<7, false> &in_channels, ac_int<7, false> &out_channels);\
  void ccs_real_run_conv
#else
#define ccs_intercept_conv2d_run_conv_17 run_conv
#endif //CCS_DESIGN_FUNC_UNET_IP_conv2d_run_conv
#endif //INCLUDE_CCS_BLOCK_INTERCEPT
#endif //EXCLUDE_CCS_BLOCK_INTERCEPT

// conv2d::run_conv 17 TOP
#define ccs_intercept_run_conv_17 ccs_intercept_conv2d_run_conv_17
// main::run 45 MODULE
#define ccs_intercept_run_45 run
#define ccs_intercept_main_run_45 run
// tranconv2d::run_tran 17 MODULE
#define ccs_intercept_run_tran_17 run_tran
#define ccs_intercept_tranconv2d_run_tran_17 run_tran
// batchnorm_relu::run_batch 21 MODULE
#define ccs_intercept_run_batch_21 run_batch
#define ccs_intercept_batchnorm_relu_run_batch_21 run_batch
// maxpool::run_max 18 MODULE
#define ccs_intercept_run_max_18 run_max
#define ccs_intercept_maxpool_run_max_18 run_max
