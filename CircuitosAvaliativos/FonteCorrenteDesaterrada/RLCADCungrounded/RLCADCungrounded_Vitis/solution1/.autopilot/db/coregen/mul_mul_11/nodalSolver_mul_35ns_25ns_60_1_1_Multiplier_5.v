// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================

`timescale 1 ns / 1 ps

module nodalSolver_mul_35ns_25ns_60_1_1_Multiplier_5(a, b, p);
input[35 - 1 : 0] a; 
input[25 - 1 : 0] b; 
output[60 - 1 : 0] p;

assign p = $signed({1'b0, a}) * $signed({1'b0, b});
endmodule
