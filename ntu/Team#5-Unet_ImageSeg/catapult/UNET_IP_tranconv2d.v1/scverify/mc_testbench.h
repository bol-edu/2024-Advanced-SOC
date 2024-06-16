// ----------------------------------------------------------------------------
// SystemC Testbench Header
//
//    HLS version: 2023.2/1059873 Production Release
//       HLS date: Mon Aug  7 10:54:31 PDT 2023
//  Flow Packages: HDL_Tcl 8.0a, SCVerify 10.4
//
//   Generated by: r12016@cad40
// Generated date: Thu Jun 13 03:36:02 CST 2024
//
// ----------------------------------------------------------------------------
#ifdef CCS_SCVERIFY

// 
// -------------------------------------
// mc_testbench
// SCVerify mc_testbench SC_MODULE
// -------------------------------------
// 
#ifndef INCLUDED_MC_TESTBENCH_H
#define INCLUDED_MC_TESTBENCH_H

#ifdef __SYNTHESIS__
#error __SYNTHESIS__ is a predefined, reserved Catapult macro and cannot be user defined.
#endif

#ifndef SC_USE_STD_STRING
#define SC_USE_STD_STRING
#endif

#include "../../../hls/main.h"
#include "ccs_testbench.h"
#include <systemc.h>
#include <tlm.h>
#include <ac_int.h>
#include <ac_fixed.h>
#include <mc_container_types.h>
#include <mc_typeconv.h>
#include <mc_transactors.h>
#include <mc_comparator.h>
#include <mc_end_of_testbench.h>
#include <vector>
#include <ac_read_env.h>


class mc_testbench : public sc_module
{
public:
   // Module instance pointers
   mc_comparator< mgc_sysc_ver_array1D<ac_fixed<12, 8, true, AC_TRN, AC_WRAP >,32768> , MaskPacket< 0, 12 > > *output_comp;
   
   // Interface Ports
   sc_in< bool > clk;
   sc_port< tlm::tlm_fifo_put_if< mgc_sysc_ver_array1D<ac_fixed<12, 8, true, AC_TRN, AC_WRAP >,32768> > > ccs_input;
   sc_port< tlm::tlm_fifo_put_if< mc_wait_ctrl > > ccs_wait_ctrl_input;
   sc_port< tlm::tlm_fifo_put_if< mgc_sysc_ver_array1D<ac_fixed<12, 8, true, AC_TRN, AC_WRAP >,32768> > > ccs_output_IN;
   sc_port< tlm::tlm_fifo_put_if< mc_wait_ctrl > > ccs_wait_ctrl_output_IN;
   sc_port< tlm::tlm_fifo_get_if< mgc_sysc_ver_array1D<ac_fixed<12, 8, true, AC_TRN, AC_WRAP >,32768> > > ccs_output;
   sc_port< tlm::tlm_fifo_put_if< mc_wait_ctrl > > ccs_wait_ctrl_output;
   sc_port< tlm::tlm_fifo_put_if< ac_int<7, false > > > ccs_height;
   sc_port< tlm::tlm_fifo_put_if< mc_wait_ctrl > > ccs_wait_ctrl_height;
   sc_port< tlm::tlm_fifo_put_if< ac_int<7, false > > > ccs_width;
   sc_port< tlm::tlm_fifo_put_if< mc_wait_ctrl > > ccs_wait_ctrl_width;
   sc_port< tlm::tlm_fifo_put_if< ac_int<2, false > > > ccs_kernel_size;
   sc_port< tlm::tlm_fifo_put_if< mc_wait_ctrl > > ccs_wait_ctrl_kernel_size;
   sc_port< tlm::tlm_fifo_put_if< ac_int<20, false > > > ccs_filter_offset;
   sc_port< tlm::tlm_fifo_put_if< mc_wait_ctrl > > ccs_wait_ctrl_filter_offset;
   sc_port< tlm::tlm_fifo_put_if< ac_int<7, false > > > ccs_in_channels;
   sc_port< tlm::tlm_fifo_put_if< mc_wait_ctrl > > ccs_wait_ctrl_in_channels;
   sc_port< tlm::tlm_fifo_put_if< ac_int<7, false > > > ccs_out_channels;
   sc_port< tlm::tlm_fifo_put_if< mc_wait_ctrl > > ccs_wait_ctrl_out_channels;
   sc_port< tlm::tlm_fifo_put_if< ac_int<3, false > > > ccs_stride;
   sc_port< tlm::tlm_fifo_put_if< mc_wait_ctrl > > ccs_wait_ctrl_stride;
   sc_in< bool > design_is_idle;
   sc_out< sc_logic > enable_stalls;
   sc_in< unsigned short > stall_coverage;
   
   // Named Objects
   
   // Data objects
   int end_of_sim_wait_count;
   bool testbench_ended;
   int main_exit_code;
   bool atleast_one_active_input;
   sc_time last_event_time;
   sc_time last_event_time2;
   sc_signal< bool >                          cpp_testbench_active;
   sc_event testbench_end_event;
   sc_event testbench_aw_event;
   sc_event reset_request_event;
   bool _checked_results;
   bool _failed;
   static mc_testbench* that;
   bool _channel_mismatch;
   bool _capture_input;
   int input_capture_count;
   int input_iteration_count;
   bool _capture_output_IN;
   int output_IN_capture_count;
   int output_IN_iteration_count;
   tlm::tlm_fifo< mc_golden_info< mgc_sysc_ver_array1D<ac_fixed<12, 8, true, AC_TRN, AC_WRAP >,32768>, MaskPacket<0, 12> > > output_golden;
   bool _capture_output;
   int output_capture_count;
   int output_iteration_count;
   bool _capture_height;
   int height_capture_count;
   int height_iteration_count;
   bool _capture_width;
   int width_capture_count;
   int width_iteration_count;
   bool _capture_kernel_size;
   int kernel_size_capture_count;
   int kernel_size_iteration_count;
   bool _capture_filter_offset;
   int filter_offset_capture_count;
   int filter_offset_iteration_count;
   bool _capture_in_channels;
   int in_channels_capture_count;
   int in_channels_iteration_count;
   bool _capture_out_channels;
   int out_channels_capture_count;
   int out_channels_iteration_count;
   bool _capture_stride;
   int stride_capture_count;
   int stride_iteration_count;
   int wait_cnt;
   sc_time previous_timestamp;
   sc_time average_period;
   unsigned int period_counter;
   bool calculate_period;
   
   // Declare processes (SC_METHOD and SC_THREAD)
   void wait_for_end();
   void run();
   
   // Constructor
   SC_HAS_PROCESS(mc_testbench);
   mc_testbench(
      const sc_module_name& name
   )
      : clk("clk")
      , ccs_input("ccs_input")
      , ccs_wait_ctrl_input("ccs_wait_ctrl_input")
      , ccs_output_IN("ccs_output_IN")
      , ccs_wait_ctrl_output_IN("ccs_wait_ctrl_output_IN")
      , ccs_output("ccs_output")
      , ccs_wait_ctrl_output("ccs_wait_ctrl_output")
      , ccs_height("ccs_height")
      , ccs_wait_ctrl_height("ccs_wait_ctrl_height")
      , ccs_width("ccs_width")
      , ccs_wait_ctrl_width("ccs_wait_ctrl_width")
      , ccs_kernel_size("ccs_kernel_size")
      , ccs_wait_ctrl_kernel_size("ccs_wait_ctrl_kernel_size")
      , ccs_filter_offset("ccs_filter_offset")
      , ccs_wait_ctrl_filter_offset("ccs_wait_ctrl_filter_offset")
      , ccs_in_channels("ccs_in_channels")
      , ccs_wait_ctrl_in_channels("ccs_wait_ctrl_in_channels")
      , ccs_out_channels("ccs_out_channels")
      , ccs_wait_ctrl_out_channels("ccs_wait_ctrl_out_channels")
      , ccs_stride("ccs_stride")
      , ccs_wait_ctrl_stride("ccs_wait_ctrl_stride")
      , design_is_idle("design_is_idle")
      , enable_stalls("enable_stalls")
      , stall_coverage("stall_coverage")
      , cpp_testbench_active("cpp_testbench_active")
      , output_golden("output_golden",-1)
   {
      // Instantiate other modules
      output_comp = new mc_comparator< mgc_sysc_ver_array1D<ac_fixed<12, 8, true, AC_TRN, AC_WRAP >,32768> , MaskPacket< 0, 12 > > (
         "output_comp",
         "output",
         0,
         ac_env::read_int("SCVerify_MAX_ERROR_CNT",0),
         1
      );
      output_comp->data_in(ccs_output);
      output_comp->data_golden(output_golden);
      
      
      // Register processes
      SC_METHOD(wait_for_end);
      sensitive << clk.pos() << testbench_end_event;
      SC_THREAD(run);
      // Other constructor statements
      set_stack_size(64000000);
      _checked_results = false;
      that = this;
      end_of_sim_wait_count = 0;
      testbench_ended = false;
      main_exit_code = 0;
      atleast_one_active_input = true;
      _failed = false;
      _capture_input = true;
      _capture_output_IN = true;
      _capture_output = true;
      _capture_height = true;
      _capture_width = true;
      _capture_kernel_size = true;
      _capture_filter_offset = true;
      _capture_in_channels = true;
      _capture_out_channels = true;
      _capture_stride = true;
      wait_cnt = 0;
      previous_timestamp = SC_ZERO_TIME;
      average_period = SC_ZERO_TIME;
      period_counter = 0;
      calculate_period = true;
   }
   
   ~mc_testbench()
   {
      delete output_comp;
      output_comp = 0;
   }
   
   // C++ class functions
   public:
      static void wait_for_idle_sync() ;
   public:
      static void set_enable_stalls(bool flag) ;
   public:
      void reset_request() ;
   public:
      void capture_input( ac_fixed<12, 8, true, AC_TRN, AC_WRAP > input[32768]) ;
   public:
      void capture_output_IN( ac_fixed<12, 8, true, AC_TRN, AC_WRAP > output[32768]) ;
   public:
      void capture_output( ac_fixed<12, 8, true, AC_TRN, AC_WRAP > output[32768]) ;
   public:
      void capture_height( ac_int<7, false > &height) ;
   public:
      void capture_width( ac_int<7, false > &width) ;
   public:
      void capture_kernel_size( ac_int<2, false > &kernel_size) ;
   public:
      void capture_filter_offset( ac_int<20, false > &filter_offset) ;
   public:
      void capture_in_channels( ac_int<7, false > &in_channels) ;
   public:
      void capture_out_channels( ac_int<7, false > &out_channels) ;
   public:
      void capture_stride( ac_int<3, false > &stride) ;
   protected:
      void wait_on_input_required() ;
   public:
      static void capture_IN(ac_fixed<12, 8, true, AC_TRN, AC_WRAP> input[32768], ac_fixed<12, 8, true, AC_TRN, AC_WRAP> output[32768], ac_int<7, false> &height, ac_int<7, false> &width, ac_int<2, false> &kernel_size, ac_int<20, false> &filter_offset, ac_int<7, false> &in_channels, ac_int<7, false> &out_channels, ac_int<3, false> &stride) ;
   public:
      static void capture_OUT(ac_fixed<12, 8, true, AC_TRN, AC_WRAP> input[32768], ac_fixed<12, 8, true, AC_TRN, AC_WRAP> output[32768], ac_int<7, false> &height, ac_int<7, false> &width, ac_int<2, false> &kernel_size, ac_int<20, false> &filter_offset, ac_int<7, false> &in_channels, ac_int<7, false> &out_channels, ac_int<3, false> &stride) ;
   public:
      static void exec_run_tran(ac_fixed<12, 8, true, AC_TRN, AC_WRAP> input[32768], ac_fixed<12, 8, true, AC_TRN, AC_WRAP> output[32768], ac_int<7, false> &height, ac_int<7, false> &width, ac_int<2, false> &kernel_size, ac_int<20, false> &filter_offset, ac_int<7, false> &in_channels, ac_int<7, false> &out_channels, ac_int<3, false> &stride) ;
   protected:
      void start_of_simulation() ;
   protected:
      void end_of_simulation() ;
   public:
      void check_results() ;
   public:
      bool failed() ;
   public:
      void set_failed(bool fail) ;
};
#endif
#endif //CCS_SCVERIFY
