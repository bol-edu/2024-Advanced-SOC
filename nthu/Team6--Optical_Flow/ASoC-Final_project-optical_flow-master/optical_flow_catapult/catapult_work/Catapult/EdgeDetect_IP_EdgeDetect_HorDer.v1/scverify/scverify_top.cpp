#include <string>
#include <fstream>
#include <iostream>
#include "mc_testbench.h"
#include <mc_reset.h>
#include <mc_transactors.h>
#include <mc_scverify.h>
#include <mc_stall_ctrl.h>
#include <ac_read_env.h>
#include "ccs_ioport_trans_rsc_v1.h"
#include "mgc_ioport_trans_rsc_v1.h"
#include <mc_monitor.h>
#include <mc_simulator_extensions.h>
#include "mc_dut_wrapper.h"
#include "ccs_probes.cpp"
#include <mt19937ar.c>
#ifndef TO_QUOTED_STRING
#define TO_QUOTED_STRING(x) TO_QUOTED_STRING1(x)
#define TO_QUOTED_STRING1(x) #x
#endif
#ifndef TOP_HDL_ENTITY
#define TOP_HDL_ENTITY EdgeDetect_IP_EdgeDetect_HorDer
#endif
// Hold time for the SCVerify testbench to account for the gate delay after downstream synthesis in pico second(s)
// Hold time value is obtained from 'top_gate_constraints.cpp', which is generated at the end of RTL synthesis
#ifdef CCS_DUT_GATE
extern double __scv_hold_time;
extern double __scv_hold_time_RSCID_1;
extern double __scv_hold_time_RSCID_2;
extern double __scv_hold_time_RSCID_3;
extern double __scv_hold_time_RSCID_4;
#else
double __scv_hold_time = 0.0; // default for non-gate simulation is zero
double __scv_hold_time_RSCID_1 = 0;
double __scv_hold_time_RSCID_2 = 0;
double __scv_hold_time_RSCID_3 = 0;
double __scv_hold_time_RSCID_4 = 0;
#endif

class scverify_top : public sc_module
{
public:
  sc_signal<sc_logic>                                     rst;
  sc_signal<sc_logic>                                     rst_n;
  sc_signal<sc_logic>                                     SIG_SC_LOGIC_0;
  sc_signal<sc_logic>                                     SIG_SC_LOGIC_1;
  sc_signal<sc_logic>                                     TLS_design_is_idle;
  sc_signal<bool>                                         TLS_design_is_idle_reg;
  unsigned long                                           d_max_sim_time;
  unsigned long                                           d_deadlock_time;
  bool                                                    env_SCVerify_DEADLOCK_DETECTION;
  bool                                                    env_SCVerify_DISABLE_EMPTY_INPUTS;
  bool                                                    env_SCVerify_IDLE_SYNCHRONIZATION_MODE;
  bool                                                    env_SCVerify_ENABLE_RESET_TOGGLE;
  float                                                   env_SCVerify_RESET_CYCLES;
  unsigned long                                           env_SCVerify_MAX_SIM_TIME;
  int                                                     env_SCVerify_AUTOWAIT;
  int                                                     env_SCVerify_AUTOWAIT_INPUT_CYCLES;
  int                                                     env_SCVerify_AUTOWAIT_OUTPUT_CYCLES;
  bool                                                    d_iosync_pause_on_stall;
  bool                                                    d_idle_sync_enabled;
  bool                                                    d_disable_on_empty;
  sc_clock                                                clk;
  mc_programmable_reset                                   arst_n_driver;
  mc_programmable_reset                                   rst_driver;
  sc_signal<sc_logic>                                     TLS_rst;
  sc_signal<sc_logic>                                     TLS_arst_n;
  sc_signal<sc_lv<8> >                                    TLS_dat_in_rsc_dat;
  sc_signal<sc_logic>                                     TLS_dat_in_rsc_vld;
  sc_signal<sc_logic>                                     TLS_dat_in_rsc_rdy;
  sc_signal<sc_lv<11> >                                   TLS_widthIn;
  sc_signal<sc_lv<10> >                                   TLS_heightIn;
  sc_signal<sc_lv<9> >                                    TLS_dx_rsc_dat;
  sc_signal<sc_logic>                                     TLS_dx_rsc_vld;
  sc_signal<sc_logic>                                     TLS_dx_rsc_rdy;
  ccs_DUT_wrapper                                         EdgeDetect_IP_EdgeDetect_HorDer_INST;
  ccs_in_wait_coupled_trans_rsc_v1<1,8 >                  dat_in_rsc_INST;
  ccs_out_wait_trans_rsc_v1<1,9 >                         dx_rsc_INST;
  mgc_in_wire_trans_rsc_v1<1,11 >                         widthIn_rsc_INST;
  mgc_in_wire_trans_rsc_v1<1,10 >                         heightIn_rsc_INST;
  tlm::tlm_fifo<ac_int<8, false > >                       TLS_in_fifo_dat_in;
  tlm::tlm_fifo<mc_wait_ctrl>                             TLS_in_wait_ctrl_fifo_dat_in;
  tlm::tlm_fifo<int>                                      TLS_in_fifo_dat_in_sizecount;
  sc_signal<sc_logic>                                     TLS_dat_in_rsc_trdone;
  mc_channel_input_transactor<ac_int<8, false >,8,false>  transactor_dat_in;
  tlm::tlm_fifo<ac_int<9, true > >                        TLS_out_fifo_dx;
  tlm::tlm_fifo<mc_wait_ctrl>                             TLS_out_wait_ctrl_fifo_dx;
  sc_signal<sc_logic>                                     TLS_dx_rsc_trdone;
  mc_output_transactor<ac_int<9, true >,9,true>           transactor_dx;
  tlm::tlm_fifo<ac_int<11, false > >                      TLS_in_fifo_widthIn;
  tlm::tlm_fifo<mc_wait_ctrl>                             TLS_in_wait_ctrl_fifo_widthIn;
  mc_input_transactor<ac_int<11, false >,11,false>        transactor_widthIn;
  tlm::tlm_fifo<ac_int<10, false > >                      TLS_in_fifo_heightIn;
  tlm::tlm_fifo<mc_wait_ctrl>                             TLS_in_wait_ctrl_fifo_heightIn;
  mc_input_transactor<ac_int<10, false >,10,false>        transactor_heightIn;
  mc_testbench                                            testbench_INST;
  sc_signal<sc_logic>                                     catapult_start;
  sc_signal<sc_logic>                                     catapult_done;
  sc_signal<sc_logic>                                     catapult_ready;
  sc_signal<sc_logic>                                     in_sync;
  sc_signal<sc_logic>                                     out_sync;
  sc_signal<sc_logic>                                     inout_sync;
  sc_signal<unsigned>                                     wait_for_init;
  sync_generator                                          sync_generator_INST;
  catapult_monitor                                        catapult_monitor_INST;
  ccs_probe_monitor                                      *ccs_probe_monitor_INST;
  mc_wait_ctrl                                           *autowait_input_cfg;
  mc_wait_ctrl                                           *autowait_output_cfg;
  sc_event                                                generate_reset_event;
  sc_event                                                deadlock_event;
  sc_signal<sc_logic>                                     deadlocked;
  sc_event                                                max_sim_time_event;
  sc_signal<sc_logic>                                     OFS_EdgeDetect_IP_EdgeDetect_HorDer_run_inst_EdgeDetect_IP_EdgeDetect_HorDer_run_staller_inst_run_wen;
  sc_signal<sc_logic>                                     OFS_dat_in_rsc_vld;
  sc_signal<sc_logic>                                     OFS_dx_rsc_rdy;
  sc_signal<sc_logic>                                     OFS_EdgeDetect_IP_EdgeDetect_HorDer_run_inst_EdgeDetect_IP_EdgeDetect_HorDer_run_dat_in_rsci_inst_EdgeDetect_IP_EdgeDetect_HorDer_run_dat_in_rsci_dat_in_wait_ctrl_inst_dat_in_rsci_irdy_run_sct;
  sc_signal<sc_logic>                                     OFS_EdgeDetect_IP_EdgeDetect_HorDer_run_inst_EdgeDetect_IP_EdgeDetect_HorDer_run_dx_rsci_inst_EdgeDetect_IP_EdgeDetect_HorDer_run_dx_rsci_dx_wait_ctrl_inst_dx_rsci_irdy;
  sc_signal<sc_logic>                                     OFS_EdgeDetect_IP_EdgeDetect_HorDer_run_inst_EdgeDetect_IP_EdgeDetect_HorDer_run_dx_rsci_inst_EdgeDetect_IP_EdgeDetect_HorDer_run_dx_rsci_dx_wait_ctrl_inst_dx_rsci_ivld_run_sct;
  sc_signal<sc_logic>                                     TLS_enable_stalls;
  sc_signal<unsigned short>                               TLS_stall_coverage;
  bool                                                    var_trdone;

  void read_env();
  void TLS_arst_n_method();
  void TLS_rst_method();
  void drive_TLS_dat_in_rsc_trdone();
  void drive_TLS_dx_rsc_trdone();
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
  void drive_idle_reg();
  void idle_watch();

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
    , TLS_dat_in_rsc_dat("TLS_dat_in_rsc_dat")
    , TLS_dat_in_rsc_vld("TLS_dat_in_rsc_vld")
    , TLS_dat_in_rsc_rdy("TLS_dat_in_rsc_rdy")
    , TLS_widthIn("TLS_widthIn")
    , TLS_heightIn("TLS_heightIn")
    , TLS_dx_rsc_dat("TLS_dx_rsc_dat")
    , TLS_dx_rsc_vld("TLS_dx_rsc_vld")
    , TLS_dx_rsc_rdy("TLS_dx_rsc_rdy")
    , EdgeDetect_IP_EdgeDetect_HorDer_INST("rtl", TO_QUOTED_STRING(TOP_HDL_ENTITY))
    , dat_in_rsc_INST("dat_in_rsc", true)
    , dx_rsc_INST("dx_rsc", true)
    , widthIn_rsc_INST("widthIn_rsc", true)
    , heightIn_rsc_INST("heightIn_rsc", true)
    , TLS_in_fifo_dat_in("TLS_in_fifo_dat_in", -1)
    , TLS_in_wait_ctrl_fifo_dat_in("TLS_in_wait_ctrl_fifo_dat_in", -1)
    , TLS_in_fifo_dat_in_sizecount("TLS_in_fifo_dat_in_sizecount", 1)
    , TLS_dat_in_rsc_trdone("TLS_dat_in_rsc_trdone")
    , transactor_dat_in("transactor_dat_in", 0, 8, 0, d_disable_on_empty)
    , TLS_out_fifo_dx("TLS_out_fifo_dx", -1)
    , TLS_out_wait_ctrl_fifo_dx("TLS_out_wait_ctrl_fifo_dx", -1)
    , TLS_dx_rsc_trdone("TLS_dx_rsc_trdone")
    , transactor_dx("transactor_dx", 0, 9, 0)
    , TLS_in_fifo_widthIn("TLS_in_fifo_widthIn", 1)
    , TLS_in_wait_ctrl_fifo_widthIn("TLS_in_wait_ctrl_fifo_widthIn", 1)
    , transactor_widthIn("transactor_widthIn", 0, 11, 0, d_disable_on_empty)
    , TLS_in_fifo_heightIn("TLS_in_fifo_heightIn", 1)
    , TLS_in_wait_ctrl_fifo_heightIn("TLS_in_wait_ctrl_fifo_heightIn", 1)
    , transactor_heightIn("transactor_heightIn", 0, 10, 0, d_disable_on_empty)
    , testbench_INST("user_tb")
    , catapult_start("catapult_start")
    , catapult_done("catapult_done")
    , catapult_ready("catapult_ready")
    , in_sync("in_sync")
    , out_sync("out_sync")
    , inout_sync("inout_sync")
    , wait_for_init("wait_for_init")
    , sync_generator_INST("sync_generator", true, false, false, false, 6, 6, 0)
    , catapult_monitor_INST("Monitor", clk, true, 6LL, 6LL)
    , ccs_probe_monitor_INST(NULL)
    , autowait_input_cfg(NULL)
    , autowait_output_cfg(NULL)
    , deadlocked("deadlocked")
    , var_trdone(false)
  {
    read_env();

    arst_n_driver.reset_out(TLS_arst_n);

    rst_driver.reset_out(TLS_rst);

    EdgeDetect_IP_EdgeDetect_HorDer_INST.clk(clk);
    EdgeDetect_IP_EdgeDetect_HorDer_INST.rst(TLS_rst);
    EdgeDetect_IP_EdgeDetect_HorDer_INST.arst_n(TLS_arst_n);
    EdgeDetect_IP_EdgeDetect_HorDer_INST.dat_in_rsc_dat(TLS_dat_in_rsc_dat);
    EdgeDetect_IP_EdgeDetect_HorDer_INST.dat_in_rsc_vld(TLS_dat_in_rsc_vld);
    EdgeDetect_IP_EdgeDetect_HorDer_INST.dat_in_rsc_rdy(TLS_dat_in_rsc_rdy);
    EdgeDetect_IP_EdgeDetect_HorDer_INST.widthIn(TLS_widthIn);
    EdgeDetect_IP_EdgeDetect_HorDer_INST.heightIn(TLS_heightIn);
    EdgeDetect_IP_EdgeDetect_HorDer_INST.dx_rsc_dat(TLS_dx_rsc_dat);
    EdgeDetect_IP_EdgeDetect_HorDer_INST.dx_rsc_vld(TLS_dx_rsc_vld);
    EdgeDetect_IP_EdgeDetect_HorDer_INST.dx_rsc_rdy(TLS_dx_rsc_rdy);

    dat_in_rsc_INST.rdy(TLS_dat_in_rsc_rdy);
    dat_in_rsc_INST.vld(TLS_dat_in_rsc_vld);
    dat_in_rsc_INST.dat(TLS_dat_in_rsc_dat);
    dat_in_rsc_INST.clk(clk);
    dat_in_rsc_INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_1)));

    dx_rsc_INST.rdy(TLS_dx_rsc_rdy);
    dx_rsc_INST.vld(TLS_dx_rsc_vld);
    dx_rsc_INST.dat(TLS_dx_rsc_dat);
    dx_rsc_INST.clk(clk);
    dx_rsc_INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_4)));

    widthIn_rsc_INST.clk(clk);
    widthIn_rsc_INST.z(TLS_widthIn);
    widthIn_rsc_INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_2)));

    heightIn_rsc_INST.clk(clk);
    heightIn_rsc_INST.z(TLS_heightIn);
    heightIn_rsc_INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_3)));

    transactor_dat_in.in_fifo(TLS_in_fifo_dat_in);
    transactor_dat_in.in_wait_ctrl_fifo(TLS_in_wait_ctrl_fifo_dat_in);
    transactor_dat_in.sizecount_fifo(TLS_in_fifo_dat_in_sizecount);
    transactor_dat_in.set_disable_on_empty(d_disable_on_empty);
    transactor_dat_in.bind_clk(clk, true, rst);
    transactor_dat_in.add_attribute(*(new sc_attribute<int>("MC_TRANSACTOR_EVENT", 0 )));
    transactor_dat_in.register_block(&dat_in_rsc_INST, dat_in_rsc_INST.basename(), TLS_dat_in_rsc_trdone, 0, 0, 1);

    transactor_dx.out_fifo(TLS_out_fifo_dx);
    transactor_dx.out_wait_ctrl_fifo(TLS_out_wait_ctrl_fifo_dx);
    transactor_dx.bind_clk(clk, true, rst);
    transactor_dx.add_attribute(*(new sc_attribute<int>("MC_TRANSACTOR_EVENT", 0 )));
    transactor_dx.register_block(&dx_rsc_INST, dx_rsc_INST.basename(), TLS_dx_rsc_trdone, 0, 0, 1);

    transactor_widthIn.in_fifo(TLS_in_fifo_widthIn);
    transactor_widthIn.in_wait_ctrl_fifo(TLS_in_wait_ctrl_fifo_widthIn);
    transactor_widthIn.set_disable_on_empty(d_disable_on_empty);
    transactor_widthIn.bind_clk(clk, true, rst);
    transactor_widthIn.add_attribute(*(new sc_attribute<int>("MC_TRANSACTOR_EVENT", 0 )));
    if (!d_idle_sync_enabled) { transactor_widthIn.register_block(&widthIn_rsc_INST, widthIn_rsc_INST.basename(), in_sync, 0, 0, 1); }
    if (d_idle_sync_enabled) { transactor_widthIn.register_block(&widthIn_rsc_INST, widthIn_rsc_INST.basename(), TLS_design_is_idle, 0, 0, 1); }

    transactor_heightIn.in_fifo(TLS_in_fifo_heightIn);
    transactor_heightIn.in_wait_ctrl_fifo(TLS_in_wait_ctrl_fifo_heightIn);
    transactor_heightIn.set_disable_on_empty(d_disable_on_empty);
    transactor_heightIn.bind_clk(clk, true, rst);
    transactor_heightIn.add_attribute(*(new sc_attribute<int>("MC_TRANSACTOR_EVENT", 0 )));
    if (!d_idle_sync_enabled) { transactor_heightIn.register_block(&heightIn_rsc_INST, heightIn_rsc_INST.basename(), in_sync, 0, 0, 1); }
    if (d_idle_sync_enabled) { transactor_heightIn.register_block(&heightIn_rsc_INST, heightIn_rsc_INST.basename(), TLS_design_is_idle, 0, 0, 1); }

    testbench_INST.clk(clk);
    testbench_INST.ccs_dat_in(TLS_in_fifo_dat_in);
    testbench_INST.ccs_wait_ctrl_dat_in(TLS_in_wait_ctrl_fifo_dat_in);
    testbench_INST.ccs_sizecount_dat_in(TLS_in_fifo_dat_in_sizecount);
    testbench_INST.ccs_dx(TLS_out_fifo_dx);
    testbench_INST.ccs_wait_ctrl_dx(TLS_out_wait_ctrl_fifo_dx);
    testbench_INST.ccs_widthIn(TLS_in_fifo_widthIn);
    testbench_INST.ccs_wait_ctrl_widthIn(TLS_in_wait_ctrl_fifo_widthIn);
    testbench_INST.ccs_heightIn(TLS_in_fifo_heightIn);
    testbench_INST.ccs_wait_ctrl_heightIn(TLS_in_wait_ctrl_fifo_heightIn);
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

    SC_METHOD(drive_TLS_dat_in_rsc_trdone);
      sensitive << TLS_dat_in_rsc_rdy;
      sensitive << TLS_dat_in_rsc_vld;
      sensitive << rst;

    SC_METHOD(drive_TLS_dx_rsc_trdone);
      sensitive << TLS_dx_rsc_vld;
      sensitive << TLS_dx_rsc_rdy;

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
      sensitive << OFS_EdgeDetect_IP_EdgeDetect_HorDer_run_inst_EdgeDetect_IP_EdgeDetect_HorDer_run_staller_inst_run_wen;
      dont_initialize();

    SC_METHOD(deadlock_notify);
      sensitive << deadlock_event;
      dont_initialize();

    SC_METHOD(drive_idle_reg);
      sensitive << clk;

    SC_METHOD(idle_watch);
      sensitive << OFS_EdgeDetect_IP_EdgeDetect_HorDer_run_inst_EdgeDetect_IP_EdgeDetect_HorDer_run_staller_inst_run_wen;
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
  unsigned long latency_est = 2;
  unsigned long trcnt = 1;
  if (env_SCVerify_ENABLE_RESET_TOGGLE) { trcnt = ceil(env_SCVerify_RESET_CYCLES+0.5)*3; }
  unsigned long wait_for_cycles = latency_est * 9 + trcnt;
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
  dat_in_rsc_INST.clear();
  dx_rsc_INST.clear();
}

void scverify_top::TLS_rst_method() {
  std::ostringstream msg;
  msg << "TLS_rst active @ " << sc_time_stamp();
  SC_REPORT_INFO("HW reset", msg.str().c_str());
  dat_in_rsc_INST.clear();
  dx_rsc_INST.clear();
}

void scverify_top::drive_TLS_dat_in_rsc_trdone() {
  if (!env_SCVerify_ENABLE_RESET_TOGGLE && rst.read() == SC_LOGIC_1) {
    assert(TLS_dat_in_rsc_rdy.read() != SC_LOGIC_1);
  }
  TLS_dat_in_rsc_trdone.write(TLS_dat_in_rsc_rdy.read() & TLS_dat_in_rsc_vld.read() & ~rst.read());
}

void scverify_top::drive_TLS_dx_rsc_trdone() {
  TLS_dx_rsc_trdone.write(TLS_dx_rsc_vld.read() & TLS_dx_rsc_rdy.read());
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
  autowait_input_cfg = new mc_wait_ctrl(0, 1, env_SCVerify_AUTOWAIT_INPUT_CYCLES, mc_wait_ctrl::RANDOM, mc_wait_ctrl::INITIAL, 0, true);
  autowait_output_cfg = new mc_wait_ctrl(0, 1, env_SCVerify_AUTOWAIT_OUTPUT_CYCLES, mc_wait_ctrl::RANDOM, mc_wait_ctrl::INITIAL, 0, true);
  transactor_dat_in.set_auto_wait_limit(env_SCVerify_AUTOWAIT);
  transactor_dat_in.configure_autowait(autowait_input_cfg);
  transactor_dx.set_auto_wait_limit(env_SCVerify_AUTOWAIT);
  transactor_dx.configure_autowait(autowait_output_cfg);
  transactor_widthIn.set_auto_wait_limit(env_SCVerify_AUTOWAIT);
  transactor_widthIn.configure_autowait(autowait_input_cfg);
  transactor_heightIn.set_auto_wait_limit(env_SCVerify_AUTOWAIT);
  transactor_heightIn.configure_autowait(autowait_input_cfg);
}

void scverify_top::inform_autowait() {
  bool waited = false;
  waited |= (transactor_dat_in.atleast_one_autowait(0) > 0);
  waited |= (transactor_dx.atleast_one_autowait(1) > 0);
  waited |= (transactor_widthIn.atleast_one_autowait(0) > 0);
  waited |= (transactor_heightIn.atleast_one_autowait(0) > 0);
  if (waited)
    SC_REPORT_INFO(name(), "At least one AUTOWAIT was applied during simulation.");
}

void scverify_top::setup_debug() {
#ifdef MC_DEFAULT_TRANSACTOR_LOG
  static int transactor_dat_in_flags = MC_DEFAULT_TRANSACTOR_LOG;
  static int transactor_dx_flags = MC_DEFAULT_TRANSACTOR_LOG;
  static int transactor_widthIn_flags = MC_DEFAULT_TRANSACTOR_LOG;
  static int transactor_heightIn_flags = MC_DEFAULT_TRANSACTOR_LOG;
#else
  static int transactor_dat_in_flags = (d_disable_on_empty ? 0 : MC_TRANSACTOR_UNDERFLOW) | MC_TRANSACTOR_WAIT;
  static int transactor_dx_flags = MC_TRANSACTOR_UNDERFLOW | MC_TRANSACTOR_WAIT;
  static int transactor_widthIn_flags = 0;
  static int transactor_heightIn_flags = 0;
#endif
  static int transactor_dat_in_count = -1;
  static int transactor_dx_count = -1;
  static int transactor_widthIn_count = -1;
  static int transactor_heightIn_count = -1;

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
    debug("transactor_dat_in",transactor_dat_in_flags,transactor_dat_in_count);
    debug("transactor_dx",transactor_dx_flags,transactor_dx_count);
    debug("transactor_widthIn",transactor_widthIn_flags,transactor_widthIn_count);
    debug("transactor_heightIn",transactor_heightIn_flags,transactor_heightIn_count);
  }
}

void scverify_top::debug(const char* varname, int flags, int count) {
  sc_module *xlator_p = 0;
  sc_attr_base *debug_attr_p = 0;
  if (strcmp(varname,"transactor_dat_in") == 0)
    xlator_p = &transactor_dat_in;
  if (strcmp(varname,"transactor_dx") == 0)
    xlator_p = &transactor_dx;
  if (strcmp(varname,"transactor_widthIn") == 0)
    xlator_p = &transactor_widthIn;
  if (strcmp(varname,"transactor_heightIn") == 0)
    xlator_p = &transactor_heightIn;
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
      transactor_dat_in.reset_streams();
      transactor_dx.reset_streams();
      transactor_widthIn.reset_streams();
      transactor_heightIn.reset_streams();
      rst.write(SC_LOGIC_0);
    }
    activate_reset = true;
  }
}

void scverify_top::install_observe_foreign_signals() {
#if !defined(CCS_DUT_SYSC)
#if defined(CCS_DUT_CYCLE) || defined(CCS_DUT_RTL)
  OBSERVE_FOREIGN_SIGNAL(OFS_EdgeDetect_IP_EdgeDetect_HorDer_run_inst_EdgeDetect_IP_EdgeDetect_HorDer_run_staller_inst_run_wen, /scverify_top/rtl/EdgeDetect_IP_EdgeDetect_HorDer_run_inst/EdgeDetect_IP_EdgeDetect_HorDer_run_staller_inst/run_wen);
  OBSERVE_FOREIGN_SIGNAL(OFS_dat_in_rsc_vld, /scverify_top/rtl/dat_in_rsc_vld);
  OBSERVE_FOREIGN_SIGNAL(OFS_dx_rsc_rdy, /scverify_top/rtl/dx_rsc_rdy);
  OBSERVE_FOREIGN_SIGNAL(OFS_EdgeDetect_IP_EdgeDetect_HorDer_run_inst_EdgeDetect_IP_EdgeDetect_HorDer_run_dat_in_rsci_inst_EdgeDetect_IP_EdgeDetect_HorDer_run_dat_in_rsci_dat_in_wait_ctrl_inst_dat_in_rsci_irdy_run_sct,
      /scverify_top/rtl/EdgeDetect_IP_EdgeDetect_HorDer_run_inst/EdgeDetect_IP_EdgeDetect_HorDer_run_dat_in_rsci_inst/EdgeDetect_IP_EdgeDetect_HorDer_run_dat_in_rsci_dat_in_wait_ctrl_inst/dat_in_rsci_irdy_run_sct);
  OBSERVE_FOREIGN_SIGNAL(OFS_EdgeDetect_IP_EdgeDetect_HorDer_run_inst_EdgeDetect_IP_EdgeDetect_HorDer_run_dx_rsci_inst_EdgeDetect_IP_EdgeDetect_HorDer_run_dx_rsci_dx_wait_ctrl_inst_dx_rsci_irdy,
      /scverify_top/rtl/EdgeDetect_IP_EdgeDetect_HorDer_run_inst/EdgeDetect_IP_EdgeDetect_HorDer_run_dx_rsci_inst/EdgeDetect_IP_EdgeDetect_HorDer_run_dx_rsci_dx_wait_ctrl_inst/dx_rsci_irdy);
  OBSERVE_FOREIGN_SIGNAL(OFS_EdgeDetect_IP_EdgeDetect_HorDer_run_inst_EdgeDetect_IP_EdgeDetect_HorDer_run_dx_rsci_inst_EdgeDetect_IP_EdgeDetect_HorDer_run_dx_rsci_dx_wait_ctrl_inst_dx_rsci_ivld_run_sct,
      /scverify_top/rtl/EdgeDetect_IP_EdgeDetect_HorDer_run_inst/EdgeDetect_IP_EdgeDetect_HorDer_run_dx_rsci_inst/EdgeDetect_IP_EdgeDetect_HorDer_run_dx_rsci_dx_wait_ctrl_inst/dx_rsci_ivld_run_sct);
#endif
#endif
}

void scverify_top::deadlock_watch() {
#if !defined(CCS_DUT_SYSC) && defined(DEADLOCK_DETECTION)
#if defined(CCS_DUT_CYCLE) || defined(CCS_DUT_RTL)
#if defined(MTI_SYSTEMC) || defined(NCSC) || defined(VCS_SYSTEMC)
  if (!clk) {
    if (rst == SC_LOGIC_0 &&
      (OFS_EdgeDetect_IP_EdgeDetect_HorDer_run_inst_EdgeDetect_IP_EdgeDetect_HorDer_run_staller_inst_run_wen.read() == SC_LOGIC_0)
      && (OFS_dat_in_rsc_vld.read() == SC_LOGIC_1)
      && (OFS_dx_rsc_rdy.read() == SC_LOGIC_1)
    ) {
      deadlocked.write(SC_LOGIC_1);
      deadlock_event.notify(d_deadlock_time, SC_NS);
    } else {
      if (deadlocked.read() == SC_LOGIC_1)
        deadlock_event.cancel();
      deadlocked.write(SC_LOGIC_0);
    }
  }
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

void scverify_top::drive_idle_reg() {
#if defined(MTI_SYSTEMC) || defined(NCSC) || defined(VCS_SYSTEMC)
  static unsigned short wait_for_idle_buf;
  if (clk.read() == SC_LOGIC_1 && rst.read() == SC_LOGIC_0) {
    if (TLS_design_is_idle.read() == SC_LOGIC_1) {
      wait_for_idle_buf++;
    } else {
      wait_for_idle_buf = 0;
    }
    if (wait_for_idle_buf >= (env_SCVerify_AUTOWAIT != 0 ? env_SCVerify_AUTOWAIT_INPUT_CYCLES : testbench::idle_sync_stable_cycles)) {
      TLS_design_is_idle_reg.write(true);
      if (var_trdone) var_trdone = false;
      wait_for_idle_buf = 0;
    } else {
      TLS_design_is_idle_reg.write(false);
    }
  }
#endif
}

void scverify_top::idle_watch() {
#if defined(MTI_SYSTEMC) || defined(NCSC) || defined(VCS_SYSTEMC)
  bool X = (OFS_EdgeDetect_IP_EdgeDetect_HorDer_run_inst_EdgeDetect_IP_EdgeDetect_HorDer_run_staller_inst_run_wen.read()==0);
  bool Y = false;
  var_trdone = X || Y;
  TLS_design_is_idle.write(var_trdone ? SC_LOGIC_1 : SC_LOGIC_0);
#endif
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
