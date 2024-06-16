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
  sc_out<sc_logic> input_rsc_clken;
  sc_out<sc_logic> input_triosy_lz;
  sc_out<sc_lv<15> > output_rsc_wadr;
  sc_out<sc_lv<12> > output_rsc_d;
  sc_out<sc_logic> output_rsc_we;
  sc_out<sc_logic> output_rsc_clken;
  sc_out<sc_logic> output_triosy_lz;
  sc_in<sc_lv<7> > channels;
  sc_in<sc_lv<7> > height;
  sc_in<sc_lv<7> > width;
  sc_in<sc_lv<3> > pool_size;
  sc_in<sc_lv<3> > stride;
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
    input_rsc_clken("input_rsc_clken"), 
    input_triosy_lz("input_triosy_lz"), 
    output_rsc_wadr("output_rsc_wadr"), 
    output_rsc_d("output_rsc_d"), 
    output_rsc_we("output_rsc_we"), 
    output_rsc_clken("output_rsc_clken"), 
    output_triosy_lz("output_triosy_lz"), 
    channels("channels"), 
    height("height"), 
    width("width"), 
    pool_size("pool_size"), 
    stride("stride")
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


