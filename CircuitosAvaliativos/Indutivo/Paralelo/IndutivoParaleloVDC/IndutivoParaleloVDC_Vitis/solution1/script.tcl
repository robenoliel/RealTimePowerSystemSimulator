############################################################
## This file is generated automatically by Vitis HLS.
## Please DO NOT edit it.
## Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
############################################################
open_project IndutivoParaleloVDC_Vitis
set_top nodalSolver
add_files HLSfiles/main_core.cpp
add_files HLSfiles/main_core.h
add_files -tb HLSfiles/main_core_tb.cpp
open_solution "solution1" -flow_target vivado
set_part {xc7vx485tffg1157-1}
create_clock -period 10 -name default
set_clock_uncertainty 2%
#source "./IndutivoParaleloVDC_Vitis/solution1/directives.tcl"
csim_design
csynth_design
cosim_design
export_design -format ip_catalog
