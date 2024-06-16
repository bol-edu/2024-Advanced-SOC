#include <string>
#include <fstream>
#include <iostream>
#include "mc_testbench.h"
#include <mc_reset.h>
#include <mc_transactors.h>
#include <mc_scverify.h>
#include <mc_stall_ctrl.h>
#include <ac_read_env.h>
#include "/home/raid7_4/raid1_1/linux/mentor/Catapult/2023.2/Mgc_home/pkgs/ccs_xilinx/hdl/BLOCK_1R1W_RBW_trans_rsc.h"
#include "ccs_ioport_trans_rsc_v1.h"
#include <mc_monitor.h>
#include <mc_simulator_extensions.h>
#include "mc_dut_wrapper.h"
#include "ccs_probes.cpp"
#include <mt19937ar.c>
#ifndef TO_QUOTED_STRING
#define TO_QUOTED_STRING(x) TO_QUOTED_STRING1(x)
#define TO_QUOTED_STRING1(x) #x
#endif
// Hold time for the SCVerify testbench to account for the gate delay after downstream synthesis in pico second(s)
// Hold time value is obtained from 'top_gate_constraints.cpp', which is generated at the end of RTL synthesis
#ifdef CCS_DUT_GATE
extern double __scv_hold_time;
extern double __scv_hold_time_RSCID_1;
extern double __scv_hold_time_RSCID_2;
extern double __scv_hold_time_RSCID_3;
extern double __scv_hold_time_RSCID_4;
extern double __scv_hold_time_RSCID_5;
extern double __scv_hold_time_RSCID_6;
extern double __scv_hold_time_RSCID_7;
extern double __scv_hold_time_RSCID_8;
extern double __scv_hold_time_RSCID_9;
#else
double __scv_hold_time = 0.0; // default for non-gate simulation is zero
double __scv_hold_time_RSCID_1 = 0;
double __scv_hold_time_RSCID_2 = 0;
double __scv_hold_time_RSCID_3 = 0;
double __scv_hold_time_RSCID_4 = 0;
double __scv_hold_time_RSCID_5 = 0;
double __scv_hold_time_RSCID_6 = 0;
double __scv_hold_time_RSCID_7 = 0;
double __scv_hold_time_RSCID_8 = 0;
double __scv_hold_time_RSCID_9 = 0;
#endif

class scverify_top : public sc_module
{
public:
  sc_signal<sc_logic>                                                                               rst;
  sc_signal<sc_logic>                                                                               rst_n;
  sc_signal<sc_logic>                                                                               SIG_SC_LOGIC_0;
  sc_signal<sc_logic>                                                                               SIG_SC_LOGIC_1;
  sc_signal<sc_logic>                                                                               TLS_design_is_idle;
  sc_signal<bool>                                                                                   TLS_design_is_idle_reg;
  unsigned long                                                                                     d_max_sim_time;
  unsigned long                                                                                     d_deadlock_time;
  bool                                                                                              env_SCVerify_DEADLOCK_DETECTION;
  bool                                                                                              env_SCVerify_DISABLE_EMPTY_INPUTS;
  bool                                                                                              env_SCVerify_IDLE_SYNCHRONIZATION_MODE;
  bool                                                                                              env_SCVerify_ENABLE_RESET_TOGGLE;
  float                                                                                             env_SCVerify_RESET_CYCLES;
  unsigned long                                                                                     env_SCVerify_MAX_SIM_TIME;
  int                                                                                               env_SCVerify_AUTOWAIT;
  int                                                                                               env_SCVerify_AUTOWAIT_INPUT_CYCLES;
  int                                                                                               env_SCVerify_AUTOWAIT_OUTPUT_CYCLES;
  bool                                                                                              d_iosync_pause_on_stall;
  bool                                                                                              d_idle_sync_enabled;
  bool                                                                                              d_disable_on_empty;
  sc_clock                                                                                          clk;
  mc_programmable_reset                                                                             arst_n_driver;
  mc_programmable_reset                                                                             rst_driver;
  sc_signal<sc_logic>                                                                               TLS_rst;
  sc_signal<sc_logic>                                                                               TLS_arst_n;
  sc_signal<sc_lv<15> >                                                                             TLS_input_rsc_radr;
  sc_signal<sc_logic>                                                                               TLS_input_rsc_re;
  sc_signal<sc_lv<12> >                                                                             TLS_input_rsc_q;
  sc_signal<sc_logic>                                                                               TLS_input_triosy_lz;
  sc_signal<sc_lv<15> >                                                                             TLS_output_rsc_wadr;
  sc_signal<sc_lv<12> >                                                                             TLS_output_rsc_d;
  sc_signal<sc_logic>                                                                               TLS_output_rsc_we;
  sc_signal<sc_lv<15> >                                                                             TLS_output_rsc_radr;
  sc_signal<sc_logic>                                                                               TLS_output_rsc_re;
  sc_signal<sc_lv<12> >                                                                             TLS_output_rsc_q;
  sc_signal<sc_logic>                                                                               TLS_output_triosy_lz;
  sc_signal<sc_lv<7> >                                                                              TLS_height_rsc_dat;
  sc_signal<sc_logic>                                                                               TLS_height_triosy_lz;
  sc_signal<sc_lv<7> >                                                                              TLS_width_rsc_dat;
  sc_signal<sc_logic>                                                                               TLS_width_triosy_lz;
  sc_signal<sc_lv<2> >                                                                              TLS_kernel_size_rsc_dat;
  sc_signal<sc_logic>                                                                               TLS_kernel_size_triosy_lz;
  sc_signal<sc_lv<20> >                                                                             TLS_filter_offset_rsc_dat;
  sc_signal<sc_logic>                                                                               TLS_filter_offset_triosy_lz;
  sc_signal<sc_lv<7> >                                                                              TLS_in_channels_rsc_dat;
  sc_signal<sc_logic>                                                                               TLS_in_channels_triosy_lz;
  sc_signal<sc_lv<7> >                                                                              TLS_out_channels_rsc_dat;
  sc_signal<sc_logic>                                                                               TLS_out_channels_triosy_lz;
  sc_signal<sc_lv<3> >                                                                              TLS_stride_rsc_dat;
  sc_signal<sc_logic>                                                                               TLS_stride_triosy_lz;
  ccs_DUT_wrapper                                                                                   UNET_IP_tranconv2d_INST;
  sc_signal<sc_lv<12> >                                                                             TLS_input_rsc_d;
  sc_signal<sc_lv<15> >                                                                             TLS_input_rsc_wadr;
  sc_signal<sc_logic >                                                                              TLS_input_rsc_we;
  BLOCK_1R1W_RBW_trans_rsc<15,12,32768,1 >                                                          input_rsc_INST;
  BLOCK_1R1W_RBW_trans_rsc<15,12,32768,1 >                                                          output_rsc_INST;
  ccs_in_trans_rsc_v1<1,7 >                                                                         height_rsc_INST;
  ccs_in_trans_rsc_v1<1,7 >                                                                         width_rsc_INST;
  ccs_in_trans_rsc_v1<1,2 >                                                                         kernel_size_rsc_INST;
  ccs_in_trans_rsc_v1<1,20 >                                                                        filter_offset_rsc_INST;
  ccs_in_trans_rsc_v1<1,7 >                                                                         in_channels_rsc_INST;
  ccs_in_trans_rsc_v1<1,7 >                                                                         out_channels_rsc_INST;
  ccs_in_trans_rsc_v1<1,3 >                                                                         stride_rsc_INST;
  tlm::tlm_fifo<mgc_sysc_ver_array1D<ac_fixed<12, 8, true, AC_TRN, AC_WRAP >,32768> >               TLS_in_fifo_input;
  tlm::tlm_fifo<mc_wait_ctrl>                                                                       TLS_in_wait_ctrl_fifo_input;
  mc_trios_input_monitor                                                                            trios_monitor_input_triosy_lz_INST;
  mc_input_transactor<mgc_sysc_ver_array1D<ac_fixed<12, 8, true, AC_TRN, AC_WRAP >,32768>,12,true>  transactor_input;
  tlm::tlm_fifo<mgc_sysc_ver_array1D<ac_fixed<12, 8, true, AC_TRN, AC_WRAP >,32768> >               TLS_in_fifo_output;
  tlm::tlm_fifo<mc_wait_ctrl>                                                                       TLS_in_wait_ctrl_fifo_output;
  tlm::tlm_fifo<mgc_sysc_ver_array1D<ac_fixed<12, 8, true, AC_TRN, AC_WRAP >,32768> >               TLS_out_fifo_output;
  tlm::tlm_fifo<mc_wait_ctrl>                                                                       TLS_out_wait_ctrl_fifo_output;
  mc_trios_inout_monitor                                                                            trios_monitor_output_triosy_lz_INST;
  mc_inout_transactor<mgc_sysc_ver_array1D<ac_fixed<12, 8, true, AC_TRN, AC_WRAP >,32768>,12,true>  transactor_output;
  tlm::tlm_fifo<ac_int<7, false > >                                                                 TLS_in_fifo_height;
  tlm::tlm_fifo<mc_wait_ctrl>                                                                       TLS_in_wait_ctrl_fifo_height;
  mc_trios_input_monitor                                                                            trios_monitor_height_triosy_lz_INST;
  mc_input_transactor<ac_int<7, false >,7,false>                                                    transactor_height;
  tlm::tlm_fifo<ac_int<7, false > >                                                                 TLS_in_fifo_width;
  tlm::tlm_fifo<mc_wait_ctrl>                                                                       TLS_in_wait_ctrl_fifo_width;
  mc_trios_input_monitor                                                                            trios_monitor_width_triosy_lz_INST;
  mc_input_transactor<ac_int<7, false >,7,false>                                                    transactor_width;
  tlm::tlm_fifo<ac_int<2, false > >                                                                 TLS_in_fifo_kernel_size;
  tlm::tlm_fifo<mc_wait_ctrl>                                                                       TLS_in_wait_ctrl_fifo_kernel_size;
  mc_trios_input_monitor                                                                            trios_monitor_kernel_size_triosy_lz_INST;
  mc_input_transactor<ac_int<2, false >,2,false>                                                    transactor_kernel_size;
  tlm::tlm_fifo<ac_int<20, false > >                                                                TLS_in_fifo_filter_offset;
  tlm::tlm_fifo<mc_wait_ctrl>                                                                       TLS_in_wait_ctrl_fifo_filter_offset;
  mc_trios_input_monitor                                                                            trios_monitor_filter_offset_triosy_lz_INST;
  mc_input_transactor<ac_int<20, false >,20,false>                                                  transactor_filter_offset;
  tlm::tlm_fifo<ac_int<7, false > >                                                                 TLS_in_fifo_in_channels;
  tlm::tlm_fifo<mc_wait_ctrl>                                                                       TLS_in_wait_ctrl_fifo_in_channels;
  mc_trios_input_monitor                                                                            trios_monitor_in_channels_triosy_lz_INST;
  mc_input_transactor<ac_int<7, false >,7,false>                                                    transactor_in_channels;
  tlm::tlm_fifo<ac_int<7, false > >                                                                 TLS_in_fifo_out_channels;
  tlm::tlm_fifo<mc_wait_ctrl>                                                                       TLS_in_wait_ctrl_fifo_out_channels;
  mc_trios_input_monitor                                                                            trios_monitor_out_channels_triosy_lz_INST;
  mc_input_transactor<ac_int<7, false >,7,false>                                                    transactor_out_channels;
  tlm::tlm_fifo<ac_int<3, false > >                                                                 TLS_in_fifo_stride;
  tlm::tlm_fifo<mc_wait_ctrl>                                                                       TLS_in_wait_ctrl_fifo_stride;
  mc_trios_input_monitor                                                                            trios_monitor_stride_triosy_lz_INST;
  mc_input_transactor<ac_int<3, false >,3,false>                                                    transactor_stride;
  mc_testbench                                                                                      testbench_INST;
  sc_signal<sc_logic>                                                                               catapult_start;
  sc_signal<sc_logic>                                                                               catapult_done;
  sc_signal<sc_logic>                                                                               catapult_ready;
  sc_signal<sc_logic>                                                                               in_sync;
  sc_signal<sc_logic>                                                                               out_sync;
  sc_signal<sc_logic>                                                                               inout_sync;
  sc_signal<unsigned>                                                                               wait_for_init;
  sync_generator                                                                                    sync_generator_INST;
  catapult_monitor                                                                                  catapult_monitor_INST;
  ccs_probe_monitor                                                                                *ccs_probe_monitor_INST;
  mc_wait_ctrl                                                                                     *autowait_input_cfg;
  mc_wait_ctrl                                                                                     *autowait_output_cfg;
  sc_event                                                                                          generate_reset_event;
  sc_event                                                                                          deadlock_event;
  sc_signal<sc_logic>                                                                               deadlocked;
  sc_event                                                                                          max_sim_time_event;
  sc_signal<sc_logic>                                                                               TLS_enable_stalls;
  sc_signal<unsigned short>                                                                         TLS_stall_coverage;

  void read_env();
  void TLS_arst_n_method();
  void TLS_rst_method();
  void max_sim_time_notify();
  void start_of_simulation();
  void setup_autowait();
  void inform_autowait();
  void setup_debug();
  void debug(const char* varname, int flags, int count);
  void generate_reset();
  void install_observe_foreign_signals();
  void deadlock_watch();
  void deadlock_notify();

  // Constructor
  SC_HAS_PROCESS(scverify_top);
  scverify_top(const sc_module_name& name)
    : rst("rst")
    , rst_n("rst_n")
    , SIG_SC_LOGIC_0("SIG_SC_LOGIC_0")
    , SIG_SC_LOGIC_1("SIG_SC_LOGIC_1")
    , TLS_design_is_idle("TLS_design_is_idle")
    , TLS_design_is_idle_reg("TLS_design_is_idle_reg")
    , CCS_CLK_CTOR(clk, "clk", 10, SC_NS, 0.5, 0, SC_NS, false)
    , arst_n_driver("arst_n_driver", ac_env::read_float("SCVerify_RESET_CYCLES",2.0)*10.000000, true)
    , rst_driver("rst_driver", ac_env::read_float("SCVerify_RESET_CYCLES",2.0)*10.000000, false)
    , TLS_rst("TLS_rst")
    , TLS_arst_n("TLS_arst_n")
    , TLS_input_rsc_radr("TLS_input_rsc_radr")
    , TLS_input_rsc_re("TLS_input_rsc_re")
    , TLS_input_rsc_q("TLS_input_rsc_q")
    , TLS_input_triosy_lz("TLS_input_triosy_lz")
    , TLS_output_rsc_wadr("TLS_output_rsc_wadr")
    , TLS_output_rsc_d("TLS_output_rsc_d")
    , TLS_output_rsc_we("TLS_output_rsc_we")
    , TLS_output_rsc_radr("TLS_output_rsc_radr")
    , TLS_output_rsc_re("TLS_output_rsc_re")
    , TLS_output_rsc_q("TLS_output_rsc_q")
    , TLS_output_triosy_lz("TLS_output_triosy_lz")
    , TLS_height_rsc_dat("TLS_height_rsc_dat")
    , TLS_height_triosy_lz("TLS_height_triosy_lz")
    , TLS_width_rsc_dat("TLS_width_rsc_dat")
    , TLS_width_triosy_lz("TLS_width_triosy_lz")
    , TLS_kernel_size_rsc_dat("TLS_kernel_size_rsc_dat")
    , TLS_kernel_size_triosy_lz("TLS_kernel_size_triosy_lz")
    , TLS_filter_offset_rsc_dat("TLS_filter_offset_rsc_dat")
    , TLS_filter_offset_triosy_lz("TLS_filter_offset_triosy_lz")
    , TLS_in_channels_rsc_dat("TLS_in_channels_rsc_dat")
    , TLS_in_channels_triosy_lz("TLS_in_channels_triosy_lz")
    , TLS_out_channels_rsc_dat("TLS_out_channels_rsc_dat")
    , TLS_out_channels_triosy_lz("TLS_out_channels_triosy_lz")
    , TLS_stride_rsc_dat("TLS_stride_rsc_dat")
    , TLS_stride_triosy_lz("TLS_stride_triosy_lz")
    , UNET_IP_tranconv2d_INST("rtl", "ccs_wrapper")
    , TLS_input_rsc_d("TLS_input_rsc_d")
    , TLS_input_rsc_wadr("TLS_input_rsc_wadr")
    , TLS_input_rsc_we("TLS_input_rsc_we")
    , input_rsc_INST("input_rsc", true)
    , output_rsc_INST("output_rsc", true)
    , height_rsc_INST("height_rsc", true)
    , width_rsc_INST("width_rsc", true)
    , kernel_size_rsc_INST("kernel_size_rsc", true)
    , filter_offset_rsc_INST("filter_offset_rsc", true)
    , in_channels_rsc_INST("in_channels_rsc", true)
    , out_channels_rsc_INST("out_channels_rsc", true)
    , stride_rsc_INST("stride_rsc", true)
    , TLS_in_fifo_input("TLS_in_fifo_input", -1)
    , TLS_in_wait_ctrl_fifo_input("TLS_in_wait_ctrl_fifo_input", -1)
    , trios_monitor_input_triosy_lz_INST("trios_monitor_input_triosy_lz_INST")
    , transactor_input("transactor_input", 0, 12, 0, d_disable_on_empty)
    , TLS_in_fifo_output("TLS_in_fifo_output", -1)
    , TLS_in_wait_ctrl_fifo_output("TLS_in_wait_ctrl_fifo_output", -1)
    , TLS_out_fifo_output("TLS_out_fifo_output", -1)
    , TLS_out_wait_ctrl_fifo_output("TLS_out_wait_ctrl_fifo_output", -1)
    , trios_monitor_output_triosy_lz_INST("trios_monitor_output_triosy_lz_INST")
    , transactor_output("transactor_output", 0, 12, 0)
    , TLS_in_fifo_height("TLS_in_fifo_height", -1)
    , TLS_in_wait_ctrl_fifo_height("TLS_in_wait_ctrl_fifo_height", -1)
    , trios_monitor_height_triosy_lz_INST("trios_monitor_height_triosy_lz_INST")
    , transactor_height("transactor_height", 0, 7, 0, d_disable_on_empty)
    , TLS_in_fifo_width("TLS_in_fifo_width", -1)
    , TLS_in_wait_ctrl_fifo_width("TLS_in_wait_ctrl_fifo_width", -1)
    , trios_monitor_width_triosy_lz_INST("trios_monitor_width_triosy_lz_INST")
    , transactor_width("transactor_width", 0, 7, 0, d_disable_on_empty)
    , TLS_in_fifo_kernel_size("TLS_in_fifo_kernel_size", -1)
    , TLS_in_wait_ctrl_fifo_kernel_size("TLS_in_wait_ctrl_fifo_kernel_size", -1)
    , trios_monitor_kernel_size_triosy_lz_INST("trios_monitor_kernel_size_triosy_lz_INST")
    , transactor_kernel_size("transactor_kernel_size", 0, 2, 0, d_disable_on_empty)
    , TLS_in_fifo_filter_offset("TLS_in_fifo_filter_offset", -1)
    , TLS_in_wait_ctrl_fifo_filter_offset("TLS_in_wait_ctrl_fifo_filter_offset", -1)
    , trios_monitor_filter_offset_triosy_lz_INST("trios_monitor_filter_offset_triosy_lz_INST")
    , transactor_filter_offset("transactor_filter_offset", 0, 20, 0, d_disable_on_empty)
    , TLS_in_fifo_in_channels("TLS_in_fifo_in_channels", -1)
    , TLS_in_wait_ctrl_fifo_in_channels("TLS_in_wait_ctrl_fifo_in_channels", -1)
    , trios_monitor_in_channels_triosy_lz_INST("trios_monitor_in_channels_triosy_lz_INST")
    , transactor_in_channels("transactor_in_channels", 0, 7, 0, d_disable_on_empty)
    , TLS_in_fifo_out_channels("TLS_in_fifo_out_channels", -1)
    , TLS_in_wait_ctrl_fifo_out_channels("TLS_in_wait_ctrl_fifo_out_channels", -1)
    , trios_monitor_out_channels_triosy_lz_INST("trios_monitor_out_channels_triosy_lz_INST")
    , transactor_out_channels("transactor_out_channels", 0, 7, 0, d_disable_on_empty)
    , TLS_in_fifo_stride("TLS_in_fifo_stride", -1)
    , TLS_in_wait_ctrl_fifo_stride("TLS_in_wait_ctrl_fifo_stride", -1)
    , trios_monitor_stride_triosy_lz_INST("trios_monitor_stride_triosy_lz_INST")
    , transactor_stride("transactor_stride", 0, 3, 0, d_disable_on_empty)
    , testbench_INST("user_tb")
    , catapult_start("catapult_start")
    , catapult_done("catapult_done")
    , catapult_ready("catapult_ready")
    , in_sync("in_sync")
    , out_sync("out_sync")
    , inout_sync("inout_sync")
    , wait_for_init("wait_for_init")
    , sync_generator_INST("sync_generator", true, false, false, false, 266392, 266392, 0)
    , catapult_monitor_INST("Monitor", clk, true, 266392LL, 266392LL)
    , ccs_probe_monitor_INST(NULL)
    , autowait_input_cfg(NULL)
    , autowait_output_cfg(NULL)
    , deadlocked("deadlocked")
  {
    read_env();

    arst_n_driver.reset_out(TLS_arst_n);

    rst_driver.reset_out(TLS_rst);

    UNET_IP_tranconv2d_INST.clk(clk);
    UNET_IP_tranconv2d_INST.rst(TLS_rst);
    UNET_IP_tranconv2d_INST.arst_n(TLS_arst_n);
    UNET_IP_tranconv2d_INST.input_rsc_radr(TLS_input_rsc_radr);
    UNET_IP_tranconv2d_INST.input_rsc_re(TLS_input_rsc_re);
    UNET_IP_tranconv2d_INST.input_rsc_q(TLS_input_rsc_q);
    UNET_IP_tranconv2d_INST.input_triosy_lz(TLS_input_triosy_lz);
    UNET_IP_tranconv2d_INST.output_rsc_wadr(TLS_output_rsc_wadr);
    UNET_IP_tranconv2d_INST.output_rsc_d(TLS_output_rsc_d);
    UNET_IP_tranconv2d_INST.output_rsc_we(TLS_output_rsc_we);
    UNET_IP_tranconv2d_INST.output_rsc_radr(TLS_output_rsc_radr);
    UNET_IP_tranconv2d_INST.output_rsc_re(TLS_output_rsc_re);
    UNET_IP_tranconv2d_INST.output_rsc_q(TLS_output_rsc_q);
    UNET_IP_tranconv2d_INST.output_triosy_lz(TLS_output_triosy_lz);
    UNET_IP_tranconv2d_INST.height_rsc_dat(TLS_height_rsc_dat);
    UNET_IP_tranconv2d_INST.height_triosy_lz(TLS_height_triosy_lz);
    UNET_IP_tranconv2d_INST.width_rsc_dat(TLS_width_rsc_dat);
    UNET_IP_tranconv2d_INST.width_triosy_lz(TLS_width_triosy_lz);
    UNET_IP_tranconv2d_INST.kernel_size_rsc_dat(TLS_kernel_size_rsc_dat);
    UNET_IP_tranconv2d_INST.kernel_size_triosy_lz(TLS_kernel_size_triosy_lz);
    UNET_IP_tranconv2d_INST.filter_offset_rsc_dat(TLS_filter_offset_rsc_dat);
    UNET_IP_tranconv2d_INST.filter_offset_triosy_lz(TLS_filter_offset_triosy_lz);
    UNET_IP_tranconv2d_INST.in_channels_rsc_dat(TLS_in_channels_rsc_dat);
    UNET_IP_tranconv2d_INST.in_channels_triosy_lz(TLS_in_channels_triosy_lz);
    UNET_IP_tranconv2d_INST.out_channels_rsc_dat(TLS_out_channels_rsc_dat);
    UNET_IP_tranconv2d_INST.out_channels_triosy_lz(TLS_out_channels_triosy_lz);
    UNET_IP_tranconv2d_INST.stride_rsc_dat(TLS_stride_rsc_dat);
    UNET_IP_tranconv2d_INST.stride_triosy_lz(TLS_stride_triosy_lz);

    input_rsc_INST.q(TLS_input_rsc_q);
    input_rsc_INST.re(TLS_input_rsc_re);
    input_rsc_INST.radr(TLS_input_rsc_radr);
    input_rsc_INST.clk(clk);
    input_rsc_INST.clken(SIG_SC_LOGIC_1);
    input_rsc_INST.d(TLS_input_rsc_d);
    input_rsc_INST.wadr(TLS_input_rsc_wadr);
    input_rsc_INST.we(TLS_input_rsc_we);
    input_rsc_INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_1)));

    output_rsc_INST.q(TLS_output_rsc_q);
    output_rsc_INST.re(TLS_output_rsc_re);
    output_rsc_INST.radr(TLS_output_rsc_radr);
    output_rsc_INST.we(TLS_output_rsc_we);
    output_rsc_INST.d(TLS_output_rsc_d);
    output_rsc_INST.wadr(TLS_output_rsc_wadr);
    output_rsc_INST.clk(clk);
    output_rsc_INST.clken(SIG_SC_LOGIC_1);
    output_rsc_INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_2)));

    height_rsc_INST.dat(TLS_height_rsc_dat);
    height_rsc_INST.clk(clk);
    height_rsc_INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_3)));

    width_rsc_INST.dat(TLS_width_rsc_dat);
    width_rsc_INST.clk(clk);
    width_rsc_INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_4)));

    kernel_size_rsc_INST.dat(TLS_kernel_size_rsc_dat);
    kernel_size_rsc_INST.clk(clk);
    kernel_size_rsc_INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_5)));

    filter_offset_rsc_INST.dat(TLS_filter_offset_rsc_dat);
    filter_offset_rsc_INST.clk(clk);
    filter_offset_rsc_INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_6)));

    in_channels_rsc_INST.dat(TLS_in_channels_rsc_dat);
    in_channels_rsc_INST.clk(clk);
    in_channels_rsc_INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_7)));

    out_channels_rsc_INST.dat(TLS_out_channels_rsc_dat);
    out_channels_rsc_INST.clk(clk);
    out_channels_rsc_INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_8)));

    stride_rsc_INST.dat(TLS_stride_rsc_dat);
    stride_rsc_INST.clk(clk);
    stride_rsc_INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_9)));

    trios_monitor_input_triosy_lz_INST.trios(TLS_input_triosy_lz);
    trios_monitor_input_triosy_lz_INST.register_mon(&catapult_monitor_INST);

    transactor_input.in_fifo(TLS_in_fifo_input);
    transactor_input.in_wait_ctrl_fifo(TLS_in_wait_ctrl_fifo_input);
    transactor_input.set_disable_on_empty(d_disable_on_empty);
    transactor_input.bind_clk(clk, true, rst);
    transactor_input.add_attribute(*(new sc_attribute<int>("MC_TRANSACTOR_EVENT", 0 )));
    transactor_input.register_block(&input_rsc_INST, input_rsc_INST.basename(), TLS_input_triosy_lz, 0, 32767, 1);

    trios_monitor_output_triosy_lz_INST.trios(TLS_output_triosy_lz);
    trios_monitor_output_triosy_lz_INST.register_mon(&catapult_monitor_INST);

    transactor_output.in_fifo(TLS_in_fifo_output);
    transactor_output.in_wait_ctrl_fifo(TLS_in_wait_ctrl_fifo_output);
    transactor_output.out_fifo(TLS_out_fifo_output);
    transactor_output.out_wait_ctrl_fifo(TLS_out_wait_ctrl_fifo_output);
    transactor_output.bind_clk(clk, true, rst);
    transactor_output.add_attribute(*(new sc_attribute<int>("MC_TRANSACTOR_EVENT", 0 )));
    transactor_output.register_block(&output_rsc_INST, output_rsc_INST.basename(), TLS_output_triosy_lz, 0, 32767, 1);

    trios_monitor_height_triosy_lz_INST.trios(TLS_height_triosy_lz);
    trios_monitor_height_triosy_lz_INST.register_mon(&catapult_monitor_INST);

    transactor_height.in_fifo(TLS_in_fifo_height);
    transactor_height.in_wait_ctrl_fifo(TLS_in_wait_ctrl_fifo_height);
    transactor_height.set_disable_on_empty(d_disable_on_empty);
    transactor_height.bind_clk(clk, true, rst);
    transactor_height.add_attribute(*(new sc_attribute<int>("MC_TRANSACTOR_EVENT", 0 )));
    transactor_height.register_block(&height_rsc_INST, height_rsc_INST.basename(), TLS_height_triosy_lz, 0, 0, 1);

    trios_monitor_width_triosy_lz_INST.trios(TLS_width_triosy_lz);
    trios_monitor_width_triosy_lz_INST.register_mon(&catapult_monitor_INST);

    transactor_width.in_fifo(TLS_in_fifo_width);
    transactor_width.in_wait_ctrl_fifo(TLS_in_wait_ctrl_fifo_width);
    transactor_width.set_disable_on_empty(d_disable_on_empty);
    transactor_width.bind_clk(clk, true, rst);
    transactor_width.add_attribute(*(new sc_attribute<int>("MC_TRANSACTOR_EVENT", 0 )));
    transactor_width.register_block(&width_rsc_INST, width_rsc_INST.basename(), TLS_width_triosy_lz, 0, 0, 1);

    trios_monitor_kernel_size_triosy_lz_INST.trios(TLS_kernel_size_triosy_lz);
    trios_monitor_kernel_size_triosy_lz_INST.register_mon(&catapult_monitor_INST);

    transactor_kernel_size.in_fifo(TLS_in_fifo_kernel_size);
    transactor_kernel_size.in_wait_ctrl_fifo(TLS_in_wait_ctrl_fifo_kernel_size);
    transactor_kernel_size.set_disable_on_empty(d_disable_on_empty);
    transactor_kernel_size.bind_clk(clk, true, rst);
    transactor_kernel_size.add_attribute(*(new sc_attribute<int>("MC_TRANSACTOR_EVENT", 0 )));
    transactor_kernel_size.register_block(&kernel_size_rsc_INST, kernel_size_rsc_INST.basename(), TLS_kernel_size_triosy_lz, 0, 0, 1);

    trios_monitor_filter_offset_triosy_lz_INST.trios(TLS_filter_offset_triosy_lz);
    trios_monitor_filter_offset_triosy_lz_INST.register_mon(&catapult_monitor_INST);

    transactor_filter_offset.in_fifo(TLS_in_fifo_filter_offset);
    transactor_filter_offset.in_wait_ctrl_fifo(TLS_in_wait_ctrl_fifo_filter_offset);
    transactor_filter_offset.set_disable_on_empty(d_disable_on_empty);
    transactor_filter_offset.bind_clk(clk, true, rst);
    transactor_filter_offset.add_attribute(*(new sc_attribute<int>("MC_TRANSACTOR_EVENT", 0 )));
    transactor_filter_offset.register_block(&filter_offset_rsc_INST, filter_offset_rsc_INST.basename(), TLS_filter_offset_triosy_lz, 0, 0, 1);

    trios_monitor_in_channels_triosy_lz_INST.trios(TLS_in_channels_triosy_lz);
    trios_monitor_in_channels_triosy_lz_INST.register_mon(&catapult_monitor_INST);

    transactor_in_channels.in_fifo(TLS_in_fifo_in_channels);
    transactor_in_channels.in_wait_ctrl_fifo(TLS_in_wait_ctrl_fifo_in_channels);
    transactor_in_channels.set_disable_on_empty(d_disable_on_empty);
    transactor_in_channels.bind_clk(clk, true, rst);
    transactor_in_channels.add_attribute(*(new sc_attribute<int>("MC_TRANSACTOR_EVENT", 0 )));
    transactor_in_channels.register_block(&in_channels_rsc_INST, in_channels_rsc_INST.basename(), TLS_in_channels_triosy_lz, 0, 0, 1);

    trios_monitor_out_channels_triosy_lz_INST.trios(TLS_out_channels_triosy_lz);
    trios_monitor_out_channels_triosy_lz_INST.register_mon(&catapult_monitor_INST);

    transactor_out_channels.in_fifo(TLS_in_fifo_out_channels);
    transactor_out_channels.in_wait_ctrl_fifo(TLS_in_wait_ctrl_fifo_out_channels);
    transactor_out_channels.set_disable_on_empty(d_disable_on_empty);
    transactor_out_channels.bind_clk(clk, true, rst);
    transactor_out_channels.add_attribute(*(new sc_attribute<int>("MC_TRANSACTOR_EVENT", 0 )));
    transactor_out_channels.register_block(&out_channels_rsc_INST, out_channels_rsc_INST.basename(), TLS_out_channels_triosy_lz, 0, 0, 1);

    trios_monitor_stride_triosy_lz_INST.trios(TLS_stride_triosy_lz);
    trios_monitor_stride_triosy_lz_INST.register_mon(&catapult_monitor_INST);

    transactor_stride.in_fifo(TLS_in_fifo_stride);
    transactor_stride.in_wait_ctrl_fifo(TLS_in_wait_ctrl_fifo_stride);
    transactor_stride.set_disable_on_empty(d_disable_on_empty);
    transactor_stride.bind_clk(clk, true, rst);
    transactor_stride.add_attribute(*(new sc_attribute<int>("MC_TRANSACTOR_EVENT", 0 )));
    transactor_stride.register_block(&stride_rsc_INST, stride_rsc_INST.basename(), TLS_stride_triosy_lz, 0, 0, 1);

    testbench_INST.clk(clk);
    testbench_INST.ccs_input(TLS_in_fifo_input);
    testbench_INST.ccs_wait_ctrl_input(TLS_in_wait_ctrl_fifo_input);
    testbench_INST.ccs_output_IN(TLS_in_fifo_output);
    testbench_INST.ccs_wait_ctrl_output_IN(TLS_in_wait_ctrl_fifo_output);
    testbench_INST.ccs_output(TLS_out_fifo_output);
    testbench_INST.ccs_wait_ctrl_output(TLS_out_wait_ctrl_fifo_output);
    testbench_INST.ccs_height(TLS_in_fifo_height);
    testbench_INST.ccs_wait_ctrl_height(TLS_in_wait_ctrl_fifo_height);
    testbench_INST.ccs_width(TLS_in_fifo_width);
    testbench_INST.ccs_wait_ctrl_width(TLS_in_wait_ctrl_fifo_width);
    testbench_INST.ccs_kernel_size(TLS_in_fifo_kernel_size);
    testbench_INST.ccs_wait_ctrl_kernel_size(TLS_in_wait_ctrl_fifo_kernel_size);
    testbench_INST.ccs_filter_offset(TLS_in_fifo_filter_offset);
    testbench_INST.ccs_wait_ctrl_filter_offset(TLS_in_wait_ctrl_fifo_filter_offset);
    testbench_INST.ccs_in_channels(TLS_in_fifo_in_channels);
    testbench_INST.ccs_wait_ctrl_in_channels(TLS_in_wait_ctrl_fifo_in_channels);
    testbench_INST.ccs_out_channels(TLS_in_fifo_out_channels);
    testbench_INST.ccs_wait_ctrl_out_channels(TLS_in_wait_ctrl_fifo_out_channels);
    testbench_INST.ccs_stride(TLS_in_fifo_stride);
    testbench_INST.ccs_wait_ctrl_stride(TLS_in_wait_ctrl_fifo_stride);
    testbench_INST.design_is_idle(TLS_design_is_idle_reg);
    testbench_INST.enable_stalls(TLS_enable_stalls);
    testbench_INST.stall_coverage(TLS_stall_coverage);

    sync_generator_INST.clk(clk);
    sync_generator_INST.rst(rst);
    sync_generator_INST.in_sync(in_sync);
    sync_generator_INST.out_sync(out_sync);
    sync_generator_INST.inout_sync(inout_sync);
    sync_generator_INST.wait_for_init(wait_for_init);
    sync_generator_INST.catapult_start(catapult_start);
    sync_generator_INST.catapult_ready(catapult_ready);
    sync_generator_INST.catapult_done(catapult_done);

    catapult_monitor_INST.rst(rst);


    SC_METHOD(TLS_arst_n_method);
      sensitive_neg << TLS_arst_n;
      dont_initialize();

    SC_METHOD(TLS_rst_method);
      sensitive_pos << TLS_rst;
      dont_initialize();

    SC_METHOD(max_sim_time_notify);
      sensitive << max_sim_time_event;
      dont_initialize();

    SC_METHOD(inform_autowait);
      sensitive << testbench_INST.testbench_aw_event;
      dont_initialize();

    SC_METHOD(generate_reset);
      sensitive << generate_reset_event;
      sensitive << testbench_INST.reset_request_event;

    SC_METHOD(deadlock_watch);
      sensitive << clk;
      dont_initialize();

    SC_METHOD(deadlock_notify);
      sensitive << deadlock_event;
      dont_initialize();


    #if defined(CCS_SCVERIFY) && defined(CCS_DUT_RTL) && !defined(CCS_DUT_SYSC) && !defined(CCS_SYSC) && !defined(CCS_DUT_POWER)
    ccs_probe_monitor_INST = new ccs_probe_monitor("ccs_probe_monitor");
    ccs_probe_monitor_INST->clk(clk);
    ccs_probe_monitor_INST->rst(rst);
    #endif
    SIG_SC_LOGIC_0.write(SC_LOGIC_0);
    SIG_SC_LOGIC_1.write(SC_LOGIC_1);
    mt19937_init_genrand(19650218UL);
    install_observe_foreign_signals();
    deadlocked.write(SC_LOGIC_0);
    TLS_design_is_idle.write(SC_LOGIC_0);
  }
};
void scverify_top::read_env() {
  env_SCVerify_DEADLOCK_DETECTION = ac_env::read_bool("SCVerify_DEADLOCK_DETECTION",false);
  env_SCVerify_DISABLE_EMPTY_INPUTS = ac_env::read_bool("SCVerify_DISABLE_EMPTY_INPUTS",false);
  env_SCVerify_IDLE_SYNCHRONIZATION_MODE = ac_env::read_bool("SCVerify_IDLE_SYNCHRONIZATION_MODE",false);
  env_SCVerify_ENABLE_RESET_TOGGLE = ac_env::read_bool("SCVerify_ENABLE_RESET_TOGGLE",false);
  env_SCVerify_RESET_CYCLES = ac_env::read_float("SCVerify_RESET_CYCLES",2.0);
  env_SCVerify_MAX_SIM_TIME = ac_env::read_int("SCVerify_MAX_SIM_TIME",0);
  env_SCVerify_AUTOWAIT = ac_env::read_int("SCVerify_AUTOWAIT",/*default to 0 (no automatic I/O stalling)*/ 0);
  env_SCVerify_AUTOWAIT_INPUT_CYCLES = ac_env::read_int("SCVerify_AUTOWAIT_INPUT_CYCLES",/*original hardcoded default*/ 5);
  env_SCVerify_AUTOWAIT_OUTPUT_CYCLES = ac_env::read_int("SCVerify_AUTOWAIT_OUTPUT_CYCLES",/*original hardcoded default*/ 5);
  d_iosync_pause_on_stall = ac_env::read_bool("SCVerify_IOSYNC_PAUSE_ON_STALL",false);
  d_idle_sync_enabled = env_SCVerify_IDLE_SYNCHRONIZATION_MODE;
  d_disable_on_empty = env_SCVerify_DISABLE_EMPTY_INPUTS || env_SCVerify_IDLE_SYNCHRONIZATION_MODE;
  float longest_clk_per = 10.000000;
  unsigned long latency_est = 266384;
  unsigned long trcnt = 1;
  if (env_SCVerify_ENABLE_RESET_TOGGLE) { trcnt = ceil(env_SCVerify_RESET_CYCLES+0.5)*3; }
  unsigned long wait_for_cycles = latency_est * 9 + trcnt;
  wait_for_cycles += 100; //extended for Xilinx
  unsigned long wait_time = ceil(longest_clk_per) * wait_for_cycles;
  d_deadlock_time = wait_time;
  d_max_sim_time = env_SCVerify_MAX_SIM_TIME;
  if ((d_max_sim_time > 0) && (wait_time > d_max_sim_time)) {
    d_max_sim_time = wait_time;
    std::ostringstream msg;
    msg << "Maximum simulation time extended to meet calculated value of " << d_max_sim_time << " ns";
    SC_REPORT_WARNING("System", msg.str().c_str());
  }
}

void scverify_top::TLS_arst_n_method() {
  std::ostringstream msg;
  msg << "TLS_arst_n active @ " << sc_time_stamp();
  SC_REPORT_INFO("HW reset", msg.str().c_str());
  input_rsc_INST.clear();
  output_rsc_INST.clear();
  height_rsc_INST.clear();
  width_rsc_INST.clear();
  kernel_size_rsc_INST.clear();
  filter_offset_rsc_INST.clear();
  in_channels_rsc_INST.clear();
  out_channels_rsc_INST.clear();
  stride_rsc_INST.clear();
}

void scverify_top::TLS_rst_method() {
  std::ostringstream msg;
  msg << "TLS_rst active @ " << sc_time_stamp();
  SC_REPORT_INFO("HW reset", msg.str().c_str());
  input_rsc_INST.clear();
  output_rsc_INST.clear();
  height_rsc_INST.clear();
  width_rsc_INST.clear();
  kernel_size_rsc_INST.clear();
  filter_offset_rsc_INST.clear();
  in_channels_rsc_INST.clear();
  out_channels_rsc_INST.clear();
  stride_rsc_INST.clear();
}

void scverify_top::max_sim_time_notify() {
  testbench_INST.set_failed(true);
  testbench_INST.check_results();
  SC_REPORT_ERROR("System", "Specified maximum simulation time reached");
  sc_stop();
}

void scverify_top::start_of_simulation() {
  setup_autowait();
  if (d_max_sim_time>0) max_sim_time_event.notify(d_max_sim_time,SC_NS);
}

void scverify_top::setup_autowait() {
  autowait_input_cfg = new mc_wait_ctrl(0, 1, env_SCVerify_AUTOWAIT_INPUT_CYCLES, mc_wait_ctrl::RANDOM, mc_wait_ctrl::INITIAL, 0, false);
  autowait_output_cfg = new mc_wait_ctrl(0, 1, env_SCVerify_AUTOWAIT_OUTPUT_CYCLES, mc_wait_ctrl::RANDOM, mc_wait_ctrl::INITIAL, 0, false);
  transactor_input.set_auto_wait_limit(env_SCVerify_AUTOWAIT);
  transactor_input.configure_autowait(autowait_input_cfg);
  transactor_output.set_auto_wait_limit(env_SCVerify_AUTOWAIT);
  transactor_output.configure_autowait(autowait_output_cfg);
  transactor_height.set_auto_wait_limit(env_SCVerify_AUTOWAIT);
  transactor_height.configure_autowait(autowait_input_cfg);
  transactor_width.set_auto_wait_limit(env_SCVerify_AUTOWAIT);
  transactor_width.configure_autowait(autowait_input_cfg);
  transactor_kernel_size.set_auto_wait_limit(env_SCVerify_AUTOWAIT);
  transactor_kernel_size.configure_autowait(autowait_input_cfg);
  transactor_filter_offset.set_auto_wait_limit(env_SCVerify_AUTOWAIT);
  transactor_filter_offset.configure_autowait(autowait_input_cfg);
  transactor_in_channels.set_auto_wait_limit(env_SCVerify_AUTOWAIT);
  transactor_in_channels.configure_autowait(autowait_input_cfg);
  transactor_out_channels.set_auto_wait_limit(env_SCVerify_AUTOWAIT);
  transactor_out_channels.configure_autowait(autowait_input_cfg);
  transactor_stride.set_auto_wait_limit(env_SCVerify_AUTOWAIT);
  transactor_stride.configure_autowait(autowait_input_cfg);
}

void scverify_top::inform_autowait() {
  bool waited = false;
  waited |= (transactor_input.atleast_one_autowait(0) > 0);
  waited |= (transactor_output.atleast_one_autowait(1) > 0);
  waited |= (transactor_height.atleast_one_autowait(0) > 0);
  waited |= (transactor_width.atleast_one_autowait(0) > 0);
  waited |= (transactor_kernel_size.atleast_one_autowait(0) > 0);
  waited |= (transactor_filter_offset.atleast_one_autowait(0) > 0);
  waited |= (transactor_in_channels.atleast_one_autowait(0) > 0);
  waited |= (transactor_out_channels.atleast_one_autowait(0) > 0);
  waited |= (transactor_stride.atleast_one_autowait(0) > 0);
  if (waited)
    SC_REPORT_INFO(name(), "At least one AUTOWAIT was applied during simulation.");
}

void scverify_top::setup_debug() {
#ifdef MC_DEFAULT_TRANSACTOR_LOG
  static int transactor_input_flags = MC_DEFAULT_TRANSACTOR_LOG;
  static int transactor_output_flags = MC_DEFAULT_TRANSACTOR_LOG;
  static int transactor_height_flags = MC_DEFAULT_TRANSACTOR_LOG;
  static int transactor_width_flags = MC_DEFAULT_TRANSACTOR_LOG;
  static int transactor_kernel_size_flags = MC_DEFAULT_TRANSACTOR_LOG;
  static int transactor_filter_offset_flags = MC_DEFAULT_TRANSACTOR_LOG;
  static int transactor_in_channels_flags = MC_DEFAULT_TRANSACTOR_LOG;
  static int transactor_out_channels_flags = MC_DEFAULT_TRANSACTOR_LOG;
  static int transactor_stride_flags = MC_DEFAULT_TRANSACTOR_LOG;
#else
  static int transactor_input_flags = (d_disable_on_empty ? 0 : MC_TRANSACTOR_UNDERFLOW) | MC_TRANSACTOR_WAIT;
  static int transactor_output_flags = (d_disable_on_empty ? 0 : MC_TRANSACTOR_UNDERFLOW) | MC_TRANSACTOR_WAIT;
  static int transactor_height_flags = (d_disable_on_empty ? 0 : MC_TRANSACTOR_UNDERFLOW) | MC_TRANSACTOR_WAIT;
  static int transactor_width_flags = (d_disable_on_empty ? 0 : MC_TRANSACTOR_UNDERFLOW) | MC_TRANSACTOR_WAIT;
  static int transactor_kernel_size_flags = (d_disable_on_empty ? 0 : MC_TRANSACTOR_UNDERFLOW) | MC_TRANSACTOR_WAIT;
  static int transactor_filter_offset_flags = (d_disable_on_empty ? 0 : MC_TRANSACTOR_UNDERFLOW) | MC_TRANSACTOR_WAIT;
  static int transactor_in_channels_flags = (d_disable_on_empty ? 0 : MC_TRANSACTOR_UNDERFLOW) | MC_TRANSACTOR_WAIT;
  static int transactor_out_channels_flags = (d_disable_on_empty ? 0 : MC_TRANSACTOR_UNDERFLOW) | MC_TRANSACTOR_WAIT;
  static int transactor_stride_flags = (d_disable_on_empty ? 0 : MC_TRANSACTOR_UNDERFLOW) | MC_TRANSACTOR_WAIT;
#endif
  static int transactor_input_count = -1;
  static int transactor_output_count = -1;
  static int transactor_height_count = -1;
  static int transactor_width_count = -1;
  static int transactor_kernel_size_count = -1;
  static int transactor_filter_offset_count = -1;
  static int transactor_in_channels_count = -1;
  static int transactor_out_channels_count = -1;
  static int transactor_stride_count = -1;

  // At the breakpoint, modify the local variables
  // above to turn on/off different levels of transaction
  // logging for each variable. Available flags are:
  //   MC_TRANSACTOR_EMPTY       - log empty FIFOs (on by default)
  //   MC_TRANSACTOR_UNDERFLOW   - log FIFOs that run empty and then are loaded again (off)
  //   MC_TRANSACTOR_READ        - log all read events
  //   MC_TRANSACTOR_WRITE       - log all write events
  //   MC_TRANSACTOR_LOAD        - log all FIFO load events
  //   MC_TRANSACTOR_DUMP        - log all FIFO dump events
  //   MC_TRANSACTOR_STREAMCNT   - log all streamed port index counter events
  //   MC_TRANSACTOR_WAIT        - log user specified handshake waits
  //   MC_TRANSACTOR_SIZE        - log input FIFO size updates

  std::ifstream debug_cmds;
  debug_cmds.open("scverify.cmd",std::fstream::in);
  if (debug_cmds.is_open()) {
    std::cout << "Reading SCVerify debug commands from file 'scverify.cmd'" << std::endl;
    std::string line;
    while (getline(debug_cmds,line)) {
      std::size_t pos1 = line.find(" ");
      if (pos1 == std::string::npos) continue;
      std::size_t pos2 = line.find(" ", pos1+1);
      std::string varname = line.substr(0,pos1);
      std::string flags = line.substr(pos1+1,pos2-pos1-1);
      std::string count = line.substr(pos2+1);
      debug(varname.c_str(),std::atoi(flags.c_str()),std::atoi(count.c_str()));
    }
    debug_cmds.close();
  } else {
    debug("transactor_input",transactor_input_flags,transactor_input_count);
    debug("transactor_output",transactor_output_flags,transactor_output_count);
    debug("transactor_height",transactor_height_flags,transactor_height_count);
    debug("transactor_width",transactor_width_flags,transactor_width_count);
    debug("transactor_kernel_size",transactor_kernel_size_flags,transactor_kernel_size_count);
    debug("transactor_filter_offset",transactor_filter_offset_flags,transactor_filter_offset_count);
    debug("transactor_in_channels",transactor_in_channels_flags,transactor_in_channels_count);
    debug("transactor_out_channels",transactor_out_channels_flags,transactor_out_channels_count);
    debug("transactor_stride",transactor_stride_flags,transactor_stride_count);
  }
}

void scverify_top::debug(const char* varname, int flags, int count) {
  sc_module *xlator_p = 0;
  sc_attr_base *debug_attr_p = 0;
  if (strcmp(varname,"transactor_input") == 0)
    xlator_p = &transactor_input;
  if (strcmp(varname,"transactor_output") == 0)
    xlator_p = &transactor_output;
  if (strcmp(varname,"transactor_height") == 0)
    xlator_p = &transactor_height;
  if (strcmp(varname,"transactor_width") == 0)
    xlator_p = &transactor_width;
  if (strcmp(varname,"transactor_kernel_size") == 0)
    xlator_p = &transactor_kernel_size;
  if (strcmp(varname,"transactor_filter_offset") == 0)
    xlator_p = &transactor_filter_offset;
  if (strcmp(varname,"transactor_in_channels") == 0)
    xlator_p = &transactor_in_channels;
  if (strcmp(varname,"transactor_out_channels") == 0)
    xlator_p = &transactor_out_channels;
  if (strcmp(varname,"transactor_stride") == 0)
    xlator_p = &transactor_stride;
  if (xlator_p) {
    debug_attr_p = xlator_p->get_attribute("MC_TRANSACTOR_EVENT");
    if (!debug_attr_p) {
      debug_attr_p = new sc_attribute<int>("MC_TRANSACTOR_EVENT",flags);
      xlator_p->add_attribute(*debug_attr_p);
    }
    ((sc_attribute<int>*)debug_attr_p)->value = flags;
  }

  if (count>=0) {
    debug_attr_p = xlator_p->get_attribute("MC_TRANSACTOR_COUNT");
    if (!debug_attr_p) {
      debug_attr_p = new sc_attribute<int>("MC_TRANSACTOR_COUNT",count);
      xlator_p->add_attribute(*debug_attr_p);
    }
    ((sc_attribute<int>*)debug_attr_p)->value = count;
  }
}

// Process: SC_METHOD generate_reset
void scverify_top::generate_reset() {
  static bool activate_reset = true;
  static bool toggle_hw_reset = env_SCVerify_ENABLE_RESET_TOGGLE;
  if (activate_reset || sc_time_stamp() == SC_ZERO_TIME) {
    setup_debug();
    activate_reset = false;
    rst.write(SC_LOGIC_1);
    arst_n_driver.reset_driver();
    rst_driver.reset_driver();
    generate_reset_event.notify(env_SCVerify_RESET_CYCLES*10.000000, SC_NS);
  } else {
    if (toggle_hw_reset) {
      toggle_hw_reset = false;
      generate_reset_event.notify(env_SCVerify_RESET_CYCLES*10.000000, SC_NS);
    } else {
      transactor_input.reset_streams();
      transactor_output.reset_streams();
      transactor_height.reset_streams();
      transactor_width.reset_streams();
      transactor_kernel_size.reset_streams();
      transactor_filter_offset.reset_streams();
      transactor_in_channels.reset_streams();
      transactor_out_channels.reset_streams();
      transactor_stride.reset_streams();
      rst.write(SC_LOGIC_0);
    }
    activate_reset = true;
  }
}

void scverify_top::install_observe_foreign_signals() {
#if !defined(CCS_DUT_SYSC)
#if defined(CCS_DUT_CYCLE) || defined(CCS_DUT_RTL)
#endif
#endif
}

void scverify_top::deadlock_watch() {
#if !defined(CCS_DUT_SYSC) && defined(DEADLOCK_DETECTION)
#if defined(CCS_DUT_CYCLE) || defined(CCS_DUT_RTL)
#if defined(MTI_SYSTEMC) || defined(NCSC) || defined(VCS_SYSTEMC)
  deadlocked.write(SC_LOGIC_0);
#endif
#endif
#endif
}

void scverify_top::deadlock_notify() {
  if (deadlocked.read() == SC_LOGIC_1) {
    testbench_INST.check_results();
    SC_REPORT_ERROR("System", "Simulation deadlock detected");
    sc_stop();
  }
}

#if defined(MC_SIMULATOR_OSCI) || defined(MC_SIMULATOR_VCS)
int sc_main(int argc, char *argv[]) {
  sc_report_handler::set_actions("/IEEE_Std_1666/deprecated", SC_DO_NOTHING);
  scverify_top scverify_top("scverify_top");
  sc_start();
  return scverify_top.testbench_INST.failed();
}
#else
MC_MODULE_EXPORT(scverify_top);
#endif
