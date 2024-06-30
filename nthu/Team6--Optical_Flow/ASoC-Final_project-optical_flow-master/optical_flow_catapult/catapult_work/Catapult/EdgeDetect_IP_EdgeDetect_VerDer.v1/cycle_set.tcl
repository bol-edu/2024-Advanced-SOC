
# Loop constraints
directive set /EdgeDetect_IP::EdgeDetect_VerDer/run/run:rlp CSTEPS_FROM {{. == 0}}
directive set /EdgeDetect_IP::EdgeDetect_VerDer/run/run:rlp/main CSTEPS_FROM {{. == 2} {.. == 0}}
directive set /EdgeDetect_IP::EdgeDetect_VerDer/run/run:rlp/main/VROW CSTEPS_FROM {{. == 1} {.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_VerDer/run/run:rlp/main/VROW/VCOL CSTEPS_FROM {{. == 4} {.. == 0}}

# IO operation constraints
directive set /EdgeDetect_IP::EdgeDetect_VerDer/run/run:rlp/main/VROW/VCOL/operator-<10,false>:asn CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_VerDer/run/run:rlp/main/VROW/VCOL/VCOL:if:io_read(dat_in) CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_VerDer/run/run:rlp/main/VROW/VCOL/VCOL:if#4:asn#1 CSTEPS_FROM {{.. == 3}}
directive set /EdgeDetect_IP::EdgeDetect_VerDer/run/run:rlp/main/VROW/VCOL/VCOL:if#5:io_write(dat_out) CSTEPS_FROM {{.. == 3}}
directive set /EdgeDetect_IP::EdgeDetect_VerDer/run/run:rlp/main/VROW/VCOL/VCOL:if#5:io_write(dy) CSTEPS_FROM {{.. == 3}}
directive set /EdgeDetect_IP::EdgeDetect_VerDer/run/run:rlp/main/VROW/VCOL/operator-<11,false>:asn CSTEPS_FROM {{.. == 2}}
directive set /EdgeDetect_IP::EdgeDetect_VerDer/run/run:rlp/main/VROW/VROW:if:asn#1 CSTEPS_FROM {{.. == 1}}

# Sync operation constraints

# Real operation constraints
directive set /EdgeDetect_IP::EdgeDetect_VerDer/run/run:rlp/main/VROW/VCOL/operator-<10,false>:acc CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_VerDer/run/run:rlp/main/VROW/VCOL/VCOL:mux CSTEPS_FROM {{.. == 2}}
directive set /EdgeDetect_IP::EdgeDetect_VerDer/run/run:rlp/main/VROW/VCOL/VCOL:if#2:read_mem(line_buf1:rsc.@) CSTEPS_FROM {{.. == 2}}
directive set /EdgeDetect_IP::EdgeDetect_VerDer/run/run:rlp/main/VROW/VCOL/VCOL:if#2:read_mem(line_buf0:rsc.@) CSTEPS_FROM {{.. == 2}}
directive set /EdgeDetect_IP::EdgeDetect_VerDer/run/run:rlp/main/VROW/VCOL/VCOL:else#2:write_mem(line_buf1:rsc.@) CSTEPS_FROM {{.. == 2}}
directive set /EdgeDetect_IP::EdgeDetect_VerDer/run/run:rlp/main/VROW/VCOL/VCOL:else#2:write_mem(line_buf0:rsc.@) CSTEPS_FROM {{.. == 2}}
directive set /EdgeDetect_IP::EdgeDetect_VerDer/run/run:rlp/main/VROW/VCOL/VCOL:mux#1 CSTEPS_FROM {{.. == 3}}
directive set /EdgeDetect_IP::EdgeDetect_VerDer/run/run:rlp/main/VROW/VCOL/VCOL:mux#2 CSTEPS_FROM {{.. == 3}}
directive set /EdgeDetect_IP::EdgeDetect_VerDer/run/run:rlp/main/VROW/VCOL/VCOL:mux#4 CSTEPS_FROM {{.. == 2}}
directive set /EdgeDetect_IP::EdgeDetect_VerDer/run/run:rlp/main/VROW/VCOL/VCOL:mux#5 CSTEPS_FROM {{.. == 3}}
directive set /EdgeDetect_IP::EdgeDetect_VerDer/run/run:rlp/main/VROW/VCOL/VCOL:equal CSTEPS_FROM {{.. == 3}}
directive set /EdgeDetect_IP::EdgeDetect_VerDer/run/run:rlp/main/VROW/VCOL/VCOL:mux#7 CSTEPS_FROM {{.. == 3}}
directive set /EdgeDetect_IP::EdgeDetect_VerDer/run/run:rlp/main/VROW/VCOL/VCOL:VCOL:mux1h CSTEPS_FROM {{.. == 3}}
directive set /EdgeDetect_IP::EdgeDetect_VerDer/run/run:rlp/main/VROW/VCOL/operator*<8,false>#2:acc CSTEPS_FROM {{.. == 3}}
directive set /EdgeDetect_IP::EdgeDetect_VerDer/run/run:rlp/main/VROW/VCOL/operator-<11,false>:acc CSTEPS_FROM {{.. == 2}}
directive set /EdgeDetect_IP::EdgeDetect_VerDer/run/run:rlp/main/VROW/VCOL/VCOL:equal#1 CSTEPS_FROM {{.. == 2}}
directive set /EdgeDetect_IP::EdgeDetect_VerDer/run/run:rlp/main/VROW/VCOL/VCOL:acc#3 CSTEPS_FROM {{.. == 2}}
directive set /EdgeDetect_IP::EdgeDetect_VerDer/run/run:rlp/main/VROW/VCOL/VCOL:if#6:mux CSTEPS_FROM {{.. == 2}}
directive set /EdgeDetect_IP::EdgeDetect_VerDer/run/run:rlp/main/VROW/VROW:equal CSTEPS_FROM {{.. == 1}}
directive set /EdgeDetect_IP::EdgeDetect_VerDer/run/run:rlp/main/VROW/VROW:acc CSTEPS_FROM {{.. == 1}}

# Probe constraints
