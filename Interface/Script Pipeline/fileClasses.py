# -*- coding: utf-8 -*-
"""
Created on Tue Dec  8 20:36:21 2020

@author: roben
"""

import numpy as np

###################### GENERATES FILE MAIN_CORE.H ############################

class File_main_core_h:
    
    def __init__(self, netList, desiredIndex = [], integrationPass = 0.000005, pi = 3.1415926, precision = 1):
        self.integrationPass = integrationPass
        self.desiredIndex = desiredIndex
        self.pi = pi
        self.netList = netList
        self.precision = precision        #1=float 2=double

        
        try:
            if precision == 1:
                self.main_string = open('Script Pipeline\\HLStemplates//main_core_h.txt','r').read() #Gets the template
            else:
                self.main_string = open('Script Pipeline\\HLStemplates//main_core_h_double.txt','r').read() #Gets the template
        except IOError:
            raise Exception('main_core.h file template not found!')
        
        self.countLC = 0
        self.countI = 0
        self.countV = 0
        self.countNodes = 0
        self.matrixOrder = 0
        
        for element in self.netList:
            kind = element[2][0]
            if kind == 'C' or kind == 'L':
                self.countLC += 1
            elif kind == 'I' or kind == 'B':
                self.countI += 1
            elif kind == 'V' or kind == 'A':
                self.countV += 1
            if element[0] > self.countNodes:
                self.countNodes = element[0]
            if element[1] > self.countNodes:
                self.countNodes = element[1]
        self.matrixOrder = self.countV + self.countNodes
        
        if self.desiredIndex == []: self.desiredIndex = [i for i in range(self.countNodes)]
        if len(self.desiredIndex) < 4:
            while len(self.desiredIndex) < 4:
                self.desiredIndex += [self.desiredIndex[0]]
        self.main_string = self.main_string % (self.countLC, self.countI, \
                                               self.countV, self.countNodes, \
                                               self.matrixOrder, \
                                               self.pi, self.desiredIndex[0], \
                                               self.desiredIndex[1],self.desiredIndex[2], \
                                               self.desiredIndex[3])
        
    def get_main_string(self):
        return self.main_string
    
###################### GENERATES FILE MAIN_CORE.CPP ##########################

    
class File_main_core_cpp:
    
    def __init__(self, netList, Am, h, precision = 1):
        self.netList = netList
        self.Am = Am
        self.h = h
        self.precision = precision        #1=float 2=double
        try:
            self.main_string = open('Script Pipeline\\HLStemplates//main_core_cpp.txt','r').read() #Gets the template
        except IOError:
            raise Exception('main_core.cpp file template not found!')
        
        self.sourceI = []
        self.sourceV = []
        self.LC = []
        
        for line in netList:
            kind = line[2][0]
            if kind == 'I':
                self.sourceI.append([line[1], line[0], 0, 0, 0, line[3]])
            elif kind == 'V':
                self.sourceV.append([0, 0, 0, line[3]])
            elif kind == 'A':
                self.sourceV.append([2*np.pi*line[4]*h, line[3], line[5]*(np.pi/180), line[6]])
            elif kind == 'B':
                self.sourceI.append([line[1], line[0], 2*np.pi*line[4]*h, line[3], line[5]*(np.pi/180), line[6]])
            elif kind == 'L' or kind == 'C':
                self.LC.append([{'L':0, 'C':1}[kind], line[1], line[0], {'L':h/line[3], 'C':4*line[3]/h}[kind],0.0])
            
        position = self.main_string.find('static I_SOURCE i_sources[I_SOURCES] = ')
        position += len('static I_SOURCE i_sources[I_SOURCES] = ')
        prec_str = '%.'+str(7*self.precision)+'e'
        i_matrix = self.__cppMatrix(self.sourceI,  string_format = ['%d', '%d',prec_str,prec_str,prec_str,prec_str])
        self.main_string = self.main_string[:position] + i_matrix + self.main_string[position:]
        
        position = self.main_string.find('static V_SOURCE sources[V_SOURCES] = ')
        position += len('static V_SOURCE sources[V_SOURCES] = ')
        v_matrix = self.__cppMatrix(self.sourceV,  string_format = [prec_str,prec_str,prec_str,prec_str])
        self.main_string = self.main_string[:position] + v_matrix + self.main_string[position:]
        
        position = self.main_string.find('const MATRIX_G Gi[N][N] = ')
        position += len('const MATRIX_G Gi[N][N] = ')
        self.main_string = self.main_string[:position] + self.__cppMatrix(self.Am) + self.main_string[position:]
        
        position = self.main_string.find('static LC_ELEMENT elements[N_LC] = ')
        position += len('static LC_ELEMENT elements[N_LC] = ')
        lc_matrix = self.__cppMatrix(self.LC,  string_format = ['%d', '%d','%d',prec_str,prec_str])
        self.main_string = self.main_string[:position] + lc_matrix + self.main_string[position:]
                
    def __cppMatrix(self, matrix, string_format = []):
        prec_str = '%.'+str(7*self.precision)+'e'
        print(prec_str)
        matrix = np.array(matrix)
        if string_format == []:
            string_format = [prec_str]*matrix.shape[1]
        stringMatrix = "\n{"
        firstLine = True
        for line in matrix:
            if not firstLine:
                stringMatrix += ',\n'
            else:
                firstLine = False
            stringMatrix += "{"
            firstColumn = True
            for element, form in zip(line, string_format):
                if not firstColumn:
                    stringMatrix += ', '
                else:
                    firstColumn = False
                stringMatrix += form % (element)
            stringMatrix += '}'
        stringMatrix += '}'
        return stringMatrix

    def get_main_string(self):
        return self.main_string
    

###################### GENERATES FILE MAIN_CORE_TB.CPP ############################

class File_main_core_tb_cpp:
    
    def __init__(self, Am, h, time, name): #integration step?
        self.matrixOrder = Am.shape[0]
        
        try:
            self.main_string = open('Script Pipeline\\HLStemplates//main_core_tb_cpp.txt','r').read() #Gets the template
        except IOError:
            raise Exception('main_core.cpp file template not found!')
            
        output = '\nprintf("V1 = %f V\\n", outprint.a);\nprintf("V1 = %f V\\n", outprint.b);\nprintf("V1 = %f V\\n", outprint.c);\nprintf("V1 = %f V\\n", outprint.d);'
        if self.matrixOrder < 4:
            output = output[0:1+35*self.matrixOrder]
        
        position = self.main_string.find('printf("\\n");')
        position += len('printf("\\n");')
        #self.main_string = self.main_string[:position] + output + self.main_string[position:]
        
        self.main_string = self.main_string % (name, name, time//h)
        
    def get_main_string(self):
        return self.main_string
    
    
    
    
    
    
    
    
    
    