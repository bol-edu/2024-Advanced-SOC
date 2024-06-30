
# Loop constraints
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp CSTEPS_FROM {{. == 0}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main CSTEPS_FROM {{. == 2} {.. == 0}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW CSTEPS_FROM {{. == 1} {.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL CSTEPS_FROM {{. == 2} {.. == 0}}

# IO operation constraints
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/MCOL:io_read(dx_in) CSTEPS_FROM {{.. == 0}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/MCOL:io_read(dy_in) CSTEPS_FROM {{.. == 0}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/MCOL:io_write(magn) CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/MCOL:io_write(angle) CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/operator-<11,false>:io_read(widthIn:rsc.@) CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/operator-<10,false>:io_read(heightIn:rsc.@) CSTEPS_FROM {{.. == 1}}

# Sync operation constraints

# Real operation constraints
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/MCOL:mul CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/MCOL:mul#1 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/MCOL:acc CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/leading_sign_19_0 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/operator<<=<19,0,false,AC_TRN,AC_WRAP>:lshift CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_normalize<19,19,false,AC_TRN,AC_WRAP>:expret:qif:acc CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_normalize<19,19,false,AC_TRN,AC_WRAP>:expret:ac_math::ac_normalize<19,19,false,AC_TRN,AC_WRAP>:expret:and#1 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_sqrt_pwl<AC_TRN,19,19,AC_TRN,AC_WRAP,16,9,AC_TRN,AC_WRAP>:normalized_output:mux CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_sqrt_pwl<AC_TRN,19,19,AC_TRN,AC_WRAP,16,9,AC_TRN,AC_WRAP>:normalized_output:ac_math::ac_sqrt_pwl<AC_TRN,19,19,AC_TRN,AC_WRAP,16,9,AC_TRN,AC_WRAP>:normalized_output:mul CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_sqrt_pwl<AC_TRN,19,19,AC_TRN,AC_WRAP,16,9,AC_TRN,AC_WRAP>:normalized_output:mux#1 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_sqrt_pwl<AC_TRN,19,19,AC_TRN,AC_WRAP,16,9,AC_TRN,AC_WRAP>:normalized_output:acc CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_sqrt_pwl<AC_TRN,19,19,AC_TRN,AC_WRAP,16,9,AC_TRN,AC_WRAP>:normalized_output_temp:acc#1 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_sqrt_pwl<AC_TRN,19,19,AC_TRN,AC_WRAP,16,9,AC_TRN,AC_WRAP>:normalized_output_temp:acc#2 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_sqrt_pwl<AC_TRN,19,19,AC_TRN,AC_WRAP,16,9,AC_TRN,AC_WRAP>:normalized_output_temp:acc#3 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_sqrt_pwl<AC_TRN,19,19,AC_TRN,AC_WRAP,16,9,AC_TRN,AC_WRAP>:normalized_output_temp:acc#4 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_sqrt_pwl<AC_TRN,19,19,AC_TRN,AC_WRAP,16,9,AC_TRN,AC_WRAP>:normalized_output_temp:acc#5 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_sqrt_pwl<AC_TRN,19,19,AC_TRN,AC_WRAP,16,9,AC_TRN,AC_WRAP>:normalized_output_temp:acc CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_sqrt_pwl<AC_TRN,19,19,AC_TRN,AC_WRAP,16,9,AC_TRN,AC_WRAP>:m1:mux#1 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_sqrt_pwl<AC_TRN,19,19,AC_TRN,AC_WRAP,16,9,AC_TRN,AC_WRAP>:m1:mux#2 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_normalize<19,19,false,AC_TRN,AC_WRAP>:expret:ac_math::ac_normalize<19,19,false,AC_TRN,AC_WRAP>:expret:and CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/operator<<<33,9,false,AC_TRN,AC_WRAP>:lshift CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_sqrt_pwl<AC_TRN,19,19,AC_TRN,AC_WRAP,16,9,AC_TRN,AC_WRAP>:ac_math::ac_sqrt_pwl<AC_TRN,19,19,AC_TRN,AC_WRAP,16,9,AC_TRN,AC_WRAP>:and CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:x1:qif:acc CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:x1:mux CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:if:acc#10 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:if:acc CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:else:acc CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:else:acc#3 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:mux CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:mux#1 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:if:acc#17 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:if:acc#18 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:if:acc#11 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:else:acc#13 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:else:acc#14 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:else:acc#4 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:mux#3 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:mux#4 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:mux#5 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:if:acc#19 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:if:acc#20 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:if:acc#12 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:else:acc#17 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:else:acc#18 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:else:acc#5 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:mux#7 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:mux#8 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:mux#9 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:if:acc#22 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:if:acc#23 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:if:acc#13 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:else:acc#19 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:else:acc#20 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:else:acc#7 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:mux#10 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:mux#11 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:mux#12 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:if:acc#24 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:if:acc#25 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:if:acc#14 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:else:acc#22 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:else:acc#23 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:else:acc#8 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:mux#13 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:mux#14 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:mux#15 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for-6:if:acc CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:if:acc#26 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:if:acc#15 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:else:acc#24 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for-6:else:acc#1 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:else:acc#10 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:mux#16 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:mux#17 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:mux#18 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:if:acc#27 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:if:acc#16 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for-7:else:acc#1 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:else:acc#11 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:mux#19 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:mux#20 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:if:acc#21 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:else:acc#16 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:for:mux#21 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:else:else:if:acc CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:ac_math::ac_atan2_cordic<9,9,AC_TRN,AC_WRAP,9,9,AC_TRN,AC_WRAP,8,3,AC_TRN,AC_WRAP>:mux1h CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/operator-<11,false>:acc CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/MCOL:equal CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/MCOL:acc#1 CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MCOL/MCOL:if:mux CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/operator-<10,false>:acc CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MROW:equal CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_MagAng/run/run:rlp/main/MROW/MROW:acc CSTEPS_FROM {{.. == 1}}

# Probe constraints
