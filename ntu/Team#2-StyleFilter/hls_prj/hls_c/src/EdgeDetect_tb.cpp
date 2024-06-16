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
  const int iW = 1296;
  const int iH = 864;
  EdgeDetect_Algorithm<iW,iH> ref_inst;
  EdgeDetect_IP::EdgeDetect_Top dut;

  unsigned long int width = iW;
  long int height         = iH;

  EdgeDetect_IP::maxWType widthIn = iW;
  EdgeDetect_IP::maxHType heightIn = iH;

  unsigned char *rarray = new unsigned char[iH*iW];
  unsigned char *garray = new unsigned char[iH*iW];
  unsigned char *barray = new unsigned char[iH*iW];
  
  unsigned char *rarray_rgb = new unsigned char[iH*iW];
  unsigned char *garray_rgb = new unsigned char[iH*iW];
  unsigned char *barray_rgb = new unsigned char[iH*iW];

  unsigned char *kmean_r_array = new unsigned char[iH*iW];
  unsigned char *kmean_g_array = new unsigned char[iH*iW];
  unsigned char *kmean_b_array = new unsigned char[iH*iW];

  cout << "Loading Input File" << endl;

  if (argc < 3) {
    cout << "Usage: " << argv[0] << " <inputbmp> <outputbmp_alg> <outputbmp_ba>" << endl;
    CCS_RETURN(-1);
  }

  std::string bmpIn(argv[1]);  // input bitmap file
  std::string bmpAlg(argv[2]); // output bitmap (algorithm)
  std::string bmpBA(argv[3]);  // output bitmap (bit-accurate)

  bmp_read((char*)bmpIn.c_str(), &width, &height, &rarray, &garray, &barray);
  unsigned char *dat_in_r = new unsigned char[iH*iW];
  unsigned char *dat_in_g = new unsigned char[iH*iW];
  unsigned char *dat_in_b = new unsigned char[iH*iW];
  assert(width==iW);
  assert(height==iH);

  ac_channel<EdgeDetect_IP::Stream_t>            dat_in;
  EdgeDetect_IP::Stream_t temp_data_in;
  ac_channel<EdgeDetect_IP::Stream_t>            dat_out;
  ac_channel<ac_fixed<8,3> >   angle;

  unsigned char *dat_in_orig = new unsigned char[iH*iW];;
  unsigned char *magn_orig = new unsigned char[iH*iW];
  double *kmean_out_r = new double[iH*iW];
  double *kmean_out_g = new double[iH*iW];
  double *kmean_out_b = new double[iH*iW];
  double *angle_orig = new double[iH*iW];
  unsigned  cnt = 0;
  for (int y = 0; y < iH; y++) {
    for (int x = 0; x < iW; x++) {
      dat_in_r[cnt] = rarray[cnt];
      dat_in_g[cnt] = garray[cnt];
      dat_in_b[cnt] = barray[cnt];
        // R << int(rarray[cnt]) << " "; 
        // G << int(garray[cnt]) << " "; 
        // B << int(barray[cnt]) << " "; 
        cnt++;
    }
    // R<<endl;
    // G<<endl;
    // B<<endl;
  }
  cnt = 0;
  
  for (int y = 0; y < iH; y++) {
    for (int x = 0; x < iW; x++) {
      temp_data_in.r_pixelType=rarray[cnt];
      temp_data_in.g_pixelType=garray[cnt];
      temp_data_in.b_pixelType=barray[cnt];
      temp_data_in.sof=(x==0&&y==0);
      temp_data_in.eol=(x==EdgeDetect_IP::maxWType(widthIn-1));
      dat_in.write(temp_data_in); // just using red component (pseudo monochrome)
      dat_in_orig[cnt] = rarray[cnt];
      cnt++;
    }
  }

#ifdef CCS_SCVERIFY
//  dat_in_wait_ctrl.mode     = mc_wait_ctrl::RANDOM;
//  dat_in_wait_ctrl.cycles   = 5;
//  dat_in_wait_ctrl.elements = mc_wait_ctrl::ALL;
//  dat_in_wait_ctrl.interval = 0;
#endif

  cout << "Running" << endl;
  ref_inst.run(dat_in_r,dat_in_g,dat_in_b,magn_orig,angle_orig,kmean_out_r,kmean_out_g,kmean_out_b);
  dut.run(dat_in,widthIn,heightIn,dat_out);

  cnt = 0;
  float sumErr = 0;
  float sumAngErr = 0;
  for (int y = 0; y < heightIn; y++) {
    for (int x = 0; x < iW; x++) {
      EdgeDetect_IP::Stream_t hw = dat_out.read();
      int alg = (int)*(magn_orig+cnt);
      // int diff = alg-hw;
      // int adiff = abs(diff);
      // sumErr += adiff;
      // float angO = (double)*(angle_orig+cnt);
      // float angHw = angle.read().to_double();
      // float angAdiff = abs(angO-angHw);
      // sumAngErr += angAdiff;
      cnt++;
      rarray_rgb[cnt] = hw.r_pixelType;   // repurposing 'red' array to the bit-accurate monochrome edge-detect output
      garray_rgb[cnt] = hw.g_pixelType;   // repurposing 'red' array to the bit-accurate monochrome edge-detect output
      barray_rgb[cnt] = hw.b_pixelType;   // repurposing 'red' array to the bit-accurate monochrome edge-detect output
      garray[cnt] = alg;  // repurposing 'green' array to the original algorithmic edge-detect output
    }
  }
  cnt = 0;

  for (int y = 0; y < iH; y++) {
    for (int x = 0; x < iW; x++) {
      int alg_r = (int)*(kmean_out_r+cnt);
      int alg_g = (int)*(kmean_out_g+cnt);
      int alg_b = (int)*(kmean_out_b+cnt);
      // cout<<(int)*(kmean_out_b+cnt)<<" ";
      cnt++;
      kmean_r_array[cnt] = alg_r;  // repurposing 'green' array to the original algorithmic edge-detect output
      kmean_g_array[cnt] = alg_g;  // repurposing 'green' array to the original algorithmic edge-detect output
      kmean_b_array[cnt] = alg_b;  // repurposing 'green' array to the original algorithmic edge-detect output
        // R << int(alg_r) << " "; 
        // G << int(alg_g) << " "; 
        // B << int(alg_b) << " "; 
    }
    //     R<<endl;
    // G<<endl;
    // B<<endl;
  }
  printf("Magnitude: Manhattan norm per pixel %f\n",sumErr/(iH*iW));
  // printf("Angle: Manhattan norm per pixel %f\n",sumAngErr/(iH*iW));

  cout << "Writing algorithmic bitmap output to: " << bmpAlg << endl;
  // bmp_24_write((char*)bmpAlg.c_str(), iW,  iH, garray, garray, garray);
  bmp_24_write((char*)bmpAlg.c_str(), iW,  iH, kmean_r_array, kmean_g_array, kmean_b_array);
  cout << "Writing bit-accurate bitmap output to: " << bmpBA << endl;
  bmp_24_write((char*)bmpBA.c_str(), iW,  iH, rarray_rgb, garray_rgb, barray_rgb);

  delete (dat_in_orig);
  delete (magn_orig);
  delete (angle_orig);
  delete (rarray);
  delete (garray);
  delete (barray);

  cout << "Finished" << endl;

  CCS_RETURN(0);
}
