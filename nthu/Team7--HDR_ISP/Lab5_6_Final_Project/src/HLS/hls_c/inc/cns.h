#pragma once

#include "HDRISP_defs.h"
#include <mc_scverify.h>

//INITIALIZE_EASYLOGGINGPP

namespace HDRISP_IP
{
  class cns
  {
  private:
  public:
	cns() {}
		
	#pragma hls_design interface
    void CCS_BLOCK(run)(stream_32     &dat_in,
                        maxWType      &widthIn,
                        maxHType      &heightIn,
                        stream_32     &dat_out)
    { 
	  int64 line_buf0[maxImageWidth/2];
	  int64 line_buf1[maxImageWidth/2];
	  
	  int64 pix_rdbuf[2];
	  int64 pix_wrbuf[2];
	  int32 line0_pix, line1_pix;
	  int32 pix_dly1_line[3], pix_dly2_line[3];
	  int32 pix_window[9];
	  uint8 pix_u[9];
	  uint8 pix_v[9];
	  uint8 mid_u, mid_v;
	  int32 raw32_in = 0;
	  int32 raw32_out = 0;
      
	  bool line_buf_en = true;
	  
	  uint8 boundary_pixel = 1;
	  
	  std::cout << "heightIn = " << (int)heightIn << ", widthIn = " << (int)widthIn << std::endl;
	  
	  COL: for(maxHType i = 0; ;i = i + 1){
		#pragma hls_pipeline_init_interval 1
		ROW: for(maxWType j = 0; ;j = j + 1){
          //std::cout << "i * width + j = " << (int)(i * widthIn + j) << std::endl;
		  //std::cout << "i = " << i << ", j = " << j << std::endl;
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
		  
		  /*
		  if((i == 4) && (j == 4)){
			  std::cout << "HLS_C:bf\n"
			            
			            << "dly4[0] = " << pix_dly4_line[0] << ",\t"
						<< "dly3[0] = " << pix_dly3_line[0] << ",\t"
						<< "dly2[0] = " << pix_dly2_line[0] << ",\t"
						<< "dly1[0] = " << pix_dly1_line[0] << ",\t"
						<< "raw32_in = " << raw32_in << "\n"
			            << "dly4[1] = " << pix_dly4_line[1] << ",\t"
						<< "dly3[1] = " << pix_dly3_line[1] << ",\t"
						<< "dly2[1] = " << pix_dly2_line[1] << ",\t"
						<< "dly1[1] = " << pix_dly1_line[1] << ",\t"
						<< "line2_pix = " << line2_pix << "\n"
						<< "dly4[2] = " << pix_dly4_line[2] << "\t"
						<< "dly3[2] = " << pix_dly3_line[2] << "\t"
			            << "dly2[2] = " << pix_dly2_line[2] << "\t"
						<< "dly1[2] = " << pix_dly1_line[2] << "\t"
						<< "line4_pix = " << line4_pix << std::endl;		
		  }
		  */
		  
		  pix_window[0] = pix_dly2_line[2];
		  pix_window[1] = pix_dly1_line[2];
		  pix_window[2] = line1_pix;
		  pix_window[3] = pix_dly2_line[1];
		  pix_window[4] = pix_dly1_line[1];
		  pix_window[5] = line0_pix;
		  pix_window[6] = pix_dly2_line[0];
		  pix_window[7] = pix_dly1_line[0];
		  pix_window[8] = raw32_in;
		  
		  #pragma hls_unroll yes
		  for(uint8 k = 0; k < 9; k++){
			pix_u[k] = pix_window[k].slc<8>(8);
		  }
		  #pragma hls_unroll yes
		  for(uint8 k = 0; k < 9; k++){
			pix_v[k] = pix_window[k].slc<8>(0);
		  }
		  
		  
		  mid_u = median_filter9(pix_u);
		  //std::sort(pix_u, pix_u + 9);
		  //std::cout << "mid_u = " << mid_u << ", pix_u[center] = " << pix_u[4] << std::endl;
		  mid_v = median_filter9(pix_v);
		  raw32_out.set_slc(0,mid_v);
		  raw32_out.set_slc(8,mid_u);
		  raw32_out.set_slc(16,raw32_in.slc<16>(16));
		  
		  /*
		  if((i == 21) && (j == 21)){
			  std::cout << "HLS_C:\n"
			            << "p0 = " << (unsigned)((uint8_t)pix_window[0].slc<8>(8)) << "\t"
						<< "p1 = " << (unsigned)((uint8_t)pix_window[1].slc<8>(8)) << "\t"
						<< "p2 = " << (unsigned)((uint8_t)pix_window[2].slc<8>(8)) << "\n"
						<< "p3 = " << (unsigned)((uint8_t)pix_window[3].slc<8>(8)) << "\t"
						<< "p4 = " << (unsigned)((uint8_t)pix_window[4].slc<8>(8)) << "\t"
						<< "p5 = " << (unsigned)((uint8_t)pix_window[5].slc<8>(8)) << "\n"
						<< "p6 = " << (unsigned)((uint8_t)pix_window[6].slc<8>(8)) << "\t"
						<< "p7 = " << (unsigned)((uint8_t)pix_window[7].slc<8>(8)) << "\t"
			            << "p8 = " << (unsigned)((uint8_t)pix_window[8].slc<8>(8)) << std::endl;
		  }*/
		  
		  #pragma hls_unroll yes
		  REG: for(uint2 i = 0; i < 3; i++){
			pix_dly2_line[i] = pix_dly1_line[i]; 
		  }
		  
		  
		  
		  
		  //regiister window shift
		  //[0]: p8 = pix(i + 2, j + 2), [1]: p5 = pix(i, j + 2), [2]: p3 = pix(i - 2, j + 2)
		  pix_dly1_line[0] = raw32_in;
		  pix_dly1_line[1] = line0_pix;
		  pix_dly1_line[2] = line1_pix;
		  /*
		  if((i == 4) && (j == 4)){
			  std::cout << "HLS_C:after\n"
			            
			            << "dly4[0] = " << pix_dly4_line[0] << ",\t"
						<< "dly3[0] = " << pix_dly3_line[0] << ",\t"
						<< "dly2[0] = " << pix_dly2_line[0] << ",\t"
						<< "dly1[0] = " << pix_dly1_line[0] << ",\t"
						<< "raw32_in = " << raw32_in << "\n"
			            << "dly4[1] = " << pix_dly4_line[1] << ",\t"
						<< "dly3[1] = " << pix_dly3_line[1] << ",\t"
						<< "dly2[1] = " << pix_dly2_line[1] << ",\t"
						<< "dly1[1] = " << pix_dly1_line[1] << ",\t"
						<< "line2_pix = " << line2_pix << "\n"
						<< "dly4[2] = " << pix_dly4_line[2] << "\t"
						<< "dly3[2] = " << pix_dly3_line[2] << "\t"
			            << "dly2[2] = " << pix_dly2_line[2] << "\t"
						<< "dly1[2] = " << pix_dly1_line[2] << "\t"
						<< "line4_pix = " << line4_pix << std::endl;		
		  }
		  */
		  
		  
		  
		  if ((j < boundary_pixel) || (i < boundary_pixel)){
            //break;
			raw32_out = raw32_in;
			//std::cout << "(i, j) = (" << i << ", " << j << ")" << std::endl; 
          }else if((j >= widthIn) || (i >= heightIn)){
			raw32_out = pix_dly1_line[0];
		  }
		  
		  if((((i < boundary_pixel) && (j <= widthIn - 1) ) || ((i >= 2) && (j < boundary_pixel)) || ((i >= 2) && (j >= 2))) && (i != heightIn + boundary_pixel)){
			/*
			if(i < 5){
			  std::cout << "(i, j) = (" << i << ", " << j << "): raw32_out = " << (int)raw32_out << std::endl;
			}
			*/
			//std::cout << "raw32_out = " << (int)raw32_out << std::endl;
			dat_out.write(raw32_out);
			/*
			if((i >= 4) && (j >= (widthIn))){
			  #pragma hls_pipeline_init_interval 1
			  PAD1: for(int k = 0; k < 2; k++){
				dat_out.write(0);
              }			  
			}
			*/
		  }
		  
		  if(j == (widthIn)){
			break;
		  }
		  
		}
		if(i == (heightIn)){
			/*
			#pragma hls_pipeline_init_interval 1
			PAD2: for(int j = 0; j < widthIn * 2; j++){
				dat_out.write(0);
			}
			*/
		    break;
		}
	  }

	}
	
	uint8 median_filter9(uint8 din_yuv[9]){
		uint8 row0[3], row1[3], row2[3], max[3], mid[3], min[3], pass[3];
		//uint8* row0_ptr, row1_ptr, row2_ptr, max_ptr, mid_ptr, min_ptr, pass_ptr;
		uint8 midian = 0;
		median_filter3(din_yuv[0], din_yuv[1], din_yuv[2], row0);
		median_filter3(din_yuv[3], din_yuv[4], din_yuv[5], row1);
		median_filter3(din_yuv[6], din_yuv[7], din_yuv[8], row2);
		median_filter3(row0[0], row1[0], row2[0], max);
        median_filter3(row0[1], row1[1], row2[1], mid);
        median_filter3(row0[2], row1[2], row2[2], min);
		median_filter3(max[2], mid[1], min[0], pass);
		midian = pass[1];
		return midian;
	}
	
	void median_filter3(uint8 din0, uint8 din1, uint8 din2, uint8 b[3]){
		uint8 a[4];
		
		a[0] = (din0 > din1)? din0:din1;
		a[1] = (din0 > din1)? din1:din0;
		a[2] = (a[1] > din2)? a[1]:din2;
		a[3] = (a[1] > din2)? din2:a[1];
		b[0] = (a[0] > a[2])? a[0]:a[2];
		b[1] = (a[0] > a[2])? a[2]:a[0];
		b[2] = a[3];
	}
	
  };
}
