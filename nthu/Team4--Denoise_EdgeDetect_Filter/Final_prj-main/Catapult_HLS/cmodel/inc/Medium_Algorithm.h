#include <stdio.h>
#include <stdlib.h>
#include <algorithm>

class MediumFilter_Algo
{
  // Define some "constants" for use in algorithm
  enum {
    imageWidth  = 1296,
    imageHeight =  864
  };

public:
  // Constructor
  MediumFilter_Algo() {}

  //--------------------------------------------------------------------------
  // Function: run
  //   Top interface for data in/out of class. Apply Medium filter to the input image.
  void run(unsigned char        *dat_in,  // image data (streamed in by pixel)
           unsigned char        *filtered) // filtered image output
  {
    MediumFilter(dat_in, filtered);
  }

private: // Helper functions

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
