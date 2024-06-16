
# Loop constraints
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp CSTEPS_FROM {{. == 0}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main CSTEPS_FROM {{. == 3} {.. == 0}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/for CSTEPS_FROM {{. == 2} {.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/for/for:for CSTEPS_FROM {{. == 1} {.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/for/for:for/for:for:for CSTEPS_FROM {{. == 4} {.. == 0}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT CSTEPS_FROM {{. == 2} {.. == 2}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN CSTEPS_FROM {{. == 2} {.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT CSTEPS_FROM {{. == 2} {.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH CSTEPS_FROM {{. == 3} {.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X CSTEPS_FROM {{. == 1} {.. == 0}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y CSTEPS_FROM {{. == 4} {.. == 0}}

# IO operation constraints
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/padded_height:asn CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/padded_height:asn#1 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/padded_width:asn CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/padded_width:asn#1 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/filter_size:asn CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/filter_size:asn#1 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/for:asn CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/for/height:asn CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/for/for:for/for:for:for/width:asn CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/for/for:for/for:for:for/for:for:for:asn#2 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/for/for:for/for:for:for/for:for:for:asn#5 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/for/for:for/for:for:for/for:for:for:asn#6 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/for/for:for/for:for:for/for:for:for:asn#8 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/for/for:for/for:for:for/padded_width:asn#2 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/for/for:for/for:for:for/for:for:for:asn#10 CSTEPS_FROM {{.. == 3}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/for/for:for/for:for:for/padded_height:asn#2 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/for/for:for/for:for:for/padded_width:asn#3 CSTEPS_FROM {{.. == 3}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/for/for:for/height:asn#1 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/for/for:asn#3 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT:asn#1 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/operator_<2,false>:asn CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/height:asn#2 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/operator_<2,false>:asn#1 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/width:asn#1 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/operator_<2,false>:asn#2 CSTEPS_FROM {{.. == 0}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/operator_<2,false>:asn#3 CSTEPS_FROM {{.. == 0}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/operator_<2,false>:asn#4 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/padded_width:asn#4 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/padded_height:asn#3 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/padded_width:asn#5 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:asn#8 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/operator_<2,false>:asn#5 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:asn#11 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/operator_<2,false>:asn#6 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:asn#13 CSTEPS_FROM {{.. == 3}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/operator_<2,false>:asn#7 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/operator_<2,false>:asn#8 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_WIDTH:asn#4 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/operator_<2,false>:asn#9 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_WIDTH:asn#6 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_WIDTH:asn#7 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/width:asn#2 CSTEPS_FROM {{.. == 3}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/operator_<2,false>:asn#10 CSTEPS_FROM {{.. == 3}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/height:asn#3 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/operator_<2,false>:asn#11 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_IN:asn#2 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_OUT:asn#3 CSTEPS_FROM {{.. == 2}}

# Sync operation constraints

# Real operation constraints
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/padded_height:acc CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/padded_width:acc CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/filter_size:mul CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/for:acc#2 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/for/for:for:acc#2 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/for/for:for/for:for:for/for:for:for:acc#10 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/for/for:for/for:for:for/for:for:for:mul#5 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/for/for:for/for:for:for/for:for:for:acc CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/for/for:for/for:for:for/for:for:for:mul#4 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/for/for:for/for:for:for/for:for:for:mul#3 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/for/for:for/for:for:for/for:for:for:acc#8 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/for/for:for/for:for:for/for:for:for:read_mem(input:rsc.@) CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/for/for:for/for:for:for/for:for:for:acc#4 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/for/for:for/for:for:for/for:for:for:mul#2 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/for/for:for/for:for:for/for:for:for:acc#11 CSTEPS_FROM {{.. == 3}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/for/for:for/for:for:for/for:for:for:acc#12 CSTEPS_FROM {{.. == 3}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/for/for:for/for:for:for/for:for:for:mul#1 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/for/for:for/for:for:for/for:for:for:mul CSTEPS_FROM {{.. == 3}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/for/for:for/for:for:for/for:for:for:acc#9 CSTEPS_FROM {{.. == 3}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/for/for:for/for:for:for/for:for:for:write_mem(padded_input:rsc.@) CSTEPS_FROM {{.. == 3}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/for/for:for/for:for:for/for:for:for:acc#7 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/for/for:for/for:for:for/for:for:for:mux CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/for/for:for/for:for:acc#1 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/for/for:for/for:for:acc#3 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/for/for:acc#1 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/for/for:acc#3 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT:acc#2 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT:acc#4 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH:acc#8 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:acc#1 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:acc#4 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:mul#2 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:acc#14 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:acc CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:mul#1 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:mul CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:acc#2 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:read_mem(padded_input:rsc.@) CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:mul#4 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:mul#3 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:mul#5 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:acc#10 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:mul#6 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:acc#15 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:acc#16 CSTEPS_FROM {{.. == 3}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:acc#17 CSTEPS_FROM {{.. == 3}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:acc#6 CSTEPS_FROM {{.. == 3}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:read_rom(UNET_IP::filters_pretrain.rom#3_map_1) CSTEPS_FROM {{.. == 3}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:mul#7 CSTEPS_FROM {{.. == 4}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:acc#12 CSTEPS_FROM {{.. == 4}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:acc#13 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:mux#1 CSTEPS_FROM {{.. == 4}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:mux CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_X:acc#2 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_X:acc#1 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_WIDTH:acc#9 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_WIDTH:mul#2 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_WIDTH:acc#10 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_WIDTH:acc#11 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_WIDTH:mul#1 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_WIDTH:mul CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_WIDTH:acc#2 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_WIDTH:write_mem(output:rsc.@) CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_WIDTH:acc#6 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_WIDTH:acc#12 CSTEPS_FROM {{.. == 3}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_HEIGHT:acc#2 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_HEIGHT:acc#5 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_IN:acc#1 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_IN/LOOP_IN:acc#3 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_OUT:acc#1 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::conv2d/run_conv/run_conv:rlp/main/LOOP_OUT/LOOP_OUT:acc#3 CSTEPS_FROM {{.. == 2}}

# Probe constraints
