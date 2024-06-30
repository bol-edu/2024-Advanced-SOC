//****************************************
// replace KeyExpansion() with GenRoundKey() in each round
//
//****************************************


#include "aes_defs.h"
#include <stdint.h>
#include <stdio.h>
class AES128_EN{
public:
    AES128_EN(){}

    StateBlock state;
    unsigned char roundkeys[16*11];
    //unsigned char key[16];

    //encrypt block
    void run(unsigned char plaintext_in[16], unsigned char key_in[16], unsigned char ciphertext_out[16]){
        // input
        for(int i=0;i<4;i++){
            for(int j=0;j<4;j++){
                state.arr[j][i] = plaintext_in[i*4+j];
            }
        }
        for(int i = 0; i < 16; i++){
            roundkeys[i] = key_in[i];
        }

        //KeyExpansion(key, roundkeys);
        //for(int i=0;i<16*11;i++)
        //printf("%02x", *(roundkeys+i));
        AddRoundKey(state, roundkeys);
        for(int r = 1; r < 10; r++){
            
            /* for(int i=0;i<4;i++){
                for(int j=0;j<4;j++){
                    printf("%02x",state.arr[j][i]);
                }
            }
            printf("\n"); */
            
            SubBytes(state);
            state = ShiftRows(state);
            state = MixColumns(state);
            GenRoundKey(roundkeys+((r-1)<<4), roundkeys+(r<<4), r);
            AddRoundKey(state, roundkeys+(r<<4));
        }
        SubBytes(state);
        state = ShiftRows(state);
        GenRoundKey(roundkeys + 144, roundkeys + 160, 10);
        AddRoundKey(state, roundkeys+(10<<4));

        // output
        for(int i=0;i<4;i++){
            for(int j=0;j<4;j++){
                ciphertext_out[i*4+j] = state.arr[j][i];
            }
        }

    }


    void SubBytes(StateBlock &state){
        unsigned char t;
        for(int i = 0; i < 4; i++){
            for(int j = 0; j < 4; j++){
                t = state.arr[i][j];
                state.arr[i][j] = sbox[t>>4][t&0x0f];
            }
        }
    }

    StateBlock ShiftRows(StateBlock state){
        StateBlock a;
        for(uint8_t i=0;i<4;i++){
            for(uint8_t j=0;j<4;j++){
                a.arr[i][j] = state.arr[i][(j+i)%4];
            }
        }
        return a;
    }

    StateBlock MixColumns(StateBlock state){
        StateBlock a = {{0}};
        for (uint8_t i = 0; i < 4; ++i) {
            for (uint8_t k = 0; k < 4; ++k) {
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
        for (i = 0; i < 4; i++) {
            for (j = 0; j < 4; j++) {
                state.arr[i][j] = state.arr[i][j] ^ key[i + 4 * j];
            }
        }
    }

    void GenRoundKey(const unsigned char prev_key[], unsigned char w[], uint8_t round){
        //
        unsigned char temp[4];
        unsigned char rcon[4];
        uint8_t i = 0;
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
    
    /* 
    void KeyExpansion(const unsigned char key[16], unsigned char w[]){
        uint8_t i = 0;
        while(i < 4 * 4){
            w[i] = key[i];
            i++;
        }
        unsigned char temp[4];
        unsigned char rcon[4];
        // {w[i],w[i+1],w[i+2],w[i+3]} -> word
        while(i < 4 * 4 * (10+1)){
            temp[0] = w[i - 4 + 0];
            temp[1] = w[i - 4 + 1];
            temp[2] = w[i - 4 + 2];
            temp[3] = w[i - 4 + 3];
            if((i & 0x0c) == 0){
                RotWord(temp);
                SubWord(temp);
                Rcon(rcon, (i >>4));
                XorWords(temp, rcon, temp);
            }
            w[i + 0] = w[i + 0 - 4 * 4] ^ temp[0];
            w[i + 1] = w[i + 1 - 4 * 4] ^ temp[1];
            w[i + 2] = w[i + 2 - 4 * 4] ^ temp[2];
            w[i + 3] = w[i + 3 - 4 * 4] ^ temp[3];

            i += 4;
        }
    } */

    void SubWord(unsigned char *a){
        uint8_t i;
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
        for (i = 0; i < 4; i++) {
            c[i] = a[i] ^ b[i];
        }
    }

    void Rcon(unsigned char *a, unsigned int n){
        a[0] = RCON[n-1];
        a[1] = a[2] = a[3] = 0;
    }

};