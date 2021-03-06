-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
Library IEEE;
use IEEE.std_logic_1164.all;
Library work;
use work.all;

entity nodalSolver_mul_35ns_25ns_60_1_1 is
    generic (
        ID : INTEGER;
        NUM_STAGE : INTEGER;
        din0_WIDTH : INTEGER;
        din1_WIDTH : INTEGER;
        dout_WIDTH : INTEGER);
    port (
        din0 : IN STD_LOGIC_VECTOR(din0_WIDTH - 1 DOWNTO 0);
        din1 : IN STD_LOGIC_VECTOR(din1_WIDTH - 1 DOWNTO 0);
        dout : OUT STD_LOGIC_VECTOR(dout_WIDTH - 1 DOWNTO 0));
end entity;

architecture arch of nodalSolver_mul_35ns_25ns_60_1_1 is
    component nodalSolver_mul_35ns_25ns_60_1_1_Multiplier_5 is
        port (
            a : IN STD_LOGIC_VECTOR;
            b : IN STD_LOGIC_VECTOR;
            p : OUT STD_LOGIC_VECTOR);
    end component;



begin
    nodalSolver_mul_35ns_25ns_60_1_1_Multiplier_5_U :  component nodalSolver_mul_35ns_25ns_60_1_1_Multiplier_5
    port map (
        a => din0,
        b => din1,
        p => dout);

end architecture;

