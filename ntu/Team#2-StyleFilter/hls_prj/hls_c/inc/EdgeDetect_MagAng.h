/**************************************************************************
 *                                                                        *
 *  Edge Detect Design Walkthrough for HLS                                *
 *                                                                        *
 *  Software Version: 1.0                                                 *
 *                                                                        *
 *  Release Date    : Tue Jan 14 15:40:43 PST 2020                        *
 *  Release Type    : Production Release                                  *
 *  Release Build   : 1.0.0                                               *
 *                                       abs                                 *
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
  class EdgeDetect_MagAng
  {
  public:
    EdgeDetect_MagAng() {}
  
    #pragma hls_design interface
    void CCS_BLOCK(run)(ac_channel<gradType> &dx_in,
                        ac_channel<gradType> &dy_in,
                        maxWType             &widthIn,
                        maxHType             &heightIn,
                        ac_channel<pixelType>  &magn)
    {
      gradType dx, dy;
      gradType dx_abs, dy_abs;
      //sqType dx_sq;
      //sqType dy_sq;
      //sumType sum; // fixed point integer for sqrt
      //angType at;
      pixelType sobel_out;
      //ac_fixed<16,9,false> sq_rt; // square-root return type
  
      MROW: for (maxHType y = 0; ; y++) {
        #pragma hls_pipeline_init_interval 1
        MCOL: for (maxWType x = 0; ; x++) {
          dx = dx_in.read();
          dy = dy_in.read();
          // dx_sq = dx * dx;
          // dy_sq = dy * dy;
          // sum = dx_sq + dy_sq;
          // Catapult's math library piecewise linear implementation of sqrt and atan2
          // ac_math::ac_sqrt_pwl(sum,sq_rt);
          // magn.write(sq_rt.to_uint());
          // ac_math::ac_atan2_cordic((ac_fixed<9,9>)dy, (ac_fixed<9,9>) dx, at);
          if(dx >=0)
            dx_abs = dx;
          else
            dx_abs = 0 - dx;

          if(dy >=0)
            dy_abs = dy;
          else
            dy_abs = 0 - dy;


          if ((dx_abs + dy_abs) >100)
          {
            sobel_out = 0;
          }
          else sobel_out=255;
          magn.write(sobel_out);
          // angle.write(at);
          // programmable width exit condition
          if (x == maxWType(widthIn-1)) { // cast to maxWType for RTL code coverage
            break;
          }
        }
        // programmable height exit condition
        if (y == maxHType(heightIn-1)) { // cast to maxHType for RTL code coverage
          break;
        }
      }
    }
    private:
    //template <int len>
    /*uint32 calc_crc32(uint32 crc_in, ac_int<len, false> dat_in)
    {
      const uint32 CRC_POLY = 0xEDB88320;
      uint32 crc_tmp = crc_in;

      #pragma hls_unroll yes
      for(int i=0; i<len; i++)
      {
        uint1 tmp_bit = crc_tmp[0] ^ dat_in[i];

        uint31 mask;

        #pragma hls_unroll yes
        for(int i=0; i<31; i++)
          mask[i] = tmp_bit & CRC_POLY[i];

        uint31 crc_tmp_h31 = crc_tmp.slc<31>(1);
   
        crc_tmp_h31 ^= mask;
        
        crc_tmp.set_slc(31,tmp_bit);
        crc_tmp.set_slc(0,crc_tmp_h31);
      }
      return crc_tmp;
    }
      gradType abs(gradType din)
    {
      if(din <= 0) return -1*din;
      else return din;
    }*/

  };

}


