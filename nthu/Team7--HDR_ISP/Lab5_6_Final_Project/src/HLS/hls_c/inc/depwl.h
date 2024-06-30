#pragma once

#include "HDRISP_defs.h"
#include <mc_scverify.h>

//INITIALIZE_EASYLOGGINGPP

namespace HDRISP_IP
{
  class depwl
  {
  private:
  public:
	depwl() {}
		
	#pragma hls_design interface
    void CCS_BLOCK(run)(stream_u16    &dat_in,
                        maxWType      &widthIn,
                        maxHType      &heightIn,
						int           &max_val,
						stream_depwl  &pwl_prms,
                        stream_32     &dat_out)
    { 
	  uint16 raw16_in = 0;
	  int32 raw32_out = 0;
      
	  int pixel_idx = 0;
      int pwl_idx = 0;
	  
	  DePwlPrms pwl_prm_tmp;
	  
	  if(pwl_prms.available(1)){
		pwl_prm_tmp = pwl_prms.read();  
	  }
	  
	  std::cout << "heightIn = " << (int)heightIn << ", widthIn = " << (int)widthIn << std::endl;
	  
	  COL: for(maxHType i = 0; ;i = i + 1){
		#pragma hls_pipeline_init_interval 1
		ROW: for(maxWType j = 0; ;j = j + 1){
          //std::cout << "i * width + j = " << (int)(i * widthIn + j) << std::endl;
		  //std::cout << "i = " << i << ", j = " << j << std::endl;
          if(dat_in.available(1)){
			raw16_in = dat_in.read();
			
		  } 		  
		  
		  PWL: for(int idx = 1; idx < (int)pwl_prm_tmp.pwl_nums; idx++){
			  
		  	if((int)raw16_in <= (int)pwl_prm_tmp.x_cood[idx]){
		  		pwl_idx = idx;
				//std::cout << "1.pwl_idx = " << pwl_idx << std::endl;
		  		break;
		  	}
		  	pwl_idx = idx;
			//std::cout << "2.pwl_idx = " << pwl_idx << std::endl;
			if(pwl_idx == 0){
		  	  break;
			  //std::cout << "3.pwl_idx == 0" << std::endl;
			  //return -1;
		    }
		  }
		  
		  raw32_out = (raw16_in - pwl_prm_tmp.x_cood[pwl_idx - 1]) * pwl_prm_tmp.slope[pwl_idx] \
		              + pwl_prm_tmp.y_cood[pwl_idx - 1];
		    
		  if(raw32_out > max_val){
		  	raw32_out = max_val;
		  }else if(raw32_out < 0){
		  	raw32_out = 0;
		  }
		  
		  if(i != heightIn){
		    dat_out.write(raw32_out);
		  }
		  
		  if(j == (widthIn -1)){
		    break;
		  }
		  
		}
		if(i == (heightIn -1)){
		    break;
		}
	  }

	}
	
  };
}
