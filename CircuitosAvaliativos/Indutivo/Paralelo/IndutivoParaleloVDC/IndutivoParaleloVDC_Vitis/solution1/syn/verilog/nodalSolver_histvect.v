// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Version: 2020.2
// Copyright (C) Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module nodalSolver_histvect (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        G_vec_V_2,
        G_vec_V_1,
        G_vec_I_2_i,
        G_vec_I_2_o,
        G_vec_I_2_o_ap_vld,
        G_vec_I_1_i,
        G_vec_I_1_o,
        G_vec_I_1_o_ap_vld,
        grp_fu_720_p_din0,
        grp_fu_720_p_din1,
        grp_fu_720_p_opcode,
        grp_fu_720_p_dout0,
        grp_fu_720_p_ce,
        grp_fu_724_p_din0,
        grp_fu_724_p_din1,
        grp_fu_724_p_opcode,
        grp_fu_724_p_dout0,
        grp_fu_724_p_ce,
        grp_fu_744_p_din0,
        grp_fu_744_p_din1,
        grp_fu_744_p_dout0,
        grp_fu_744_p_ce
);

parameter    ap_ST_fsm_pp0_stage0 = 3'd1;
parameter    ap_ST_fsm_pp0_stage1 = 3'd2;
parameter    ap_ST_fsm_pp0_stage2 = 3'd4;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
input  [31:0] G_vec_V_2;
input  [31:0] G_vec_V_1;
input  [31:0] G_vec_I_2_i;
output  [31:0] G_vec_I_2_o;
output   G_vec_I_2_o_ap_vld;
input  [31:0] G_vec_I_1_i;
output  [31:0] G_vec_I_1_o;
output   G_vec_I_1_o_ap_vld;
output  [31:0] grp_fu_720_p_din0;
output  [31:0] grp_fu_720_p_din1;
output  [1:0] grp_fu_720_p_opcode;
input  [31:0] grp_fu_720_p_dout0;
output   grp_fu_720_p_ce;
output  [31:0] grp_fu_724_p_din0;
output  [31:0] grp_fu_724_p_din1;
output  [1:0] grp_fu_724_p_opcode;
input  [31:0] grp_fu_724_p_dout0;
output   grp_fu_724_p_ce;
output  [31:0] grp_fu_744_p_din0;
output  [31:0] grp_fu_744_p_din1;
input  [31:0] grp_fu_744_p_dout0;
output   grp_fu_744_p_ce;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg[31:0] G_vec_I_2_o;
reg G_vec_I_2_o_ap_vld;
reg[31:0] G_vec_I_1_o;
reg G_vec_I_1_o_ap_vld;

(* fsm_encoding = "none" *) reg   [2:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
reg    ap_enable_reg_pp0_iter0;
wire    ap_block_pp0_stage0;
reg    ap_enable_reg_pp0_iter1;
reg    ap_enable_reg_pp0_iter2;
reg    ap_enable_reg_pp0_iter3;
reg    ap_enable_reg_pp0_iter4;
reg    ap_idle_pp0;
wire    ap_CS_fsm_pp0_stage2;
wire    ap_block_state3_pp0_stage2_iter0;
wire    ap_block_state6_pp0_stage2_iter1;
wire    ap_block_state9_pp0_stage2_iter2;
wire    ap_block_state12_pp0_stage2_iter3;
wire    ap_block_state15_pp0_stage2_iter4;
wire    ap_block_pp0_stage2_11001;
reg   [31:0] elements_Ih_0;
wire    ap_block_state1_pp0_stage0_iter0;
wire    ap_block_state4_pp0_stage0_iter1;
wire    ap_block_state7_pp0_stage0_iter2;
wire    ap_block_state10_pp0_stage0_iter3;
wire    ap_block_state13_pp0_stage0_iter4;
wire    ap_block_pp0_stage0_11001;
wire   [31:0] grp_fu_20_p2;
reg   [31:0] sub_reg_86;
wire   [31:0] grp_fu_28_p2;
reg   [31:0] mul_reg_91;
wire    ap_CS_fsm_pp0_stage1;
wire    ap_block_state2_pp0_stage1_iter0;
wire    ap_block_state5_pp0_stage1_iter1;
wire    ap_block_state8_pp0_stage1_iter2;
wire    ap_block_state11_pp0_stage1_iter3;
wire    ap_block_state14_pp0_stage1_iter4;
wire    ap_block_pp0_stage1_11001;
reg   [31:0] add_reg_101;
reg    ap_enable_reg_pp0_iter0_reg;
wire    ap_block_pp0_stage2_subdone;
reg   [31:0] ap_sig_allocacmp_elements_Ih_0_load;
wire    ap_block_pp0_stage1;
wire    ap_block_pp0_stage2;
reg   [31:0] ap_sig_allocacmp_G_vec_I_2_load;
wire   [31:0] grp_fu_24_p2;
reg   [31:0] ap_sig_allocacmp_G_vec_I_1_load;
reg   [31:0] grp_fu_20_p0;
reg   [31:0] grp_fu_20_p1;
wire   [31:0] grp_fu_24_p0;
wire   [31:0] grp_fu_24_p1;
wire   [31:0] grp_fu_28_p0;
wire   [31:0] grp_fu_28_p1;
reg   [1:0] grp_fu_20_opcode;
wire    ap_block_pp0_stage1_00001;
wire    ap_block_pp0_stage0_00001;
wire    ap_block_pp0_stage2_00001;
wire    grp_fu_20_ce;
wire    grp_fu_24_ce;
wire    grp_fu_28_ce;
reg   [2:0] ap_NS_fsm;
wire    ap_block_pp0_stage0_subdone;
reg    ap_idle_pp0_1to4;
wire    ap_block_pp0_stage1_subdone;
reg    ap_idle_pp0_0to3;
reg    ap_reset_idle_pp0;
wire    ap_enable_pp0;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_CS_fsm = 3'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 ap_enable_reg_pp0_iter2 = 1'b0;
#0 ap_enable_reg_pp0_iter3 = 1'b0;
#0 ap_enable_reg_pp0_iter4 = 1'b0;
#0 elements_Ih_0 = 32'd0;
#0 ap_enable_reg_pp0_iter0_reg = 1'b0;
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_pp0_stage0;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter0_reg <= 1'b0;
    end else begin
        if ((1'b1 == ap_CS_fsm_pp0_stage0)) begin
            ap_enable_reg_pp0_iter0_reg <= ap_start;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage2_subdone) & (1'b1 == ap_CS_fsm_pp0_stage2))) begin
            ap_enable_reg_pp0_iter1 <= ap_enable_reg_pp0_iter0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter2 <= 1'b0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage2_subdone) & (1'b1 == ap_CS_fsm_pp0_stage2))) begin
            ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter3 <= 1'b0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage2_subdone) & (1'b1 == ap_CS_fsm_pp0_stage2))) begin
            ap_enable_reg_pp0_iter3 <= ap_enable_reg_pp0_iter2;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter4 <= 1'b0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage2_subdone) & (1'b1 == ap_CS_fsm_pp0_stage2))) begin
            ap_enable_reg_pp0_iter4 <= ap_enable_reg_pp0_iter3;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((ap_enable_reg_pp0_iter3 == 1'b1) & (1'b0 == ap_block_pp0_stage1_11001) & (1'b1 == ap_CS_fsm_pp0_stage1))) begin
        add_reg_101 <= grp_fu_720_p_dout0;
        elements_Ih_0 <= grp_fu_720_p_dout0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        mul_reg_91 <= grp_fu_744_p_dout0;
    end
end

always @ (posedge ap_clk) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        sub_reg_86 <= grp_fu_720_p_dout0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter4 == 1'b1) & (1'b0 == ap_block_pp0_stage2) & (1'b1 == ap_CS_fsm_pp0_stage2))) begin
        G_vec_I_1_o = grp_fu_724_p_dout0;
    end else begin
        G_vec_I_1_o = G_vec_I_1_i;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter4 == 1'b1) & (1'b0 == ap_block_pp0_stage2_11001) & (1'b1 == ap_CS_fsm_pp0_stage2))) begin
        G_vec_I_1_o_ap_vld = 1'b1;
    end else begin
        G_vec_I_1_o_ap_vld = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter4 == 1'b1) & (1'b0 == ap_block_pp0_stage2) & (1'b1 == ap_CS_fsm_pp0_stage2))) begin
        G_vec_I_2_o = grp_fu_720_p_dout0;
    end else begin
        G_vec_I_2_o = G_vec_I_2_i;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter4 == 1'b1) & (1'b0 == ap_block_pp0_stage2_11001) & (1'b1 == ap_CS_fsm_pp0_stage2))) begin
        G_vec_I_2_o_ap_vld = 1'b1;
    end else begin
        G_vec_I_2_o_ap_vld = 1'b0;
    end
end

always @ (*) begin
    if ((((ap_enable_reg_pp0_iter4 == 1'b1) & (1'b0 == ap_block_pp0_stage2_11001) & (1'b1 == ap_CS_fsm_pp0_stage2)) | ((ap_start == 1'b0) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_pp0_stage0)) begin
        ap_enable_reg_pp0_iter0 = ap_start;
    end else begin
        ap_enable_reg_pp0_iter0 = ap_enable_reg_pp0_iter0_reg;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (ap_idle_pp0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter4 == 1'b0) & (ap_enable_reg_pp0_iter3 == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter3 == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0_0to3 = 1'b1;
    end else begin
        ap_idle_pp0_0to3 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter4 == 1'b0) & (ap_enable_reg_pp0_iter3 == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b0))) begin
        ap_idle_pp0_1to4 = 1'b1;
    end else begin
        ap_idle_pp0_1to4 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage2_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage2))) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (ap_idle_pp0_0to3 == 1'b1))) begin
        ap_reset_idle_pp0 = 1'b1;
    end else begin
        ap_reset_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter4 == 1'b1) & (1'b0 == ap_block_pp0_stage2) & (1'b1 == ap_CS_fsm_pp0_stage2))) begin
        ap_sig_allocacmp_G_vec_I_1_load = grp_fu_724_p_dout0;
    end else begin
        ap_sig_allocacmp_G_vec_I_1_load = G_vec_I_1_i;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter4 == 1'b1) & (1'b0 == ap_block_pp0_stage2) & (1'b1 == ap_CS_fsm_pp0_stage2))) begin
        ap_sig_allocacmp_G_vec_I_2_load = grp_fu_720_p_dout0;
    end else begin
        ap_sig_allocacmp_G_vec_I_2_load = G_vec_I_2_i;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter3 == 1'b1) & (1'b0 == ap_block_pp0_stage1) & (1'b1 == ap_CS_fsm_pp0_stage1))) begin
        ap_sig_allocacmp_elements_Ih_0_load = grp_fu_720_p_dout0;
    end else begin
        ap_sig_allocacmp_elements_Ih_0_load = elements_Ih_0;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_00001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((ap_enable_reg_pp0_iter3 == 1'b1) & (1'b0 == ap_block_pp0_stage2_00001) & (1'b1 == ap_CS_fsm_pp0_stage2)))) begin
        grp_fu_20_opcode = 2'd1;
    end else if (((ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage1_00001) & (1'b1 == ap_CS_fsm_pp0_stage1))) begin
        grp_fu_20_opcode = 2'd0;
    end else begin
        grp_fu_20_opcode = 'bx;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter3 == 1'b1) & (1'b0 == ap_block_pp0_stage2) & (1'b1 == ap_CS_fsm_pp0_stage2))) begin
        grp_fu_20_p0 = ap_sig_allocacmp_G_vec_I_2_load;
    end else if (((ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage1) & (1'b1 == ap_CS_fsm_pp0_stage1))) begin
        grp_fu_20_p0 = ap_sig_allocacmp_elements_Ih_0_load;
    end else if (((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        grp_fu_20_p0 = G_vec_V_2;
    end else begin
        grp_fu_20_p0 = 'bx;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter3 == 1'b1) & (1'b0 == ap_block_pp0_stage2) & (1'b1 == ap_CS_fsm_pp0_stage2))) begin
        grp_fu_20_p1 = add_reg_101;
    end else if (((ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage1) & (1'b1 == ap_CS_fsm_pp0_stage1))) begin
        grp_fu_20_p1 = mul_reg_91;
    end else if (((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        grp_fu_20_p1 = G_vec_V_1;
    end else begin
        grp_fu_20_p1 = 'bx;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_pp0_stage0 : begin
            if ((~((ap_start == 1'b0) & (ap_idle_pp0_1to4 == 1'b1)) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end
        end
        ap_ST_fsm_pp0_stage1 : begin
            if ((1'b0 == ap_block_pp0_stage1_subdone)) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage1;
            end
        end
        ap_ST_fsm_pp0_stage2 : begin
            if ((((1'b0 == ap_block_pp0_stage2_subdone) & (ap_reset_idle_pp0 == 1'b0)) | ((1'b0 == ap_block_pp0_stage2_subdone) & (ap_reset_idle_pp0 == 1'b1)))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage2;
            end
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_pp0_stage1 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_pp0_stage2 = ap_CS_fsm[32'd2];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage0_00001 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage0_11001 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage0_subdone = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage1 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage1_00001 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage1_11001 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage1_subdone = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage2 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage2_00001 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage2_11001 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage2_subdone = ~(1'b1 == 1'b1);

assign ap_block_state10_pp0_stage0_iter3 = ~(1'b1 == 1'b1);

assign ap_block_state11_pp0_stage1_iter3 = ~(1'b1 == 1'b1);

assign ap_block_state12_pp0_stage2_iter3 = ~(1'b1 == 1'b1);

assign ap_block_state13_pp0_stage0_iter4 = ~(1'b1 == 1'b1);

assign ap_block_state14_pp0_stage1_iter4 = ~(1'b1 == 1'b1);

assign ap_block_state15_pp0_stage2_iter4 = ~(1'b1 == 1'b1);

assign ap_block_state1_pp0_stage0_iter0 = ~(1'b1 == 1'b1);

assign ap_block_state2_pp0_stage1_iter0 = ~(1'b1 == 1'b1);

assign ap_block_state3_pp0_stage2_iter0 = ~(1'b1 == 1'b1);

assign ap_block_state4_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

assign ap_block_state5_pp0_stage1_iter1 = ~(1'b1 == 1'b1);

assign ap_block_state6_pp0_stage2_iter1 = ~(1'b1 == 1'b1);

assign ap_block_state7_pp0_stage0_iter2 = ~(1'b1 == 1'b1);

assign ap_block_state8_pp0_stage1_iter2 = ~(1'b1 == 1'b1);

assign ap_block_state9_pp0_stage2_iter2 = ~(1'b1 == 1'b1);

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign grp_fu_20_ce = 1'b1;

assign grp_fu_20_p2 = grp_fu_720_p_dout0;

assign grp_fu_24_ce = 1'b1;

assign grp_fu_24_p0 = ap_sig_allocacmp_G_vec_I_1_load;

assign grp_fu_24_p1 = add_reg_101;

assign grp_fu_24_p2 = grp_fu_724_p_dout0;

assign grp_fu_28_ce = 1'b1;

assign grp_fu_28_p0 = sub_reg_86;

assign grp_fu_28_p1 = 32'd1008981770;

assign grp_fu_28_p2 = grp_fu_744_p_dout0;

assign grp_fu_720_p_ce = 1'b1;

assign grp_fu_720_p_din0 = grp_fu_20_p0;

assign grp_fu_720_p_din1 = grp_fu_20_p1;

assign grp_fu_720_p_opcode = grp_fu_20_opcode;

assign grp_fu_724_p_ce = 1'b1;

assign grp_fu_724_p_din0 = ap_sig_allocacmp_G_vec_I_1_load;

assign grp_fu_724_p_din1 = add_reg_101;

assign grp_fu_724_p_opcode = 2'd0;

assign grp_fu_744_p_ce = 1'b1;

assign grp_fu_744_p_din0 = sub_reg_86;

assign grp_fu_744_p_din1 = 32'd1008981770;

endmodule //nodalSolver_histvect
