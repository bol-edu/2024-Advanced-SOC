//=============================================================================================================//
//                                              include define module                                          //
//=============================================================================================================//
#include "/home/m110/m110063553/catapult/test_sharpen/hls_c/inc/HDRISP_defs.h"
//=============================================================================================================//

//=============================================================================================================//
//                                              include modified cmodel module                                 //
//=============================================================================================================//
#include "/home/m110/m110063553/catapult/test_sharpen/cmodel/inc/sources/modules/unpack.h"
#include "/home/m110/m110063553/catapult/test_sharpen/cmodel/inc/sources/modules/depwl.h"
#include "/home/m110/m110063553/catapult/test_sharpen/cmodel/inc/sources/modules/dpc.h"
#include "/home/m110/m110063553/catapult/test_sharpen/cmodel/inc/sources/modules/lsc.h"
#include "/home/m110/m110063553/catapult/test_sharpen/cmodel/inc/sources/modules/blc.h"
#include "/home/m110/m110063553/catapult/test_sharpen/cmodel/inc/sources/modules/wbgain.h"
#include "/home/m110/m110063553/catapult/test_sharpen/cmodel/inc/sources/modules/demoasic.h"
#include "/home/m110/m110063553/catapult/test_sharpen/cmodel/inc/sources/modules/ccm.h"
#include "/home/m110/m110063553/catapult/test_sharpen/cmodel/inc/sources/modules/ltm.h"
#include "/home/m110/m110063553/catapult/test_sharpen/cmodel/inc/sources/modules/rgbgamma.h"
#include "/home/m110/m110063553/catapult/test_sharpen/cmodel/inc/sources/modules/rgb2yuv.h"
#include "/home/m110/m110063553/catapult/test_sharpen/cmodel/inc/sources/modules/ygamma.h"
#include "/home/m110/m110063553/catapult/test_sharpen/cmodel/inc/sources/modules/contrast.h"
#include "/home/m110/m110063553/catapult/test_sharpen/cmodel/inc/sources/modules/sharpen.h"
//=============================================================================================================//


//=============================================================================================================//
//                                              include original cmodel module                                 //
//=============================================================================================================//

#include "/home/m110/m110063553/catapult/test_sharpen/cmodel/inc/sources/modules/sharpen.cpp"

//=============================================================================================================//
//                                              include hls module                                             //
//=============================================================================================================//
#include "/home/m110/m110063553/catapult/test_sharpen/hls_c/inc/sharpen.h"
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
    ygamma_algorithm<iW,iH>    ref_ygamma_inst;
    contrast_algorithm<iW,iH>  ref_contrast_inst;		
    sharpen_algorithm<iW,iH>   ref_sharpen_inst;
	HDRISP_IP::sharpen u_sharpen;
	
//=============================================================================================================//	
//                                     sharpen.h    (modified algorithm)                                       //
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
	ref_ygamma_inst.YGamma(&frame, &isp_prms);
	ref_contrast_inst.Contrast(&frame, &isp_prms);
	ref_sharpen_inst.Sharpen(&frame, &isp_prms);
  
//=============================================================================================================//	
//                                     sharpen.cpp    (original algorithm)                                     //
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
	ref_rgb2yuv_inst.Rgb2Yuv(&frame2, &isp_prms);
	ref_ygamma_inst.YGamma(&frame2, &isp_prms);
	ref_contrast_inst.Contrast(&frame2, &isp_prms);
	Sharpen(&frame2, &isp_prms);
//=============================================================================================================//	
//                                     sharpen.h    (hls)                                                      //
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
	ref_rgb2yuv_inst.Rgb2Yuv(&frame3, &isp_prms);
	ref_ygamma_inst.YGamma(&frame3, &isp_prms);
	ref_contrast_inst.Contrast(&frame3, &isp_prms);
  
	uint8_t* dataY_ptr = (uint8_t*)frame3.data.yuv_u8_i.y;
	uint8_t* dataU_ptr = (uint8_t*)frame3.data.yuv_u8_i.u;
	uint8_t* dataV_ptr = (uint8_t*)frame3.data.yuv_u8_i.v;
	
	int32 data_hls = 0;
	uint8 null_byte = 0;
	uint8 data_y = 0;
	uint8 data_u = 0;
	uint8 data_v = 0;
	
	HDRISP_IP::stream_32 dataIn_chn;
	HDRISP_IP::stream_32 dataOut_chn;
	
	HDRISP_IP::maxWType widthIn  = 768;//6080;
	HDRISP_IP::maxHType heightIn = 512;//4044;
	

	std::cout << "Test1" << std::endl;
	for(int i = 0; i < iW * iH; i++){
		
	  data_y = dataY_ptr[i];
	  data_u = dataU_ptr[i];
	  data_v = dataV_ptr[i];
	  
	  data_hls.set_slc(24, null_byte);
	  data_hls.set_slc(16, data_y);
	  data_hls.set_slc(8, data_u);
	  data_hls.set_slc(0, data_v);
	  
      if(i <= 100){  	
	    std::cout << "i = " << i << ", data_hls = " << (int)data_hls << std::endl;
	  }
	  dataIn_chn.write(data_hls);		
	}
	
	std::cout << "Test2" << std::endl;
	HDRISP_IP::stream_sharpen sharpen_prmIn;
	HDRISP_IP::SharpenPrms sharpen_prmTmp;
 
	sharpen_prmTmp.ratio = isp_prms.sharpen_prms.ratio;
	//std::cout << "isp_prms.sharpen_prms.ratio = " << isp_prms.sharpen_prms.ratio << std::endl;
	//std::cout << "sharpen_prmTmp.ratio = " << sharpen_prmTmp.ratio << std::endl;

  
	std::cout << "Test2_1" << std::endl;
	sharpen_prmIn.write(sharpen_prmTmp);

  
	std::cout << "Test2_2" << std::endl;
	u_sharpen.run(dataIn_chn, widthIn, heightIn, sharpen_prmIn, dataOut_chn);
	std::cout << "Test3" << std::endl;
 
//=============================================================================================================//	
//                                     compare sharpen_algorithm (data1) and sharpen.cpp (data2)               //
//=============================================================================================================//  	  
	int err_num = 0;
	uint8_t* data1_y;
	uint8_t* data2_y;
	data1_y = (uint8_t*)frame.data.yuv_u8_i.y;
	data2_y = (uint8_t*)frame2.data.yuv_u8_i.y;
	
	for(int i = 0; i < iH; i++){
		for(int j = 0; j < iW; j++){
			
		  if((int)data1_y[i * iW + j] != (int)data2_y[i * iW + j]){
  	        //std::cout << "U: No." << (i * iW + j)  << " = " << (int)data1[i * iW + j] 
  	        //          << ", data2 = " << (int)data2[(i * iW + j) * 3 + k] << std::endl;
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
//                                     compare sharpen_hls (data_hls_out) and sharpen.cpp (data2)              //
//=============================================================================================================//  	
	int hls_err_num = 0;
	int32 data_hls_out = 0;
	uint8 data_hls_out_y = 0;
	for(int i = 0; i < iH; i++){
		for(int j = 0; j < iW; j++){
			
		  data_hls_out = dataOut_chn.read();
		  data_hls_out_y = data_hls_out.slc<8>(16);
		  if((int)data_hls_out_y != (int)data2_y[i * iW + j]){
			if(i * iW + j < 7680){
  	          std::cout << "Y: No." << (i * iW + j)  << " = " << (int)data_hls_out_y 
  	                    << ", data2 = " << (int)data2_y[i * iW + j] << std::endl;
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
	uint8_t* data;
	data = (uint8_t*)frame.data.yuv_u8_i.y;
	FILE *fptr;
    fptr = fopen("sharpen.txt","w");
	
	for(int i = 0; i < iH + 8; i++){
		for(int j = 0; j < iW + 8; j++){
			const char data_char = (char)(data[i * iW + j]); 
			if(i * iW + j < 100){
				//std::cout << (int)data_char << std::endl;
			}
			fprintf(fptr, "0x%02x", data[i * iW + j]);
			fprintf(fptr, " ");
		}
		fprintf(fptr, "\n");
	}
	fclose(fptr);
*/	   
    return 0;
}
