#ifndef HDRISP_CCM_H_
#define HDRISP_CCM_H_

#include "/home/course/ee525201/final_project/ISP1/cmodel/inc/srcs/include/modules/modules.h"

#define MOD_NAME "ccm"


template <int Width, int Height>
class ccm_algorithm
{
public:
  ccm_algorithm(){}
  
  static int Ccm(Frame *frame, const IspPrms *isp_prm)
  {
      if ((frame == nullptr) || (isp_prm == nullptr))
      {
          LOG(ERROR) << "input prms is null";
          return -1;
      }
      int pixel_idx = 0;
  
      int32_t *bgr_in = reinterpret_cast<int32_t *>(frame->data.bgr_s32_i);
      int32_t *bgr_out = reinterpret_cast<int32_t *>(frame->data.bgr_s32_o);
  
      FOR_ITER(h, frame->info.height)
      {
          FOR_ITER(w, frame->info.width)
          {
              pixel_idx = h * frame->info.width + w;
  
              int32_t _r = bgr_in[pixel_idx * 3 + 2];
              int32_t _g = bgr_in[pixel_idx * 3 + 1];
              int32_t _b = bgr_in[pixel_idx * 3 + 0];
  
              bgr_out[pixel_idx * 3 + 2] = (int32_t)(_r * isp_prm->ccm_prms.ccm[0][0] + _g * isp_prm->ccm_prms.ccm[0][1] + _b * isp_prm->ccm_prms.ccm[0][2]);
              bgr_out[pixel_idx * 3 + 1] = (int32_t)(_r * isp_prm->ccm_prms.ccm[1][0] + _g * isp_prm->ccm_prms.ccm[1][1] + _b * isp_prm->ccm_prms.ccm[1][2]);
			  bgr_out[pixel_idx * 3 + 0] = (int32_t)(_r * isp_prm->ccm_prms.ccm[2][0] + _g * isp_prm->ccm_prms.ccm[2][1] + _b * isp_prm->ccm_prms.ccm[2][2]);
  
              ClipMinMax<int32_t>(bgr_out[pixel_idx * 3 + 0], (int32_t)isp_prm->info.max_val, 0);
              ClipMinMax<int32_t>(bgr_out[pixel_idx * 3 + 1], (int32_t)isp_prm->info.max_val, 0);
              ClipMinMax<int32_t>(bgr_out[pixel_idx * 3 + 2], (int32_t)isp_prm->info.max_val, 0);
          }
      }
  
      SwapMem<void>(frame->data.bgr_s32_i, frame->data.bgr_s32_o);
  
      return 0;
  }
  
  void RegisterCcmMod()
  {
      IspModule mod;
  
      mod.in_type = DataPtrTypes::TYPE_INT32;
      mod.out_type = DataPtrTypes::TYPE_INT32;
  
      mod.in_domain = ColorDomains::BGR;
      mod.out_domain = ColorDomains::BGR;
  
      mod.name = MOD_NAME;
      mod.run_function = Ccm;
  
      RegisterIspModule(mod);
  }
};

#endif