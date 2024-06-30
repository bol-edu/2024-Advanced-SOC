bmpUtil: source code of bmp reader and writer
cmodel: reference model
hls_c: hls c++ code
bin: gcc verification
.vscode: VSCode environment
catapult_work: Catapult environment

Flows:
1. build c++ code; Use Makefile or VSCode
(1) make
or
(2) code . &

2. run gcc verification
cd bin; ./run.sh

3. run Catapult HLS synthesis
cd catapult_work; catapult -p ultra -f directives.tcl

