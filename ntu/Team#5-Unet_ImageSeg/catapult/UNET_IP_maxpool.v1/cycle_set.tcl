
# Loop constraints
directive set /UNET_IP::maxpool/run_max/run_max:rlp CSTEPS_FROM {{. == 0}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main CSTEPS_FROM {{. == 3} {.. == 0}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH CSTEPS_FROM {{. == 2} {.. == 2}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH/LOOP_HEIGHT CSTEPS_FROM {{. == 2} {.. == 1}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH/LOOP_HEIGHT/LOOP_WIDTH CSTEPS_FROM {{. == 4} {.. == 1}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X CSTEPS_FROM {{. == 1} {.. == 1}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y CSTEPS_FROM {{. == 4} {.. == 0}}

# IO operation constraints
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/out_height:asn CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/out_height:asn#1 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/out_width:asn CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/out_width:asn#1 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/channels:asn CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH/LOOP_HEIGHT/LOOP_WIDTH/pool_size:asn CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/pool_size:asn#1 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:if:asn#4 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:if:asn#6 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:if:asn#7 CSTEPS_FROM {{.. == 3}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:if:asn#9 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:if:asn#11 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/pool_size:asn#2 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH/channels:asn#1 CSTEPS_FROM {{.. == 2}}

# Sync operation constraints

# Real operation constraints
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/out_height:div CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/out_width:div CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH:acc#2 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH/LOOP_HEIGHT:acc#2 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH/LOOP_HEIGHT/LOOP_WIDTH:acc#5 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X:acc#2 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:acc#2 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:if:mul#4 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:if:mul#1 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:if:mul CSTEPS_FROM {{.. == 3}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:if:mul#3 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:if:acc#2 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:if:mul#2 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:if:acc#4 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:if:acc CSTEPS_FROM {{.. == 3}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:else:acc#5 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:else:acc#6 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:else:acc CSTEPS_FROM {{.. == 3}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:mux#9 CSTEPS_FROM {{.. == 3}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:if:read_mem(input:rsc.@)#1 CSTEPS_FROM {{.. == 3}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:else:if:acc CSTEPS_FROM {{.. == 4}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:acc#1 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:mux#3 CSTEPS_FROM {{.. == 4}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:mux CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_X:acc#1 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_X:acc#3 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH/LOOP_HEIGHT/LOOP_WIDTH/LOOP_WIDTH:mul#2 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH/LOOP_HEIGHT/LOOP_WIDTH/LOOP_WIDTH:acc#6 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH/LOOP_HEIGHT/LOOP_WIDTH/LOOP_WIDTH:mul#1 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH/LOOP_HEIGHT/LOOP_WIDTH/LOOP_WIDTH:mul CSTEPS_FROM {{.. == 3}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH/LOOP_HEIGHT/LOOP_WIDTH/LOOP_WIDTH:acc#4 CSTEPS_FROM {{.. == 3}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH/LOOP_HEIGHT/LOOP_WIDTH/LOOP_WIDTH:write_mem(output:rsc.@) CSTEPS_FROM {{.. == 3}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH/LOOP_HEIGHT/LOOP_WIDTH/LOOP_WIDTH:acc#3 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH/LOOP_HEIGHT/LOOP_WIDTH/LOOP_WIDTH:acc#7 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH/LOOP_HEIGHT/LOOP_HEIGHT:acc#1 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH/LOOP_HEIGHT/LOOP_HEIGHT:acc#3 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH/LOOP_CH:acc#1 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::maxpool/run_max/run_max:rlp/main/LOOP_CH/LOOP_CH:acc#3 CSTEPS_FROM {{.. == 2}}

# Probe constraints
