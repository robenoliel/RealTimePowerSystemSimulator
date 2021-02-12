-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity nodalSolver_mul_64s_63ns_126_1_1_Multiplier_6 is
port (
    a: in std_logic_vector(64 - 1 downto 0);
    b: in std_logic_vector(63 - 1 downto 0);
    p: out std_logic_vector(126 - 1 downto 0));
end entity;

architecture behav of nodalSolver_mul_64s_63ns_126_1_1_Multiplier_6 is
    signal a_i : std_logic_vector(64 - 1 downto 0);
    signal b_i : std_logic_vector(63 - 1 downto 0);
begin
    a_i <= a;
    b_i <= b;
    p <= std_logic_vector(resize(unsigned(std_logic_vector(signed(a_i) * signed('0' & b_i))), 126));
end architecture;
