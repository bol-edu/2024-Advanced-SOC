#pragma once

#include "attention_defs.h"
#include <mc_scverify.h>

namespace ATTENTION_IP 
{
  class Attention_Buffer
  {
  public:
    Attention_Buffer() {}
  
    #pragma hls_design interface
    void CCS_BLOCK(run)(headType                 head,
                        lengthType               length,
                        dimType                  dim,
                        ac_channel<dataType>     &din_chan,
                        ac_channel<channelType>  &q_chan1,
                        ac_channel<channelType>  &k_chan1,
                        ac_channel<channelType>  &v_chan1)
    {
        channelType pp_buf[3 * length_size];
        dataType    data_in;
        channelType channel_in;
        
        LOOPI1:for (headType i=0; ; i++) {
            LOOPJ1:for (lengthType3 j=0; ; j++) {
                LOOPK1:for (dimType k=0; ; k++) {
                    if (din_chan.available(1)) {
                        data_in = din_chan.read();
                        channel_in.data[k] = data_in; 
                    } 
                    if (k == dim-1) break;
                }
                pp_buf[j] = channel_in;
                if (j == 3*length-1) break;
            }
            
            LOOPJ2:for (lengthType j=0; ; j++) {
                q_chan1.write(pp_buf[j]);
                LOOPK2:for (lengthType k=0; ; k++) {
                    k_chan1.write(pp_buf[length + k]);
                    if (k == length-1) break;
                }
                LOOPK3:for (lengthType k=0; ; k++) {
                    v_chan1.write(pp_buf[length * 2 + k]);
                    if (k == length-1) break;
                }
                if (j == length-1) break;
            }
            if (i == head-1) break;    
        }        
    }
  };

}


