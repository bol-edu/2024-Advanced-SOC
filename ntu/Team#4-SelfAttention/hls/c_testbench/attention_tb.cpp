#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <cstdlib>
#include <fstream>
#include <mc_scverify.h>

#include "attention.h"

using namespace std;

CCS_MAIN(int argc, char *argv[])
{
    
    
    ATTENTION_IP::Attention_Top dut;
    
    // LOAD INPUT DATA
    cout << "Load input data" << endl;
    std:ifstream ifs;
    int in_data[86016] = {0};
    ifs.open(argv[1]);
    for (int i=0; i<86016; i++) {
        ifs >> in_data[i];
    }
    
    // DEFINE INPUT
    ATTENTION_IP::headType head = ATTENTION_IP::head_size;
    ATTENTION_IP::lengthType length = ATTENTION_IP::length_size;
    ATTENTION_IP::dimType dim = ATTENTION_IP::dim_size;
    ac_channel<ATTENTION_IP::dataType> din_chan;
    for (int i=0; i<head*3*length*dim; i++) {
        din_chan.write(in_data[i]);
    }
    ac_channel<ATTENTION_IP::dataType> dout_chan;
    
    // START RUNNING
    cout << "Running" << endl;
    dut.run(head, length, dim, din_chan, dout_chan);
    
    
    // receving output
    ATTENTION_IP::dataType out_data;
    for (int i=0; i<8*56*64; i++) {
        if (dout_chan.available(1)) {
            if (dout_chan.available(1)) {
                out_data = dout_chan.read();
                if (i<64) cout << out_data << endl;
            }
        }
    }
    
    cout << "Finished" << endl;
    cout << "0805" << endl;

    CCS_RETURN(0);
}
