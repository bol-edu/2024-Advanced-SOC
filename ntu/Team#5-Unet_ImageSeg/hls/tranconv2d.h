#ifndef _TRANCONV2D__H
#define _TRANCONV2D__H

#include <ac_int.h>
#include <ac_channel.h>
#include <mc_scverify.h>
#include <ac_fixed.h>
#include <defs.h>

class tranconv2d{

    public:
    tranconv2d() {}
    #pragma hls_design interface
     void CCS_BLOCK(run)(
                        bufType input[64*64*8], // memory interface
                        bufType output[64*64*8],
                        ac_int<7, false> &height, // direct input
                        ac_int<7, false> &width, // direct input
                        ac_int<2, false> &kernel_size, // direct input
                        ac_int<20, false> &filter_offset, // direct input
                        ac_int<7, false> &in_channels, // direct input
                        ac_int<7, false> &out_channels, // direct input
                        ac_int<3, false> &stride // direct input
                        ) 
    {        
    ac_int<8, false> filter_size = kernel_size * kernel_size;
    ac_int<10, false> out_height = height * stride;
    ac_int<10, false> out_width = width * stride;

    
    // Define the loop variables
    ac_int<8, false> out_c;
    ac_int<8, false> in_c;
    ac_int<7, false> i;
    ac_int<7, false> j;
    ac_int<2, false> x;
    ac_int<2, false> y;
    ac_int<20, false> in_idx;
    ac_int<20, false> filter_idx;
    ac_int<20, false> out_idx;
    ac_fixed<12, 4, true> temp;
    ac_int<20, false> out_i;
    ac_int<20, false> out_j;

    // Reset the output
    LOOP_RESET: for (out_idx=0; out_idx < out_channels * out_height * out_width; out_idx++) {
        output[out_idx] = 0;
    }




    // Perform the transposed convolution
    LOOP_OUT: for (out_c = 0; out_c < out_channels; out_c++) {
        LOOP_IN: for (in_c = 0; in_c < in_channels; in_c++) {
            LOOP_HEIGHT: for (i = 0; i < height; i++) {
                LOOP_WIDTH: for (j = 0; j < width; j++) {
                    LOOP_X: for (x = 0; x < kernel_size; x++) {
                        LOOP_Y: for (y = 0; y < kernel_size; y++) {
                            in_idx = in_c * height * width + i * width + j;
                            filter_idx = out_c * in_channels * filter_size + in_c * filter_size + x * kernel_size + y + filter_offset;
                            out_i = i * stride + x;
                            out_j = j * stride + y;
                            out_idx = out_c * out_height * out_width + out_i * out_width + out_j;
                            output[out_idx] += input[in_idx] * filters_pretrain[filter_idx];
                        }
                    }
                }
            }
        }
    }
    }

};

#endif