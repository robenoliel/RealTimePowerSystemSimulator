// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================

`timescale 1 ns / 1 ps

module nodalSolver_mul_42ns_33ns_75_1_1_Multiplier_4(a, b, p);
input[42 - 1 : 0] a; 
input[33 - 1 : 0] b; 
output[75 - 1 : 0] p;

assign p = $signed({1'b0, a}) * $signed({1'b0, b});
endmodule
