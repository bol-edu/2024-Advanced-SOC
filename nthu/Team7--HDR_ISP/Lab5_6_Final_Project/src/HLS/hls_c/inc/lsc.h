#pragma once

#include "HDRISP_defs.h"
#include <mc_scverify.h>

//INITIALIZE_EASYLOGGINGPP
#define __AC_FLOAT_ENABLE_ALPHA

namespace HDRISP_IP
{
  class lsc
  {
  private:
  public:
	lsc() {}
		
	#pragma hls_design interface
    void CCS_BLOCK(run)(stream_32     &dat_in,
                        maxWType      &widthIn,
                        maxHType      &heightIn,
						int32         &cfa,
						int           &max_val,
						int32         &mesh_box_width,
						int32         &mesh_box_height,
						stream_lsc    &lsc_prms,
                        stream_32     &dat_out)
    { 
	  int32 pixel_idx = 0;
	  int32 raw32_in = 0;
	  int32 raw32_out = 0;
	  
	  LscPrms lsc_prm_tmp;
	  
	  if(lsc_prms.available(1)){
		lsc_prm_tmp = lsc_prms.read();  
	  }
	  
	  
	  
	  std::cout << "heightIn = " << (int)heightIn << ", widthIn = " << (int)widthIn << std::endl;
	  
	  COL: for(maxHType i = 0; ;i = i + 1){
		#pragma hls_pipeline_init_interval 1
		ROW: for(maxWType j = 0; ;j = j + 1){
          
		  pixel_idx = i * widthIn + j;
          int32 box_idx =  j / mesh_box_width;
          int32 box_idy =  i / mesh_box_height;
          FloatType x_coff = ((FloatType)(j % mesh_box_width)) / (FloatType)mesh_box_width;
          FloatType y_coff = ((FloatType)(i % mesh_box_height)) / (FloatType)mesh_box_height;
          int32 cfa_id = cfa;
          FloatType gain = 1;
		  
		  FloatType gain0, gain1, gain2, gain3;
		  
		  if(dat_in.available(1)){
			raw32_in = dat_in.read();
		  }
		  
		  
		  switch (kPixelCfaLut[cfa_id][j % 2][i % 2]){
		  case PixelCfaTypes::R:
		    gain0 = (FloatType)lsc_prm_tmp.mesh_r[box_idy][box_idx];
			gain1 = (FloatType)lsc_prm_tmp.mesh_r[box_idy][box_idx + 1];
			gain2 = (FloatType)lsc_prm_tmp.mesh_r[box_idy + 1][box_idx];
			gain3 = (FloatType)lsc_prm_tmp.mesh_r[box_idy + 1][box_idx + 1];
            break;
          case PixelCfaTypes::GR:
		    gain0 = (FloatType)lsc_prm_tmp.mesh_gr[box_idy][box_idx];
			gain1 = (FloatType)lsc_prm_tmp.mesh_gr[box_idy][box_idx + 1];
			gain2 = (FloatType)lsc_prm_tmp.mesh_gr[box_idy + 1][box_idx];
			gain3 = (FloatType)lsc_prm_tmp.mesh_gr[box_idy + 1][box_idx + 1];
            break;
          case PixelCfaTypes::GB:
		    gain0 = (FloatType)lsc_prm_tmp.mesh_gb[box_idy][box_idx];
			gain1 = (FloatType)lsc_prm_tmp.mesh_gb[box_idy][box_idx + 1];
			gain2 = (FloatType)lsc_prm_tmp.mesh_gb[box_idy + 1][box_idx];
			gain3 = (FloatType)lsc_prm_tmp.mesh_gb[box_idy + 1][box_idx + 1];
            break;
          case PixelCfaTypes::B:
		    gain0 = (FloatType)lsc_prm_tmp.mesh_b[box_idy][box_idx];
			gain1 = (FloatType)lsc_prm_tmp.mesh_b[box_idy][box_idx + 1];
			gain2 = (FloatType)lsc_prm_tmp.mesh_b[box_idy + 1][box_idx];
			gain3 = (FloatType)lsc_prm_tmp.mesh_b[box_idy + 1][box_idx + 1];
            break;
          default:
		    gain0 = (FloatType)lsc_prm_tmp.mesh_r[box_idy][box_idx];
			gain1 = (FloatType)lsc_prm_tmp.mesh_r[box_idy][box_idx + 1];
			gain2 = (FloatType)lsc_prm_tmp.mesh_r[box_idy + 1][box_idx];
			gain3 = (FloatType)lsc_prm_tmp.mesh_r[box_idy + 1][box_idx + 1];
            break;
		  }
		  
		  //std::cout << (float)x_coff << ", " << (float)y_coff << std::endl;
		  
		  gain = BilinearInterpolation(gain0, gain1, gain2, gain3, x_coff, y_coff);
		  //std::cout << (float)gain << std::endl;
		  raw32_out = ((FloatType)(raw32_in) * gain).to_int();
		  //std::cout << (int)raw32_out << std::endl;
		  if(raw32_out > max_val){
		  	raw32_out = max_val;
		  }else if(raw32_out < 0){
		  	raw32_out = 0;
		  }
		  
		  if(i != heightIn){
			dat_out.write(raw32_out);
		  }
		  
		  if(j == (widthIn - 1)){
			break;
		  }
		  
		}
		if(i == (heightIn - 1)){
		  break;
		}
	  }

	}
	
	FloatType BilinearInterpolation(FloatType gain0, FloatType gain1, FloatType gain2, FloatType gain3, FloatType x_coff, FloatType y_coff){
      FloatType result = 0;
	  if (x_coff > 1 || y_coff > 1) {
          result = 1;
      }
      
      FloatType gain01 = gain0 * x_coff + gain1 * ((FloatType)(1) - x_coff);
      FloatType gain23 = gain2 * x_coff + gain3 * ((FloatType)(1) - x_coff);
      result = gain01 * y_coff + gain23 * ((FloatType)(1) - y_coff);
	  //std::cout << gain01 << ", " << gain23 << ", " << result << std::endl;
      return result; 
    }
	
	
  };
}
