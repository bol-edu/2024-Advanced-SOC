// mc_dut_wrapper.h
#ifndef INCLUDED_CCS_DUT_WRAPPER_H
#define INCLUDED_CCS_DUT_WRAPPER_H

#ifndef SC_USE_STD_STRING
#define SC_USE_STD_STRING
#endif

#include <systemc.h>
#include <mc_simulator_extensions.h>

#ifdef CCS_SYSC
namespace HDL {
#endif

// Create a foreign module wrapper around the HDL
#ifdef VCS_SYSTEMC
// VCS support - ccs_DUT_wrapper is derived from VCS-generated SystemC wrapper around HDL code
class ccs_DUT_wrapper : public ccs_wrapper
{
public:
  ccs_DUT_wrapper(const sc_module_name& nm, const char *hdl_name)
  : ccs_wrapper(nm)
  {}
  ~ccs_DUT_wrapper() {}
};

#else
// non VCS simulators - ccs_DUT_wrapper is derived from mc_foreign_module (adding 2nd ctor arg)
class ccs_DUT_wrapper: public mc_foreign_module
{
public:
  // Interface Ports
  sc_in<bool> clk;
  sc_in<sc_logic> rst;
  sc_in<sc_logic> arst_n;
  sc_out<sc_lv<15> > input_rsc_radr;
  sc_out<sc_logic> input_rsc_re;
  sc_in<sc_lv<12> > input_rsc_q;
  sc_out<sc_logic> input_triosy_lz;
  sc_out<sc_lv<15> > output_rsc_wadr;
  sc_out<sc_lv<12> > output_rsc_d;
  sc_out<sc_logic> output_rsc_we;
  sc_out<sc_lv<15> > output_rsc_radr;
  sc_out<sc_logic> output_rsc_re;
  sc_in<sc_lv<12> > output_rsc_q;
  sc_out<sc_logic> output_triosy_lz;
  sc_in<sc_lv<7> > height_rsc_dat;
  sc_out<sc_logic> height_triosy_lz;
  sc_in<sc_lv<7> > width_rsc_dat;
  sc_out<sc_logic> width_triosy_lz;
  sc_in<sc_lv<2> > kernel_size_rsc_dat;
  sc_out<sc_logic> kernel_size_triosy_lz;
  sc_in<sc_lv<20> > filter_offset_rsc_dat;
  sc_out<sc_logic> filter_offset_triosy_lz;
  sc_in<sc_lv<7> > in_channels_rsc_dat;
  sc_out<sc_logic> in_channels_triosy_lz;
  sc_in<sc_lv<7> > out_channels_rsc_dat;
  sc_out<sc_logic> out_channels_triosy_lz;
  sc_in<sc_lv<3> > stride_rsc_dat;
  sc_out<sc_logic> stride_triosy_lz;
public:
  ccs_DUT_wrapper(const sc_module_name& nm, const char *hdl_name)
  :
    mc_foreign_module(nm, hdl_name), 
    clk("clk"), 
    rst("rst"), 
    arst_n("arst_n"), 
    input_rsc_radr("input_rsc_radr"), 
    input_rsc_re("input_rsc_re"), 
    input_rsc_q("input_rsc_q"), 
    input_triosy_lz("input_triosy_lz"), 
    output_rsc_wadr("output_rsc_wadr"), 
    output_rsc_d("output_rsc_d"), 
    output_rsc_we("output_rsc_we"), 
    output_rsc_radr("output_rsc_radr"), 
    output_rsc_re("output_rsc_re"), 
    output_rsc_q("output_rsc_q"), 
    output_triosy_lz("output_triosy_lz"), 
    height_rsc_dat("height_rsc_dat"), 
    height_triosy_lz("height_triosy_lz"), 
    width_rsc_dat("width_rsc_dat"), 
    width_triosy_lz("width_triosy_lz"), 
    kernel_size_rsc_dat("kernel_size_rsc_dat"), 
    kernel_size_triosy_lz("kernel_size_triosy_lz"), 
    filter_offset_rsc_dat("filter_offset_rsc_dat"), 
    filter_offset_triosy_lz("filter_offset_triosy_lz"), 
    in_channels_rsc_dat("in_channels_rsc_dat"), 
    in_channels_triosy_lz("in_channels_triosy_lz"), 
    out_channels_rsc_dat("out_channels_rsc_dat"), 
    out_channels_triosy_lz("out_channels_triosy_lz"), 
    stride_rsc_dat("stride_rsc_dat"), 
    stride_triosy_lz("stride_triosy_lz")
  {
    elaborate_foreign_module(hdl_name);
  }

  ~ccs_DUT_wrapper() {}
};
#endif // VCS_SYSTEMC

#ifdef CCS_SYSC
} // namespace HDL
#endif
#endif // INCLUDED_CCS_DUT_WRAPPER_H


