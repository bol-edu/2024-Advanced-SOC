#ifndef HDRISP_CONTRAST_H_
#define HDRISP_CONTRAST_H_

#include "/home/course/ee525201/final_project/ISP1/cmodel/inc/srcs/include/modules/modules.h"

#define MOD_NAME "contrast"


template <int Width, int Height>
class contrast_algorithm
{
public:
  contrast_algorithm(){}
  
  static int Contrast(Frame *frame, const IspPrms *isp_prm)
  {
      if ((frame == nullptr) || (isp_prm == nullptr))
      {
          LOG(ERROR) << "input prms is null";
          return -1;
      }
      int pixel_idx = 0;
      float contrast_ratio = isp_prm->contrast_prms.ratio;
  
      uint8_t *y_i = reinterpret_cast<uint8_t *>(frame->data.yuv_u8_i.y);
      uint8_t *y_o = reinterpret_cast<uint8_t *>(frame->data.yuv_u8_o.y);
  
      FOR_ITER(h, frame->info.height)
      {
          FOR_ITER(w, frame->info.width)
          {
              pixel_idx = h * frame->info.width + w;
  
              int y = y_i[pixel_idx];
              y = static_cast<int>(y + (y - 127) * contrast_ratio);
              ClipMinMax(y, 255, 0);
              y_o[pixel_idx] = y;
          }
      }
  
      SwapMem<void>(frame->data.yuv_u8_i.y, frame->data.yuv_u8_o.y);
  
      return 0;
  }
  
  void RegisterContrastMod()
  {
      IspModule mod;
  
      mod.in_type = DataPtrTypes::TYPE_INT32;
      mod.out_type = DataPtrTypes::TYPE_INT32;
  
      mod.in_domain = ColorDomains::YUV;
      mod.out_domain = ColorDomains::YUV;
  
      mod.name = MOD_NAME;
      mod.run_function = Contrast;
  
      RegisterIspModule(mod);
  }

};  
#endif