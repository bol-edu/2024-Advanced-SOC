//=============================================================================================================//
//                                              include define module                                          //
//=============================================================================================================//
#include "/home/m110/m110063553/catapult/test_rgb2yuv/hls_c/inc/HDRISP_defs.h"
//=============================================================================================================//

//=============================================================================================================//
//                                              include modified cmodel module                                 //
//=============================================================================================================//
#include "/home/m110/m110063553/catapult/test_rgb2yuv/cmodel/inc/sources/modules/unpack.h"
#include "/home/m110/m110063553/catapult/test_rgb2yuv/cmodel/inc/sources/modules/depwl.h"
#include "/home/m110/m110063553/catapult/test_rgb2yuv/cmodel/inc/sources/modules/dpc.h"
#include "/home/m110/m110063553/catapult/test_rgb2yuv/cmodel/inc/sources/modules/lsc.h"
#include "/home/m110/m110063553/catapult/test_rgb2yuv/cmodel/inc/sources/modules/blc.h"
#include "/home/m110/m110063553/catapult/test_rgb2yuv/cmodel/inc/sources/modules/wbgain.h"
#include "/home/m110/m110063553/catapult/test_rgb2yuv/cmodel/inc/sources/modules/demoasic.h"
#include "/home/m110/m110063553/catapult/test_rgb2yuv/cmodel/inc/sources/modules/ccm.h"
#include "/home/m110/m110063553/catapult/test_rgb2yuv/cmodel/inc/sources/modules/ltm.h"
#include "/home/m110/m110063553/catapult/test_rgb2yuv/cmodel/inc/sources/modules/rgbgamma.h"
#include "/home/m110/m110063553/catapult/test_rgb2yuv/cmodel/inc/sources/modules/rgb2yuv.h"
//=============================================================================================================//

//=============================================================================================================//
//                                              include original cmodel module                                 //
//=============================================================================================================//

#include "/home/m110/m110063553/catapult/test_rgb2yuv/cmodel/inc/sources/modules/rgb2yuv.cpp"



//=============================================================================================================//
//                                              include hls module                                             //
//=============================================================================================================//
#include "/home/m110/m110063553/catapult/test_rgb2yuv/hls_c/inc/rgb2yuv.h"
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
	rgb2yuv_algorithm<iW,iH>   ref_rgb2yuv_inst;	
   	HDRISP_IP::rgb2yuv u_rgb2yuv;
	
//=============================================================================================================//	
//                                     rgb2yuv.h    (modified algorithm)                                       //
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
	ref_rgb2yuv_inst.Rgb2Yuv(&frame, &isp_prms);

//=============================================================================================================//	
//                                     rgb2yuv.cpp    (original algorithm)                                     //
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
	ref_rgbgamma_inst.RgbGamma(&frame2, &isp_prms);
	Rgb2Yuv(&frame2, &isp_prms);
  
 
//=============================================================================================================//	
//                                     rgb2yuv.h    (hls)                                                      //
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
	ref_rgbgamma_inst.RgbGamma(&frame3, &isp_prms);
 
	int32_t * dataIn_ptr = (int32_t *)frame3.data.bgr_s32_i;
	int32 data_hls = 0;
	HDRISP_IP::stream_32 dataIn_chn;
	HDRISP_IP::stream_32 dataOut_chn;
	
	HDRISP_IP::maxWType widthIn  = 768;//6080;
	HDRISP_IP::maxHType heightIn = 512;//4044;
	

	std::cout << "Test1" << std::endl;
	
	for(int i = 0; i < iW * iH ; i++){
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
/*
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
*/
  
	std::cout << "Test2_1" << std::endl;  
	
	std::cout << "Test2_2" << std::endl;
	
	u_rgb2yuv.run(dataIn_chn, widthIn, heightIn, dataOut_chn);
	
	std::cout << "Test3" << std::endl;

//=============================================================================================================//	
//                                     compare rgb2yuv_algorithm (data1) and rgb2yuv.cpp (data2)               //
//=============================================================================================================//  	
	int err_num = 0;
	uint8_t* data1_y;
	uint8_t* data1_u;
	uint8_t* data1_v;
	uint8_t* data2_y;
	uint8_t* data2_u;
	uint8_t* data2_v;
	data1_y = (uint8_t*)frame.data.yuv_u8_i.y;
	data1_u = (uint8_t*)frame.data.yuv_u8_i.u;
	data1_v = (uint8_t*)frame.data.yuv_u8_i.v;
	data2_y = (uint8_t*)frame2.data.yuv_u8_i.y;
	data2_u = (uint8_t*)frame2.data.yuv_u8_i.u;
	data2_v = (uint8_t*)frame2.data.yuv_u8_i.v;
	
	for(int i = 0; i < iH; i++){
		for(int j = 0; j < iW; j++){
		
		  if((int)data1_y[i * iW + j] != (int)data2_y[i * iW + j]){
					//std::cout << "U: No." << (i * iW + j)  << " = " << (int)data1[i * iW + j] 
					//          << ", data2 = " << (int)data2[(i * iW + j) * 3 + k] << std::endl;
					err_num += 1;
		  }
		
		  if((int)data1_u[i * iW + j] != (int)data2_u[i * iW + j]){
  	        //std::cout << "U: No." << (i * iW + j)  << " = " << (int)data1[i * iW + j] 
  	        //          << ", data2 = " << (int)data2[(i * iW + j) * 3 + k] << std::endl;
  	        err_num += 1;
		  }
			
		  if((int)data1_v[i * iW + j] != (int)data2_v[i * iW + j]){
  	        //std::cout << "V: No." << (i * iW + j) << " = " << (int)data1[i * iW + j] 
  	        //          << ", data2 = " << (int)data2[i * iW + j] << std::endl;
  	        err_num += 1;
		  }
			
		}
	}
	
	if(err_num == 0){
		std::cout << "====Algorithm.h is the same as Algorithm.cpp!====" << std::endl;
	}else{
		std::cout << "There are " << err_num << " errors with Algorithm!" << std::endl;
	}
	
//=============================================================================================================//	
//                                     compare rgb2yuv_hls (data_hls_out) and rgb2yuv.cpp (data2)              //
//=============================================================================================================//  
	int hls_err_num = 0;
	int32 data_hls_out = 0;
	uint8 data_hls_out_y = 0;
	uint8 data_hls_out_u = 0;
	uint8 data_hls_out_v = 0;
	for(int i = 0; i < iH; i++){
		for(int j = 0; j < iW; j++){
			
		  data_hls_out = dataOut_chn.read();
		  data_hls_out_v = data_hls_out.slc<8>(0);  	// get lowest 8 bits
		  data_hls_out_u = data_hls_out.slc<8>(8);  	// get lowest 8 bits after 8bits
		  data_hls_out_y = data_hls_out.slc<8>(16);  	// get lowest 8 bits after 16bits
		  //std::cout << "data_hls_out_y = " << (unsigned)((uint8_t)data_hls_out_y) << std::endl;

		  
		  if(abs((int)data_hls_out_y - (int)data2_y[i * iW + j]) > 1){
			if(i * iW + j < 7680){
  	          std::cout << "Y: No." << (i * iW + j)  << " = " << (int)data_hls_out_y 
  	                    << ", data2 = " << (int)data2_y[i * iW + j] << std::endl;
  	        }
			hls_err_num += 1;
			
		  }
		  
		  if(abs((int)data_hls_out_u - (int)data2_u[i * iW + j]) > 1){
			if(i * iW + j < 7680){
  	          std::cout << "U: No." << (i * iW + j)  << " = " << (int)data_hls_out_u 
  	                    << ", data2 = " << (int)data2_u[i * iW + j] << std::endl;
  	        }
			hls_err_num += 1;
			
		  }
			
		  if(abs((int)data_hls_out_v - (int)data2_v[i * iW + j]) > 1){
			if(i * iW + j < 7680){
  	          std::cout << "V: No." << (i * iW + j) << " = " << (int)data_hls_out_v 
  	                    << ", data2 = " << (int)data2_v[i * iW + j] << std::endl;
  	        }
			hls_err_num += 1;
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
