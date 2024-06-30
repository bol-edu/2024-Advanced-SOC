echo "Catapult setup"
setenv MGC_HOME /usr/cadtool/mentor/Catapult/2024.1/Mgc_home
setenv CXX_HOME $MGC_HOME
setenv SYSTEMC_INCDIR $MGC_HOME/shared/include
setenv SYSTEMC_LIBDIR $MGC_HOME/shared/lib
setenv LD_LIBRARY_PATH $SYSTEMC_LIBDIR
setenv LD_LIBRARY_PATH ${MGC_HOME}/lib:$LD_LIBRARY_PATH
echo "QuestaSim_setup"
setenv MODEL_TECH /usr/cadtool/mentor/Questa_Sim/2021.1_1/questasim/bin
setenv QUESTA_HOME /usr/cadtool/mentor/Questa_Sim/2021.1_1/questasim
echo "Source Catapult & QuestaSim"
#source /usr/cadtool/user_setup/05-catapult.csh
#source /usr/cadtool/user_setup/05-questasim.csh

source /usr/cadtool/user_setup/05-catapult.csh
source /usr/cadtool/user_setup/05-questasim.csh
