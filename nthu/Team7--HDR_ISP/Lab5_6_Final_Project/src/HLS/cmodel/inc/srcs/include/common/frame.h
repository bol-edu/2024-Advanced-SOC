#ifndef ADAS_ISP_FRAME_H
#define ADAS_ISP_FRAME_H

#include "/home/course/ee525201/final_project/ISP1/cmodel/inc/srcs/include/common/common.h"

#define SAFE_FREE(arr)     \
    do                     \
    {                      \
        if (arr)           \
        {                  \
            delete[] arr;  \
            arr = nullptr; \
        }                  \
    } while (0)

class Frame
{
private:
    int FrameDateMalloc(int width, int height);
public:
    ImageInfo info;
    ImageMem data;

public:
    Frame(ImageInfo &img_info);

    ~Frame();

    int ReadFileToFrame(std::string file, int size);

    int RawMemToFrame(void *src, int len);
};

#endif // !ADAS_ISP_FRAME_H