#pragma once

#include "OpticalFlow_defs.h"
#include <mc_scverify.h>

class OpticalFlow_flow_calc
  {
  public:
    OpticalFlow_flow_calc() {}
  
    #pragma hls_design interface
    void CCS_BLOCK(run)(//ac_channel<tensor_t> &tensor,
                        ac_channel<tensor_int_t> &tensor_shift,
                        ac_channel<shift_t>  &shift,
                        ////////ac_channel<velocity_t>  &output,
                        ac_channel<output_stream_t>  &output,
                        ////////ac_channel<vel_pixel_t>  &denominator,
                        ///////ac_channel<shift_t>  &shift,
                        maxWType            widthIn,
                        maxHType            heightIn,
                        shift_t             shift_threshold)
    {
      /////tensor_t tensor_value;

      //pixel_t denominator_value;
      vel_pixel_t denominator_value;
      vel_pixel_t denominator_value_after_shift;
      vel_pixel_t denominator_value_before_threshold;

      tensor_int_t tensor_shift_value;

      ////////velocity_t total_output_value;
      velocity_t velocity_value;
      velocity_t velocity_value_compare_to_sign_bit;
      vel_pixel_t denominator_value_compare_to_sign_bit;
      vel_pixel_t velocity_value_compare_to_sign_bit_bitwise_OR;
      vel_pixel_t velocity_value_compare_to_sign_bit_bitwise_OR_complement;
      vel_pixel_t rightmost_1;
      velocity_t velocity_value_before_threshold;
      velocity_t velocity_value_after_shift;
      output_stream_t output_value;
      shift_t shift_value;
      shift_t shift_value_here;

      Flow_calc_ROW: for(maxHType y=0; ; y++) {
        Flow_calc_COLUMN: for(maxWType x=0; ; x++) {
          // read input channels
          /////tensor_value = tensor.read();
          tensor_shift_value = tensor_shift.read();
          shift_value = shift.read();

          // reset shift_value
          /////shift_value = 0;
          shift_value_here = 0;
            
          if ((y >= 2) && (y < heightIn-2) && (x >= 2) && (x < widthIn-2)) {
            //if ((x==302) && (y==116)){
            //if ((x==785) && (y==287)){
            //if ((x==354) && (y==277)){
            /*if ((x==TARGET_X) && (y==TARGET_Y)){
              cout << endl << "HLS_tensor_value[0]: " << tensor_value.val[0] << endl;
              cout << "HLS_tensor_value[1]: " << tensor_value.val[1] << endl;
              cout << "HLS_tensor_value[2]: " << tensor_value.val[2] << endl;
              cout << "HLS_tensor_value[3]: " << tensor_value.val[3] << endl;
              cout << "HLS_tensor_value[4]: " << tensor_value.val[4] << endl;
              cout << "HLS_tensor_value[5]: " << tensor_value.val[5] << endl;
            
              for (int k=OUTER_PIXEL_T_BIT_WIDTH-1;k>0;k=k-1){
                cout << tensor_value.val[0][k];
              }
              printf("\n");
              
              for (int k=OUTER_PIXEL_T_BIT_WIDTH-1;k>0;k=k-1){
                cout << tensor_value.val[1][k];
              }
              printf("\n");
              
              for (int k=OUTER_PIXEL_T_BIT_WIDTH-1;k>0;k=k-1){
                cout << tensor_value.val[2][k];
              }
              printf("\n");
              
              for (int k=OUTER_PIXEL_T_BIT_WIDTH-1;k>0;k=k-1){
                cout << tensor_value.val[3][k];
              }
              printf("\n");
              
              for (int k=OUTER_PIXEL_T_BIT_WIDTH-1;k>0;k=k-1){
                cout << tensor_value.val[4][k];
              }
              printf("\n");
              
              for (int k=OUTER_PIXEL_T_BIT_WIDTH-1;k>0;k=k-1){
                cout << tensor_value.val[5][k];
              }
              printf("\n");
            }

            // shift left until MSB has non-zero value
            while ((tensor_value.val[0][OUTER_PIXEL_T_BIT_WIDTH-2]==tensor_value.val[0][OUTER_PIXEL_T_BIT_WIDTH-1]) && (tensor_value.val[1][OUTER_PIXEL_T_BIT_WIDTH-2]==tensor_value.val[1][OUTER_PIXEL_T_BIT_WIDTH-1]) && (tensor_value.val[3][OUTER_PIXEL_T_BIT_WIDTH-2]==tensor_value.val[3][OUTER_PIXEL_T_BIT_WIDTH-1]) && (tensor_value.val[4][OUTER_PIXEL_T_BIT_WIDTH-2]==tensor_value.val[4][OUTER_PIXEL_T_BIT_WIDTH-1]) && (tensor_value.val[5][OUTER_PIXEL_T_BIT_WIDTH-2]==tensor_value.val[5][OUTER_PIXEL_T_BIT_WIDTH-1])) { // if we choose tensor_value.val[0][OUTER_PIXEL_T_BIT_WIDTH-1], then after multiplication and add, it will become 32*2+1=65 bits, but we have only 64 bits, thus overflow may happen. Therefore, here we choose tensor_value.val[0][OUTER_PIXEL_T_BIT_WIDTH-2], then we will have 31*2+1=63 bits after multiplication and add
              tensor_value.val[0] = tensor_value.val[0]<<1;
              tensor_value.val[1] = tensor_value.val[1]<<1;
              tensor_value.val[3] = tensor_value.val[3]<<1;
              tensor_value.val[4] = tensor_value.val[4]<<1;
              tensor_value.val[5] = tensor_value.val[5]<<1;
              shift_value = shift_value + 1;
              //cout << x << "," << y << " :" << shift_value <<endl;
              if (shift_value==OUTER_PIXEL_T_BIT_WIDTH-1){
                break;
              }
            }
            //cout << "type: " << typeid(tensor_value.val[0]).name() << endl;
            //cout << x << "," << y << endl;

            // Transform into 32-bit int
            tensor_shift_value.val[0] = tensor_value.val[0].to_int();
            tensor_shift_value.val[1] = tensor_value.val[1].to_int();
            tensor_shift_value.val[2] = tensor_value.val[2].to_int();
            tensor_shift_value.val[3] = tensor_value.val[3].to_int();
            tensor_shift_value.val[4] = tensor_value.val[4].to_int();
            tensor_shift_value.val[5] = tensor_value.val[5].to_int();*/

            denominator_value = (tensor_shift_value.val[0]*tensor_shift_value.val[1] - tensor_shift_value.val[3]*tensor_shift_value.val[3]);
            velocity_value.x = (tensor_shift_value.val[5]*tensor_shift_value.val[3] - tensor_shift_value.val[4]*tensor_shift_value.val[1]); // / denominator_value;
            velocity_value.y = (tensor_shift_value.val[4]*tensor_shift_value.val[3] - tensor_shift_value.val[5]*tensor_shift_value.val[0]); // / denominator_value;

            ///// while ((denominator_value[VEL_PIXEL_T_BIT_WIDTH-2]==denominator_value[VEL_PIXEL_T_BIT_WIDTH-1]) && (velocity_value.x[VEL_PIXEL_T_BIT_WIDTH-2]==velocity_value.x[VEL_PIXEL_T_BIT_WIDTH-1]) && (velocity_value.y[VEL_PIXEL_T_BIT_WIDTH-2]==velocity_value.y[VEL_PIXEL_T_BIT_WIDTH-1])) {
            /////   denominator_value = denominator_value<<1;
            /////   velocity_value.x = velocity_value.x<<1;
            /////   velocity_value.y = velocity_value.y<<1;
            /////   shift_value_here = shift_value_here + 1;
            /////   //cout << x << "," << y << " :" << shift_value <<endl;
            /////   if (shift_value_here==VEL_PIXEL_T_BIT_WIDTH-1){
            /////     break;
            /////   }
            ///// }
            for (uint i=0; i<VEL_PIXEL_T_BIT_WIDTH; i=i+1) {
              denominator_value_compare_to_sign_bit[i] = denominator_value[VEL_PIXEL_T_BIT_WIDTH-1]^denominator_value[i];
              velocity_value_compare_to_sign_bit.x[i] = velocity_value.x[VEL_PIXEL_T_BIT_WIDTH-1]^velocity_value.x[i];
              velocity_value_compare_to_sign_bit.y[i] = velocity_value.y[VEL_PIXEL_T_BIT_WIDTH-1]^velocity_value.y[i];
              velocity_value_compare_to_sign_bit_bitwise_OR[i] = denominator_value_compare_to_sign_bit[i] | velocity_value_compare_to_sign_bit.x[i] | velocity_value_compare_to_sign_bit.y[i];
            }

            /// for (shift_t i=2; i<VEL_PIXEL_T_BIT_WIDTH+1; i=i+1) {
            ///   if ((velocity_value_compare_to_sign_bit_bitwise_OR[VEL_PIXEL_T_BIT_WIDTH-i]==1) || (i==VEL_PIXEL_T_BIT_WIDTH)) {
            ///     shift_value_here = i-2;
            ///     denominator_value_before_threshold = denominator_value<<shift_value_here;
            ///     velocity_value_before_threshold.x = velocity_value.x<<shift_value_here;
            ///     velocity_value_before_threshold.y = velocity_value.y<<shift_value_here;
            ///     break;
            ///   }
            /// }
            for (uint i=0; i<VEL_PIXEL_T_BIT_WIDTH; i=i+1) {
              velocity_value_compare_to_sign_bit_bitwise_OR_complement[i]=velocity_value_compare_to_sign_bit_bitwise_OR[VEL_PIXEL_T_BIT_WIDTH-1-i];
            }
            rightmost_1 = velocity_value_compare_to_sign_bit_bitwise_OR_complement & (-velocity_value_compare_to_sign_bit_bitwise_OR_complement);
            for (uint i=1; i<VEL_PIXEL_T_BIT_WIDTH; i=i+1) {
              shift_value_here = shift_value_here + i*rightmost_1[i];
            }
            shift_value_here = shift_value_here-1;
            //cout << "shift_value_here: " << shift_value_here << endl;
            denominator_value_before_threshold = denominator_value<<shift_value_here;
            velocity_value_before_threshold.x = velocity_value.x<<shift_value_here;
            velocity_value_before_threshold.y = velocity_value.y<<shift_value_here;

            // Calculate velocity_value
            if ((shift_value*2 + shift_value_here) > shift_threshold) {
              denominator_value_after_shift = 0;
              velocity_value_after_shift.x = 0;
              velocity_value_after_shift.y = 0;
            } else {
              denominator_value_after_shift = denominator_value_before_threshold;
              velocity_value_after_shift.x = velocity_value_before_threshold.x;
              velocity_value_after_shift.y = velocity_value_before_threshold.y;
            }
            
            //if ((x==451) && (y==62)){
            //if ((x==362) && (y==399)){
            //if ((x==317) && (y==189)){
            //if ((x==497) && (y==367)){
            //if ((x==785) && (y==287)){
            //if ((x==354) && (y==277)){
            if ((x==TARGET_X) && (y==TARGET_Y)){
              //cout << endl << "HLS_tensor_value[0]: " << tensor_value.val[0] << endl;
              //cout << "HLS_tensor_value[1]: " << tensor_value.val[1] << endl;
              //cout << "HLS_tensor_value[2]: " << tensor_value.val[2] << endl;
              //cout << "HLS_tensor_value[3]: " << tensor_value.val[3] << endl;
              //cout << "HLS_tensor_value[4]: " << tensor_value.val[4] << endl;
              //cout << "HLS_tensor_value[5]: " << tensor_value.val[5] << endl;

              //for (int k=OUTER_PIXEL_T_BIT_WIDTH-1;k>0;k=k-1){
              //  cout << tensor_value.val[0][k];
              //}
              //printf("\n");
              //
              //for (int k=OUTER_PIXEL_T_BIT_WIDTH-1;k>0;k=k-1){
              //  cout << tensor_value.val[1][k];
              //}
              //printf("\n");
              //
              //for (int k=OUTER_PIXEL_T_BIT_WIDTH-1;k>0;k=k-1){
              //  cout << tensor_value.val[2][k];
              //}
              //printf("\n");
              //
              //for (int k=OUTER_PIXEL_T_BIT_WIDTH-1;k>0;k=k-1){
              //  cout << tensor_value.val[3][k];
              //}
              //printf("\n");
              //
              //for (int k=OUTER_PIXEL_T_BIT_WIDTH-1;k>0;k=k-1){
              //  cout << tensor_value.val[4][k];
              //}
              //printf("\n");
              //
              //for (int k=OUTER_PIXEL_T_BIT_WIDTH-1;k>0;k=k-1){
              //  cout << tensor_value.val[5][k];
              //}
              //printf("\n");

              cout << endl << "HLS_tensor_shift_value[0]: " << tensor_shift_value.val[0] << endl;
              cout << "HLS_tensor_shift_value[1]: " << tensor_shift_value.val[1] << endl;
              cout << "HLS_tensor_shift_value[2]: " << tensor_shift_value.val[2] << endl;
              cout << "HLS_tensor_shift_value[3]: " << tensor_shift_value.val[3] << endl;
              cout << "HLS_tensor_shift_value[4]: " << tensor_shift_value.val[4] << endl;
              cout << "HLS_tensor_shift_value[5]: " << tensor_shift_value.val[5] << endl;

              cout << "HLS_denominator_value_after_shift: " << denominator_value_after_shift << endl;
              cout << "HLS_shift_value: " << shift_value << endl;
              cout << "HLS_shift_value_in_flow_calc: " << shift_value_here << endl;
              cout << "HLS_total_shift_value: " << shift_value*2+shift_value_here << endl;
              cout << "HLS_velocity_value_after_shift.x: " << velocity_value_after_shift.x << endl;
              cout << "HLS_velocity_value_after_shift.y: " << velocity_value_after_shift.y << endl;
              cout << "HLS_velocity_value_after_shift.x (after division): " << velocity_value_after_shift.x.to_double()/denominator_value_after_shift.to_double() << endl;
              cout << "HLS_velocity_value_after_shift.y (after division): " << velocity_value_after_shift.y.to_double()/denominator_value_after_shift.to_double() << endl;
            }

            // Write output optical flow (velocity) streaming interface
            output_value = denominator_value_after_shift.slc<32>(VEL_PIXEL_T_BIT_WIDTH-32);
            //printf("HLS_denominator_value_after_shift: %08x\n", output_value.to_int());
            output.write(output_value);
            output_value = velocity_value_after_shift.x.slc<32>(VEL_PIXEL_T_BIT_WIDTH-32);
            //printf("HLS_velocity_value_after_shift.x: %08x\n", output_value.to_int());
            output.write(output_value);
            output_value = velocity_value_after_shift.y.slc<32>(VEL_PIXEL_T_BIT_WIDTH-32);
            //printf("HLS_velocity_value_after_shift.y: %08x\n", output_value.to_int());
            output.write(output_value);
            ////////denominator.write(denominator_value);
            ///////shift.write(shift_value);
          } else {
            velocity_value_after_shift.x = 0;
            velocity_value_after_shift.y = 0;
            denominator_value_after_shift = 0;

            // Write output optical flow (velocity) streaming interface
            output_value = denominator_value_after_shift.slc<32>(VEL_PIXEL_T_BIT_WIDTH-32);
            output.write(output_value);
            output_value = velocity_value_after_shift.x.slc<32>(VEL_PIXEL_T_BIT_WIDTH-32);
            output.write(output_value);
            output_value = velocity_value_after_shift.y.slc<32>(VEL_PIXEL_T_BIT_WIDTH-32);
            output.write(output_value);
            ////////denominator.write(denominator_value);
            ///////shift.write(shift_value);
          }

          // programmable width exit condition
          if (x == widthIn-1) {
            break;
          }
        }
        // programmable height exit condition
        if (y == heightIn-1) {
          break;
        }
      }
    }
};


