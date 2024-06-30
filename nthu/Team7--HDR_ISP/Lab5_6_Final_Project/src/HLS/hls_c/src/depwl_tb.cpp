//#include "../inc/unpack.h"
#include "/home/course/ee525201/final_project/ISP1/hls_c/inc/HDRISP_defs.h"
//#include "/home/course/ee525201/final_project/ISP1/hls_c/inc/unpack.h"
#include "/home/course/ee525201/final_project/ISP1/hls_c/inc/depwl.h"
//#include "../../cmodel/inc/srcs/sources/modules/unpach.h"
#include "/home/course/ee525201/final_project/ISP1/cmodel/inc/srcs/sources/modules/unpack.h"
#include "/home/course/ee525201/final_project/ISP1/cmodel/inc/srcs/sources/modules/depwl.h"
#include "/home/course/ee525201/final_project/ISP1/cmodel/inc/srcs/sources/modules/depwl.cpp"
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
	//HDRISP_IP::unpack u_unpack;
	HDRISP_IP::depwl u_depwl;
	
	//depwl.h
	Frame frame(isp_prms.info);
    frame.ReadFileToFrame(isp_prms.raw_file, width * height * isp_prms.info.bpp / 8);
	ref_unpack_inst.MipiDataUnpack(&frame, &isp_prms);
	ref_depwl_inst.Depwl(&frame, &isp_prms);
	
	//depwl.cpp
	Frame frame2(isp_prms.info);
	frame2.ReadFileToFrame(isp_prms.raw_file, width * height * isp_prms.info.bpp / 8);
	ref_unpack_inst.MipiDataUnpack(&frame2, &isp_prms);
	Depwl(&frame2, &isp_prms);
	
	//hls_c
	Frame frame3(isp_prms.info);
	frame3.ReadFileToFrame(isp_prms.raw_file, width * height * isp_prms.info.bpp / 8);
	ref_unpack_inst.MipiDataUnpack(&frame3, &isp_prms);
	
	uint16_t * dataIn_ptr = (uint16_t *)frame3.data.raw_u16_i;
	uint16 data_hls = 0;
	HDRISP_IP::stream_u16 dataIn_chn;
	HDRISP_IP::stream_32  dataOut_chn;
	
	HDRISP_IP::maxWType widthIn = 768;//6080;
    HDRISP_IP::maxHType heightIn = 512;//4044;
	
	int mode_fake = 0;
	std::cout << "Test1" << std::endl;
	for(int i = 0; i < iW * iH; i++){
		data_hls = (uint16)dataIn_ptr[i];
		if(i <= 100){
			std::cout << "i = " << i << ", data_hls = " << data_hls << std::endl;
		}
		dataIn_chn.write(data_hls);
		
	}
	std::cout << "Test2" << std::endl;
	HDRISP_IP::stream_depwl depwl_prmIn;
	HDRISP_IP::DePwlPrms depwl_prmTmp;
	depwl_prmTmp.pwl_nums = isp_prms.depwl_prm.pwl_nums;
	std::cout << "isp_prms.depwl_prm.pwl_nums = " << isp_prms.depwl_prm.pwl_nums << std::endl;
	std::cout << "depwl_prmTmp.pwl_nums = " << depwl_prmTmp.pwl_nums << std::endl;
    depwl_prmTmp.pedestal_before_pwl = isp_prms.depwl_prm.pedestal_before_pwl;
    depwl_prmTmp.pedestal = isp_prms.depwl_prm.pedestal;
	
	for (int i = 0; i < MAX_PWL_NUMS; ++i) {
	  depwl_prmTmp.x_cood[i] = isp_prms.depwl_prm.x_cood[i];
    }
	for (int i = 0; i < MAX_PWL_NUMS; ++i) {
	  depwl_prmTmp.y_cood[i] = isp_prms.depwl_prm.y_cood[i];
    }
	for (int i = 0; i < MAX_PWL_NUMS; ++i) {
	  depwl_prmTmp.slope[i] = isp_prms.depwl_prm.slope[i];
    }
	
    //depwl_prmTmp.x_cood[MAX_PWL_NUMS] = isp_prms.depwl_prm.x_cood[MAX_PWL_NUMS];
    //depwl_prmTmp.y_cood[MAX_PWL_NUMS] = isp_prms.depwl_prm.y_cood[MAX_PWL_NUMS];
    //depwl_prmTmp.slope[MAX_PWL_NUMS] = isp_prms.depwl_prm.slope[MAX_PWL_NUMS];
	std::cout << "Test2_1" << std::endl;
	depwl_prmIn.write(depwl_prmTmp);
	std::cout << "Test2_2" << std::endl;
	int max_val = isp_prms.info.max_val;
	u_depwl.run(dataIn_chn, widthIn, heightIn, max_val, depwl_prmIn, dataOut_chn);
	std::cout << "Test3" << std::endl;
	
	
	
	
	
	//compare depwl_algorithm (data1) and depwl.cpp (data2)
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
	
	//compare unpack_hls (data_hls_out) and unpack.cpp (data2)
	int hls_err_num = 0;
	int32 data_hls_out = 0;
	for(int i = 0; i < iH * iW; i++){
		data_hls_out = dataOut_chn.read();
		if((int)data_hls_out != (int)data2[i]){
			if(i <= 100){
				//std::cout << "No." << i << " = " << data_hls_out 
				//          << ", data2 = " << (int)data2[i] << std::endl;
			}
			hls_err_num += 1;
		}
	}
	
	if(hls_err_num == 0){
		std::cout << "====HLS_C is the same as Algorithm.cpp!====" << std::endl;
	}
	
	//save data
	int32_t* data;
	//data = (uint16_t*)frame.data.raw_u16_o;
	data = (int32_t*)frame.data.raw_s32_i;
	FILE *fptr;
    fptr = fopen("Depwl.txt","w");
	
	for(int i = 0; i < iH + 8; i++){
		for(int j = 0; j < iW + 8; j++){
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
	

    return 0;
}