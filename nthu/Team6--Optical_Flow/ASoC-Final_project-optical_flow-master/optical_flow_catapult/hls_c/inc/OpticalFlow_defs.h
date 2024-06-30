
#pragma once

#include <ac_int.h>
#include <ac_fixed.h>
#include <ac_channel.h>
#include <ac_math/ac_sqrt_pwl.h>
#include <ac_math/ac_atan2_cordic.h>

#define TARGET_X 150 //343 //25 //592 //371 //586 //358 // 354
#define TARGET_Y 150 //128 //38 //223 //147 //150 //250 // 277

const int MAX_HEIGHT = 436;
const int MAX_WIDTH = 1024;
const int INPUT_T_BIT_WIDTH = 8; //17;
const int INPUT_T_INTEGER_PART = 8; //9;
const int PIXEL_T_BIT_WIDTH = 32;
const int PIXEL_T_INTEGER_PART = 13; //13;
const int OUTER_PIXEL_T_BIT_WIDTH = 64; //32;
const int OUTER_PIXEL_T_INTEGER_PART = 32; //27; // need to be an "even" number because we have "OUTER_PIXEL_T_INTEGER_PART/2"
const int VEL_PIXEL_T_BIT_WIDTH = OUTER_PIXEL_T_INTEGER_PART*2; //32;
//const int VEL_PIXEL_T_INTEGER_PART = 32; //13;
const int TENSOR_LONG_PIXEL_T_BIT_WIDTH = OUTER_PIXEL_T_BIT_WIDTH+32; // "32" is from the bit number of "TENSOR_FILTER"


// basic typedefs
typedef ac_fixed<INPUT_T_BIT_WIDTH, INPUT_T_INTEGER_PART, false, AC_RND, AC_WRAP> input_t; // Integer part: 9 ; Decimal part: 8 ; signed
//typedef ac_fixed<34,18, true, AC_TRN, AC_WRAP> input2x_t; // For ping-pong buffer
typedef ac_int<INPUT_T_BIT_WIDTH> input1x_t; // For ping-pong buffer
typedef ac_int<INPUT_T_BIT_WIDTH*2> input2x_t; // For ping-pong buffer
typedef ac_int<INPUT_T_BIT_WIDTH*4> input4x_t; // For ping-pong buffer
typedef ac_int<INPUT_T_BIT_WIDTH*8> input8x_t; // For ping-pong buffer
typedef ac_fixed<PIXEL_T_BIT_WIDTH,PIXEL_T_INTEGER_PART, true, AC_RND, AC_WRAP> pixel_t; // Integer part: 13 ; Decimal part: 19 ; signed
//typedef ac_fixed<64,26, true, AC_TRN, AC_WRAP> pixel2x_t; // For ping-pong buffer
typedef ac_int<PIXEL_T_BIT_WIDTH> pixel1x_t; // For ping-pong buffer
typedef ac_int<PIXEL_T_BIT_WIDTH*2> pixel2x_t; // For ping-pong buffer

typedef ac_fixed<OUTER_PIXEL_T_BIT_WIDTH,OUTER_PIXEL_T_INTEGER_PART, true, AC_RND, AC_WRAP> outer_pixel_t; // Integer part: 27 ; Decimal part: 5 ; signed
typedef ac_int<OUTER_PIXEL_T_BIT_WIDTH*6> outer1x_t; // For ping-pong buffer, multiplied by "6" is because outer_t type has 6 components of type outer_pixel_t
typedef ac_int<OUTER_PIXEL_T_BIT_WIDTH*12> outer2x_t; // For ping-pong buffer
/////typedef ac_fixed<64,56, true, AC_TRN, AC_WRAP> calc_pixel_t; // Integer part: 56 ; Decimal part: 8 ; signed
typedef ac_int<OUTER_PIXEL_T_INTEGER_PART> tensor_int_pixel_t;
typedef ac_int<OUTER_PIXEL_T_INTEGER_PART/2> tensor_int_half_pixel_t;
/////typedef ac_fixed<VEL_PIXEL_T_BIT_WIDTH,VEL_PIXEL_T_INTEGER_PART, true, AC_TRN, AC_WRAP> vel_pixel_t; // Integer part: 13 ; Decimal part: 19 ; signed
typedef ac_int<VEL_PIXEL_T_BIT_WIDTH> vel_pixel_t;
typedef ac_int<ac::nbits<TENSOR_LONG_PIXEL_T_BIT_WIDTH*2+VEL_PIXEL_T_BIT_WIDTH>::val,false> shift_t; // which is ac_int<8>
typedef ac_fixed<TENSOR_LONG_PIXEL_T_BIT_WIDTH,OUTER_PIXEL_T_INTEGER_PART, true, AC_RND, AC_WRAP> tensor_long_pixel_t;
typedef ac_int<32> output_stream_t;

typedef struct{
	pixel_t x;
	pixel_t y;
	pixel_t z;
}gradient_t;

typedef struct{
    outer_pixel_t val[6];
}outer_t; 

typedef struct{
    outer_pixel_t val[6];
}tensor_t;

typedef struct{
    tensor_int_pixel_t val[6];
}tensor_int_t;

///////typedef struct{
///////    tensor_int_half_pixel_t val[6];
///////}tensor_int_half_t;

typedef struct{
    tensor_long_pixel_t val[6];
}tensor_long_t;

typedef struct{
    vel_pixel_t x;
    vel_pixel_t y;
}velocity_t;

// for data packing
////////typedef ac_int<64, false> frames_t;
typedef ac_int<32, false> frames_t;

// Compute number of bits for max image size count, used internally and in testbench
typedef ac_int<ac::nbits<MAX_WIDTH+1>::val,false> maxWType;
typedef ac_int<ac::nbits<MAX_HEIGHT+1>::val,false> maxHType;

// convolution filters
//const int GRAD_WEIGHTS[7] =  {1,-8,0,8,-1};
const ac_fixed<32, 2, true, AC_RND, AC_WRAP> GRAD_WEIGHTS[5] =  {0.0833,-0.6667,0,0.6667,-0.0833}; //{1/12,-8/12,0/12,8/12,-1/12};
const ac_fixed<32, 2, true, AC_RND, AC_WRAP> GRAD_WEIGHTS_Z[4] =  {0.0833,-0.6667,0.6667,-0.0833};
//const pixel_t GRAD_FILTER[7] = {0.0755, 0.133, 0.1869, 0.2903, 0.1869, 0.133, 0.0755};
const ac_fixed<32, 1, false, AC_RND, AC_WRAP> GRAD_FILTER[7] = {0.0755, 0.133, 0.1869, 0.2903, 0.1869, 0.133, 0.0755};
//const pixel_t TENSOR_FILTER[3] = {0.3243, 0.3513, 0.3243};
const ac_fixed<32, 1, false, AC_RND, AC_WRAP> TENSOR_FILTER[3] = {0.3243, 0.3513, 0.3243}; // Remember that we have TENSOR_FILTER_int_version in OpticalFlow_tensor_weight_x.h. Don't forget to change its bit number !!!

//ac_int<32> TENSOR_FILTER_INT_VERSION[3];
