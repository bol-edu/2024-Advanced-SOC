
/*
#include <stdio.h>
#include <stdint.h>
#include "catapult.h"
#include "aes_enc.h"
//#include "sbox.h"

uint8_t state_temp[16] = {'T', 'h', 'i', 's', 'I', 's', 'P',
                          'l', 'a', 'i', 'n', 't', 'e', 'x', 't', 'A'};

uint8_t key[16] = {'T', 'h', 'i', 's', 'I', 's', 'K', 'e',
                   'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y'};  // initial key

void keyexpansion(unsigned char key[16], unsigned char ekey[176]);

int main(void)
  {
    unsigned char x, y, i;
    ac_channel<ac_int<128,false>> state[16];
    ac_channel<ac_int<128,false>> cipher[16];

      for (i = 0; i < 16; ++i) {
          state[i] = state_temp[i];
      }
  
      //keyexpansion(key, ekey);
  
      // TIME_STAMP_INIT;
      aes_enc(state, cipher, ekey);
      // TIME_STAMP_SW;
  
      for (x = 0; x < 16; x++) {
          printf(" %x", cipher[x]);
      }
      printf("\n");
      printf("finish\n");
  
      free(state);
      free(cipher);
      free(ekey);
  
      return 0;
  }


ac_int<128,false> state_temp[16] = {'T', 'h', 'i', 's', 'I', 's', 'P',
                          'l', 'a', 'i', 'n', 't', 'e', 'x', 't', 'A'};

ac_int<128,false> key[16] = {'T', 'h', 'i', 's', 'I', 's', 'K', 'e',
                   'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y'};  // initial key

CCS_MAIN(int argc, char *argv[])
{
    unsigned char x, y, i;
    ac_int<128,false> state[16];
    ac_int<128,false> cipher[16];
    //aes_enc aes_enc_inst;

    for (i = 0; i < 16; ++i) {
        state[i] = state_temp[i];
    }

    aes_enc(state, cipher, key);

    for (x = 0; x < 16; x++) {
        printf(" %02x", cipher[x]);
    }
    printf("\n");
    printf("finish\n");

    return 0;
}

*/
#include <stdint.h>
#include <stdio.h>
#include "ac_channel.h"
#include "ac_int.h"
#include "sbox.h"
#include "aes_enc.h"
#include "catapult.h"
#include <mc_scverify.h>

CCS_MAIN(int argc, char *argv[])
{
    const char* state_str = "ThisIsPlaintextA";
    const char* key_str = "ThisIsKeyyyyyyyy";
    
    ac_int<128, false> state_temp = 0;
    ac_int<128, false> key_temp = 0;

    for (int i = 0; i < 16; ++i) {
        state_temp.set_slc(120 - i * 8, ac_int<8, false>(state_str[i]));
        key_temp.set_slc(120 - i * 8, ac_int<8, false>(key_str[i]));
    }

    ac_channel<ac_int<128, false>> state_in_chn;
    ac_channel<ac_int<128, false>> key_in_chn;
    ac_channel<ac_int<128, false>> cipher_out_chn;

    state_in_chn.write(state_temp);
    key_in_chn.write(key_temp);

    aes_enc aes_enc_inst;
    
    aes_enc_inst.run(state_in_chn, cipher_out_chn, key_in_chn);

    ac_int<128, false> cipher_out = cipher_out_chn.read();

    for (int i = 0; i < 16; i++) {
        printf("%02x ", cipher_out.slc<8>(120 - i * 8).to_uint());
    }
    printf("\n");

    printf("finish\n");

    return 0;
}



