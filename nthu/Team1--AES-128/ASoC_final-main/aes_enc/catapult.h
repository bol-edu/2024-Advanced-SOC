
#include <stdint.h>
#include "ac_channel.h"
#include "ac_int.h"
#include "sbox.h"
#include "aes_enc.h"
#include <mc_scverify.h>

class aes_enc 
{
public:

aes_enc(){}
    unsigned char key[16];
    ac_int<128, false> state_in;
    ac_int<128, false> key_in;
    ac_int<128, false> cipher_out;

    #pragma hls_design interface top
    void CCS_BLOCK(run)(ac_channel<ac_int<128, false>> &state, ac_channel<ac_int<128, false>> &cipher, ac_channel<ac_int<128, false>> &ekey) {
        unsigned char iteration = 0;
        unsigned char x, y;
        Mat sub, shift, mix, round, state_grid, result;
        unsigned char rkey[176];

        state_in = state.read();
        for (x = 0; x < 4; x++) {
            for (y = 0; y < 4; y++) {
                state_grid.mat[x][y] = state_in.slc<8>(120 - (x + 4 * y) * 8).to_uint();
            }
        }

        key_in = ekey.read();
        #pragma hls_unroll yes
        for (int i = 0; i < 16; i++) {
            key[i] = key_in.slc<8>(120 - i * 8).to_uint();
        }

        keyexpansion(key, rkey);

        addroundkey(state_grid, 0, sub, rkey);

        #pragma hls_pipeline_init_interval 1  // Catapult Constraint
        #pragma hls_unroll yes // Catapult C Constraint
        loop_main: for (iteration = 1; iteration < 10; iteration++) { // assuming nr is 10
            subbytes(sub, shift);
            shift_row_enc(shift, mix);
            mixcolumn(mix, round);
            addroundkey(round, iteration, sub, rkey);
        }
        subbytes(sub, shift);
        shift_row_enc(shift, round);
        addroundkey(round, 10, result, rkey); // assuming nr is 10

        for (x = 0; x < 4; x++) {
            for (y = 0; y < 4; y++) {
                cipher_out.set_slc(120 - (x + 4 * y) * 8, ac_int<8, false>(result.mat[x][y]));
            }
        }

        cipher.write(cipher_out);
    }

    void shift_row_enc(Mat &state, Mat &result) {

    result.mat[0][0] = state.mat[0][0];
    result.mat[0][1] = state.mat[0][1];
    result.mat[0][2] = state.mat[0][2];
    result.mat[0][3] = state.mat[0][3];

    result.mat[1][0] = state.mat[1][1];
    result.mat[1][1] = state.mat[1][2];
    result.mat[1][2] = state.mat[1][3];
    result.mat[1][3] = state.mat[1][0];

    result.mat[2][0] = state.mat[2][2];
    result.mat[2][1] = state.mat[2][3];
    result.mat[2][2] = state.mat[2][0];
    result.mat[2][3] = state.mat[2][1];

    result.mat[3][0] = state.mat[3][3];
    result.mat[3][1] = state.mat[3][0];
    result.mat[3][2] = state.mat[3][1];
    result.mat[3][3] = state.mat[3][2];

    }

    void subbytes(Mat &state, Mat &result) {
    uint8_t x, y;
    #pragma hls_unroll yes
    loop_sb1: for (x = 0; x < 4; x++) {
        #pragma hls_unroll yes
        loop_sb2: for (y = 0; y < 4; y++) {
            result.mat[x][y] = sbox[state.mat[x][y]];
        }
    }
    }

    void addroundkey(Mat &state, unsigned char iteration, Mat &result, unsigned char ekey[176]) {
        uint8_t x, y;
        #pragma hls_unroll yes
        loop_rk1: for (x = 0; x < 4; x++) {
            #pragma hls_unroll yes
            loop_rk2: for (y = 0; y < 4; y++) {
                result.mat[y][x] = state.mat[y][x] ^ ekey[iteration * nb * 4 + x * nb + y];
            }
        }
    }

    void mixcolumn(Mat &state, Mat &result) {
        uint8_t x;
        #pragma hls_unroll yes
        loop_mx1: for (x = 0; x < 4; x++) {
            result.mat[0][x] = (gf2[state.mat[0][x]]) ^ (gf3[state.mat[1][x]]) ^ (state.mat[2][x]) ^ (state.mat[3][x]);
            result.mat[1][x] = (state.mat[0][x]) ^ (gf2[state.mat[1][x]]) ^ (gf3[state.mat[2][x]]) ^ (state.mat[3][x]);
            result.mat[2][x] = (state.mat[0][x]) ^ (state.mat[1][x]) ^ (gf2[state.mat[2][x]]) ^ (gf3[state.mat[3][x]]);
            result.mat[3][x] = (gf3[state.mat[0][x]]) ^ (state.mat[1][x]) ^ (state.mat[2][x]) ^ (gf2[state.mat[3][x]]);
        }
    }

    void keyexpansion(unsigned char key[16], unsigned char ekey[176])
    {
        uint32_t i, j, k;
        uint8_t temp[4];

        for(i = 0; i < nk; ++i)
        {
            ekey[(i * 4) + 0] = key[(i * 4) + 0];
            ekey[(i * 4) + 1] = key[(i * 4) + 1];
            ekey[(i * 4) + 2] = key[(i * 4) + 2];
            ekey[(i * 4) + 3] = key[(i * 4) + 3];
        }

        for(; (i < (nb * (nr + 1))); ++i)
        {
            for(j = 0; j < 4; ++j)
            {
                temp[j] = ekey[(i-1) * 4 + j];
            }
            if (i % nk == 0)
            {
                k = temp[0];
                temp[0] = temp[1];
                temp[1] = temp[2];
                temp[2] = temp[3];
                temp[3] = k;

                temp[0] = sbox[temp[0]];
                temp[1] = sbox[temp[1]];
                temp[2] = sbox[temp[2]];
                temp[3] = sbox[temp[3]];

                temp[0] =  temp[0] ^ Rcon[i/nk];
            }
            else if (nk > 6 && i % nk == 4)
            {
                temp[0] = sbox[temp[0]];
                temp[1] = sbox[temp[1]];
                temp[2] = sbox[temp[2]];
                temp[3] = sbox[temp[3]];
            }
            ekey[i * 4 + 0] = ekey[(i - nk) * 4 + 0] ^ temp[0];
            ekey[i * 4 + 1] = ekey[(i - nk) * 4 + 1] ^ temp[1];
            ekey[i * 4 + 2] = ekey[(i - nk) * 4 + 2] ^ temp[2];
            ekey[i * 4 + 3] = ekey[(i - nk) * 4 + 3] ^ temp[3];
        }
    }
};
