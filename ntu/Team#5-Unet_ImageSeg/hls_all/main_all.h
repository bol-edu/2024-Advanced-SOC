#pragma once

#include <ac_int.h>
#include <ac_channel.h>
#include <mc_scverify.h>
#include <ac_fixed.h>
#include <defs.h>

namespace UNET_IP 
{

#pragma hls_design top
class main{

    // filter memory
    // filterType filters[485120];
    // filterType gamma[736];
    // filterType beta[736];

    // buffer memory
    bufType buf1[64*64*8];
    bufType padded_input[66*66*3];
    bufType buf2[64*64*8];

    // concat buffer memory
    bufType enc1 [64*64*8];
    // bufType enc2 [32*32*16];
    // bufType enc3 [16*16*32];
    // bufType enc4 [8*8*64],;


    public:
    main() {}
    #pragma hls_design interface
     void CCS_BLOCK(run)(
                        ac_channel<bufType> &input,
                        ac_channel<bufType> &output
                        ) 
    {   
    ac_int <20, false> i;
    for (i = 0; i<3*64*64; i++){
        buf1[i] = input.read();
    }

    ac_int<20, false> filter_offset = 0;
    ac_int<10, false> gamma_offset = 0;
    ac_int<7, false> height = 64;
    ac_int<7, false> width = 64;
    ac_int<2, false> kernel_size = 3;
    ac_int<2, false> padding = 1;
    ac_int<7, false> in_channels = 3;
    ac_int<7, false> out_channels = 8;
    ac_int<3, false> stride = 2;
    ac_int<3, false> pool_size = 2;
    ac_int<2, false> kernel_size_trans = 2;
    ac_int<8, false> padded_height;
    ac_int<8, false> padded_width;

    ac_int<8, false> filter_size_conv = 9;
    ac_int<8, false> filter_size_trans = 4;

    // Define the loop variables
    ac_int<8, false> out_c;
    ac_int<8, false> in_c;
    ac_int<7, false> j;
    ac_int<3, true> x;
    ac_int<3, true> y;
    ac_int<20, false> in_idx;
    ac_int<20, false> filter_idx;
    ac_int<20, false> out_idx;
    ac_fixed<13, 7, true> temp;

    //enc1

    //conv2d
    padded_height = height + 2 * padding;
    padded_width = width + 2 * padding;
    ac_int<2, false> offset = kernel_size / 2;
    for (out_c = 0; out_c < in_channels; out_c++) {
        for (i = 0; i < height; i++) {
            #pragma hls_pipeline_init_interval 1
            for (j = 0; j < width; j++) {
                padded_input[out_c * padded_height * padded_width + (i + padding) * padded_width + padding + j] = buf1[out_c * height * width + i * width + j];
            }
        }
    }

    
    for (out_c = 0; out_c < out_channels; out_c++) {
        for (in_c = 0; in_c < in_channels; in_c++) {
            for (i = offset; i < height + offset; i++) {
                for (j = offset; j < width + offset; j++) {
                    out_idx = out_c * height * width + (i - offset) * width + (j - offset);
                    temp = 0;
                    for ( x = -offset; x <= offset; x++) {
                        #pragma hls_pipeline_init_interval 1
                        for (y = -offset; y <= offset; y++) {
                            
                            in_idx = in_c * padded_height * padded_width + (i + x) * padded_width + (j + y);
                            filter_idx = out_c * in_channels * filter_size_conv + in_c * filter_size_conv + (x + offset) * kernel_size + (y + offset) + filter_offset;
                            temp += padded_input[in_idx] * filters_pretrain[filter_idx];
                        }
                    }
                    buf2[out_idx] = temp;
                }
            }
        }
    }

    //batchnorm_relu
    ac_int<13, false> num_elements = height * width;
    ac_fixed<17,0,false> epsilon = 1e-5;
    ac_fixed<14,8,false>  mean;
    ac_fixed<22,16,false> var;
    ac_fixed<20,8,false> mean_tmp;
    ac_fixed<34,16,false> var_tmp;
    ac_int<20, false> idx;
    ac_fixed<14,8,false> var_sqrt;
    ac_fixed<22,17,false> sum;
    ac_fixed<40,20,false> out_tmp;


    for (out_c = 0; out_c < out_channels; out_c++) {
        mean     = 0;
        var      = 0;
        mean_tmp = 0;
        var_tmp  = 0;
        

        // Calculate mean
        #pragma hls_pipeline_init_interval 1
        for (i = 0; i < num_elements; i++) {
            
            mean_tmp += buf2[out_c * num_elements + i];
        }
        mean = mean_tmp / num_elements;

        // Calculate variance
        #pragma hls_pipeline_init_interval 1
        for (i = 0; i < num_elements; i++) {
            
            var_tmp += (buf2[out_c * num_elements + i] - mean) * (buf2[out_c * num_elements + i] - mean);
        }
        var= var_tmp / num_elements;
        // Normalize, scale, and shift
        for (i = 0; i < num_elements; i++) {
            idx = out_c * num_elements + i;
            sum = var + epsilon;
            ac_math::ac_sqrt_pwl(sum, var_sqrt);
            out_tmp = gamma_pretrain[out_c+ gamma_offset] * ((buf2[idx] - mean) / var_sqrt) + beta_pretrain[out_c + gamma_offset];
            buf1[idx] = (out_tmp > 0) ? out_tmp : 0;
        }
    }
    filter_offset += 8*3*3*3;
    gamma_offset += 8;

    //conv2d
    in_channels = 8;
    out_channels = 8;

    padded_height = height + 2 * padding;
    padded_width = width + 2 * padding;
    for (out_c = 0; out_c < in_channels; out_c++) {
        for (i = 0; i < height; i++) {
            #pragma hls_pipeline_init_interval 1
            for (j = 0; j < width; j++) {
                padded_input[out_c * padded_height * padded_width + (i + padding) * padded_width + padding + j] = buf1[out_c * height * width + i * width + j];
            }
        }
    }

    for (out_c = 0; out_c < out_channels; out_c++) {
        for (in_c = 0; in_c < in_channels; in_c++) {
            for (i = offset; i < height + offset; i++) {
                for (j = offset; j < width + offset; j++) {
                    out_idx = out_c * height * width + (i - offset) * width + (j - offset);
                    temp = 0;
                    for ( x = -offset; x <= offset; x++) {
                        #pragma hls_pipeline_init_interval 1
                        for (y = -offset; y <= offset; y++) {
                            in_idx = in_c * padded_height * padded_width + (i + x) * padded_width + (j + y);
                            filter_idx = out_c * in_channels * filter_size_conv + in_c * filter_size_conv + (x + offset) * kernel_size + (y + offset) + filter_offset;
                            temp += padded_input[in_idx] * filters_pretrain[filter_idx];
                        }
                    }
                    buf2[out_idx] = temp;
                }
            }
        }
    }

    //batchnorm_relu
    num_elements = height * width;
    epsilon = 1e-5;

    for (out_c = 0; out_c < out_channels; out_c++) {
        mean     = 0;
        var      = 0;
        mean_tmp = 0;
        var_tmp  = 0;
        

        // Calculate mean
        #pragma hls_pipeline_init_interval 1
        for (i = 0; i < num_elements; i++) {
            mean_tmp += buf2[out_c * num_elements + i];
        }
        mean = mean_tmp / num_elements;

        // Calculate variance
        #pragma hls_pipeline_init_interval 1
        for (i = 0; i < num_elements; i++) {
            var_tmp += (buf2[out_c * num_elements + i] - mean) * (buf2[out_c * num_elements + i] - mean);
        }
        var= var_tmp / num_elements;
        // Normalize, scale, and shift
        for (i = 0; i < num_elements; i++) {
            idx = out_c * num_elements + i;
            sum = var + epsilon;
            ac_math::ac_sqrt_pwl(sum, var_sqrt);
            out_tmp = gamma_pretrain[out_c+ gamma_offset] * ((buf2[idx] - mean) / var_sqrt) + beta_pretrain[out_c+ gamma_offset];
            enc1[idx] = (out_tmp > 0) ? out_tmp : 0;
        }
    }

    //maxpool

    ac_int<7, false> out_height = height / stride;
    ac_int<7, false> out_width = width / stride;
    ac_fixed<15,9,true> max_val;
    ac_fixed<15,9,true> val;

    for (out_c = 0; out_c < out_channels; out_c++) {
        for (i = 0; i < out_height; i++) {
            for (j = 0; j < out_width; j++) {
                for (x = 0; x < pool_size; x++) {
                    #pragma hls_pipeline_init_interval 1
                    for (y = 0; y < pool_size; y++) {
                        if (x == 0 && y == 0) {
                            max_val = enc1[out_c * height * width + (i * stride + x) * width + (j * stride + y)];
                        } else {
                            val = enc1[out_c * height * width + (i * stride + x) * width + (j * stride + y)];
                            if (val > max_val) {
                                max_val = val;
                            }
                        }
                    }
                }
                buf1[out_c * out_height * out_width + i * out_width + j] = max_val;
            }
        }
    }

    for (i = 0; i<3*64*64; i++){
        output.write(buf1[i]);
    }
    }
  

};

}