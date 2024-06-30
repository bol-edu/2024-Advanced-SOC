#ifndef HDRISP_YUV2RGB_H_
#define HDRISP_YUV2RGB_H_

#include "/home/course/ee525201/final_project/ISP1/cmodel/inc/srcs/include/modules/modules.h"

#define MOD_NAME "yuv2rgb"


template <int Width, int Height>
class yuv2bgr_algorithm
{
public:
  yuv2bgr_algorithm(){}
  
  static int Yuv2Bgr(Frame *frame, const IspPrms *isp_prm)
  {
      if ((frame == nullptr) || (isp_prm == nullptr))
      {
          LOG(ERROR) << "input prms is null";
          return -1;
      }
      int pixel_idx = 0;
  
      uint8_t *bgr_o = reinterpret_cast<uint8_t *>(frame->data.bgr_u8_o);
      uint8_t *y_i = reinterpret_cast<uint8_t *>(frame->data.yuv_u8_i.y);
      uint8_t *u_i = reinterpret_cast<uint8_t *>(frame->data.yuv_u8_i.u);
      uint8_t *v_i = reinterpret_cast<uint8_t *>(frame->data.yuv_u8_i.v);
  
      FOR_ITER(ih, frame->info.height)
      {
          FOR_ITER(iw, frame->info.width)
          {
              int pixel_idx = GET_PIXEL_INDEX(iw, ih, frame->info.width);
  
              auto &b = bgr_o[3 * pixel_idx + 0];
              auto &g = bgr_o[3 * pixel_idx + 1];
              auto &r = bgr_o[3 * pixel_idx + 2];
              
			  
		      if((ih == 6) && (iw == 525)){
			    std::cout << "algorithm: (y, u, v) = (" << (int)y_i[pixel_idx] << ", " << (int)u_i[pixel_idx] << ", " << (int)v_i[pixel_idx] << ")" << std::endl; 
		      }
			  
			  
              int r_tmp = y_i[pixel_idx] + 0 + 1.114 * (v_i[pixel_idx] - 128);
              int g_tmp = y_i[pixel_idx] - 0.395 * (u_i[pixel_idx] - 128) - 0.581 * (v_i[pixel_idx] - 128);
              int b_tmp = y_i[pixel_idx] + 2.032 * (u_i[pixel_idx] - 128) + 0;
  
              ClipMinMax(r_tmp, 255, 0);
              ClipMinMax(g_tmp, 255, 0);
              ClipMinMax(b_tmp, 255, 0);
  
              r = static_cast<uint8_t>(r_tmp);
              g = static_cast<uint8_t>(g_tmp);
              b = static_cast<uint8_t>(b_tmp);
          }
      }
  
      return 0;
  }
  
  void RegisterYuv2RgbMod()
  {
      IspModule mod;
  
      mod.in_type = DataPtrTypes::TYPE_INT32;
      mod.out_type = DataPtrTypes::TYPE_INT32;
  
      mod.in_domain = ColorDomains::YUV;
      mod.out_domain = ColorDomains::BGR;
  
      mod.name = MOD_NAME;
      mod.run_function = Yuv2Bgr;
  
      RegisterIspModule(mod);
  }

};
#endif  