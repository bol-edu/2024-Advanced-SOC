#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include <time.h>
#include "func.h"
#include "imgDataSet.h"
#include "filter.h"
#include <iostream>
using namespace std;


typedef struct {
    int in_channels;
    int out_channels;
    int channel_size1;
    int channel_size2;
    int channel_size3;
    int channel_size4;
    int channel_size5;
    float* filters;
    float* gamma;
    float* beta;
} UNet;

void init_unet(UNet* , int , int );
void forward_unet(UNet*, float*, float*, int, int);

int main() {
    srand(time(NULL)); // Seed the random number generator

    // Example usage
    int in_channels = 3;
    int out_channels = 21;
    int height = 64;
    int width = 64;

    UNet unet;
    init_unet(&unet, in_channels, out_channels);

    // float input[in_channels * height * width];
    //float input[3 * 64 * 64];
    float output[out_channels * height * width];

    // Load input image
    float *input = img;
    // Initialize input with random values
    // for (int i = 0; i < in_channels * height * width; i++) {
    //     input[i] = (float)rand() / RAND_MAX;
    // }

    forward_unet(&unet, input, output, height, width);

    // Use the output...
    // for (int i = 0; i < height; i++) {
    //     for (int j = 0; j < width; j++) {
    //         printf("%f,", output[i * width + j]);
    //     }
    //     printf("\n");
    // }
    return 0;
}

void init_unet(UNet* unet, int in_channels, int out_channels) {
    unet->in_channels = 3;
    unet->out_channels = 21;
    unet->channel_size1 = 8;
    unet->channel_size2 = 16;
    unet->channel_size3 = 32;
    unet->channel_size4 = 64;
    unet->channel_size5 = 128;
    int filter_size = 3 * 3;
    int num_filters = (3 * unet->channel_size1 +
        unet->channel_size1 * unet->channel_size1 + //enc1
        unet->channel_size1 * unet->channel_size2 +
        unet->channel_size2 * unet->channel_size2 + //enc2
        unet->channel_size2 * unet->channel_size3 +
        unet->channel_size3 * unet->channel_size3 + //enc3
        unet->channel_size3 * unet->channel_size4 +
        unet->channel_size4 * unet->channel_size4 + //enc4
        unet->channel_size4 * unet->channel_size5 +
        unet->channel_size5 * unet->channel_size5 + //bottleneck
        unet->channel_size5 * unet->channel_size4 +
        unet->channel_size4 * unet->channel_size4 + //dec4
        unet->channel_size4 * unet->channel_size3 +
        unet->channel_size3 * unet->channel_size3 + //dec3
        unet->channel_size3 * unet->channel_size2 +
        unet->channel_size2 * unet->channel_size2 + //dec2
        unet->channel_size2 * unet->channel_size1 +
        unet->channel_size1 * unet->channel_size1   //dec1
        ) * filter_size 
        + (
            unet->channel_size5 * unet->channel_size4 +//upconv4
            unet->channel_size4 * unet->channel_size3 + //upconv3
            unet->channel_size3 * unet->channel_size2 + //upconv2
            unet->channel_size2 * unet->channel_size1 //upconv1
        ) * 4
        + unet->channel_size1 * unet->out_channels  //output
        ;
    int num_gamma_beta = unet->channel_size5 * 2 + unet->channel_size4 * 4 + unet->channel_size3 * 4 + unet->channel_size2 * 4 + unet->channel_size1 * 4;

    cout << "num_filters: " << num_filters << endl;
    cout << "num_gamma_beta: " << num_gamma_beta << endl;
    // unet->filters = (float*)malloc(2 * num_filters * sizeof(float));
    // unet->gamma = (float*)malloc(unet->channel_size5 * 2 * sizeof(float)); // Double for two layers in conv_block
    // unet->beta = (float*)malloc(unet->channel_size5 * 2 * sizeof(float));  // Double for two layers in conv_block
    // float filters[num_filters];
    // float gamma[num_gamma_beta];
    // float beta[num_gamma_beta];
    
    // assign filter values to filters_pretrain
    float *filters = filters_pretrain;
    float *gamma = gamma_pretrain;
    float *beta = beta_pretrain;

    // cout << "filters[1]: " << filters[1] << endl;
    // cout << "filters_pretrain[1]: " << filters_pretrain[1] << endl;

    unet->filters = filters;
    unet->gamma = gamma;
    unet->beta = beta;
    // if (!unet->filters || !unet->gamma || !unet->beta) {
    //     return; // Memory allocation failed
    // }
    // printf("unet->filters:%x, unet->gamma:%x, unet->beta:%x\n", unet->filters, unet->gamma, unet->beta);
    // Initialize filters, gamma, and beta with random values for simplicity

    for (int i = 0; i < unet->channel_size5 * 2; i++) {
        unet->gamma[i] = (float)rand() / RAND_MAX;
        unet->beta[i] = (float)rand() / RAND_MAX;
    }
}

void forward_unet(UNet* unet, float* input, float* output, int height, int width) {
    int pool_size = 2;
    int stride = 2;

    float enc1[unet->channel_size1 * height * width];

    // Encoder
    conv_block(input, enc1, unet->filters, unet->gamma, unet->beta, unet->in_channels, unet->channel_size1, height, width, 0, 0, 0);
    float pooled_enc1[unet->channel_size1 * (height / 2) * (width / 2)];
    max_pool2d(enc1, pooled_enc1, unet->channel_size1, height, width, pool_size, stride);

    int offset1 = unet->in_channels * unet->channel_size1 * 3 * 3 * 2;
    float enc2[unet->channel_size2 * (height / 2) * (width / 2)];
    conv_block(pooled_enc1, enc2, unet->filters, unet->gamma, unet->beta, unet->channel_size1, unet->channel_size2, height / 2, width / 2, offset1, unet->channel_size1 * 2, unet->channel_size1 * 2);
    float pooled_enc2[unet->channel_size2 * (height / 4) * (width / 4)];
    max_pool2d(enc2, pooled_enc2, unet->channel_size2, height / 2, width / 2, pool_size, stride);

    int offset2 = offset1 + unet->channel_size1 * unet->channel_size2 * 3 * 3 * 2;
    float enc3[unet->channel_size3 * (height / 4) * (width / 4)];
    conv_block(pooled_enc2, enc3, unet->filters, unet->gamma, unet->beta, unet->channel_size2, unet->channel_size3, height / 4, width / 4, offset2, unet->channel_size1 * 2 + unet->channel_size2 * 2, unet->channel_size1 * 2 + unet->channel_size2 * 2);
    float pooled_enc3[unet->channel_size3 * (height / 8) * (width / 8)];
    max_pool2d(enc3, pooled_enc3, unet->channel_size3, height / 4, width / 4, pool_size, stride);

    int offset3 = offset2 + unet->channel_size2 * unet->channel_size3 * 3 * 3 * 2;
    float enc4[unet->channel_size4 * (height / 8) * (width / 8)];
    conv_block(pooled_enc3, enc4, unet->filters, unet->gamma, unet->beta, unet->channel_size3, unet->channel_size4, height / 8, width / 8, offset3, unet->channel_size1 * 2 + unet->channel_size2 * 2 + unet->channel_size3 * 2, unet->channel_size1 * 2 + unet->channel_size2 * 2 + unet->channel_size3 * 2);
    float pooled_enc4[unet->channel_size4 * (height / 16) * (width / 16)];
    max_pool2d(enc4, pooled_enc4, unet->channel_size4, height / 8, width / 8, pool_size, stride);

    int offset4 = offset3 + unet->channel_size3 * unet->channel_size4 * 3 * 3 * 2;
    float bottleneck[unet->channel_size5 * (height / 16) * (width / 16)];
    conv_block(pooled_enc4, bottleneck, unet->filters, unet->gamma, unet->beta, unet->channel_size4, unet->channel_size5, height / 16, width / 16, offset4, unet->channel_size1 * 2 + unet->channel_size2 * 2 + unet->channel_size3 * 2 + unet->channel_size4 * 2, unet->channel_size1 * 2 + unet->channel_size2 * 2 + unet->channel_size3 * 2 + unet->channel_size4 * 2);

    // Decoder
    float upconv4_output[unet->channel_size4 * (height / 8) * (width / 8)];
    int trans_offset4 = offset4 + unet->channel_size4 * unet->channel_size5 * 3 * 3 * 2;
    conv_transpose2d(bottleneck, upconv4_output, unet->filters + trans_offset4, unet->channel_size5, unet->channel_size4, height / 16, width / 16, 2, 2);
    float dec4[unet->channel_size4 * (height / 8) * (width / 8)];
    concat(upconv4_output, enc4, dec4, unet->channel_size4, unet->channel_size4, height / 8, width / 8);
    int dec_offset4 = trans_offset4 + unet->channel_size5 * unet->channel_size4 * 2 * 2;
    conv_block(dec4, dec4, unet->filters, unet->gamma, unet->beta, unet->channel_size4 * 2, unet->channel_size4, height / 8, width / 8, dec_offset4, unet->channel_size1 * 2 + unet->channel_size2 * 2 + unet->channel_size3 * 2 + unet->channel_size4 * 2 + unet->channel_size5 * 2, unet->channel_size1 * 2 + unet->channel_size2 * 2 + unet->channel_size3 * 2 + unet->channel_size4 * 2 + unet->channel_size5 * 2);

    float upconv3_output[unet->channel_size3 * (height / 4) * (width / 4)];
    int trans_offset3 = dec_offset4 + unet->channel_size4 * unet->channel_size3 * 3 * 3 * 2;
    conv_transpose2d(dec4, upconv3_output, unet->filters + trans_offset3, unet->channel_size4, unet->channel_size3, height / 8, width / 8, 2, 2);
    float dec3[unet->channel_size3 * (height / 4) * (width / 4)];
    concat(upconv3_output, enc3, dec3, unet->channel_size3, unet->channel_size3, height / 4, width / 4);
    int dec_offset3 = trans_offset3 + unet->channel_size4 * unet->channel_size3 * 2 * 2;
    conv_block(dec3, dec3, unet->filters, unet->gamma, unet->beta, unet->channel_size3 * 2, unet->channel_size3, height / 4, width / 4, dec_offset3, unet->channel_size1 * 2 + unet->channel_size2 * 2 + unet->channel_size3 * 2 + unet->channel_size4 * 2 + unet->channel_size5 * 2 + unet->channel_size4 * 2, unet->channel_size1 * 2 + unet->channel_size2 * 2 + unet->channel_size3 * 2 + unet->channel_size4 * 2 + unet->channel_size5 * 2 + unet->channel_size4 * 2);

    float upconv2_output[unet->channel_size2 * (height / 2) * (width / 2)];
    int trans_offset2 = dec_offset3 + unet->channel_size3 * unet->channel_size2 * 3 * 3 * 2;
    conv_transpose2d(dec3, upconv2_output, unet->filters + trans_offset2, unet->channel_size3, unet->channel_size2, height / 4, width / 4, 2, 2);
    float dec2[unet->channel_size2 * (height / 2) * (width / 2)];
    concat(upconv2_output, enc2, dec2, unet->channel_size2, unet->channel_size2, height / 2, width / 2);
    int dec_offset2 = trans_offset2 + unet->channel_size3 * unet->channel_size2 * 2 * 2;
    conv_block(dec2, dec2, unet->filters, unet->gamma, unet->beta, unet->channel_size2 * 2, unet->channel_size2, height / 2, width / 2, dec_offset2, unet->channel_size1 * 2 + unet->channel_size2 * 2 + unet->channel_size3 * 2 + unet->channel_size4 * 2 + unet->channel_size5 * 2 + unet->channel_size4 * 2 + unet->channel_size3 * 2, unet->channel_size1 * 2 + unet->channel_size2 * 2 + unet->channel_size3 * 2 + unet->channel_size4 * 2 + unet->channel_size5 * 2 + unet->channel_size4 * 2 + unet->channel_size3 * 2);

    float upconv1_output[unet->channel_size1 * height * width];
    int trans_offset1 = dec_offset2 + unet->channel_size2 * unet->channel_size1 * 3 * 3 * 2;
    conv_transpose2d(dec2, upconv1_output, unet->filters + trans_offset1, unet->channel_size2, unet->channel_size1, height / 2, width / 2, 2, 2);
    float dec1[unet->channel_size1 * height * width];
    concat(upconv1_output, enc1, dec1, unet->channel_size1, unet->channel_size1, height, width);
    int dec_offset1 = trans_offset1 + unet->channel_size2 * unet->channel_size1 * 2 * 2;
    conv_block(dec1, dec1, unet->filters, unet->gamma, unet->beta, unet->channel_size1 * 2, unet->channel_size1, height, width, dec_offset1, unet->channel_size1 * 2 + unet->channel_size2 * 2 + unet->channel_size3 * 2 + unet->channel_size4 * 2 + unet->channel_size5 * 2 + unet->channel_size4 * 2 + unet->channel_size3 * 2 + unet->channel_size2 * 2, unet->channel_size1 * 2 + unet->channel_size2 * 2 + unet->channel_size3 * 2 + unet->channel_size4 * 2 + unet->channel_size5 * 2 + unet->channel_size4 * 2 + unet->channel_size3 * 2 + unet->channel_size2 * 2);

    // Output
    int final_offset = dec_offset1 + unet->channel_size1 * unet->channel_size1 * 3 * 3 * 2;
    conv2d(dec1, output, unet->filters + final_offset, unet->channel_size1, unet->out_channels, height, width, 1, 0);

    cout << "final_offset: " << final_offset << endl;

}