# -*- coding: utf-8 -*-
"""
Created on Thu Dec 24 14:01:12 2020

@author: roben
"""

import numpy as np

def mapper(x): return x*256+32768

step = 0.001

out = np.array([[32256.000000, 32266.000000],
                [32179.000000, 32191.000000],
                [32103.000000, 32116.000000],
                [32027.000000, 32041.000000],
                [32027.000000, 32027.000000],
                [31952.000000, 31968.000000],
                [31878.000000, 31895.000000],
                [31805.000000, 31824.000000],
                [31734.000000, 31754.000000],
                [31665.000000, 31687.000000],
                [31598.000000, 31621.000000]])

for i in range(1,11):
    print('Time:',step*i)
    V1 = f(out[i-1,0])
    print('V1 =', V1)
    V2 = f(out[i-1,1])
    print('V2 =', V2)
    Vr = V1-V2
    print('Vr =', Vr)
    print('\n')

    