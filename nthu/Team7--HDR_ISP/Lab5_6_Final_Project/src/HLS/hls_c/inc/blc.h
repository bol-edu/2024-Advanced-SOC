#pragma once

#include "HDRISP_defs.h"
#include <mc_scverify.h>

namespace HDRISP_IP
{
  class blc
  {
  private:
  public:
	blc() {}

	#pragma hls_design interface
    void CCS_BLOCK(run)(stream_32     &dat_in,
                        maxWType      &widthIn,
                        maxHType      &heightIn,
						int           &max_val,
						stream_blc    &blc_prms,
                        stream_32     &dat_out)
    {  
  	  int32 raw32_in  = 0;
  	  int32 raw32_out = 0;
	 	  
	  BlcPrms blc_prm_tmp;
	  
	  if(blc_prms.available(1)){
		blc_prm_tmp = blc_prms.read();  
	  }
	  
	  //std::cout << "heightIn = " << (int)heightIn << ", widthIn = " << (int)widthIn << std::endl;
	
	
		
      COL: for (maxHType i = 0; ;i = i + 1){
        #pragma hls_pipeline_init_interval 1  
        ROW: for(maxWType j = 0; ;j = j + 1){
			
			if(dat_in.available(1)){
			  raw32_in = dat_in.read();
			}
			raw32_out = raw32_in - blc_prm_tmp.blc;
			  //std::cout << "raw32_out = " << raw32_out <<std::endl;
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
