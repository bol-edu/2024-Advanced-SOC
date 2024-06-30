#include "hls_signal_handler.h"
#include <algorithm>
#include <cassert>
#include <fstream>
#include <iostream>
#include <list>
#include <map>
#include <vector>
#include "ap_fixed.h"
#include "ap_int.h"
#include "hls_stream.h"
using namespace std;

namespace hls::sim
{
  template<size_t n>
  struct Byte {
    unsigned char a[n];

    Byte()
    {
      for (size_t i = 0; i < n; ++i) {
        a[i] = 0;
      }
    }

    template<typename T>
    Byte<n>& operator= (const T &val)
    {
      std::memcpy(a, &val, n);
      return *this;
    }
  };

  struct SimException : public std::exception {
    const std::string msg;
    const size_t line;
    SimException(const std::string &msg, const size_t line)
      : msg(msg), line(line)
    {
    }
  };

  void errExit(const size_t line, const std::string &msg)
  {
    std::string s;
    s += "ERROR";
//  s += '(';
//  s += __FILE__;
//  s += ":";
//  s += std::to_string(line);
//  s += ')';
    s += ": ";
    s += msg;
    s += "\n";
    fputs(s.c_str(), stderr);
    exit(1);
  }
}


namespace hls::sim
{
  struct Buffer {
    char *first;
    Buffer(char *addr) : first(addr)
    {
    }
  };

  struct DBuffer : public Buffer {
    static const size_t total = 1<<10;
    size_t ufree;

    DBuffer(size_t usize) : Buffer(nullptr), ufree(total)
    {
      first = new char[usize*ufree];
    }

    ~DBuffer()
    {
      delete[] first;
    }
  };

  struct CStream {
    char *front;
    char *back;
    size_t num;
    size_t usize;
    std::list<Buffer*> bufs;
    bool dynamic;

    CStream() : front(nullptr), back(nullptr),
                num(0), usize(0), dynamic(true)
    {
    }

    ~CStream()
    {
      for (Buffer *p : bufs) {
        delete p;
      }
    }

    template<typename T>
    T* data()
    {
      return (T*)front;
    }

    template<typename T>
    void transfer(hls::stream<T> *param)
    {
      while (!empty()) {
        param->write(*(T*)nextRead());
      }
    }

    bool empty();
    char* nextRead();
    char* nextWrite();
  };

  bool CStream::empty()
  {
    return num == 0;
  }

  char* CStream::nextRead()
  {
    assert(num > 0);
    char *res = front;
    front += usize;
    if (dynamic) {
      if (++static_cast<DBuffer*>(bufs.front())->ufree == DBuffer::total) {
        if (bufs.size() > 1) {
          bufs.pop_front();
          front = bufs.front()->first;
        } else {
          front = back = bufs.front()->first;
        }
      }
    }
    --num;
    return res;
  }

  char* CStream::nextWrite()
  {
    if (dynamic) {
      if (static_cast<DBuffer*>(bufs.back())->ufree == 0) {
        bufs.push_back(new DBuffer(usize));
        back = bufs.back()->first;
      }
      --static_cast<DBuffer*>(bufs.back())->ufree;
    }
    char *res = back;
    back += usize;
    ++num;
    return res;
  }

  std::list<CStream> streams;
  std::map<char*, CStream*> prebuilt;

  CStream* createStream(size_t usize)
  {
    streams.emplace_front();
    CStream &s = streams.front();
    {
      s.dynamic = true;
      s.bufs.push_back(new DBuffer(usize));
      s.front = s.bufs.back()->first;
      s.back = s.front;
      s.num = 0;
      s.usize = usize;
    }
    return &s;
  }

  template<typename T>
  CStream* createStream(hls::stream<T> *param)
  {
    CStream *s = createStream(sizeof(T));
    {
      s->dynamic = true;
      while (!param->empty()) {
        T data = param->read();
        memcpy(s->nextWrite(), (char*)&data, sizeof(T));
      }
      prebuilt[s->front] = s;
    }
    return s;
  }

  template<typename T>
  CStream* createStream(T *param, size_t usize)
  {
    streams.emplace_front();
    CStream &s = streams.front();
    {
      s.dynamic = false;
      s.bufs.push_back(new Buffer((char*)param));
      s.front = s.back = s.bufs.back()->first;
      s.usize = usize;
      s.num = ~0UL;
    }
    prebuilt[s.front] = &s;
    return &s;
  }

  CStream* findStream(char *buf)
  {
    return prebuilt.at(buf);
  }
}
class AESL_RUNTIME_BC {
  public:
    AESL_RUNTIME_BC(const char* name) {
      file_token.open( name);
      if (!file_token.good()) {
        cout << "Failed to open tv file " << name << endl;
        exit (1);
      }
      file_token >> mName;//[[[runtime]]]
    }
    ~AESL_RUNTIME_BC() {
      file_token.close();
    }
    int read_size () {
      int size = 0;
      file_token >> mName;//[[transaction]]
      file_token >> mName;//transaction number
      file_token >> mName;//pop_size
      size = atoi(mName.c_str());
      file_token >> mName;//[[/transaction]]
      return size;
    }
  public:
    fstream file_token;
    string mName;
};
unsigned int ap_apatb_inStreamTop_V_data_V_cap_bc;
static AESL_RUNTIME_BC __xlx_inStreamTop_V_data_V_V_size_Reader("../tv/stream_size/stream_size_in_inStreamTop_V_data_V.dat");
unsigned int ap_apatb_inStreamTop_V_keep_V_cap_bc;
static AESL_RUNTIME_BC __xlx_inStreamTop_V_keep_V_V_size_Reader("../tv/stream_size/stream_size_in_inStreamTop_V_keep_V.dat");
unsigned int ap_apatb_inStreamTop_V_strb_V_cap_bc;
static AESL_RUNTIME_BC __xlx_inStreamTop_V_strb_V_V_size_Reader("../tv/stream_size/stream_size_in_inStreamTop_V_strb_V.dat");
unsigned int ap_apatb_inStreamTop_V_user_V_cap_bc;
static AESL_RUNTIME_BC __xlx_inStreamTop_V_user_V_V_size_Reader("../tv/stream_size/stream_size_in_inStreamTop_V_user_V.dat");
unsigned int ap_apatb_inStreamTop_V_last_V_cap_bc;
static AESL_RUNTIME_BC __xlx_inStreamTop_V_last_V_V_size_Reader("../tv/stream_size/stream_size_in_inStreamTop_V_last_V.dat");
unsigned int ap_apatb_outStreamTop_V_data_V_cap_bc;
static AESL_RUNTIME_BC __xlx_outStreamTop_V_data_V_V_size_Reader("../tv/stream_size/stream_size_out_outStreamTop_V_data_V.dat");
unsigned int ap_apatb_outStreamTop_V_keep_V_cap_bc;
static AESL_RUNTIME_BC __xlx_outStreamTop_V_keep_V_V_size_Reader("../tv/stream_size/stream_size_out_outStreamTop_V_keep_V.dat");
unsigned int ap_apatb_outStreamTop_V_strb_V_cap_bc;
static AESL_RUNTIME_BC __xlx_outStreamTop_V_strb_V_V_size_Reader("../tv/stream_size/stream_size_out_outStreamTop_V_strb_V.dat");
unsigned int ap_apatb_outStreamTop_V_user_V_cap_bc;
static AESL_RUNTIME_BC __xlx_outStreamTop_V_user_V_V_size_Reader("../tv/stream_size/stream_size_out_outStreamTop_V_user_V.dat");
unsigned int ap_apatb_outStreamTop_V_last_V_cap_bc;
static AESL_RUNTIME_BC __xlx_outStreamTop_V_last_V_V_size_Reader("../tv/stream_size/stream_size_out_outStreamTop_V_last_V.dat");
using hls::sim::Byte;
struct __cosim_s4__ { char data[4]; };
struct __cosim_s1__ { char data[1]; };
extern "C" void userdma(Byte<4>*, Byte<4>*, volatile void *, volatile void *, volatile void *, volatile void *, volatile void *, volatile void *, __cosim_s4__, __cosim_s1__, int, volatile void *, int, volatile void *, int, __cosim_s1__, volatile void *, volatile void *, volatile void *, volatile void *, volatile void *, char);
extern "C" void apatb_userdma_hw(volatile void * __xlx_apatb_param_inStreamTop_V_data_V, volatile void * __xlx_apatb_param_inStreamTop_V_keep_V, volatile void * __xlx_apatb_param_inStreamTop_V_strb_V, volatile void * __xlx_apatb_param_inStreamTop_V_user_V, volatile void * __xlx_apatb_param_inStreamTop_V_last_V, volatile void * __xlx_apatb_param_s2m_buf_sts, __cosim_s4__* __xlx_apatb_param_s2m_len, __cosim_s1__* __xlx_apatb_param_s2m_enb_clrsts, volatile void * __xlx_apatb_param_s2mbuf, volatile void * __xlx_apatb_param_s2m_err, volatile void * __xlx_apatb_param_m2sbuf, volatile void * __xlx_apatb_param_m2s_buf_sts, int __xlx_apatb_param_m2s_len, __cosim_s1__* __xlx_apatb_param_m2s_enb_clrsts, volatile void * __xlx_apatb_param_outStreamTop_V_data_V, volatile void * __xlx_apatb_param_outStreamTop_V_keep_V, volatile void * __xlx_apatb_param_outStreamTop_V_strb_V, volatile void * __xlx_apatb_param_outStreamTop_V_user_V, volatile void * __xlx_apatb_param_outStreamTop_V_last_V, char __xlx_apatb_param_endianness) {
using hls::sim::createStream;
  // Collect __xlx_s2mbuf__tmp_vec
std::vector<Byte<4>> __xlx_s2mbuf__tmp_vec;
for (size_t i = 0; i < 1024; ++i){
__xlx_s2mbuf__tmp_vec.push_back(((Byte<4>*)__xlx_apatb_param_s2mbuf)[i]);
}
  int __xlx_size_param_s2mbuf = 1024;
  int __xlx_offset_param_s2mbuf = 0;
  int __xlx_offset_byte_param_s2mbuf = 0*4;
  // Collect __xlx_m2sbuf__tmp_vec
std::vector<Byte<4>> __xlx_m2sbuf__tmp_vec;
for (size_t i = 0; i < 1024; ++i){
__xlx_m2sbuf__tmp_vec.push_back(((Byte<4>*)__xlx_apatb_param_m2sbuf)[i]);
}
  int __xlx_size_param_m2sbuf = 1024;
  int __xlx_offset_param_m2sbuf = 0;
  int __xlx_offset_byte_param_m2sbuf = 0*4;
auto* sinStreamTop_V_data_V = createStream((hls::stream<int>*)__xlx_apatb_param_inStreamTop_V_data_V);
auto* sinStreamTop_V_keep_V = createStream((hls::stream<char>*)__xlx_apatb_param_inStreamTop_V_keep_V);
auto* sinStreamTop_V_strb_V = createStream((hls::stream<char>*)__xlx_apatb_param_inStreamTop_V_strb_V);
auto* sinStreamTop_V_user_V = createStream((hls::stream<char>*)__xlx_apatb_param_inStreamTop_V_user_V);
auto* sinStreamTop_V_last_V = createStream((hls::stream<char>*)__xlx_apatb_param_inStreamTop_V_last_V);
  //Create input buffer for outStreamTop_V_data_V
  ap_apatb_outStreamTop_V_data_V_cap_bc = __xlx_outStreamTop_V_data_V_V_size_Reader.read_size();
  int* __xlx_outStreamTop_V_data_V_input_buffer= new int[ap_apatb_outStreamTop_V_data_V_cap_bc];
auto* soutStreamTop_V_data_V = createStream((hls::stream<int>*)__xlx_apatb_param_outStreamTop_V_data_V);
  //Create input buffer for outStreamTop_V_keep_V
  ap_apatb_outStreamTop_V_keep_V_cap_bc = __xlx_outStreamTop_V_keep_V_V_size_Reader.read_size();
  char* __xlx_outStreamTop_V_keep_V_input_buffer= new char[ap_apatb_outStreamTop_V_keep_V_cap_bc];
auto* soutStreamTop_V_keep_V = createStream((hls::stream<char>*)__xlx_apatb_param_outStreamTop_V_keep_V);
  //Create input buffer for outStreamTop_V_strb_V
  ap_apatb_outStreamTop_V_strb_V_cap_bc = __xlx_outStreamTop_V_strb_V_V_size_Reader.read_size();
  char* __xlx_outStreamTop_V_strb_V_input_buffer= new char[ap_apatb_outStreamTop_V_strb_V_cap_bc];
auto* soutStreamTop_V_strb_V = createStream((hls::stream<char>*)__xlx_apatb_param_outStreamTop_V_strb_V);
  //Create input buffer for outStreamTop_V_user_V
  ap_apatb_outStreamTop_V_user_V_cap_bc = __xlx_outStreamTop_V_user_V_V_size_Reader.read_size();
  char* __xlx_outStreamTop_V_user_V_input_buffer= new char[ap_apatb_outStreamTop_V_user_V_cap_bc];
auto* soutStreamTop_V_user_V = createStream((hls::stream<char>*)__xlx_apatb_param_outStreamTop_V_user_V);
  //Create input buffer for outStreamTop_V_last_V
  ap_apatb_outStreamTop_V_last_V_cap_bc = __xlx_outStreamTop_V_last_V_V_size_Reader.read_size();
  char* __xlx_outStreamTop_V_last_V_input_buffer= new char[ap_apatb_outStreamTop_V_last_V_cap_bc];
auto* soutStreamTop_V_last_V = createStream((hls::stream<char>*)__xlx_apatb_param_outStreamTop_V_last_V);
  // DUT call
  userdma(__xlx_s2mbuf__tmp_vec.data(), __xlx_m2sbuf__tmp_vec.data(), sinStreamTop_V_data_V->data<int>(), sinStreamTop_V_keep_V->data<char>(), sinStreamTop_V_strb_V->data<char>(), sinStreamTop_V_user_V->data<char>(), sinStreamTop_V_last_V->data<char>(), __xlx_apatb_param_s2m_buf_sts, *__xlx_apatb_param_s2m_len, *__xlx_apatb_param_s2m_enb_clrsts, __xlx_offset_byte_param_s2mbuf, __xlx_apatb_param_s2m_err, __xlx_offset_byte_param_m2sbuf, __xlx_apatb_param_m2s_buf_sts, __xlx_apatb_param_m2s_len, *__xlx_apatb_param_m2s_enb_clrsts, soutStreamTop_V_data_V->data<int>(), soutStreamTop_V_keep_V->data<char>(), soutStreamTop_V_strb_V->data<char>(), soutStreamTop_V_user_V->data<char>(), soutStreamTop_V_last_V->data<char>(), __xlx_apatb_param_endianness);
// print __xlx_apatb_param_s2mbuf
for (size_t i = 0; i < __xlx_size_param_s2mbuf; ++i) {
((Byte<4>*)__xlx_apatb_param_s2mbuf)[i] = __xlx_s2mbuf__tmp_vec[__xlx_offset_param_s2mbuf+i];
}
// print __xlx_apatb_param_m2sbuf
for (size_t i = 0; i < __xlx_size_param_m2sbuf; ++i) {
((Byte<4>*)__xlx_apatb_param_m2sbuf)[i] = __xlx_m2sbuf__tmp_vec[__xlx_offset_param_m2sbuf+i];
}
sinStreamTop_V_data_V->transfer((hls::stream<int>*)__xlx_apatb_param_inStreamTop_V_data_V);
sinStreamTop_V_keep_V->transfer((hls::stream<char>*)__xlx_apatb_param_inStreamTop_V_keep_V);
sinStreamTop_V_strb_V->transfer((hls::stream<char>*)__xlx_apatb_param_inStreamTop_V_strb_V);
sinStreamTop_V_user_V->transfer((hls::stream<char>*)__xlx_apatb_param_inStreamTop_V_user_V);
sinStreamTop_V_last_V->transfer((hls::stream<char>*)__xlx_apatb_param_inStreamTop_V_last_V);
soutStreamTop_V_data_V->transfer((hls::stream<int>*)__xlx_apatb_param_outStreamTop_V_data_V);
soutStreamTop_V_keep_V->transfer((hls::stream<char>*)__xlx_apatb_param_outStreamTop_V_keep_V);
soutStreamTop_V_strb_V->transfer((hls::stream<char>*)__xlx_apatb_param_outStreamTop_V_strb_V);
soutStreamTop_V_user_V->transfer((hls::stream<char>*)__xlx_apatb_param_outStreamTop_V_user_V);
soutStreamTop_V_last_V->transfer((hls::stream<char>*)__xlx_apatb_param_outStreamTop_V_last_V);
}
