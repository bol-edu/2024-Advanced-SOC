#pragma once

#include "HDRISP_defs.h"
#include <mc_scverify.h>

//INITIALIZE_EASYLOGGINGPP

namespace HDRISP_IP
{
  class saturation
  {
  private:
  public:
	saturation() {}
		
	#pragma hls_design interface
    void CCS_BLOCK(run)(stream_32     &dat_in,
                        maxWType      &widthIn,
                        maxHType      &heightIn,
						stream_sat    &sat_prms,
                        stream_32     &dat_out)
    { 
	  
	  uint8 pix_u;
	  uint8 pix_v;
	  
	  int8 pix_u_tmp;
	  int8 pix_v_tmp;
	  
	  uint8 u_cal;
	  uint8 v_cal;
	  
	  int32 raw32_in = 0;
	  int32 raw32_out = 0;
      
	  Float_Sat sin_val;
	  Float_Sat cos_val;
	  
	  SaturationPrms sat_prm_tmp;
	  
	  if(sat_prms.available(1)){
		sat_prm_tmp = sat_prms.read();
	  }
	  
	  //Float_Sat angle = (((Float_Sat)3.1415926 * (Float_Sat)sat_prm_tmp.rotate_angle) / ((Float_Sat)(180*3.1415926)));
	  Float_Sat angle = (((Float_Sat)sat_prm_tmp.rotate_angle) / ((Float_Sat)(180)));
	  ac_math::ac_sin_cordic(angle, sin_val);
	  ac_math::ac_cos_cordic(angle, cos_val);
	  
	  std::cout << "heightIn = " << (int)heightIn << ", widthIn = " << (int)widthIn << std::endl;
	  
	  std::cout << "hls: sin(angle) = " << sin_val << ", cos(angle) = " << cos_val << std::endl;
	  
	  
	  COL: for(maxHType i = 0; ;i = i + 1){
		#pragma hls_pipeline_init_interval 1
		ROW: for(maxWType j = 0; ;j = j + 1){
          
		  if(dat_in.available(1)){
			raw32_in = dat_in.read();
		  }
		  
		  pix_u = raw32_in.slc<8>(8);
		  pix_v = raw32_in.slc<8>(0);
		  
		  pix_u_tmp = pix_u - 128;
		  pix_v_tmp = pix_v - 128;
		  
		  u_cal = (uint8)(((Float_Sat)pix_u_tmp * cos_val + (Float_Sat)pix_v_tmp * sin_val + (Float_Sat)128).to_int());
		  v_cal = (uint8)(((Float_Sat)pix_v_tmp * cos_val + (Float_Sat)pix_u_tmp * sin_val + (Float_Sat)128).to_int());
		  
		  /*
		  if((i == 5) && (j == 425)){
				std::cout << "hls: u_tmp = " << pix_u_tmp << ", v_tmp = " << pix_v_tmp << ", u = " << u_cal << ", v = " << v_cal << std::endl;
			  }
		  */
		  
		  if(u_cal > 255){
			u_cal = 255;
		  }else if(u_cal < 0){
			u_cal = 0;
		  }
		  
		  if(v_cal > 255){
			v_cal = 255;
		  }else if(v_cal < 0){
			v_cal = 0;
		  }
		  
		  raw32_out.set_slc(0, v_cal);
		  raw32_out.set_slc(8, u_cal);
		  raw32_out.set_slc(16, raw32_in.slc<16>(16));
		  
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
	
	
  };
}
