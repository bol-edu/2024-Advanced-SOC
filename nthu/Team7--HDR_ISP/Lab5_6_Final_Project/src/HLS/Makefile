NAME = SCVerify_HDRISP
BINDIR = ./bin

ifndef MGC_HOME
$(error - Environment variable MGC_HOME must be defined)
endif

CATAPULT_HOME = $(MGC_HOME)

CXXFLAGS += -g -o3 -std=c++11 -Wall -Wno-unknown-pragmas -Wno-unused-variable -Wno-unused-label

CXX := $(CATAPULT_HOME)/bin/g++

#LD_LIBRARY_PATH := $(if $(LD_LIBRARY_PATH),$(LD_LIBRARY_PATH):$(CATAPULT_HOME)/lib:$(CATAPULT_HOME)/shared/lib,$(CATAPULT_HOME)/lib:$(CATAPULT_HOME)/shared/lib)

#SOURCE_FILE := ./bmpUtil/src/bmp_io.cpp
#SOURCE_FILE += ./hls_c/src/EdgeDetect_tb.cpp
SOURCE_FILE := ./cmodel/inc/main.cpp
SOURCE_FILE += ./cmodel/inc/parse.cpp
SOURCE_FILE += ./cmodel/inc/thirdparty/easylog/easylogging++.cc
SOURCE_FILE += ./cmodel/inc/thirdparty/easybmp/EasyBMP.cpp
SOURCE_FILE += ./cmodel/inc/srcs/sources/common/common.cpp
SOURCE_FILE += ./cmodel/inc/srcs/sources/common/frame.cpp
SOURCE_FILE += ./cmodel/inc/srcs/sources/common/modules.cpp
SOURCE_FILE += ./cmodel/inc/srcs/sources/common/pipeline.cpp
SOURCE_FILE += ./cmodel/inc/srcs/sources/modules/blc.cpp
SOURCE_FILE += ./cmodel/inc/srcs/sources/modules/ccm.cpp
SOURCE_FILE += ./cmodel/inc/srcs/sources/modules/clipout.cpp
SOURCE_FILE += ./cmodel/inc/srcs/sources/modules/cns.cpp
SOURCE_FILE += ./cmodel/inc/srcs/sources/modules/contrast.cpp
SOURCE_FILE += ./cmodel/inc/srcs/sources/modules/demoasic.cpp
SOURCE_FILE += ./cmodel/inc/srcs/sources/modules/depwl.cpp
SOURCE_FILE += ./cmodel/inc/srcs/sources/modules/dpc.cpp
SOURCE_FILE += ./cmodel/inc/srcs/sources/modules/lsc.cpp
SOURCE_FILE += ./cmodel/inc/srcs/sources/modules/ltm.cpp
SOURCE_FILE += ./cmodel/inc/srcs/sources/modules/rgb2yuv.cpp
SOURCE_FILE += ./cmodel/inc/srcs/sources/modules/rgbgamma.cpp
SOURCE_FILE += ./cmodel/inc/srcs/sources/modules/rns.cpp
SOURCE_FILE += ./cmodel/inc/srcs/sources/modules/saturation.cpp
SOURCE_FILE += ./cmodel/inc/srcs/sources/modules/sharpen.cpp
SOURCE_FILE += ./cmodel/inc/srcs/sources/modules/unpack.cpp
SOURCE_FILE += ./cmodel/inc/srcs/sources/modules/wbgain.cpp
SOURCE_FILE += ./cmodel/inc/srcs/sources/modules/ygamma.cpp
SOURCE_FILE += ./cmodel/inc/srcs/sources/modules/yuv2rgb.cpp

#INCLUDE_DIR := -I./bmpUtil/inc/
#INCLUDE_DIR += -I./cmodel/inc/
#INCLUDE_DIR += -I./hls_c/inc/
#INCLUDE_DIR := -I./cmodel/inc/srcs/include/common/
INCLUDE_DIR := -I./cmodel/inc/srcs/include/
INCLUDE_DIR += -I./cmodel/inc/thirdparty/easylog/
INCLUDE_DIR += -I./cmodel/inc/thirdparty/easybmp/
INCLUDE_DIR += -I./cmodel/inc/thirdparty/json/nlohmann/

INCDIRS :=   $(INCLUDE_DIR)
INCDIRS += -I$(CATAPULT_HOME)/shared/include

CPPFLAGS += $(INCDIRS)

BIN = $(BINDIR)/$(NAME).exe

$(BIN): 
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) $(SOURCE_FILE) -o $@ 

.PHONY: clean $(BIN)
clean:
	@rm -f $(BIN)

