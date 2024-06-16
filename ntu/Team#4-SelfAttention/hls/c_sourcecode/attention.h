#pragma once

#include <attention_defs.h>
#include <attention_buffer.h>
#include <attention_filter.h>
#include <attention_calculator.h>
#include <mc_scverify.h>

namespace ATTENTION_IP {

  #pragma hls_design top
  class Attention_Top
  {
    Attention_Buffer Buffer_inst;
    Attention_Filter Filter_inst;
    Attention_Calculator Calculator_inst;
    
    ac_channel<channelType>    q_chan1;
    ac_channel<channelType>    k_chan1;
    ac_channel<channelType>    v_chan1;
    ac_channel<channelType>    q_chan2;
    ac_channel<channelType>    k_chan2;
    ac_channel<channelType>    v_chan2;
    
    
  
  public:
    Attention_Top() {}
  
    #pragma hls_design interface
    void CCS_BLOCK(run)(headType                head,
                        lengthType              length,
                        dimType                 dim,
                        ac_channel<dataType>    &din_chan,
                        ac_channel<dataType>    &dout_chan)
    {
        Buffer_inst.run(head, length, dim, din_chan, q_chan1, k_chan1, v_chan1);
        Filter_inst.run(head, length, dim, q_chan1, k_chan1, v_chan1, q_chan2, k_chan2, v_chan2);
        Calculator_inst.run(head, length, dim, q_chan2, k_chan2, v_chan2, dout_chan);
    }
  };

}


