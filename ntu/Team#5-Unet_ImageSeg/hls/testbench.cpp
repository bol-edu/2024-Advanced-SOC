#include <stdio.h>
#include <stdlib.h>

#include<func_hls.c>
#include<func.c>
#include "imgDataSet.h"

#include<iostream>
#include<fstream>
#include<cstdlib>
#include<cmath>

int main(){
    int in_channels = 3;
    int channel_size5 = 128;
    int out_channels = 21;
    int height = 64;
    int width = 64;

    ac_fixed<15,9,true> in_hls[MAX_CHANNELS * MAX_HEIGHT * MAX_WIDTH];
    ac_fixed<15,9,true> out_hls[MAX_CHANNELS * MAX_HEIGHT * MAX_WIDTH];
    ac_fixed<17,1,false> gamma_hls[channel_size5 * 2];
    ac_fixed<17,1,false> beta_hls[channel_size5 * 2];
    float in_c[MAX_CHANNELS * MAX_HEIGHT * MAX_WIDTH] = img;
    float out_c[MAX_CHANNELS * MAX_HEIGHT * MAX_WIDTH];
    float gamma_c[channel_size5 * 2];
    float beta_c[channel_size5 * 2];
    float epsilon = 1e-5;
    

    for(unsigned int c = 0, c < in_channels, c++){
        for(unsigned int h = 0, h < height, h++){
            for(unsigned int w = 0, w < width, w++){
                int in_idx = c * height * width + h * height + w;
                in_hls[in_idx] = img[in_idx];
            }
        }
    }

    for (int i = 0; i < channel_size5 * 2; i++) {
        gamma_c[i] = (float)rand() / RAND_MAX;
        beta_c[i] = (float)rand() / RAND_MAX;
        gamma_hls[i] = gamma_c[i];
        beta_hls[i] = beta_c[i];
    }

    void batch_norm(in_hls, out_hls, gamma_hls, beta_hls, in_channels, height, width, epsilon);
    void batch_norm(in_c, out_c, gamma_c, beta_c, in_channels, height, width, epsilon)

    
}
