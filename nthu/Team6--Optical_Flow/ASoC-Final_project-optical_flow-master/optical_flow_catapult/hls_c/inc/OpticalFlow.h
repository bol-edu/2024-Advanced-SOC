
#pragma once

#include "OpticalFlow_defs.h"
/////#include "OpticalFlow_framesplit.h"
#include "OpticalFlow_gradient_x_calc.h"
#include "OpticalFlow_gradient_y_calc.h"
#include "OpticalFlow_gradient_z_calc.h"
#include "OpticalFlow_gradient_weight_y.h"
#include "OpticalFlow_gradient_weight_x.h"
#include "OpticalFlow_outer_product.h"
#include "OpticalFlow_tensor_weight_y.h"
#include "OpticalFlow_tensor_weight_x.h"
#include "OpticalFlow_flow_calc.h"

#include <mc_scverify.h>

// top-level kernel function
#pragma hls_design top
  class OpticalFlow_Top
{
  //instances
  /////OpticalFlow_framesplit         framesplit_inst;
  OpticalFlow_gradient_x_calc    gradient_x_calc_inst;
  OpticalFlow_gradient_y_calc    gradient_y_calc_inst;
  OpticalFlow_gradient_z_calc    gradient_z_calc_inst;
  OpticalFlow_gradient_weight_y  gradient_weight_y_inst;
  OpticalFlow_gradient_weight_x  gradient_weight_x_inst;
  OpticalFlow_outer_product      outer_product_inst;
  OpticalFlow_tensor_weight_y    tensor_weight_y_inst;
  OpticalFlow_tensor_weight_x    tensor_weight_x_inst;
  OpticalFlow_flow_calc          flow_calc_inst;

  // FIFOs connecting the stages
  ac_channel<pixel_t> gradient_x; // <-----------------------------------------------------------------------------------
  ac_channel<pixel_t> gradient_y;
  ac_channel<pixel_t> gradient_z;
  ac_channel<gradient_t> y_filtered;
  ac_channel<gradient_t> filtered_gradient;
  ac_channel<outer_t> out_product;
  ac_channel<tensor_t> tensor_y;
  ac_channel<tensor_int_t> tensor_shift;
  ac_channel<shift_t> shift;

  // FIFOs for streaming in, just for clarity
  /////ac_channel<input_t> frame1_a;
  /////ac_channel<input_t> frame2_a;
  /////ac_channel<input_t> frame3_a;
  /////ac_channel<input_t> frame4_a;
  /////ac_channel<input_t> frame5_a;

  //Need to duplicate frame3 for the two calculations
  /////ac_channel<input_t> frame3_b;
  /////ac_channel<input_t> frame3_c;
  ac_channel<input_t> frame3;

  // Stored input frames for Ix and It
  ac_channel<frames_t> input_frames_delayed;

  public:
    OpticalFlow_Top() {}
  
    //--------------------------------------------------------------------------
    // Function: run
    //   Top interface for data in/out of class. Combines vertical and
    //   horizontal derivative and magnitude/angle computation.
    #pragma hls_design interface
    void CCS_BLOCK(run)(ac_channel<frames_t>    &input_frames,
                        maxWType                widthIn,
                        maxHType                heightIn,
                        shift_t                 shift_threshold,
                        /////ac_channel<pixel_t> &gradient_x, // <-----------------------------------------------------------------------------------
                        /////ac_channel<gradient_t> &filtered_gradient,
                        /////ac_channel<outer_t> &out_product,
                        /////ac_channel<tensor_t> &tensor_y,
                        /////ac_channel<tensor_t> &tensor,
                        //ac_channel<pixel_t>  &denominator,
                        ////////ac_channel<vel_pixel_t>  &denominator,
                        ////////ac_channel<shift_t>  &shift,
                        ////////ac_channel<velocity_t>  &outputs)
                        ac_channel<output_stream_t>  &outputs)
    {
      // compute
      /////framesplit_inst.run(input_frames, frame1_a, frame2_a, frame3_a, frame3_b, frame3_c, frame4_a, frame5_a, widthIn, heightIn);
      /////gradient_x_calc_inst.run(frame3_b, gradient_x, widthIn, heightIn);
      /////gradient_y_calc_inst.run(frame3_c, gradient_y, widthIn, heightIn);
      /////gradient_z_calc_inst.run(frame1_a, frame2_a, frame3_a, frame4_a, frame5_a, gradient_z, widthIn, heightIn);
      gradient_y_calc_inst.run(input_frames, gradient_y, frame3, input_frames_delayed, widthIn, heightIn);
      gradient_x_calc_inst.run(frame3, gradient_x, widthIn, heightIn);
      gradient_z_calc_inst.run(input_frames_delayed, gradient_z, widthIn, heightIn);
      gradient_weight_y_inst.run(gradient_x, gradient_y, gradient_z, y_filtered, widthIn, heightIn);
      gradient_weight_x_inst.run(y_filtered, filtered_gradient, widthIn, heightIn);
      outer_product_inst.run(filtered_gradient, out_product, widthIn, heightIn);
      tensor_weight_y_inst.run(out_product, tensor_y, widthIn, heightIn);
      /////tensor_weight_x_inst.run(tensor_y, tensor_shift, widthIn, heightIn);
      tensor_weight_x_inst.run(tensor_y, tensor_shift, shift, widthIn, heightIn);
      /////flow_calc_inst.run(tensor, outputs, widthIn, heightIn);
      ////////flow_calc_inst.run(tensor_shift, outputs, denominator, widthIn, heightIn);
      /////flow_calc_inst.run(tensor, outputs, denominator, shift, widthIn, heightIn);
      flow_calc_inst.run(tensor_shift, shift, outputs, widthIn, heightIn, shift_threshold);
    }
  };



