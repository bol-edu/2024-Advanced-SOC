#pragma once

#include "HDRISP_defs.h"
#include <mc_scverify.h>

//INITIALIZE_EASYLOGGINGPP

namespace HDRISP_IP
{
  class unpack
  {
  private:
  public:
	unpack() {}
		
	#pragma hls_design interface
    void CCS_BLOCK(run)(int         &mode,
						stream_u8   &dat_in,
                        maxWType    &widthIn,
                        maxHType    &heightIn,
                        stream_u16  &dat_out)
    { 
	  uint16 raw16_in = 0;
	  //uint16 raw16_out = 0;
	  
	  //uint16 raw16_out = 0;
	  uint8 raw16_in0;
	  uint8 raw16_in1;
    #pragma hls_pipeline_init_interval 2
	  RAW16:for(int i = 0;;i=i+1){
		  if(dat_in.available(2)){
			 
			  raw16_in0 = dat_in.read();
			  raw16_in1 = dat_in.read();  
			  raw16_in = ((uint16)raw16_in1 << 8) | ((uint16)raw16_in0 & 0xff);
			  /*
			  if(i <= 50){
				std::cout << "i = " << i
				        << ", raw16_in0 = " << (int)raw16_in0 
						<< ", raw16_in1 = " << (int)raw16_in1 
						<< ", raw16_in = " << (int)raw16_in << std::endl;
			  }*/
			  
			  dat_out.write(raw16_in);
			  //raw16_out = raw16_in;
		  }/*
		  if(i <= 50){
			  std::cout << "out: i = " << i
				        << ", raw16_in0 = " << raw16_in0 
						<< ", raw16_in1 = " << raw16_in1 
						<< ", raw16_in = " << raw16_in << std::endl;
		  }*/
		  //dat_out.write(raw16_in);
		  //if(i%2 == 0){
		  //dat_out.write(raw16_in);
		  //}
		      
		  if(i == (widthIn + 8) * (widthIn + 8) * 2 -1){
			  break;
		  }
	  }
	}
	
	static void UnpackRaw10ToRaw16(uint8      raw10_in,
								   maxWType   &widthIn,
                                   maxHType   &heightIn,
                                   uint16     raw16_out)
	{
		// pixel buffers store pixel history
	  uint8 raw_buf0;
	  uint8 raw_buf1;
	  uint8 raw_buf2;
	  uint8 raw_buf3;

	  uint8 raw10_0 = 0;
	  uint8 raw10_1 = 0;
	  uint8 raw10_2 = 0;
	  uint8 raw10_3 = 0;
	  uint8 raw10_4 = 0;
	  
	  uint16 raw16_0 = 0;
	  uint16 raw16_1 = 0;
	  uint16 raw16_2 = 0;
	  uint16 raw16_3 = 0;
	  
	  //uint16 raw16_out = 0;
	  uint8 count = 0;
	  
	  RAW10: for(int i = 0;;i++){
		  
		  if(count == 5){
			  count = 0;
		  }else{
			  count += 1;
		  }
		  
		  raw10_0 = raw_buf0;
		  raw10_1 = raw_buf1;
		  raw10_2 = raw_buf2;
		  raw10_3 = raw_buf3;
		  
		  if(i <= widthIn*heightIn){
			  //raw10_4 = dat_in.read();
			  raw10_4 = raw10_in;
		  }
		  
		  if(count == 5){
			  raw16_0 = ((uint16)raw10_0 << 2) | (((uint16)raw10_4 >> 6) & 0x03);
			  raw16_1 = ((uint16)raw10_1 << 2) | (((uint16)raw10_4 >> 4) & 0x03);
			  raw16_2 = ((uint16)raw10_2 << 2) | (((uint16)raw10_4 >> 2) & 0x03);
			  raw16_3 = ((uint16)raw10_3 << 2) | (((uint16)raw10_4 >> 0) & 0x03); 
		  }else{
			  raw16_0 = raw16_0;
			  raw16_1 = raw16_1;
			  raw16_2 = raw16_2;
			  raw16_3 = raw16_3;
		  }
		  
		  raw_buf0 = raw_buf1;
		  raw_buf1 = raw_buf2;
		  raw_buf2 = raw_buf3;
		  raw_buf3 = raw10_4;
		  
		  if(count == 0){
			  raw16_out = raw16_0;
		  }else if(count == 1){
			  raw16_out = raw16_1;
		  }else if(count == 3){
			  raw16_out = raw16_2;
		  }else if(count == 4){
			  raw16_out = raw16_3;
		  }
		  
		  if(i == heightIn * widthIn - 1){
			  break;
		  }  
	  }
	}
	

  };
}
