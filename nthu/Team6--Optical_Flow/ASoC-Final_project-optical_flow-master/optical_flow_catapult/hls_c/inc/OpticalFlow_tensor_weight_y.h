#pragma once

#include "OpticalFlow_defs.h"
#include <mc_scverify.h>

class OpticalFlow_tensor_weight_y
  {
  public:
    OpticalFlow_tensor_weight_y() {}
  
    #pragma hls_design interface
    void CCS_BLOCK(run)(ac_channel<outer_t>  &out_product,
                        ac_channel<tensor_t> &tensor_y,
                        maxWType            widthIn,
                        maxHType            heightIn)
    {
      // Line buffers store pixel line history - Mapped to RAM
      outer2x_t line_buf1[MAX_WIDTH/2];
      outer2x_t line_buf0[MAX_WIDTH/2];

      outer2x_t rdbuf0, rdbuf1;
      outer2x_t wrbuf0;

      outer_t out_product0, out_product1, out_product2;
      outer1x_t out_product0_buf, out_product1_buf, out_product2_buf;

      tensor_t tensor_y_value;

      Tensor_weight_y_ROW: for (maxHType y=0; ; y++) {
        Tensor_weight_y_COLUMN: for(maxWType x=0; ; x++) {
          // read input channel
          if (y <= heightIn-1) {
            out_product0 = out_product.read();

            // transform into ac_int type, in order to set write_data_buffer
            for(uint component=0; component<6; component++){
              for(uint i=0; i<OUTER_PIXEL_T_BIT_WIDTH; i++){
                  out_product0_buf[OUTER_PIXEL_T_BIT_WIDTH*component+i] = out_product0.val[component][i];
              }
            }
          }

          // Write data cache, write lower 32*6 on even iterations of COL loop, upper 32*6 on odd (when "OUTER_PIXEL_T_BIT_WIDTH=32")
          if ( (x&1) == 0 ) {
            wrbuf0.set_slc(0,out_product0_buf);
          } else {
            wrbuf0.set_slc(OUTER_PIXEL_T_BIT_WIDTH*6,out_product0_buf);
          }

          // Read line buffers into read buffer caches on even iterations of COL loop
          if ( (x&1) == 0 ) {
            // vertical window of pixels
            rdbuf1 = line_buf1[x/2];
            rdbuf0 = line_buf0[x/2];
          } else { // Write line buffer caches on odd iterations of COL loop
            line_buf1[x/2] = rdbuf0; // copy previous line
            line_buf0[x/2] = wrbuf0; // store current line
          }

          // Get 32*6-bit data from read buffer caches, lower 32*6 on even iterations of COL loop (when "OUTER_PIXEL_T_BIT_WIDTH=32")
          out_product2_buf = ((x&1)==0) ? rdbuf1.slc<OUTER_PIXEL_T_BIT_WIDTH*6>(0) : rdbuf1.slc<OUTER_PIXEL_T_BIT_WIDTH*6>(OUTER_PIXEL_T_BIT_WIDTH*6);
          out_product1_buf = ((x&1)==0) ? rdbuf0.slc<OUTER_PIXEL_T_BIT_WIDTH*6>(0) : rdbuf0.slc<OUTER_PIXEL_T_BIT_WIDTH*6>(OUTER_PIXEL_T_BIT_WIDTH*6);

          // split into 6 components & transform back into ac_fixed type
          for(uint component=0; component<6; component++){
            for(uint i=0; i<OUTER_PIXEL_T_BIT_WIDTH; i++){
              out_product2.val[component][i] = out_product2_buf[OUTER_PIXEL_T_BIT_WIDTH*component+i];
              out_product1.val[component][i] = out_product1_buf[OUTER_PIXEL_T_BIT_WIDTH*component+i];
            }
          }

          if ((y >= 2) && (y < heightIn)) {
            // Calculate tensor_y_value
            tensor_y_value.val[0] = out_product0.val[0]*TENSOR_FILTER[0] + out_product1.val[0]*TENSOR_FILTER[1] + out_product2.val[0]*TENSOR_FILTER[2];
            tensor_y_value.val[1] = out_product0.val[1]*TENSOR_FILTER[0] + out_product1.val[1]*TENSOR_FILTER[1] + out_product2.val[1]*TENSOR_FILTER[2];
            tensor_y_value.val[2] = out_product0.val[2]*TENSOR_FILTER[0] + out_product1.val[2]*TENSOR_FILTER[1] + out_product2.val[2]*TENSOR_FILTER[2];
            tensor_y_value.val[3] = out_product0.val[3]*TENSOR_FILTER[0] + out_product1.val[3]*TENSOR_FILTER[1] + out_product2.val[3]*TENSOR_FILTER[2];
            tensor_y_value.val[4] = out_product0.val[4]*TENSOR_FILTER[0] + out_product1.val[4]*TENSOR_FILTER[1] + out_product2.val[4]*TENSOR_FILTER[2];
            tensor_y_value.val[5] = out_product0.val[5]*TENSOR_FILTER[0] + out_product1.val[5]*TENSOR_FILTER[1] + out_product2.val[5]*TENSOR_FILTER[2];

            // Write output tensor_y_value streaming interface
            tensor_y.write(tensor_y_value);
          } else if (y >= 1) {
            // Calculate tensor_y_value
            tensor_y_value.val[0] = 0;
            tensor_y_value.val[1] = 0;
            tensor_y_value.val[2] = 0;
            tensor_y_value.val[3] = 0;
            tensor_y_value.val[4] = 0;
            tensor_y_value.val[5] = 0;

            // Write output tensor_y_value streaming interface
            tensor_y.write(tensor_y_value);
          }

          if ((x==TARGET_X) && (y==TARGET_Y+1)){
            cout << "HLS_tensor_y[0]: " << tensor_y_value.val[0] << endl;
            cout << "HLS_tensor_y[1]: " << tensor_y_value.val[1] << endl;
            cout << "HLS_tensor_y[2]: " << tensor_y_value.val[2] << endl;
            cout << "HLS_tensor_y[3]: " << tensor_y_value.val[3] << endl;
            cout << "HLS_tensor_y[4]: " << tensor_y_value.val[4] << endl;
            cout << "HLS_tensor_y[5]: " << tensor_y_value.val[5] << endl;
          }

          // programmable width exit condition
          if (x == widthIn-1) {
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


