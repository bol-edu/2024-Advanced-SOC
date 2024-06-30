//=============================================================================================================//
//                                              include define module                                          //
//=============================================================================================================//
#include "/home/m110/m110063553/catapult/test_wbgain/hls_c/inc/HDRISP_defs.h"
//=============================================================================================================//

//=============================================================================================================//
//                                              include modified cmodel module                                 //
//=============================================================================================================//
#include "/home/m110/m110063553/catapult/test_wbgain/cmodel/inc/sources/modules/unpack.h"
#include "/home/m110/m110063553/catapult/test_wbgain/cmodel/inc/sources/modules/depwl.h"
#include "/home/m110/m110063553/catapult/test_wbgain/cmodel/inc/sources/modules/dpc.h"
#include "/home/m110/m110063553/catapult/test_wbgain/cmodel/inc/sources/modules/lsc.h"
#include "/home/m110/m110063553/catapult/test_wbgain/cmodel/inc/sources/modules/blc.h"
#include "/home/m110/m110063553/catapult/test_wbgain/cmodel/inc/sources/modules/wbgain.h"
//=============================================================================================================//

//=============================================================================================================//
//                                              include original cmodel module                                 //
//=============================================================================================================//

#include "/home/m110/m110063553/catapult/test_wbgain/cmodel/inc/sources/modules/wbgain.cpp"


//=============================================================================================================//
//                                              include hls module                                             //
//=============================================================================================================//
#include "/home/m110/m110063553/catapult/test_wbgain/hls_c/inc/wbgain.h"
//=============================================================================================================//


//=============================================================================================================//
//                                              include libraries                                              //
//=============================================================================================================//
#include <mc_scverify.h>
//=============================================================================================================//


INITIALIZE_EASYLOGGINGPP

extern int ParseIspCfgFile(const std::string cfg_file_path, IspPrms &isp_prm);

CCS_MAIN(int argc, char** argv)
{	
	const int iW = 768;//6080;//640;
	const int iH = 512;//4044;//480;
	
	
	
	IspPrms isp_prms;
	
	
	auto ret = ParseIspCfgFile(argv[1], isp_prms);
	if (ret)
    {
        LOG(ERROR) << argv[1] << " parse failed\n";
        return -1;
    }

    auto width = isp_prms.info.width;
    auto height = isp_prms.info.height;
	
 
//=============================================================================================================//	
//                                     instance   (modified algorithm)                                         //
//=============================================================================================================//
    unpack_algorithm<iW,iH> 	ref_unpack_inst;
	depwl_algorithm<iW,iH>  	ref_depwl_inst;
	dpc_algorithm<iW,iH>    	ref_dpc_inst;
	lsc_algorithm<iW,iH>    	ref_lsc_inst;
	blc_algorithm<iW,iH>    	ref_blc_inst;
    wbgain_algorithm<iW,iH>     ref_wbgain_inst;	
   	HDRISP_IP::wbgain u_wbgain;
	
//=============================================================================================================//	
//                                     wbgain.h    (modified algorithm)                                        //
//=============================================================================================================//    
	Frame frame(isp_prms.info);
	frame.ReadFileToFrame(isp_prms.raw_file, width * height * isp_prms.info.bpp / 8);  // ( raw file, size)
	ref_unpack_inst.MipiDataUnpack(&frame, &isp_prms);  
	ref_depwl_inst.Depwl(&frame, &isp_prms);
	ref_dpc_inst.Dpc(&frame, &isp_prms);
	ref_lsc_inst.Lsc(&frame, &isp_prms);
	ref_blc_inst.Blc(&frame, &isp_prms);
    ref_wbgain_inst.WbGain(&frame, &isp_prms);
	//Blc(&frame, &isp_prms);
	//WbGain(&frame, &isp_prms);
	//Demoasic(&frame, &isp_prms);
	//Ccm(&frame, &isp_prms);
	//Ltm(&frame, &isp_prms);
	//RgbGamma(&frame, &isp_prms);
	//Rgb2Yuv(&frame, &isp_prms);
	//YGamma(&frame, &isp_prms);
	//Contrast(&frame, &isp_prms);
	//Sharpen(&frame, &isp_prms);
	//Cns(&frame, &isp_prms);
	//Saturation(&frame, &isp_prms);
	//Yuv2Bgr(&frame, &isp_prms);
  
//=============================================================================================================//	
//                                     wbgain.cpp    (original algorithm)                                      //
//=============================================================================================================//    
	Frame frame2(isp_prms.info);
	frame2.ReadFileToFrame(isp_prms.raw_file, width * height * isp_prms.info.bpp / 8);  // ( raw file, size)
	ref_unpack_inst.MipiDataUnpack(&frame2, &isp_prms);  
	ref_depwl_inst.Depwl(&frame2, &isp_prms);
	ref_dpc_inst.Dpc(&frame2, &isp_prms);
	ref_lsc_inst.Lsc(&frame2, &isp_prms);
	ref_blc_inst.Blc(&frame2, &isp_prms);
    WbGain(&frame2, &isp_prms);  
 
//=============================================================================================================//	
//                                     wbgain.h    (hls)                                                       //
//=============================================================================================================//  
	Frame frame3(isp_prms.info);
	frame3.ReadFileToFrame(isp_prms.raw_file, width * height * isp_prms.info.bpp / 8);
	ref_unpack_inst.MipiDataUnpack(&frame3, &isp_prms);  
	ref_depwl_inst.Depwl(&frame3, &isp_prms);
	ref_dpc_inst.Dpc(&frame3, &isp_prms);
	ref_lsc_inst.Lsc(&frame3, &isp_prms);
	ref_blc_inst.Blc(&frame3, &isp_prms);
 
	int32_t * dataIn_ptr = (int32_t *)frame3.data.raw_s32_i;
	int32 data_hls = 0;
	HDRISP_IP::stream_32 dataIn_chn;
	HDRISP_IP::stream_32 dataOut_chn;
	
	HDRISP_IP::maxWType widthIn  = 768;//6080;
    HDRISP_IP::maxHType heightIn = 512;//4044;
	

	std::cout << "Test1" << std::endl;
	for(int i = 0; i < (iW) * (iH); i++){
		data_hls = dataIn_ptr[i];
		if(i <= 100){
			std::cout << "i = " << i << ", data_hls = " <<(int) data_hls << std::endl;
		}
		dataIn_chn.write(data_hls);
		
	}
	
	std::cout << "Test2" << std::endl;
	HDRISP_IP::stream_wbgain wbgain_prmIn;
	HDRISP_IP::WbGain wbgain_prmTmp;  
  
 	for (int i = 0; i < 4; ++i) {
	  wbgain_prmTmp.d65_gain[i] = isp_prms.wb_gains.d65_gain[i];
	  std::cout << " wbgain_prmTmp.d65_gain[i] = " <<  wbgain_prmTmp.d65_gain[i] << std::endl;
	  std::cout << " isp_prms.wb_gains.d65_gain[i] = " <<  isp_prms.wb_gains.d65_gain[i] << std::endl;
	}
	for (int i = 0; i < 4; ++i) {
	  wbgain_prmTmp.d50_gain[i] = isp_prms.wb_gains.d50_gain[i];
	  std::cout << " wbgain_prmTmp.d50_gain[i] = " <<  wbgain_prmTmp.d50_gain[i] << std::endl;
	  std::cout << " isp_prms.wb_gains.d50_gain[i] = " <<  isp_prms.wb_gains.d50_gain[i] << std::endl;
	}
	for (int i = 0; i < 4; ++i) {
	  wbgain_prmTmp.f11_gain[i] = isp_prms.wb_gains.f11_gain[i];
	  std::cout << " wbgain_prmTmp.f11_gain[i] = " <<  wbgain_prmTmp.f11_gain[i] << std::endl;
	  std::cout << " isp_prms.wb_gains.f11_gain[i] = " <<  isp_prms.wb_gains.f11_gain[i] << std::endl;
	}
	for (int i = 0; i < 4; ++i) {
	  wbgain_prmTmp.f12_gain[i] = isp_prms.wb_gains.f12_gain[i];
	  std::cout << " wbgain_prmTmp.f12_gain[i] = " <<  wbgain_prmTmp.f12_gain[i] << std::endl;
	  std::cout << " isp_prms.wb_gains.f12_gain[i] = " <<  isp_prms.wb_gains.f12_gain[i] << std::endl;
	}
  
 
	std::cout << "Test2_1" << std::endl;
	wbgain_prmIn.write(wbgain_prmTmp);

	int32 cfa = (int32)((int)(isp_prms.info.cfa));
  
	std::cout << "Test2_2" << std::endl;
	int max_val = isp_prms.info.max_val;
	u_wbgain.run(dataIn_chn, widthIn, heightIn, cfa, max_val, wbgain_prmIn, dataOut_chn);
	std::cout << "Test3" << std::endl;
 
  



 

//=============================================================================================================//	
//                                     compare wbgain_algorithm (data1) and wbgain.cpp (data2)                 //
//=============================================================================================================//  	
	int err_num = 0;
	int32_t* data1;
	int32_t* data2;
	data1 = (int32_t*)frame.data.raw_s32_i;
	data2 = (int32_t*)frame2.data.raw_s32_i;
	
	for(int i = 0; i < iH + 8; i++){
		for(int j = 0; j < iW + 8; j++){
			if((int)data1[i * iW + j] != (int)data2[i * iW + j]){
				std::cout << "No." << i * iW + j << " = " << (int)data1[i * iW + j] 
				          << ", data2 = " << (int)data2[i * iW + j] << std::endl;
				err_num += 1;
			}
		}
	}
	
	if(err_num == 0){
		std::cout << "====Algorithm.h is the same as Algorithm.cpp!====" << std::endl;
	}

//=============================================================================================================//	
//                                     compare wbgain_hls (data_hls_out) and wbgain.cpp (data2)                //
//=============================================================================================================//  
	int hls_err_num = 0;
 	//int32_t* data2;
	//data2 = (int32_t*)frame.data.raw_s32_i;
	int32 data_hls_out = 0;
	for(int i = 0; i < (iW) * (iH); i++){
		data_hls_out = dataOut_chn.read();
		if((int)data_hls_out != (int)data2[i]){
			if(i <= 2560){
				std::cout << "No." << i << " = " << (int)data_hls_out 
				          << ", data2 = " << (int)data2[i] << std::endl;
			}
			hls_err_num += 1;
		}
	}
	
	if(hls_err_num == 0){
		std::cout << "====HLS_C is the same as Algorithm.cpp!====" << std::endl;
	}else{
		std::cout << "There are " << hls_err_num << " errors with HLS_C!" << std::endl;
	}
 
 
 
 
	//save data
	int32_t* data;
	data = (int32_t*)frame.data.raw_s32_i;
	FILE *fptr;
    fptr = fopen("wbgain.txt","w");
	
	for(int i = 0; i < iH; i++){
		for(int j = 0; j < iW; j++){
			//const char data_char = (char)(data[i * iW + j]); 
			if(i * iW + j < 100){
				//std::cout << (int)data_char << std::endl;
			}
			//fprintf(fptr, "0x%08x", data[i * iW + j]);
			fprintf(fptr, " ");
		}
		fprintf(fptr, "\n");
	}
	fclose(fptr);
	
//=============================================================================================================//	
//                                        download modified algorithm image                                    //
//=============================================================================================================//   
  //WriteMemToFile(isp_prms.out_file_path + "isp_result_bgr.raw", frame.data.bgr_u8_o, width * height * 3);
   /* FILE* modified_fp;
    modified_fp = fopen("modified.raw", "wb");
    
    if (!modified_fp) {
        LOG(ERROR) << "modified.raw open failed";
        return -1;
    }


    
    size_t modified_rd = fwrite(frame.data.raw_s32_i, width * height * 3, 1, modified_fp);
    
    if (modified_rd != 1) {
        LOG(ERROR) << "Failed to write data to modified.raw";
        fclose(modified_fp);
        return -1;
    }
    
      fclose(modified_fp);
	  */
//=============================================================================================================//      

//=============================================================================================================//	
//                                        download original algorithm image                                    //
//=============================================================================================================//  
 /*   FILE* original_fp;
    original_fp = fopen("original.raw", "wb");
    
    if (!original_fp) {
        LOG(ERROR) << "original.raw open failed";
        return -1;
    }


    
    size_t original_rd = fwrite(frame2.data.raw_s32_i, width * height * 3, 1, original_fp);
    
    if (original_rd != 1) {
        LOG(ERROR) << "Failed to write data to original.raw";
        fclose(original_fp);
        return -1;
    }
    
      fclose(original_fp);  
	*/  
//=============================================================================================================//      
    
    return 0;
}
