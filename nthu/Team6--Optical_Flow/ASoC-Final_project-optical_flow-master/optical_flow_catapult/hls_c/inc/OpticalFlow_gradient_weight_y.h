#pragma once

#include "OpticalFlow_defs.h"
#include <mc_scverify.h>

class OpticalFlow_gradient_weight_y
  {
  public:
    OpticalFlow_gradient_weight_y() {}
  
    #pragma hls_design interface
    void CCS_BLOCK(run)(ac_channel<pixel_t>    &gradient_x,
                        ac_channel<pixel_t>    &gradient_y,
                        ac_channel<pixel_t>    &gradient_z,
                        ac_channel<gradient_t> &y_filtered,
                        maxWType            widthIn,
                        maxHType            heightIn)
    {
      // Line buffers store pixel line history - Mapped to RAM
      //pixel2x_t line_buf6_Ix[MAX_WIDTH/2];
      pixel2x_t line_buf5_Ix[MAX_WIDTH/2];
      pixel2x_t line_buf4_Ix[MAX_WIDTH/2];
      pixel2x_t line_buf3_Ix[MAX_WIDTH/2];
      pixel2x_t line_buf2_Ix[MAX_WIDTH/2];
      pixel2x_t line_buf1_Ix[MAX_WIDTH/2];
      pixel2x_t line_buf0_Ix[MAX_WIDTH/2];
      //pixel2x_t line_buf6_Iy[MAX_WIDTH/2];
      pixel2x_t line_buf5_Iy[MAX_WIDTH/2];
      pixel2x_t line_buf4_Iy[MAX_WIDTH/2];
      pixel2x_t line_buf3_Iy[MAX_WIDTH/2];
      pixel2x_t line_buf2_Iy[MAX_WIDTH/2];
      pixel2x_t line_buf1_Iy[MAX_WIDTH/2];
      pixel2x_t line_buf0_Iy[MAX_WIDTH/2];
      //pixel2x_t line_buf6_Iz[MAX_WIDTH/2];
      pixel2x_t line_buf5_Iz[MAX_WIDTH/2];
      pixel2x_t line_buf4_Iz[MAX_WIDTH/2];
      pixel2x_t line_buf3_Iz[MAX_WIDTH/2];
      pixel2x_t line_buf2_Iz[MAX_WIDTH/2];
      pixel2x_t line_buf1_Iz[MAX_WIDTH/2];
      pixel2x_t line_buf0_Iz[MAX_WIDTH/2];

      //pixel2x_t rdbuf0_Ix, rdbuf1_Ix, rdbuf2_Ix, rdbuf3_Ix, rdbuf4_Ix, rdbuf5_Ix, rdbuf6_Ix;
      //pixel2x_t rdbuf0_Iy, rdbuf1_Iy, rdbuf2_Iy, rdbuf3_Iy, rdbuf4_Iy, rdbuf5_Iy, rdbuf6_Iy;
      //pixel2x_t rdbuf0_Iz, rdbuf1_Iz, rdbuf2_Iz, rdbuf3_Iz, rdbuf4_Iz, rdbuf5_Iz, rdbuf6_Iz;
      pixel2x_t rdbuf0_Ix, rdbuf1_Ix, rdbuf2_Ix, rdbuf3_Ix, rdbuf4_Ix, rdbuf5_Ix;
      pixel2x_t rdbuf0_Iy, rdbuf1_Iy, rdbuf2_Iy, rdbuf3_Iy, rdbuf4_Iy, rdbuf5_Iy;
      pixel2x_t rdbuf0_Iz, rdbuf1_Iz, rdbuf2_Iz, rdbuf3_Iz, rdbuf4_Iz, rdbuf5_Iz;
      pixel2x_t wrbuf0_Ix;
      pixel2x_t wrbuf0_Iy;
      pixel2x_t wrbuf0_Iz;

      pixel_t Ix0, Ix1, Ix2, Ix3, Ix4, Ix5, Ix6;
      pixel_t Iy0, Iy1, Iy2, Iy3, Iy4, Iy5, Iy6;
      pixel_t Iz0, Iz1, Iz2, Iz3, Iz4, Iz5, Iz6;
      pixel1x_t Ix0_buf, Ix1_buf, Ix2_buf, Ix3_buf, Ix4_buf, Ix5_buf, Ix6_buf;
      pixel1x_t Iy0_buf, Iy1_buf, Iy2_buf, Iy3_buf, Iy4_buf, Iy5_buf, Iy6_buf;
      pixel1x_t Iz0_buf, Iz1_buf, Iz2_buf, Iz3_buf, Iz4_buf, Iz5_buf, Iz6_buf;

      gradient_t y_filtered_value;

      Gradient_weight_y_ROW: for (maxHType y=0; ; y++) {
        Gradient_weight_y_COLUMN: for (maxWType x=0; ; x++) {
          // read input channel
          if (y <= heightIn-1) {
            Ix0 = gradient_x.read();
            Iy0 = gradient_y.read();
            Iz0 = gradient_z.read();

            // transform into ac_int type, in order to set write_data_buffer
            for(uint i=0; i<PIXEL_T_BIT_WIDTH; i++){
                Ix0_buf[i] = Ix0[i];
                Iy0_buf[i] = Iy0[i];
                Iz0_buf[i] = Iz0[i];
            }
          }
          // Write data cache, write lower 32 on even iterations of COL loop, upper 32 on odd (when "PIXEL_T_BIT_WIDTH=32")
          if ( (x&1) == 0 ) {
            wrbuf0_Ix.set_slc(0,Ix0_buf);
            wrbuf0_Iy.set_slc(0,Iy0_buf);
            wrbuf0_Iz.set_slc(0,Iz0_buf);
          } else {
            wrbuf0_Ix.set_slc(PIXEL_T_BIT_WIDTH,Ix0_buf);
            wrbuf0_Iy.set_slc(PIXEL_T_BIT_WIDTH,Iy0_buf);
            wrbuf0_Iz.set_slc(PIXEL_T_BIT_WIDTH,Iz0_buf);
          }
          // Read line buffers into read buffer caches on even iterations of COL loop
          if ( (x&1) == 0 ) {
            // vertical window of pixels
            //rdbuf6_Ix = line_buf6_Ix[x/2];
            rdbuf5_Ix = line_buf5_Ix[x/2];
            rdbuf4_Ix = line_buf4_Ix[x/2];
            rdbuf3_Ix = line_buf3_Ix[x/2];
            rdbuf2_Ix = line_buf2_Ix[x/2];
            rdbuf1_Ix = line_buf1_Ix[x/2];
            rdbuf0_Ix = line_buf0_Ix[x/2];
            //rdbuf6_Iy = line_buf6_Iy[x/2];
            rdbuf5_Iy = line_buf5_Iy[x/2];
            rdbuf4_Iy = line_buf4_Iy[x/2];
            rdbuf3_Iy = line_buf3_Iy[x/2];
            rdbuf2_Iy = line_buf2_Iy[x/2];
            rdbuf1_Iy = line_buf1_Iy[x/2];
            rdbuf0_Iy = line_buf0_Iy[x/2];
            //rdbuf6_Iz = line_buf6_Iz[x/2];
            rdbuf5_Iz = line_buf5_Iz[x/2];
            rdbuf4_Iz = line_buf4_Iz[x/2];
            rdbuf3_Iz = line_buf3_Iz[x/2];
            rdbuf2_Iz = line_buf2_Iz[x/2];
            rdbuf1_Iz = line_buf1_Iz[x/2];
            rdbuf0_Iz = line_buf0_Iz[x/2];
          } else { // Write line buffer caches on odd iterations of COL loop
            //line_buf6_Ix[x/2] = rdbuf5_Ix; // copy previous line
            line_buf5_Ix[x/2] = rdbuf4_Ix; // copy previous line
            line_buf4_Ix[x/2] = rdbuf3_Ix; // copy previous line
            line_buf3_Ix[x/2] = rdbuf2_Ix; // copy previous line
            line_buf2_Ix[x/2] = rdbuf1_Ix; // copy previous line
            line_buf1_Ix[x/2] = rdbuf0_Ix; // copy previous line
            line_buf0_Ix[x/2] = wrbuf0_Ix; // store current line
            //line_buf6_Iy[x/2] = rdbuf5_Iy; // copy previous line
            line_buf5_Iy[x/2] = rdbuf4_Iy; // copy previous line
            line_buf4_Iy[x/2] = rdbuf3_Iy; // copy previous line
            line_buf3_Iy[x/2] = rdbuf2_Iy; // copy previous line
            line_buf2_Iy[x/2] = rdbuf1_Iy; // copy previous line
            line_buf1_Iy[x/2] = rdbuf0_Iy; // copy previous line
            line_buf0_Iy[x/2] = wrbuf0_Iy; // store current line
            //line_buf6_Iz[x/2] = rdbuf5_Iz; // copy previous line
            line_buf5_Iz[x/2] = rdbuf4_Iz; // copy previous line
            line_buf4_Iz[x/2] = rdbuf3_Iz; // copy previous line
            line_buf3_Iz[x/2] = rdbuf2_Iz; // copy previous line
            line_buf2_Iz[x/2] = rdbuf1_Iz; // copy previous line
            line_buf1_Iz[x/2] = rdbuf0_Iz; // copy previous line
            line_buf0_Iz[x/2] = wrbuf0_Iz; // store current line
          }
          // Get 32-bit data from read buffer caches, lower 32 on even iterations of COL loop (when "PIXEL_T_BIT_WIDTH=32")
          Ix6_buf = ((x&1)==0) ? rdbuf5_Ix.slc<PIXEL_T_BIT_WIDTH>(0) : rdbuf5_Ix.slc<PIXEL_T_BIT_WIDTH>(PIXEL_T_BIT_WIDTH);
          Ix5_buf = ((x&1)==0) ? rdbuf4_Ix.slc<PIXEL_T_BIT_WIDTH>(0) : rdbuf4_Ix.slc<PIXEL_T_BIT_WIDTH>(PIXEL_T_BIT_WIDTH);
          Ix4_buf = ((x&1)==0) ? rdbuf3_Ix.slc<PIXEL_T_BIT_WIDTH>(0) : rdbuf3_Ix.slc<PIXEL_T_BIT_WIDTH>(PIXEL_T_BIT_WIDTH);
          Ix3_buf = ((x&1)==0) ? rdbuf2_Ix.slc<PIXEL_T_BIT_WIDTH>(0) : rdbuf2_Ix.slc<PIXEL_T_BIT_WIDTH>(PIXEL_T_BIT_WIDTH);
          Ix2_buf = ((x&1)==0) ? rdbuf1_Ix.slc<PIXEL_T_BIT_WIDTH>(0) : rdbuf1_Ix.slc<PIXEL_T_BIT_WIDTH>(PIXEL_T_BIT_WIDTH);
          Ix1_buf = ((x&1)==0) ? rdbuf0_Ix.slc<PIXEL_T_BIT_WIDTH>(0) : rdbuf0_Ix.slc<PIXEL_T_BIT_WIDTH>(PIXEL_T_BIT_WIDTH);
          Iy6_buf = ((x&1)==0) ? rdbuf5_Iy.slc<PIXEL_T_BIT_WIDTH>(0) : rdbuf5_Iy.slc<PIXEL_T_BIT_WIDTH>(PIXEL_T_BIT_WIDTH);
          Iy5_buf = ((x&1)==0) ? rdbuf4_Iy.slc<PIXEL_T_BIT_WIDTH>(0) : rdbuf4_Iy.slc<PIXEL_T_BIT_WIDTH>(PIXEL_T_BIT_WIDTH);
          Iy4_buf = ((x&1)==0) ? rdbuf3_Iy.slc<PIXEL_T_BIT_WIDTH>(0) : rdbuf3_Iy.slc<PIXEL_T_BIT_WIDTH>(PIXEL_T_BIT_WIDTH);
          Iy3_buf = ((x&1)==0) ? rdbuf2_Iy.slc<PIXEL_T_BIT_WIDTH>(0) : rdbuf2_Iy.slc<PIXEL_T_BIT_WIDTH>(PIXEL_T_BIT_WIDTH);
          Iy2_buf = ((x&1)==0) ? rdbuf1_Iy.slc<PIXEL_T_BIT_WIDTH>(0) : rdbuf1_Iy.slc<PIXEL_T_BIT_WIDTH>(PIXEL_T_BIT_WIDTH);
          Iy1_buf = ((x&1)==0) ? rdbuf0_Iy.slc<PIXEL_T_BIT_WIDTH>(0) : rdbuf0_Iy.slc<PIXEL_T_BIT_WIDTH>(PIXEL_T_BIT_WIDTH);
          Iz6_buf = ((x&1)==0) ? rdbuf5_Iz.slc<PIXEL_T_BIT_WIDTH>(0) : rdbuf5_Iz.slc<PIXEL_T_BIT_WIDTH>(PIXEL_T_BIT_WIDTH);
          Iz5_buf = ((x&1)==0) ? rdbuf4_Iz.slc<PIXEL_T_BIT_WIDTH>(0) : rdbuf4_Iz.slc<PIXEL_T_BIT_WIDTH>(PIXEL_T_BIT_WIDTH);
          Iz4_buf = ((x&1)==0) ? rdbuf3_Iz.slc<PIXEL_T_BIT_WIDTH>(0) : rdbuf3_Iz.slc<PIXEL_T_BIT_WIDTH>(PIXEL_T_BIT_WIDTH);
          Iz3_buf = ((x&1)==0) ? rdbuf2_Iz.slc<PIXEL_T_BIT_WIDTH>(0) : rdbuf2_Iz.slc<PIXEL_T_BIT_WIDTH>(PIXEL_T_BIT_WIDTH);
          Iz2_buf = ((x&1)==0) ? rdbuf1_Iz.slc<PIXEL_T_BIT_WIDTH>(0) : rdbuf1_Iz.slc<PIXEL_T_BIT_WIDTH>(PIXEL_T_BIT_WIDTH);
          Iz1_buf = ((x&1)==0) ? rdbuf0_Iz.slc<PIXEL_T_BIT_WIDTH>(0) : rdbuf0_Iz.slc<PIXEL_T_BIT_WIDTH>(PIXEL_T_BIT_WIDTH);

          // transform back into ac_fixed type
          for(uint i=0; i<PIXEL_T_BIT_WIDTH; i++){
            Ix6[i] = Ix6_buf[i];
            Ix5[i] = Ix5_buf[i];
            Ix4[i] = Ix4_buf[i];
            Ix3[i] = Ix3_buf[i];
            Ix2[i] = Ix2_buf[i];
            Ix1[i] = Ix1_buf[i];
            Iy6[i] = Iy6_buf[i];
            Iy5[i] = Iy5_buf[i];
            Iy4[i] = Iy4_buf[i];
            Iy3[i] = Iy3_buf[i];
            Iy2[i] = Iy2_buf[i];
            Iy1[i] = Iy1_buf[i];
            Iz6[i] = Iz6_buf[i];
            Iz5[i] = Iz5_buf[i];
            Iz4[i] = Iz4_buf[i];
            Iz3[i] = Iz3_buf[i];
            Iz2[i] = Iz2_buf[i];
            Iz1[i] = Iz1_buf[i];
          }

          
          if ((y >= 6) && (y < heightIn)) {
            // Calculate y_filtered_value
            y_filtered_value.x = Ix0*GRAD_FILTER[0] + Ix1*GRAD_FILTER[1] + Ix2*GRAD_FILTER[2] + Ix3*GRAD_FILTER[3] + Ix4*GRAD_FILTER[4] + Ix5*GRAD_FILTER[5] + Ix6*GRAD_FILTER[6];
            y_filtered_value.y = Iy0*GRAD_FILTER[0] + Iy1*GRAD_FILTER[1] + Iy2*GRAD_FILTER[2] + Iy3*GRAD_FILTER[3] + Iy4*GRAD_FILTER[4] + Iy5*GRAD_FILTER[5] + Iy6*GRAD_FILTER[6];
            y_filtered_value.z = Iz0*GRAD_FILTER[0] + Iz1*GRAD_FILTER[1] + Iz2*GRAD_FILTER[2] + Iz3*GRAD_FILTER[3] + Iz4*GRAD_FILTER[4] + Iz5*GRAD_FILTER[5] + Iz6*GRAD_FILTER[6];
            //if ((x==990) && (y==435)){
            //  cout << Ix0 << ", " << Ix1 << ", " << Ix2 << ", " << Ix3 << ", " << Ix4 << ", " << Ix5 << ", " << Ix6 << endl;
            //  cout << GRAD_FILTER[0] << ", " << GRAD_FILTER[1] << ", " << GRAD_FILTER[2] << ", " << GRAD_FILTER[3] << ", " << GRAD_FILTER[4] << ", " << GRAD_FILTER[5] << ", " << GRAD_FILTER[6] << endl;
            //  cout << y_filtered_value.x << endl;
            //}

            // Write output y_filtered_value streaming interface
            y_filtered.write(y_filtered_value);
          } else if (y >= 3) {
            // Calculate y_filtered_value
            y_filtered_value.x = 0;
            y_filtered_value.y = 0;
            y_filtered_value.z = 0;

            // Write output y_filtered_value streaming interface
            y_filtered.write(y_filtered_value);
          }

          if ((x==TARGET_X) && (y==TARGET_Y+3)){
            cout << "HLS_y_filtered.x: " << y_filtered_value.x << endl;
            cout << "HLS_y_filtered.y: " << y_filtered_value.y << endl;
            cout << "HLS_y_filtered.z: " << y_filtered_value.z << endl;
          }

          // programmable width exit condition
          if (x == widthIn-1) {
            break;
          }
        }
        // programmable height exit condition
        if (y == heightIn+2) {
          break;
        }
      }
    }
};


