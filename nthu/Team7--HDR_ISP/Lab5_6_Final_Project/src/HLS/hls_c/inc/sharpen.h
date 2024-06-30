#pragma once

#include "HDRISP_defs.h"
#include <mc_scverify.h>

namespace HDRISP_IP
{
  class sharpen
  {
  private:
  public:
	sharpen() {}

	#pragma hls_design interface
    void CCS_BLOCK(run)(stream_32        &dat_in,
                        maxWType         &widthIn,
                        maxHType         &heightIn,
            			stream_sharpen   &sharpen_prms,
                        stream_32        &dat_out)
    {  
    
  	  int32 raw32_in = 0;
	  int32 raw32_out = 0;
	  //uint8 raw32_in_y = 0;
	  //uint8 raw32_out_y = 0;
	  int64 line_buf0[maxImageWidth/2];
	  int64 line_buf1[maxImageWidth/2];
	  int64 line_buf2[maxImageWidth/2];
	  int64 line_buf3[maxImageWidth/2];
	  
	  int64 pix_rdbuf[4];
	  int64 pix_wrbuf[4];
	  int32 line0_pix, line1_pix, line2_pix, line3_pix;
	  int32 pix_dly1_line[5], pix_dly2_line[5], pix_dly3_line[5], pix_dly4_line[5];
	  int32 pix_window[25];
	  uint8 pix_y[25];
	  uint8 pix_y_out[25];
	  //uint8 pix_v[9];
	  //uint8 mid_u, mid_v;

	  
	  bool line_buf_en = true;   
	  
	  uint8 boundary_pixel = 2;
	  
      //uint16 yuv8_out_buf = 0;
      const int KernelSum = 273;
      const int kGaussKernel[5][5] = {
          {1, 4, 7, 4, 1},
          {4, 16, 26, 16, 4},
          {7, 26, 41, 26, 7},
          {4, 16, 26, 16, 4}, 
          {1, 4, 7, 4, 1},
      };
      
      SharpenPrms sharpen_prms_tmp;
  	  if(sharpen_prms.available(1)){
  		sharpen_prms_tmp = sharpen_prms.read();  
	  }  

      sharpen_prm sharpen_ratio = sharpen_prms_tmp.ratio;
      //std::cout << "sharpen_ratio = " << sharpen_ratio << std::endl;

    
    
      COL: for (maxHType i = 0; ;i = i + 1){
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
					//std::cout << "raw32_in = " << raw32_in.slc<8>(16) << std::endl;
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
					pix_rdbuf[3] = line_buf3[j/2];
					pix_rdbuf[2] = line_buf2[j/2];
					pix_rdbuf[1] = line_buf1[j/2];
					pix_rdbuf[0] = line_buf0[j/2];
				} else { // Write line buffer caches on odd iterations of ROW loop
					line_buf3[j/2] = pix_rdbuf[2]; // copy previous line
					line_buf2[j/2] = pix_rdbuf[1]; // store current line
					line_buf1[j/2] = pix_rdbuf[0]; // copy previous line
					line_buf0[j/2] = pix_wrbuf[0]; // store current line
				}
		    // Get 8-bit data from read buffer caches, lower 8 on even iterations of COL loop
					line3_pix = ((j&1)==0) ? pix_rdbuf[3].slc<32>(0) : pix_rdbuf[3].slc<32>(32);
					line2_pix = ((j&1)==0) ? pix_rdbuf[2].slc<32>(0) : pix_rdbuf[2].slc<32>(32);
					line1_pix = ((j&1)==0) ? pix_rdbuf[1].slc<32>(0) : pix_rdbuf[1].slc<32>(32);
					line0_pix = ((j&1)==0) ? pix_rdbuf[0].slc<32>(0) : pix_rdbuf[0].slc<32>(32);
					
			}

			
			
			// 5x5 gauss filter
			
			pix_window[0] = pix_dly4_line[4];
			pix_window[1] = pix_dly3_line[4];				
			pix_window[2] = pix_dly2_line[4];
			pix_window[3] = pix_dly1_line[4];
			pix_window[4] = line3_pix;
			pix_window[5] = pix_dly4_line[3];
			pix_window[6] = pix_dly3_line[3];			
			pix_window[7] = pix_dly2_line[3];
			pix_window[8] = pix_dly1_line[3];
			pix_window[9] = line2_pix;
			pix_window[10] = pix_dly4_line[2];
			pix_window[11] = pix_dly3_line[2];			
			pix_window[12] = pix_dly2_line[2];
			pix_window[13] = pix_dly1_line[2];
			pix_window[14] = line1_pix;
			pix_window[15] = pix_dly4_line[1];
			pix_window[16] = pix_dly3_line[1];
			pix_window[17] = pix_dly2_line[1];
			pix_window[18] = pix_dly1_line[1];
			pix_window[19] = line0_pix;
			pix_window[20] = pix_dly4_line[0];
			pix_window[21] = pix_dly3_line[0];
			pix_window[22] = pix_dly2_line[0];
			pix_window[23] = pix_dly1_line[0];
			pix_window[24] = raw32_in;
			std::cout << "pix_window[17] = " << pix_window[17].slc<8>(16) << std::endl;
			std::cout << "pix_window[18] = " << pix_window[18].slc<8>(16) << std::endl;
			std::cout << "pix_window[19] = " << pix_window[19].slc<8>(16) << std::endl;
			std::cout << "pix_window[20] = " << pix_window[20].slc<8>(16) << std::endl;
			std::cout << "pix_window[21] = " << pix_window[21].slc<8>(16) << std::endl;
			std::cout << "pix_window[22] = " << pix_window[22].slc<8>(16) << std::endl;
			std::cout << "pix_window[23] = " << pix_window[23].slc<8>(16) << std::endl;
			std::cout << "pix_window[24] = " << pix_window[24].slc<8>(16) << std::endl;
			#pragma hls_unroll yes
			for(uint8 k = 0; k < 25; k++){
				pix_y[k] = pix_window[k].slc<8>(16);
				//std::cout << "pix_y[k] = " << pix_y[k] << std::endl;    
			}
			
			pix_y_out[0] = pix_y[0] * kGaussKernel[0][0];
			//std::cout << "kGaussKernel[0][0] = " << kGaussKernel[0][0] << std::endl;
			pix_y_out[1] = pix_y[1] * kGaussKernel[0][1];
			//std::cout << "kGaussKernel[0][1] = " << kGaussKernel[0][1] << std::endl;
			pix_y_out[2] = pix_y[2] * kGaussKernel[0][2];
			pix_y_out[3] = pix_y[3] * kGaussKernel[0][3];
			pix_y_out[4] = pix_y[4] * kGaussKernel[0][4];
			pix_y_out[5] = pix_y[5] * kGaussKernel[1][0];
			pix_y_out[6] = pix_y[6] * kGaussKernel[1][1];
			pix_y_out[7] = pix_y[7] * kGaussKernel[1][2];
			pix_y_out[8] = pix_y[8] * kGaussKernel[1][3];
			pix_y_out[9] = pix_y[9] * kGaussKernel[1][4];
			pix_y_out[10] = pix_y[10] * kGaussKernel[2][0];
			pix_y_out[11] = pix_y[11] * kGaussKernel[2][1];
			pix_y_out[12] = pix_y[12] * kGaussKernel[2][2];
			pix_y_out[13] = pix_y[13] * kGaussKernel[2][3];
			pix_y_out[14] = pix_y[14] * kGaussKernel[2][4];
			pix_y_out[15] = pix_y[15] * kGaussKernel[3][0];
			pix_y_out[16] = pix_y[16] * kGaussKernel[3][1];
			pix_y_out[17] = pix_y[17] * kGaussKernel[3][2];
			pix_y_out[18] = pix_y[18] * kGaussKernel[3][3];
			pix_y_out[19] = pix_y[19] * kGaussKernel[3][4];
			pix_y_out[20] = pix_y[20] * kGaussKernel[4][0];
			pix_y_out[21] = pix_y[21] * kGaussKernel[4][1];
			pix_y_out[22] = pix_y[22] * kGaussKernel[4][2];
			pix_y_out[23] = pix_y[23] * kGaussKernel[4][3];
			pix_y_out[24] = pix_y[24] * kGaussKernel[4][4];
			//std::cout << "kGaussKernel[4][4] = " << kGaussKernel[4][4] << std::endl;
			//sum
			int pix_y_out_sum = ((pix_y_out[0] + pix_y_out[1] + pix_y_out[2] + pix_y_out[3] + pix_y_out[4] + 
							pix_y_out[5] + pix_y_out[6] + pix_y_out[7] + pix_y_out[8] + pix_y_out[9] + 
							pix_y_out[10]+ pix_y_out[11]+ pix_y_out[12]+ pix_y_out[13]+ pix_y_out[14]+ 
							pix_y_out[15]+ pix_y_out[16]+ pix_y_out[17]+ pix_y_out[18]+ pix_y_out[19]+ 
							pix_y_out[20]+ pix_y_out[21]+ pix_y_out[22]+ pix_y_out[23]+ pix_y_out[24]) / KernelSum);
			//std::cout << "pix_y_out_sum = " << pix_y_out_sum << std::endl;
			sharpen_prm tmp_pix_y_out = ((pix_y[24] - (pix_y_out_sum * sharpen_ratio)) / (1 - sharpen_ratio));
			//mid_y = median_filter9(pix_y);
			//std::sort(pix_u, pix_u + 9);
			//std::cout << "mid_u = " << mid_u << ", pix_u[center] = " << pix_u[4] << std::endl;
			//mid_v = median_filter9(pix_v);
			if(tmp_pix_y_out > 255){
    			tmp_pix_y_out = 255;
    		}else if(tmp_pix_y_out < 0){
    			tmp_pix_y_out = 0;
    		}else{
    			tmp_pix_y_out = tmp_pix_y_out;
    		}
			
			uint8 raw32_out_y = tmp_pix_y_out.to_uint();
			
			raw32_out.set_slc(0,raw32_in.slc<16>(0));
			raw32_out.set_slc(16,raw32_out_y);
			raw32_out.set_slc(24,raw32_in.slc<8>(24));
			
			
			
			
			// compute algo.
			#pragma hls_unroll yes
			REG: for(uint8 i = 0; i < 5; i++){
				pix_dly2_line[i] = pix_dly1_line[i]; 
				pix_dly3_line[i] = pix_dly2_line[i]; 
				pix_dly4_line[i] = pix_dly3_line[i]; 
			}
			
			pix_dly1_line[0] = raw32_in;
			pix_dly1_line[1] = line0_pix;
			pix_dly1_line[2] = line1_pix;
			pix_dly1_line[3] = line2_pix;
			pix_dly1_line[4] = line3_pix;
			
			
			
			
			if ((j < boundary_pixel) || (i < boundary_pixel)){
            //break;
				raw32_out = raw32_in;
			//std::cout << "(i, j) = (" << i << ", " << j << ")" << std::endl; 
			}else if((j >= widthIn) || (i >= heightIn)){
				raw32_out = pix_dly1_line[0];
			}
			
			
			if((((i < boundary_pixel) && (j <= widthIn - 1) ) || ((i >= 2) && (j < boundary_pixel)) || ((i >= 2) && (j >= 2))) && (i != heightIn + boundary_pixel)){
				dat_out.write(raw32_out);
			}
			
			
			
			
			/*
    		if(dat_in.available(1)){
				raw32_in = dat_in.read();
            //std::cout << "yuv8_in = " << yuv8_in << std::endl;    
    		}
			
			
			raw32_in_y = raw32_in.slc<8>(16); 
           
            if ((j < 2) || (i < 2) || (j > (widthIn - 3)) || (i > (heightIn - 3))){
				raw32_out.set_slc(0,raw32_in.slc<16>(0));
				raw32_out.set_slc(16,raw32_in_y);
				raw32_out.set_slc(24,raw32_in.slc<8>(24));  
				std::cout << "raw32_out = " << raw32_out << std::endl;    
				continue;
            }
  
            //int raw32_out_y = 0;
  
			CAL_COL: for (int kh = i - 2, gauss_idy = 0; kh <= i + 2; ++kh, ++gauss_idy){
				
                CAL_ROW:for (int kw = j - 2, gauss_idx = 0; kw <= j + 2; ++kw, ++gauss_idx){ // #define GET_PIXEL_INDEX(iw, ih, width) ((ih) * (width) + (iw))
                      
				  raw32_out_y += (raw32_in_y[(kh * widthIn) + kw] * kGaussKernel[gauss_idy][gauss_idx]);
                }
            }
			
			
            sharpen_prm raw32_out_y_div = raw32_out_y / KernelSum;
  
            sharpen_prm raw32_out_y_buf = ((raw32_in_y - sharpen_ratio * raw32_out_y_div) / (1 - sharpen_ratio)).to_int();
              
            if(raw32_out_y_buf > 255){
    			raw32_out_y_buf = 255;
    		}else if(raw32_out_y_buf < 0){
    			raw32_out_y_buf = 0;
    		}else{
    			raw32_out_y_buf = raw32_out_y_buf;
    		}
            
			
			

			uint8 raw32_out_y = raw32_out_y_buf.to_int();
			raw32_out.set_slc(0,raw32_in.slc<16>(0));
			raw32_out.set_slc(16,raw32_out_y);
			raw32_out.set_slc(24,raw32_in.slc<8>(24));  			
              
			if(i != heightIn){
				dat_out.write(raw32_out);
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
	
	
	
	
	/*
	void gauss_filter5(uint8 din0, uint8 din1, uint8 din2, uint8 din3, uint8 din4, uint8 din5, uint8 b[5]){
		uint8 a[6];
		
		a[0] = din0 * kGaussKernel[0][0];
		a[1] = din1 * kGaussKernel[0][1];
		a[2] = din2 * kGaussKernel[0][2];
		a[3] = din3 * kGaussKernel[0][3];
		a[4] = din4 * kGaussKernel[0][4];

		
		
		a[1] = (din0 > din1)? din1:din0;
		a[2] = (a[1] > din2)? a[1]:din2;
		a[3] = (a[1] > din2)? din2:a[1];
		b[0] = (a[0] > a[2])? a[0]:a[2];
		b[1] = (a[0] > a[2])? a[2]:a[0];
		b[2] = a[3];
	}
	*/
	
  };
}
