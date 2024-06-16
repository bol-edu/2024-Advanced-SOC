#ifndef _ENCRYPT__H
#define _ENCRYPT__H

#include <ac_int.h>
#include <ac_channel.h>
#include <mc_scverify.h>

#pragma hls_design top
class Encrypt_Top
{
private:
	ac_int<64, false> IV;
	ac_int<64, false> key[2];
	ac_int<64, false> constant[16];
	ac_int<64, false> state[5];
	ac_int<64, false> t[5];
	ac_int<64, false> associated_data;
	ac_int<64, false> plaintext;
	ac_int<64, false> ciphertext;
	uint32 msw_a, lsw_a, msw_p, lsw_p, msw_c, lsw_c;

public:
	Encrypt_Top() {
		IV = 0x80400c0600000000;
		constant[0] = 0xf0;
		constant[1] = 0xe1;
		constant[2] = 0xd2;
		constant[3] = 0xc3;
		constant[4] = 0xb4;
		constant[5] = 0xa5;
		constant[6] = 0x96;
		constant[7] = 0x87;
		constant[8] = 0x78;
		constant[9] = 0x69;
		constant[10] = 0x5a;
		constant[11] = 0x4b;
		constant[12] = 0x3c;
		constant[13] = 0x2d;
		constant[14] = 0x1e;
		constant[15] = 0x0f;
		key[0] = 0;
		key[1] = 0;
		associated_data = 0;
		plaintext = 0;
		ciphertext = 0;
		state[0] = 0;
		state[1] = 0;
		state[2] = 0;
		state[3] = 0;
		state[4] = 0;
	}

	#pragma hls_design interface
	void CCS_BLOCK(run)(uint32 key1,
						uint32 key2,
						uint32 key3,
						uint32 key4,
						uint32 nonce1,
						uint32 nonce2,
						uint32 nonce3,
						uint32 nonce4,
						uint8 adlen,
						uint8 plen,
						ac_channel<uint32> &data_in,
						ac_channel<uint32> &data_out)
	{
		key[0].set_slc(32, key1);
		key[0].set_slc(0, key2);
		key[1].set_slc(32, key3);
		key[1].set_slc(0, key4);
		
		state[0] = IV;
		state[1] = key[0];
		state[2] = key[1];
		state[3].set_slc(32, nonce1);
		state[3].set_slc(0, nonce2);
		state[4].set_slc(32, nonce3);
		state[4].set_slc(0, nonce4);
		
		// Initialization
		INIT_P12: for (int i=0; i<12; i++) {
			// add_constant
			state[2] = state[2] ^ constant[i];
			// sbox
			sbox(state);
			// linear
			linear(state);
		}
		state[3] = state[3] ^ key[0];
		state[4] = state[4] ^ key[1];
		
		/*for(int i = 0; i < 5; i++) {
			printf("%llx\n", state[i]);
		}
		printf("\n");*/
		
		// Associated data
		ADLEN: for (int i=0; ; i++) {
			#pragma hls_pipeline_init_interval 1
			msw_a = data_in.read();
			lsw_a = data_in.read();
			associated_data.set_slc(32,  msw_a);
			associated_data.set_slc(0, lsw_a);
			state[0] = associated_data ^ state[0];
			AD_P6: for (int j=0; j<6; j++) {
				// add_constant
				state[2] = state[2] ^ constant[j+6];
				// sbox
				sbox(state);
				// linear
				linear(state);
			}
			if (i==adlen-1)
				break;
		}
		state[4] = state[4] ^ 1;
		
		/*for(int i = 0; i < 5; i++) {
			printf("%llx\n", state[i]);
		}
		printf("\n");*/
		
		// Encrypt
		//ciphertext[0] = plaintext[0] ^ state[0];
		msw_p = data_in.read();
		lsw_p = data_in.read();
		plaintext.set_slc(32,  msw_p);
		plaintext.set_slc(0, lsw_p);
		ac_int<64, false> ciphertext = plaintext ^ state[0];
		msw_c = ciphertext.slc<32>(32);
		lsw_c = ciphertext.slc<32>(0);
		data_out.write(msw_c);
		data_out.write(lsw_c);
		PLEN: for (int i=1; ; i++) {
			#pragma hls_pipeline_init_interval 1
			msw_p = data_in.read();
			lsw_p = data_in.read();
			plaintext.set_slc(32,  msw_p);
			plaintext.set_slc(0, lsw_p);
			ENC_P6: for (int j=0; j<6; j++) {
				// add_constant
				state[2] = state[2] ^ constant[j+6];
				// sbox
				sbox(state);
				// linear
				linear(state);
			}
			ciphertext = plaintext ^ state[0];
			state[0] = ciphertext;
			msw_c = ciphertext.slc<32>(32);
			lsw_c = ciphertext.slc<32>(0);
			data_out.write(msw_c);
			data_out.write(lsw_c);
			if (i==plen-1)
				break;
		}
		
		/*for(int i = 0; i < 5; i++) {
			printf("%llx\n", state[i]);
		}
		printf("\n");*/
		
		// Finalization
		state[1] = state[1] ^ key[0];
		state[2] = state[2] ^ key[1];
		FINAL_P12: for (int i=0; i<12; i++) {
			// add_constant
			state[2] = state[2] ^ constant[i];
			// sbox
			sbox(state);
			// linear
			linear(state);
		}
		state[3] = state[3] ^ key[0];
		state[4] = state[4] ^ key[1];
		
		/*for(int i = 0; i < 5; i++) {
			printf("%llx\n", state[i]);
		}
		printf("\n");*/
		
		data_out.write(state[3].slc<32>(32));
		data_out.write(state[3].slc<32>(0));
		data_out.write(state[4].slc<32>(32));
		data_out.write(state[4].slc<32>(0));
		//tag1 = state[3];
		//tag2 = state[4];
	}

	void sbox(ac_int<64, false> state[5]) {
		/*state[0] ^= state[4];    state[4] ^= state[3];    state[2] ^= state[1];
		t[0]  = state[0];    t[1]  = state[1];    t[2]  = state[2];    t[3]  = state[3];    t[4]  = state[4];
		t[0] =~ t[0];    t[1] =~ t[1];    t[2] =~ t[2];    t[3] =~ t[3];    t[4] =~ t[4];
		t[0] &= state[1];    t[1] &= state[2];    t[2] &= state[3];    t[3] &= state[4];    t[4] &= state[0];
		state[0] ^= t[1];    state[1] ^= t[2];    state[2] ^= t[3];    state[3] ^= t[4];    state[4] ^= t[0];
		state[1] ^= state[0];    state[0] ^= state[4];    state[3] ^= state[2];    state[2] =~ state[2];*/
		t[0] = state[0]; t[1] = state[1]; t[2] = state[2]; t[3] = state[3]; t[4] = state[4];
		state[0] = (t[4] & t[1]) ^ t[3] ^ (t[2] & t[1]) ^ t[2] ^ (t[1] & t[0]) ^ t[1] ^ t[0];
		state[1] = t[4] ^ (t[2] & t[3]) ^ t[3] ^ (t[3] & t[1]) ^ t[2] ^ (t[1] & t[2]) ^ t[1] ^ t[0] ;
		state[2] = (t[4] & t[3]) ^ t[4] ^ t[2] ^ t[1] ^ 0xffffffffffffffff;
		state[3] = (t[4] & t[0]) ^ (t[3] & t[0]) ^ t[4] ^ t[3] ^ t[2] ^ t[1] ^ t[0];
		state[4] = (t[4] & t[1]) ^ t[4] ^ t[3] ^ (t[1] & t[0]) ^ t[1];
	}

	void linear(ac_int<64, false> state[5]) {
		state[0] = state[0] ^ (state[0] >> 19 | state[0] << 45) ^ (state[0] >> 28 | state[0] << 36);
		state[1] = state[1] ^ (state[1] >> 61 | state[1] << 3) ^ (state[1] >> 39 | state[1] << 25);
		state[2] = state[2] ^ (state[2] >> 1 | state[2] << 63) ^ (state[2] >> 6 | state[2] << 58);
		state[3] = state[3] ^ (state[3] >> 10 | state[3] << 54) ^ (state[3] >> 17 | state[3] << 47);
		state[4] = state[4] ^ (state[4] >> 7 | state[4] << 57) ^ (state[4] >> 41 | state[4] << 23);
	}

};
#endif