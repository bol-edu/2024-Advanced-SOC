//#include "../inc/unpack.h"
//#include "/home/course/ee525201/final_project/ISP1/hls_c/inc/HDRISP_defs.h"
//#include "/home/course/ee525201/final_project/ISP1/hls_c/inc/unpack.h"
//#include "../../cmodel/inc/srcs/sources/modules/unpach.h"
#include "/home/course/ee525201/final_project/ISP1/cmodel/inc/srcs/sources/modules/unpack.h"
#include "/home/course/ee525201/final_project/ISP1/cmodel/inc/srcs/sources/modules/unpack.cpp"
//#include "/home/course/ee525201/final_project/ISP1/cmodel/inc/srcs/include/modules/modules.h"
//#include "/home/course/ee525201/final_project/ISP1/cmodel/inc/srcs/include/common/frame.h"
//#include "/home/course/ee525201/final_project/ISP1/cmodel/inc/srcs/include/common/common.h"
//#include "/home/course/ee525201/final_project/ISP1/cmodel/inc/parse.cpp"
//#include "/home/course/ee525201/final_project/ISP1/cmodel/inc/thirdparty/easybmp/EasyBMP.h"
//#include "/home/course/ee525201/final_project/ISP1/cmodel/inc/thirdparty/easylog/easylogging++.h"
//#include "/home/course/ee525201/final_project/ISP1/cmodel/inc/thirdparty/json/nlohmann/json.hpp"
#include <mc_scverify.h>
//#include "parse.h" /////////////////////////////////////////////////////////////////////////////////////

//INITIALIZE_EASYLOGGINGPP

extern int ParseIspCfgFile(const std::string cfg_file_path, IspPrms &isp_prm);

CCS_MAIN(int argc, char** argv)
{	
	const int iW = 6080;//640;
	const int iH = 4044;//480;
	
	
	
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
    unpack_algorithm<iW,iH> ref_inst;
	HDRISP_IP::unpack u_unpack;
	
	
	
	//unpack.h
	Frame frame(isp_prms.info);
    frame.ReadFileToFrame(isp_prms.raw_file, width * height * isp_prms.info.bpp / 8);
	ref_inst.MipiDataUnpack(&frame, &isp_prms);
	
	//unpack.cpp
	Frame frame2(isp_prms.info);
	frame2.ReadFileToFrame(isp_prms.raw_file, width * height * isp_prms.info.bpp / 8);
	MipiDataUnpack(&frame2, &isp_prms);
	
	//hls_c
	Frame frame3(isp_prms.info);
	frame3.ReadFileToFrame(isp_prms.raw_file, width * height * isp_prms.info.bpp / 8);
	
	uint8_t * dataIn_ptr = (uint8_t *)frame3.data.raw_u8_i;
	uint8 data_hls = 0;
	HDRISP_IP::stream_u8 dataIn_chn;
	HDRISP_IP::stream_u16 dataOut_chn;
	
	HDRISP_IP::maxWType widthIn = 6080;
    HDRISP_IP::maxHType heightIn = 4044;
	
	int mode_fake = 0;
	std::cout << "Test1" << std::endl;
	for(int i = 0; i < (iW + 8) * (iH + 8) * 2; i++){
		data_hls = (uint8)dataIn_ptr[i];
		if(i <= 100){
			//std::cout << "i = " << i << ", data_hls = " << data_hls << std::endl;
		}
		dataIn_chn.write(data_hls);
		
	}
	std::cout << "Test2" << std::endl;
	u_unpack.run(mode_fake, dataIn_chn, widthIn, heightIn, dataOut_chn);
	std::cout << "Test3" << std::endl;
	
	
	
	
	
	//compare unpack_algorithm (data1) and unpack.cpp (data2)
	int err_num = 0;
	uint16_t* data1;
	uint16_t* data2;
	data1 = (uint16_t*)frame.data.raw_u16_i;
	data2 = (uint16_t*)frame2.data.raw_u16_i;
	
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
	uint16 data_hls_out = 0;
	for(int i = 0; i < (iW + 8) * (iH + 8); i++){
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
	uint16_t* data;
	//data = (uint16_t*)frame.data.raw_u16_o;
	data = (uint16_t*)frame.data.raw_u16_i;
	FILE *fptr;
    fptr = fopen("Unpack.txt","w");
	
	for(int i = 0; i < iH + 8; i++){
		for(int j = 0; j < iW + 8; j++){
			//const char data_char = (char)(data[i * iW + j]); 
			if(i * iW + j < 100){
				//std::cout << (int)data_char << std::endl;
			}
			fprintf(fptr, "0x%04x", data[i * iW + j]);
			fprintf(fptr, " ");
		}
		fprintf(fptr, "\n");
	}
	fclose(fptr);
	

    return 0;
}