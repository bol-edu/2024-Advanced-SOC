#pragma once

#include <ac_int.h>
#include <ac_channel.h>
#include <mc_scverify.h>
#include <ac_fixed.h>
#include <conv2d.h>
#include <maxpool.h>
#include <batchnorm_relu.h>
#include <tranconv2d.h>
#include <defs.h>

namespace UNET_IP 
{

#pragma hls_design top
class main{

    //instances
    conv2d conv2d_inst;
    batchnorm_relu batchnorm_relu_inst;
    maxpool maxpool_inst;
    tranconv2d tranconv2d_inst;

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
    //enc1
    padded_height = height + 2 * padding;
    padded_width = width + 2 * padding;
    for (ac_int<8, false> c = 0; c < in_channels; c++) {
        for (ac_int<7, false> h = 0; h < height; h++) {
            #pragma hls_pipeline_init_interval 1
            for (ac_int<7, false> w = 0; w < width; w++) {
                padded_input[c * padded_height * padded_width + (h + padding) * padded_width + padding + w] = buf1[c * height * width + h * width + w];
            }
        }
    }

    //conv2d : input, padded_input, output, height, width, kernel_size, padding, filter_offset, in_channels, out_channels
    //conv2d_inst.run_conv(buf1, buf2, 64, 64, 3, 1, 0, 3, 8);
    conv2d_inst.run_conv(buf1, buf2, height, width, kernel_size, padding, filter_offset, in_channels, out_channels);
    //batchnorm_relu : input, output, gamma, beta, channels, height, width, offset
    //batchnorm_relu_inst.run_batch(buf2, buf1, 8, 64, 64, 0);
    batchnorm_relu_inst.run_batch(buf2, buf1, out_channels, height, width, gamma_offset);
    filter_offset += 8*3*3*3;
    gamma_offset += 8;

    // conv2d_inst.run_conv(buf1, buf2, 64, 64, 3, 1, filter_offset, 8, 8);
    // batchnorm_relu_inst.run_batch(buf2, enc1, 8, 64, 64, gamma_offset);
    padded_height = height + 2 * padding;
    padded_width = width + 2 * padding;
    for (ac_int<8, false> c = 0; c < in_channels; c++) {
        for (ac_int<7, false> h = 0; h < height; h++) {
            #pragma hls_pipeline_init_interval 1
            for (ac_int<7, false> w = 0; w < width; w++) {
                padded_input[c * padded_height * padded_width + (h + padding) * padded_width + padding + w] = buf1[c * height * width + h * width + w];
            }
        }
    }
    conv2d_inst.run_conv(buf1, buf2, height, width, kernel_size, padding, filter_offset, out_channels, out_channels);
    batchnorm_relu_inst.run_batch(buf2, enc1, out_channels, height, width, gamma_offset);
    filter_offset += 8*8*3*3;
    gamma_offset += 8;
    //maxpool : input, output,channels, height, width,  pool_size, stride
    maxpool_inst.run_max(enc1, buf1, out_channels, height, width, pool_size, stride);

    for (i = 0; i<32*32*8; i++){
        output.write(buf1[i]);
    }

    // height = 32;
    // width = 32;
    // in_channels = 8;
    // out_channels = 16;

    // //enc2
    // conv2d_inst.run_conv(buf1, buf2, height, width, kernel_size, padding, filter_offset, in_channels, out_channels);
    // batchnorm_relu_inst.run_batch(buf2, buf1, out_channels, height, width, gamma_offset);
    // filter_offset += 16*8*3*3;
    // gamma_offset += 16;

    // conv2d_inst.run_conv(buf1, buf2, height, width, kernel_size, padding, filter_offset, out_channels, out_channels);
    // batchnorm_relu_inst.run_batch(buf2, enc2, out_channels, height, width, gamma_offset);
    // filter_offset += 16*16*3*3;
    // gamma_offset += 16;
    // maxpool_inst.run_max(enc2, buf1, out_channels, height, width, pool_size, stride);

    // height = 16;
    // width = 16;
    // in_channels = 16;
    // out_channels = 32;

    // //enc3
    // conv2d_inst.run_conv(buf1, buf2, height, width, kernel_size, padding, filter_offset, in_channels, out_channels);
    // batchnorm_relu_inst.run_batch(buf2, buf1, out_channels, height, width, gamma_offset);
    // filter_offset += 32*16*3*3;
    // gamma_offset += 32;

    // conv2d_inst.run_conv(buf1, buf2, height, width, kernel_size, padding, filter_offset, out_channels, out_channels);
    // batchnorm_relu_inst.run_batch(buf2, enc3, out_channels, height, width, gamma_offset);
    // filter_offset += 32*32*3*3;
    // gamma_offset += 32;
    // maxpool_inst.run_max(enc3, buf1, out_channels, height, width, pool_size, stride);

    // height = 8;
    // width = 8;
    // in_channels = 32;
    // out_channels = 64;

    // //enc4
    // conv2d_inst.run_conv(buf1, buf2, height, width, kernel_size, padding, filter_offset, in_channels, out_channels);
    // batchnorm_relu_inst.run_batch(buf2, buf1, out_channels, height, width, gamma_offset);
    // filter_offset += 64*32*3*3;
    // gamma_offset += 64;

    // conv2d_inst.run_conv(buf1, buf2, height, width, kernel_size, padding, filter_offset, out_channels, out_channels);
    // batchnorm_relu_inst.run_batch(buf2, enc4, out_channels, height, width, gamma_offset);
    // filter_offset += 64*64*3*3;
    // gamma_offset += 64;
    // maxpool_inst.run_max(enc4, buf1, out_channels, height, width, pool_size, stride);

    // height = 4;
    // width = 4;
    // in_channels = 64;
    // out_channels = 128;

    // //bottleneck
    // conv2d_inst.run_conv(buf1, buf2, height, width, kernel_size, padding, filter_offset, in_channels, out_channels);
    // batchnorm_relu_inst.run_batch(buf2, buf1, out_channels, height, width, gamma_offset);
    // filter_offset += 128*64*3*3;
    // gamma_offset += 128;

    // conv2d_inst.run_conv(buf1, buf2, height, width, kernel_size, padding, filter_offset, out_channels, out_channels);
    // batchnorm_relu_inst.run_batch(buf2, buf1, out_channels, height, width, gamma_offset);
    // filter_offset += 128*128*3*3;
    // gamma_offset += 128;

    // height = 4;
    // width = 4;
    // in_channels = 128;
    // out_channels = 64;

    // //dec4
    // //tranconv2d : input, output, filters, height, width, kernel_size, filter_offset, in_channels, out_channels, stride
    // tranconv2d_inst.run_tran(buf1, buf2, height, width, kernel_size_trans, filter_offset, in_channels, out_channels, stride);
    // filter_offset += 64*128*2*2;
    // //concat
    // for (i = 8*8*64; i<8*8*64*2; i++){
    //     buf2[i] = enc4[i-8*8*64];
    // }

    // height = 8;
    // width = 8;
    // in_channels = 128;
    // out_channels = 64;

    // //conv2d : input, padded_input, output, filters, height, width, kernel_size, padding, filter_offset, in_channels, out_channels
    // conv2d_inst.run_conv(buf2, buf1, height, width, kernel_size, padding, filter_offset, in_channels, out_channels);
    // batchnorm_relu_inst.run_batch(buf1, buf2, out_channels, height, width, gamma_offset);
    // filter_offset += 64*128*3*3;
    // gamma_offset += 64;

    // conv2d_inst.run_conv(buf2, buf1, height, width, kernel_size, padding, filter_offset, out_channels, out_channels);
    // batchnorm_relu_inst.run_batch(buf1, buf2, out_channels, height, width, gamma_offset);
    // filter_offset += 64*64*3*3;
    // gamma_offset += 64;

    // height = 8;
    // width = 8;
    // in_channels = 64;
    // out_channels = 32;

    // //dec3
    // tranconv2d_inst.run_tran(buf2, buf1, height, width, kernel_size_trans, filter_offset, in_channels, out_channels, stride);
    // for (i = 16*16*32; i<16*16*32*2; i++){
    //     buf1[i] = enc3[i-16*16*32];
    // }
    // filter_offset += 32*64*2*2;

    // height = 16;
    // width = 16;
    // in_channels = 64;
    // out_channels = 32;

    // conv2d_inst.run_conv(buf1, buf2, height, width, kernel_size, padding, filter_offset, in_channels, out_channels);
    // batchnorm_relu_inst.run_batch(buf2, buf1, out_channels, height, width, gamma_offset);
    // filter_offset += 32*64*3*3;
    // gamma_offset += 32;

    // conv2d_inst.run_conv(buf1, buf2, height, width, kernel_size, padding, filter_offset, out_channels, out_channels);
    // batchnorm_relu_inst.run_batch(buf2, buf1, out_channels, height, width, gamma_offset);
    // filter_offset += 32*32*3*3;
    // gamma_offset += 32;

    // height = 16;
    // width = 16;
    // in_channels = 32;
    // out_channels = 16;

    // //dec2
    // tranconv2d_inst.run_tran(buf1, buf2, height, width, kernel_size_trans, filter_offset, in_channels, out_channels, stride);
    // for (i = 32*32*16; i<32*32*16*2; i++){
    //     buf2[i] = enc2[i-32*32*16];
    // }
    // filter_offset += 16*32*2*2;

    // height = 32;
    // width = 32;
    // in_channels = 32;
    // out_channels = 16;

    // conv2d_inst.run_conv(buf2, buf1, height, width, kernel_size, padding, filter_offset, in_channels, out_channels);
    // batchnorm_relu_inst.run_batch(buf1, buf2, out_channels, height, width, gamma_offset);
    // filter_offset += 16*32*3*3;
    // gamma_offset += 16;

    // conv2d_inst.run_conv(buf2, buf1, height, width, kernel_size, padding, filter_offset, out_channels, out_channels);
    // batchnorm_relu_inst.run_batch(buf1, buf2, out_channels, height, width, gamma_offset);
    // filter_offset += 16*16*3*3;
    // gamma_offset += 16;

    // height = 32;
    // width = 32;
    // in_channels = 16;
    // out_channels = 8;

    // //dec1
    // tranconv2d_inst.run_tran(buf2, buf1, height, width, kernel_size_trans, filter_offset, in_channels, out_channels, stride);
    // for (i = 64*64*8; i<64*64*8*2; i++){
    //     buf1[i] = enc1[i-64*64*8];
    // }
    // filter_offset += 8*16*2*2;

    // height = 64;
    // width = 64;
    // in_channels = 16;
    // out_channels = 8;

    // conv2d_inst.run_conv(buf1, buf2, height, width, kernel_size, padding, filter_offset, in_channels, out_channels);
    // batchnorm_relu_inst.run_batch(buf2, buf1, out_channels, height, width, gamma_offset);
    // filter_offset += 8*16*3*3;
    // gamma_offset += 8;

    // conv2d_inst.run_conv(buf1, buf2, height, width, kernel_size, padding, filter_offset, out_channels, out_channels);
    // batchnorm_relu_inst.run_batch(buf2, buf1, out_channels, height, width, gamma_offset);
    // filter_offset += 8*8*3*3;
    // gamma_offset += 8;

    // width = 64;
    // height = 64;
    // in_channels = 8;
    // out_channels = 21;

    // //output
    // conv2d_inst.run_conv(buf1, buf2, height, width, kernel_size, padding, filter_offset, in_channels, out_channels);

    for (i = 0; i<64*64*21; i++){
        output.write(buf2[i]);
    }
    }
  

};

}