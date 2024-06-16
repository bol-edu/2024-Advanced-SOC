/*************************************************************************
 *                                                                        *
 *  Edge Detect Design Walkthrough for HLS      
 *  copy VerDer.h                                                         *
 */

#pragma once

#include "EdgeDetect_defs.h"
#include <mc_scverify.h>


namespace EdgeDetect_IP {

  class Kmean
  {
  public:
    Kmean() {}
  
    #pragma hls_design interface
    void CCS_BLOCK(run)(ac_channel<Stream_t> &kmean_in,
                        maxWType              &widthIn,
                        maxHType              &heightIn,
                        ac_channel<pixelTypeRGB> &kmean_out
                                                   )
      {
      KROW: for (maxHType y = 0; ; y++) {
      Stream_t pix0;
      pixelTypeRGB distance_pix;
      pixelTypeRGB index_pix;
      pixelTypeRGB output_rgb;
      pixelTypeRGB distance_cal;
      uint8 kmeanBit = 5;
      uint8 clusterListInt[5];
      clusterListInt[0]=0;
      clusterListInt[1]=52;
      clusterListInt[2]=154;
      clusterListInt[3]=205;
      clusterListInt[4]=255;
        #pragma hls_pipeline_init_interval 1
        KCOL: for (maxWType x = 0; ; x++) {
          if (x <= widthIn-1) {
            pix0 = kmean_in.read(); // Read streaming interface
          }
          
          distance_pix.r_pixelType=255;
          distance_pix.g_pixelType=255;
          distance_pix.b_pixelType=255;
          index_pix.r_pixelType=0;
          index_pix.g_pixelType=0;
          index_pix.b_pixelType=0;
          for (int j = 0; ; j++) {
            distance_cal.r_pixelType=distance(clusterListInt[j],pix0.r_pixelType);
            distance_cal.g_pixelType=distance(clusterListInt[j],pix0.g_pixelType);
            distance_cal.b_pixelType=distance(clusterListInt[j],pix0.b_pixelType);
            if(distance_cal.r_pixelType<distance_pix.r_pixelType){
              distance_pix.r_pixelType=distance_cal.r_pixelType;
              index_pix.r_pixelType=j;
            }
            if(distance_cal.g_pixelType<distance_pix.g_pixelType){
              distance_pix.g_pixelType=distance_cal.g_pixelType;
              index_pix.g_pixelType=j;
            }
            if(distance_cal.b_pixelType<distance_pix.b_pixelType){
              distance_pix.b_pixelType=distance_cal.b_pixelType;
              index_pix.b_pixelType=j;
            }
            if ( j == kmeanBit-1) {
              break;
            }
          }
          output_rgb.r_pixelType=clusterListInt[index_pix.r_pixelType];
          output_rgb.g_pixelType=clusterListInt[index_pix.g_pixelType];
          output_rgb.b_pixelType=clusterListInt[index_pix.b_pixelType];
          kmean_out.write(output_rgb); // derivative out

          // programmable width exit condition
          if (x == maxWType(widthIn-1)) { // cast to maxWType for RTL code coverage
            break;
          }
        }
      if (y == maxHType(heightIn-1)) {
        break;
      }
    }
    }
  private:
      uint8 distance(uint8 a,uint8 b)
    {
      if(a>b) return a-b;
      else return b-a;
    }

  };

}