#pragma once

#include "OpticalFlow_defs.h"
#include <mc_scverify.h>

class OpticalFlow_gradient_x_calc
{
  public:
    OpticalFlow_gradient_x_calc() {}
  
    #pragma hls_design interface
    void CCS_BLOCK(run)(ac_channel<input_t> &frame3_b,
                        ac_channel<pixel_t> &gradient_x,
                        maxWType            widthIn,
                        maxHType            heightIn)
    {
      // pixel buffers store pixel history
      input_t pix_buf0 = 0;
      input_t pix_buf1 = 0;
      input_t pix_buf2 = 0;
      input_t pix_buf3 = 0;

      input_t pix0;
      input_t pix1;
      input_t pix2;
      input_t pix3;
      input_t pix4;

      pixel_t gradient_x_value;

      Gradient_x_calc_ROW: for (maxHType y=0; ; y++) {
        Gradient_x_calc_COLUMN: for (maxWType x=0; ; x++) {

          //////////////////////// If using replication method on boundary ////////////////////////
          ///// // read input value
          ///// if (x <= widthIn-1) {
          /////   pix0 = frame3_b.read(); // Read from input stream
          ///// } else {
          /////   pix0 = pix_buf0;
          ///// }
          ///// 
          ///// if (x == 0) {
          /////   pix1 = pix0;
          /////   pix2 = pix0;
          /////   pix3 = pix0;
          /////   pix4 = pix0;
          ///// } else {
          /////   pix1 = pix_buf0;
          /////   pix2 = pix_buf1;
          /////   pix3 = pix_buf2;
          /////   pix4 = pix_buf3;
          ///// }
          /////////////////////////////////////////////////////////////////////////////////////////

          // read input value
          if (x <= widthIn-1) {
            pix0 = frame3_b.read(); // Read from input stream
            //if (x==50) {
            //  cout << pix0 << ", ";
            //}
          } else {
            pix0 = pix_buf0;
          }

          pix1 = pix_buf0;
          pix2 = pix_buf1;
          pix3 = pix_buf2;
          pix4 = pix_buf3;

          // Calculate Ix
          gradient_x_value = pix0*GRAD_WEIGHTS[4] + pix1*GRAD_WEIGHTS[3] + pix2*GRAD_WEIGHTS[2] + pix3*GRAD_WEIGHTS[1] + pix4*GRAD_WEIGHTS[0];
          //cout << pix0 << ", ";
          //cout << GRAD_WEIGHTS[4] << ", ";
          //cout << pix0*GRAD_WEIGHTS[4] << endl;
          //if ((x==992) && (y==435)){
          //  cout << "Ix: " << gradient_x_value << endl; 
          //}

          pix_buf3 = pix_buf2;
          pix_buf2 = pix_buf1;
          pix_buf1 = pix_buf0;
          pix_buf0 = pix0;

          // Write output Ix streaming interface
          if ((x >= 4) && (x < widthIn)) {
            gradient_x.write(gradient_x_value);
            //cout << "HLS: " << gradient_x_value << endl;
          } else if (x >= 2) {
            gradient_x.write(0);
          }

          if ((x==TARGET_X+2) && (y==TARGET_Y)){
            //cout << pix0 << ", " << pix1 << ", " << pix2 << ", " << pix3 << ", " << pix4 << endl;
            cout << "HLS_Ix: " << gradient_x_value << endl;
            //for (int k=PIXEL_T_BIT_WIDTH-1;k>0;k=k-1){
            //  cout << gradient_x_value[k];
            //}
            //cout << endl;
          }
          
          // programmable width exit condition
          if (x == widthIn+1) {
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


