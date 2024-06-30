#pragma once

#include "OpticalFlow_defs.h"
#include <mc_scverify.h>

class OpticalFlow_gradient_z_calc
  {
  public:
    OpticalFlow_gradient_z_calc() {}
  
    #pragma hls_design interface
    void CCS_BLOCK(run)(/////ac_channel<input_t> &frame1_a,
                        /////ac_channel<input_t> &frame2_a,
                        /////ac_channel<input_t> &frame3_a,
                        /////ac_channel<input_t> &frame4_a,
                        /////ac_channel<input_t> &frame5_a,
                        ac_channel<frames_t> &input_frames_delayed,
                        ac_channel<pixel_t> &gradient_z,
                        maxWType            widthIn,
                        maxHType            heightIn)
    {
      input_t frame1_value;
      input_t frame2_value;
      input_t frame3_value;
      input_t frame4_value;
      ////////input_t frame5_value;
      frames_t input_frames_delayed_value;
      
      pixel_t gradient_z_value;

      Gradient_z_calc_ROW: for (maxHType y=0; ; y++) {
        Gradient_z_calc_COLUMN: for (maxWType x=0; ; x++) {
          // read input channels
          /////frame1_value = frame1_a.read();
          /////frame2_value = frame2_a.read();
          /////frame3_value = frame3_a.read();
          /////frame4_value = frame4_a.read();
          /////frame5_value = frame5_a.read();
          input_frames_delayed_value = input_frames_delayed.read();
          frame1_value = (input_t)(input_frames_delayed_value.slc<8>(0));
          frame2_value = (input_t)(input_frames_delayed_value.slc<8>(8));
          frame3_value = (input_t)(input_frames_delayed_value.slc<8>(16));
          frame4_value = (input_t)(input_frames_delayed_value.slc<8>(24));
          ////////frame5_value = (input_t)(input_frames_delayed_value.slc<8>(32));

          // Calculate Iz
          ////////gradient_z_value = frame1_value*GRAD_WEIGHTS[0] + frame2_value*GRAD_WEIGHTS[1] + frame3_value*GRAD_WEIGHTS[2] + frame4_value*GRAD_WEIGHTS[3] + frame5_value*GRAD_WEIGHTS[4];
          gradient_z_value = frame1_value*GRAD_WEIGHTS_Z[0] + frame2_value*GRAD_WEIGHTS_Z[1] + frame3_value*GRAD_WEIGHTS_Z[2] + frame4_value*GRAD_WEIGHTS_Z[3];

          // Write output Iz streaming interface
          gradient_z.write(gradient_z_value);

          if ((x==TARGET_X) && (y==TARGET_Y)){
            //cout << "input_frames_delayed_value: " << frame4_value << frame3_value << frame2_value << frame1_value << endl;
            cout << "HLS_Iz: " << gradient_z_value << endl;
          }

          // programmable width exit condition
          if (x == widthIn-1) {
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


