#pragma once

#include "HDRISP_defs.h"
#include <mc_scverify.h>

namespace HDRISP_IP
{
  class contrast
  {
  private:
  public:
	contrast() {}

	#pragma hls_design interface
    void CCS_BLOCK(run)(stream_32        &dat_in,
                        maxWType         &widthIn,
                        maxHType         &heightIn,
            			stream_contrast  &contrast_prms,
                        stream_32        &dat_out)
    {  
    
  	  int32 raw32_in = 0;
	  int32 raw32_out = 0;
	  uint8 raw32_in_y = 0;
	  uint8 raw32_out_y = 0;
	  //int32 yuv8_out_buf = 0;
      
      ContrastPrms contrast_prms_tmp;
  	  if(contrast_prms.available(1)){
  		contrast_prms_tmp = contrast_prms.read();  
	  }  

      contrast_prm contrast_ratio = contrast_prms_tmp.ratio;
      //std::cout << "contrast_ratio = " << contrast_ratio << std::endl;
      //std::cout << "contrast_prms_tmp.ratio = " << contrast_prms_tmp.ratio << std::endl;  

    
    
      COL: for (maxHType i = 0; ;i = i + 1){
        #pragma hls_pipeline_init_interval 1  
        ROW: for(maxWType j = 0; ;j = j + 1){
			
    			if(dat_in.available(1)){
    			  raw32_in = dat_in.read();
            //std::cout << "yuv8_in = " << yuv8_in << std::endl;    
    			}
				raw32_in_y = raw32_in.slc<8>(16);
				contrast_prm  raw32_in_y_buf =   ((contrast_prm)raw32_in_y + (contrast_prm(raw32_in_y - 127) * contrast_ratio));
    			if(raw32_in_y_buf > 255){
    				raw32_in_y_buf = 255;
    			}else if(raw32_in_y_buf < 0){
    				raw32_in_y_buf = 0;
    			}else{
    				raw32_in_y_buf = raw32_in_y_buf;
    			}
				//std::cout << "yuv8_in_buf = " << yuv8_in_buf << std::endl;
				raw32_out_y = (uint8)raw32_in_y_buf.to_uint();
				//std::cout << "raw32_out_y = " << raw32_out_y << std::endl;
				raw32_out.set_slc(0,raw32_in.slc<16>(0));
				raw32_out.set_slc(16,raw32_out_y);
				raw32_out.set_slc(24,raw32_in.slc<8>(24));


              
			

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
