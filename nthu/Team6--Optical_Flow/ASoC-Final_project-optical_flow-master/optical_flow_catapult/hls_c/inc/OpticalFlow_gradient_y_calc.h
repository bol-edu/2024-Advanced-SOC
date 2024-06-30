#pragma once

#include "OpticalFlow_defs.h"
#include <mc_scverify.h>

class OpticalFlow_gradient_y_calc
{
  public:
    OpticalFlow_gradient_y_calc() {}
  
    #pragma hls_design interface
    void CCS_BLOCK(run)(/////ac_channel<input_t> &frame3_c,
                        ac_channel<frames_t> &input_frames,
                        ac_channel<pixel_t> &gradient_y,
                        ac_channel<input_t> &frame3,
                        ac_channel<frames_t> &input_frames_delayed,
                        maxWType            widthIn,
                        maxHType            heightIn)
    {
      frames_t input_frames_value;
      ////////input5x_t input_frames_40bits;

      // Line buffers store pixel line history - Mapped to RAM
      input2x_t line_buf3[MAX_WIDTH/2];
      input2x_t line_buf2[MAX_WIDTH/2];
      input8x_t line_buf1[MAX_WIDTH/2];
      input8x_t line_buf0[MAX_WIDTH/2];
      
      input2x_t rdbuf2_pix, rdbuf3_pix;
      input2x_t rdbuf1_pix_slice;
      input8x_t rdbuf0_pix, rdbuf1_pix;
      input8x_t wrbuf0_pix; //, wrbuf1_pix, wrbuf2_pix, wrbuf3_pix;
      
      input_t pix0, pix1, pix2, pix3, pix4;
      input1x_t pix0_buf, pix1_buf, pix2_buf, pix3_buf, pix4_buf;

      pixel_t gradient_y_value;
      frames_t input_frames_delayed_value;

      Gradient_y_calc_ROW: for (maxHType y=0; ; y++) {
        Gradient_y_calc_COLUMN: for (maxWType x=0; ; x++) {
          // read input channel
          if (y <= heightIn-1) {
            input_frames_value = input_frames.read();
            ////////input_frames_40bits = input_frames_value.slc<40>(0);
            pix0 = (input_t)(input_frames_value.slc<INPUT_T_BIT_WIDTH>(16));
            // transform into ac_int type, in order to set write_data_buffer
            /////for(uint i=0; i<INPUT_T_BIT_WIDTH; i++){
            /////    pix0_buf[i] = pix0[i];
            /////}
            //if (x==50){
            //  cout << pix0 << ", ";
            //  cout << pix0_buf << ", ";
            //}
            
          }

          // Write data cache, write lower 32 on even iterations of COL loop, upper 32 on odd (when "INPUT_T_BIT_WIDTH=8")
          if ( (x&1) == 0 ) {
            ////////wrbuf0_pix.set_slc(0,input_frames_40bits);
            wrbuf0_pix.set_slc(0,input_frames_value);
          } else {
            ////////wrbuf0_pix.set_slc(INPUT_T_BIT_WIDTH*5,input_frames_40bits);
            wrbuf0_pix.set_slc(INPUT_T_BIT_WIDTH*4,input_frames_value);
          }
          // Read line buffers into read buffer caches on even iterations of COL loop
          if ( (x&1) == 0 ) {
            // vertical window of pixels
            rdbuf3_pix = line_buf3[x/2];
            rdbuf2_pix = line_buf2[x/2];
            rdbuf1_pix = line_buf1[x/2];
            rdbuf0_pix = line_buf0[x/2];
            //if (x==50){
            //  cout << rdbuf0_pix << " out, ";
            //}
          } else { // Write line buffer caches on odd iterations of COL loop
            line_buf3[x/2] = rdbuf2_pix; // copy previous line
            rdbuf1_pix_slice.set_slc(0,rdbuf1_pix.slc<INPUT_T_BIT_WIDTH>(16));
            rdbuf1_pix_slice.set_slc(INPUT_T_BIT_WIDTH,rdbuf1_pix.slc<INPUT_T_BIT_WIDTH>(INPUT_T_BIT_WIDTH*4+16));
            line_buf2[x/2] = rdbuf1_pix_slice; // copy previous line
            line_buf1[x/2] = rdbuf0_pix; // copy previous line
            line_buf0[x/2] = wrbuf0_pix; // store current line
            //if (x==51){
            //  cout << wrbuf0_pix << ", ";
            //}
            
          }
          // Get 32-bit data from read buffer caches, lower 32 on even iterations of COL loop (when "INPUT_T_BIT_WIDTH=8")
          pix4_buf = ((x&1)==0) ? rdbuf3_pix.slc<INPUT_T_BIT_WIDTH>(0) : rdbuf3_pix.slc<INPUT_T_BIT_WIDTH>(INPUT_T_BIT_WIDTH);
          pix3_buf = ((x&1)==0) ? rdbuf2_pix.slc<INPUT_T_BIT_WIDTH>(0) : rdbuf2_pix.slc<INPUT_T_BIT_WIDTH>(INPUT_T_BIT_WIDTH);
          pix2_buf = ((x&1)==0) ? rdbuf1_pix.slc<INPUT_T_BIT_WIDTH>(16) : rdbuf1_pix.slc<INPUT_T_BIT_WIDTH>(INPUT_T_BIT_WIDTH*4+16);
          pix1_buf = ((x&1)==0) ? rdbuf0_pix.slc<INPUT_T_BIT_WIDTH>(16) : rdbuf0_pix.slc<INPUT_T_BIT_WIDTH>(INPUT_T_BIT_WIDTH*4+16);

          input_frames_delayed_value = ((x&1)==0) ? rdbuf1_pix.slc<INPUT_T_BIT_WIDTH*4>(0) : rdbuf1_pix.slc<INPUT_T_BIT_WIDTH*4>(INPUT_T_BIT_WIDTH*4);
          
          // transform back into ac_fixed type
          for(uint i=0; i<INPUT_T_BIT_WIDTH; i++){
            pix4[i] = pix4_buf[i];
            pix3[i] = pix3_buf[i];
            pix2[i] = pix2_buf[i];
            pix1[i] = pix1_buf[i];
          }
          //if (x==50){
          //  cout << pix1 << ", ";
          //  cout << pix1_buf << endl;
          //}

          // Boundary condition
          // Here we do NOT care about the value of pix0 when "y >= heightIn"

          // Calculate Iy
          gradient_y_value = pix0*GRAD_WEIGHTS[4] + pix1*GRAD_WEIGHTS[3] + pix2*GRAD_WEIGHTS[2] + pix3*GRAD_WEIGHTS[1] + pix4*GRAD_WEIGHTS[0];
          //if ((pix0==pix1) && (pix0==pix2) && (pix0==pix3) && (pix0==pix4)){
          //if ((pix0==151) && (pix1==144) && (pix2==129) && (pix3==144) && (pix4==151)){
          //if (gradient_y_value<-20){
          //  cout << pix0 << ", " << pix1 << ", " << pix2 << ", " << pix3 << ", " << pix4 << endl;
          //  cout << GRAD_WEIGHTS[4] << ", " << GRAD_WEIGHTS[3] << ", " << GRAD_WEIGHTS[2] << ", " << GRAD_WEIGHTS[1] << ", " << GRAD_WEIGHTS[0] << endl;
          //  cout << "output:" << gradient_y_value << endl;
          //}

          // Write output Iy streaming interface
          if ((y >= 4) && (y < heightIn)) {
            gradient_y.write(gradient_y_value);
            frame3.write(pix2);
            input_frames_delayed.write(input_frames_delayed_value);
          } else if (y >= 2) {
            gradient_y.write(0);
            frame3.write(pix2);
            input_frames_delayed.write(input_frames_delayed_value);
          }

          if ((x==TARGET_X) && (y==TARGET_Y+2)){
            //cout << "input_frames_delayed_value: " << input_frames_delayed_value << endl;
            //cout << "input_frames_value: " << input_frames_value << endl;
            //cout << pix0 << ", " << pix1 << ", " << pix2 << ", " << pix3 << ", " << pix4 << endl;
            cout << "HLS_Iy: " << gradient_y_value << endl;
          }

          // programmable width exit condition
          if (x == widthIn-1) {
            break;
          }
        }
        // programmable height exit condition
        if (y == heightIn+1) {
          break;
        }
      }
    }
};


