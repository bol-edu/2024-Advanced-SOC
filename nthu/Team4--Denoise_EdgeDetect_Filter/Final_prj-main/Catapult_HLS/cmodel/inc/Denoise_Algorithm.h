#include <stdio.h>
#include <stdlib.h>
#include <math.h>

class Denoise_Filter
{
  // Define some "constants" for use in algorithm
  enum {
    imageWidth  = 1296,
    imageHeight =  864
  };

public:
  // Constructor
  Denoise_Filter() {}

  //--------------------------------------------------------------------------
  // Function: run
  //   Top interface for data in/out of class. Apply Gaussian filter to the input image.
  void run(unsigned char        *dat_in,      // image data (streamed in by pixel)
           unsigned char        *filtered,
           int                  *ctrl_signal)    // filtered image output
  {
    if(*ctrl_signal == 0){
        filtered = dat_in;
    }else if(*ctrl_signal == 1){
        GaussianFilter(dat_in, filtered);
    }else if(*ctrl_signal == 2){
        MediumFilter(dat_in, filtered);
    }
  }

private: // Helper functions

  //--------------------------------------------------------------------------
  // Function: GaussianFilter
  //   Apply Gaussian filter to the input image
  void GaussianFilter(unsigned char    *dat_in,
                      unsigned char    *filtered) 
  {
    // Gaussian kernel
    double kernel[3][3] = {
        {0.045, 0.122, 0.045},
        {0.122, 0.332, 0.122},
        {0.045, 0.122, 0.045}
    };

    // process the image pixel
    for (int y = 0; y < imageHeight; y++) {
        for (int x = 0; x < imageWidth; x++) {
            double sum = 0;
            // Around the processed image pixel 3X3 
            for (int ky = -1; ky <= 1; ky++) {
                for (int kx = -1; kx <= 1; kx++) {
                    /*
                        (x-1, y+1) (x, y+1) (x+1, y+1)
                        (x-1, y)   (x, y)   (x+1, y)
                        (x-1, y-1) (x, y-1) (x+1, y-1)

                        dat_in => [(0, 0), (1, 0)..., (imageWidth, 0)] [(0, 1), ..., (imageWidth, 1)] [(0,2), ...] ... 

                        (x, y) => dat_in[y*imageWidth + x]
                    */
                    sum += kernel[ky + 1][kx + 1] * dat_in[clip(y + ky, imageHeight-1) * imageWidth + clip(x + kx, imageWidth-1)];
                }
            }
            filtered[y * imageWidth + x] = sum;
        }
    }
  }

  //--------------------------------------------------------------------------
  // Function: MediumFilter
  //   Apply Medium filter to the input image
  void MediumFilter(unsigned char  *dat_in,
                    unsigned char  *filtered) 
  {
    // process the image pixel 
    for (int y = 0; y < imageHeight; y++) {
      for (int x = 0; x < imageWidth; x++) {
        int y_m1 = clip(y-1, imageHeight); int y_p1 = clip(y+1, imageHeight);
        int x_m1 = clip(x-1, imageWidth);  int x_p1 = clip(x+1, imageWidth);

        unsigned char window[9] = {
          dat_in[y_m1 * imageWidth + x_m1],   dat_in[y_m1 * imageWidth + x],   dat_in[y_m1 * imageWidth + x_p1],
          dat_in[y * imageWidth + x_m1],      dat_in[y * imageWidth + x],      dat_in[y * imageWidth + x_p1],
          dat_in[y_p1 * imageWidth + x_m1],   dat_in[y_p1 * imageWidth + x],   dat_in[y_p1 * imageWidth + x_p1]
        };
        quickSort(window, 0, 8);
        filtered[y * imageWidth + x] = window[4]; // Pick the median value
      }
    }
  }

  // Quick Sort for 9 element 
  void quickSort(unsigned char* arr, int low, int high) {
    if (low < high) {
        int pivot = partition(arr, low, high);
        quickSort(arr, low, pivot - 1);
        quickSort(arr, pivot + 1, high);
    }
  } 
  void swap(unsigned char* a, unsigned char* b) {
    unsigned char tmp = *a;
    *a = *b;
    *b = tmp;
  }

  int partition(unsigned char* arr, int low, int high) {
    int pivot = arr[high];
    int i = low;
    for (int j = low; j < high; j += 1) {
        if (arr[j] < pivot) {
            swap(&arr[i], &arr[j]);
            i += 1;
        }
    }
    swap(&arr[i], &arr[high]);
    return i;
  }

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
