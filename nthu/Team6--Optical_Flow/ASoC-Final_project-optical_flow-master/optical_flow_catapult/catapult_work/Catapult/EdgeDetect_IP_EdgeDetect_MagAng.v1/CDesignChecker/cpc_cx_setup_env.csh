#! /bin/csh -f
setenv SYSTEMC_HOME /usr/cadtool/mentor/Catapult/2023.1/Mgc_home/shared
setenv SYSTEMC_LIB_DIR /usr/cadtool/mentor/Catapult/2023.1/Mgc_home/shared/lib
setenv CXX_FLAGS "-g -DCALYPTO_SKIP_SYSTEMC_VERSION_CHECK"
setenv LD_FLAGS "-lpthread"
setenv OSSIM ddd
setenv PATH /usr/cadtool/mentor/Catapult/2023.1/Mgc_home/bin:$PATH
