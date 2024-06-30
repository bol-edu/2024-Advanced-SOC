#pragma once

#include "HDRISP_defs.h"
#include <mc_scverify.h>

//INITIALIZE_EASYLOGGINGPP
#define __AC_FLOAT_ENABLE_ALPHA

namespace HDRISP_IP
{
  class demosaic
  {
  private:
  public:
	demosaic() {}
		
	#pragma hls_design interface
    void CCS_BLOCK(run)(stream_32     &dat_in,
                        maxWType      &widthIn,
                        maxHType      &heightIn,
						int32         &cfa,
						int           &max_val,
                        stream_32     &dat_out_r,
						stream_32     &dat_out_g,
						stream_32     &dat_out_b)
    { 
	  int64 line_buf0[maxImageWidth/2];
	  int64 line_buf1[maxImageWidth/2];
	  int64 pix_rdbuf[2];
	  int64 pix_wrbuf[2];
	  int32 line0_pix, line1_pix;
	  int32 pix_dly1_line[3], pix_dly2_line[3];
	  int32 pix_window[9];

	  int32 raw32_in = 0;
	  int32 raw32_out[3];
	  int32 rgb_out[3];
	  //int32 raw32_out_dly1[3];
	  bool line_buf_en = true;
	  int32 cfa_id = cfa;
	  
	  std::cout << "heightIn = " << (int)heightIn << ", widthIn = " << (int)widthIn << std::endl;
	  
	  COL: for(maxHType i = 0; ;i = i + 1){
		#pragma hls_pipeline_init_interval 1
		ROW: for(maxWType j = 0; ;j = j + 1){

		  if((j == widthIn)){
			line_buf_en = false;
		  }else{
			line_buf_en = true;
		  }
		  
          if(line_buf_en){
		    if(dat_in.available(1)){
		 	  raw32_in = dat_in.read();
		    } 		  
		    // Write data cache, write lower 32 on even iterations of ROW loop, upper 8 on odd
            if ( (j&1) == 0 ) {
              pix_wrbuf[0].set_slc(0,raw32_in);
            } else {
              pix_wrbuf[0].set_slc(32,raw32_in);
            }
		    // Read line buffers into read buffer caches on even iterations of ROW loop
            if ( (j&1) == 0 ) {
              // vertical window of pixels
		 	  pix_rdbuf[1] = line_buf1[j/2];
		 	  pix_rdbuf[0] = line_buf0[j/2];
            } else { // Write line buffer caches on odd iterations of ROW loop
		 	  line_buf1[j/2] = pix_rdbuf[0]; // copy previous line
              line_buf0[j/2] = pix_wrbuf[0]; // store current line
            }
		    // Get 8-bit data from read buffer caches, lower 8 on even iterations of COL loop
            line1_pix = ((j&1)==0) ? pix_rdbuf[1].slc<32>(0) : pix_rdbuf[1].slc<32>(32);
		    line0_pix = ((j&1)==0) ? pix_rdbuf[0].slc<32>(0) : pix_rdbuf[0].slc<32>(32);
          }
		  
		  
		  pix_window[0] = pix_dly2_line[2];
		  pix_window[1] = pix_dly1_line[2];
		  pix_window[2] = line1_pix;
		  pix_window[3] = pix_dly2_line[1];
		  pix_window[4] = pix_dly1_line[1];
		  pix_window[5] = line0_pix;
		  pix_window[6] = pix_dly2_line[0];
		  pix_window[7] = pix_dly1_line[0];
		  pix_window[8] = raw32_in;
		  
		  
		  if((i == 21) && (j == 5)){
			  std::cout << "HLS_C:\n"
			            << "p0 = " << pix_window[0] << "\t"
						<< "p1 = " << pix_window[1] << "\t"
						<< "p2 = " << pix_window[2] << "\n"
						<< "p3 = " << pix_window[3] << "\t"
						<< "p4 = " << pix_window[4] << "\t"
						<< "p5 = " << pix_window[5] << "\n"
						<< "p6 = " << pix_window[6] << "\t"
						<< "p7 = " << pix_window[7] << "\t"
			            << "p8 = " << pix_window[8] << std::endl;
		  }
		  
		  #pragma hls_unroll yes
		  REG: for(uint2 i = 0; i < 3; i++){
			pix_dly2_line[i] = pix_dly1_line[i]; 
		  }
                     
		  pix_dly1_line[0] = raw32_in;
		  pix_dly1_line[1] = line0_pix;
		  pix_dly1_line[2] = line1_pix;
		  
		  
		  switch (kPixelCfaLut[cfa_id][(j-1) % 2][(i-1) % 2]){
		  case PixelCfaTypes::R:
		    rgb_out[0] = (pix_window[0] + pix_window[2] + pix_window[6] + pix_window[8]) >> 2; //B
			rgb_out[1] = (pix_window[1] + pix_window[3] + pix_window[5] + pix_window[7]) >> 2; //G
			rgb_out[2] = pix_window[4];                                                        //R
            break;
          case PixelCfaTypes::GR:
		    rgb_out[0] = (pix_window[3] + pix_window[5]) >> 1;
			rgb_out[1] = pix_window[4];
			rgb_out[2] = (pix_window[1] + pix_window[7]) >> 1;
            break;
          case PixelCfaTypes::GB:
		    rgb_out[0] = (pix_window[1] + pix_window[7]) >> 1;
			rgb_out[1] = pix_window[4];
			rgb_out[2] = (pix_window[3] + pix_window[5]) >> 1;
            break;
          case PixelCfaTypes::B:
		    rgb_out[0] = pix_window[4];
			rgb_out[1] = (pix_window[1] + pix_window[3] + pix_window[5] + pix_window[7]) >> 2;
			rgb_out[2] = (pix_window[0] + pix_window[2] + pix_window[6] + pix_window[8]) >> 2;
            break;
          default:
		    rgb_out[0] = (pix_window[0] + pix_window[2] + pix_window[6] + pix_window[8]) >> 2;
			rgb_out[1] = (pix_window[1] + pix_window[3] + pix_window[5] + pix_window[7]) >> 2;
			rgb_out[2] = pix_window[4];
            break;
		  }
		  
		  if((i < 1) || (j < 1) || (j > widthIn - 1) || (i > heightIn - 1)){
			rgb_out[0] = raw32_in;
			rgb_out[1] = raw32_in;
			rgb_out[2] = raw32_in;
		  }
		  
		  
		  
		  #pragma hls_unroll yes
		  RGBout: for(uint8 k = 0; k < 3; k++){
			raw32_out[k] = rgb_out[k];
			
			if(raw32_out[k] > max_val){
		  	  raw32_out[k] = max_val;
		    }else if(raw32_out[k] < 0){
		  	  raw32_out[k] = 0;
		    }
		  }
		  
		  if((((i < 1) && (j <= widthIn - 1) ) || ((i >= 2) && (j < 1)) || ((i >= 2) && (j >= 2))) && (i != heightIn + 1)){
			dat_out_b.write(raw32_out[0]);
			dat_out_g.write(raw32_out[1]);
			dat_out_r.write(raw32_out[2]);
			/*
			if(i*widthIn+j < 1536){
			  std::cout << "(r, g, b) = " << raw32_out[2] << ", " << raw32_out[1] << ", " << raw32_out[0] << std::endl;
			}
			*/
		  }
		  /* 
		  #pragma hls_unroll yes
		  DLY: for(uint8 l = 0; l < 3; l++){
			raw32_out_dly1[l] = raw32_out[l];
		  }
		  */
		  if(j == (widthIn)){
			break;
		  }
		  
		}
		if(i == (heightIn)){
		  break;
		}
	  }

	}
	
  };
}
