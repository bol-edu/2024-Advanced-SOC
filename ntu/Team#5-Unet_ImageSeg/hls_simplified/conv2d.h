#pragma once

#include <ac_int.h>
#include <ac_channel.h>
#include <mc_scverify.h>
#include <ac_fixed.h>
#include <defs.h>

namespace UNET_IP 
{

class conv2d{

    public:
    conv2d() {}
    #pragma hls_design interface

     void CCS_BLOCK(run_conv)(
                        bufType input[64*64*8], // memory interface
                        bufType output[64*64*8],
                        ac_int<7, false> &height, // direct input
                        ac_int<7, false> &width, // direct input
                        ac_int<2, false> &kernel_size, // direct input
                        ac_int<2, false> &padding, // direct input
                        ac_int<20, false> &filter_offset, // direct input
                        ac_int<7, false> &in_channels, // direct input
                        ac_int<7, false> &out_channels // direct input
                        ) 
    {        
    ac_int<8, false> padded_height = height + 2 * padding;
    ac_int<8, false> padded_width = width + 2 * padding;
    ac_int<8, false> filter_size = kernel_size * kernel_size;

    // Copy input to padded input with padding
    // for (ac_int<8, false> c = 0; c < in_channels; c++) {
    //     for (ac_int<7, false> h = 0; h < height; h++) {
    //         #pragma hls_pipeline_init_interval 1
    //         for (ac_int<7, false> w = 0; w < width; w++) {
    //             padded_input[c * padded_height * padded_width + (h + padding) * padded_width + padding + w] = input[c * height * width + h * width + w];
    //         }
    //     }
    // }

    // // Initialize output to 0.0
    // for (ac_int<8, false> c = 0; c < out_channels; c++) {
    //     for (ac_int<7, false> h = 0; h < height; h++) {
    //         #pragma hls_pipeline_init_interval 1
    //         for (ac_int<7, false> w = 0; w < width; w++) {
    //             output[c * height * width + h * width + w] = 0;
    //         }
    //     }
    // }

    // Define the offset due to the kernel size
    ac_int<2, false> offset = kernel_size / 2;

    // Define the loop variables
    ac_int<8, false> out_c;
    ac_int<8, false> in_c;
    ac_int<7, false> i;
    ac_int<7, false> j;
    ac_int<3, true> x;
    ac_int<3, true> y;
    ac_int<20, false> in_idx;
    ac_int<20, false> filter_idx;
    ac_int<20, false> out_idx;
    ac_fixed<12, 4, true> temp;

    // Apply the convolution
    LOOP_OUT:    for (out_c = 0; out_c < out_channels; out_c++) {
        LOOP_IN:    for (in_c = 0; in_c < in_channels; in_c++) {
            LOOP_HEIGHT:    for (i = offset; i < height + offset; i++) {
                LOOP_WIDTH:    for (j = offset; j < width + offset; j++) {
                    out_idx = out_c * height * width + (i - offset) * width + (j - offset);
                    temp = 0;
                    LOOP_X:    for ( x = -offset; x <= offset; x++) {
                        LOOP_Y:    for (y = -offset; y <= offset; y++) {
                            in_idx = in_c * padded_height * padded_width + (i + x) * padded_width + (j + y);
                            filter_idx = out_c * in_channels * filter_size + in_c * filter_size + (x + offset) * kernel_size + (y + offset) + filter_offset;
                            temp += input[in_idx] * filters_pretrain[filter_idx];
                        }
                    }
                    output[out_idx] = temp;
                }
            }
        }
    }
}

};

}
