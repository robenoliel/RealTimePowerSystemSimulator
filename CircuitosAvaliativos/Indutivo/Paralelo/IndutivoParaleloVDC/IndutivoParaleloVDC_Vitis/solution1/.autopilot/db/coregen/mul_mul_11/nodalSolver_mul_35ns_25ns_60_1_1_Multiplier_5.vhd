-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity nodalSolver_mul_35ns_25ns_60_1_1_Multiplier_5 is
port (
    a: in std_logic_vector(35 - 1 downto 0);
    b: in std_logic_vector(25 - 1 downto 0);
    p: out std_logic_vector(60 - 1 downto 0));
end entity;

architecture behav of nodalSolver_mul_35ns_25ns_60_1_1_Multiplier_5 is
    signal a_i : std_logic_vector(35 - 1 downto 0);
    signal b_i : std_logic_vector(25 - 1 downto 0);
begin
    a_i <= a;
    b_i <= b;
    p <= std_logic_vector(resize(unsigned(a_i) * unsigned(b_i), 60));
end architecture;
