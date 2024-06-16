#ifndef _MAXPOOL__H
#define _MAXPOOL__H

#include <ac_int.h>
#include <ac_channel.h>
#include <mc_scverify.h>
#include <ac_fixed.h>
#include <defs.h>

class maxpool
{

public:
    maxpool() {}
#pragma hls_design interface
    void CCS_BLOCK(run)(
        bufType input[64 * 64 * 8], // memory interface
        bufType output[64 * 64 * 8],
        ac_int<7, false> &channels, // direct input
        ac_int<7, false> &height,   // direct input
        ac_int<7, false> &width,     // direct input
        ac_int<3, false> &pool_size, // direct input
        ac_int<3, false> &stride     // direct input
    )
    {
        ac_int<7, false> out_height = height / stride;
        ac_int<7, false> out_width = width / stride;

        ac_fixed<15,9,true> max_val;
        ac_int<7, false> c;
        ac_int<7, false> i;
        ac_int<7, false> j;
        ac_int<3, false> x;
        ac_int<3, false> y;
        ac_fixed<15,9,true> val;


        LOOP_CH: for (c = 0; c < channels; c++) {
            LOOP_HEIGHT: for (i = 0; i < out_height; i++) {
                LOOP_WIDTH: for (j = 0; j < out_width; j++) {
                    LOOP_X: for (x = 0; x < pool_size; x++) {
                        LOOP_Y: for (y = 0; y < pool_size; y++) {
                            if (x == 0 && y == 0) {
                                max_val = input[c * height * width + (i * stride + x) * width + (j * stride + y)];
                            } else {
                                val = input[c * height * width + (i * stride + x) * width + (j * stride + y)];
                                if (val > max_val) {
                                    max_val = val;
                                }
                            }
                        }
                    }
                    output[c * out_height * out_width + i * out_width + j] = max_val;
                }
            }
        }
    }
};

#endif