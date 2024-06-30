# This Catapult LB script has been generated to expand the characterization range(es)
# of components of the Catapult base library(ies) to fit the current design
# 
# Running this script is optional but using the updated library should result in improved correlation.
# 
# Run this script in Catapult LB with the base library loaded or uncomment the "library load" command(s)
#library load /usr/cadtool/mentor/Catapult/2023.1/Mgc_home/pkgs/siflibs/nangate/nangate-45nm_beh.lib
library set /LIBS/nangate-45nm_beh/MODS/mgc_mul_pipe/PARAMETERS/n_inreg -- -CHAR_RANGE {0 to 0, 2}
library set /LIBS/nangate-45nm_beh/MODS/mgc_mul/PARAMETERS/signd_a -- -CHAR_RANGE {0, 1 to 1}
library set /LIBS/nangate-45nm_beh/MODS/mgc_mul/PARAMETERS/signd_b -- -CHAR_RANGE {0, 1 to 1}
library set /LIBS/nangate-45nm_beh/MODS/mgc_mul_pipe/PARAMETERS/signd_a -- -CHAR_RANGE {0, 1 to 1}
library set /LIBS/nangate-45nm_beh/MODS/mgc_mul_pipe/PARAMETERS/signd_b -- -CHAR_RANGE {0, 1 to 1}
library set /LIBS/nangate-45nm_beh/MODS/mgc_shift_bl/PARAMETERS/width_z -- -CHAR_RANGE {4 to 4, 8 to 8, 16 to 16, 32 to 32, 33}
library set /LIBS/nangate-45nm_beh/MODS/mgc_add/PARAMETERS/width_b -- -CHAR_RANGE {1, 2 to 2, 4 to 24, 32 to 32, 64 to 64}
library set /LIBS/nangate-45nm_beh/MODS/mgc_reg_pos/PARAMETERS/has_enable -- -CHAR_RANGE {0 to 0, 1}
library set /LIBS/nangate-45nm_beh/MODS/mgc_reg_pos/PARAMETERS/enable_on -- -CHAR_RANGE {0 to 0, 1}
# The "library characterize" command below requires that: 
#   1. characterization directory set in the library exists and write accessible;
#   2. paths to technology libraries are set to correct locations;
#   3. the downstream tool used to characterize the library is available;
library characterize
