# On-Board Validation

![block diagram](https://github.com/vic9112/Advance_SOC/assets/137171415/7f406d79-5491-4b37-ac04-8d6374f2131d)

## Validation Step
- Including all files in this folder on remote PYNQ jupyter notebook, then you can see the result: <br>
  ![result](https://github.com/vic9112/Advance_SOC/assets/137171415/1f198b9d-068c-4625-962d-0ca68a95383e)
- The speed is much slower than Vitis HLS implementation since we didn't optimize the Catapult HLS due to some memory partition issues.

## Issue / Conclusion
- We didn’t test the complete Falcon flow since we don’t have the library like [PyCrypto](https://pypi.org/project/pycrypto/), [PyCryptoDome](https://pypi.org/project/pycryptodome/), [PyCryptoDomeX](https://pypi.org/project/pycryptodomex/) in pynq jupyter notebook. If we have permission to install all libraries required for Falcon Python code on our jupyter notebook, we can test the complete falcon flow including key generation, signature, and verification.
- The other problem we found is that interrupt and data movement have a different path, which means when interrupt is asserted, we cannot ensure that data has been moved to DDR memory. During simulation, we found that interrupt is asserted before DMA loads all calculated data to DDR memory. However, during on-board verification, interrupt is asserted after DMA loads all calculated data to DDR memory. We assume that it is because we use multi-threads in jupyter notebook and when interrupt is asserted, CPU needs to stop other programs which may need some time to deal with interrupt service routine.

