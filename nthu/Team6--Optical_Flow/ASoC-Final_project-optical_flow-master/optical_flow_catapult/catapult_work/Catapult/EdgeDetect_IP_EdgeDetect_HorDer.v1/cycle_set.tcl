
# Loop constraints
directive set /EdgeDetect_IP::EdgeDetect_HorDer/run/run:rlp CSTEPS_FROM {{. == 0}}
directive set /EdgeDetect_IP::EdgeDetect_HorDer/run/run:rlp/main CSTEPS_FROM {{. == 2} {.. == 0}}
directive set /EdgeDetect_IP::EdgeDetect_HorDer/run/run:rlp/main/HROW CSTEPS_FROM {{. == 1} {.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_HorDer/run/run:rlp/main/HROW/HCOL CSTEPS_FROM {{. == 3} {.. == 0}}

# IO operation constraints
directive set /EdgeDetect_IP::EdgeDetect_HorDer/run/run:rlp/main/HROW/HCOL/operator-<11,false>:asn CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_HorDer/run/run:rlp/main/HROW/HCOL/HCOL:if:io_read(dat_in) CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_HorDer/run/run:rlp/main/HROW/HCOL/HCOL:if#2:asn#1 CSTEPS_FROM {{.. == 2}}
directive set /EdgeDetect_IP::EdgeDetect_HorDer/run/run:rlp/main/HROW/HCOL/HCOL:if#3:io_write(dx) CSTEPS_FROM {{.. == 2}}
directive set /EdgeDetect_IP::EdgeDetect_HorDer/run/run:rlp/main/HROW/operator-<10,false>:asn CSTEPS_FROM {{.. == 1}}

# Sync operation constraints

# Real operation constraints
directive set /EdgeDetect_IP::EdgeDetect_HorDer/run/run:rlp/main/HROW/HCOL/operator-<11,false>:acc CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_HorDer/run/run:rlp/main/HROW/HCOL/HCOL:equal CSTEPS_FROM {{.. == 2}}
directive set /EdgeDetect_IP::EdgeDetect_HorDer/run/run:rlp/main/HROW/HCOL/HCOL:mux#2 CSTEPS_FROM {{.. == 2}}
directive set /EdgeDetect_IP::EdgeDetect_HorDer/run/run:rlp/main/HROW/HCOL/HCOL:mux#1 CSTEPS_FROM {{.. == 2}}
directive set /EdgeDetect_IP::EdgeDetect_HorDer/run/run:rlp/main/HROW/HCOL/operator*<8,false>#2:acc CSTEPS_FROM {{.. == 2}}
directive set /EdgeDetect_IP::EdgeDetect_HorDer/run/run:rlp/main/HROW/HCOL/HCOL:acc#3 CSTEPS_FROM {{.. == 2}}
directive set /EdgeDetect_IP::EdgeDetect_HorDer/run/run:rlp/main/HROW/HCOL/HCOL:if#4:mux CSTEPS_FROM {{.. == 2}}
directive set /EdgeDetect_IP::EdgeDetect_HorDer/run/run:rlp/main/HROW/operator-<10,false>:acc CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_HorDer/run/run:rlp/main/HROW/HROW:equal CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_HorDer/run/run:rlp/main/HROW/HROW:acc CSTEPS_FROM {{.. == 1}}

# Probe constraints
