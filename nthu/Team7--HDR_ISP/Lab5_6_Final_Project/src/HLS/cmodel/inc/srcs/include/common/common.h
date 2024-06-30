#ifndef ISP_COMMON_H
#define ISP_COMMON_H

#include "/home/course/ee525201/final_project/ISP1/cmodel/inc/thirdparty/easylog/easylogging++.h"
#include "/home/course/ee525201/final_project/ISP1/cmodel/inc/srcs/include/common/types.h"

#define FOR_ITER(index, max) for (int index = 0; index < max; ++index)
#define GET_PIXEL_INDEX(iw, ih, width) ((ih) * (width) + (iw))

template <class _T>
static inline void SwapMem(_T *&a, _T *&b)
{
    _T *tmp = b;
    b = a;
    a = tmp;
}

template <class _T>
static inline _T Min(_T a, _T b)
{
    return (a > b ? b : a);
}


template <class _T>
static inline void ClipMinMax(_T &a, _T max, _T min)
{
    if (a > max)
    {
        a = max;
    }
    else if (a < min)
    {
        a = min;
    }
}

size_t ReadFileToMem(std::string file_name, void *mem, int size);
size_t WriteMemToFile(std::string file_name, void *mem, int size);

#endif /* ISP_COMMON_H */
