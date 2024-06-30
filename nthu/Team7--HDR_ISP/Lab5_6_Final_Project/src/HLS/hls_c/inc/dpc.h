#pragma once

#include "HDRISP_defs.h"
#include <mc_scverify.h>

//INITIALIZE_EASYLOGGINGPP

namespace HDRISP_IP
{
  class dpc
  {
  private:
  public:
	dpc() {}
		
	#pragma hls_design interface
    void CCS_BLOCK(run)(stream_32     &dat_in,
                        maxWType      &widthIn,
                        maxHType      &heightIn,
						stream_dpc    &dpc_prms,
                        stream_32     &dat_out)
    { 
	  int64 line_buf0[maxImageWidth/2];
	  int64 line_buf1[maxImageWidth/2];
	  int64 line_buf2[maxImageWidth/2];
	  int64 line_buf3[maxImageWidth/2];
	  /*
	  int64 line_buf0[768/2];
	  int64 line_buf1[768/2];
	  int64 line_buf2[768/2];
	  int64 line_buf3[768/2];
	  */
	  int64 pix_rdbuf[4];
	  int64 pix_wrbuf[4];
	  int32 line2_pix, line4_pix;
	  int32 pix_dly1_line[3], pix_dly2_line[3], pix_dly3_line[3], pix_dly4_line[3];
	  int32 pix_window[9];
	  int32 raw32_in = 0;
	  int32 raw32_out = 0;
      int32 dv = 0;
	  int32 dh = 0;
	  int32 ddl = 0;
	  int32 ddr = 0;
	  int32 dvh_min;
	  int32 dlr_min;
	  int32 min_all;
	  bool flag[9];
	  bool flag_all;
	  int pixel_idx = 0;
      int pwl_idx = 0;
	  bool line_buf_en = true;
	  DpcPrms dpc_prm_tmp;
	  
	  if(dpc_prms.available(1)){
		dpc_prm_tmp = dpc_prms.read();  
	  }
	  int32 thres = dpc_prm_tmp.thres; 
	  //DpcMode mode = dpc_prm_tmp.mode;
	  bool mode = dpc_prm_tmp.mode;
	
	  std::cout << "heightIn = " << (int)heightIn << ", widthIn = " << (int)widthIn << std::endl;
	  
	  COL: for(maxHType i = 0; ;i = i + 1){
		#pragma hls_pipeline_init_interval 1
		ROW: for(maxWType j = 0; ;j = j + 1){
          //std::cout << "i * width + j = " << (int)(i * widthIn + j) << std::endl;
		  //std::cout << "i = " << i << ", j = " << j << std::endl;
		  if((j == widthIn) || (j == widthIn + 1)){
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
		 	  pix_rdbuf[3] = line_buf3[j/2];
		 	  pix_rdbuf[2] = line_buf2[j/2];
		 	  pix_rdbuf[1] = line_buf1[j/2];
		 	  pix_rdbuf[0] = line_buf0[j/2];
            } else { // Write line buffer caches on odd iterations of ROW loop
              line_buf3[j/2] = pix_rdbuf[2]; // copy previous line
		 	  line_buf2[j/2] = pix_rdbuf[1]; // copy previous line
		 	  line_buf1[j/2] = pix_rdbuf[0]; // copy previous line
              line_buf0[j/2] = pix_wrbuf[0]; // store current line
            }
		    // Get 8-bit data from read buffer caches, lower 8 on even iterations of COL loop
            line4_pix = ((j&1)==0) ? pix_rdbuf[3].slc<32>(0) : pix_rdbuf[3].slc<32>(32);
		    line2_pix = ((j&1)==0) ? pix_rdbuf[1].slc<32>(0) : pix_rdbuf[1].slc<32>(32);
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
		  
		  pix_window[1] = pix_dly4_line[2];
		  pix_window[2] = pix_dly2_line[2];
		  pix_window[3] = line4_pix;
		  pix_window[4] = pix_dly4_line[1];
		  pix_window[0] = pix_dly2_line[1];
		  pix_window[5] = line2_pix;
		  pix_window[6] = pix_dly4_line[0];
		  pix_window[7] = pix_dly2_line[0];
		  pix_window[8] = raw32_in;
		  
		  /*
		  if((i == 4) && (j == 4)){
			  std::cout << "HLS_C:\n"
			            << "p1 = " << pix_window[1] << "\t"
						<< "p2 = " << pix_window[2] << "\t"
						<< "p3 = " << pix_window[3] << "\n"
						<< "p4 = " << pix_window[4] << "\t"
						<< "p0 = " << pix_window[0] << "\t"
						<< "p5 = " << pix_window[5] << "\n"
						<< "p6 = " << pix_window[6] << "\t"
						<< "p7 = " << pix_window[7] << "\t"
			            << "p8 = " << pix_window[8] << std::endl;
		  }
		  */
		  #pragma hls_unroll yes
		  REG: for(uint2 i = 0; i < 3; i++){
			//[0]: p6 = pix(i + 2, j - 2), [1]: p4 = pix(i, j - 2), [2]: p1 = pix(i - 2, j - 2)
			pix_dly4_line[i] = pix_dly3_line[i];
			//not used
			pix_dly3_line[i] = pix_dly2_line[i];
			//[0]: p7 = pix(i + 2, j), [1]: p0 = pix(i, j), [2]: p2 = pix(i - 2, j)
			pix_dly2_line[i] = pix_dly1_line[i]; 
		  }
		  
		  
		  
		  
		  //regiister window shift
		  //[0]: p8 = pix(i + 2, j + 2), [1]: p5 = pix(i, j + 2), [2]: p3 = pix(i - 2, j + 2)
		  pix_dly1_line[0] = raw32_in;
		  pix_dly1_line[1] = line2_pix;
		  pix_dly1_line[2] = line4_pix;
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
		  
		  
		  
		  flag[0] = diff_flag(pix_window[1], pix_window[0], thres);
		  flag[1] = diff_flag(pix_window[2], pix_window[0], thres);
		  flag[2] = diff_flag(pix_window[3], pix_window[0], thres);
		  flag[3] = diff_flag(pix_window[4], pix_window[0], thres);
		  flag[4] = diff_flag(pix_window[5], pix_window[0], thres);
		  flag[5] = diff_flag(pix_window[6], pix_window[0], thres);
		  flag[6] = diff_flag(pix_window[7], pix_window[0], thres);
		  flag[7] = diff_flag(pix_window[8], pix_window[0], thres);
		  flag_all = flag[0] & flag[1] & flag[2] & flag[3] & flag[4] & flag[5] & flag[6] & flag[7];
		  
		  
	      if(flag_all){
	        if(mode == false){
	          raw32_out = (pix_window[2] + pix_window[4] + pix_window[5] + pix_window[7]) >> 2;  
	        }else{
	          dv = cal_gradient(pix_window[0], pix_window[2], pix_window[7]);
	          dh = cal_gradient(pix_window[0], pix_window[4], pix_window[5]);
	          ddl = cal_gradient(pix_window[0], pix_window[1], pix_window[8]);
	          ddr  = cal_gradient(pix_window[0], pix_window[3], pix_window[6]);
	          dvh_min = min(dv, dh);
	          dlr_min = min(ddl, ddr);
	          min_all = min(dvh_min, dlr_min);
	          if(min_all == dv){
	        	  raw32_out = (pix_window[2] + pix_window[7] + 1) >> 1;
	          }else if(min_all == dh){
	        	  raw32_out = (pix_window[4] + pix_window[5] + 1) >> 1;
	          }else if(min_all == ddl){
	        	  raw32_out = (pix_window[1] + pix_window[8] + 1) >> 1;
	          }else{
	        	  raw32_out = (pix_window[3] + pix_window[6] + 1) >> 1;
	          }
	        }
		  }else{
		     raw32_out = pix_window[0];//raw32_in;
			 /*
			 if((i == 4) && (j == 4)){
			   std::cout << "test find out !" << std::endl;
			 }
			 */
		  }  
		  
		  /*
		  if((i == 4) && (j == 4)){
			std::cout << "raw32_out = " << (int)raw32_out << std::endl;
		  }
		  */
		  
		  if ((j < 2) || (i < 2) || (j >= widthIn) || (i >= heightIn)) {
            //break;
			raw32_out = 0;
          }
		  
		  if((((i < 2) && (j <= widthIn - 1) ) || ((i >= 4) && (j < 2)) || ((i >= 4) && (j >= 4))) && (i != heightIn + 2)){
			/*
			if(i < 5){
			  std::cout << "(i, j) = (" << i << ", " << j << "): raw32_out = " << (int)raw32_out << std::endl;
			}
			*/
			
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
		  
		  if(j == (widthIn + 1)){
			break;
		  }
		  
		}
		if(i == (heightIn + 1)){
			#pragma hls_pipeline_init_interval 1
			PAD2: for(int j = 0; j < widthIn * 2; j++){
				dat_out.write(0);
			}
		    break;
		}
	  }

	}
	
	bool diff_flag(int32 din1, int32 din2, int32 thres){
		int32 diff_abs = (din1 > din2)? (int32)(din1 - din2): (int32)(~(din1 - din2) + 1);
		bool flag;
		if(diff_abs > thres){
			flag = true;
		}else{
			flag = false;
		}
		return flag;
	}
	
	int32 cal_gradient(int32 din1, int32 din2, int32 din3){
		int32 gradient, gradient_abs;
		gradient = 2 * din1 - din2 - din3;
		gradient_abs = (gradient > 0)? (int32)gradient: (int32)(~gradient + 1);
		
		return gradient_abs;
	}
	
	int32 min(int32 din1, int32 din2){
		int32 min_val = 0;
		if(din1 < din2){
			min_val = din1;
		}else{
			min_val = din2;
		}
		return min_val;
	}
	
	
  };
}
