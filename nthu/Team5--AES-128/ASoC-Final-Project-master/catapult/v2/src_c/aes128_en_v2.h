//****************************************
// replace KeyExpansion() with GenRoundKey() in each round
//
//****************************************


#include "aes_defs.h"
#include <stdint.h>
#include "ac_channel.h"
#include "ac_int.h"
#include <mc_scverify.h>

class AES128_EN{
public:
    AES128_EN(){}

    StateBlock state;
    unsigned char roundkeys[16];
    ac_int<128,false> _pt_in;
    ac_int<128,false> _key_in;
    ac_int<128,false> _ct_out;

    //encrypt block
    #pragma hls_design interface top
    void CCS_BLOCK(run)(ac_channel<ac_int<128,false>> &plaintext_in, 
                        ac_channel<ac_int<128,false>> &key_in, 
                        ac_channel<ac_int<128,false>> &ciphertext_out){
        // input
        _pt_in = plaintext_in.read();
        #pragma hls_unroll yes
        for(int i=0;i<4;i++){
            #pragma hls_unroll yes
            for(int j=0;j<4;j++){
                state.arr[j][i] = _pt_in.slc<8>(120-(i*4+j)*8);
            }
        }
        _key_in = key_in.read();
        #pragma hls_unroll yes
        for(int i = 0; i < 16; i++){
            roundkeys[i] = _key_in.slc<8>(120-i*8);
        }

        //KeyExpansion(key, roundkeys);

        AddRoundKey(state, roundkeys);
        ROUND:for(int r = 1; r < 10; r++){

            SubBytes(state);
            state = ShiftRows(state);
            state = MixColumns(state);
            GenRoundKey(roundkeys, roundkeys, r);
            AddRoundKey(state, roundkeys);
        }
        SubBytes(state);
        state = ShiftRows(state);
        GenRoundKey(roundkeys, roundkeys, 10);
        AddRoundKey(state, roundkeys);

        // output
        #pragma hls_unroll yes
        for(int i=0;i<4;i++){
            #pragma hls_unroll yes
            for(int j=0;j<4;j++){
                ac_int<8,false> t = state.arr[j][i];
                _ct_out.set_slc(120-(i*4+j)*8, t);
            }
        }
        ciphertext_out.write(_ct_out);
    }


    void SubBytes(StateBlock &state){
        unsigned char t;
        #pragma hls_unroll yes
        for(int i = 0; i < 4; i++){
            #pragma hls_unroll yes
            for(int j = 0; j < 4; j++){
                t = state.arr[i][j];
                state.arr[i][j] = sbox[t>>4][t&0x0f];
            }
        }
    }

    StateBlock ShiftRows(StateBlock state){
        StateBlock a;
        #pragma hls_unroll yes
        for(uint8_t i=0;i<4;i++){
            #pragma hls_unroll yes
            for(uint8_t j=0;j<4;j++){
                a.arr[i][j] = state.arr[i][(j+i)%4];
            }
        }
        return a;
    }

    StateBlock MixColumns(StateBlock state){
        StateBlock a = {{0}};
        #pragma hls_unroll yes
        for (uint8_t i = 0; i < 4; ++i) {
            #pragma hls_unroll yes
            for (uint8_t k = 0; k < 4; ++k) {
                #pragma hls_unroll yes
                for (uint8_t j = 0; j < 4; ++j) {
                    if (CMDS[i][k] == 1)
                        a.arr[i][j] ^= state.arr[k][j];
                    else
                        a.arr[i][j] ^= GF_MUL_TABLE[CMDS[i][k]%2][state.arr[k][j]];
                }
            }
        }
        return a;
    }

    void AddRoundKey(StateBlock &state, unsigned char *key){
        uint8_t i, j;
        #pragma hls_unroll yes
        for (i = 0; i < 4; i++) {
            #pragma hls_unroll yes
            for (j = 0; j < 4; j++) {
                state.arr[i][j] = state.arr[i][j] ^ key[i + 4 * j];
            }
        }
    }
    
    void GenRoundKey(const unsigned char prev_key[16], unsigned char w[16], uint8_t round){
        //
        unsigned char temp[4];
        unsigned char rcon[4];
        uint8_t i = 0;
        #pragma hls_unroll yes
        for(i=0;i<16;i+=4){
            if(i == 0){
                temp[0] = prev_key[12];
                temp[1] = prev_key[13];
                temp[2] = prev_key[14];
                temp[3] = prev_key[15];
                RotWord(temp);
                SubWord(temp);
                Rcon(rcon, round);
                XorWords(temp, rcon, temp);
            } else{
                temp[0] = w[i-4+0];
                temp[1] = w[i-4+1];
                temp[2] = w[i-4+2];
                temp[3] = w[i-4+3];
            }
            w[i + 0] = prev_key[i + 0 ] ^ temp[0];
            w[i + 1] = prev_key[i + 1 ] ^ temp[1];
            w[i + 2] = prev_key[i + 2 ] ^ temp[2];
            w[i + 3] = prev_key[i + 3 ] ^ temp[3];
        }
    }

    void SubWord(unsigned char *a){
        uint8_t i;
        #pragma hls_unroll yes
        for (i = 0; i < 4; i++) {
            a[i] = sbox[a[i]>>4][a[i]&0x0f];
        }
    }

    void RotWord(unsigned char *a){
        unsigned char c = a[0];
        a[0] = a[1];
        a[1] = a[2];
        a[2] = a[3];
        a[3] = c;
    }

    void XorWords(unsigned char *a, unsigned char *b, unsigned char *c){
        uint8_t i;
        #pragma hls_unroll yes
        for (i = 0; i < 4; i++) {
            c[i] = a[i] ^ b[i];
        }
    }

    void Rcon(unsigned char *a, unsigned int n){
        a[0] = RCON[n-1];
        a[1] = a[2] = a[3] = 0;
    }

};
