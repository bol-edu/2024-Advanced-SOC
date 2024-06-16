#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <time.h>
#include "func.h"

#define MAX_CHANNELS 128
#define MAX_HEIGHT 64
#define MAX_WIDTH 64
#define MAX_PADDING 1

float temp_output1[MAX_CHANNELS * MAX_HEIGHT * MAX_WIDTH];
float temp_output2[MAX_CHANNELS * MAX_HEIGHT * MAX_WIDTH];
float padded_input[MAX_CHANNELS * (MAX_HEIGHT + 2 * MAX_PADDING) * (MAX_WIDTH + 2 * MAX_PADDING)];

void batch_norm(float* input, float* output, float* gamma, float* beta, int channels, int height, int width, float epsilon) {
    int num_elements = height * width;

    for (int c = 0; c < channels; c++) {
        float mean = 0.0;
        float var = 0.0;

        // Calculate mean
        for (int i = 0; i < num_elements; i++) {
            mean += input[c * num_elements + i];
        }
        mean /= num_elements;

        // Calculate variance
        for (int i = 0; i < num_elements; i++) {
            var += (input[c * num_elements + i] - mean) * (input[c * num_elements + i] - mean);
        }
        var /= num_elements;

        // Normalize, scale, and shift
        for (int i = 0; i < num_elements; i++) {
            int idx = c * num_elements + i;
            output[idx] = gamma[c] * ((input[idx] - mean) / (float)sqrt((float)(var + epsilon))) + beta[c];
        }
    }
}

void relu(float* input, float* output, int channels, int height, int width) {
    int num_elements = channels * height * width;

    for (int i = 0; i < num_elements; i++) {
        output[i] = (float)fmax((float)0, (float)input[i]);
    }
}

void batch_norm_relu(float* input, float* output, float* gamma, float* beta, int channels, int height, int width, float epsilon) {
    batch_norm(input, temp_output1, gamma, beta, channels, height, width, epsilon);
    relu(temp_output1, output, channels, height, width);
}

void conv_block(float* input, float* output, float* filters, float* gamma, float* beta, int in_channels, int out_channels, int height, int width, int filter_offset, int gamma_offset, int beta_offset) {
    int kernel_size = 3;
    int padding = 1;
    float epsilon = 1e-5;

    conv2d(input, temp_output1, filters + filter_offset, in_channels, out_channels, height, width, kernel_size, padding);
    batch_norm_relu(temp_output1, temp_output2, gamma + gamma_offset, beta + beta_offset, out_channels, height, width, epsilon);

    conv2d(temp_output2, temp_output1, filters + filter_offset + in_channels * out_channels * kernel_size * kernel_size, out_channels, out_channels, height, width, kernel_size, padding);
    batch_norm_relu(temp_output1, output, gamma + gamma_offset + out_channels, beta + beta_offset + out_channels, out_channels, height, width, epsilon);
}

void conv2d(float* input, float* output, float* filters, int in_channels, int out_channels, int height, int width, int kernel_size, int padding) {
    int padded_height = height + 2 * padding;
    int padded_width = width + 2 * padding;
    int filter_size = kernel_size * kernel_size;

    // Copy input to padded input with padding
    for (int c = 0; c < in_channels; c++) {
        for (int h = 0; h < height; h++) {
            memcpy(
                padded_input + c * padded_height * padded_width + (h + padding) * padded_width + padding,
                input + c * height * width + h * width,
                width * sizeof(float)
            );
        }
    }

    // Initialize output to 0.0
    memset(output, 0, out_channels * height * width * sizeof(float));

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

void conv_transpose2d(float* input, float* output, float* filters, int in_channels, int out_channels, int in_height, int in_width, int kernel_size, int stride) {
    int out_height = in_height * stride;
    int out_width = in_width * stride;
    int filter_size = kernel_size * kernel_size;

    // Perform the transposed convolution
    for (int out_c = 0; out_c < out_channels; out_c++) {
        for (int in_c = 0; in_c < in_channels; in_c++) {
            for (int i = 0; i < in_height; i++) {
                for (int j = 0; j < in_width; j++) {
                    for (int x = 0; x < kernel_size; x++) {
                        for (int y = 0; y < kernel_size; y++) {
                            int in_idx = in_c * in_height * in_width + i * in_width + j;
                            int filter_idx = out_c * in_channels * filter_size + in_c * filter_size + x * kernel_size + y;
                            int out_i = i * stride + x;
                            int out_j = j * stride + y;
                            int out_idx = out_c * out_height * out_width + out_i * out_width + out_j;
                            output[out_idx] += input[in_idx] * filters[filter_idx];
                        }
                    }
                }
            }
        }
    }
}

void concat(float* input1, float* input2, float* output, int channels1, int channels2, int height, int width) {
    int area = height * width;

    // Copy input1 to the output
    for (int c = 0; c < channels1; c++) {
        for (int i = 0; i < area; i++) {
            output[c * area + i] = input1[c * area + i];
        }
    }

    // Copy input2 to the output
    for (int c = 0; c < channels2; c++) {
        for (int i = 0; i < area; i++) {
            output[(channels1 + c) * area + i] = input2[c * area + i];
        }
    }
}

void max_pool2d(float* input, float* output, int channels, int height, int width, int pool_size, int stride) {
    int out_height = height / stride;
    int out_width = width / stride;

    for (int c = 0; c < channels; c++) {
        for (int i = 0; i < out_height; i++) {
            for (int j = 0; j < out_width; j++) {
                float max_val = -INFINITY;
                for (int x = 0; x < pool_size; x++) {
                    for (int y = 0; y < pool_size; y++) {
                        int in_idx = c * height * width + (i * stride + x) * width + (j * stride + y);
                        if (input[in_idx] > max_val) {
                            max_val = input[in_idx];
                        }
                    }
                }
                output[c * out_height * out_width + i * out_width + j] = max_val;
            }
        }
    }
}
