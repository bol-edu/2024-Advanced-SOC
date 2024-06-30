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
    ccs_design::HDL::EdgeDetect_IP::EdgeDetect_MagAng ccs_DUT_wrapper;

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
  sc_in<sc_lv<9> > dx_in_rsc_dat;
  sc_in<sc_logic> dx_in_rsc_vld;
  sc_out<sc_logic> dx_in_rsc_rdy;
  sc_in<sc_lv<9> > dy_in_rsc_dat;
  sc_in<sc_logic> dy_in_rsc_vld;
  sc_out<sc_logic> dy_in_rsc_rdy;
  sc_in<sc_lv<11> > widthIn_rsc_dat;
  sc_out<sc_logic> widthIn_triosy_lz;
  sc_in<sc_lv<10> > heightIn_rsc_dat;
  sc_out<sc_logic> heightIn_triosy_lz;
  sc_out<sc_lv<9> > magn_rsc_dat;
  sc_out<sc_logic> magn_rsc_vld;
  sc_in<sc_logic> magn_rsc_rdy;
  sc_out<sc_lv<8> > angle_rsc_dat;
  sc_out<sc_logic> angle_rsc_vld;
  sc_in<sc_logic> angle_rsc_rdy;
public:
  ccs_DUT_wrapper(const sc_module_name& nm, const char *hdl_name)
  :
    mc_foreign_module(nm, hdl_name), 
    clk("clk"), 
    rst("rst"), 
    arst_n("arst_n"), 
    dx_in_rsc_dat("dx_in_rsc_dat"), 
    dx_in_rsc_vld("dx_in_rsc_vld"), 
    dx_in_rsc_rdy("dx_in_rsc_rdy"), 
    dy_in_rsc_dat("dy_in_rsc_dat"), 
    dy_in_rsc_vld("dy_in_rsc_vld"), 
    dy_in_rsc_rdy("dy_in_rsc_rdy"), 
    widthIn_rsc_dat("widthIn_rsc_dat"), 
    widthIn_triosy_lz("widthIn_triosy_lz"), 
    heightIn_rsc_dat("heightIn_rsc_dat"), 
    heightIn_triosy_lz("heightIn_triosy_lz"), 
    magn_rsc_dat("magn_rsc_dat"), 
    magn_rsc_vld("magn_rsc_vld"), 
    magn_rsc_rdy("magn_rsc_rdy"), 
    angle_rsc_dat("angle_rsc_dat"), 
    angle_rsc_vld("angle_rsc_vld"), 
    angle_rsc_rdy("angle_rsc_rdy")
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


