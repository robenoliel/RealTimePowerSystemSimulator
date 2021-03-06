-- ==============================================================
-- RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
-- Version: 2020.2
-- Copyright (C) Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity nodalSolver_histvect is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    G_vec_V_1 : IN STD_LOGIC_VECTOR (31 downto 0);
    G_vec_I_1_i : IN STD_LOGIC_VECTOR (31 downto 0);
    G_vec_I_1_o : OUT STD_LOGIC_VECTOR (31 downto 0);
    G_vec_I_1_o_ap_vld : OUT STD_LOGIC;
    G_vec_V_2 : IN STD_LOGIC_VECTOR (31 downto 0);
    G_vec_I_2_i : IN STD_LOGIC_VECTOR (31 downto 0);
    G_vec_I_2_o : OUT STD_LOGIC_VECTOR (31 downto 0);
    G_vec_I_2_o_ap_vld : OUT STD_LOGIC;
    grp_fu_726_p_din0 : OUT STD_LOGIC_VECTOR (31 downto 0);
    grp_fu_726_p_din1 : OUT STD_LOGIC_VECTOR (31 downto 0);
    grp_fu_726_p_opcode : OUT STD_LOGIC_VECTOR (1 downto 0);
    grp_fu_726_p_dout0 : IN STD_LOGIC_VECTOR (31 downto 0);
    grp_fu_726_p_ce : OUT STD_LOGIC;
    grp_fu_730_p_din0 : OUT STD_LOGIC_VECTOR (31 downto 0);
    grp_fu_730_p_din1 : OUT STD_LOGIC_VECTOR (31 downto 0);
    grp_fu_730_p_opcode : OUT STD_LOGIC_VECTOR (1 downto 0);
    grp_fu_730_p_dout0 : IN STD_LOGIC_VECTOR (31 downto 0);
    grp_fu_730_p_ce : OUT STD_LOGIC;
    grp_fu_734_p_din0 : OUT STD_LOGIC_VECTOR (31 downto 0);
    grp_fu_734_p_din1 : OUT STD_LOGIC_VECTOR (31 downto 0);
    grp_fu_734_p_opcode : OUT STD_LOGIC_VECTOR (1 downto 0);
    grp_fu_734_p_dout0 : IN STD_LOGIC_VECTOR (31 downto 0);
    grp_fu_734_p_ce : OUT STD_LOGIC;
    grp_fu_742_p_din0 : OUT STD_LOGIC_VECTOR (31 downto 0);
    grp_fu_742_p_din1 : OUT STD_LOGIC_VECTOR (31 downto 0);
    grp_fu_742_p_dout0 : IN STD_LOGIC_VECTOR (31 downto 0);
    grp_fu_742_p_ce : OUT STD_LOGIC );
end;


architecture behav of nodalSolver_histvect is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_pp0_stage0 : STD_LOGIC_VECTOR (6 downto 0) := "0000001";
    constant ap_ST_fsm_pp0_stage1 : STD_LOGIC_VECTOR (6 downto 0) := "0000010";
    constant ap_ST_fsm_pp0_stage2 : STD_LOGIC_VECTOR (6 downto 0) := "0000100";
    constant ap_ST_fsm_pp0_stage3 : STD_LOGIC_VECTOR (6 downto 0) := "0001000";
    constant ap_ST_fsm_pp0_stage4 : STD_LOGIC_VECTOR (6 downto 0) := "0010000";
    constant ap_ST_fsm_pp0_stage5 : STD_LOGIC_VECTOR (6 downto 0) := "0100000";
    constant ap_ST_fsm_pp0_stage6 : STD_LOGIC_VECTOR (6 downto 0) := "1000000";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_boolean_0 : BOOLEAN := false;
    constant ap_const_lv32_6 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000110";
    constant ap_const_lv32_3 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000011";
    constant ap_const_lv32_2 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000010";
    constant ap_const_lv32_4 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000100";
    constant ap_const_lv32_3C23D70A : STD_LOGIC_VECTOR (31 downto 0) := "00111100001000111101011100001010";
    constant ap_const_lv32_42200000 : STD_LOGIC_VECTOR (31 downto 0) := "01000010001000000000000000000000";
    constant ap_const_lv32_80000000 : STD_LOGIC_VECTOR (31 downto 0) := "10000000000000000000000000000000";
    constant ap_const_lv2_0 : STD_LOGIC_VECTOR (1 downto 0) := "00";
    constant ap_const_lv2_1 : STD_LOGIC_VECTOR (1 downto 0) := "01";

attribute shreg_extract : string;
    signal ap_CS_fsm : STD_LOGIC_VECTOR (6 downto 0) := "0000001";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_pp0_stage0 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_pp0_stage0 : signal is "none";
    signal ap_enable_reg_pp0_iter0 : STD_LOGIC;
    signal ap_block_pp0_stage0 : BOOLEAN;
    signal ap_enable_reg_pp0_iter1 : STD_LOGIC := '0';
    signal ap_enable_reg_pp0_iter2 : STD_LOGIC := '0';
    signal ap_idle_pp0 : STD_LOGIC;
    signal ap_CS_fsm_pp0_stage6 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_pp0_stage6 : signal is "none";
    signal ap_block_state7_pp0_stage6_iter0 : BOOLEAN;
    signal ap_block_state14_pp0_stage6_iter1 : BOOLEAN;
    signal ap_block_pp0_stage6_11001 : BOOLEAN;
    signal elements_Ih_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    signal elements_Ih_1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    signal grp_fu_26_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal reg_44 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_CS_fsm_pp0_stage3 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_pp0_stage3 : signal is "none";
    signal ap_block_state4_pp0_stage3_iter0 : BOOLEAN;
    signal ap_block_state11_pp0_stage3_iter1 : BOOLEAN;
    signal ap_block_pp0_stage3_11001 : BOOLEAN;
    signal ap_block_state1_pp0_stage0_iter0 : BOOLEAN;
    signal ap_block_state8_pp0_stage0_iter1 : BOOLEAN;
    signal ap_block_state15_pp0_stage0_iter2 : BOOLEAN;
    signal ap_block_pp0_stage0_11001 : BOOLEAN;
    signal grp_fu_38_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal mul_reg_130 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_CS_fsm_pp0_stage2 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_pp0_stage2 : signal is "none";
    signal ap_block_state3_pp0_stage2_iter0 : BOOLEAN;
    signal ap_block_state10_pp0_stage2_iter1 : BOOLEAN;
    signal ap_block_pp0_stage2_11001 : BOOLEAN;
    signal mul_1_reg_140 : STD_LOGIC_VECTOR (31 downto 0);
    signal bitcast_ln91_1_fu_91_p1 : STD_LOGIC_VECTOR (31 downto 0);
    signal grp_fu_30_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal sub4_reg_155 : STD_LOGIC_VECTOR (31 downto 0);
    signal grp_fu_34_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal sub3_1_reg_160 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_CS_fsm_pp0_stage4 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_pp0_stage4 : signal is "none";
    signal ap_block_state5_pp0_stage4_iter0 : BOOLEAN;
    signal ap_block_state12_pp0_stage4_iter1 : BOOLEAN;
    signal ap_block_pp0_stage4_11001 : BOOLEAN;
    signal ap_enable_reg_pp0_iter0_reg : STD_LOGIC := '0';
    signal ap_block_pp0_stage6_subdone : BOOLEAN;
    signal ap_block_pp0_stage0_subdone : BOOLEAN;
    signal ap_block_pp0_stage3 : BOOLEAN;
    signal ap_sig_allocacmp_G_vec_I_1_load : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_block_pp0_stage4 : BOOLEAN;
    signal grp_fu_26_p0 : STD_LOGIC_VECTOR (31 downto 0);
    signal grp_fu_26_p1 : STD_LOGIC_VECTOR (31 downto 0);
    signal grp_fu_30_p0 : STD_LOGIC_VECTOR (31 downto 0);
    signal grp_fu_30_p1 : STD_LOGIC_VECTOR (31 downto 0);
    signal grp_fu_34_p0 : STD_LOGIC_VECTOR (31 downto 0);
    signal grp_fu_34_p1 : STD_LOGIC_VECTOR (31 downto 0);
    signal grp_fu_38_p0 : STD_LOGIC_VECTOR (31 downto 0);
    signal grp_fu_38_p1 : STD_LOGIC_VECTOR (31 downto 0);
    signal bitcast_ln91_fu_81_p1 : STD_LOGIC_VECTOR (31 downto 0);
    signal xor_ln91_fu_85_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal grp_fu_26_opcode : STD_LOGIC_VECTOR (1 downto 0);
    signal ap_block_pp0_stage3_00001 : BOOLEAN;
    signal ap_block_pp0_stage0_00001 : BOOLEAN;
    signal ap_block_pp0_stage4_00001 : BOOLEAN;
    signal grp_fu_26_ce : STD_LOGIC;
    signal grp_fu_30_opcode : STD_LOGIC_VECTOR (1 downto 0);
    signal grp_fu_30_ce : STD_LOGIC;
    signal grp_fu_34_ce : STD_LOGIC;
    signal grp_fu_38_ce : STD_LOGIC;
    signal ap_NS_fsm : STD_LOGIC_VECTOR (6 downto 0);
    signal ap_idle_pp0_0to1 : STD_LOGIC;
    signal ap_reset_idle_pp0 : STD_LOGIC;
    signal ap_idle_pp0_1to2 : STD_LOGIC;
    signal ap_block_state2_pp0_stage1_iter0 : BOOLEAN;
    signal ap_block_state9_pp0_stage1_iter1 : BOOLEAN;
    signal ap_block_pp0_stage1_subdone : BOOLEAN;
    signal ap_block_pp0_stage2_subdone : BOOLEAN;
    signal ap_block_pp0_stage3_subdone : BOOLEAN;
    signal ap_block_pp0_stage4_subdone : BOOLEAN;
    signal ap_block_state6_pp0_stage5_iter0 : BOOLEAN;
    signal ap_block_state13_pp0_stage5_iter1 : BOOLEAN;
    signal ap_block_pp0_stage5_subdone : BOOLEAN;
    signal ap_enable_pp0 : STD_LOGIC;
    signal ap_ce_reg : STD_LOGIC;

    component nodalSolver_faddfsub_32ns_32ns_32_4_full_dsp_1 IS
    generic (
        ID : INTEGER;
        NUM_STAGE : INTEGER;
        din0_WIDTH : INTEGER;
        din1_WIDTH : INTEGER;
        dout_WIDTH : INTEGER );
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        din0 : IN STD_LOGIC_VECTOR (31 downto 0);
        din1 : IN STD_LOGIC_VECTOR (31 downto 0);
        opcode : IN STD_LOGIC_VECTOR (1 downto 0);
        ce : IN STD_LOGIC;
        dout : OUT STD_LOGIC_VECTOR (31 downto 0) );
    end component;


    component nodalSolver_fsub_32ns_32ns_32_4_full_dsp_1 IS
    generic (
        ID : INTEGER;
        NUM_STAGE : INTEGER;
        din0_WIDTH : INTEGER;
        din1_WIDTH : INTEGER;
        dout_WIDTH : INTEGER );
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        din0 : IN STD_LOGIC_VECTOR (31 downto 0);
        din1 : IN STD_LOGIC_VECTOR (31 downto 0);
        ce : IN STD_LOGIC;
        dout : OUT STD_LOGIC_VECTOR (31 downto 0) );
    end component;


    component nodalSolver_fmul_32ns_32ns_32_3_max_dsp_1 IS
    generic (
        ID : INTEGER;
        NUM_STAGE : INTEGER;
        din0_WIDTH : INTEGER;
        din1_WIDTH : INTEGER;
        dout_WIDTH : INTEGER );
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        din0 : IN STD_LOGIC_VECTOR (31 downto 0);
        din1 : IN STD_LOGIC_VECTOR (31 downto 0);
        ce : IN STD_LOGIC;
        dout : OUT STD_LOGIC_VECTOR (31 downto 0) );
    end component;



begin




    ap_CS_fsm_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_CS_fsm <= ap_ST_fsm_pp0_stage0;
            else
                ap_CS_fsm <= ap_NS_fsm;
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter0_reg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter0_reg <= ap_const_logic_0;
            else
                if ((ap_const_logic_1 = ap_CS_fsm_pp0_stage0)) then 
                    ap_enable_reg_pp0_iter0_reg <= ap_start;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter1_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter1 <= ap_const_logic_0;
            else
                if (((ap_const_boolean_0 = ap_block_pp0_stage6_subdone) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage6))) then 
                    ap_enable_reg_pp0_iter1 <= ap_enable_reg_pp0_iter0;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter2_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter2 <= ap_const_logic_0;
            else
                if (((ap_const_boolean_0 = ap_block_pp0_stage6_subdone) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage6))) then 
                    ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
                elsif (((ap_enable_reg_pp0_iter1 = ap_const_logic_0) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
                    ap_enable_reg_pp0_iter2 <= ap_const_logic_0;
                end if; 
            end if;
        end if;
    end process;

    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage6_11001) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage6))) then
                elements_Ih_0 <= grp_fu_726_p_dout0;
                mul_1_reg_140 <= grp_fu_742_p_dout0;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage3_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage3))) then
                elements_Ih_1 <= grp_fu_734_p_dout0;
                sub4_reg_155 <= grp_fu_730_p_dout0;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage2_11001) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage2))) then
                mul_reg_130 <= grp_fu_742_p_dout0;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((((ap_const_boolean_0 = ap_block_pp0_stage3_11001) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage3)) or ((ap_const_boolean_0 = ap_block_pp0_stage6_11001) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage6)))) then
                reg_44 <= grp_fu_726_p_dout0;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage3_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage3))) then
                sub3_1_reg_160 <= grp_fu_734_p_dout0;
            end if;
        end if;
    end process;

    ap_NS_fsm_assign_proc : process (ap_start, ap_CS_fsm, ap_block_pp0_stage6_subdone, ap_block_pp0_stage0_subdone, ap_reset_idle_pp0, ap_idle_pp0_1to2, ap_block_pp0_stage1_subdone, ap_block_pp0_stage2_subdone, ap_block_pp0_stage3_subdone, ap_block_pp0_stage4_subdone, ap_block_pp0_stage5_subdone)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_pp0_stage0 => 
                if ((not(((ap_idle_pp0_1to2 = ap_const_logic_1) and (ap_start = ap_const_logic_0))) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_reset_idle_pp0 = ap_const_logic_0))) then
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage1;
                elsif (((ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_reset_idle_pp0 = ap_const_logic_1))) then
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
                else
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
                end if;
            when ap_ST_fsm_pp0_stage1 => 
                if ((ap_const_boolean_0 = ap_block_pp0_stage1_subdone)) then
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage2;
                else
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage1;
                end if;
            when ap_ST_fsm_pp0_stage2 => 
                if ((ap_const_boolean_0 = ap_block_pp0_stage2_subdone)) then
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage3;
                else
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage2;
                end if;
            when ap_ST_fsm_pp0_stage3 => 
                if ((ap_const_boolean_0 = ap_block_pp0_stage3_subdone)) then
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage4;
                else
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage3;
                end if;
            when ap_ST_fsm_pp0_stage4 => 
                if ((ap_const_boolean_0 = ap_block_pp0_stage4_subdone)) then
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage5;
                else
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage4;
                end if;
            when ap_ST_fsm_pp0_stage5 => 
                if ((ap_const_boolean_0 = ap_block_pp0_stage5_subdone)) then
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage6;
                else
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage5;
                end if;
            when ap_ST_fsm_pp0_stage6 => 
                if ((ap_const_boolean_0 = ap_block_pp0_stage6_subdone)) then
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
                else
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage6;
                end if;
            when others =>  
                ap_NS_fsm <= "XXXXXXX";
        end case;
    end process;

    G_vec_I_1_o_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0, ap_enable_reg_pp0_iter2, G_vec_I_1_i, grp_fu_730_p_dout0)
    begin
        if (((ap_enable_reg_pp0_iter2 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            G_vec_I_1_o <= grp_fu_730_p_dout0;
        else 
            G_vec_I_1_o <= G_vec_I_1_i;
        end if; 
    end process;


    G_vec_I_1_o_ap_vld_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter2, ap_block_pp0_stage0_11001)
    begin
        if (((ap_enable_reg_pp0_iter2 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            G_vec_I_1_o_ap_vld <= ap_const_logic_1;
        else 
            G_vec_I_1_o_ap_vld <= ap_const_logic_0;
        end if; 
    end process;


    G_vec_I_2_o_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0, ap_enable_reg_pp0_iter2, G_vec_I_2_i, grp_fu_726_p_dout0)
    begin
        if (((ap_enable_reg_pp0_iter2 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            G_vec_I_2_o <= grp_fu_726_p_dout0;
        else 
            G_vec_I_2_o <= G_vec_I_2_i;
        end if; 
    end process;


    G_vec_I_2_o_ap_vld_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter2, ap_block_pp0_stage0_11001)
    begin
        if (((ap_enable_reg_pp0_iter2 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            G_vec_I_2_o_ap_vld <= ap_const_logic_1;
        else 
            G_vec_I_2_o_ap_vld <= ap_const_logic_0;
        end if; 
    end process;

    ap_CS_fsm_pp0_stage0 <= ap_CS_fsm(0);
    ap_CS_fsm_pp0_stage2 <= ap_CS_fsm(2);
    ap_CS_fsm_pp0_stage3 <= ap_CS_fsm(3);
    ap_CS_fsm_pp0_stage4 <= ap_CS_fsm(4);
    ap_CS_fsm_pp0_stage6 <= ap_CS_fsm(6);
        ap_block_pp0_stage0 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage0_00001 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage0_11001 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage0_subdone <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage1_subdone <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage2_11001 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage2_subdone <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage3 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage3_00001 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage3_11001 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage3_subdone <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage4 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage4_00001 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage4_11001 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage4_subdone <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage5_subdone <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage6_11001 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage6_subdone <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state10_pp0_stage2_iter1 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state11_pp0_stage3_iter1 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state12_pp0_stage4_iter1 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state13_pp0_stage5_iter1 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state14_pp0_stage6_iter1 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state15_pp0_stage0_iter2 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state1_pp0_stage0_iter0 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state2_pp0_stage1_iter0 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state3_pp0_stage2_iter0 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state4_pp0_stage3_iter0 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state5_pp0_stage4_iter0 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state6_pp0_stage5_iter0 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state7_pp0_stage6_iter0 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state8_pp0_stage0_iter1 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state9_pp0_stage1_iter1 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_done_assign_proc : process(ap_start, ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter0, ap_block_pp0_stage0, ap_enable_reg_pp0_iter2, ap_block_pp0_stage0_11001)
    begin
        if ((((ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_start = ap_const_logic_0)) or ((ap_enable_reg_pp0_iter2 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0)))) then 
            ap_done <= ap_const_logic_1;
        else 
            ap_done <= ap_const_logic_0;
        end if; 
    end process;

    ap_enable_pp0 <= (ap_idle_pp0 xor ap_const_logic_1);

    ap_enable_reg_pp0_iter0_assign_proc : process(ap_start, ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter0_reg)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_pp0_stage0)) then 
            ap_enable_reg_pp0_iter0 <= ap_start;
        else 
            ap_enable_reg_pp0_iter0 <= ap_enable_reg_pp0_iter0_reg;
        end if; 
    end process;


    ap_idle_assign_proc : process(ap_start, ap_CS_fsm_pp0_stage0, ap_idle_pp0)
    begin
        if (((ap_idle_pp0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_start = ap_const_logic_0))) then 
            ap_idle <= ap_const_logic_1;
        else 
            ap_idle <= ap_const_logic_0;
        end if; 
    end process;


    ap_idle_pp0_assign_proc : process(ap_enable_reg_pp0_iter0, ap_enable_reg_pp0_iter1, ap_enable_reg_pp0_iter2)
    begin
        if (((ap_enable_reg_pp0_iter2 = ap_const_logic_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_0))) then 
            ap_idle_pp0 <= ap_const_logic_1;
        else 
            ap_idle_pp0 <= ap_const_logic_0;
        end if; 
    end process;


    ap_idle_pp0_0to1_assign_proc : process(ap_enable_reg_pp0_iter0, ap_enable_reg_pp0_iter1)
    begin
        if (((ap_enable_reg_pp0_iter1 = ap_const_logic_0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_0))) then 
            ap_idle_pp0_0to1 <= ap_const_logic_1;
        else 
            ap_idle_pp0_0to1 <= ap_const_logic_0;
        end if; 
    end process;


    ap_idle_pp0_1to2_assign_proc : process(ap_enable_reg_pp0_iter1, ap_enable_reg_pp0_iter2)
    begin
        if (((ap_enable_reg_pp0_iter2 = ap_const_logic_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_0))) then 
            ap_idle_pp0_1to2 <= ap_const_logic_1;
        else 
            ap_idle_pp0_1to2 <= ap_const_logic_0;
        end if; 
    end process;


    ap_ready_assign_proc : process(ap_enable_reg_pp0_iter0, ap_CS_fsm_pp0_stage6, ap_block_pp0_stage6_11001)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage6_11001) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage6))) then 
            ap_ready <= ap_const_logic_1;
        else 
            ap_ready <= ap_const_logic_0;
        end if; 
    end process;


    ap_reset_idle_pp0_assign_proc : process(ap_start, ap_idle_pp0_0to1)
    begin
        if (((ap_idle_pp0_0to1 = ap_const_logic_1) and (ap_start = ap_const_logic_0))) then 
            ap_reset_idle_pp0 <= ap_const_logic_1;
        else 
            ap_reset_idle_pp0 <= ap_const_logic_0;
        end if; 
    end process;


    ap_sig_allocacmp_G_vec_I_1_load_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0, ap_enable_reg_pp0_iter2, G_vec_I_1_i, grp_fu_730_p_dout0)
    begin
        if (((ap_enable_reg_pp0_iter2 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            ap_sig_allocacmp_G_vec_I_1_load <= grp_fu_730_p_dout0;
        else 
            ap_sig_allocacmp_G_vec_I_1_load <= G_vec_I_1_i;
        end if; 
    end process;

    bitcast_ln91_1_fu_91_p1 <= xor_ln91_fu_85_p2;
    bitcast_ln91_fu_81_p1 <= elements_Ih_1;
    grp_fu_26_ce <= ap_const_logic_1;

    grp_fu_26_opcode_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter0, ap_enable_reg_pp0_iter1, ap_CS_fsm_pp0_stage3, ap_CS_fsm_pp0_stage4, ap_block_pp0_stage3_00001, ap_block_pp0_stage0_00001, ap_block_pp0_stage4_00001)
    begin
        if ((((ap_const_boolean_0 = ap_block_pp0_stage0_00001) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0)) or ((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage4_00001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage4)))) then 
            grp_fu_26_opcode <= ap_const_lv2_1;
        elsif (((ap_const_boolean_0 = ap_block_pp0_stage3_00001) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage3))) then 
            grp_fu_26_opcode <= ap_const_lv2_0;
        else 
            grp_fu_26_opcode <= "XX";
        end if; 
    end process;


    grp_fu_26_p0_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter0, ap_block_pp0_stage0, ap_enable_reg_pp0_iter1, elements_Ih_0, G_vec_V_2, G_vec_I_2_i, ap_CS_fsm_pp0_stage3, ap_CS_fsm_pp0_stage4, ap_block_pp0_stage3, ap_block_pp0_stage4)
    begin
        if (((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage4) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage4))) then 
            grp_fu_26_p0 <= G_vec_I_2_i;
        elsif (((ap_const_boolean_0 = ap_block_pp0_stage3) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage3))) then 
            grp_fu_26_p0 <= elements_Ih_0;
        elsif (((ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            grp_fu_26_p0 <= G_vec_V_2;
        else 
            grp_fu_26_p0 <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        end if; 
    end process;


    grp_fu_26_p1_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter0, ap_block_pp0_stage0, ap_enable_reg_pp0_iter1, G_vec_V_1, ap_CS_fsm_pp0_stage3, mul_reg_130, sub3_1_reg_160, ap_CS_fsm_pp0_stage4, ap_block_pp0_stage3, ap_block_pp0_stage4)
    begin
        if (((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage4) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage4))) then 
            grp_fu_26_p1 <= sub3_1_reg_160;
        elsif (((ap_const_boolean_0 = ap_block_pp0_stage3) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage3))) then 
            grp_fu_26_p1 <= mul_reg_130;
        elsif (((ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            grp_fu_26_p1 <= G_vec_V_1;
        else 
            grp_fu_26_p1 <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        end if; 
    end process;

    grp_fu_26_p2 <= grp_fu_726_p_dout0;
    grp_fu_30_ce <= ap_const_logic_1;

    grp_fu_30_opcode_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, ap_CS_fsm_pp0_stage4, ap_block_pp0_stage0_00001, ap_block_pp0_stage4_00001)
    begin
        if ((ap_enable_reg_pp0_iter1 = ap_const_logic_1)) then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_00001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
                grp_fu_30_opcode <= ap_const_lv2_1;
            elsif (((ap_const_boolean_0 = ap_block_pp0_stage4_00001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage4))) then 
                grp_fu_30_opcode <= ap_const_lv2_0;
            else 
                grp_fu_30_opcode <= "XX";
            end if;
        else 
            grp_fu_30_opcode <= "XX";
        end if; 
    end process;


    grp_fu_30_p0_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0, ap_enable_reg_pp0_iter1, sub4_reg_155, ap_CS_fsm_pp0_stage4, ap_sig_allocacmp_G_vec_I_1_load, ap_block_pp0_stage4)
    begin
        if ((ap_enable_reg_pp0_iter1 = ap_const_logic_1)) then
            if (((ap_const_boolean_0 = ap_block_pp0_stage4) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage4))) then 
                grp_fu_30_p0 <= sub4_reg_155;
            elsif (((ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
                grp_fu_30_p0 <= ap_sig_allocacmp_G_vec_I_1_load;
            else 
                grp_fu_30_p0 <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
            end if;
        else 
            grp_fu_30_p0 <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        end if; 
    end process;


    grp_fu_30_p1_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0, ap_enable_reg_pp0_iter1, reg_44, sub3_1_reg_160, ap_CS_fsm_pp0_stage4, ap_block_pp0_stage4)
    begin
        if ((ap_enable_reg_pp0_iter1 = ap_const_logic_1)) then
            if (((ap_const_boolean_0 = ap_block_pp0_stage4) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage4))) then 
                grp_fu_30_p1 <= sub3_1_reg_160;
            elsif (((ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
                grp_fu_30_p1 <= reg_44;
            else 
                grp_fu_30_p1 <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
            end if;
        else 
            grp_fu_30_p1 <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        end if; 
    end process;

    grp_fu_30_p2 <= grp_fu_730_p_dout0;
    grp_fu_34_ce <= ap_const_logic_1;
    grp_fu_34_p0 <= bitcast_ln91_1_fu_91_p1;
    grp_fu_34_p1 <= mul_1_reg_140;
    grp_fu_34_p2 <= grp_fu_734_p_dout0;
    grp_fu_38_ce <= ap_const_logic_1;

    grp_fu_38_p0_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter0, ap_block_pp0_stage0, G_vec_V_1, reg_44, ap_CS_fsm_pp0_stage4, ap_block_pp0_stage4)
    begin
        if ((ap_enable_reg_pp0_iter0 = ap_const_logic_1)) then
            if (((ap_const_boolean_0 = ap_block_pp0_stage4) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage4))) then 
                grp_fu_38_p0 <= reg_44;
            elsif (((ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
                grp_fu_38_p0 <= G_vec_V_1;
            else 
                grp_fu_38_p0 <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
            end if;
        else 
            grp_fu_38_p0 <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        end if; 
    end process;


    grp_fu_38_p1_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter0, ap_block_pp0_stage0, ap_CS_fsm_pp0_stage4, ap_block_pp0_stage4)
    begin
        if ((ap_enable_reg_pp0_iter0 = ap_const_logic_1)) then
            if (((ap_const_boolean_0 = ap_block_pp0_stage4) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage4))) then 
                grp_fu_38_p1 <= ap_const_lv32_42200000;
            elsif (((ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
                grp_fu_38_p1 <= ap_const_lv32_3C23D70A;
            else 
                grp_fu_38_p1 <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
            end if;
        else 
            grp_fu_38_p1 <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        end if; 
    end process;

    grp_fu_38_p2 <= grp_fu_742_p_dout0;
    grp_fu_726_p_ce <= ap_const_logic_1;
    grp_fu_726_p_din0 <= grp_fu_26_p0;
    grp_fu_726_p_din1 <= grp_fu_26_p1;
    grp_fu_726_p_opcode <= grp_fu_26_opcode;
    grp_fu_730_p_ce <= ap_const_logic_1;
    grp_fu_730_p_din0 <= grp_fu_30_p0;
    grp_fu_730_p_din1 <= grp_fu_30_p1;
    grp_fu_730_p_opcode <= grp_fu_30_opcode;
    grp_fu_734_p_ce <= ap_const_logic_1;
    grp_fu_734_p_din0 <= bitcast_ln91_1_fu_91_p1;
    grp_fu_734_p_din1 <= mul_1_reg_140;
    grp_fu_734_p_opcode <= ap_const_lv2_1;
    grp_fu_742_p_ce <= ap_const_logic_1;
    grp_fu_742_p_din0 <= grp_fu_38_p0;
    grp_fu_742_p_din1 <= grp_fu_38_p1;
    xor_ln91_fu_85_p2 <= (bitcast_ln91_fu_81_p1 xor ap_const_lv32_80000000);
end behav;
