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

#include "EdgeDetect_defs.h"
#include <mc_scverify.h>


namespace EdgeDetect_IP 
{
  class Mix
  {
  public:
    Mix() {}
  
    #pragma hls_design interface
    void CCS_BLOCK(Mix,run)(ac_channel<pixelTypeRGB> &grb_in,
                        maxWType             &widthIn,
                        maxHType             &heightIn,
                        ac_channel<pixelType>   &magn,
                        ac_channel<Stream_t>  &grb_out)
    {
      pixelTypeRGB mix_out,ori_in;
      pixelType mag; // square-root return type
      Stream_t ans;
      MROW: for (maxHType y = 0; ; y++) {
        #pragma hls_pipeline_init_interval 1
        MCOL: for (maxWType x = 0; ; x++) {
          ori_in = grb_in.read();
          mag = magn.read();          
          ans.r_pixelType=ori_in.r_pixelType&mag;
          ans.g_pixelType=ori_in.g_pixelType&mag;
          ans.b_pixelType=ori_in.b_pixelType&mag;
          ans.sof=(x==0&&y==0);
          ans.eol=(x==maxWType(widthIn-1));
          grb_out.write(ans);
          if (x == maxWType(widthIn-1)) { 
            break;
          }
        }
        if (y == maxHType(heightIn-1)) {
          break;
        }
      }
    }
  };

}


