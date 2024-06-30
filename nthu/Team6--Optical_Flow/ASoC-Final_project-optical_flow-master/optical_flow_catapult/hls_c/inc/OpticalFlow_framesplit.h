#pragma once

#include "OpticalFlow_defs.h"
#include <mc_scverify.h>

class OpticalFlow_framesplit
  {
  public:
    OpticalFlow_framesplit() {}
  
    #pragma hls_design interface
    void CCS_BLOCK(run)(ac_channel<frames_t> &input_frames,
                        ac_channel<input_t>  &frame1_a,
                        ac_channel<input_t>  &frame2_a,
                        ac_channel<input_t>  &frame3_a,
                        ac_channel<input_t>  &frame3_b,
                        ac_channel<input_t>  &frame3_c,
                        ac_channel<input_t>  &frame4_a,
                        ac_channel<input_t>  &frame5_a,
                        maxWType             widthIn,
                        maxHType             heightIn)
    {
      frames_t input_frame;
      // stream in and split the input frames into 7 channels
      Framesplit_ROW: for (maxHType y=0; ; y++) {
        Framesplit_COLUMN: for (maxWType x=0; ; x++) {
          // read input channel
          input_frame = input_frames.read();
          
          // assign values to different stream channels (FIFO)
          frame1_a.write((input_t)(input_frame.slc<8>(0)));
          frame2_a.write((input_t)(input_frame.slc<8>(8)));
          frame3_a.write((input_t)(input_frame.slc<8>(16)));
          frame3_b.write((input_t)(input_frame.slc<8>(16)));
          frame3_c.write((input_t)(input_frame.slc<8>(16)));
          frame4_a.write((input_t)(input_frame.slc<8>(24)));
          frame5_a.write((input_t)(input_frame.slc<8>(32)));
          //printf("%x\n", input_frame);
          //printf("%x\n", (input_t)(input_frame.slc<8>(0)));
          //printf("%x\n", (input_t)(input_frame.slc<8>(8)));
          //printf("%x\n", (input_t)(input_frame.slc<8>(16)));
          //printf("%x\n", (input_t)(input_frame.slc<8>(24)));
          //cout << (input_t)(input_frame.slc<8>(0)) << ", ";
          //cout << (input_t)(input_frame.slc<8>(8)) << ", ";
          //cout << (input_t)(input_frame.slc<8>(16)) << ", ";
          //cout << (input_t)(input_frame.slc<8>(24)) << ", ";

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


