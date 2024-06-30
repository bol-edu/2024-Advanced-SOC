// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2023.2 (64-bit)
// Tool Version Limit: 2023.10
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#ifdef SDT
#include "xparameters.h"
#endif
#include "xuserdma.h"

extern XUserdma_Config XUserdma_ConfigTable[];

#ifdef SDT
XUserdma_Config *XUserdma_LookupConfig(UINTPTR BaseAddress) {
	XUserdma_Config *ConfigPtr = NULL;

	int Index;

	for (Index = (u32)0x0; XUserdma_ConfigTable[Index].Name != NULL; Index++) {
		if (!BaseAddress || XUserdma_ConfigTable[Index].Control_BaseAddress == BaseAddress) {
			ConfigPtr = &XUserdma_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XUserdma_Initialize(XUserdma *InstancePtr, UINTPTR BaseAddress) {
	XUserdma_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XUserdma_LookupConfig(BaseAddress);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XUserdma_CfgInitialize(InstancePtr, ConfigPtr);
}
#else
XUserdma_Config *XUserdma_LookupConfig(u16 DeviceId) {
	XUserdma_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XUSERDMA_NUM_INSTANCES; Index++) {
		if (XUserdma_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XUserdma_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XUserdma_Initialize(XUserdma *InstancePtr, u16 DeviceId) {
	XUserdma_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XUserdma_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XUserdma_CfgInitialize(InstancePtr, ConfigPtr);
}
#endif

#endif

