//=============================================================================================================//
//                                              include define module                                          //
//=============================================================================================================//
#include "/home/m110/m110063553/catapult/test_rgbgamma/hls_c/inc/HDRISP_defs.h"
//=============================================================================================================//

//=============================================================================================================//
//                                              include modified cmodel module                                 //
//=============================================================================================================//
#include "/home/m110/m110063553/catapult/test_rgbgamma/cmodel/inc/sources/modules/unpack.h"
#include "/home/m110/m110063553/catapult/test_rgbgamma/cmodel/inc/sources/modules/depwl.h"
#include "/home/m110/m110063553/catapult/test_rgbgamma/cmodel/inc/sources/modules/dpc.h"
#include "/home/m110/m110063553/catapult/test_rgbgamma/cmodel/inc/sources/modules/lsc.h"
#include "/home/m110/m110063553/catapult/test_rgbgamma/cmodel/inc/sources/modules/blc.h"
#include "/home/m110/m110063553/catapult/test_rgbgamma/cmodel/inc/sources/modules/wbgain.h"
#include "/home/m110/m110063553/catapult/test_rgbgamma/cmodel/inc/sources/modules/demoasic.h"
#include "/home/m110/m110063553/catapult/test_rgbgamma/cmodel/inc/sources/modules/ccm.h"
#include "/home/m110/m110063553/catapult/test_rgbgamma/cmodel/inc/sources/modules/ltm.h"
#include "/home/m110/m110063553/catapult/test_rgbgamma/cmodel/inc/sources/modules/rgbgamma.h"
//=============================================================================================================//

//=============================================================================================================//
//                                              include original cmodel module                                 //
//=============================================================================================================//

#include "/home/m110/m110063553/catapult/test_rgbgamma/cmodel/inc/sources/modules/rgbgamma.cpp"



//=============================================================================================================//
//                                              include hls module                                             //
//=============================================================================================================//
#include "/home/m110/m110063553/catapult/test_rgbgamma/hls_c/inc/rgbgamma.h"
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
    unpack_algorithm<iW,iH>    ref_unpack_inst;
	depwl_algorithm<iW,iH>     ref_depwl_inst;
	dpc_algorithm<iW,iH>       ref_dpc_inst;
	lsc_algorithm<iW,iH>       ref_lsc_inst;
	blc_algorithm<iW,iH>       ref_blc_inst;
    wbgain_algorithm<iW,iH>    ref_wbgain_inst;	
    demoasic_algorithm<iW,iH>  ref_demoasic_inst;	
    ccm_algorithm<iW,iH>       ref_ccm_inst;	
    ltm_algorithm<iW,iH>       ref_ltm_inst;	
    rgbgamma_algorithm<iW,iH>  ref_rgbgamma_inst;	
   	HDRISP_IP::rgbgamma u_rgbgamma;
	
//=============================================================================================================//	
//                                     rgbgamma.h    (modified algorithm)                                      //
//=============================================================================================================//    
	Frame frame(isp_prms.info);
	frame.ReadFileToFrame(isp_prms.raw_file, width * height * isp_prms.info.bpp / 8);  // ( raw file, size)
	ref_unpack_inst.MipiDataUnpack(&frame, &isp_prms);  
	ref_depwl_inst.Depwl(&frame, &isp_prms);
	ref_dpc_inst.Dpc(&frame, &isp_prms);
	ref_lsc_inst.Lsc(&frame, &isp_prms);
	ref_blc_inst.Blc(&frame, &isp_prms);
	ref_wbgain_inst.WbGain(&frame, &isp_prms);
	ref_demoasic_inst.Demoasic(&frame, &isp_prms);
	ref_ccm_inst.Ccm(&frame, &isp_prms);
	ref_ltm_inst.Ltm(&frame, &isp_prms);
	ref_rgbgamma_inst.RgbGamma(&frame, &isp_prms);

//=============================================================================================================//	
//                                     rgbgamma.cpp    (original algorithm)                                    //
//=============================================================================================================//    
	Frame frame2(isp_prms.info);
	frame2.ReadFileToFrame(isp_prms.raw_file, width * height * isp_prms.info.bpp / 8);  // ( raw file, size)
	ref_unpack_inst.MipiDataUnpack(&frame2, &isp_prms);  
	ref_depwl_inst.Depwl(&frame2, &isp_prms);
	ref_dpc_inst.Dpc(&frame2, &isp_prms);
	ref_lsc_inst.Lsc(&frame2, &isp_prms);
	ref_blc_inst.Blc(&frame2, &isp_prms);
    ref_wbgain_inst.WbGain(&frame2, &isp_prms);
	ref_demoasic_inst.Demoasic(&frame2, &isp_prms);
	ref_ccm_inst.Ccm(&frame2, &isp_prms);
	ref_ltm_inst.Ltm(&frame2, &isp_prms);
	RgbGamma(&frame2, &isp_prms);
  
 
//=============================================================================================================//	
//                                     rgbgamma.h    (hls)                                                     //
//=============================================================================================================//  
	Frame frame3(isp_prms.info);
	frame3.ReadFileToFrame(isp_prms.raw_file, width * height * isp_prms.info.bpp / 8);
	ref_unpack_inst.MipiDataUnpack(&frame3, &isp_prms);  
	ref_depwl_inst.Depwl(&frame3, &isp_prms);
	ref_dpc_inst.Dpc(&frame3, &isp_prms);
	ref_lsc_inst.Lsc(&frame3, &isp_prms);
	ref_blc_inst.Blc(&frame3, &isp_prms);
	ref_wbgain_inst.WbGain(&frame3, &isp_prms);
	ref_demoasic_inst.Demoasic(&frame3, &isp_prms);
	ref_ccm_inst.Ccm(&frame3, &isp_prms);
	ref_ltm_inst.Ltm(&frame3, &isp_prms);

 
	int32_t * dataIn_ptr = (int32_t *)frame3.data.bgr_s32_i;
	int32 data_hls = 0;
	HDRISP_IP::stream_32 dataIn_chn;
	HDRISP_IP::stream_32 dataOut_chn;
	
	HDRISP_IP::maxWType widthIn  = 768;//6080;
	HDRISP_IP::maxHType heightIn = 512;//4044;
	

	std::cout << "Test1" << std::endl;
	
	for(int i = 0; i < iW * iH * 3; i++){
		for(int j = 0; j < 3; j++){
		  data_hls = dataIn_ptr[i * 3 + j];
          if(i <= 100){
			//std::cout << "i = " << i << ", data_hls = " << (int)data_hls << std::endl;
		  }
		  dataIn_chn.write(data_hls);	
		  //std::cout << "index = " << i *3 + j << std::endl;
		}
	}
 
//=============================================================================================================//	
//                                   input  parameters                                                         //
//=============================================================================================================//  

	std::cout << "Test2" << std::endl;
	HDRISP_IP::stream_rgbgamma rgbgamma_prmIn;
	HDRISP_IP::RgbGammmaCurve rgbgamma_prmTmp;
 
	rgbgamma_prmTmp.nums = isp_prms.rgb_gamma.nums;
	std::cout << "isp_prms.rgb_gamma.nums = " << isp_prms.rgb_gamma.nums << std::endl;
	std::cout << "rgbgamma_prmTmp.nums = " << rgbgamma_prmTmp.nums << std::endl;
	
	rgbgamma_prmTmp.in_bits = isp_prms.rgb_gamma.in_bits;
	std::cout << "rgbgamma_prmTmp.in_bits = " << rgbgamma_prmTmp.in_bits << std::endl;
 	std::cout << "isp_prms.rgb_gamma.in_bits = " << isp_prms.rgb_gamma.in_bits << std::endl;

	rgbgamma_prmTmp.out_bits = isp_prms.rgb_gamma.out_bits;  
 	std::cout << "rgbgamma_prmTmp.out_bits = " << rgbgamma_prmTmp.out_bits << std::endl;
	std::cout << "isp_prms.rgb_gamma.out_bits = " << isp_prms.rgb_gamma.out_bits << std::endl;
  
 	for (int i = 0; i < MAX_GAMMA_NUMS; ++i) {
	  rgbgamma_prmTmp.curve[i] = isp_prms.rgb_gamma.curve[i];
    std::cout << "rgbgamma_prmTmp.curve[i] = " << rgbgamma_prmTmp.curve[i] << std::endl;
	std::cout << "isp_prms.rgb_gamma.curve[i] = " << isp_prms.rgb_gamma.curve[i] << std::endl;
    }

  
	std::cout << "Test2_1" << std::endl;
	rgbgamma_prmIn.write(rgbgamma_prmTmp);

  
	std::cout << "Test2_2" << std::endl;
	u_rgbgamma.run(dataIn_chn, widthIn, heightIn, rgbgamma_prmIn, dataOut_chn);
	std::cout << "Test3" << std::endl;

//=============================================================================================================//	
//                                     compare rgbgamma_algorithm (data1) and rgbgamma.cpp (data2)             //
//=============================================================================================================//  	
	int err_num = 0;
	int32_t* data1;
	int32_t* data2;
	data1 = (int32_t*)frame.data.bgr_s32_i;
	data2 = (int32_t*)frame2.data.bgr_s32_i;
	
	for(int i = 0; i < iH; i++){
		for(int j = 0; j < iW; j++){
			for(int k = 0; k <3; k++){
			  if((int)data1[(i * iW + j) * 3 + k] != (int)data2[(i * iW + j) * 3 + k]){
				//std::cout << "No." << (i * iW + j) * 3 + k << " = " << (int)data1[(i * iW + j) * 3 + k] 
				//          << ", data2 = " << (int)data2[(i * iW + j) * 3 + k] << std::endl;
				err_num += 1;
			  }
			}
			
		}
	}
	
	if(err_num == 0){
		std::cout << "====Algorithm.h is the same as Algorithm.cpp!====" << std::endl;
	}else{
		std::cout << "There are " << err_num << " errors with Algorithm!" << std::endl;
	}
	
//=============================================================================================================//	
//                                     compare rgbgamma_hls (data_hls_out) and rgbgamma.cpp (data2)            //
//=============================================================================================================//  
	int hls_err_num = 0;
	int32 data_hls_out = 0;
 	//int32_t* data1;
	//data1 = (int32_t*)frame.data.bgr_s32_i;
  //std::cout << "data1 = " << data1 << std::endl;
	for(int i = 0; i < iH; i++){
		for(int j = 0; j < iW; j++){
			for(int k = 0; k <3; k++){
			  data_hls_out = dataOut_chn.read();
			  if((int)data_hls_out != (int)data2[(i * iW + j) * 3 + k]){
				  /*
				if((i * iW + j) < 1536){
			      std::cout << "No." << (i * iW + j) * 3 + k << " = " << (int)data_hls_out 
				          << ", data2 = " << (int)data2[(i * iW + j) * 3 + k] << std::endl;  
				}
				*/
				hls_err_num += 1;
			  }
			}
			
		}
	}
	
	if(hls_err_num == 0){
		std::cout << "====HLS_C is the same as Algorithm.cpp!====" << std::endl;
	}else{
		std::cout << "There are " << hls_err_num << " errors with HLS_C!" << std::endl;
	}

/*
 
	//save data
	int32_t* data;
	data = (int32_t*)frame.data.bgr_s32_i;
	FILE *fptr;
    fptr = fopen("rgbgamma.txt","w");
	
	for(int i = 0; i < iH + 8; i++){
		for(int j = 0; j < iW + 8; j++){
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
	*/   
    return 0;
}
