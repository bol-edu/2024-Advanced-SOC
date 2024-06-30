#ifndef HDRISP_SATURATION_H_
#define HDRISP_SATURATION_H_

#include "/home/course/ee525201/final_project/ISP1/cmodel/inc/srcs/include/modules/modules.h"

#define MOD_NAME "saturation"


template <int Width, int Height>
class saturation_algorithm
{
public:
  saturation_algorithm(){}
  
  static int Saturation(Frame *frame, const IspPrms *isp_prm)
  {
      if ((frame == nullptr) || (isp_prm == nullptr))
      {
          LOG(ERROR) << "input prms is null";
          return -1;
      }
      int pixel_idx = 0;
  
      uint8_t *u_i = reinterpret_cast<uint8_t *>(frame->data.yuv_u8_i.u);
      uint8_t *v_i = reinterpret_cast<uint8_t *>(frame->data.yuv_u8_i.v);
  
      uint8_t *u_o = reinterpret_cast<uint8_t *>(frame->data.yuv_u8_o.u);
      uint8_t *v_o = reinterpret_cast<uint8_t *>(frame->data.yuv_u8_o.v);
  
      float angle = 3.1415926f * isp_prm->sat_prms.rotate_angle / 180.0f;
      float sin_val = sin(angle);
      float cos_val = cos(angle);
      
	  //std::cout << "algorithm: sin(angle) = " << sin_val << ", cos(angle) = " << cos_val << std::endl;
	  
      FOR_ITER(ih, frame->info.height)
      {
          FOR_ITER(iw, frame->info.width)
          {
              int pixel_idx = GET_PIXEL_INDEX(iw, ih, frame->info.width);
  
              int u_tmp = u_i[pixel_idx] - 128;
              int v_tmp = v_i[pixel_idx] - 128;
  
              int u = static_cast<uint8_t>(u_tmp * cos_val + v_tmp * sin_val + 128);
              int v = static_cast<uint8_t>(v_tmp * cos_val + u_tmp * sin_val + 128);
              
			  /*
			  if((ih == 5) && (iw == 425)){
				std::cout << "algorithm: u_tmp = " << u_tmp << ", v_tmp = " << v_tmp << ", u = " << u << ", v = " << v << std::endl;
			  }
			  */
			  
              ClipMinMax(u, 255, 0);
              ClipMinMax(v, 255, 0);
  
              u_o[pixel_idx] = u;
              v_o[pixel_idx] = v;
          }
      }
  
      SwapMem<void>(frame->data.yuv_u8_o.u, frame->data.yuv_u8_i.u);
      SwapMem<void>(frame->data.yuv_u8_o.v, frame->data.yuv_u8_i.v);
  
      return 0;
  }
  
  void RegisterSaturationMod()
  {
      IspModule mod;
  
      mod.in_type = DataPtrTypes::TYPE_INT32;
      mod.out_type = DataPtrTypes::TYPE_INT32;
  
      mod.in_domain = ColorDomains::YUV;
      mod.out_domain = ColorDomains::YUV;
  
      mod.name = MOD_NAME;
      mod.run_function = Saturation;
  
      RegisterIspModule(mod);
  }
  
};  
#endif