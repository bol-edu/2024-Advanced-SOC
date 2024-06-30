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

  class Denoise_IP
  {
  private:
  
  public:
    Denoise_IP() {}
  
    #pragma hls_design interface
    void CCS_BLOCK(run)(ac_channel<pixelType>   &dat_in,
                        maxWType                &widthIn,
                        maxHType                &heightIn,
                        ac_channel<pixelType>   &dat_out,
                        uint2                   &ctrl_signal  //unuse
                        )
    {
      // Line buffers store pixel line history - Mapped to RAM
      pixelType2x line_buf0[maxImageWidth/2];
      pixelType2x line_buf1[maxImageWidth/2];
      pixelType2x rdbuf0_pix, rdbuf1_pix;
      pixelType2x wrbuf0_pix, wrbuf1_pix;
      
      // for Medium Filter 
      uint4 i, j, max_i;  // 0-15
      float_pixelType_result max_val, pix_result, pix_multi_float;
      pixelType pix_result_sat;

      // buffering  
      pixelType pix[9];
      pixelType tmp_pix[9];
      pixelType uint_pix[5];
      
      // Remove loop upperbounds for RTL code coverage
      // Use bit accurate data types on loop iterator
      
      VROW: for (maxHType y = 0; ; y++) { // VROW has one extra iteration to ramp-up window
        #pragma hls_pipeline_init_interval 1
        VCOL: for (maxWType x = 0; ; x++) {
          /*
                            pix[6]  pix[3]    pix[0] <= read buffer 1
            write buffer 1  (pix[7] pix[4])   pix[1] <= read buffer 0
            write buffer 0  (pix[8] pix[5])   pix[2] <= dat_in
          */

          // Read Pixel // For uint_pix[0]
          if (x == 0 || x == 1) {
              pix[0] = pix[0];
          } else {
              if ((x & 1) == 0) { // even 2, 4, 6, ...
                  pix[0] = rdbuf1_pix.slc<8>(0);
              } else { // odd 3, 5, 7, ...
                  pix[0] = rdbuf1_pix.slc<8>(8);
              }
          }
          
          // For uint_pix[1]
          if (x == 0 || x == 1) {
              pix[1] = pix[1];
          } else {
              if ((x & 1) == 0) { // even 2, 4, 6, ...
                  pix[1] = rdbuf0_pix.slc<8>(0);
              } else { // odd 3, 5, 7, ...
                  pix[1] = rdbuf0_pix.slc<8>(8);
              }
          }


          // Read dat_in into pix[2]
          if (y <= heightIn-1 && x <= widthIn-1) {  
            pix[2] = dat_in.read(); // Read streaming interface
          }

          // LineBuffer Access
          // first col 
          if(x==0){
            rdbuf0_pix = line_buf0[x/2];
            rdbuf1_pix = line_buf1[x/2];

            pix[4] = rdbuf0_pix.slc<8>(0);
            pix[1] = rdbuf0_pix.slc<8>(8);

            pix[3] = rdbuf1_pix.slc<8>(0);
            pix[0] = rdbuf1_pix.slc<8>(8);
          }else{
            if ( (x&1)==1 ) {
            // ReadLineBuffer in x=1, x=3, ... x=odd
              rdbuf0_pix = line_buf0[(x+1)/2];
              rdbuf1_pix = line_buf1[(x+1)/2];
            } else {
            // WriteLineBuffer in x=2, x=4, ... x=even
              if(y==0){    // first row => write into buf1
                line_buf0[(x/2)-1] = wrbuf0_pix;
              }else{
                line_buf0[(x/2)-1] = wrbuf0_pix; 
                line_buf1[(x/2)-1] = wrbuf1_pix; 
              }
            }
          }

          // Padding
          if(y==1 && x==1){    
            //Around padding
            pix[0] = pix[1];
            pix[3] = pix[4];
            pix[6] = pix[4];
            pix[7] = pix[4];
            pix[8] = pix[5];
          }else if(y == heightIn && x == 1){
            pix[2] = pix[1];
            pix[5] = pix[4];
            pix[7] = pix[4];
            pix[8] = pix[4];
            pix[6] = pix[3];
          }else if(y == 1 && x == widthIn){
            pix[0] = pix[4];
            pix[1] = pix[4];
            pix[3] = pix[4];
            pix[2] = pix[5];
            pix[6] = pix[7];
          }else if(y == heightIn && x == widthIn){
            pix[0] = pix[3];
            pix[1] = pix[4];
            pix[2] = pix[4];
            pix[5] = pix[4];
            pix[8] = pix[7];
          }
          else if(x==1){
            pix[6] = pix[3];
            pix[7] = pix[4];
            pix[8] = pix[5];
          }else if(y == heightIn){
            pix[2] = pix[1];
            pix[5] = pix[4];
            pix[8] = pix[7];
          }else if(y==1){
            pix[0] = pix[1];
            pix[3] = pix[4];
            pix[6] = pix[7];
          }else if(x == widthIn){
            pix[0] = pix[3];
            pix[1] = pix[4];
            pix[2] = pix[5];
          }

          /*
          printf(" ======== Pixel calculate with Kernal ========= \n");
          printf(" ======== x=%u, y=%u ========= \n", x.to_int(), y.to_int());
          printf(" ======== pix[6]=%2d, pix[3]=%2d, pix[0]=%2d ========= \n", pix[6].to_int(), pix[3].to_int(), pix[0].to_int());
          printf(" ======== pix[7]=%2d, pix[4]=%2d, pix[1]=%2d ========= \n", pix[7].to_int(), pix[4].to_int(), pix[1].to_int());
          printf(" ======== pix[8]=%2d, pix[5]=%2d, pix[2]=%2d ========= \n\n", pix[8].to_int(), pix[5].to_int(), pix[2].to_int());
          */
          
          // Calculate with Gaussian_kernel
          if(ctrl_signal == 0){
            // Bypass Mode
            pix_result = pix[4];
          }else if(ctrl_signal == 1){
            // Gaussian Filter
            pix_result = 0;
            for(i=0; i<9; i++){
              pix_multi_float = pix[i] * Gaussian_kernel[i];
              pix_result += pix_multi_float / 16;
            }
          }else if(ctrl_signal == 2){
            // Medium Filter
            for(i=0; i<9; i++){
              tmp_pix[i] = pix[i];
            }
            
            pix_result = 0;
            for(j=0; j<5; j++){
              max_val = tmp_pix[j];
              max_i = j;
              for(i=j+1; i<9; i++){
                if(tmp_pix[i] > max_val){
                  max_val = tmp_pix[i];
                  max_i = i;
                }
              }
              tmp_pix[max_i] = tmp_pix[j];
            }
            pix_result = max_val;
          }

          // Output dat_out
          if (y!=0 && x!=0) { 
            // Saturation
            //printf(" ======== pix_result ========= \n");
            //printf(" ======== x=%u, y=%u ========= \n", x.to_int(), y.to_int());
            //printf(" ======== pix_result_sat=%2d, pix_result=%2d ========= \n", pix_result_sat.to_int(), pix_result.to_int());
            if(pix_result < 0){
              pix_result_sat = 0; 
            }else if(pix_result > 255){
              pix_result_sat = 255;
            }else{
              pix_result_sat = pix_result.slc<8>(3);
            }
            
            dat_out.write(pix_result_sat);
          }
 
          // Pixel Shift 
          pix[6] = pix[3]; pix[7] = pix[4]; pix[8] = pix[5];
          if(x==0){
            // maintain
            pix[3] = pix[3]; pix[4] = pix[4];
          }else{
            // shift
            pix[3] = pix[0]; pix[4] = pix[1];
          }
          
          pix[5] = pix[2];
          
          // WriteLineBuffer
          wrbuf0_pix.set_slc(0,pix[8]);
          wrbuf0_pix.set_slc(8,pix[5]);   
          wrbuf1_pix.set_slc(0,pix[7]);
          wrbuf1_pix.set_slc(8,pix[4]);  

          // programmable width exit condition
          if (x ==  maxWType(widthIn)) { // cast to maxWType for RTL code coverage
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


