set moduleName vetmat
set isTopModule 0
set isCombinational 0
set isDatapathOnly 0
set isPipelined 1
set pipeline_type function
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set C_modelName {vetmat}
set C_modelType { void 0 }
set C_modelArgList {
	{ G_vec_I_0 float 32 regular {pointer 2} {global 2}  }
	{ G_vec_I_1 float 32 regular {pointer 2} {global 2}  }
	{ G_vec_I_2 float 32 regular {pointer 2} {global 2}  }
	{ G_vec_V_0 float 32 regular {pointer 1} {global 1}  }
	{ G_vec_V_1 float 32 regular {pointer 1} {global 1}  }
	{ G_vec_V_2 float 32 regular {pointer 1} {global 1}  }
}
set C_modelArgMapList {[ 
	{ "Name" : "G_vec_I_0", "interface" : "wire", "bitwidth" : 32, "direction" : "READWRITE", "extern" : 0} , 
 	{ "Name" : "G_vec_I_1", "interface" : "wire", "bitwidth" : 32, "direction" : "READWRITE", "extern" : 0} , 
 	{ "Name" : "G_vec_I_2", "interface" : "wire", "bitwidth" : 32, "direction" : "READWRITE", "extern" : 0} , 
 	{ "Name" : "G_vec_V_0", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "G_vec_V_1", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "G_vec_V_2", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY", "extern" : 0} ]}
# RTL Port declarations: 
set portNum 84
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ G_vec_I_0_i sc_in sc_lv 32 signal 0 } 
	{ G_vec_I_0_o sc_out sc_lv 32 signal 0 } 
	{ G_vec_I_0_o_ap_vld sc_out sc_logic 1 outvld 0 } 
	{ G_vec_I_1_i sc_in sc_lv 32 signal 1 } 
	{ G_vec_I_1_o sc_out sc_lv 32 signal 1 } 
	{ G_vec_I_1_o_ap_vld sc_out sc_logic 1 outvld 1 } 
	{ G_vec_I_2_i sc_in sc_lv 32 signal 2 } 
	{ G_vec_I_2_o sc_out sc_lv 32 signal 2 } 
	{ G_vec_I_2_o_ap_vld sc_out sc_logic 1 outvld 2 } 
	{ G_vec_V_0 sc_out sc_lv 32 signal 3 } 
	{ G_vec_V_0_ap_vld sc_out sc_logic 1 outvld 3 } 
	{ G_vec_V_1 sc_out sc_lv 32 signal 4 } 
	{ G_vec_V_1_ap_vld sc_out sc_logic 1 outvld 4 } 
	{ G_vec_V_2 sc_out sc_lv 32 signal 5 } 
	{ G_vec_V_2_ap_vld sc_out sc_logic 1 outvld 5 } 
	{ grp_fu_171_p_din0 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_171_p_din1 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_171_p_opcode sc_out sc_lv 2 signal -1 } 
	{ grp_fu_171_p_dout0 sc_in sc_lv 32 signal -1 } 
	{ grp_fu_171_p_ce sc_out sc_logic 1 signal -1 } 
	{ grp_fu_176_p_din0 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_176_p_din1 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_176_p_opcode sc_out sc_lv 2 signal -1 } 
	{ grp_fu_176_p_dout0 sc_in sc_lv 32 signal -1 } 
	{ grp_fu_176_p_ce sc_out sc_logic 1 signal -1 } 
	{ grp_fu_181_p_din0 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_181_p_din1 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_181_p_opcode sc_out sc_lv 2 signal -1 } 
	{ grp_fu_181_p_dout0 sc_in sc_lv 32 signal -1 } 
	{ grp_fu_181_p_ce sc_out sc_logic 1 signal -1 } 
	{ grp_fu_726_p_din0 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_726_p_din1 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_726_p_opcode sc_out sc_lv 2 signal -1 } 
	{ grp_fu_726_p_dout0 sc_in sc_lv 32 signal -1 } 
	{ grp_fu_726_p_ce sc_out sc_logic 1 signal -1 } 
	{ grp_fu_730_p_din0 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_730_p_din1 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_730_p_opcode sc_out sc_lv 2 signal -1 } 
	{ grp_fu_730_p_dout0 sc_in sc_lv 32 signal -1 } 
	{ grp_fu_730_p_ce sc_out sc_logic 1 signal -1 } 
	{ grp_fu_734_p_din0 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_734_p_din1 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_734_p_opcode sc_out sc_lv 2 signal -1 } 
	{ grp_fu_734_p_dout0 sc_in sc_lv 32 signal -1 } 
	{ grp_fu_734_p_ce sc_out sc_logic 1 signal -1 } 
	{ grp_fu_738_p_din0 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_738_p_din1 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_738_p_opcode sc_out sc_lv 2 signal -1 } 
	{ grp_fu_738_p_dout0 sc_in sc_lv 32 signal -1 } 
	{ grp_fu_738_p_ce sc_out sc_logic 1 signal -1 } 
	{ grp_fu_186_p_din0 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_186_p_din1 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_186_p_dout0 sc_in sc_lv 32 signal -1 } 
	{ grp_fu_186_p_ce sc_out sc_logic 1 signal -1 } 
	{ grp_fu_191_p_din0 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_191_p_din1 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_191_p_dout0 sc_in sc_lv 32 signal -1 } 
	{ grp_fu_191_p_ce sc_out sc_logic 1 signal -1 } 
	{ grp_fu_196_p_din0 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_196_p_din1 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_196_p_dout0 sc_in sc_lv 32 signal -1 } 
	{ grp_fu_196_p_ce sc_out sc_logic 1 signal -1 } 
	{ grp_fu_742_p_din0 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_742_p_din1 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_742_p_dout0 sc_in sc_lv 32 signal -1 } 
	{ grp_fu_742_p_ce sc_out sc_logic 1 signal -1 } 
	{ grp_fu_746_p_din0 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_746_p_din1 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_746_p_dout0 sc_in sc_lv 32 signal -1 } 
	{ grp_fu_746_p_ce sc_out sc_logic 1 signal -1 } 
	{ grp_fu_750_p_din0 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_750_p_din1 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_750_p_dout0 sc_in sc_lv 32 signal -1 } 
	{ grp_fu_750_p_ce sc_out sc_logic 1 signal -1 } 
	{ grp_fu_754_p_din0 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_754_p_din1 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_754_p_dout0 sc_in sc_lv 32 signal -1 } 
	{ grp_fu_754_p_ce sc_out sc_logic 1 signal -1 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "G_vec_I_0_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "G_vec_I_0", "role": "i" }} , 
 	{ "name": "G_vec_I_0_o", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "G_vec_I_0", "role": "o" }} , 
 	{ "name": "G_vec_I_0_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "G_vec_I_0", "role": "o_ap_vld" }} , 
 	{ "name": "G_vec_I_1_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "G_vec_I_1", "role": "i" }} , 
 	{ "name": "G_vec_I_1_o", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "G_vec_I_1", "role": "o" }} , 
 	{ "name": "G_vec_I_1_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "G_vec_I_1", "role": "o_ap_vld" }} , 
 	{ "name": "G_vec_I_2_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "G_vec_I_2", "role": "i" }} , 
 	{ "name": "G_vec_I_2_o", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "G_vec_I_2", "role": "o" }} , 
 	{ "name": "G_vec_I_2_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "G_vec_I_2", "role": "o_ap_vld" }} , 
 	{ "name": "G_vec_V_0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "G_vec_V_0", "role": "default" }} , 
 	{ "name": "G_vec_V_0_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "G_vec_V_0", "role": "ap_vld" }} , 
 	{ "name": "G_vec_V_1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "G_vec_V_1", "role": "default" }} , 
 	{ "name": "G_vec_V_1_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "G_vec_V_1", "role": "ap_vld" }} , 
 	{ "name": "G_vec_V_2", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "G_vec_V_2", "role": "default" }} , 
 	{ "name": "G_vec_V_2_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "G_vec_V_2", "role": "ap_vld" }} , 
 	{ "name": "grp_fu_171_p_din0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_171_p_din0", "role": "default" }} , 
 	{ "name": "grp_fu_171_p_din1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_171_p_din1", "role": "default" }} , 
 	{ "name": "grp_fu_171_p_opcode", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "grp_fu_171_p_opcode", "role": "default" }} , 
 	{ "name": "grp_fu_171_p_dout0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_171_p_dout0", "role": "default" }} , 
 	{ "name": "grp_fu_171_p_ce", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "grp_fu_171_p_ce", "role": "default" }} , 
 	{ "name": "grp_fu_176_p_din0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_176_p_din0", "role": "default" }} , 
 	{ "name": "grp_fu_176_p_din1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_176_p_din1", "role": "default" }} , 
 	{ "name": "grp_fu_176_p_opcode", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "grp_fu_176_p_opcode", "role": "default" }} , 
 	{ "name": "grp_fu_176_p_dout0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_176_p_dout0", "role": "default" }} , 
 	{ "name": "grp_fu_176_p_ce", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "grp_fu_176_p_ce", "role": "default" }} , 
 	{ "name": "grp_fu_181_p_din0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_181_p_din0", "role": "default" }} , 
 	{ "name": "grp_fu_181_p_din1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_181_p_din1", "role": "default" }} , 
 	{ "name": "grp_fu_181_p_opcode", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "grp_fu_181_p_opcode", "role": "default" }} , 
 	{ "name": "grp_fu_181_p_dout0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_181_p_dout0", "role": "default" }} , 
 	{ "name": "grp_fu_181_p_ce", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "grp_fu_181_p_ce", "role": "default" }} , 
 	{ "name": "grp_fu_726_p_din0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_726_p_din0", "role": "default" }} , 
 	{ "name": "grp_fu_726_p_din1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_726_p_din1", "role": "default" }} , 
 	{ "name": "grp_fu_726_p_opcode", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "grp_fu_726_p_opcode", "role": "default" }} , 
 	{ "name": "grp_fu_726_p_dout0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_726_p_dout0", "role": "default" }} , 
 	{ "name": "grp_fu_726_p_ce", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "grp_fu_726_p_ce", "role": "default" }} , 
 	{ "name": "grp_fu_730_p_din0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_730_p_din0", "role": "default" }} , 
 	{ "name": "grp_fu_730_p_din1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_730_p_din1", "role": "default" }} , 
 	{ "name": "grp_fu_730_p_opcode", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "grp_fu_730_p_opcode", "role": "default" }} , 
 	{ "name": "grp_fu_730_p_dout0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_730_p_dout0", "role": "default" }} , 
 	{ "name": "grp_fu_730_p_ce", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "grp_fu_730_p_ce", "role": "default" }} , 
 	{ "name": "grp_fu_734_p_din0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_734_p_din0", "role": "default" }} , 
 	{ "name": "grp_fu_734_p_din1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_734_p_din1", "role": "default" }} , 
 	{ "name": "grp_fu_734_p_opcode", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "grp_fu_734_p_opcode", "role": "default" }} , 
 	{ "name": "grp_fu_734_p_dout0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_734_p_dout0", "role": "default" }} , 
 	{ "name": "grp_fu_734_p_ce", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "grp_fu_734_p_ce", "role": "default" }} , 
 	{ "name": "grp_fu_738_p_din0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_738_p_din0", "role": "default" }} , 
 	{ "name": "grp_fu_738_p_din1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_738_p_din1", "role": "default" }} , 
 	{ "name": "grp_fu_738_p_opcode", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "grp_fu_738_p_opcode", "role": "default" }} , 
 	{ "name": "grp_fu_738_p_dout0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_738_p_dout0", "role": "default" }} , 
 	{ "name": "grp_fu_738_p_ce", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "grp_fu_738_p_ce", "role": "default" }} , 
 	{ "name": "grp_fu_186_p_din0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_186_p_din0", "role": "default" }} , 
 	{ "name": "grp_fu_186_p_din1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_186_p_din1", "role": "default" }} , 
 	{ "name": "grp_fu_186_p_dout0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_186_p_dout0", "role": "default" }} , 
 	{ "name": "grp_fu_186_p_ce", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "grp_fu_186_p_ce", "role": "default" }} , 
 	{ "name": "grp_fu_191_p_din0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_191_p_din0", "role": "default" }} , 
 	{ "name": "grp_fu_191_p_din1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_191_p_din1", "role": "default" }} , 
 	{ "name": "grp_fu_191_p_dout0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_191_p_dout0", "role": "default" }} , 
 	{ "name": "grp_fu_191_p_ce", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "grp_fu_191_p_ce", "role": "default" }} , 
 	{ "name": "grp_fu_196_p_din0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_196_p_din0", "role": "default" }} , 
 	{ "name": "grp_fu_196_p_din1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_196_p_din1", "role": "default" }} , 
 	{ "name": "grp_fu_196_p_dout0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_196_p_dout0", "role": "default" }} , 
 	{ "name": "grp_fu_196_p_ce", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "grp_fu_196_p_ce", "role": "default" }} , 
 	{ "name": "grp_fu_742_p_din0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_742_p_din0", "role": "default" }} , 
 	{ "name": "grp_fu_742_p_din1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_742_p_din1", "role": "default" }} , 
 	{ "name": "grp_fu_742_p_dout0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_742_p_dout0", "role": "default" }} , 
 	{ "name": "grp_fu_742_p_ce", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "grp_fu_742_p_ce", "role": "default" }} , 
 	{ "name": "grp_fu_746_p_din0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_746_p_din0", "role": "default" }} , 
 	{ "name": "grp_fu_746_p_din1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_746_p_din1", "role": "default" }} , 
 	{ "name": "grp_fu_746_p_dout0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_746_p_dout0", "role": "default" }} , 
 	{ "name": "grp_fu_746_p_ce", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "grp_fu_746_p_ce", "role": "default" }} , 
 	{ "name": "grp_fu_750_p_din0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_750_p_din0", "role": "default" }} , 
 	{ "name": "grp_fu_750_p_din1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_750_p_din1", "role": "default" }} , 
 	{ "name": "grp_fu_750_p_dout0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_750_p_dout0", "role": "default" }} , 
 	{ "name": "grp_fu_750_p_ce", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "grp_fu_750_p_ce", "role": "default" }} , 
 	{ "name": "grp_fu_754_p_din0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_754_p_din0", "role": "default" }} , 
 	{ "name": "grp_fu_754_p_din1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_754_p_din1", "role": "default" }} , 
 	{ "name": "grp_fu_754_p_dout0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_754_p_dout0", "role": "default" }} , 
 	{ "name": "grp_fu_754_p_ce", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "grp_fu_754_p_ce", "role": "default" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "",
		"CDFG" : "vetmat",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "Aligned", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "1",
		"VariableLatency" : "0", "ExactLatency" : "14", "EstimateLatencyMin" : "14", "EstimateLatencyMax" : "14",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "G_vec_I_0", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "G_vec_I_1", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "G_vec_I_2", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "G_vec_V_0", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "G_vec_V_1", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "G_vec_V_2", "Type" : "Vld", "Direction" : "O"}]}]}


set ArgLastReadFirstWriteLatency {
	vetmat {
		G_vec_I_0 {Type IO LastRead 0 FirstWrite 0}
		G_vec_I_1 {Type IO LastRead 4 FirstWrite 4}
		G_vec_I_2 {Type IO LastRead 8 FirstWrite 8}
		G_vec_V_0 {Type O LastRead -1 FirstWrite 14}
		G_vec_V_1 {Type O LastRead -1 FirstWrite 14}
		G_vec_V_2 {Type O LastRead -1 FirstWrite 14}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "14", "Max" : "14"}
	, {"Name" : "Interval", "Min" : "1", "Max" : "1"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	G_vec_I_0 { ap_ovld {  { G_vec_I_0_i in_data 0 32 }  { G_vec_I_0_o out_data 1 32 }  { G_vec_I_0_o_ap_vld out_vld 1 1 } } }
	G_vec_I_1 { ap_ovld {  { G_vec_I_1_i in_data 0 32 }  { G_vec_I_1_o out_data 1 32 }  { G_vec_I_1_o_ap_vld out_vld 1 1 } } }
	G_vec_I_2 { ap_ovld {  { G_vec_I_2_i in_data 0 32 }  { G_vec_I_2_o out_data 1 32 }  { G_vec_I_2_o_ap_vld out_vld 1 1 } } }
	G_vec_V_0 { ap_vld {  { G_vec_V_0 out_data 1 32 }  { G_vec_V_0_ap_vld out_vld 1 1 } } }
	G_vec_V_1 { ap_vld {  { G_vec_V_1 out_data 1 32 }  { G_vec_V_1_ap_vld out_vld 1 1 } } }
	G_vec_V_2 { ap_vld {  { G_vec_V_2 out_data 1 32 }  { G_vec_V_2_ap_vld out_vld 1 1 } } }
}
