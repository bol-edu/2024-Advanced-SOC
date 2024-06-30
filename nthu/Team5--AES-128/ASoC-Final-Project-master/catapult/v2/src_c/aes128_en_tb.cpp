#include "aes_defs.h"
#include "aes128_en_v2.h"
#include <stdio.h>
#include <iostream>
#include <stdlib.h>
#include <string.h>
#include "ac_channel.h"
#include "ac_int.h"
#include <mc_scverify.h>

using namespace std;

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

ac_int<128,false> BinToACINT(BYTE *binBlock){
    ac_int<128,false> a;
    ac_int<8,false> t;
    for(int i=0;i<16;i++){
        t = *(binBlock+i);
        a.set_slc(120-i*8,t);
    }
    return a;
}

bool result[128];
bool all_pass;
BYTE k_bin[16];
BYTE p_bin[16];
BYTE c_bin[16];
char k_hex[32];
char p_hex[32];
char c_hex[32];
ac_int<128,false> key;
ac_int<128,false> pt;
ac_int<128,false> ct;
ac_int<128,false> out;

CCS_MAIN(int argc, char *argv){
    ac_channel<ac_int<128,false>> key_in_chn;
    ac_channel<ac_int<128,false>> pt_in_chn;
    ac_channel<ac_int<128,false>> ct_out_chn;
    AES128_EN a;
    FILE *file;
    char line[38] = {0};
    file = fopen("src_c/128_ecb_tbl.txt", "r");
    if(file==NULL){
        cout << "Error opening file";
        CCS_RETURN(1);
    }
    all_pass = true;
    // repeats test for 128 times
    for(int i=0;i<=128;i++){
        fgets(line, 38, file);

        // read in key
        fgets(line, 38, file);
        strcpy(k_hex, line+4);
        HexToBin(k_bin, k_hex, 16);
        key = BinToACINT(k_bin);
        key_in_chn.write(key);

        // read in plaintext
        fgets(line, 38, file);
        strcpy(p_hex, line+3);
        HexToBin(p_bin, p_hex, 16);
        pt = BinToACINT(p_bin);
        pt_in_chn.write(pt);

        // do encryption
        a.run(pt_in_chn, key_in_chn, ct_out_chn);
        out = ct_out_chn.read();

        // read in ciphertext
        fgets(line, 38, file);
        strcpy(c_hex, line+3);
        HexToBin(c_bin, c_hex, 16);
        ct = BinToACINT(c_bin);

        //  and compare with the output
        if(out==ct){
            result[i] = true;
        }else{
            result[i] = false;
            cout << "Pattern " << i << "\tfailed:\n";
            cout << "  Expect = " << ct << endl;
            cout << "  Output = " << out << endl;
            cout << "\n==\n";
            all_pass = false;
        }
        fgets(line, 38, file);
    }

    if(all_pass){
        cout << "***********************\n";
        cout << "All testcases passed!!!\n";
        cout << "***********************\n";
    }else{
        cout << "************************\n";
        cout << "Some testcases failed...\n";
        cout << "************************\n";
    }

    CCS_RETURN(0);
}

