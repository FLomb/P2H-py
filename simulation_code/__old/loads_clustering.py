# -*- coding: utf-8 -*-
"""
Created on Tue Nov 12 09:37:57 2019

@author: FLomb
"""
import pandas as pd
import numpy as np
import os
import matplotlib.pyplot as plt
from clustering_functions import rmsd
from scipy.cluster.hierarchy import dendrogram, linkage

os.chdir('RAMP')
from utils import load_obj, save_obj
#os.chdir('..')

start = '2016-01-01 00:00:00'
stop = '2016-01-07 23:59:00'
x = pd.date_range(start,stop, freq='T')
x_day = pd.date_range(start,stop, freq='D')

#%% 

profiles_dict = load_obj('profiles_dict_lombardia')

profiles_subset = profiles_dict['VARESE']['single_family']['U1']
for p in profiles_subset.keys():
    profiles_subset[p] = (
                            pd.DataFrame(profiles_subset[p]).set_index(x).resample('H').mean()/
                            pd.DataFrame(profiles_subset[p]).set_index(x).resample('H').mean().sum()
                            )
    profiles_subset[p][profiles_subset[p] < 0.001] = 0

overall_keys = []
for p in (str(r) for r in (range(129,170))):#profiles_subset.keys():
    diff_frame = pd.DataFrame(index=range(len(profiles_subset.keys())), columns=['key','rmsd']).astype('float')
    for q in pd.DataFrame(profiles_subset.keys())[pd.DataFrame(profiles_subset.keys()) != p].dropna().values[:,0].tolist():
        diff_frame['rmsd'].loc[int(q)] = rmsd(profiles_subset[p].values[:,0],profiles_subset[q].values[:,0])
        diff_frame['key'].loc[int(q)] = q
    min_rmsd = diff_frame['key'].loc[diff_frame['rmsd'].idxmin()]
    overall_keys.append(min_rmsd)
    
    
plt.plot(profiles_subset['1'])
plt.plot(profiles_subset['10'], label='10')
plt.plot(profiles_subset['100'])
plt.legend()