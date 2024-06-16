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
#else
double __scv_hold_time = 0.0; // default for non-gate simulation is zero
double __scv_hold_time_RSCID_1 = 0;
double __scv_hold_time_RSCID_2 = 0;
#endif

class scverify_top : public sc_module
{
public:
  sc_signal<sc_logic>                                                           rst;
  sc_signal<sc_logic>                                                           rst_n;
  sc_signal<sc_logic>                                                           SIG_SC_LOGIC_0;
  sc_signal<sc_logic>                                                           SIG_SC_LOGIC_1;
  sc_signal<sc_logic>                                                           TLS_design_is_idle;
  sc_signal<bool>                                                               TLS_design_is_idle_reg;
  unsigned long                                                                 d_max_sim_time;
  unsigned long                                                                 d_deadlock_time;
  bool                                                                          env_SCVerify_DEADLOCK_DETECTION;
  bool                                                                          env_SCVerify_DISABLE_EMPTY_INPUTS;
  bool                                                                          env_SCVerify_IDLE_SYNCHRONIZATION_MODE;
  bool                                                                          env_SCVerify_ENABLE_RESET_TOGGLE;
  float                                                                         env_SCVerify_RESET_CYCLES;
  unsigned long                                                                 env_SCVerify_MAX_SIM_TIME;
  int                                                                           env_SCVerify_AUTOWAIT;
  int                                                                           env_SCVerify_AUTOWAIT_INPUT_CYCLES;
  int                                                                           env_SCVerify_AUTOWAIT_OUTPUT_CYCLES;
  bool                                                                          d_iosync_pause_on_stall;
  bool                                                                          d_idle_sync_enabled;
  bool                                                                          d_disable_on_empty;
  sc_clock                                                                      clk;
  mc_programmable_reset                                                         rst_driver;
  sc_signal<sc_logic>                                                           TLS_rst;
  sc_signal<sc_lv<12> >                                                         TLS_input_rsc_dat;
  sc_signal<sc_logic>                                                           TLS_input_rsc_vld;
  sc_signal<sc_logic>                                                           TLS_input_rsc_rdy;
  sc_signal<sc_lv<12> >                                                         TLS_output_rsc_dat;
  sc_signal<sc_logic>                                                           TLS_output_rsc_vld;
  sc_signal<sc_logic>                                                           TLS_output_rsc_rdy;
  ccs_DUT_wrapper                                                               UNET_IP_main_INST;
  ccs_in_wait_trans_rsc_v1<1,12 >                                               input_rsc_INST;
  ccs_out_wait_trans_rsc_v1<1,12 >                                              output_rsc_INST;
  tlm::tlm_fifo<ac_fixed<12, 6, true, AC_TRN, AC_WRAP > >                       TLS_in_fifo_input;
  tlm::tlm_fifo<mc_wait_ctrl>                                                   TLS_in_wait_ctrl_fifo_input;
  tlm::tlm_fifo<int>                                                            TLS_in_fifo_input_sizecount;
  sc_signal<sc_logic>                                                           TLS_input_rsc_trdone;
  mc_channel_input_transactor<ac_fixed<12, 6, true, AC_TRN, AC_WRAP >,12,true>  transactor_input;
  tlm::tlm_fifo<ac_fixed<12, 6, true, AC_TRN, AC_WRAP > >                       TLS_out_fifo_output;
  tlm::tlm_fifo<mc_wait_ctrl>                                                   TLS_out_wait_ctrl_fifo_output;
  sc_signal<sc_logic>                                                           TLS_output_rsc_trdone;
  mc_output_transactor<ac_fixed<12, 6, true, AC_TRN, AC_WRAP >,12,true>         transactor_output;
  mc_testbench                                                                  testbench_INST;
  sc_signal<sc_logic>                                                           catapult_start;
  sc_signal<sc_logic>                                                           catapult_done;
  sc_signal<sc_logic>                                                           catapult_ready;
  sc_signal<sc_logic>                                                           in_sync;
  sc_signal<sc_logic>                                                           out_sync;
  sc_signal<sc_logic>                                                           inout_sync;
  sc_signal<unsigned>                                                           wait_for_init;
  sync_generator                                                                sync_generator_INST;
  catapult_monitor                                                              catapult_monitor_INST;
  ccs_probe_monitor                                                            *ccs_probe_monitor_INST;
  mc_wait_ctrl                                                                 *autowait_input_cfg;
  mc_wait_ctrl                                                                 *autowait_output_cfg;
  sc_event                                                                      generate_reset_event;
  sc_event                                                                      deadlock_event;
  sc_signal<sc_logic>                                                           deadlocked;
  sc_event                                                                      max_sim_time_event;
  sc_signal<sc_logic>                                                           OFS_UNET_IP_main_run_inst_UNET_IP_main_run_staller_inst_run_wen;
  sc_signal<sc_logic>                                                           OFS_input_rsc_vld;
  sc_signal<sc_logic>                                                           OFS_output_rsc_rdy;
  sc_signal<sc_logic>                                                           OFS_UNET_IP_main_run_inst_UNET_IP_main_run_input_rsci_inst_UNET_IP_main_run_input_rsci_input_wait_ctrl_inst_input_rsci_ivld;
  sc_signal<sc_logic>                                                           OFS_UNET_IP_main_run_inst_UNET_IP_main_run_output_rsci_inst_UNET_IP_main_run_output_rsci_output_wait_ctrl_inst_output_rsci_irdy;
  sc_signal<sc_logic>                                                           TLS_enable_stalls;
  sc_signal<unsigned short>                                                     TLS_stall_coverage;
  bool                                                                          var_trdone;

  void read_env();
  void TLS_rst_method();
  void drive_TLS_input_rsc_trdone();
  void drive_TLS_output_rsc_trdone();
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
    , rst_driver("rst_driver", ac_env::read_float("SCVerify_RESET_CYCLES",2.0)*10.000000, false)
    , TLS_rst("TLS_rst")
    , TLS_input_rsc_dat("TLS_input_rsc_dat")
    , TLS_input_rsc_vld("TLS_input_rsc_vld")
    , TLS_input_rsc_rdy("TLS_input_rsc_rdy")
    , TLS_output_rsc_dat("TLS_output_rsc_dat")
    , TLS_output_rsc_vld("TLS_output_rsc_vld")
    , TLS_output_rsc_rdy("TLS_output_rsc_rdy")
    , UNET_IP_main_INST("rtl", "ccs_wrapper")
    , input_rsc_INST("input_rsc", true)
    , output_rsc_INST("output_rsc", true)
    , TLS_in_fifo_input("TLS_in_fifo_input", -1)
    , TLS_in_wait_ctrl_fifo_input("TLS_in_wait_ctrl_fifo_input", -1)
    , TLS_in_fifo_input_sizecount("TLS_in_fifo_input_sizecount", 1)
    , TLS_input_rsc_trdone("TLS_input_rsc_trdone")
    , transactor_input("transactor_input", 0, 12, 0, d_disable_on_empty)
    , TLS_out_fifo_output("TLS_out_fifo_output", -1)
    , TLS_out_wait_ctrl_fifo_output("TLS_out_wait_ctrl_fifo_output", -1)
    , TLS_output_rsc_trdone("TLS_output_rsc_trdone")
    , transactor_output("transactor_output", 0, 12, 0)
    , testbench_INST("user_tb")
    , catapult_start("catapult_start")
    , catapult_done("catapult_done")
    , catapult_ready("catapult_ready")
    , in_sync("in_sync")
    , out_sync("out_sync")
    , inout_sync("inout_sync")
    , wait_for_init("wait_for_init")
    , sync_generator_INST("sync_generator", true, false, false, false, 9338876, 9338876, 0)
    , catapult_monitor_INST("Monitor", clk, true, 9338876LL, 9338876LL)
    , ccs_probe_monitor_INST(NULL)
    , autowait_input_cfg(NULL)
    , autowait_output_cfg(NULL)
    , deadlocked("deadlocked")
    , var_trdone(false)
  {
    read_env();

    rst_driver.reset_out(TLS_rst);

    UNET_IP_main_INST.clk(clk);
    UNET_IP_main_INST.rst(TLS_rst);
    UNET_IP_main_INST.input_rsc_dat(TLS_input_rsc_dat);
    UNET_IP_main_INST.input_rsc_vld(TLS_input_rsc_vld);
    UNET_IP_main_INST.input_rsc_rdy(TLS_input_rsc_rdy);
    UNET_IP_main_INST.output_rsc_dat(TLS_output_rsc_dat);
    UNET_IP_main_INST.output_rsc_vld(TLS_output_rsc_vld);
    UNET_IP_main_INST.output_rsc_rdy(TLS_output_rsc_rdy);

    input_rsc_INST.rdy(TLS_input_rsc_rdy);
    input_rsc_INST.vld(TLS_input_rsc_vld);
    input_rsc_INST.dat(TLS_input_rsc_dat);
    input_rsc_INST.clk(clk);
    input_rsc_INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_1)));

    output_rsc_INST.rdy(TLS_output_rsc_rdy);
    output_rsc_INST.vld(TLS_output_rsc_vld);
    output_rsc_INST.dat(TLS_output_rsc_dat);
    output_rsc_INST.clk(clk);
    output_rsc_INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_2)));

    transactor_input.in_fifo(TLS_in_fifo_input);
    transactor_input.in_wait_ctrl_fifo(TLS_in_wait_ctrl_fifo_input);
    transactor_input.sizecount_fifo(TLS_in_fifo_input_sizecount);
    transactor_input.set_disable_on_empty(d_disable_on_empty);
    transactor_input.bind_clk(clk, true, rst);
    transactor_input.add_attribute(*(new sc_attribute<int>("MC_TRANSACTOR_EVENT", 0 )));
    transactor_input.register_block(&input_rsc_INST, input_rsc_INST.basename(), TLS_input_rsc_trdone, 0, 0, 1);

    transactor_output.out_fifo(TLS_out_fifo_output);
    transactor_output.out_wait_ctrl_fifo(TLS_out_wait_ctrl_fifo_output);
    transactor_output.bind_clk(clk, true, rst);
    transactor_output.add_attribute(*(new sc_attribute<int>("MC_TRANSACTOR_EVENT", 0 )));
    transactor_output.register_block(&output_rsc_INST, output_rsc_INST.basename(), TLS_output_rsc_trdone, 0, 0, 1);

    testbench_INST.clk(clk);
    testbench_INST.ccs_input(TLS_in_fifo_input);
    testbench_INST.ccs_wait_ctrl_input(TLS_in_wait_ctrl_fifo_input);
    testbench_INST.ccs_sizecount_input(TLS_in_fifo_input_sizecount);
    testbench_INST.ccs_output(TLS_out_fifo_output);
    testbench_INST.ccs_wait_ctrl_output(TLS_out_wait_ctrl_fifo_output);
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


    SC_METHOD(TLS_rst_method);
      sensitive_pos << TLS_rst;
      dont_initialize();

    SC_METHOD(drive_TLS_input_rsc_trdone);
      sensitive << TLS_input_rsc_rdy;
      sensitive << TLS_input_rsc_vld;
      sensitive << rst;

    SC_METHOD(drive_TLS_output_rsc_trdone);
      sensitive << TLS_output_rsc_vld;
      sensitive << TLS_output_rsc_rdy;

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
      sensitive << OFS_UNET_IP_main_run_inst_UNET_IP_main_run_staller_inst_run_wen;
      dont_initialize();

    SC_METHOD(deadlock_notify);
      sensitive << deadlock_event;
      dont_initialize();

    SC_METHOD(drive_idle_reg);
      sensitive << clk;

    SC_METHOD(idle_watch);
      sensitive << OFS_UNET_IP_main_run_inst_UNET_IP_main_run_staller_inst_run_wen;
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
  unsigned long latency_est = 9338874;
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

void scverify_top::TLS_rst_method() {
  std::ostringstream msg;
  msg << "TLS_rst active @ " << sc_time_stamp();
  SC_REPORT_INFO("HW reset", msg.str().c_str());
  input_rsc_INST.clear();
  output_rsc_INST.clear();
}

void scverify_top::drive_TLS_input_rsc_trdone() {
  if (!env_SCVerify_ENABLE_RESET_TOGGLE && rst.read() == SC_LOGIC_1) {
    assert(TLS_input_rsc_rdy.read() != SC_LOGIC_1);
  }
  TLS_input_rsc_trdone.write(TLS_input_rsc_rdy.read() & TLS_input_rsc_vld.read() & ~rst.read());
}

void scverify_top::drive_TLS_output_rsc_trdone() {
  TLS_output_rsc_trdone.write(TLS_output_rsc_vld.read() & TLS_output_rsc_rdy.read());
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
  transactor_input.set_auto_wait_limit(env_SCVerify_AUTOWAIT);
  transactor_input.configure_autowait(autowait_input_cfg);
  transactor_output.set_auto_wait_limit(env_SCVerify_AUTOWAIT);
  transactor_output.configure_autowait(autowait_output_cfg);
}

void scverify_top::inform_autowait() {
  bool waited = false;
  waited |= (transactor_input.atleast_one_autowait(0) > 0);
  waited |= (transactor_output.atleast_one_autowait(1) > 0);
  if (waited)
    SC_REPORT_INFO(name(), "At least one AUTOWAIT was applied during simulation.");
}

void scverify_top::setup_debug() {
#ifdef MC_DEFAULT_TRANSACTOR_LOG
  static int transactor_input_flags = MC_DEFAULT_TRANSACTOR_LOG;
  static int transactor_output_flags = MC_DEFAULT_TRANSACTOR_LOG;
#else
  static int transactor_input_flags = (d_disable_on_empty ? 0 : MC_TRANSACTOR_UNDERFLOW) | MC_TRANSACTOR_WAIT;
  static int transactor_output_flags = MC_TRANSACTOR_UNDERFLOW | MC_TRANSACTOR_WAIT;
#endif
  static int transactor_input_count = -1;
  static int transactor_output_count = -1;

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
  }
}

void scverify_top::debug(const char* varname, int flags, int count) {
  sc_module *xlator_p = 0;
  sc_attr_base *debug_attr_p = 0;
  if (strcmp(varname,"transactor_input") == 0)
    xlator_p = &transactor_input;
  if (strcmp(varname,"transactor_output") == 0)
    xlator_p = &transactor_output;
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
    rst_driver.reset_driver();
    generate_reset_event.notify(env_SCVerify_RESET_CYCLES*10.000000, SC_NS);
  } else {
    if (toggle_hw_reset) {
      toggle_hw_reset = false;
      generate_reset_event.notify(env_SCVerify_RESET_CYCLES*10.000000, SC_NS);
    } else {
      transactor_input.reset_streams();
      transactor_output.reset_streams();
      rst.write(SC_LOGIC_0);
    }
    activate_reset = true;
  }
}

void scverify_top::install_observe_foreign_signals() {
#if !defined(CCS_DUT_SYSC)
#if defined(CCS_DUT_CYCLE) || defined(CCS_DUT_RTL)
  OBSERVE_FOREIGN_SIGNAL(OFS_UNET_IP_main_run_inst_UNET_IP_main_run_staller_inst_run_wen, /scverify_top/rtl/dut_inst/UNET_IP_main_run_inst/UNET_IP_main_run_staller_inst/run_wen);
  OBSERVE_FOREIGN_SIGNAL(OFS_input_rsc_vld, /scverify_top/rtl/dut_inst/input_rsc_vld);
  OBSERVE_FOREIGN_SIGNAL(OFS_output_rsc_rdy, /scverify_top/rtl/dut_inst/output_rsc_rdy);
  OBSERVE_FOREIGN_SIGNAL(OFS_UNET_IP_main_run_inst_UNET_IP_main_run_input_rsci_inst_UNET_IP_main_run_input_rsci_input_wait_ctrl_inst_input_rsci_ivld, /scverify_top/rtl/dut_inst/UNET_IP_main_run_inst/UNET_IP_main_run_input_rsci_inst/UNET_IP_main_run_input_rsci_input_wait_ctrl_inst/input_rsci_ivld);
  OBSERVE_FOREIGN_SIGNAL(OFS_UNET_IP_main_run_inst_UNET_IP_main_run_output_rsci_inst_UNET_IP_main_run_output_rsci_output_wait_ctrl_inst_output_rsci_irdy, /scverify_top/rtl/dut_inst/UNET_IP_main_run_inst/UNET_IP_main_run_output_rsci_inst/UNET_IP_main_run_output_rsci_output_wait_ctrl_inst/output_rsci_irdy);
#endif
#endif
}

void scverify_top::deadlock_watch() {
#if !defined(CCS_DUT_SYSC) && defined(DEADLOCK_DETECTION)
#if defined(CCS_DUT_CYCLE) || defined(CCS_DUT_RTL)
#if defined(MTI_SYSTEMC) || defined(NCSC) || defined(VCS_SYSTEMC)
  if (!clk) {
    if (rst == SC_LOGIC_0 &&
      (OFS_UNET_IP_main_run_inst_UNET_IP_main_run_staller_inst_run_wen.read() == SC_LOGIC_0)
      && (OFS_input_rsc_vld.read() == SC_LOGIC_1)
      && (OFS_output_rsc_rdy.read() == SC_LOGIC_1)
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
  bool X = (OFS_UNET_IP_main_run_inst_UNET_IP_main_run_staller_inst_run_wen.read()==0);
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
