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
#ifndef _INCLUDED_EDGEDETECT_ALGORITHM_H_
#define _INCLUDED_EDGEDETECT_ALGORITHM_H_

// Revision History
//    Rev 1 - Coding of edge detection algorithm in C++

#include <cstring>
#include <iostream>
#include <math.h>
#include <stdlib.h>
// Include constant kernel definition
#include "edge_defs.h"

// Template parameters allow configuring the maximum image size
template <int maxImageWidth, int maxImageHeight>
class EdgeDetect_Algorithm
{
  // Define some "constants" for use in algorithm
  enum {
    imageWidth  = 1296,
    imageHeight =  864,
    kmeanBit =  3,
    iterationNum=1
  };
public:
  // Constructor
  EdgeDetect_Algorithm() {}

  //--------------------------------------------------------------------------
  // Function: run
  //   Top interface for data in/out of class. Combines vertical and 
  //   horizontal derivative and magnitude/angle computation.
  void run(unsigned char *dat_in_r,  // image data (streamed in by pixel)
           unsigned char *dat_in_g,  // image data (streamed in by pixel)
           unsigned char *dat_in_b,  // image data (streamed in by pixel)
           unsigned char *magn,    // magnitude output
           double        *angle,
           double *kmean_out_r,
           double *kmean_out_g,
           double *kmean_out_b
           )   // angle output
  {
    // allocate buffers for image data
    unsigned char *dat_in = (unsigned char *)malloc(maxImageHeight*maxImageWidth*sizeof(unsigned char));
    unsigned char *kmean_temp_r = (unsigned char *)malloc(maxImageHeight*maxImageWidth*sizeof(unsigned char));
    unsigned char *kmean_temp_g = (unsigned char *)malloc(maxImageHeight*maxImageWidth*sizeof(unsigned char));
    unsigned char *kmean_temp_b = (unsigned char *)malloc(maxImageHeight*maxImageWidth*sizeof(unsigned char));
    double *dy = (double *)malloc(maxImageHeight*maxImageWidth*sizeof(double));
    double *dx = (double *)malloc(maxImageHeight*maxImageWidth*sizeof(double));
    image2gray(dat_in_r,dat_in_g,dat_in_b,dat_in);
    verticalDerivative(dat_in, dy);
    horizontalDerivative(dat_in, dx);
    magnitudeAngle(dx, dy, magn, angle);

    comic(dat_in_r,kmean_temp_r);
    comic(dat_in_g,kmean_temp_g);
    comic(dat_in_b,kmean_temp_b);
    mixRGB( kmean_temp_r,
            kmean_temp_g,
            kmean_temp_b,
            magn,
            kmean_out_r,
            kmean_out_g,
            kmean_out_b
            );
    // free(dy);
    // free(dx);
  }
  //--------------------------------------------------------------------------
  // Function: image to gray code
  //   Compute the vertical derivative on the input data
void mixRGB(unsigned char *kmean_temp_r,
            unsigned char *kmean_temp_g,
            unsigned char *kmean_temp_b,
            unsigned char *magn,
            double *kmean_out_r,
            double *kmean_out_g,
            double *kmean_out_b
) {
      for (int y = 0; y < imageHeight; y++) {
        for (int x = 0; x < imageWidth; x++) {
            kmean_out_r[y * imageWidth + x]=kmean_temp_r[y * imageWidth + x]&magn[y * imageWidth + x];
            kmean_out_g[y * imageWidth + x]=kmean_temp_g[y * imageWidth + x]&magn[y * imageWidth + x];
            kmean_out_b[y * imageWidth + x]=kmean_temp_b[y * imageWidth + x]&magn[y * imageWidth + x];
          }
          // cout<<kmean_temp_r[y * imageWidth];
    }
}

void comic(unsigned char *dat_in_kmean, unsigned char *out) {
    // 分配足够存放一行像素数据的内存
    unsigned char *data = (unsigned char *)malloc(imageWidth * sizeof(unsigned char));
    unsigned char *cluster_list = (unsigned char *)malloc(kmeanBit * sizeof(unsigned char));
    // 正确的out_temp内存分配
    unsigned char *out_temp = (unsigned char *)malloc(imageWidth * sizeof(unsigned char));
    if (!data || !cluster_list || !out_temp) {
        std::cerr << "内存分配失败。" << std::endl;
        return;
    }

    for (int y = 0; y < imageHeight; y++) {
        for(int c_i=0;c_i<kmeanBit;c_i++){
          cluster_list[c_i] = dat_in_kmean[y * imageWidth + (imageWidth>>c_i)-1];

        }

        for (int x = 0; x < imageWidth; x++) {
            data[x] = dat_in_kmean[y * imageWidth + x];
        }
        // cout<<endl;
        // if(y==1)
        kmean(data, cluster_list, out_temp);


        // cout<<"\n";
        // 使用正确的字节数进行内存拷贝
        // memcpy(out + y * imageWidth, out_temp, imageWidth * sizeof(unsigned char));
        for (int x = 0; x < imageWidth; x++) {
          out[x+y * imageWidth]=out_temp[x];
            // cout <<int(out[x+y * imageWidth])<<" ";
        }
    }

    // free(data);
    // free(cluster_list);
    // free(out_temp);
}
void kmean(unsigned char *data, unsigned char *cluster_list, unsigned char *out) {
    int *intData = new int[imageWidth];  // 存储转换后的数据
    for (int i = 0; i < imageWidth; i++) {
        intData[i] = int(data[i]);  // 将 unsigned char 转换为 int
    }

    double *D = new double[kmeanBit]; // 存放迭代计算中的距离变量
    int *N = new int[kmeanBit](); // 统计每个模式类中的模式样本数
    int tempIndex[imageWidth]; // 临时存放每个数据点的聚类索引
    // float clusterListInt[3] = {0};  // int 类型的聚类中心
    // float clusterListInt[3] = cluster_list;  // int 类型的聚类中心
    float clusterListInt[kmeanBit]; // int 类型的聚类中心
    for (int i = 0; i < kmeanBit; i++) {
        clusterListInt[i] = static_cast<float>(cluster_list[i]); // 将 unsigned char 转换为 float
        // cout<<clusterListInt[i]<<endl;
    }
    for (int iteration = 0; iteration < iterationNum; iteration++) {
        for (int i = 0; i < kmeanBit; i++) { // 初始化聚类样本数统计
            N[i] = 0;
            // clusterListInt[i] = 0;  // 重置聚类中心
        }

        // 分别计算各点与聚类中心的距离
        for (int i = 0; i < imageWidth; i++) {
            for (int j = 0; j < kmeanBit; j++) {
                D[j] = abs(intData[i] - clusterListInt[j]); // 计算距离
                // cout <<int(D[i])<<"|"<<int(i)<<" ";
            }

            int minIndex = 0;
            for (int j = 1; j < kmeanBit; j++) {
                if (D[minIndex] > D[j]) minIndex = j;
            }
            tempIndex[i] = minIndex; // 保存最近的聚类中心索引
            N[minIndex]++; // 该聚类的样本数加1
        }

        // 计算新的聚类中心
        for (int i = 0; i < imageWidth; i++) {
            clusterListInt[tempIndex[i]] += intData[i];
        }

        for (int i = 0; i < kmeanBit; i++) {
            if (N[i] > 0) {
                clusterListInt[i] /= N[i]; // 平均值作为新的聚类中心
            }
        }
      //   for (int i = 0; i <kmeanBit; i++) {
      //     cout<<clusterListInt[i]<<" ";
      //   }
      // cout<<endl;
    }

    for (int i = 0; i < imageWidth; i++) {
        out[i] = static_cast<unsigned char>(clusterListInt[tempIndex[i]]);  // 将聚类中心转换回 unsigned char 类型
        // cout<<int(out[i])<<" ";
    }

    delete[] intData;
    delete[] D;
    delete[] N;
}
  //--------------------------------------------------------------------------
  // Function: image to gray code
  //   Compute the vertical derivative on the input data
  void image2gray(unsigned char *dat_in_r,unsigned char *dat_in_g,unsigned char *dat_in_b,
                        unsigned char *dat_in) 
  {
    for (int y = 0; y < imageHeight; y++) {
      for (int x = 0; x < imageWidth; x++) {
        dat_in[y * imageWidth + x]= int(dat_in_r[y * imageWidth + x]/4)
                                    +int(dat_in_g[y * imageWidth + x]/2)
                                    +int(dat_in_b[y * imageWidth + x]/4);
      }
    }
  }
  //--------------------------------------------------------------------------
  // Function: verticalDerivative
  //   Compute the vertical derivative on the input data
  void verticalDerivative(unsigned char *dat_in,
                        double *dy) 
  {
    for (int y = 0; y < imageHeight; y++) {
      for (int x = 0; x < imageWidth; x++) {
        // Calculate derivative
        *(dy + y * imageWidth + x) =
          dat_in[clip(y - 1, imageHeight-1) * imageWidth + x] * kernel[0] +
          dat_in[y * imageWidth + x]                          * kernel[1] +
          dat_in[clip(y + 1, imageHeight-1) * imageWidth + x] * kernel[2];
      }
    }
  }

  //--------------------------------------------------------------------------
  // Function: horizontalDerivative
  //   Compute the horizontal derivative on the input data
  void horizontalDerivative(unsigned char *dat_in, 
                          double *dx) 
  {
    for (int y = 0; y < imageHeight; y++) {
      for (int x = 0; x < imageWidth; x++) {
        // Calculate derivative
        *(dx + y * imageWidth + x) =
          dat_in[y * imageWidth + clip(x - 1, imageWidth-1)] * kernel[0] +
          dat_in[y * imageWidth + x]                         * kernel[1] +
          dat_in[y * imageWidth + clip(x + 1, imageWidth-1)] * kernel[2];
      }
    }
  }

  //--------------------------------------------------------------------------
  // Function: magnitudeAngle
  //   Compute the magnitute and angle based on the horizontal and vertical
  //   derivative results
  void magnitudeAngle(double *dx, 
                      double *dy, 
                      unsigned char *magn, 
                      double *angle) 
  {
    double dx_sq;
    double dy_sq;
    //double sum;
    for (int y = 0; y < imageHeight; y++) {
      for (int x = 0; x < imageWidth; x++) {
    dx_sq = dx[y * imageWidth + x];  // 獲取 dx 在 (y, x) 位置的值
    dy_sq = dy[y * imageWidth + x];  // 獲取 dy 在 (y, x) 位置的值
        //sum = abs(dx_sq) + abs(dy_sq);
        if((abs(dx_sq) + abs(dy_sq))>100)
        *(magn + y * imageWidth + x) = 0;
        else
        *(magn + y * imageWidth + x)=255;

        *(angle + y * imageWidth + x) = atan2(dy[y * imageWidth + x], dx[y * imageWidth + x]);
      }
    }
  }

private: // Helper functions

  //--------------------------------------------------------------------------
  // Function: clip
  //   Perform boundary processing by "adjusting" the index value to "clip"
  //   at either end
  int clip(int i, int bound) {
    if (i < 0) {
      return 0;               // clip to the top/left value
    } else if (i >= bound) {
      return bound;           // clip to the bottom/right value
    } else {
      return i;               // return all others untouched
    }
  }

};

#endif