/**************************************************************************
 *                                                                        *
 *  Edge Detect Design Walkthrough for HLS                                *
 *                                                                        *
 *  Software Version: 1.0                                                 *
 *                                                                        *
 *  Release Date    : Tue Jan 14 15:40:43 PST 2020                        *
 *  Release Type    : Production Release                                  *
 *  Release Build   : 1.0.0                                               *
 *                                                                        *
 *  Copyright 2020, Siemens                                               *
 *                                                                        *
 **************************************************************************
 *  Licensed under the Apache License, Version 2.0 (the "License");       *
 *  you may not use this file except in compliance with the License.      * 
 *  You may obtain a copy of the License at                               *
 *                                                                        *
 *      http://www.apache.org/licenses/LICENSE-2.0                        *
 *                                                                        *
 *  Unless required by applicable law or agreed to in writing, software   * 
 *  distributed under the License is distributed on an "AS IS" BASIS,     * 
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or       *
 *  implied.                                                              * 
 *  See the License for the specific language governing permissions and   * 
 *  limitations under the License.                                        *
 **************************************************************************
 *                                                                        *
 *  The most recent version of this package is available at github.       *
 *                                                                        *
 *************************************************************************/
#include <stdio.h>
#include <stdlib.h>

using namespace std;

#include "EdgeDetect_Algorithm.h"
#include "EdgeDetect.h"

#include "bmpUtil/bmp_io.hpp"
#include <fstream>
#include <iostream>
#include <cstdlib>
#include <cmath>
#include <mc_scverify.h>

CCS_MAIN(int argc, char *argv[])
{
  /*
  const int iW = 4;
  const int iH = 4;
  */
  
  const int iW = 1296;
  const int iH = 864;
  EdgeDetect_IP::EdgeDetect_Top               dut;

  unsigned long int width = iW;
  long int height         = iH;

  EdgeDetect_IP::maxWType widthIn = iW;
  EdgeDetect_IP::maxHType heightIn = iH;

  unsigned char *rarray = new unsigned char[iH*iW];
  unsigned char *barray = new unsigned char[iH*iW];

  cout << "Loading Input File" << endl;

  if (argc < 2) {
    cout << "Usage: " << argv[0] << " <inputbmp> <outputbmp_ba>" << endl;
    CCS_RETURN(-1);
  }

  std::string bmpIn(argv[1]);  // input bitmap file
  std::string bmpBA(argv[2]);  // output bitmap (bit-accurate)

  bmp_read((char*)bmpIn.c_str(), &width, &height, &rarray, &garray, &barray);
  assert(width==iW);
  assert(height==iH);

  ac_channel<uint8>            dat_in;
  ac_channel<uint8>            dat_out;
  uint2            ctrl_denoise;
  uint2            ctrl_edgedetect;

  unsigned char *dat_in_orig = new unsigned char[iH*iW];;
  unsigned  cnt = 0;
  for (int y = 0; y < iH; y++) {
    for (int x = 0; x < iW; x++) {
      dat_in.write(rarray[cnt]); // just using red component (pseudo monochrome)
      dat_in_orig[cnt] = rarray[cnt];
      cnt++;
    }
  }
  ctrl_denoise = 0;       //Gaussian Filter
  ctrl_edgedetect = 0;    //Laplacian Filter

#ifdef CCS_SCVERIFY
//  dat_in_wait_ctrl.mode     = mc_wait_ctrl::RANDOM;
//  dat_in_wait_ctrl.cycles   = 5;
//  dat_in_wait_ctrl.elements = mc_wait_ctrl::ALL;
//  dat_in_wait_ctrl.interval = 0;
#endif

  cout << "Running" << endl;

  //ref_inst.run(dat_in_orig,magn_orig,angle_orig);
  dut.run(dat_in,widthIn,heightIn,dat_out,ctrl_denoise, ctrl_edgedetect);

  cnt = 0;
  for (int y = 0; y < heightIn; y++) {
    for (int x = 0; x < iW; x++) {
      int hw = dat_out.read();
      cnt++;
      rarray[cnt] = hw;   // repurposing 'red' array to the bit-accurate monochrome edge-detect output
    }
  }

  cout << "Finish Ctrl_status :" << ctrl_status << endl; 

  cout << "Writing bit-accurate bitmap output to: " << bmpBA << endl;
  bmp_24_write((char*)bmpBA.c_str(), iW,  iH, rarray, rarray, rarray);

  delete (dat_in_orig);
  delete (rarray);
  delete (barray);

  cout << "Finished" << endl;

  CCS_RETURN(0);
}
