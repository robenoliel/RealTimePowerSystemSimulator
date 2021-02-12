// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================

`timescale 1 ns / 1 ps

module nodalSolver_mul_170s_53ns_170_2_1_Multiplier_0(clk, ce, a, b, p);
input clk;
input ce;
input signed [170 - 1 : 0] a;
input [53 - 1 : 0] b;
output[170 - 1 : 0] p;
reg signed [170 - 1 : 0] p;
wire signed [170 - 1 : 0] tmp_product;

assign tmp_product = $signed(a) * $signed({1'b0, b});
always @ (posedge clk) begin
    if (ce) begin
        p <= tmp_product;
    end
end
endmodule
