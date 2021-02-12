// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
`timescale 1 ns / 1 ps
module nodalSolver_sin_or_cos_double_s_ref_4oPi_table_256_V(
    reset,
    clk,
    address0,
    ce0,
    q0);

parameter DataWidth = 32'd256;
parameter AddressRange = 32'd10;
parameter AddressWidth = 32'd4;
input reset;
input clk;
input[AddressWidth - 1:0] address0;
input ce0;
output[DataWidth - 1:0] q0;



nodalSolver_sin_or_cos_double_s_ref_4oPi_table_256_V_rom nodalSolver_sin_or_cos_double_s_ref_4oPi_table_256_V_rom_U(
    .clk( clk ),
    .addr0( address0 ),
    .ce0( ce0 ),
    .q0( q0 ));

endmodule
