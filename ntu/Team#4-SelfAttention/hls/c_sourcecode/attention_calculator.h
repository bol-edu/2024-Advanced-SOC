#pragma once

#include "attention_defs.h"
#include <mc_scverify.h>

using namespace std;

namespace ATTENTION_IP {

  class Attention_Calculator
  {
  private:
  
  public:
    Attention_Calculator() {}
  
    #pragma hls_design interface
    void CCS_BLOCK(run)(headType                 &head,
                        lengthType               &length,
                        dimType                  &dim,
                        ac_channel<channelType>  &q_chan2,
                        ac_channel<channelType>  &k_chan2,
                        ac_channel<channelType>  &v_chan2,
                        ac_channel<dataType>     &dout_chan)
    {
        channelType q_channel;
        channelType k_channel;
        channelType v_channel;
        
        uint8       cnt;
        calcType38  sum_array[56];
        calcType38  sum;
        calcType38  maxn;
        dataType    data_out[64];
        
        LOOPI1:for (headType i=0; ; i=i+1) {
            LOOPJ1:for (lengthType j=0; ; j=j+1) {
                if (q_chan2.available(1)) {
                    q_channel = q_chan2.read();
                }
                maxn = -137438953472;
                cnt = 0;
                LOOPK1:for(lengthType k=0; ; k=k+1) {
                    if (k_chan2.available(1)) k_channel = k_chan2.read();
                    
                    bool endflag = 1;
                    sum = 0;
                    LOOPL1:for (dimType l=0; ; l=l+1) {
                        sum = sum + q_channel.data[l] * k_channel.data[l];
                        if (k_channel.data[l] != 0) endflag = 0;
                        if (l == dim-1) break;
                    }
                    
                    sum = (sum >> (22 + 3)); 
                    if (endflag) break;
                    sum_array[cnt] = sum;
                    if (sum > maxn) maxn = sum;
                    cnt = cnt + 1;
                }
                
                uint16 sum2 = 0;
                LOOPK2:for (lengthType k=0; ; k=k+1) {
                    sum_array[k] = sum_array[k] - maxn;
                    
                    if (sum_array[k] < -20)  sum_array[k] = 0;
                    else if (sum_array[k] == -20) sum_array[k] = 1;
                    else if (sum_array[k] == -19) sum_array[k] = 1;
                    else if (sum_array[k] == -18) sum_array[k] = 1;
                    else if (sum_array[k] == -17) sum_array[k] = 2;
                    else if (sum_array[k] == -16) sum_array[k] = 2;
                    else if (sum_array[k] == -15) sum_array[k] = 3;
                    else if (sum_array[k] == -14) sum_array[k] = 4;
                    else if (sum_array[k] == -13) sum_array[k] = 5;
                    else if (sum_array[k] == -12) sum_array[k] = 7;
                    else if (sum_array[k] == -11) sum_array[k] = 9;
                    else if (sum_array[k] == -10) sum_array[k] = 12;
                    else if (sum_array[k] == -9) sum_array[k] = 15;
                    else if (sum_array[k] == -8) sum_array[k] = 20;
                    else if (sum_array[k] == -7) sum_array[k] = 25;
                    else if (sum_array[k] == -6) sum_array[k] = 33;
                    else if (sum_array[k] == -5) sum_array[k] = 32;
                    else if (sum_array[k] == -4) sum_array[k] = 54;
                    else if (sum_array[k] == -3) sum_array[k] = 70;
                    else if (sum_array[k] == -2) sum_array[k] = 90;
                    else if (sum_array[k] == -1) sum_array[k] = 115;
                    else if (sum_array[k] == 0) sum_array[k] = 148;
                    
                    sum2 = sum2 + sum_array[k];
                    
                    if (k == cnt-1) break;
                }

                sum2 = 65536 / sum2;
                LOOPK3:for (dimType k=0; ; k=k+1) {
                    data_out[k] = 0;
                    if (k == dim-1) break;
                }
                
                LOOPK4:for (lengthType k=0; ; k=k+1) {
                    sum_array[k] = sum_array[k] * sum2;

                    if (v_chan2.available(1)) {
                        v_channel = v_chan2.read();
                        LOOPL2:for (int l=0; ; l=l+1) {
                            data_out[l] = data_out[l] + ((v_channel.data[l] * sum_array[k]) >> 16);    
                            if (l == dim-1) break;              
                        }
                    }   
                    if (k == cnt-1) break; 
                }
                
                LOOPK5:for (dimType k=0; ; k=k+1) {
                    dout_chan.write(data_out[k]);
                    if (k == dim-1) break;
                }
                
                if (j == length-1) break;
            }
            if (i == head-1) break;
        }
    }
  };

}


