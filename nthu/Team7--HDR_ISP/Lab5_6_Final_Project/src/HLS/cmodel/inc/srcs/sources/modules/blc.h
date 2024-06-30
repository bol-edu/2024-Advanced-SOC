#ifndef HDRISP_BLC_H_
#define HDRISP_BLC_H_

#include "/home/course/ee525201/final_project/ISP1/cmodel/inc/srcs/include/modules/modules.h"
#define MOD_NAME "blc"

template <int maxImageWidth, int maxImageHeight>
class blc_algorithm
{
public:
  // Constructor
  blc_algorithm() {}
  
  static int Blc(Frame *frame, const IspPrms *isp_prm)
  {
    if ((frame == nullptr) || (isp_prm == nullptr))
    {
        LOG(ERROR) << "input prms is null";
        return -1;
    }
    int pixel_idx = 0;
    int pwl_idx = 0;

    int32_t* raw32_in = reinterpret_cast<int32_t *>(frame->data.raw_s32_i);
    int32_t* raw32_out = reinterpret_cast<int32_t *>(frame->data.raw_s32_o);

    const DePwlPrms *pwl_prm = &(isp_prm->depwl_prm);

    FOR_ITER(ih, frame->info.height)
    {
        FOR_ITER(iw, frame->info.width)
        {
            int pixel_idx = GET_PIXEL_INDEX(iw, ih, frame->info.width);
            raw32_out[pixel_idx] = raw32_in[pixel_idx] - isp_prm->blc;
            ClipMinMax<int32_t>(raw32_out[pixel_idx], (int32_t)isp_prm->info.max_val, 0);
        }
    }
    SwapMem<void>(frame->data.raw_s32_i, frame->data.raw_s32_o);
    
    return 0;
  }

  void RegisterBlcMod()
  {
      IspModule mod;
  
      mod.in_type = DataPtrTypes::TYPE_INT32;
      mod.out_type = DataPtrTypes::TYPE_INT32;
  
      mod.in_domain = ColorDomains::RAW;
      mod.out_domain = ColorDomains::RAW;
  
      mod.name = MOD_NAME;
      mod.run_function = Blc;
  
      RegisterIspModule(mod);
  }
};  
  
 /* 
  //   Top interface for data in/out of class. 
  void blc(Frame *frame, const IspPrms *isp_prm
           //signed  int    *raw32_in,  // image data (streamed in by pixel)
           //unsigned int   ImageWidth,
           //unsigned int   ImageHeight,
           //signed  int    *raw32_out
           )  //image data output
            
  {
  
      int32_t* raw32_in = reinterpret_cast<int32_t *>(frame->data.raw_s32_i);
      int32_t* raw32_out = reinterpret_cast<int32_t *>(frame->data.raw_s32_o);
  
      int pixel_idx = 0;
      int pwl_idx = 0;
  
      for (int ih = 0; ih < frame->info.height; ih++){
      
        for (int iw = 0; iw < frame->info.width; iw++){
        
          int pixel_idx = ih * frame->info.width + iw;
          raw32_out[pixel_idx] = raw32_in[pixel_idx] - isp_prm->blc;
          if(raw32_out[pixel_idx] > (int32_t)isp_prm->info.max_val){
            raw32_out[pixel_idx] = (int32_t)isp_prm->info.max_val;
          } else if(raw32_out[pixel_idx] < 0){
            raw32_out[pixel_idx] = 0;
          }
        }
          
      }
      SwapMem<void>(frame->data.raw_s32_i, frame->data.raw_s32_o);
  }
      
  */    
      

#endif