#pragma once

#include "HDRISP_defs.h"
#include <mc_scverify.h>
#define __AC_FLOAT_ENABLE_ALPHA
namespace HDRISP_IP
{
  class rgb2yuv
  {
  private:
  public:
	rgb2yuv() {}

	#pragma hls_design interface
    void CCS_BLOCK(run)(stream_32      		&dat_in,
                        maxWType       		&widthIn,
                        maxHType       		&heightIn,
                        stream_32      		&dat_out)
    {  
    
	  int32 raw32_in[3];
	  int32 raw32_out;
	  //int32 raw32_out_dly1[3];
	  uint8 y_out;
	  uint8	u_out;
	  uint8	v_out;
	  //uint8 buf = 0;
      //RgbGammmaCurve rgbgamma_prm_tmp;
  	  //if(rgbgamma_prms.available(1)){
  	//	rgbgamma_prm_tmp = rgbgamma_prms.read();  
     
	//  }  
      //float step_coff = (float)(gamma_prm.nums - 1) / (1 << gamma_prm.in_bits);
      //float out_max = (1 << gamma_prm.out_bits) - 1;
   
      //rgbgamma_prm temp_num = (rgbgamma_prm_tmp.nums - 1);
      //std::cout << "temp_num = " << temp_num << std::endl;    
      
      //rgbgamma_prm temp_in_bit = (1 << rgbgamma_prm_tmp.in_bits);
      //std::cout << "temp_in_bit = " << temp_in_bit << std::endl;    
      
      //rgbgamma_prm step_coff = (temp_num / temp_in_bit);
      //std::cout << "step_coff = " << step_coff << std::endl;    
         
  	  //rgbgamma_prm out_max =  ((1 << rgbgamma_prm_tmp.out_bits) - 1);
      //std::cout << "out_max = " << out_max << std::endl;    
		             // auto y = static_cast<uint8_t>(0.299 * r + 0.587 * g + 0.114 * b);
              //auto u = static_cast<uint8_t>(-0.147 * r - 0.289 * g + 0.436 * b + 128);
              //auto v = static_cast<uint8_t>(0.615 * r - 0.515 * g - 0.100 * b + 128);
    
      COL: for (maxHType i = 0; ;i = i + 1){
        ROW: for(maxWType j = 0; ;j = j + 1){
		#pragma hls_pipeline_init_interval 1  
			   RGB: for(uint8 k = 0; k < 3 ; k = k + 1){
					if(dat_in.available(1)){
						raw32_in[k] = dat_in.read();  // b -> g -> r
					}
					
					if(k == 2){
						#pragma hls_unroll yes
					CAL: for(uint8 l = 0; l < 1; l++){	
 						y_out =    ((Float_YUV)(raw32_in[2]) * (Float_YUV)0.299 +     				// r 
									(Float_YUV)(raw32_in[1]) * (Float_YUV)0.587 +     				// g
									(Float_YUV)(raw32_in[0]) * (Float_YUV)0.114).to_int(); 		    // b
						//std::cout << "y_out[l] = " << (unsigned)((uint8_t)y_out[l]) << std::endl;			
						u_out =    ((Float_YUV)(raw32_in[2]) * (Float_YUV)(-0.147) +     			// r 
									(Float_YUV)(raw32_in[1]) * (Float_YUV)(-0.289) +     			// g
									(Float_YUV)(raw32_in[0]) * (Float_YUV)0.436    +   			    // b
									128).to_int(); 		
						//std::cout << "u_out[l] = " << (unsigned)((uint8_t)u_out[l]) << std::endl;			
						v_out =    ((Float_YUV)(raw32_in[2]) * (Float_YUV)(0.615)   +     			// r 
									(Float_YUV)(raw32_in[1]) * (Float_YUV)(- 0.515) +     			// g
									(Float_YUV)(raw32_in[0]) * (Float_YUV)(- 0.100) +   			// b
									128).to_int(); 		
						//std::cout << "v_out[l] = " << (unsigned)((uint8_t)v_out[l]) << std::endl;		
					}	
					raw32_out.set_slc(24,raw32_in[0].slc<8>(24));
					raw32_out.set_slc(16, y_out);
					raw32_out.set_slc(8, u_out);
					raw32_out.set_slc(0, v_out);
					dat_out.write(raw32_out);
					
					
					
					}

					
					
					
					if((i == 0) && (j == 0) && k < 2){  // initialize
						y_out = 0;
						//y_out[1] = 0;
						//y_out[2] = 0;
						u_out = 0;
						//u_out[1] = 0;
						//u_out[2] = 0;
						v_out = 0;
						//v_out[1] = 0;
						//v_out[2] = 0;
						//raw32_out_dly1[0] = 0;
						//raw32_out_dly1[1] = 0;
						//raw32_out_dly1[2] = 0;
					}
				
					//if((i * widthIn + j) * 3 + k >= 3){
					//	dat_out.write(raw32_out_dly1[k]);
					//}
					
					//#pragma hls_unroll yes
					//DLY: for(uint8 l = 0; l < 3; l++){
					//	raw32_out_dly1[l].set_slc(16, y_out[l]);
					//	raw32_out_dly1[l].set_slc(8, u_out[l]);
					//	raw32_out_dly1[l].set_slc(0, v_out[l]);
						//raw32_out_dly1[l].set_slc(8, v_out[l]);
						//raw32_out_dly1[l].set_slc(24, 0);
						
						//raw32_out.set_slc(0,raw32_in.slc<16>(0));
				//raw32_out.set_slc(16,raw32_out_y);
				//raw32_out.set_slc(24,raw32_in.slc<8>(24));
					//}
							
					if(k == 2){
						break;
					}            
                               
			   }  
			  
			if(j == (widthIn)){
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


