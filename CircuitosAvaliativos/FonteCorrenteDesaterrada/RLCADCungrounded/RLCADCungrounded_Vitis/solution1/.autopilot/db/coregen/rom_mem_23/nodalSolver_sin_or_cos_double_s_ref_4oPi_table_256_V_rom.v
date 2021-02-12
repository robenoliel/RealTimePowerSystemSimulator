// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
`timescale 1 ns / 1 ps
module nodalSolver_sin_or_cos_double_s_ref_4oPi_table_256_V_rom (
addr0, ce0, q0, clk);

parameter DWIDTH = 256;
parameter AWIDTH = 4;
parameter MEM_SIZE = 10;

input[AWIDTH-1:0] addr0;
input ce0;
output reg[DWIDTH-1:0] q0;
input clk;

reg [DWIDTH-1:0] ram[0:MEM_SIZE-1];

initial begin
    $readmemh("./nodalSolver_sin_or_cos_double_s_ref_4oPi_table_256_V_rom.dat", ram);
end



always @(posedge clk)  
begin 
    if (ce0) 
    begin
        q0 <= ram[addr0];
    end
end



endmodule

