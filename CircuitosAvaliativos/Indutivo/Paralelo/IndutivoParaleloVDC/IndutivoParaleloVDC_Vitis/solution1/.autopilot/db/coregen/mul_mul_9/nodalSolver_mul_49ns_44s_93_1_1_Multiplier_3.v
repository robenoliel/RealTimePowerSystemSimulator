// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================

`timescale 1 ns / 1 ps

module nodalSolver_mul_49ns_44s_93_1_1_Multiplier_3(a, b, p);
input[49 - 1 : 0] a; 
input[44 - 1 : 0] b; 
output[93 - 1 : 0] p;

assign p = $signed({1'b0, a}) * $signed(b);
endmodule
