#include "Encrypt.h"

CCS_MAIN(int argc, char *argv[])
{
	uint32 key[4], nonce[4];
	uint8 adlen, plen;
	ac_channel<uint32> data_in_chn;
	ac_channel<uint32> data_out_chn;  
	uint32 data_in, data_out;

	Encrypt_Top dut;

	adlen = 2;
	plen = 30;
	key[0] = 0;
	key[1] = 0;
	key[2] = 0;
	key[3] = 0;
	nonce[0] = 0;
	nonce[1] = 1;
	nonce[2] = 0;
	nonce[3] = 2;
	uint32 associated_data[4] = {0, 0x787878, 0, 0x878787};
	uint32 plaintext[4] = {0x12345678, 0x90abcdef, 0x12345678, 0x90abcdef};
	
	for (int i=0; i<adlen; i++) {
		data_in = associated_data[i*2];
		printf("Associated Data %2d: %x\n", i*2, data_in);
		data_in_chn.write(data_in);
		data_in = associated_data[i*2+1];
		printf("Associated Data %2d: %x\n", i*2+1, data_in);
		data_in_chn.write(data_in);
	}
	
	for (int i=0; i<plen; i++) {
		//data_in = plaintext[i*2];
		data_in = 0x12345678;
		printf("Plaintext Data %2d: %x\n", i*2, data_in);
		data_in_chn.write(data_in);
		//data_in = plaintext[i*2+1];
		data_in = 0x90abcdef;
		printf("Plaintext Data %2d: %x\n", i*2+1, data_in);
		data_in_chn.write(data_in);
	}
	
	dut.run(key[0], key[1], key[2], key[3], nonce[0], nonce[1], nonce[2], nonce[3], adlen, plen, data_in_chn, data_out_chn);
		
	for (int i=0; i<plen; i++) {
		data_out = data_out_chn.read();
		printf("Ciphertext %2d: %x\n", i*2, data_out);
		data_out = data_out_chn.read();
		printf("Ciphertext %2d: %x\n", i*2+1, data_out);
	}
	
	data_out = data_out_chn.read();
	printf("Tag1_0 %x\n", data_out);
	data_out = data_out_chn.read();
	printf("Tag1_1 %x\n", data_out);
	data_out = data_out_chn.read();
	printf("Tag2_0 %x\n", data_out);
	data_out = data_out_chn.read();
	printf("Tag2_1 %x\n", data_out);
	
	printf("Finish!\n");

	CCS_RETURN(0);
}
