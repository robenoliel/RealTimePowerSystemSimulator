-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity nodalSolver_mul_42ns_33ns_75_1_1_Multiplier_4 is
port (
    a: in std_logic_vector(42 - 1 downto 0);
    b: in std_logic_vector(33 - 1 downto 0);
    p: out std_logic_vector(75 - 1 downto 0));
end entity;

architecture behav of nodalSolver_mul_42ns_33ns_75_1_1_Multiplier_4 is
    signal a_i : std_logic_vector(42 - 1 downto 0);
    signal b_i : std_logic_vector(33 - 1 downto 0);
begin
    a_i <= a;
    b_i <= b;
    p <= std_logic_vector(resize(unsigned(a_i) * unsigned(b_i), 75));
end architecture;
