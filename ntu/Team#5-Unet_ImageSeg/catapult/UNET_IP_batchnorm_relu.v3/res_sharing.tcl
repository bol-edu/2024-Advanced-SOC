directive set /UNET_IP::batchnorm_relu/UNET_IP::batchnorm_relu:run_batch/UNET_IP::batchnorm_relu:run_batch:conc/num_elements:mul RESOURCE_NAME LOOP_MEAN:mul:rg
directive set /UNET_IP::batchnorm_relu/UNET_IP::batchnorm_relu:run_batch/UNET_IP::batchnorm_relu:run_batch:conc/LOOP_MEAN:mul RESOURCE_NAME LOOP_MEAN:mul:rg
directive set /UNET_IP::batchnorm_relu/UNET_IP::batchnorm_relu:run_batch/UNET_IP::batchnorm_relu:run_batch:conc/ac_math::ac_sqrt_pwl<AC_TRN,22,17,AC_TRN,AC_WRAP,14,8,AC_TRN,AC_WRAP>:normalized_output:ac_math::ac_sqrt_pwl<AC_TRN,22,17,AC_TRN,AC_WRAP,14,8,AC_TRN,AC_WRAP>:normalized_output:mul RESOURCE_NAME LOOP_MEAN:mul:rg
directive set /UNET_IP::batchnorm_relu/UNET_IP::batchnorm_relu:run_batch/UNET_IP::batchnorm_relu:run_batch:conc/LOOP_OUT:acc#1 RESOURCE_NAME LOOP_MEAN:acc#1:rg
directive set /UNET_IP::batchnorm_relu/UNET_IP::batchnorm_relu:run_batch/UNET_IP::batchnorm_relu:run_batch:conc/LOOP_MEAN:acc#1 RESOURCE_NAME LOOP_MEAN:acc#1:rg
