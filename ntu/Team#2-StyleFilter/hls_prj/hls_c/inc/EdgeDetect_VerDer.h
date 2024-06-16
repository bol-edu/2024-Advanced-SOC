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


namespace EdgeDetect_IP {

  class EdgeDetect_VerDer
  {
  private:
  
  public:
    EdgeDetect_VerDer() {}
  
    #pragma hls_design interface
    void CCS_BLOCK(run)(ac_channel<Stream_t> &dat_in,
                        maxWType              &widthIn,
                        maxHType              &heightIn,
                        ac_channel<pixelType> &dat_out,
                        ac_channel<Stream_t> &dat_rgb,
                        ac_channel<gradType>  &dy)
    {
      // Line buffers store pixel line history - Mapped to RAM
      pixelTypeRGB2x line_buf0[maxImageWidth/2];
      pixelTypeRGB2x line_buf1[maxImageWidth/2];
      pixelTypeRGB2x rdbuf0_pix, rdbuf1_pix;
      pixelTypeRGB2x wrbuf0_pix, wrbuf1_pix;
      Stream_t pix0, pix1, pix2;
      gradType pix;
  
      // Remove loop upperbounds for RTL code coverage
      // Use bit accurate data types on loop iterator
      VROW: for (maxHType y = 0; ; y++) { // VROW has one extra iteration to ramp-up window
        #pragma hls_pipeline_init_interval 1
        VCOL: for (maxWType x = 0; ; x++) {
          if (y <= heightIn-1) {
            pix0 = dat_in.read(); // Read streaming interface
          }
          // Write data cache, write lower 8 on even iterations of COL loop, upper 8 on odd
          if ( (x&1) == 0 ) {
            wrbuf0_pix.r_pixelType.set_slc(0,pix0.r_pixelType);
            wrbuf0_pix.g_pixelType.set_slc(0,pix0.g_pixelType);
            wrbuf0_pix.b_pixelType.set_slc(0,pix0.b_pixelType);
          } else {
            wrbuf0_pix.r_pixelType.set_slc(8,pix0.r_pixelType);
            wrbuf0_pix.g_pixelType.set_slc(8,pix0.g_pixelType);
            wrbuf0_pix.b_pixelType.set_slc(8,pix0.b_pixelType);
          }
          // Read line buffers into read buffer caches on even iterations of COL loop
          if ( (x&1) == 0 ) {
            // vertical window of pixels
            rdbuf1_pix = line_buf1[x/2];
            rdbuf0_pix = line_buf0[x/2];
          } else { // Write line buffer caches on odd iterations of COL loop
            line_buf1[x/2] = rdbuf0_pix; // copy previous line
            line_buf0[x/2] = wrbuf0_pix; // store current line
          }
          // Get 8-bit data from read buffer caches, lower 8 on even iterations of COL loop
          pix2.r_pixelType = ((x&1)==0) ? rdbuf1_pix.r_pixelType.slc<8>(0) : rdbuf1_pix.r_pixelType.slc<8>(8);
          pix2.g_pixelType = ((x&1)==0) ? rdbuf1_pix.g_pixelType.slc<8>(0) : rdbuf1_pix.g_pixelType.slc<8>(8);
          pix2.b_pixelType = ((x&1)==0) ? rdbuf1_pix.b_pixelType.slc<8>(0) : rdbuf1_pix.b_pixelType.slc<8>(8);
          
          pix1.r_pixelType = ((x&1)==0) ? rdbuf0_pix.r_pixelType.slc<8>(0) : rdbuf0_pix.r_pixelType.slc<8>(8);
          pix1.g_pixelType = ((x&1)==0) ? rdbuf0_pix.g_pixelType.slc<8>(0) : rdbuf0_pix.g_pixelType.slc<8>(8);
          pix1.b_pixelType = ((x&1)==0) ? rdbuf0_pix.b_pixelType.slc<8>(0) : rdbuf0_pix.b_pixelType.slc<8>(8);
  
          // Boundary condition processing
          if (y == 1) {
            pix2 = pix1; // top boundary (replicate pix1 up to pix2)
          }
          if (y == heightIn) {
            pix0 = pix1; // bottom boundary (replicate pix1 down to pix0)
          }
  
          // Calculate derivative
          pix = ((pix2.r_pixelType*kernel[0])>>2) + ((pix1.r_pixelType*kernel[1])>>1) + ((pix0.r_pixelType*kernel[2])>>2)+
                ((pix2.g_pixelType*kernel[0])>>2) + ((pix1.g_pixelType*kernel[1])>>1) + ((pix0.g_pixelType*kernel[2])>>2)+
                ((pix2.b_pixelType*kernel[0])>>2) + ((pix1.b_pixelType*kernel[1])>>1) + ((pix0.b_pixelType*kernel[2])>>2);
  
          if (y != 0) { // Write streaming interfaces
            dat_out.write((pix1.r_pixelType>>2)+(pix1.g_pixelType>>1)+(pix1.b_pixelType>>2)); // Pass thru original data
            dy.write(pix); // derivative output
            dat_rgb.write(pix1);
          }
          // programmable width exit condition
          if (x == maxWType(widthIn-1)) { // cast to maxWType for RTL code coverage
            break;
          }
        }
        // programmable height exit condition
        if (y == heightIn) {
          break;
        }
      }
    }
  };

}


