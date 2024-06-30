#pragma once

#include "HDRISP_defs.h"
#include <mc_scverify.h>

//INITIALIZE_EASYLOGGINGPP

namespace HDRISP_IP
{
  class yuv2bgr
  {
  private:
  public:
	yuv2bgr() {}
		
	#pragma hls_design interface
    void CCS_BLOCK(run)(stream_32     &dat_in,
                        maxWType      &widthIn,
                        maxHType      &heightIn,
                        stream_32     &dat_out)
    { 
	  
	  uint8 pix_y;
	  uint8 pix_u;
	  uint8 pix_v;
	  
	  //int17 b_cal;
	  //int17 g_cal;
	  //int17 r_cal;
	  
	  int10 b_out;
	  int10 g_out;
	  int10 r_out;
	  
	  
	  int32 raw32_in = 0;
	  int32 raw32_out = 0;
      
	  
	  std::cout << "heightIn = " << (int)heightIn << ", widthIn = " << (int)widthIn << std::endl;
	  
	  COL: for(maxHType i = 0; ;i = i + 1){
		#pragma hls_pipeline_init_interval 1
		ROW: for(maxWType j = 0; ;j = j + 1){
          
		  if(dat_in.available(1)){
			raw32_in = dat_in.read();
		  }
		  
		  pix_y = raw32_in.slc<8>(16);
		  pix_u = raw32_in.slc<8>(8);
		  pix_v = raw32_in.slc<8>(0);
		  
		  if((i == 6) && (j == 525)){
			std::cout << "hls: (y, u, v) = (" << (int)pix_y << ", " << (int)pix_u << ", " << (int)pix_v << ")" << std::endl; 
		  }
		  
		  r_out = ((Float_Yuv)pix_y + (Float_Yuv)1.114 * ((Float_Yuv)pix_v - (Float_Yuv)128)).to_int();
		  g_out = ((Float_Yuv)pix_y - (Float_Yuv)0.395 * ((Float_Yuv)pix_u - (Float_Yuv)128) - (Float_Yuv)0.581 * ((Float_Yuv)pix_v - (Float_Yuv)128)).to_int();
		  b_out = ((Float_Yuv)pix_y + (Float_Yuv)2.032 * ((Float_Yuv)pix_u - (Float_Yuv)128)).to_int();
		  
		  /*
		  b_cal = (int17)pix_y + ((int17)570 * ((int17)pix_v - (int17)128));
		  g_cal = (int17)pix_y - ((int17)202 * ((int17)pix_u -(int17)128)) - ((int17)297 * ((int17)pix_v - (int17)128));
		  r_cal =  (int17)pix_y - ((int17)1040 * ((int17)pix_u -(int17)128));
		  
		  b_out = b_cal.slc<8>(9);
		  g_out = g_cal.slc<8>(9);
		  r_out = r_cal.slc<8>(9);
		  
		  
		  b_out = (uint8)(b_cal >> 9);
		  g_out = (uint8)(g_cal >> 9);
		  r_out = (uint8)(r_cal >> 9);
		  */
		  if((i * widthIn + j) == 254213){
			std::cout << "hls: b_out = " << (int)b_out << std::endl;
		  }
		  
		  if(b_out > 255){
			b_out = 255;
		  }else if(b_out < 0){
			b_out = 0;
		  }
		  
		  if(g_out > 255){
			g_out = 255;
		  }else if(g_out < 0){
			g_out = 0;
		  }
		  
		  if(r_out > 255){
			r_out = 255;
		  }else if(r_out < 0){
			r_out = 0;
		  }
		  
		  raw32_out.set_slc(0, b_out);
		  raw32_out.set_slc(8, g_out);
		  raw32_out.set_slc(16, r_out);
		  raw32_out.set_slc(24, raw32_in.slc<8>(24));
		  
		  if(i != heightIn){
			dat_out.write(raw32_out);  
		  }
		  
		  
		  
		  if(j == (widthIn - 1)){
			break;
		  }
		  
		}
		if(i == (heightIn - 1)){
		    break;
		}
	  }

	}
	
	
  };
}
