# asoc_final
1. first git clone "https://github.com/bol-edu/fsic_fpga.git" (lab fsic_fpga) 
2. move the files in this repository into lab fsic_fpga following the below instructions:  
./tb/  
filelist       --> move to ./fsic_fpga/rtl/user/testbench/tc/  
input_data.dat --> move to ./fsic_fpga/rtl/user/testbench/  
run_xsim       --> move to ./fsic_fpga/rtl/user/testbench/tc/  
tb_fsic.v      --> move to ./fsic_fpga/rtl/user/testbench/  
./user/proj/  
attention.v    --> move to ./fsic_fpga/rtl/user/user_subsys/user_prj/user_prj0/rtl/  
rtl.v          --> move to ./fsic_fpga/rtl/user/user_subsys/user_prj/user_prj0/rtl/  
user_proj0.v   --> move to ./fsic_fpga/rtl/user/user_subsys/user_prj/user_prj0/rtl/  
3. source ./fsic_fpga/rtl/user/testbench/tc/run_xsim so you can replicate the result  
