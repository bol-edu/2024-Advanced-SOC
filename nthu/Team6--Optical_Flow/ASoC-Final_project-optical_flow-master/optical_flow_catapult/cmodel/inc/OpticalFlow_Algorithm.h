
#ifndef _INCLUDED_OPTICALFLOW_ALGORITHM_H_
#define _INCLUDED_OPTICALFLOW_ALGORITHM_H_

#include <math.h>
#include <stdlib.h>
#include <cstdio>
// Include constant kernel definition
#include "OpticalFlow_defs_software.h"

#define TARGET_X 150 //343 //25 //592 //371 //586 //358 // 354
#define TARGET_Y 150 //128 //38 //223 //147 //150 //250 // 277

// Template parameters allow configuring the maximum image size
template <int maxImageWidth, int maxImageHeight>
class OpticalFlow_Algorithm
{
  // Define some "constants" for use in algorithm
  ///enum {
  ///  imageWidth  = 1296,
  ///  imageHeight =  864
  ///};

public:
  // Constructor
  OpticalFlow_Algorithm() {}

  //--------------------------------------------------------------------------
  // Function: run
  //   Top interface for data in/out of class.
  // top-level function
  void run(pixel_t_sw      frame0[MAX_HEIGHT][MAX_WIDTH],  // image data (streamed in by pixel)
           pixel_t_sw      frame1[MAX_HEIGHT][MAX_WIDTH],  // image data (streamed in by pixel)
           pixel_t_sw      frame2[MAX_HEIGHT][MAX_WIDTH],  // image data (streamed in by pixel)
           pixel_t_sw      frame3[MAX_HEIGHT][MAX_WIDTH],  // image data (streamed in by pixel)
           ////////pixel_t_sw      frame4[MAX_HEIGHT][MAX_WIDTH],  // image data (streamed in by pixel)
           /////pixel_t_sw gradient_x[MAX_HEIGHT][MAX_WIDTH], // <-----------------------------------------------------------------------------------
           /////gradient_t_sw filtered_gradient[MAX_HEIGHT][MAX_WIDTH],
           /////outer_t_sw out_product[MAX_HEIGHT][MAX_WIDTH],
           /////tensor_t_sw tensor_y[MAX_HEIGHT][MAX_WIDTH],
           /////tensor_t_sw tensor[MAX_HEIGHT][MAX_WIDTH],
           pixel_t_sw denom[MAX_HEIGHT][MAX_WIDTH],
           velocity_t_sw   outputs[MAX_HEIGHT][MAX_WIDTH])   // velocity output
  {
    // allocate buffers for image data
    ///double *dy = (double *)malloc(maxImageHeight*maxImageWidth*sizeof(double));
    ///double *dx = (double *)malloc(maxImageHeight*maxImageWidth*sizeof(double));

    // intermediate arrays
    static pixel_t_sw gradient_x[MAX_HEIGHT][MAX_WIDTH]; // <-----------------------------------------------------------------------------------
    static pixel_t_sw gradient_y[MAX_HEIGHT][MAX_WIDTH];
    static pixel_t_sw gradient_z[MAX_HEIGHT][MAX_WIDTH];
    static gradient_t_sw y_filtered[MAX_HEIGHT][MAX_WIDTH];
    static gradient_t_sw filtered_gradient[MAX_HEIGHT][MAX_WIDTH];
    static outer_t_sw out_product[MAX_HEIGHT][MAX_WIDTH];
    static tensor_t_sw tensor_y[MAX_HEIGHT][MAX_WIDTH];
    static tensor_t_sw tensor[MAX_HEIGHT][MAX_WIDTH];

    gradient_xy_calc(frame2, gradient_x, gradient_y);
    ////////gradient_z_calc(frame0, frame1, frame2, frame3, frame4, gradient_z);
    gradient_z_calc(frame0, frame1, frame2, frame3, gradient_z);
    gradient_weight_y(gradient_x, gradient_y, gradient_z, y_filtered);
    gradient_weight_x(y_filtered, filtered_gradient);
    outer_product(filtered_gradient, out_product);
    tensor_weight_y(out_product, tensor_y);
    tensor_weight_x(tensor_y, tensor);
    /////flow_calc(tensor, outputs);
    flow_calc(tensor, denom, outputs);

    ///free(dy);
    ///free(dx);
  }

  //--------------------------------------------------------------------------
  // Function:
  // compute x, y gradient
  void gradient_xy_calc(pixel_t_sw frame[MAX_HEIGHT][MAX_WIDTH],
      pixel_t_sw gradient_x[MAX_HEIGHT][MAX_WIDTH],
      pixel_t_sw gradient_y[MAX_HEIGHT][MAX_WIDTH])
  {
    pixel_t_sw x_grad, y_grad;
    for (int r = 0; r < MAX_HEIGHT + 2; r ++ )
    {
      for (int c = 0; c < MAX_WIDTH + 2; c ++)
      {
        x_grad = 0;
        y_grad = 0;
        if (r >= 4 && r < MAX_HEIGHT && c >= 4 && c < MAX_WIDTH)
        {
          for (int i = 0; i < 5; i++)
          {
            x_grad += frame[r-2][c-i] * GRAD_WEIGHTS_SW[4-i];
            y_grad += frame[r-i][c-2] * GRAD_WEIGHTS_SW[4-i];
          }
          gradient_x[r-2][c-2] = x_grad;///// / 12;
          gradient_y[r-2][c-2] = y_grad;///// / 12;
          //cout << gradient_x[r-2][c-2] << ", ";
          //cout << "algorihm: " << gradient_x[r-2][c-2] << endl;
          //if (gradient_y[r-2][c-2]==0){
          //if ((frame[r][c-2]==155) && (frame[r-1][c-2]==137) && (frame[r-2][c-2]==144) && (frame[r-3][c-2]==174) && (frame[r-4][c-2]==169)){
          //  for (int i = 0; i < 5; i++){
          //    cout << frame[r-i][c-2] << ", ";
          //  }
          //  cout << endl;
          //  for (int i = 0; i < 5; i++){
          //    cout << GRAD_WEIGHTS_SW[4-i] << ", ";
          //  }
          //  cout << endl;
          //  cout << "algorihm: " << gradient_x[r-2][c-2] << endl;
          //}
          
        }
        else if (r >= 2 && c >= 2)
        {
          gradient_x[r-2][c-2] = 0;
          gradient_y[r-2][c-2] = 0;
        }

        //if ((frame[r][c-2]==155) && (frame[r-1][c-2]==137) && (frame[r-2][c-2]==144) && (frame[r-3][c-2]==174) && (frame[r-4][c-2]==169)){
        //  for (int i = 0; i < 5; i++){
        //    cout << frame[r-i][c-2] << ", ";
        //  }
        //  cout << endl;
        //  for (int i = 0; i < 5; i++){
        //    cout << GRAD_WEIGHTS_SW[4-i] << ", ";
        //  }
        //  cout << endl;
        //  cout << "algorihm: " << gradient_x[r-2][c-2] << endl;
        //}

        if ((c==TARGET_X+2) && (r==TARGET_Y+2)){
          //cout << c << "," << r << endl;
          //for (int i = 0; i < 5; i++){
          //  cout << frame[r-i][c-2] << ", ";
          //}
          cout << "Algorithm_Ix: " << x_grad << endl;
          cout << "Algorithm_Iy: " << y_grad << endl;
        }
      }
    }
  }

  // compute z gradient
  void gradient_z_calc(pixel_t_sw frame0[MAX_HEIGHT][MAX_WIDTH], 
                      pixel_t_sw frame1[MAX_HEIGHT][MAX_WIDTH],
                      pixel_t_sw frame2[MAX_HEIGHT][MAX_WIDTH],
                      pixel_t_sw frame3[MAX_HEIGHT][MAX_WIDTH],
                      ////////pixel_t_sw frame4[MAX_HEIGHT][MAX_WIDTH],
                      pixel_t_sw gradient_z[MAX_HEIGHT][MAX_WIDTH])
  {
    for (int r = 0; r < MAX_HEIGHT; r ++)
    {
      for (int c = 0; c < MAX_WIDTH; c ++)
      {
        gradient_z[r][c] = 0.0f;
        gradient_z[r][c] += frame0[r][c] * GRAD_WEIGHTS_Z_SW[0]; 
        gradient_z[r][c] += frame1[r][c] * GRAD_WEIGHTS_Z_SW[1]; 
        gradient_z[r][c] += frame2[r][c] * GRAD_WEIGHTS_Z_SW[2]; 
        gradient_z[r][c] += frame3[r][c] * GRAD_WEIGHTS_Z_SW[3]; 
        ////////gradient_z[r][c] += frame4[r][c] * GRAD_WEIGHTS_SW[4]; 
        /////gradient_z[r][c] /= 12.0f;

        if ((c==TARGET_X) && (r==TARGET_Y)){
          //printf("Algorithm_input_frames_delayed_value: %d, %d, %d, %d\n",(int)frame3[r][c],(int)frame2[r][c],(int)frame1[r][c],(int)frame0[r][c]);
          cout << "Algorithm_Iz: " << gradient_z[r][c] << endl;
        }
      }
    }
  }

  // compute y weight
  void gradient_weight_y(pixel_t_sw gradient_x[MAX_HEIGHT][MAX_WIDTH],
                        pixel_t_sw gradient_y[MAX_HEIGHT][MAX_WIDTH],
                        pixel_t_sw gradient_z[MAX_HEIGHT][MAX_WIDTH],
                        gradient_t_sw filt_grad[MAX_HEIGHT][MAX_WIDTH])
  {
    for (int r = 0; r < MAX_HEIGHT + 3; r ++)
    {
      for (int c = 0; c < MAX_WIDTH; c ++)
      {
        gradient_t_sw acc;
        acc.x = 0;
        acc.y = 0;
        acc.z = 0;
        if (r >= 6 && r < MAX_HEIGHT)
        { 
          for (int i = 0; i < 7; i ++)
          {
            acc.x += gradient_x[r-i][c] * GRAD_FILTER_SW[i];
            acc.y += gradient_y[r-i][c] * GRAD_FILTER_SW[i];
            acc.z += gradient_z[r-i][c] * GRAD_FILTER_SW[i];
          }
          filt_grad[r-3][c] = acc;            
        }
        else if (r >= 3)
        {
          filt_grad[r-3][c] = acc;
        }

        if ((c==TARGET_X) && (r==TARGET_Y+3)){
          cout << "Algorithm_y_filtered.x: " << filt_grad[r-3][c].x << endl;
          cout << "Algorithm_y_filtered.y: " << filt_grad[r-3][c].y << endl;
          cout << "Algorithm_y_filtered.z: " << filt_grad[r-3][c].z << endl;
        }
      }
    }
  }

  // compute x weight
  void gradient_weight_x(gradient_t_sw y_filt[MAX_HEIGHT][MAX_WIDTH],
                        gradient_t_sw filt_grad[MAX_HEIGHT][MAX_WIDTH])
  {
    for (int r = 0; r < MAX_HEIGHT; r ++)
    {
      for (int c = 0; c < MAX_WIDTH + 3; c ++)
      {
        gradient_t_sw acc;
        acc.x = 0;
        acc.y = 0;
        acc.z = 0;
        if (c >= 6 && c < MAX_WIDTH)
        {
          for (int i = 0; i < 7; i ++)
          {
            acc.x += y_filt[r][c-i].x * GRAD_FILTER_SW[i];
            acc.y += y_filt[r][c-i].y * GRAD_FILTER_SW[i];
            acc.z += y_filt[r][c-i].z * GRAD_FILTER_SW[i];
          }
          filt_grad[r][c-3] = acc;
        }
        else if (c >= 3)
        {
          filt_grad[r][c-3] = acc;
        }

        if ((c==TARGET_X+3) && (r==TARGET_Y)){
          cout << "Algorithm_filtered_gradient.x: " << filt_grad[r][c-3].x << endl;
          cout << "Algorithm_filtered_gradient.y: " << filt_grad[r][c-3].y << endl;
          cout << "Algorithm_filtered_gradient.z: " << filt_grad[r][c-3].z << endl;
        }
      }
    }
  }
  
  // outer product
  void outer_product(gradient_t_sw gradient[MAX_HEIGHT][MAX_WIDTH],
                    outer_t_sw outer_product[MAX_HEIGHT][MAX_WIDTH])
  { 
    for (int r = 0; r < MAX_HEIGHT; r ++)
    {
      for (int c = 0; c < MAX_WIDTH; c ++)
      {
        gradient_t_sw grad = gradient[r][c];
        outer_t_sw out;
        out.val[0] = grad.x * grad.x;
        out.val[1] = grad.y * grad.y;
        out.val[2] = grad.z * grad.z;
        out.val[3] = grad.x * grad.y;
        out.val[4] = grad.x * grad.z;
        out.val[5] = grad.y * grad.z;
        outer_product[r][c] = out;

        if ((c==TARGET_X) && (r==TARGET_Y)){
          cout << "Algorithm_out_product[0]: " << out.val[0] << endl;
          cout << "Algorithm_out_product[1]: " << out.val[1] << endl;
          cout << "Algorithm_out_product[2]: " << out.val[2] << endl;
          cout << "Algorithm_out_product[3]: " << out.val[3] << endl;
          cout << "Algorithm_out_product[4]: " << out.val[4] << endl;
          cout << "Algorithm_out_product[5]: " << out.val[5] << endl;
        }
      }
    }
  }

  // tensor weight y
  void tensor_weight_y(outer_t_sw outer[MAX_HEIGHT][MAX_WIDTH],
                      tensor_t_sw tensor_y[MAX_HEIGHT][MAX_WIDTH])
  {
    for (int r = 0; r < MAX_HEIGHT + 1; r ++)
    {
      for(int c = 0; c < MAX_WIDTH; c ++)
      {
        tensor_t_sw acc;
        for (int k = 0; k < 6; k ++)
        {
          acc.val[k] = 0;
        }

        if (r >= 2 && r < MAX_HEIGHT) 
        {
          for (int i = 0; i < 3; i ++)
          {
            for(int component = 0; component < 6; component ++)
            {
              acc.val[component] += outer[r-i][c].val[component] * TENSOR_FILTER_SW[i];
            }
          }
        }
        if (r >= 1)
        { 
          tensor_y[r-1][c] = acc;            
        }

        if ((c==TARGET_X) && (r==TARGET_Y+1)){
          cout << "Algorithm_tensor_y[0]: " << acc.val[0] << endl;
          cout << "Algorithm_tensor_y[1]: " << acc.val[1] << endl;
          cout << "Algorithm_tensor_y[2]: " << acc.val[2] << endl;
          cout << "Algorithm_tensor_y[3]: " << acc.val[3] << endl;
          cout << "Algorithm_tensor_y[4]: " << acc.val[4] << endl;
          cout << "Algorithm_tensor_y[5]: " << acc.val[5] << endl;
        }
      }
    }
  }

  // tensor weight x
  void tensor_weight_x(tensor_t_sw tensor_y[MAX_HEIGHT][MAX_WIDTH],
                      tensor_t_sw tensor[MAX_HEIGHT][MAX_WIDTH])
  {
    for (int r = 0; r < MAX_HEIGHT; r ++)
    {
      for (int c = 0; c < MAX_WIDTH + 1; c ++)
      {
        tensor_t_sw acc;
        for(int k = 0; k < 6; k++)
        {
          acc.val[k] = 0;
        }
        if (c >= 2 && c < MAX_WIDTH) 
        {
          for (int i = 0; i < 3; i ++)
          {
            for (int component = 0; component < 6; component ++)
            {
              acc.val[component] += tensor_y[r][c-i].val[component] * TENSOR_FILTER_SW[i];
            }
          }
        }
        if (c >= 1)
        {
          tensor[r][c-1] = acc;
        }

        if ((c==TARGET_X+1) && (r==TARGET_Y)){
          cout << "Algorithm_tensor[0]: " << acc.val[0] << endl;
          cout << "Algorithm_tensor[1]: " << acc.val[1] << endl;
          cout << "Algorithm_tensor[2]: " << acc.val[2] << endl;
          cout << "Algorithm_tensor[3]: " << acc.val[3] << endl;
          cout << "Algorithm_tensor[4]: " << acc.val[4] << endl;
          cout << "Algorithm_tensor[5]: " << acc.val[5] << endl;
        }
      }
    }
  }

  // compute flow
  void flow_calc(tensor_t_sw tensors[MAX_HEIGHT][MAX_WIDTH],
                pixel_t_sw denom[MAX_HEIGHT][MAX_WIDTH],
                velocity_t_sw output[MAX_HEIGHT][MAX_WIDTH])
  {
    for(int r = 0; r < MAX_HEIGHT; r ++)
    {
      for(int c = 0; c < MAX_WIDTH; c ++)
      {
        if (r >= 2 && r < MAX_HEIGHT - 2 && c >= 2 && c < MAX_WIDTH - 2)
        {
          //pixel_t_sw denom = tensors[r][c].val[0] * tensors[r][c].val[1] -
          denom[r][c] = tensors[r][c].val[0] * tensors[r][c].val[1] -
                          tensors[r][c].val[3] * tensors[r][c].val[3];
          output[r][c].x = (tensors[r][c].val[5] * tensors[r][c].val[3] -
                            tensors[r][c].val[4] * tensors[r][c].val[1]) / denom[r][c];
          output[r][c].y = (tensors[r][c].val[4] * tensors[r][c].val[3] -
                            tensors[r][c].val[5] * tensors[r][c].val[0]) / denom[r][c];
          //if ((c==451) && (r==62)){
          //if ((c==362) && (r==399)){
          //if ((c==317) && (r==189)){
          //if ((c==497) && (r==367)){
          //if ((c==785) && (r==287)){
          //if ((c==302) && (r==116)){
          //if ((c==354) && (r==277)){
          if ((c==TARGET_X) && (r==TARGET_Y)){
            cout << endl << "Algorithm_tensor_value[0]: " << tensors[r][c].val[0] << endl;
            cout << "Algorithm_tensor_value[1]: " << tensors[r][c].val[1] << endl;
            cout << "Algorithm_tensor_value[2]: " << tensors[r][c].val[2] << endl;
            cout << "Algorithm_tensor_value[3]: " << tensors[r][c].val[3] << endl;
            cout << "Algorithm_tensor_value[4]: " << tensors[r][c].val[4] << endl;
            cout << "Algorithm_tensor_value[5]: " << tensors[r][c].val[5] << endl;
            cout << "Algorithm_denominator_value: " << denom[r][c] << endl;
            cout << "Algorithm_total_output_value.x: " << output[r][c].x << endl;
            cout << "Algorithm_total_output_value.y: " << output[r][c].y << endl;
          }
        }
        else
        {
          output[r][c].x = 0;
          output[r][c].y = 0;
          denom[r][c] = 0;
        }
      }
    }
  }

///private: // Helper functions

  //--------------------------------------------------------------------------
  // Function: 

};

#endif

