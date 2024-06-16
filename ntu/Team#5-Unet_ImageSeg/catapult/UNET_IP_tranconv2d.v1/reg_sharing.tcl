directive set /UNET_IP::tranconv2d/UNET_IP::tranconv2d:run_tran/run_tran/LOOP_RESET.stage_0.3 REGISTER_NAME LOOP_RESET.stage_0.3
directive set /UNET_IP::tranconv2d/UNET_IP::tranconv2d:run_tran/run_tran/LOOP_X:acc#2.cse.sva(2) REGISTER_NAME LOOP_RESET.stage_0.3
directive set /UNET_IP::tranconv2d/UNET_IP::tranconv2d:run_tran/run_tran/LOOP_Y:mul#4.itm REGISTER_NAME LOOP_Y:mul#4.itm
directive set /UNET_IP::tranconv2d/UNET_IP::tranconv2d:run_tran/run_tran/LOOP_Y:asn.itm REGISTER_NAME LOOP_Y:mul#4.itm
directive set /UNET_IP::tranconv2d/UNET_IP::tranconv2d:run_tran/run_tran/LOOP_Y:slc(LOOP_Y:LOOP_Y:mul)(15-4).itm REGISTER_NAME LOOP_Y:slc(LOOP_Y:LOOP_Y:mul)(15-4).itm
directive set /UNET_IP::tranconv2d/UNET_IP::tranconv2d:run_tran/run_tran/LOOP_Y:read_rom(UNET_IP::filters_pretrain.rom#3_map_1).itm REGISTER_NAME LOOP_Y:slc(LOOP_Y:LOOP_Y:mul)(15-4).itm
