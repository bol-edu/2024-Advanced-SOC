#include <stdio.h>
#include <stdlib.h>

using namespace std;

#include "conv2d.h"
#include "imgDataSet.h"

#include <iostream>
#include <fstream>
#include <cstdlib>
#include <cmath>
#include <cstring>
#include <mc_scverify.h>

void conv2d_algo(ac_fixed<12, 4, true>*, ac_fixed<12, 4, true>*, ac_fixed<12, 8, true>*, int, int, int, int, int, int);

CCS_MAIN(int argc, char *argv[])
{
    conv2d dut;

    const unsigned int ichs = 3;
    const unsigned int ochs = 8;
    const unsigned int iH = 64;
    const unsigned int iW = 64;

    ac_int<7, false> height = iH;
    ac_int<7, false> width = iW;
    ac_int<2, false> kernel_size = 3;
    ac_int<2, false> padding = 1;
    ac_int<19, false> filter_offset = 0;
    ac_int<7, false> in_channels = ichs;
    ac_int<7, false> out_channels = ochs;

    ac_fixed<12, 4, true> input_img[iH * iW * ichs];
    ac_fixed<12, 4, true> output[iH * iW * ochs];
    ac_fixed<12, 4, true> output_ans[iH * iW * ochs];
    ac_fixed<12, 8, true> filters[128 * 128];

    int padded_height = height + 2 * padding;
    int padded_width = width + 2 * padding;
    ac_fixed<12, 4, true> padded_input[padded_height * padded_width * ichs];

    cout << "Loading Input Image" << endl;
    for (unsigned int c = 0; c < ichs; c++) {
        for (unsigned int h = 0; h < iH; h++) {
            for (unsigned int w = 0; w < iW; w++) {
                int in_idx = c * height * width + h * height + w;
                input_img[in_idx] = img[in_idx];
            }
        }
    }

    cout << "Generating Filter" << endl;
    srand(0);
    int rng_max = 15;
    int rng_min = 0;
    for (unsigned int i = 0; i < (128 * 128); i++) {
        filters[i] = rand() % (rng_max - rng_min + 1) + rng_min;
    }

    cout << "Running" << endl;
    conv2d_algo(input_img, output_ans, filters, ichs, ochs, height, width, kernel_size, padding);
    dut.run(input_img, padded_input, output, filters, height, width, kernel_size, padding, filter_offset, in_channels, out_channels);

    float sumErr = 0;
    for (unsigned int c = 0; c < ochs; c++) {
        for (unsigned int h = 0; h < iH; h++) {
            for (unsigned int w = 0; w < iW; w++) {
                int idx = c * height * width + h * height + w;
                int diff = (output[idx] - output_ans[idx]).to_int();
                int diff_abs = abs(diff);
                sumErr += diff_abs;
            }
        }
    }

    printf("Mean Absolute Error (per pixel) = %f\n", sumErr / (iH * iW * ochs));

    for (int i = 0; i < 3; i++) {
        cout << "----[" << i << "]----" << endl;
        cout << "output = " << output[i] << endl;
        cout << "output_ans = " << output_ans[i] << endl;
    }

    cout << "Finished" << endl;

    CCS_RETURN(0);
}

void conv2d_algo(ac_fixed<12, 4, true>* input, ac_fixed<12, 4, true>* output, ac_fixed<12, 8, true>* filters, int in_channels, int out_channels, int height, int width, int kernel_size, int padding) {
    int padded_height = height + 2 * padding;
    int padded_width = width + 2 * padding;
    int filter_size = kernel_size * kernel_size;

    ac_fixed<12, 4, true> padded_input[padded_height * padded_width * in_channels];

    // Copy input to padded input with padding
    for (int c = 0; c < in_channels; c++) {
        for (int h = 0; h < height; h++) {
            for (int w = 0; w < width; w++) {
                padded_input[(c * padded_height * padded_width + (h + padding) * padded_width + padding + w)] = input[(c * height * width + h * width + w)];
            }
        }
    }

    // Initialize output to 0.0
    for (int c = 0; c < out_channels; c++) {
        for (int h = 0; h < height; h++) {
            for (int w = 0; w < width; w++) {
                output[c * height * width + h * width + w] = 0;
            }
        }
    }

    // Define the offset due to the kernel size
    int offset = kernel_size / 2;

    // Apply the convolution
    for (int out_c = 0; out_c < out_channels; out_c++) {
        for (int in_c = 0; in_c < in_channels; in_c++) {
            for (int i = offset; i < height + offset; i++) {
                for (int j = offset; j < width + offset; j++) {
                    for (int x = -offset; x <= offset; x++) {
                        for (int y = -offset; y <= offset; y++) {
                            int in_idx = in_c * padded_height * padded_width + (i + x) * padded_width + (j + y);
                            int filter_idx = out_c * in_channels * filter_size + in_c * filter_size + (x + offset) * kernel_size + (y + offset);
                            int out_idx = out_c * height * width + (i - offset) * width + (j - offset);
                            output[out_idx] += padded_input[in_idx] * filters[filter_idx];
                        }
                    }
                }
            }
        }
    }
}