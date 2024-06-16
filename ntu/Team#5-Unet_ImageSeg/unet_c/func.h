#pragma once
#ifndef __FUNC_H__
#define __FUNC_H__

extern void batch_norm(float* , float* , float* , float* , int , int , int , float );
extern void relu(float* , float* , int , int , int );
extern void batch_norm_relu(float* , float* , float* , float* , int , int , int , float );
extern void conv_block(float* , float* , float* , float* , float* , int , int , int , int , int , int , int );
extern void conv_transpose2d(float* , float* , float* , int , int , int , int , int , int );
extern void conv2d(float* , float* , float* , int , int , int , int , int , int );
extern void concat(float* , float* , float* , int , int , int , int );
extern void max_pool2d(float* , float* , int , int , int , int , int );


#endif
