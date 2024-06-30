#include <stdio.h>
#include <stdlib.h>
#include <math.h>

class GaussianFilter_Algo
{
  // Define some "constants" for use in algorithm
  enum {
    imageWidth  = 1296,
    imageHeight =  864
  };

public:
  // Constructor
  GaussianFilter_Algo() {}

  //--------------------------------------------------------------------------
  // Function: run
  //   Top interface for data in/out of class. Apply Gaussian filter to the input image.
  void run(int           *dat_in,  // image data (streamed in by pixel)
           int        *filtered) // filtered image output
  {
    GaussianFilter(dat_in, filtered);
  }

private: // Helper functions

  //--------------------------------------------------------------------------
  // Function: GaussianFilter
  //   Apply Gaussian filter to the input image
  void GaussianFilter(int    *dat_in,
                      int    *filtered) 
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
