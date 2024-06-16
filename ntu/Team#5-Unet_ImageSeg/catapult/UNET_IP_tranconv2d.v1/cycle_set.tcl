
# Loop constraints
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp CSTEPS_FROM {{. == 0}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main CSTEPS_FROM {{. == 3} {.. == 0}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_RESET CSTEPS_FROM {{. == 4} {.. == 1}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT CSTEPS_FROM {{. == 1} {.. == 2}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_IN CSTEPS_FROM {{. == 2} {.. == 0}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT CSTEPS_FROM {{. == 2} {.. == 1}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH CSTEPS_FROM {{. == 2} {.. == 1}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X CSTEPS_FROM {{. == 2} {.. == 1}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y CSTEPS_FROM {{. == 8} {.. == 1}}

# IO operation constraints
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/filter_size:io_read(kernel_size:rsc.@) CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/out_height:io_read(stride:rsc.@) CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/out_height:io_read(height:rsc.@) CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/out_width:io_read(width:rsc.@) CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_RESET/LOOP_RESET:io_read(out_channels:rsc.@) CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT:io_read(out_channels:rsc.@)#1 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_IN/LOOP_IN:io_read(in_channels:rsc.@) CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:io_read(filter_offset:rsc.@) CSTEPS_FROM {{.. == 3}}

# Sync operation constraints

# Real operation constraints
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/filter_size:mul CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/out_height:mul CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/out_width:mul CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_RESET/LOOP_RESET:mul#1 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_RESET/LOOP_RESET:mul CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_RESET/LOOP_RESET:acc#2 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_RESET/LOOP_RESET:write_mem(output:rsc.@) CSTEPS_FROM {{.. == 3}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_RESET/LOOP_RESET:acc#1 CSTEPS_FROM {{.. == 3}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_RESET/LOOP_RESET:mux CSTEPS_FROM {{.. == 3}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT:acc#2 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_IN/LOOP_IN:acc#2 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT:acc#2 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH:acc#2 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X:acc#2 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:mul#7 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:acc#7 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:mul#11 CSTEPS_FROM {{.. == 3}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:mul#8 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:acc#13 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:acc#14 CSTEPS_FROM {{.. == 3}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:mul#10 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:mul#9 CSTEPS_FROM {{.. == 4}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:acc#9 CSTEPS_FROM {{.. == 4}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:read_mem(output:rsc.@) CSTEPS_FROM {{.. == 4}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:mul#2 CSTEPS_FROM {{.. == 3}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:acc#15 CSTEPS_FROM {{.. == 3}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:mul#1 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:mul CSTEPS_FROM {{.. == 5}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:acc#1 CSTEPS_FROM {{.. == 5}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:read_mem(input:rsc.@) CSTEPS_FROM {{.. == 5}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:mul#4 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:mul#3 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:mul#5 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:mul#6 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:acc#16 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:acc#17 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:acc#18 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:acc#3 CSTEPS_FROM {{.. == 3}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:read_rom(UNET_IP::filters_pretrain.rom#3_map_1) CSTEPS_FROM {{.. == 3}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:LOOP_Y:mul CSTEPS_FROM {{.. == 6}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:LOOP_Y:acc#3 CSTEPS_FROM {{.. == 7}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:write_mem(output:rsc.@) CSTEPS_FROM {{.. == 7}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:acc#11 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_Y/LOOP_Y:acc#19 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_X:acc#1 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_X/LOOP_X:acc#3 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_WIDTH:acc#1 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_WIDTH/LOOP_WIDTH:acc#3 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_HEIGHT:acc#1 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_IN/LOOP_HEIGHT/LOOP_HEIGHT:acc#3 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_IN/LOOP_IN:acc#1 CSTEPS_FROM {{.. == 2}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_OUT:acc#1 CSTEPS_FROM {{.. == 1}}
directive set /UNET_IP::tranconv2d/run_tran/run_tran:rlp/main/LOOP_OUT/LOOP_OUT:acc#3 CSTEPS_FROM {{.. == 1}}

# Probe constraints
