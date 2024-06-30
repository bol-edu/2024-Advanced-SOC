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
#if defined(CCS_DUT_SYSC)
// alias ccs_DUT_wrapper to namespace enclosure of either cycle or RTL SystemC netlist
namespace
    ccs_design {
#if defined(CCS_DUT_CYCLE)
#include "cycle.cxx"
#else
#if defined(CCS_DUT_RTL)
#include "rtl.cxx"
#endif
#endif
}
typedef
    ccs_design::HDL::EdgeDetect_IP::EdgeDetect_Top ccs_DUT_wrapper;

#else

// Create a foreign module wrapper
    // around the HDL
#ifdef VCS_SYSTEMC
// VCS support - ccs_DUT_wrapper is derived from VCS-generated SystemC wrapper around HDL code
class ccs_DUT_wrapper : public TOP_HDL_ENTITY
{
public:
  ccs_DUT_wrapper(const sc_module_name& nm, const char *hdl_name)
  : TOP_HDL_ENTITY(nm)
  {
  // elaborate_foreign_module(hdl_name);
  }

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
  sc_in<sc_lv<8> > dat_in_rsc_dat;
  sc_in<sc_logic> dat_in_rsc_vld;
  sc_out<sc_logic> dat_in_rsc_rdy;
  sc_in<sc_lv<11> > widthIn;
  sc_in<sc_lv<10> > heightIn;
  sc_out<sc_lv<9> > magn_rsc_dat;
  sc_out<sc_logic> magn_rsc_vld;
  sc_in<sc_logic> magn_rsc_rdy;
  sc_out<sc_lv<8> > angle_rsc_dat;
  sc_out<sc_logic> angle_rsc_vld;
  sc_in<sc_logic> angle_rsc_rdy;
  sc_out<sc_logic> line_buf0_rsc_en;
  sc_in<sc_lv<16> > line_buf0_rsc_q;
  sc_out<sc_logic> line_buf0_rsc_we;
  sc_out<sc_lv<16> > line_buf0_rsc_d;
  sc_out<sc_lv<10> > line_buf0_rsc_adr;
  sc_out<sc_logic> line_buf1_rsc_en;
  sc_in<sc_lv<16> > line_buf1_rsc_q;
  sc_out<sc_logic> line_buf1_rsc_we;
  sc_out<sc_lv<16> > line_buf1_rsc_d;
  sc_out<sc_lv<10> > line_buf1_rsc_adr;
public:
  ccs_DUT_wrapper(const sc_module_name& nm, const char *hdl_name)
  :
    mc_foreign_module(nm, hdl_name), 
    clk("clk"), 
    rst("rst"), 
    arst_n("arst_n"), 
    dat_in_rsc_dat("dat_in_rsc_dat"), 
    dat_in_rsc_vld("dat_in_rsc_vld"), 
    dat_in_rsc_rdy("dat_in_rsc_rdy"), 
    widthIn("widthIn"), 
    heightIn("heightIn"), 
    magn_rsc_dat("magn_rsc_dat"), 
    magn_rsc_vld("magn_rsc_vld"), 
    magn_rsc_rdy("magn_rsc_rdy"), 
    angle_rsc_dat("angle_rsc_dat"), 
    angle_rsc_vld("angle_rsc_vld"), 
    angle_rsc_rdy("angle_rsc_rdy"), 
    line_buf0_rsc_en("line_buf0_rsc_en"), 
    line_buf0_rsc_q("line_buf0_rsc_q"), 
    line_buf0_rsc_we("line_buf0_rsc_we"), 
    line_buf0_rsc_d("line_buf0_rsc_d"), 
    line_buf0_rsc_adr("line_buf0_rsc_adr"), 
    line_buf1_rsc_en("line_buf1_rsc_en"), 
    line_buf1_rsc_q("line_buf1_rsc_q"), 
    line_buf1_rsc_we("line_buf1_rsc_we"), 
    line_buf1_rsc_d("line_buf1_rsc_d"), 
    line_buf1_rsc_adr("line_buf1_rsc_adr")
  {
    elaborate_foreign_module(hdl_name);
  }

  ~ccs_DUT_wrapper() {}
};
#endif

#endif

#ifdef CCS_SYSC
} // end namespace HDL
#endif
#endif


