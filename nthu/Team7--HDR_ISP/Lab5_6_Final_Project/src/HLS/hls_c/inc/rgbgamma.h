#pragma once

#include "HDRISP_defs.h"
#include <mc_scverify.h>
#define __AC_FLOAT_ENABLE_ALPHA
namespace HDRISP_IP
{
  class rgbgamma
  {
  private:
  public:
	rgbgamma() {}

	#pragma hls_design interface
    void CCS_BLOCK(run)(stream_32      		&dat_in,
                        maxWType       		&widthIn,
                        maxHType       		&heightIn,
            			stream_rgbgamma     &rgbgamma_prms,
                        stream_32      		&dat_out)
    {  
    
  	  //int32 bgr32_in  = 0;
	  int32 raw32_in[3];
	  int32 raw32_out[3];
	  int32 raw32_out_dly1[3];
            
      RgbGammmaCurve rgbgamma_prm_tmp;
  	  if(rgbgamma_prms.available(1)){
  		rgbgamma_prm_tmp = rgbgamma_prms.read();  
     
	  }  
      //float step_coff = (float)(gamma_prm.nums - 1) / (1 << gamma_prm.in_bits);
      //float out_max = (1 << gamma_prm.out_bits) - 1;
   
      rgbgamma_prm temp_num = (rgbgamma_prm_tmp.nums - 1);
      std::cout << "temp_num = " << temp_num << std::endl;    
      
      rgbgamma_prm temp_in_bit = (1 << rgbgamma_prm_tmp.in_bits);
      std::cout << "temp_in_bit = " << temp_in_bit << std::endl;    
      
      rgbgamma_prm step_coff = (temp_num / temp_in_bit);
      std::cout << "step_coff = " << step_coff << std::endl;    
         
  	  rgbgamma_prm out_max =  ((1 << rgbgamma_prm_tmp.out_bits) - 1);
      std::cout << "out_max = " << out_max << std::endl;    
    
    
      COL: for (maxHType i = 0; ;i = i + 1){
        ROW: for(maxWType j = 0; ;j = j + 1){
		#pragma hls_pipeline_init_interval 1  
			   RGB: for(uint8 k = 0; k < 3 ; k = k + 1){
					if(dat_in.available(1)){
						raw32_in[k] = dat_in.read();  // b -> g -> r
					}
					
					if(k == 2){
						#pragma hls_unroll yes
					CAL: for(uint8 l = 0; l < 3; l++){	
						rgbgamma_prm color_f = raw32_in[l];
						rgbgamma_prm curve_id_f = (color_f * step_coff);
						int curve_id = curve_id_f.to_int();
						rgbgamma_prm curve_id_temp = curve_id_f - curve_id;	
						rgbgamma_prm scale = curve_id_temp * (rgbgamma_prm_tmp.curve[curve_id + 1] - rgbgamma_prm_tmp.curve[curve_id]) + rgbgamma_prm_tmp.curve[curve_id];            	   
						raw32_out[l] = (out_max * scale).to_int();
					}	
					//raw32_out[k] =  bgr32_out_buf.to_int();
					}
					
						if((i == 0) && (j == 0) && k < 2){  // initialize
							raw32_out[0] = 0;
							raw32_out[1] = 0;
							raw32_out[2] = 0;
							raw32_out_dly1[0] = 0;
							raw32_out_dly1[1] = 0;
							raw32_out_dly1[2] = 0;
						}
					
						if((i * widthIn + j) * 3 + k >= 3){
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
			  
			if(j == (widthIn -1)){
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
