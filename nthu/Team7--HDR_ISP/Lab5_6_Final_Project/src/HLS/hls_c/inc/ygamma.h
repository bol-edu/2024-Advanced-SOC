#pragma once

#include "HDRISP_defs.h"
#include <mc_scverify.h>

namespace HDRISP_IP
{
  class ygamma
  {
  private:
  public:
	ygamma() {}

	#pragma hls_design interface
    void CCS_BLOCK(run)(stream_32      &dat_in,
                        maxWType       &widthIn,
                        maxHType       &heightIn,
            			stream_ygamma  &ygamma_prms,
                        stream_32      &dat_out)
    {  
    
	
	  int32 raw32_in = 0;
	  int32 raw32_out = 0;
	  uint8 raw32_in_y = 0;
	  uint8 raw32_out_y = 0;
	  
  	  //uint8 yuv8_in  = 0;
  	  //uint8 yuv8_out = 0;
      //fixed   yuv8_out_buf;
      
      YGammmaCurve ygamma_prm_tmp;
  	  if(ygamma_prms.available(1)){
  		ygamma_prm_tmp = ygamma_prms.read();  
	  }  
    //float step_coff = (float)(gamma_prm.nums - 1) / (1 << gamma_prm.in_bits);
    //float out_max = (1 << gamma_prm.out_bits) - 1;		  
		//float  step_coff =  ((ygamma_prm_tmp.nums - 1) /   (1 << ygamma_prm_tmp.in_bits));
   
      ygamma_prm temp_num = (ygamma_prm_tmp.nums - 1);
      std::cout << "temp_num = " << temp_num << std::endl;    
      
      ygamma_prm temp_in_bit = (1 << ygamma_prm_tmp.in_bits);
      std::cout << "temp_in_bit = " << temp_in_bit << std::endl;    
      
      ygamma_prm step_coff = (temp_num / temp_in_bit);
      std::cout << "step_coff = " << step_coff << std::endl;    
         
  	  ygamma_prm out_max =  ((1 << ygamma_prm_tmp.out_bits) - 1);
      std::cout << "out_max = " << out_max << std::endl;    
    
    
      COL: for (maxHType i = 0; ;i = i + 1){
        #pragma hls_pipeline_init_interval 1  
        ROW: for(maxWType j = 0; ;j = j + 1){
			
			if(dat_in.available(1)){
			  raw32_in = dat_in.read();
			}
			
			raw32_in_y = raw32_in.slc<8>(16);
			ygamma_prm raw32_in_y_f = raw32_in_y;
        //std::cout << "yuv8_in_f = " << yuv8_in_f << std::endl;    
        
			ygamma_prm curve_id_f = (raw32_in_y_f * step_coff);
			  //std::cout << "curve_id_f = " << curve_id_f << std::endl;
         
			int curve_id = curve_id_f.to_int();
        //std::cout << "curve_id = " << curve_id << std::endl; 
        
			ygamma_prm curve_id_temp = curve_id_f - curve_id;
        //std::cout << "curve_id_temp = " << curve_id_temp << std::endl;
                    
			ygamma_prm scale = curve_id_temp * (ygamma_prm_tmp.curve[curve_id + 1] - ygamma_prm_tmp.curve[curve_id]) + ygamma_prm_tmp.curve[curve_id];            
        //std::cout << "scale = " << scale << std::endl;            
                    
			  //ygamma_prm  cuvre_id_fixed_1 = cuvre_id_fixed;
			  //uint8 curve_id = (cuvre_id_fixed_1).to_int(); 
			  //uint8 curve_id = static_cast<uint8_t>(std::round(curve_id_f));
			  //float curve_id_1 = (float) curve_id_f;
        //std::cout << "curve_id_1 = " << curve_id_1 << std::endl;
			  // scale to 0~1
			  //float scale = float((curve_id_f - curve_id_1) * (ygamma_prm_tmp.curve[curve_id + 1] - ygamma_prm_tmp.curve[curve_id]) + ygamma_prm_tmp.curve[curve_id]);
        //std::cout << "scale = " << scale << std::endl;
			  // get scale value
			ygamma_prm raw32_out_y_buf = (out_max * scale);
			raw32_out_y = raw32_out_y_buf.to_int();
			//float yuv8_out_buf = out_max * scale;
			  
			//yuv8_out = yuv8_out_buf.to_int();
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
