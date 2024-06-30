#pragma once

#include "HDRISP_defs.h"
#include <mc_scverify.h>

//INITIALIZE_EASYLOGGINGPP
#define __AC_FLOAT_ENABLE_ALPHA

namespace HDRISP_IP
{
  class ccm
  {
  private:
  public:
	ccm() {}
		
	#pragma hls_design interface
    void CCS_BLOCK(run)(stream_32     &dat_in,
                        maxWType      &widthIn,
                        maxHType      &heightIn,
						int           &max_val,
						stream_ccm    &ccm_prms,
                        stream_32     &dat_out)
    { 
	  //int32 pixel_idx = 0;
	  int32 raw32_in[3];
	  int32 raw32_out[3];
	  int32 raw32_out_dly1[3];

	  
	  CcmPrms ccm_prm_tmp;
	  
	  if(ccm_prms.available(1)){
		ccm_prm_tmp = ccm_prms.read();  
	  }
	  
	  
	  
	  std::cout << "heightIn = " << (int)heightIn << ", widthIn = " << (int)widthIn << std::endl;
	  
	  // assume input oreder is 
	  
	  COL: for(maxHType i = 0; ;i = i + 1){
		//#pragma hls_pipeline_init_interval 1
		ROW: for(maxWType j = 0; ;j = j + 1){
          #pragma hls_pipeline_init_interval 1
		  RGB: for(uint8 k = 0; k < 3; k++){
			if(dat_in.available(1)){
			  raw32_in[k] = dat_in.read(); // b => g => r
			}
			
			if(k == 2){
			  #pragma hls_unroll yes
		      CAL: for(uint8 l = 0; l < 3; l++){
                raw32_out[l] = ((Float_CCM)(raw32_in[2]) * ccm_prm_tmp.ccm[2-l][0] +      //r
                    	        (Float_CCM)(raw32_in[1]) * ccm_prm_tmp.ccm[2-l][1] +      //g
		   	  	            (Float_CCM)(raw32_in[0]) * ccm_prm_tmp.ccm[2-l][2]).to_int(); //b

		        if(raw32_out[l] > max_val){
		          raw32_out[l] = max_val;
		        }else if(raw32_out[l] < 0){
		          raw32_out[l] = 0;
		        }
		      }
			}
			
			if((i == 0) && (j == 0) && k < 2){
			  raw32_out[0] = 0;
			  raw32_out[1] = 0;
			  raw32_out[2] = 0;
			  raw32_out_dly1[0] = 0;
			  raw32_out_dly1[1] = 0;
			  raw32_out_dly1[2] = 0;
			}
			
			
			
			if((i * widthIn + j) * 3 + k >= 3){
			  /*
			  if(((i * widthIn + j) * 3 + k) == 2314){
				std::cout << "k = " << k << std::endl;
				std::cout << "out = " << raw32_out[k] << std::endl;
				std::cout << "out0 = " << raw32_out[0] << std::endl;
				std::cout << "out1 = " << raw32_out[1] << std::endl;
				std::cout << "out2 = " << raw32_out[2] << std::endl;
			  }
			  */
			  dat_out.write(raw32_out_dly1[k]);
			}
			
			#pragma hls_unroll yes
			DLY: for(uint8 l = 0; l < 3; l++){
			  raw32_out_dly1[l] = raw32_out[l];
			}
			
			
			if(k == 2){
			  break;
			}
			
		  }
		  
		  if(j == (widthIn - 1)){
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
