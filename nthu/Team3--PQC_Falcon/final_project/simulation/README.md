# Falcon FSIC-FPGA Simulation with SOC / FPGA Mailbox Interrupt 

- Here I implement IRQ on FSIC Mailbox
  ![waveform](https://github.com/vic9112/PQC_Falcon/assets/137171415/c0aa035a-f3db-47fb-a9df-a87798b35ed1)

## Simulation Step:
1. PL_AA enable:
   - FPGA side needs to enable **`aa_mb_irq_en`** located at **`0x3000_2100`** to enable interrupt.
   - At [fsic_tb.sv](https://github.com/vic9112/PQC_Falcon/blob/main/impl_ASIC/irq_test/vivado/fsic_tb.sv)
   - ![enable](https://github.com/vic9112/PQC_Falcon/assets/137171415/be40dc4f-2cb4-45bc-aaad-0607b2cfd340)
2. SOC writes local MailBox
   - SOC side (firmware) writes specific patterns to the local MailBox, then it will sync to other side (FPGA) and generate interrupt (**`aa_mb_irq`**)
   - [fsic.c](https://github.com/vic9112/PQC_Falcon/blob/main/impl_ASIC/irq_test/testbench/fsic/fsic.c)
   - ![firmware write MB](https://github.com/vic9112/PQC_Falcon/assets/137171415/2887d0f6-202a-45aa-ad73-8ecb9f36b1f5)
3. Read Mailbox
   - Interrupt will pull down after a reading cycle to Mailbox (0x30002000)
### Directly simulating fiFFNTT, do the following:
```
$ cd vivado
$ source run_vivado_fsic_sim
```

## Block Design
```
$ cd vivado
$ source run_vivado_fsic
```
- After running `run_vivado_fsic` under `/vivado`, it will create a vivado project file `vvd_caravel_fpga`.
- Open `/vivado/vvd_caravel_fpga/vvd_caravel_fpga.xpr` using vivado GUI and open block design, then add `UserDMA` under `/vivado/vitis_prj`(connect `updma_so` to `inStreamTop`, `outStreamTop` to `updma_si`)
  ![downstream](https://github.com/vic9112/Advance_SOC/assets/137171415/0f4f2043-153b-487a-abae-87d6846bd0bd)
  ![upstream](https://github.com/vic9112/Advance_SOC/assets/137171415/b2aa20de-931d-46f5-bb7c-f37e3e1d678d)
- Add **AXI Interrupt Controller**, connect pin **`aa_mb_irq`** on **ps_axil** to the input of AXI Interrupt Controller, then concatenate to pin **`IRQ_F2P`** on **ZYNQ(PS)**<br>
![block](https://github.com/vic9112/PQC_Falcon/assets/137171415/d9fa1946-94a5-4f01-ad87-729e874b2dab)
- ZYNQ Configuration<br>
![zynq](https://github.com/vic9112/PQC_Falcon/assets/137171415/ef55a847-ba3d-432a-aa46-f377afcd041c)

## On Board Validation
**Note that included files are not for fiFFNTT, but for FIR since it's just a demonstration about the interrupt service routine**
- Include bitstream `fsicIRQ_v1.bit` and metadata file `fsicIRQ_v1.hwh` under `./level_trigger`.
- Include firmware `fsic.hex` under `./firmware_test`, which only write a value `0x3a3a3a3a` into mailbox
- Include host code `fsicIRQ_test.ipynb`

Refer to [Interrupt - PYNQ](https://pynq.readthedocs.io/en/latest/pynq_libraries/interrupt.html)
