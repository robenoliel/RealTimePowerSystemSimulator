# -*- coding: utf-8 -*-
"""
Created on Sat Dec  5 15:53:48 2020

@author: roben
"""
import sys
import os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__))+'\\Script Pipeline')
import pickle
from fileClasses import * 
import numpy as np

######################## LOADS CIRCUIT DATA ##################################

path = 'Script Pipeline\\'
netListFile = open(path + 'netList.txt','rb')
netList = pickle.load(netListFile)
h = netList[-5]
name = netList[-4]
time = netList[-3]
precision = netList[-2]
HLSworkspace = netList[-1]
netList = netList[:-5]
print("Netlist:", netList)
matrixFile = open(path + 'Am.txt','rb')
Am = pickle.load(matrixFile)
netListFile.close()
print("Am:", Am)
print('h:',h)

################ IDENTIFIES DESTINATION DIRECTORY ############################

if HLSworkspace == '':
    HLSworkspace = path

try:
    os.mkdir(HLSworkspace + "HLSfiles")
    print('HLS files directory created successfully.')
except FileExistsError:
    print('HLS directory ready.')

#################### GENERATES MAIN_CORE.H FILE ##############################

file_code = File_main_core_h(netList, precision = precision)

try:
    file = open(path + "HLSfiles\\main_core.h",'w')
    file.write(file_code.get_main_string())
    file.close()
    print('The file main_core.h was generated successfully.')
except:
    raise Exception('There has been error while accessing the file main_core.h.')

#################### GENERATES MAIN_CORE.CPP FILE ############################

file_code = File_main_core_cpp(netList, np.linalg.inv(Am), h, precision = precision)

try:
    file = open(path + "HLSfiles\\main_core.cpp",'w')
    file.write(file_code.get_main_string())
    file.close()
    print('The file main_core.cpp was generated successfully.')
except:
    raise Exception('There has been error while accessing the file main_core.cpp.')
    
    
#################### GENERATES MAIN_CORE_TB.CPP FILE ############################

file_code = File_main_core_tb_cpp(np.linalg.inv(Am), h, time, name)

try:
    file = open(path + "HLSfiles\\main_core_tb.cpp",'w')
    file.write(file_code.get_main_string())
    file.close()
    print('The file main_core_tb.cpp was generated successfully.')
except:
    raise Exception('There has been error while accessing the file main_core_tb.cpp.')