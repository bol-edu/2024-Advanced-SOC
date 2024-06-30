/**************************************************************************
 *                                                                        *
 *  Edge Detect Design Walkthrough for HLS                                *
 *                                                                        *
 *  Software Version: 1.0                                                 *
 *                                                                        *
 *  Release Date    : Tue Jan 14 15:40:43 PST 2020                        *
 *  Release Type    : Production Release                                  *
 *  Release Build   : 1.0.0                                               *
 *                                                                        *
 *  Copyright 2020, Siemens                                               *
 *                                                                        *
 **************************************************************************
 *  Licensed under the Apache License, Version 2.0 (the "License");       *
 *  you may not use this file except in compliance with the License.      *
 *  You may obtain a copy of the License at                               *
 *                                                                        *
 *      http://www.apache.org/licenses/LICENSE-2.0                        *
 *                                                                        *
 *  Unless required by applicable law or agreed to in writing, software   *
 *  distributed under the License is distributed on an "AS IS" BASIS,     *
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or       *
 *  implied.                                                              *
 *  See the License for the specific language governing permissions and   *
 *  limitations under the License.                                        *
 **************************************************************************
 *                                                                        *
 *  The most recent version of this package is available at github.       *
 *                                                                        *
 *************************************************************************/
#pragma once

#include <ac_int.h>
#include <ac_fixed.h>
#include <ac_channel.h>
#include <ac_math/ac_sqrt_pwl.h>
//#include <ac_math/ac_atan2_cordic.h>
#include <ac_math/ac_sincos_cordic.h>
//#include <ac_math/ac_cos_cordic.h>
#include "/home/course/ee525201/final_project/ISP1/cmodel/inc/srcs/include/modules/modules.h"
//#include "/home/course/ee525201/final_project/ISP1/cmodel/inc/srcs/include/common/common.h"
#define MAX_PWL_NUMS 24

//#define USE_CIRCULARBUF

namespace HDRISP_IP 
{
  //const int maxImageWidth = 1926; 
  //const int maxImageHeight = 864;
  const int maxImageWidth = 6080;//1280; 
  const int maxImageHeight = 4044;//960;   
  
  //const int kernel[3] = {1, 0, -1};
    
  // Define some bit-accurate types to use in this model
  typedef uint8                  pixelType;    // input pixel is 0-255
  typedef uint16                 pixelType2x;  // two pixels packed
  typedef uint32                 pixelType4x;  // four pixels packed
  typedef ac_int<64,false>      pixelType8x;  // four pixels packed
  typedef ac_fixed<19,19,false>  sumType;      // Result of 18-bit + 18-bit fixed pt integer for squareroot
  typedef ac_int<64,         true>   int64;
  
  typedef ac_float<25,2,8> lsc_float;
  typedef ac_fixed<32,15> FloatType;
  typedef ac_fixed<32,15> Float_CCM;
  typedef ac_fixed<32,24> Float_Sat;
  typedef ac_fixed<32,24> Float_Yuv;
  typedef ac_fixed<11,2,false>   wbgain_prm;    // 10bit   2-bit integer + 8-bit fraction  
  typedef ac_fixed<32,15,false>  rgbgamma_prm;  // 40bits  10-bit integer + 30-bit fraction
  typedef ac_fixed<32,12,true>   Float_YUV;
  typedef ac_fixed<32,9,false>   ygamma_prm;
  typedef ac_fixed<32,12,true>   contrast_prm;
  typedef ac_fixed<32,12,true>   sharpen_prm; 
  /////////// Stream Type ///////////////////
  struct Stream_t{
		bool sof;
		bool eol;
		pixelType4x pix;
  };
  
  struct DePwlPrms{
    int pwl_nums;
    bool pedestal_before_pwl;
    int pedestal;
    int x_cood[MAX_PWL_NUMS];
    int y_cood[MAX_PWL_NUMS];
    int slope[MAX_PWL_NUMS];
  };
  /*
  enum class DpcMode { 
    MEAN,
    GRADIENT
  };
  */  
  struct DpcPrms
  {
      int thres = 30;
      //DpcMode mode = DpcMode::GRADIENT;
	  bool mode = true; //Mean: false, Gradient: true
  };
  
  
  enum class PixelCfaTypes
  {
      GR,
      GB,
      R,
      B
  };
  
  static constexpr PixelCfaTypes kPixelCfaLut[kCfaNums][2][2] = {
    {
        {PixelCfaTypes::R, PixelCfaTypes::GR},
        {PixelCfaTypes::GB, PixelCfaTypes::B},
    },
    {
        {PixelCfaTypes::GR, PixelCfaTypes::R},
        {PixelCfaTypes::B, PixelCfaTypes::GB},
    },
    {
        {PixelCfaTypes::B, PixelCfaTypes::GB},
        {PixelCfaTypes::GR, PixelCfaTypes::R},
    },
    {
        {PixelCfaTypes::GB, PixelCfaTypes::B},
        {PixelCfaTypes::R, PixelCfaTypes::GR},
    }};
  
  static const int kLscMeshBoxHNums = 10;
  static const int kLscMeshBoxVNums = 9;
  static const int kLscMeshPointHNums = kLscMeshBoxHNums + 1;
  static const int kLscMeshPointVNums = kLscMeshBoxVNums + 1;

  struct LscPrms
  {
      FloatType mesh_r[kLscMeshPointVNums][kLscMeshPointHNums];
      FloatType mesh_gr[kLscMeshPointVNums][kLscMeshPointHNums];
      FloatType mesh_gb[kLscMeshPointVNums][kLscMeshPointHNums];
      FloatType mesh_b[kLscMeshPointVNums][kLscMeshPointHNums];
  
      LscPrms()
      {
          for (int idy = 0; idy < kLscMeshPointVNums; ++idy) {
              for (int idx = 0; idx < kLscMeshPointHNums; ++idx) {
                  mesh_r[idy][idx] = 1;
                  mesh_gr[idy][idx] = 1;
                  mesh_gb[idy][idx] = 1;
                  mesh_b[idy][idx] = 1;
              }
          }
      }
  };
  
  struct CcmPrms
  {
      Float_CCM ccm[3][3] = {
          {1, 0, 0},
          {0, 1, 0},
          {0, 0, 1}};
  };
  
  struct SaturationPrms
  {
    Float_Sat rotate_angle;
  };

  struct BlcPrms{
		int blc;
  };
  
  struct WbGain{
		// R G G B
		wbgain_prm d65_gain[4];
		wbgain_prm d50_gain[4];
		wbgain_prm f11_gain[4];
		wbgain_prm f12_gain[4];
  };
  
  struct RgbGammmaCurve
  {
      // 0-1
      int nums;
      int in_bits;
      int out_bits;
      rgbgamma_prm curve[MAX_GAMMA_NUMS];
  };
  
  struct YGammmaCurve
  {
      // 0-1
      int nums;
      int in_bits;
      int out_bits;
      ygamma_prm curve[MAX_GAMMA_NUMS];
  };
  
  struct ContrastPrms
  {
      contrast_prm ratio;
  };

  struct SharpenPrms
  {
      sharpen_prm ratio;
  };

  
  typedef ac_channel<uint8>  stream_u8; //input type for unpack
  typedef ac_channel<uint12>  stream_u12; //input type for ISP to represent mipi raw12
  typedef ac_channel<uint16>  stream_u16; //input type for ISP to represent mipi raw16
  typedef ac_channel<uint32>  stream_u32; //output type for ISP to represent mipi raw16 * 2
  typedef ac_channel<int32>  stream_32;
  typedef ac_channel<DePwlPrms> stream_depwl;
  typedef ac_channel<DpcPrms> stream_dpc;
  typedef ac_channel<LscPrms> stream_lsc;
  typedef ac_channel<CcmPrms> stream_ccm;
  typedef ac_channel<SaturationPrms> stream_sat;
  typedef ac_channel<BlcPrms>   		stream_blc;
  typedef ac_channel<WbGain>    		stream_wbgain;
  typedef ac_channel<RgbGammmaCurve>    stream_rgbgamma;
  typedef ac_channel<YGammmaCurve>    	stream_ygamma;
  typedef ac_channel<ContrastPrms>    	stream_contrast;
  typedef ac_channel<SharpenPrms>       stream_sharpen;
  //////////////////////////////////////////
  
  // Compute number of bits for max image size count, used internally and in testbench
  typedef ac_int<ac::nbits<maxImageWidth+1>::val,false> maxWType;
  typedef ac_int<ac::nbits<maxImageHeight+1>::val,false> maxHType;
}


