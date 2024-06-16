#pragma once

#include <ac_int.h>
#include <ac_fixed.h>
#include <ac_channel.h>


namespace ATTENTION_IP 
{
  const int head_size = 8;
  const int length_size = 56;
  const int dim_size = 64;
  
  typedef uint4                  headType;
  typedef uint6                  lengthType;
  typedef uint8                  lengthType3;
  typedef uint7                  dimType;
  typedef uint8                  paramType;    // used for head, length, dim
  typedef int16                  dataType;     // used for input and output data
  typedef ac_int<4, true>        calcType4;
  typedef ac_int<14, true>       calcType14;
  typedef ac_int<20, true>       calcType20;
  typedef ac_int<38, true>       calcType38;
  
  struct channelType{                          // used for channel passing (64 * 16 bit data at once pass)
    int16 data[64];   
  };
}


