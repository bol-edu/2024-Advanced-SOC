#pragma once

#include "attention_defs.h"
#include <mc_scverify.h>

using namespace std;

namespace ATTENTION_IP 
{
  class Attention_Filter
  {
  public:
    Attention_Filter() {}
  
    #pragma hls_design interface
    void CCS_BLOCK(run)(headType                 head,
                        lengthType               length,
                        dimType                  dim,
                        ac_channel<channelType>  &q_chan1,
                        ac_channel<channelType>  &k_chan1,
                        ac_channel<channelType>  &v_chan1,
                        ac_channel<channelType>  &q_chan2,
                        ac_channel<channelType>  &k_chan2,
                        ac_channel<channelType>  &v_chan2)
    {
        channelType     q_channel;
        channelType     k_channel;
        channelType     v_channel;
        channelType     z_channel;
        calcType4       q_data;
        calcType4       k_data;
        calcType14      sum;
        calcType14      max;
        calcType20      avg;
        bool            sel[56];
        
        LOOPI1:for (dimType i=0; ; i=i+1) {
            z_channel.data[i] = 0;
            if (i == dim-1) break;
        }
        
        LOOPI2:for (headType i=0; ; i=i+1) {
            LOOPJ1: for (lengthType j=0; ; j=j+1) {
                if (q_chan1.available(1)) {
                    q_channel = q_chan1.read();
                    q_chan2.write(q_channel);
                }
                max = -8192;
                avg = 0;
                LOOPK1:for (lengthType k=0; ; k=k+1) {
                    sel[k] = 0;
                    if (k == length-1) break;
                }
                
                LOOPK2:for (lengthType k=0; ; k=k+1) {
                    if (k_chan1.available(1)) {
                        k_channel = k_chan1.read();
                    }
                    sum = 0;
                    LOOPL1: for (dimType l=0; ; l=l+1) {
                        q_data = q_channel.data[l] / 4096;
                        k_data = k_channel.data[l] / 4096;
                        sum = sum + q_data * k_data;
                        if (l == dim-1) break;
                    }
                    if (k == 0 || (sum << 2) * k > (max * k + (avg * 3))) {
                        k_chan2.write(k_channel);
                        sel[k] = 1;
                    }
                    if (sum > max) max = sum;
                    avg = avg + sum;
                    if (k == length-1) break;
                }
                k_chan2.write(z_channel);
                
                LOOPK3:for (lengthType k=0; ; k=k+1) {
                    if (v_chan1.available(1)) v_channel = v_chan1.read();
                    if (sel[k] == 1) v_chan2.write(v_channel);
                    if (k == length-1) break;
                }
                if (j == length-1) break;
            }
            if (i == head-1) break;
        }     
    }
  };

}
