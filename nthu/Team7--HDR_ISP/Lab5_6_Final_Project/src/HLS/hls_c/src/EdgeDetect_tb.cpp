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
  //const int iW = 1296;
  //const int iH = 864;
  
  const int maxImageWidth  = EdgeDetect_IP::maxImageWidth;
  const int maxImageHeight = EdgeDetect_IP::maxImageHeight;

  const int FRAME_NUM = 1;

  EdgeDetect_Algorithm<maxImageWidth, maxImageHeight> ref_inst;
  EdgeDetect_IP::EdgeDetect_Top dut;

  unsigned long int width;
  long int height;

  unsigned char *rarray = new unsigned char[maxImageWidth*maxImageHeight];
  unsigned char *garray = new unsigned char[maxImageWidth*maxImageHeight];
  unsigned char *barray = new unsigned char[maxImageWidth*maxImageHeight];
  unsigned char *yarray = new unsigned char[maxImageWidth*maxImageHeight];
           
  unsigned int  crc32_alg_pix_in;
  unsigned int  crc32_alg_dat_out;
 
  uint32  crc32_hw_pix_in;
  uint32  crc32_hw_dat_out;

  cout << "Loading Input File" << endl;
  
  //cout << argv[1] << endl;
  if (argc < 4) {
    cout << "Usage: " << argv[0] << " <inputbmp> <mode> <outputbmp_alg> <outputbmp_ba>" << endl;
    CCS_RETURN(-1);
  }
  //cout << "Test2"<< endl;
  std::string bmpIn(argv[1]);  // input bitmap file
  //cout << "Test2-1"<< endl;
  bool sw_in = atoi(argv[2]);
  //cout << "Test2-2"<< endl;
  std::string bmpAlg(argv[2]); // output bitmap (algorithm)
  //cout << "Test2-3"<< endl;
  //cout << "argv[4] = " << argv[3] << endl;
  std::string bmpBA(argv[4]);  // output bitmap (bit-accurate)
  //cout << "Test2-4"<< endl;
  //cout << "Test3"<< endl;
  cout << "Input file:          " << bmpIn << endl;
  cout << "Mode:                " << sw_in << endl;
  cout << "Output file (alg):   " << bmpAlg << endl;
  cout << "Output file (hw):    " << bmpBA << endl;

  bmp_read((char*)bmpIn.c_str(), &width, &height, &rarray, &garray, &barray);
  EdgeDetect_IP::maxWType widthIn = width;
  EdgeDetect_IP::maxHType heightIn = height;

  cout << "Image width: " << width << endl;
  cout << "Image height: " << height << endl;

  ac_channel<EdgeDetect_IP::Stream_t>  din_chn;
  ac_channel<EdgeDetect_IP::Stream_t>  dout_chn;

  EdgeDetect_IP::Stream_t dat;

  unsigned char *dat_in_orig = new unsigned char[width*height];
  double *magn_orig = new double[width*height];

  unsigned  cnt = 0;
  for (unsigned int y = 0; y < height; y++) {
    for (unsigned int x = 0; x < width; x++) {
      //rgb2yuv
      float y = 0.299*rarray[cnt] + 0.587*garray[cnt] + 0.114*barray[cnt];
      yarray[cnt] = (unsigned char) (y + 0.5);
      //~
      dat_in_orig[cnt] = yarray[cnt];
      cnt++;
    }
  }

  for (unsigned int frm_idx = 0; frm_idx < FRAME_NUM; frm_idx++){ 
    printf("############################################# FRAME NO. %3d ###############################################\n", frm_idx);
  
    cnt = 0;
    EdgeDetect_IP::pixelType4x pix4;
    for (unsigned int y = 0; y < height; y++) {
      for (unsigned int x = 0; x < width; x+=4) {
        pix4.set_slc( 0, (EdgeDetect_IP::pixelType) yarray[cnt+0]);
        pix4.set_slc( 8, (EdgeDetect_IP::pixelType) yarray[cnt+1]);
        pix4.set_slc(16, (EdgeDetect_IP::pixelType) yarray[cnt+2]);
        pix4.set_slc(24, (EdgeDetect_IP::pixelType) yarray[cnt+3]);
        //if (frm_idx == 1)
        //  pix4.set_slc(16, (pixelType) 0);

        dat.pix = pix4;
        dat.sof = (x==0 && y==0);
        dat.eol = (x==width-4);
        din_chn.write(dat); 
        cnt+=4;
      }
    }

    cout << "Running" << endl;

    ref_inst.run(dat_in_orig, width, height, sw_in, crc32_alg_pix_in, crc32_alg_dat_out, magn_orig);
    dut.run(widthIn, heightIn, sw_in, crc32_hw_pix_in, crc32_hw_dat_out, din_chn, dout_chn);

    cnt = 0;
    float sumErr = 0;
    float sumAngErr = 0;
    int sofErr = 0;
    int eolErr = 0;

    for (unsigned int y = 0; y < height; y++) {
      for (unsigned int x = 0; x < width; x+=4) {
         dat = dout_chn.read();
         for (int i=0; i < 4; i++)
         {
           int hw = dat.pix.slc<8>(i*8); 
           int alg = (int)*(magn_orig+cnt+i);
           int diff = alg-hw;
           int adiff = abs(diff);
           sumErr += adiff;
           rarray[cnt+i] = hw;   // repurposing 'red' array to the bit-accurate monochrome edge-detect output
           garray[cnt+i] = alg;  // repurposing 'green' array to the original algorithmic edge-detect output
         }
        if(x==0 && y==0 && dat.sof!=1) sofErr += 1; 
        if(x==width/4-1 && dat.eol!=1) eolErr += 1; 
        cnt += 4;
      }
    }
    
    printf("Magnitude: Manhattan norm per pixel %f\n",sumErr/(width*height));

    cout << "Writing algorithmic bitmap output to: " << bmpAlg << endl;
    bmp_24_write((char*)bmpAlg.c_str(), width, height, garray, garray, garray);

    cout << "Writing bit-accurate bitmap output to: " << bmpBA << endl;
    bmp_24_write((char*)bmpBA.c_str(), width, height, rarray, rarray, rarray);

    cout << "sofErr: " << sofErr << " eolErr: " << eolErr << endl;

    fprintf(stdout, "crc32_alg_pix_in  = %08x  crc32_hw_pix_in  = %08x\n", (unsigned int) crc32_alg_pix_in,  (unsigned int) crc32_hw_pix_in);
    fprintf(stdout, "crc32_alg_dat_out = %08x  crc32_hw_dat_out = %08x\n", (unsigned int) crc32_alg_dat_out, (unsigned int) crc32_hw_dat_out);
    
    //write input and output raw image for RTL simulation
    FILE *fp_in_img;
    FILE *fp_out_img;
    FILE *fp_crc_in_img;
    FILE *fp_crc_out_img;
    char file_name[100];
    
    //sprintf(file_name,"in_img_%0d.hex", frm_idx);
    //fp_in_img = fopen(file_name, "w");
    //sprintf(file_name,"out_img_%0d.hex",frm_idx);
    //fp_out_img = fopen(file_name, "w");
    //sprintf(file_name,"crc32_in_img_%0d.hex",frm_idx);
    //fp_crc_in_img = fopen(file_name, "w");
    //sprintf(file_name,"crc32_out_img_%0d.hex",frm_idx);
    //fp_crc_out_img = fopen(file_name, "w");
  
    sprintf(file_name,"in_img.hex");
    fp_in_img = fopen(file_name, "w");
    sprintf(file_name,"out_img.hex");
    fp_out_img = fopen(file_name, "w");
    sprintf(file_name,"crc32_in_img.hex");
    fp_crc_in_img = fopen(file_name, "w");
    sprintf(file_name,"crc32_out_img.hex");
    fp_crc_out_img = fopen(file_name, "w");
  
    cnt = 0;
    for (unsigned int y = 0; y < height; y++) 
      for (unsigned int x = 0; x < width; x++)
      {
        fprintf(fp_in_img,  "%02x\n", yarray[cnt]);
        fprintf(fp_out_img, "%02x\n", rarray[cnt]);
        cnt++;
      }
   
    fprintf(fp_crc_in_img,   "%08x\n", (unsigned int) crc32_hw_pix_in );
    fprintf(fp_crc_out_img,  "%08x\n", (unsigned int) crc32_hw_dat_out);

    fclose(fp_in_img);
    fclose(fp_out_img);
    fclose(fp_crc_in_img);
    fclose(fp_crc_out_img);
    //

  } //frm

  delete (dat_in_orig);
  delete (magn_orig);
  delete (rarray);
  delete (garray);
  delete (barray);
  delete (yarray);

  cout << "Finished" << endl;

  CCS_RETURN(0);
}
