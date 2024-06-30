#pragma once

#include "OpticalFlow_defs.h"
#include <mc_scverify.h>

class OpticalFlow_tensor_weight_x
  {
  public:
    OpticalFlow_tensor_weight_x() {}
  
    #pragma hls_design interface
    void CCS_BLOCK(run)(ac_channel<tensor_t> &tensor_y,
                        //ac_channel<tensor_t> &tensor,
                        ac_channel<tensor_int_t> &tensor_shift,
                        ac_channel<shift_t>  &shift,
                        maxWType            widthIn,
                        maxHType            heightIn)
    {
      // tensor buffers store tensor history
      tensor_t tensor_buf0 = {0,0,0,0,0,0};
      tensor_t tensor_buf1 = {0,0,0,0,0,0};

      tensor_t tensor0;
      tensor_t tensor1;
      tensor_t tensor2;

      shift_t shift_value;

      ///////tensor_int_half_t tensor_shift0;
      ///////tensor_int_half_t tensor_shift1;
      ///////tensor_int_half_t tensor_shift2;

      ///////ac_int<OUTER_PIXEL_T_INTEGER_PART/2, false> TENSOR_FILTER_int_version[3];

      /////tensor_t tensor_value;
      tensor_long_t tensor_value; // "32" is from the bit number of "TENSOR_FILTER"
      tensor_long_t tensor_value_compare_to_sign_bit;
      tensor_long_pixel_t tensor_value_compare_to_sign_bit_bitwise_OR;
      tensor_long_pixel_t tensor_value_compare_to_sign_bit_bitwise_OR_complement;
      tensor_long_pixel_t rightmost_1;
      //tensor_long_pixel_t LSB_1;
      tensor_int_t tensor_shift_value;

      // transform into ac_int type
      ///////for(uint i=0; i<OUTER_PIXEL_T_INTEGER_PART/2; i++){
      ///////    TENSOR_FILTER_int_version[0][i] = TENSOR_FILTER[0][i];
      ///////    TENSOR_FILTER_int_version[1][i] = TENSOR_FILTER[1][i];
      ///////    TENSOR_FILTER_int_version[2][i] = TENSOR_FILTER[2][i];
      ///////}

      Tensor_weight_x_ROW: for (maxHType y=0; ; y++) {
        Tensor_weight_x_COLUMN: for (maxWType x=0; ; x++) {
          // read input value
          if (x <= widthIn-1) {
            tensor0 = tensor_y.read(); // Read from input stream
          } else {
            tensor0 = tensor_buf0;
          }

          tensor1 = tensor_buf0;
          tensor2 = tensor_buf1;

          tensor_buf1 = tensor_buf0;
          tensor_buf0 = tensor0;

          //if ((x==TARGET_X+1) && (y==TARGET_Y)){
          //  printf("Before shift:\n");
          //  printf("tensor0\n");
          //  for (int k=OUTER_PIXEL_T_BIT_WIDTH-1;k>=0;k=k-1){
          //    cout << tensor0.val[0][k];
          //  }
          //  printf("\n");
          //  
          //  for (int k=OUTER_PIXEL_T_BIT_WIDTH-1;k>=0;k=k-1){
          //    cout << tensor0.val[1][k];
          //  }
          //  printf("\n");
          //  
          //  for (int k=OUTER_PIXEL_T_BIT_WIDTH-1;k>=0;k=k-1){
          //    cout << tensor0.val[2][k];
          //  }
          //  printf("\n");
          //  
          //  for (int k=OUTER_PIXEL_T_BIT_WIDTH-1;k>=0;k=k-1){
          //    cout << tensor0.val[3][k];
          //  }
          //  printf("\n");
          //  
          //  for (int k=OUTER_PIXEL_T_BIT_WIDTH-1;k>=0;k=k-1){
          //    cout << tensor0.val[4][k];
          //  }
          //  printf("\n");
          //  
          //  for (int k=OUTER_PIXEL_T_BIT_WIDTH-1;k>=0;k=k-1){
          //    cout << tensor0.val[5][k];
          //  }
          //  printf("\n\n");
          //  printf("tensor1\n");
          //  for (int k=OUTER_PIXEL_T_BIT_WIDTH-1;k>=0;k=k-1){
          //    cout << tensor1.val[0][k];
          //  }
          //  printf("\n");
          //  
          //  for (int k=OUTER_PIXEL_T_BIT_WIDTH-1;k>=0;k=k-1){
          //    cout << tensor1.val[1][k];
          //  }
          //  printf("\n");
          //  
          //  for (int k=OUTER_PIXEL_T_BIT_WIDTH-1;k>=0;k=k-1){
          //    cout << tensor1.val[2][k];
          //  }
          //  printf("\n");
          //  
          //  for (int k=OUTER_PIXEL_T_BIT_WIDTH-1;k>=0;k=k-1){
          //    cout << tensor1.val[3][k];
          //  }
          //  printf("\n");
          //  
          //  for (int k=OUTER_PIXEL_T_BIT_WIDTH-1;k>=0;k=k-1){
          //    cout << tensor1.val[4][k];
          //  }
          //  printf("\n");
          //  
          //  for (int k=OUTER_PIXEL_T_BIT_WIDTH-1;k>=0;k=k-1){
          //    cout << tensor1.val[5][k];
          //  }
          //  printf("\n\n");
          //  printf("tensor2\n");
          //  for (int k=OUTER_PIXEL_T_BIT_WIDTH-1;k>=0;k=k-1){
          //    cout << tensor2.val[0][k];
          //  }
          //  printf("\n");
          //  
          //  for (int k=OUTER_PIXEL_T_BIT_WIDTH-1;k>=0;k=k-1){
          //    cout << tensor2.val[1][k];
          //  }
          //  printf("\n");
          //  
          //  for (int k=OUTER_PIXEL_T_BIT_WIDTH-1;k>=0;k=k-1){
          //    cout << tensor2.val[2][k];
          //  }
          //  printf("\n");
          //  
          //  for (int k=OUTER_PIXEL_T_BIT_WIDTH-1;k>=0;k=k-1){
          //    cout << tensor2.val[3][k];
          //  }
          //  printf("\n");
          //  
          //  for (int k=OUTER_PIXEL_T_BIT_WIDTH-1;k>=0;k=k-1){
          //    cout << tensor2.val[4][k];
          //  }
          //  printf("\n");
          //  
          //  for (int k=OUTER_PIXEL_T_BIT_WIDTH-1;k>=0;k=k-1){
          //    cout << tensor2.val[5][k];
          //  }
          //  printf("\n\n");
          //}

          if ((x >= 2) && (x < widthIn)) {
            // Calculate tensor_shift_value
            tensor_value.val[0] = tensor0.val[0]*TENSOR_FILTER[0] + tensor1.val[0]*TENSOR_FILTER[1] + tensor2.val[0]*TENSOR_FILTER[2];
            tensor_value.val[1] = tensor0.val[1]*TENSOR_FILTER[0] + tensor1.val[1]*TENSOR_FILTER[1] + tensor2.val[1]*TENSOR_FILTER[2];
            tensor_value.val[2] = tensor0.val[2]*TENSOR_FILTER[0] + tensor1.val[2]*TENSOR_FILTER[1] + tensor2.val[2]*TENSOR_FILTER[2];
            tensor_value.val[3] = tensor0.val[3]*TENSOR_FILTER[0] + tensor1.val[3]*TENSOR_FILTER[1] + tensor2.val[3]*TENSOR_FILTER[2];
            tensor_value.val[4] = tensor0.val[4]*TENSOR_FILTER[0] + tensor1.val[4]*TENSOR_FILTER[1] + tensor2.val[4]*TENSOR_FILTER[2];
            tensor_value.val[5] = tensor0.val[5]*TENSOR_FILTER[0] + tensor1.val[5]*TENSOR_FILTER[1] + tensor2.val[5]*TENSOR_FILTER[2];

            //if ((x==TARGET_X+1) && (y==TARGET_Y)){
            //  printf("tensor_value\n");
            //  for (int k=TENSOR_LONG_PIXEL_T_BIT_WIDTH-1;k>=0;k=k-1){
            //    cout << tensor_value.val[0][k];
            //  }
            //  printf("\n");
//
            //  for (int k=TENSOR_LONG_PIXEL_T_BIT_WIDTH-1;k>=0;k=k-1){
            //    cout << tensor_value.val[1][k];
            //  }
            //  printf("\n");
//
            //  for (int k=TENSOR_LONG_PIXEL_T_BIT_WIDTH-1;k>=0;k=k-1){
            //    cout << tensor_value.val[2][k];
            //  }
            //  printf("\n");
//
            //  for (int k=TENSOR_LONG_PIXEL_T_BIT_WIDTH-1;k>=0;k=k-1){
            //    cout << tensor_value.val[3][k];
            //  }
            //  printf("\n");
//
            //  for (int k=TENSOR_LONG_PIXEL_T_BIT_WIDTH-1;k>=0;k=k-1){
            //    cout << tensor_value.val[4][k];
            //  }
            //  printf("\n");
            //
            //  for (int k=TENSOR_LONG_PIXEL_T_BIT_WIDTH-1;k>=0;k=k-1){
            //    cout << tensor_value.val[5][k];
            //  }
            //  printf("\n");
            //}

            // reset shift_value
            shift_value = 0;
            //LSB_1 = 0;
            //LSB_1[0] = 1;

            ///// // shift left until MSB has non-zero value
            ///// while ((tensor_value.val[0][TENSOR_LONG_PIXEL_T_BIT_WIDTH-2]==tensor_value.val[0][TENSOR_LONG_PIXEL_T_BIT_WIDTH-1]) && (tensor_value.val[1][TENSOR_LONG_PIXEL_T_BIT_WIDTH-2]==tensor_value.val[1][TENSOR_LONG_PIXEL_T_BIT_WIDTH-1]) && (tensor_value.val[3][TENSOR_LONG_PIXEL_T_BIT_WIDTH-2]==tensor_value.val[3][TENSOR_LONG_PIXEL_T_BIT_WIDTH-1]) && (tensor_value.val[4][TENSOR_LONG_PIXEL_T_BIT_WIDTH-2]==tensor_value.val[4][TENSOR_LONG_PIXEL_T_BIT_WIDTH-1]) && (tensor_value.val[5][TENSOR_LONG_PIXEL_T_BIT_WIDTH-2]==tensor_value.val[5][TENSOR_LONG_PIXEL_T_BIT_WIDTH-1])) { // if we choose tensor_value.val[0][OUTER_PIXEL_T_BIT_WIDTH-1], then after multiplication and add, it will become 32*2+1=65 bits, but we have only 64 bits, thus overflow may happen. Therefore, here we choose tensor_value.val[0][OUTER_PIXEL_T_BIT_WIDTH-2], then we will have 31*2+1=63 bits after multiplication and add
            /////   tensor_value.val[0] = tensor_value.val[0]<<1;
            /////   tensor_value.val[1] = tensor_value.val[1]<<1;
            /////   tensor_value.val[3] = tensor_value.val[3]<<1;
            /////   tensor_value.val[4] = tensor_value.val[4]<<1;
            /////   tensor_value.val[5] = tensor_value.val[5]<<1;
            /////   shift_value = shift_value + 1;
            /////   //cout << x << "," << y << " :" << shift_value <<endl;
            /////   if (shift_value==TENSOR_LONG_PIXEL_T_BIT_WIDTH-1){
            /////     break;
            /////   }
            ///// }
            
            //if ((x==TARGET_X+1) && (y==TARGET_Y)){
            //  printf("After shifting:\n");
            //  for (int k=TENSOR_LONG_PIXEL_T_BIT_WIDTH-1;k>=0;k=k-1){
            //    cout << tensor_value.val[0][k];
            //  }
            //  printf("\n");
//
            //  for (int k=TENSOR_LONG_PIXEL_T_BIT_WIDTH-1;k>=0;k=k-1){
            //    cout << tensor_value.val[1][k];
            //  }
            //  printf("\n");
//
            //  for (int k=TENSOR_LONG_PIXEL_T_BIT_WIDTH-1;k>=0;k=k-1){
            //    cout << tensor_value.val[2][k];
            //  }
            //  printf("\n");
//
            //  for (int k=TENSOR_LONG_PIXEL_T_BIT_WIDTH-1;k>=0;k=k-1){
            //    cout << tensor_value.val[3][k];
            //  }
            //  printf("\n");
//
            //  for (int k=TENSOR_LONG_PIXEL_T_BIT_WIDTH-1;k>=0;k=k-1){
            //    cout << tensor_value.val[4][k];
            //  }
            //  printf("\n");
//
            //  for (int k=TENSOR_LONG_PIXEL_T_BIT_WIDTH-1;k>=0;k=k-1){
            //    cout << tensor_value.val[5][k];
            //  }
            //  printf("\n");
            //}

            ///// // Transform into 32-bit int
            ///// tensor_shift_value.val[0] = tensor_value.val[0].to_int();
            ///// tensor_shift_value.val[1] = tensor_value.val[1].to_int();
            ///// tensor_shift_value.val[2] = tensor_value.val[2].to_int();
            ///// tensor_shift_value.val[3] = tensor_value.val[3].to_int();
            ///// tensor_shift_value.val[4] = tensor_value.val[4].to_int();
            ///// tensor_shift_value.val[5] = tensor_value.val[5].to_int();
            //for(uint k=0; k<OUTER_PIXEL_T_INTEGER_PART; k++){
            //  tensor_shift_value.val[0][OUTER_PIXEL_T_INTEGER_PART-1-k] = tensor_value.val[0][TENSOR_LONG_PIXEL_T_BIT_WIDTH-1-k];
            //  tensor_shift_value.val[1][OUTER_PIXEL_T_INTEGER_PART-1-k] = tensor_value.val[1][TENSOR_LONG_PIXEL_T_BIT_WIDTH-1-k];
            //  tensor_shift_value.val[2][OUTER_PIXEL_T_INTEGER_PART-1-k] = tensor_value.val[2][TENSOR_LONG_PIXEL_T_BIT_WIDTH-1-k];
            //  tensor_shift_value.val[3][OUTER_PIXEL_T_INTEGER_PART-1-k] = tensor_value.val[3][TENSOR_LONG_PIXEL_T_BIT_WIDTH-1-k];
            //  tensor_shift_value.val[4][OUTER_PIXEL_T_INTEGER_PART-1-k] = tensor_value.val[4][TENSOR_LONG_PIXEL_T_BIT_WIDTH-1-k];
            //  tensor_shift_value.val[5][OUTER_PIXEL_T_INTEGER_PART-1-k] = tensor_value.val[5][TENSOR_LONG_PIXEL_T_BIT_WIDTH-1-k];
            //}

            for (uint i=0; i<TENSOR_LONG_PIXEL_T_BIT_WIDTH; i=i+1) {
              tensor_value_compare_to_sign_bit.val[0][i] = tensor_value.val[0][TENSOR_LONG_PIXEL_T_BIT_WIDTH-1]^tensor_value.val[0][i];
              tensor_value_compare_to_sign_bit.val[1][i] = tensor_value.val[1][TENSOR_LONG_PIXEL_T_BIT_WIDTH-1]^tensor_value.val[1][i];
              tensor_value_compare_to_sign_bit.val[3][i] = tensor_value.val[3][TENSOR_LONG_PIXEL_T_BIT_WIDTH-1]^tensor_value.val[3][i];
              tensor_value_compare_to_sign_bit.val[4][i] = tensor_value.val[4][TENSOR_LONG_PIXEL_T_BIT_WIDTH-1]^tensor_value.val[4][i];
              tensor_value_compare_to_sign_bit.val[5][i] = tensor_value.val[5][TENSOR_LONG_PIXEL_T_BIT_WIDTH-1]^tensor_value.val[5][i];
              tensor_value_compare_to_sign_bit_bitwise_OR[i] = tensor_value_compare_to_sign_bit.val[0][i] | tensor_value_compare_to_sign_bit.val[1][i] | tensor_value_compare_to_sign_bit.val[3][i] | tensor_value_compare_to_sign_bit.val[4][i] | tensor_value_compare_to_sign_bit.val[5][i];
            }

            /// for (shift_t i=2; i<TENSOR_LONG_PIXEL_T_BIT_WIDTH+1; i=i+1) {
            ///   if ((tensor_value_compare_to_sign_bit_bitwise_OR[TENSOR_LONG_PIXEL_T_BIT_WIDTH-i]==1) || (i==TENSOR_LONG_PIXEL_T_BIT_WIDTH)) {
            ///     shift_value = i-2;
            ///     tensor_shift_value.val[0] = (tensor_value.val[0]<<shift_value).to_int();
            ///     tensor_shift_value.val[1] = (tensor_value.val[1]<<shift_value).to_int();
            ///     tensor_shift_value.val[3] = (tensor_value.val[3]<<shift_value).to_int();
            ///     tensor_shift_value.val[4] = (tensor_value.val[4]<<shift_value).to_int();
            ///     tensor_shift_value.val[5] = (tensor_value.val[5]<<shift_value).to_int();
            ///     break;
            ///   }
            /// }
            /// tensor_shift_value.val[2] = tensor_value.val[2].to_int();
            for (uint i=0; i<TENSOR_LONG_PIXEL_T_BIT_WIDTH; i=i+1) {
              tensor_value_compare_to_sign_bit_bitwise_OR_complement[i]=tensor_value_compare_to_sign_bit_bitwise_OR[TENSOR_LONG_PIXEL_T_BIT_WIDTH-1-i];
            }

            rightmost_1 = tensor_value_compare_to_sign_bit_bitwise_OR_complement & (-tensor_value_compare_to_sign_bit_bitwise_OR_complement);
            for (uint i=1; i<TENSOR_LONG_PIXEL_T_BIT_WIDTH; i=i+1) {
              shift_value = shift_value + i*rightmost_1[i];
            }
            shift_value = shift_value-1;
            //cout << "shift_value: " << shift_value << endl;
            tensor_shift_value.val[0] = (tensor_value.val[0]<<shift_value).to_int();
            tensor_shift_value.val[1] = (tensor_value.val[1]<<shift_value).to_int();
            tensor_shift_value.val[2] = tensor_value.val[2].to_int();
            tensor_shift_value.val[3] = (tensor_value.val[3]<<shift_value).to_int();
            tensor_shift_value.val[4] = (tensor_value.val[4]<<shift_value).to_int();
            tensor_shift_value.val[5] = (tensor_value.val[5]<<shift_value).to_int();

            //if ((x==TARGET_X+1) && (y==TARGET_Y)){
            //  //printf("After shift and slicing:\n");
            //  printf("tensor_shift_value\n");
            //  for (int k=OUTER_PIXEL_T_INTEGER_PART-1;k>=0;k=k-1){
            //    cout << tensor_shift_value.val[0][k];
            //  }
            //  printf("\n");
            //  
            //  for (int k=OUTER_PIXEL_T_INTEGER_PART-1;k>=0;k=k-1){
            //    cout << tensor_shift_value.val[1][k];
            //  }
            //  printf("\n");
            //  
            //  for (int k=OUTER_PIXEL_T_INTEGER_PART-1;k>=0;k=k-1){
            //    cout << tensor_shift_value.val[2][k];
            //  }
            //  printf("\n");
            //  
            //  for (int k=OUTER_PIXEL_T_INTEGER_PART-1;k>=0;k=k-1){
            //    cout << tensor_shift_value.val[3][k];
            //  }
            //  printf("\n");
            //  
            //  for (int k=OUTER_PIXEL_T_INTEGER_PART-1;k>=0;k=k-1){
            //    cout << tensor_shift_value.val[4][k];
            //  }
            //  printf("\n");
            //  
            //  for (int k=OUTER_PIXEL_T_INTEGER_PART-1;k>=0;k=k-1){
            //    cout << tensor_shift_value.val[5][k];
            //  }
            //  printf("\n\n");
            //}

            // Write output tensor_shift_value streaming interface
            tensor_shift.write(tensor_shift_value);
            shift.write(shift_value);
          } else if (x >= 1) {
            // Calculate tensor_shift_value
            tensor_shift_value.val[0] = 0;
            tensor_shift_value.val[1] = 0;
            tensor_shift_value.val[2] = 0;
            tensor_shift_value.val[3] = 0;
            tensor_shift_value.val[4] = 0;
            tensor_shift_value.val[5] = 0;
            shift_value = 0;

            // Write output tensor_shift_value streaming interface
            tensor_shift.write(tensor_shift_value);
            shift.write(shift_value);
          }

          if ((x==TARGET_X+1) && (y==TARGET_Y)){
            /////cout << "HLS_tensor[0]: " << tensor_value.val[0] << endl;
            /////cout << "HLS_tensor[1]: " << tensor_value.val[1] << endl;
            /////cout << "HLS_tensor[2]: " << tensor_value.val[2] << endl;
            /////cout << "HLS_tensor[3]: " << tensor_value.val[3] << endl;
            /////cout << "HLS_tensor[4]: " << tensor_value.val[4] << endl;
            /////cout << "HLS_tensor[5]: " << tensor_value.val[5] << endl;
            cout << "HLS_tensor[0]: " << tensor_shift_value.val[0] << endl;
            cout << "HLS_tensor[1]: " << tensor_shift_value.val[1] << endl;
            cout << "HLS_tensor[2]: " << tensor_shift_value.val[2] << endl;
            cout << "HLS_tensor[3]: " << tensor_shift_value.val[3] << endl;
            cout << "HLS_tensor[4]: " << tensor_shift_value.val[4] << endl;
            cout << "HLS_tensor[5]: " << tensor_shift_value.val[5] << endl;
            cout << "HLS_shift_value: " << shift_value << endl;
          }

          // programmable width exit condition
          if (x == widthIn) {
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


