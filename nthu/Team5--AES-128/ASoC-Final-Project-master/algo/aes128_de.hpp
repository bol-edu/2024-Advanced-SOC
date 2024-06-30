#include "aes_defs.h"
#include <stdint.h>
#include <stdio.h>
class AES128_DE{
public:
    AES128_DE(){}

    StateBlock state;
    unsigned char roundkeys[16*11];
    unsigned char key[16];

    //encrypt block
    void run(unsigned char ciphertext_in[16], unsigned char key_in[16], unsigned char plaintext_out[16]){
        // input
        for(int i=0;i<4;i++){
            for(int j=0;j<4;j++){
                state.arr[j][i] = ciphertext_in[i*4+j];
            }
        }
        for(int i = 0; i < 16; i++){
            key[i] = key_in[i];
        }

        KeyExpansion(key, roundkeys);
        //for(int i=0;i<16*11;i++)
        //printf("%02x", *(roundkeys+i));
        AddRoundKey(state, roundkeys+(10<<4));
        for(int r = 9; r >= 1; r--){
            /* 
            for(int i=0;i<4;i++){
                for(int j=0;j<4;j++){
                    printf("%02x",state.arr[j][i]);
                }
            }
            printf("\n"); */
            state = InvShiftRows(state);
            InvSubBytes(state);
            /* printf("  ");
            for(int i=0;i<4;i++){
                for(int j=0;j<4;j++){
                    printf("%02x",state.arr[j][i]);
                }
            }
            printf("\n"); */
            AddRoundKey(state, roundkeys+(r<<4));
            state = InvMixColumns(state);
        }
        InvSubBytes(state);
        state = InvShiftRows(state);
        AddRoundKey(state, roundkeys);

        // output
        for(int i=0;i<4;i++){
            for(int j=0;j<4;j++){
                plaintext_out[i*4+j] = state.arr[j][i];
            }
        }

    }


    void InvSubBytes(StateBlock &state){
        unsigned char t;
        for(int i = 0; i < 4; i++){
            for(int j = 0; j < 4; j++){
                t = state.arr[i][j];
                state.arr[i][j] = inv_sbox[t>>4][t&0x0f];
            }
        }
    }

    StateBlock InvShiftRows(StateBlock state){
        StateBlock a;
        for(uint8_t i=0;i<4;i++){
            for(uint8_t j=0;j<4;j++){
                a.arr[i][j] = state.arr[i][(j-i+4)%4];
            }
        }
        return a;
    }

    StateBlock InvMixColumns(StateBlock state){
        StateBlock a = {{0}};
        for (uint8_t i = 0; i < 4; ++i) {
            for (uint8_t k = 0; k < 4; ++k) {
                for (uint8_t j = 0; j < 4; ++j) {
                    a.arr[i][j] ^= inv_GF_MUL_TABLE[INV_CMDS[i][k]][state.arr[k][j]];
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
    }

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