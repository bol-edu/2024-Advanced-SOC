
# Loop constraints
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp CSTEPS_FROM {{. == 0}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main CSTEPS_FROM {{. == 2} {.. == 0}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH CSTEPS_FROM {{. == 13} {.. == 1}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_MEAN CSTEPS_FROM {{. == 3} {.. == 0}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_VAR CSTEPS_FROM {{. == 4} {.. == 6}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_OUT CSTEPS_FROM {{. == 11} {.. == 12}}

# IO operation constraints
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/num_elements:asn CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/num_elements:asn#1 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH:asn#1 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_OUT/LOOP_OUT:asn#2 CSTEPS_FROM {{.. == 8}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_CH:asn#3 CSTEPS_FROM {{.. == 13}}

# Sync operation constraints

# Real operation constraints
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/num_elements:mul CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH:acc#2 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_MEAN/LOOP_MEAN:acc#4 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_MEAN/LOOP_MEAN:mul CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_MEAN/LOOP_MEAN:acc#1 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_MEAN/LOOP_MEAN:read_mem(input:rsc.@) CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_MEAN/LOOP_MEAN:acc#2 CSTEPS_FROM {{.. == 3}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_MEAN/LOOP_MEAN:acc#3 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_MEAN/LOOP_MEAN:mux CSTEPS_FROM {{.. == 3}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_MEAN/LOOP_MEAN:mux#1 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/operator_<20,8,false,AC_TRN,AC_WRAP,13,false>:div CSTEPS_FROM {{.. == 0}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_VAR:acc#7 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_VAR/LOOP_VAR:mul CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_VAR/LOOP_VAR:acc#1 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_VAR/LOOP_VAR:read_mem(input:rsc.@) CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_VAR/LOOP_VAR:acc#4 CSTEPS_FROM {{.. == 3}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_VAR/LOOP_VAR:acc#6 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_VAR/LOOP_VAR:mul#2 CSTEPS_FROM {{.. == 4}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_VAR/LOOP_VAR:acc#3 CSTEPS_FROM {{.. == 4}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_VAR/LOOP_VAR:acc#8 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/operator_<34,16,false,AC_TRN,AC_WRAP,13,false>:div CSTEPS_FROM {{.. == 6}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_OUT/LOOP_OUT:acc#8 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_OUT/LOOP_OUT:mul CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_OUT/LOOP_OUT:acc#1 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_OUT/leading_sign_22_0 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_OUT/operator<<=<22,0,false,AC_TRN,AC_WRAP>:lshift CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_OUT/ac_math::ac_normalize<22,17,false,AC_TRN,AC_WRAP>:expret:qif:acc CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_OUT/ac_math::ac_sqrt_pwl<AC_TRN,22,17,AC_TRN,AC_WRAP,14,8,AC_TRN,AC_WRAP>:normalized_output:mux CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_OUT/ac_math::ac_sqrt_pwl<AC_TRN,22,17,AC_TRN,AC_WRAP,14,8,AC_TRN,AC_WRAP>:normalized_output:ac_math::ac_sqrt_pwl<AC_TRN,22,17,AC_TRN,AC_WRAP,14,8,AC_TRN,AC_WRAP>:normalized_output:mul CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_OUT/ac_math::ac_sqrt_pwl<AC_TRN,22,17,AC_TRN,AC_WRAP,14,8,AC_TRN,AC_WRAP>:normalized_output:mux#1 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_OUT/ac_math::ac_sqrt_pwl<AC_TRN,22,17,AC_TRN,AC_WRAP,14,8,AC_TRN,AC_WRAP>:normalized_output:acc CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_OUT/ac_math::ac_sqrt_pwl<AC_TRN,22,17,AC_TRN,AC_WRAP,14,8,AC_TRN,AC_WRAP>:normalized_output_temp:mul CSTEPS_FROM {{.. == 3}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_OUT/ac_math::ac_sqrt_pwl<AC_TRN,22,17,AC_TRN,AC_WRAP,14,8,AC_TRN,AC_WRAP>:m1:mux#1 CSTEPS_FROM {{.. == 3}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_OUT/ac_math::ac_sqrt_pwl<AC_TRN,22,17,AC_TRN,AC_WRAP,14,8,AC_TRN,AC_WRAP>:m1:mux#2 CSTEPS_FROM {{.. == 3}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_OUT/ac_math::ac_normalize<22,17,false,AC_TRN,AC_WRAP>:expret:ac_math::ac_normalize<22,17,false,AC_TRN,AC_WRAP>:expret:and CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_OUT/operator<<<32,8,false,AC_TRN,AC_WRAP>:lshift CSTEPS_FROM {{.. == 3}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_OUT/LOOP_OUT:acc#3 CSTEPS_FROM {{.. == 8}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_OUT/LOOP_OUT:read_rom(UNET_IP::gamma_pretrain.rom_map_1) CSTEPS_FROM {{.. == 8}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_OUT/LOOP_OUT:read_mem(input:rsc.@) CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_OUT/LOOP_OUT:acc#5 CSTEPS_FROM {{.. == 3}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_OUT/ac_math::ac_sqrt_pwl<AC_TRN,22,17,AC_TRN,AC_WRAP,14,8,AC_TRN,AC_WRAP>:ac_math::ac_sqrt_pwl<AC_TRN,22,17,AC_TRN,AC_WRAP,14,8,AC_TRN,AC_WRAP>:and CSTEPS_FROM {{.. == 4}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_OUT/LOOP_OUT:div CSTEPS_FROM {{.. == 4}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_OUT/LOOP_OUT:LOOP_OUT:mul CSTEPS_FROM {{.. == 9}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_OUT/LOOP_OUT:read_rom(UNET_IP::beta_pretrain.rom_map_1) CSTEPS_FROM {{.. == 8}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_OUT/LOOP_OUT:acc#6 CSTEPS_FROM {{.. == 10}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_OUT/operator><22,16,false,AC_TRN,AC_WRAP>:acc CSTEPS_FROM {{.. == 10}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_OUT/LOOP_OUT:LOOP_OUT:and CSTEPS_FROM {{.. == 10}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_OUT/LOOP_OUT:write_mem(output:rsc.@) CSTEPS_FROM {{.. == 10}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_OUT/LOOP_OUT:acc#7 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_OUT/LOOP_OUT:mux CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_CH:acc#1 CSTEPS_FROM {{.. == 13}}
directive set /UNET_IP::batchnorm_relu/run_batch/run_batch:rlp/main/LOOP_CH/LOOP_CH:acc#3 CSTEPS_FROM {{.. == 13}}

# Probe constraints
