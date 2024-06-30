#pragma once

#include "OpticalFlow_defs.h"
#include <mc_scverify.h>

class OpticalFlow_gradient_weight_x
  {
  public:
    OpticalFlow_gradient_weight_x() {}
  
    #pragma hls_design interface
    void CCS_BLOCK(run)(ac_channel<gradient_t> &y_filtered,
                        ac_channel<gradient_t> &filtered_gradient,
                        maxWType            widthIn,
                        maxHType            heightIn)
    {
      // gradient buffers store gradient history
      gradient_t gradient_buf0 = {0,0,0};
      gradient_t gradient_buf1 = {0,0,0};
      gradient_t gradient_buf2 = {0,0,0};
      gradient_t gradient_buf3 = {0,0,0};
      gradient_t gradient_buf4 = {0,0,0};
      gradient_t gradient_buf5 = {0,0,0};
      //gradient_t gradient_buf6 = {0,0,0};

      gradient_t gradient0;
      gradient_t gradient1;
      gradient_t gradient2;
      gradient_t gradient3;
      gradient_t gradient4;
      gradient_t gradient5;
      gradient_t gradient6;


      gradient_t filtered_gradient_value;

      Gradient_weight_x_ROW: for (maxHType y=0; ; y++) {
        Gradient_weight_x_COLUMN: for (maxWType x=0; ; x++) {
          // read input value
          if (x <= widthIn-1) {
            gradient0 = y_filtered.read(); // Read from input stream
          } else {
            gradient0 = gradient_buf0;
          }

          gradient1 = gradient_buf0;
          gradient2 = gradient_buf1;
          gradient3 = gradient_buf2;
          gradient4 = gradient_buf3;
          gradient5 = gradient_buf4;
          gradient6 = gradient_buf5;

          
          //gradient_buf6 = gradient_buf5;
          gradient_buf5 = gradient_buf4;
          gradient_buf4 = gradient_buf3;
          gradient_buf3 = gradient_buf2;
          gradient_buf2 = gradient_buf1;
          gradient_buf1 = gradient_buf0;
          gradient_buf0 = gradient0;

          if ((x >= 6) && (x < widthIn)) {
            // Calculate filtered_gradient
            filtered_gradient_value.x = gradient0.x*GRAD_FILTER[0] + gradient1.x*GRAD_FILTER[1] + gradient2.x*GRAD_FILTER[2] + gradient3.x*GRAD_FILTER[3] + gradient4.x*GRAD_FILTER[4] + gradient5.x*GRAD_FILTER[5] + gradient6.x*GRAD_FILTER[6];
            filtered_gradient_value.y = gradient0.y*GRAD_FILTER[0] + gradient1.y*GRAD_FILTER[1] + gradient2.y*GRAD_FILTER[2] + gradient3.y*GRAD_FILTER[3] + gradient4.y*GRAD_FILTER[4] + gradient5.y*GRAD_FILTER[5] + gradient6.y*GRAD_FILTER[6];
            filtered_gradient_value.z = gradient0.z*GRAD_FILTER[0] + gradient1.z*GRAD_FILTER[1] + gradient2.z*GRAD_FILTER[2] + gradient3.z*GRAD_FILTER[3] + gradient4.z*GRAD_FILTER[4] + gradient5.z*GRAD_FILTER[5] + gradient6.z*GRAD_FILTER[6];

            // Write output filtered_gradient streaming interface
            filtered_gradient.write(filtered_gradient_value);
          } else if (x >= 3) {
            // Calculate filtered_gradient
            filtered_gradient_value.x = 0;
            filtered_gradient_value.y = 0;
            filtered_gradient_value.z = 0;

            // Write output filtered_gradient streaming interface
            filtered_gradient.write(filtered_gradient_value);
          }

          if ((x==TARGET_X+3) && (y==TARGET_Y)){
            cout << "HLS_filtered_gradient.x: " << filtered_gradient_value.x << endl;
            cout << "HLS_filtered_gradient.y: " << filtered_gradient_value.y << endl;
            cout << "HLS_filtered_gradient.z: " << filtered_gradient_value.z << endl;
          }

          // programmable width exit condition
          if (x == widthIn+2) {
            break;
          }
        }
        // programmable height exit condition
        if (y == heightIn-1) {
          break;
        }
      }
    }
};


