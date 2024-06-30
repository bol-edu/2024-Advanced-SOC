# FPGA Implementation of High-Level Synthesis in Post-Quantum Cryptography: Hardware Acceleration for Falcon Digital Signature

| Author | [陳冠晰/Vic Chen](https://github.com/vic9112)|
| ------ | ------------------------------------- |

## Introduction
- Due to the advent of quantum computers, existing encryption systems face significant threats. To counteract quantum computers, post-quantum cryptography has emerged. Falcon is one of the algorithms in post-quantum cryptography. The main reasons for choosing the Falcon digital signature are its speed and scalability. In terms of speed, Falcon, using Fast Fourier Sampling, can perform thousands of signatures per second. Additionally, regarding scalability, Falcon's security parameters can be adjusted according to user needs, with official versions including 256, 512, and 1024.
- Our research objective is to enhance Falcon's computational efficiency through hardware acceleration and simplify the development process using High-Level Synthesis (HLS). Furthermore, we implemented the entire Falcon process using a hardware-software co-design approach and integrated the designed hardware accelerators and FSIC into the SOC RTL source. With the [complete SOC RTL source](https://github.com/vic9112/Advance_SOC/tree/main/final_project/simulation/vivado/vvd_srcs/caravel_soc), we can observe the waveform of system-level simulations, and [FSIC](https://github.com/vic9112/Advance_SOC/tree/main/final_project/simulation/vivado/vvd_srcs/caravel_soc/rtl/user) aids us in post-silicon validation.

## System View
![system view](https://github.com/vic9112/Advance_SOC/assets/137171415/45253d01-815f-454a-9963-184ee0b0d9c4)
- We placed the kernels in the User project on the Caravel SoC side and implemented the middleware as firmware to run on the SoC side's RISC-V CPU. The Falcon API is placed on the PS side. When the product is launched, it will be released in the form of a USB dongle. This dongle can be plugged into a PC to generate public and private keys and signatures. It will communicate with the FIDO2 (Fast Identity Online) interface and the FIDO2 Server, where verification will take place on the server side.

## Block Diagram
![block diagram](https://github.com/vic9112/Advance_SOC/assets/137171415/b3c1903c-c585-4bd2-b556-8c25c8e20afd)
- The yellow dashed box highlights the entire system validation box. On the SoC side, we integrated the accelerators and FSIC into the SoC's user project. The middleware was also written as firmware and loaded into the RISC-V CPU. Since everything is on the PL side, we avoided the previous **PS-PL communication overhead** (described in `/falcon_test`).
- On the FPGA side, we also placed multiple IPs and designed a DMA to handle the data transmission required for kernel computation. The DMA transfers data through AXI-Master via the interconnect to read data from the DDR memory on the PS side, and then sends the data to the kernel on the SoC side via AXI-Stream.

## Folder Explanation

- `hls_src`: Catapult/Vitis HLS source code
- `simulation`: FSIC-FPGA simulation files
- `validation`: On-Board(PYNQ) validation files
- `falcon_test`: Improved software code (3 APIs) and on-board(KV260) validation files <be>
![3 APIs](https://github.com/vic9112/Advance_SOC/assets/137171415/ef1f0c2a-d496-4bca-b7bd-395071dd8c3f)

## Reference
- [Falcon](https://falcon-sign.info/)
