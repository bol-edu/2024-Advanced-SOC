//#include "../inc/unpack.h"
#include "/home/course/ee525201/final_project/ISP1/hls_c/inc/HDRISP_defs.h"
//#include "/home/course/ee525201/final_project/ISP1/hls_c/inc/unpack.h"
#include "/home/course/ee525201/final_project/ISP1/hls_c/inc/demosaic.h"
//#include "../../cmodel/inc/srcs/sources/modules/unpach.h"
#include "/home/course/ee525201/final_project/ISP1/cmodel/inc/srcs/sources/modules/unpack.h"
#include "/home/course/ee525201/final_project/ISP1/cmodel/inc/srcs/sources/modules/depwl.h"
#include "/home/course/ee525201/final_project/ISP1/cmodel/inc/srcs/sources/modules/dpc.h"
#include "/home/course/ee525201/final_project/ISP1/cmodel/inc/srcs/sources/modules/lsc.h"
#include "/home/course/ee525201/final_project/ISP1/cmodel/inc/srcs/sources/modules/blc.h"
#include "/home/course/ee525201/final_project/ISP1/cmodel/inc/srcs/sources/modules/wbgain.h"
#include "/home/course/ee525201/final_project/ISP1/cmodel/inc/srcs/sources/modules/demoasic.h"
#include "/home/course/ee525201/final_project/ISP1/cmodel/inc/srcs/sources/modules/demoasic.cpp"
//#include "/home/course/ee525201/final_project/ISP1/cmodel/inc/srcs/include/modules/modules.h"
//#include "/home/course/ee525201/final_project/ISP1/cmodel/inc/srcs/include/common/frame.h"
//#include "/home/course/ee525201/final_project/ISP1/cmodel/inc/srcs/include/common/common.h"
//#include "/home/course/ee525201/final_project/ISP1/cmodel/inc/parse.cpp"
//#include "/home/course/ee525201/final_project/ISP1/cmodel/inc/thirdparty/easybmp/EasyBMP.h"
//#include "/home/course/ee525201/final_project/ISP1/cmodel/inc/thirdparty/easylog/easylogging++.h"
//#include "/home/course/ee525201/final_project/ISP1/cmodel/inc/thirdparty/json/nlohmann/json.hpp"
#include <mc_scverify.h>
//#include "parse.h" /////////////////////////////////////////////////////////////////////////////////////

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
	
	//instance
    unpack_algorithm<iW,iH> ref_unpack_inst;
	depwl_algorithm<iW,iH> ref_depwl_inst;
	dpc_algorithm<iW, iH> ref_dpc_inst;
	lsc_algorithm<iW, iH> ref_lsc_inst;
	blc_algorithm<iW, iH> ref_blc_inst;
	wbgain_algorithm<iW, iH> ref_wbgain_inst;
	demoasic_algorithm<iW, iH> ref_demoasic_inst;
	//HDRISP_IP::unpack u_unpack;
	//HDRISP_IP::depwl u_depwl;
	//HDRISP_IP::lsc u_lsc;
	HDRISP_IP::demosaic u_demosaic;
	
	//dpc.h
	Frame frame(isp_prms.info);
    frame.ReadFileToFrame(isp_prms.raw_file, width * height * isp_prms.info.bpp / 8);
	ref_unpack_inst.MipiDataUnpack(&frame, &isp_prms);
	ref_depwl_inst.Depwl(&frame, &isp_prms);
	ref_dpc_inst.Dpc(&frame, &isp_prms);
	ref_lsc_inst.Lsc(&frame, &isp_prms);
	ref_blc_inst.Blc(&frame, &isp_prms);
	ref_wbgain_inst.WbGain(&frame, &isp_prms);
	ref_demoasic_inst.Demoasic(&frame, &isp_prms);
	//dpc.cpp
	Frame frame2(isp_prms.info);
	frame2.ReadFileToFrame(isp_prms.raw_file, width * height * isp_prms.info.bpp / 8);
	ref_unpack_inst.MipiDataUnpack(&frame2, &isp_prms);
	ref_depwl_inst.Depwl(&frame2, &isp_prms);
	ref_dpc_inst.Dpc(&frame2, &isp_prms);
	ref_lsc_inst.Lsc(&frame2, &isp_prms);
	ref_blc_inst.Blc(&frame2, &isp_prms);
	ref_wbgain_inst.WbGain(&frame2, &isp_prms);
	Demoasic(&frame2, &isp_prms);
	
	//hls_c
	Frame frame3(isp_prms.info);
	frame3.ReadFileToFrame(isp_prms.raw_file, width * height * isp_prms.info.bpp / 8);
	ref_unpack_inst.MipiDataUnpack(&frame3, &isp_prms);
	ref_depwl_inst.Depwl(&frame3, &isp_prms);
	ref_dpc_inst.Dpc(&frame3, &isp_prms);
	ref_lsc_inst.Lsc(&frame3, &isp_prms);
	ref_blc_inst.Blc(&frame3, &isp_prms);
	ref_wbgain_inst.WbGain(&frame3, &isp_prms);
	
	int32_t * dataIn_ptr = (int32_t *)frame3.data.raw_s32_i;
	int32 data_hls = 0;
	HDRISP_IP::stream_32 dataIn_chn;
	HDRISP_IP::stream_32  dataOut_chn_r;
	HDRISP_IP::stream_32  dataOut_chn_g;
	HDRISP_IP::stream_32  dataOut_chn_b;
	
	HDRISP_IP::maxWType widthIn = 768;//6080;
    HDRISP_IP::maxHType heightIn = 512;//4044;
	
	std::cout << "Test1" << std::endl;
	
	for(int i = 0; i < iW * iH; i++){
		
	  data_hls = dataIn_ptr[i];
        if(i <= 1536){  	
		  //std::cout << "i = " << i << ", data_hls = " << (int)data_hls << std::endl;
	    }
	  dataIn_chn.write(data_hls);	
	}
	std::cout << "Test2" << std::endl;
	std::cout << "Test2_1" << std::endl;
	std::cout << "Test2_2" << std::endl;
	int max_val = isp_prms.info.max_val;
	int32 cfa = (int32)((int)(isp_prms.info.cfa));
	u_demosaic.run(dataIn_chn, widthIn, heightIn, cfa, max_val, dataOut_chn_r, dataOut_chn_g, dataOut_chn_b);
	std::cout << "Test3" << std::endl;
	
	
	
	
	
	//compare dpc_algorithm (data1) and dpc.cpp (data2)
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
	
	//compare unpack_hls (data_hls_out) and unpack.cpp (data2)
	int hls_err_num = 0;
	int32 data_hls_out_r = 0;
	int32 data_hls_out_g = 0;
	int32 data_hls_out_b = 0;
	
	for(int i = 0; i < iH; i++){
		for(int j = 0; j < iW; j++){
			
		  data_hls_out_b = dataOut_chn_b.read();
		  if((int)data_hls_out_b != (int)data2[(i * iW + j) * 3 + 0]){
  	  
  	        if((i * iW + j) < 1536){
		      //std::cout << "B: No." << (i * iW + j) * 3 + 0 << " = " << (int)data_hls_out_b 
  	          //          << ", data2 = " << (int)data2[(i * iW + j) * 3 + 0] << std::endl;  
  	        }
  	        hls_err_num += 1;
		  }
		   
          data_hls_out_g = dataOut_chn_g.read();
		  if((int)data_hls_out_g != (int)data2[(i * iW + j) * 3 + 1]){
  	  
  	        if((i * iW + j) < 1536){
		      std::cout << "G: No." << (i * iW + j) * 3 + 1 << " = " << (int)data_hls_out_g 
  	                    << ", data2 = " << (int)data2[(i * iW + j) * 3 + 1] << std::endl;  
  	        }
  	        hls_err_num += 1;
		  }		   
			
		  data_hls_out_r = dataOut_chn_r.read();
		  if((int)data_hls_out_r != (int)data2[(i * iW + j) * 3 + 2]){
  	  
  	        if((i * iW + j) < 1536){
		      std::cout << "R: No." << (i * iW + j) * 3 + 2 << " = " << (int)data_hls_out_r 
  	                    << ", data2 = " << (int)data2[(i * iW + j) * 3 + 2] << std::endl;  
  	        }
  	        hls_err_num += 1;
		  }
      /*
		  if((i * iW + j) < 1536){
		    std::cout << "(r, g, b) = " << data_hls_out_r << ", " << data_hls_out_g << ", " << data_hls_out_b << std::endl;
		  }
      */
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
	//data = (uint16_t*)frame.data.raw_u16_o;
	data = (int32_t*)frame.data.raw_s32_i;
	FILE *fptr;
    fptr = fopen("Lsc.txt","w");
	
	for(int i = 0; i < iH; i++){
		for(int j = 0; j < iW; j++){
			//const char data_char = (char)(data[i * iW + j]); 
			if(i * iW + j < 100){
				//std::cout << (int)data_char << std::endl;
			}
			//fprintf(fptr, "0x%08x", data[i * iW + j]);
			fprintf(fptr, "%d", data[i * iW + j]);
			fprintf(fptr, " ");
		}
		fprintf(fptr, "\n");
	}
	fclose(fptr);
    */
    return 0;
}