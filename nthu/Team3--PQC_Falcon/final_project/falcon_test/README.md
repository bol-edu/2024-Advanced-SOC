# Falcon On-Board Test

## Block diagram

![block diagram](https://github.com/vic9112/Advance_SOC/assets/137171415/98282e05-a2c4-4375-a725-644d0bcd4690)

- During the chip verification phase, we integrated multiple kernels into the PL side of the MPSoC to handle concurrent requests, and middleware to manage requests from Falcon. To minimize the high communication overhead between hardware and software (as illustrated by the green double arrow), the middleware will be implemented as firmware on the RISC-V CPU within the Caravel SoC.

## Performance

| Flow | KeyGen(ms) | Sign(ms) | Verify(ms) |
| ---- | ---------- | -------- | ---------- |
| Original software | 100.4 | 2053.3 | 139.9 |
| HW/SW with middleware | 18.9 | 747.5 | 60.7 |


- On-Board (KV260) <br>
![result_1PE](https://github.com/vic9112/Advance_SOC/assets/137171415/0dba7572-2d9c-4a85-8002-7d4700a284ec)


