# -*- coding: utf-8 -*-
"""
Created on Thu Dec 24 14:01:12 2020

@author: roben
"""

import numpy as np
import matplotlib.pyplot as plt
from sklearn.metrics import r2_score, mean_squared_error


def mapper(x): return (x-32768)/256 #return x*256+32768

step = 0.0001
name = 'sotero'
psim_file = open('C:\\Users\\rodrigobagdadi\\Desktop\\RealTime\\ProjetoPipelineHLS\\Resultados\\'+name+'\\'+name+'_psim.txt').readlines()[1::]
psim = [line.split('\t') for line in psim_file]
psim = np.array(psim).astype(np.float)

hls_file = open('C:\\Users\\rodrigobagdadi\\Desktop\\RealTime\\ProjetoPipelineHLS\\Resultados\\'+name+'\\results_'+name+'.txt').read()
hls = [line.split(' ') for line in hls_file.split(';')][1:-1]
hls = np.array(hls).astype(np.float)
hls = mapper(hls)
y_psim  = psim[:-1,1]
y_hls = hls[:,0]
plt.figure()
plt.plot(np.linspace(0,step*hls.shape[0],hls.shape[0]), y_psim, label = 'psim')
plt.plot(np.linspace(0,step*hls.shape[0],hls.shape[0]), y_hls, label = 'model')
plt.legend()
plt.show()
r2 = r2_score(y_psim, y_hls)
mse = mean_squared_error(y_psim, y_hls)

print('R2:',r2,'\nMSE:',mse,'\n')


    