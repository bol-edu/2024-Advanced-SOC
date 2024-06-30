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
#include "Denoise_IP.h"
#include "EdgeDetect_Filter.h"
#include <mc_scverify.h>

namespace EdgeDetect_IP {

  #pragma hls_design top
  class EdgeDetect_Top
  {
    //instances
    Denoise_IP Denoise_inst;
    EdgeDetect_Filter EdgeDetect_Filter_inst;
    ac_channel<pixelType>   dat_noise_out;

  public:
    EdgeDetect_Top() {}
  
    //--------------------------------------------------------------------------
    // Function: run
    //   Top interface for data in/out of class. Combines vertical and
    //   horizontal derivative and magnitude/angle computation.
    #pragma hls_design interface
    void CCS_BLOCK(run)(ac_channel<pixelType>   &dat_in,
                        maxWType                &widthIn,
                        maxHType                &heightIn,
                        ac_channel<pixelType>   &dat_out,
                        uint2       &ctrl_denoise,
                        uint2       &ctrl_edgedect
                        )
    { 
      // Denoise
      Denoise_inst.run(dat_in, widthIn, heightIn, dat_noise_out, ctrl_denoise);
      // EdgeDetect
      EdgeDetect_Filter_inst.run(dat_noise_out, widthIn, heightIn, dat_out, ctrl_edgedect);
    }
  };

}

