#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <time.h>
#include "func.h"
#include <ac_fixed.h>

#define MAX_CHANNELS 128
#define MAX_HEIGHT 64
#define MAX_WIDTH 64
#define MAX_PADDING 1
#define NUM_FILTERS 485120

ac_fixed<15,9,true> input[MAX_CHANNELS * MAX_HEIGHT * MAX_WIDTH];
ac_fixed<15,9,true> input1[MAX_CHANNELS * MAX_HEIGHT * MAX_WIDTH];
ac_fixed<15,9,true> input2[MAX_CHANNELS * MAX_HEIGHT * MAX_WIDTH];
ac_fixed<15,9,true> output[MAX_CHANNELS * MAX_HEIGHT * MAX_WIDTH];
ac_fixed<15,9,true> temp_output1[MAX_CHANNELS * MAX_HEIGHT * MAX_WIDTH];
ac_fixed<15,9,true> temp_output2[MAX_CHANNELS * MAX_HEIGHT * MAX_WIDTH];
ac_fixed<15,9,true> padded_input[MAX_CHANNELS * (MAX_HEIGHT + 2 * MAX_PADDING) * (MAX_WIDTH + 2 * MAX_PADDING)];
ac_fixed<17,1,false> gamma[MAX_CHANNELS * 2];
ac_fixed<17,1,false> beta[MAX_CHANNELS * 2];
ac_fixed<18,0,true> filters[NUM_FILTERS];

void batch_norm(input, output, gamma, beta, uint8 channels, uint7 height, uint7 width, ac_fixed<17,0,false> epsilon) {
    uint13 num_elements = height * width;

    for (uint8 c = 0; c < channels; c++) {
        ac_fixed<14,8,false>  mean     = 0.0;
        ac_fixed<22,16,false> var      = 0.0;
        ac_fixed<26,20,false> mean_tmp = 0.0;
        ac_fixed<34,28,false> var_tmp  = 0.0;

        // Calculate mean
        for (uint13 i = 0; i < num_elements; i++) {
            mean_tmp += input[c * num_elements + i];
        }
        mean = mean_tmp / num_elements;

        // Calculate variance
        for (uint13 i = 0; i < num_elements; i++) {
            var_tmp += (input[c * num_elements + i] - mean) * (input[c * num_elements + i] - mean);
        }
        var= var_tmp / num_elements;


        // Normalize, scale, and shift
        for (uint13 i = 0; i < num_elements; i++) {
            uint20 idx = c * num_elements + i;
            ac_fixed<22,16,false> sum = var + epsilon;
            ac_fixed<14,8,false> var_sqrt;
            output[idx] = gamma[c] * ((input[idx] - mean) / ac_math::ac_sqrt_pwl(sum, var_sqrt)) + beta[c];
        }
    }
}

void relu(input, output, uint8 channels, uint7 height, uint7 width) {
    uint20 num_elements = channels * height * width;

    for (uint20 i = 0; i < num_elements; i++) {
        output[i] = ((ac_fixed<17,0,true>)input[i] > 0) ? (ac_fixed<17,0,true>)input[i] : 0;
    }
}

void batch_norm_relu(input, output, gamma, beta, uint8 channels, uint7 height, uint7 width, ac_fixed<17,0,false> epsilon) {
    batch_norm(input, temp_output1, gamma, beta, channels, height, width, epsilon);
    relu(temp_output1, output, channels, height, width);
}

void conv_block(input, output, filters, gamma, beta, uint8 in_channels, uint8 out_channels, uint7 height, uint7 width, uint18 filter_offset, uint10 gamma_offset, uint10 beta_offset) {
    uint2 kernel_size = 3;
    uint1 padding = 1;
    ac_fixed<17,0,false> epsilon = 1e-5;

    conv2d(input, temp_output1, filters + filter_offset, in_channels, out_channels, height, width, kernel_size, padding);
    batch_norm_relu(temp_output1, temp_output2, gamma + gamma_offset, beta + beta_offset, out_channels, height, width, epsilon);

    conv2d(temp_output2, temp_output1, filters + filter_offset + in_channels * out_channels * kernel_size * kernel_size, out_channels, out_channels, height, width, kernel_size, padding);
    batch_norm_relu(temp_output1, output, gamma + gamma_offset + out_channels, beta + beta_offset + out_channels, out_channels, height, width, epsilon);
}

void conv2d(input, output, filters, uint8 in_channels, uint8 out_channels, uint7 height, uint7 width, uint2 kernel_size, uint2 padding) {
    uint7 padded_height = height + 2 * padding;
    uint7 padded_width = width + 2 * padding;
    uint4 filter_size = kernel_size * kernel_size;

    // Copy input to padded input with padding
    for (uint8 c = 0; c < in_channels; c++) {
        for (uint7 h = 0; h < height; h++) {
            #pragma hls_pipeline_init_interval 1
            for (uint7 w = 0; w < width; w++) {
                padded_input[c * padded_height * padded_width + (h + padding) * padded_width + padding + w] = input[c * height * width + h * width + w]
            }
        }
    }

    // Initialize output to 0.0
    for (uint8 c = 0; c < out_channels; c++) {
        for (uint7 h = 0; h < height; h++) {
            #pragma hls_pipeline_init_interval 1
            for (uint7 w = 0; w < width; w++) {
                output[c * height * width + h * width + w] = 0;
            }
        }
    }

    // Define the offset due to the kernel size
    uint1 offset = kernel_size / 2;

    // Apply the convolution
    for (uint8 out_c = 0; out_c < out_channels; out_c++) {
        for (uint8 in_c = 0; in_c < in_channels; in_c++) {
            for (uint7 i = offset; i < height + offset; i++) {
                for (uint7 j = offset; j < width + offset; j++) {
                    for (int2 x = -offset; x <= offset; x++) {
                        for (int2 y = -offset; y <= offset; y++) {
                            uint20 in_idx = in_c * padded_height * padded_width + (i + x) * padded_width + (j + y);
                            uint12 filter_idx = out_c * in_channels * filter_size + in_c * filter_size + (x + offset) * kernel_size + (y + offset);
                            uint19 out_idx = out_c * height * width + (i - offset) * width + (j - offset);
                            output[out_idx] += padded_input[in_idx] * filters[filter_idx];
                        }
                    }
                }
            }
        }
    }
}

void conv_transpose2d(input, output, filters, uint8 in_channels, uint7 out_channels, uint6 in_height, uint6 in_width, uint2 kernel_size, uint2 stride) {
    uint7 out_height = in_height * stride;
    uint7 out_width = in_width * stride;
    uint4 filter_size = kernel_size * kernel_size;

    // Perform the transposed convolution
    for (uint7 out_c = 0; out_c < out_channels; out_c++) {
        for (uint8 in_c = 0; in_c < in_channels; in_c++) {
            for (uint6 i = 0; i < in_height; i++) {
                for (uint6 j = 0; j < in_width; j++) {
                    for (uint3 x = 0; x < kernel_size; x++) {
                        for (uint3 y = 0; y < kernel_size; y++) {
                            uint17 in_idx = in_c * in_height * in_width + i * in_width + j;
                            uint17 filter_idx = out_c * in_channels * filter_size + in_c * filter_size + x * kernel_size + y;
                            uint7 out_i = i * stride + x;
                            uint7 out_j = j * stride + y;
                            uint19 out_idx = out_c * out_height * out_width + out_i * out_width + out_j;
                            output[out_idx] += input[in_idx] * filters[filter_idx];
                        }
                    }
                }
            }
        }
    }
}

void concat(input1, input2, output, uint7 channels1, uint7 channels2, uint7 height, uint7 width) {
    uint13 area = height * width;

    // Copy input1 to the output
    for (uint8 c = 0; c < channels1; c++) {
        for (uint13 i = 0; i < area; i++) {
            output[c * area + i] = input1[c * area + i];
        }
    }

    // Copy input2 to the output
    for (uint8 c = 0; c < channels2; c++) {
        for (uint13 i = 0; i < area; i++) {
            output[(channels1 + c) * area + i] = input2[c * area + i];
        }
    }
}

void max_pool2d(input, output, uint7 channels, uint7 height, uint7 width, uint2 pool_size, uint2 stride) {
    uint6 out_height = height / stride;
    uint6 out_width = width / stride;

    ac_fixed<15,9,true> max_val;
    for (uint7 c = 0; c < channels; c++) {
        for (uint66 i = 0; i < out_height; i++) {
            for (uint6 j = 0; j < out_width; j++) {
                for (uint2 x = 0; x < pool_size; x++) {
                    for (uint2 y = 0; y < pool_size; y++) {
                        
                        if (x == 0 && y == 0) {
                            max_val = input[c * height * width + (i * stride + x) * width + (j * stride + y)];
                        } else {
                            ac_fixed<15,9,true> val = input[c * height * width + (i * stride + x) * width + (j * stride + y)];
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
