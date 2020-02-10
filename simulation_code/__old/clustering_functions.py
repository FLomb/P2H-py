# -*- coding: utf-8 -*-
"""
Created on Tue Nov 12 09:40:31 2019

@author: FLomb
"""

import pandas as pd
import numpy as np
import math

#%% 
# Clustering functions
###

def rmsd(prof_1, prof_2):
    
    diff_sq = 0
    for t in range(len(prof_1)):
        diff_sq += (prof_1[t] - prof_2[t])**2
    
    rmsd = math.sqrt(diff_sq/len(prof_1))
    
    return(rmsd)