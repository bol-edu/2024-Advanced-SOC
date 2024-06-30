#ifndef AES_ENC_H_
#define AES_ENC_H_
#define nk 4
#define nb 4
#define nr 10

#include <ac_channel.h>
#include <stdint.h>
#include <mc_scverify.h>

typedef unsigned char BYTE;

typedef struct {
    unsigned char mat[4][4];
} Mat;
//void aes_enc(uint8_t state[16],uint8_t cipher[16],uint8_t ekey[176]);

#endif /* AES_ENC_H_ */
