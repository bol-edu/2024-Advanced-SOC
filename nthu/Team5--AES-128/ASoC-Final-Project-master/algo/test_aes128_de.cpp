#include "aes_defs.h"
#include "aes128_de.hpp"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


/// @brief convert hex string to binary
/// @param binBlock pointer to bin output
/// @param hexBlock pointer to hex string input
/// @param blockLen length in bytes
static void HexToBin (BYTE *binBlock, const char *hexBlock, int blockLen)
{
    int j = 0, t;
    while (blockLen > 0) {
        t = *hexBlock++;
        if ((t >= '0') && (t <= '9')) j = (t - '0') << 4;
        else if ((t >= 'a') && (t <= 'f')) j = (t - 'a' + 10) << 4; 
        else if ((t >= 'A') && (t <= 'F')) j = (t - 'A' + 10) << 4; 		
        
        t = *hexBlock++;
        if ((t >= '0') && (t <= '9')) j ^= (t - '0');
        else if ((t >= 'a') && (t <= 'f')) j ^= (t - 'a' + 10); 
        else if ((t >= 'A') && (t <= 'F')) j ^= (t - 'A' + 10); 

        *binBlock++ = j;
        blockLen -= 1;
    }
}


bool result[128];
bool all_pass;
BYTE k_bin[16];
BYTE p_bin[16];
BYTE c_bin[16];
BYTE out_bin[16];
char k_hex[32];
char p_hex[32];
char c_hex[32];

int main(){
    AES128_DE a;
    FILE *file;
    char line[38] = {0};
    file = fopen("128_ecb_tbl.txt", "r");
    if(file==NULL){
        perror("Error opening file");
        return EXIT_FAILURE;
    }
    all_pass = true;
    // repeats test for 128 times
    for(int i=0;i<=128;i++){
        fgets(line, 38, file);
        // read in key
        fgets(line, 38, file);
        strcpy(k_hex, line+4);
        HexToBin(k_bin, k_hex, 16);
        // read in plaintext
        fgets(line, 38, file);
        strcpy(p_hex, line+3);
        HexToBin(p_bin, p_hex, 16);
        // read in ciphertext
        fgets(line, 38, file);
        strcpy(c_hex, line+3);
        HexToBin(c_bin, c_hex, 16);
        // do decryption
        a.run(c_bin, k_bin, out_bin);
        //  and compare with the output
        if(memcmp(out_bin, p_bin, 16)==0){
            result[i] = true;
        }else{
            result[i] = false;
            printf("Pattern %d\tfailed:\n", i);
            printf("  Expect = ");
            for(int j=0;j<16;j++){
                printf("%02x", *(p_bin+j));
            }
            printf("\n");
            printf("  Output = ");
            for(int j=0;j<16;j++){
                printf("%02x", *(out_bin+j));
            }
            printf("\n==\n");
            all_pass = false;
        }
        fgets(line, 38, file);
    }

    if(all_pass){
        printf("All testcases passed!!!\n");
    }else{
        printf("Some testcases failed...\n");
    }

    return 0;
}

