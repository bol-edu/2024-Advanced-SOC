#pragma once

#include "HDRISP_defs.h"
#include <mc_scverify.h>

namespace HDRISP_IP
{
  class wbgain
  {
  private:
  public:
	wbgain() {}

	#pragma hls_design interface
    void CCS_BLOCK(run)(stream_32      &dat_in,
                        maxWType       &widthIn,
                        maxHType       &heightIn,
						int32		   &cfa,
						int            &max_val,
						stream_wbgain  &wbgain_prms,
                        stream_32      &dat_out)
    {  
  	  int32 raw32_in  = 0;
  	  int32 raw32_out = 0;
		
	  
	  WbGain wbgain_prm_tmp;
	  
	  if(wbgain_prms.available(1)){
		wbgain_prm_tmp = wbgain_prms.read();  
	  }
	  
	    wbgain_prm r_gain  = wbgain_prm_tmp.d65_gain[0];
		wbgain_prm gr_gain = wbgain_prm_tmp.d65_gain[1];
		wbgain_prm gb_gain = wbgain_prm_tmp.d65_gain[2];
		wbgain_prm b_gain  = wbgain_prm_tmp.d65_gain[3];

		
      COL: for (maxHType i = 0; ;i = i + 1){
        #pragma hls_pipeline_init_interval 1  
        ROW: for(maxWType j = 0; ;j = j + 1){
		
			
			if(dat_in.available(1)){
			  raw32_in = dat_in.read();
			}
			int32 cfa_id = cfa; // bayer pattern
			switch (kPixelCfaLut[cfa_id][j % 2][i % 2]){
              case PixelCfaTypes::R:
                  raw32_out= (int32_t)(raw32_in * r_gain).to_int();
                  break;
              case PixelCfaTypes::GR:
                  raw32_out = (int32_t)(raw32_in * gr_gain).to_int();
                  break;
              case PixelCfaTypes::GB:
                  raw32_out = (int32_t)(raw32_in * gb_gain).to_int();
                  break;
              case PixelCfaTypes::B:
                  raw32_out = (int32_t)(raw32_in * b_gain).to_int();
                  break;
              default:
                  break;
				  
            }	
			
			if(raw32_out > max_val){
				raw32_out = max_val;
			}else if(raw32_out < 0){
				raw32_out = 0;
			}else{
				raw32_out = raw32_out;
			}
		  
			//std::cout << "raw32_out = " << raw32_out <<std::endl;
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
