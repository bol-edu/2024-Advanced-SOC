// ----------------------------------------------------------------------------
// User Testbench Interface Header
//
//    HLS version: 2023.1/1033555 Production Release
//       HLS date: Mon Feb 13 11:32:25 PST 2023
//  Flow Packages: HDL_Tcl 8.0a, SCVerify 10.4
//
//   Generated by: m111061545@ws41
// Generated date: Mon Feb 26 23:43:56 CST 2024
//
// ----------------------------------------------------------------------------

#ifndef CCS_TESTBENCH_H
#define CCS_TESTBENCH_H

#include <ac_int.h>
#include <ac_fixed.h>
#include <ac_channel.h>
#include "mc_wait_ctrl.h"
#include <string.h>
#include <iostream>

class testbench
{
   public:
   int argc;
   char** argv;
   int main(); //CCS_MAIN
   static bool enable_idle_sync_mode;
   static unsigned short idle_sync_stable_cycles;
   static void set_enable_stalls(bool flag);
   static void reset_request();
   static void* _dut_inst;
   static void* dut_inst();
   static void* set_dut_inst( void* _inst );
   static bool dat_in_ignore;
   static bool dat_in_skip;
   static bool dat_in_skip_quiet;
   static bool dat_in_skip_once;
   static bool dat_in_skip_noerr;
   static int  dat_in_array_comp_first;
   static int  dat_in_array_comp_last;
   static mc_wait_ctrl dat_in_wait_ctrl;
   static bool widthIn_ignore;
   static bool widthIn_skip;
   static bool widthIn_skip_quiet;
   static bool widthIn_skip_once;
   static bool widthIn_skip_noerr;
   static int  widthIn_array_comp_first;
   static int  widthIn_array_comp_last;
   static mc_wait_ctrl widthIn_wait_ctrl;
   static bool heightIn_ignore;
   static bool heightIn_skip;
   static bool heightIn_skip_quiet;
   static bool heightIn_skip_once;
   static bool heightIn_skip_noerr;
   static int  heightIn_array_comp_first;
   static int  heightIn_array_comp_last;
   static mc_wait_ctrl heightIn_wait_ctrl;
   static bool magn_ignore;
   static bool magn_skip;
   static bool magn_skip_quiet;
   static bool magn_skip_once;
   static bool magn_skip_noerr;
   static int  magn_array_comp_first;
   static int  magn_array_comp_last;
   static bool magn_use_mask;
   static ac_int<9, false > magn_output_mask;
   static mc_wait_ctrl magn_wait_ctrl;
   static bool angle_ignore;
   static bool angle_skip;
   static bool angle_skip_quiet;
   static bool angle_skip_once;
   static bool angle_skip_noerr;
   static int  angle_array_comp_first;
   static int  angle_array_comp_last;
   static bool angle_use_mask;
   static ac_fixed<8, 3, true, AC_TRN, AC_WRAP > angle_output_mask;
   static mc_wait_ctrl angle_wait_ctrl;
   #ifndef CCS_SCVERIFY_USE_CCS_BLOCK
   static void exec_run(ac_channel<ac_int<8, false> > &dat_in, ac_int<11, false> &widthIn, ac_int<10, false> &heightIn, ac_channel<ac_int<9, false> > &magn, ac_channel<ac_fixed<8, 3, true, AC_TRN, AC_WRAP> > &angle);
   #endif
   explicit testbench(int _argc, const char* const *_argv)
      :argc(_argc), argv(const_cast<char**>(_argv))
   {
   }
   ~testbench()
   {
   }
   private:
   testbench() {}
};
extern void mc_testbench_reset_request();
extern void* mc_testbench_dut_inst();
extern void* mc_testbench_set_dut_inst( void* _inst );
extern void mc_testbench_wait_for_idle_sync();
extern void mc_testbench_dat_in_skip(bool v);
extern void mc_testbench_widthIn_skip(bool v);
extern void mc_testbench_heightIn_skip(bool v);
extern void mc_testbench_magn_skip(bool v);
extern void mc_testbench_angle_skip(bool v);
#endif //CCS_TESTBENCH_H
