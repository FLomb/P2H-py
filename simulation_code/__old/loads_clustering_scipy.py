# -*- coding: utf-8 -*-
"""
Created on Tue Nov 12 12:45:27 2019

@author: FLomb
"""

import pandas as pd
import numpy as np
import os
import matplotlib.pyplot as plt
import copy
from clustering_functions import rmsd
from scipy.cluster.hierarchy import dendrogram, linkage, fcluster
from scipy.cluster.hierarchy import cophenet
from scipy.spatial.distance import pdist

os.chdir('RAMP')
from utils import load_obj, save_obj
#os.chdir('..')

start = '2016-01-01 00:00:00'
stop = '2016-01-07 23:59:00'
x = pd.date_range(start,stop, freq='T')
x_h = pd.date_range(start,stop, freq='H')
x_day = pd.date_range(start,stop, freq='D')

#%%

def print_clusters(timeSeries, Z, k, plot=False):
    # k Number of clusters I'd like to extract
    results = fcluster(Z, k, criterion='maxclust')

    # check the results
    s = pd.Series(results)
    clusters = s.unique()

    for c in clusters:
        cluster_indeces = s[s==c].index
        print("Cluster %d number of entries %d" % (c, len(cluster_indeces)))
        if plot:
            timeSeries.T.iloc[:,cluster_indeces].plot()
            plt.show()


#%% 

profiles_dict = load_obj('profiles_dict_lombardia')

profiles_subset = profiles_dict.copy()
profiles_subset_backup = copy.deepcopy(profiles_dict)
tot_p = 0
for prov in profiles_subset.keys():
    for arch in profiles_subset[prov].keys():    
       for us in profiles_subset[prov][arch].keys():
           tot_p += len(profiles_subset[prov][arch][us])
profiles_matrix = pd.DataFrame(index=x_h, columns=list(range((tot_p)))).astype('float')
profiles_matrix_orig = pd.DataFrame(index=x_h, columns=list(range((tot_p)))).astype('float')
profiles_matrix_adim = pd.DataFrame(index=x_h, columns=list(range((tot_p)))).astype('float')
  
count = 0       
for prov in profiles_subset.keys():
    for arch in profiles_subset[prov].keys():    
       for us in profiles_subset[prov][arch].keys():
            for p in profiles_subset[prov][arch][us].keys():
                profiles_subset[prov][arch][us][p] = (
                                        pd.DataFrame(profiles_subset[prov][arch][us][p]).set_index(x).resample('H').mean()/
                                        pd.DataFrame(profiles_subset[prov][arch][us][p]).set_index(x).resample('H').mean().sum()
                                        )
                profiles_matrix_adim[count] = profiles_subset[prov][arch][us][p].values[:,0] #pd.DataFrame(profiles_subset_backup[prov][arch][us][p]).set_index(x).resample('H').mean().values[:,0]
                profiles_matrix_orig[count] = pd.DataFrame(profiles_subset_backup[prov][arch][us][p]).set_index(x).resample('H').mean().values[:,0]
                profiles_subset[prov][arch][us][p][profiles_subset[prov][arch][us][p] < 0.001] = 0
                profiles_matrix[count] = profiles_subset[prov][arch][us][p].values[:,0]
                count += 1

os.chdir('..')
#profiles_matrix.to_csv('results/profiles_matrix.csv')
profiles_matrix_orig.to_csv('results/profiles_matrix_orig.csv')
profiles_matrix_adim.to_csv('results/profiles_matrix_adim.csv')

#Z = linkage(profiles_matrix.T, method='complete', metric='cityblock')
#pd.DataFrame(Z).to_csv('results/z_matrix.csv')
#### OR
Z = pd.read_csv('results/z_matrix.csv', index_col=0)

#c, coph_dists = cophenet(Z, pdist(profiles_matrix.T))
#c

#%% 
dendrogram(
    Z,
    truncate_mode='lastp',  # show only the last p merged clusters
    p=12,  # show only the last p merged clusters
    show_leaf_counts=False,  # otherwise numbers in brackets are counts
    leaf_rotation=90.,
    leaf_font_size=12.,
    show_contracted=True,  # to get a distribution impression in truncated branches
)
plt.show()

k = 5
print_clusters(profiles_matrix, Z, k, plot=False)
results = fcluster(Z, k, criterion='maxclust')


#%%
fig, (ax1, ax2, ax3, ax4, ax5) = plt.subplots(5,1, figsize=(8,8), sharex='col')
ax1.plot(profiles_matrix_orig.iloc[:,results==1].sum(axis=1), alpha=1, color='b')
ax2.plot(profiles_matrix_orig.iloc[:,results==2].sum(axis=1), color='r')
ax3.plot(profiles_matrix_orig.iloc[:,results==3].sum(axis=1), color='g')
ax4.plot(profiles_matrix_orig.iloc[:,results==4].sum(axis=1), color='orange')
ax5.plot(profiles_matrix_orig.iloc[:,results==5].sum(axis=1), color='purple')

#%%

for i in range(1,6):
    profiles_matrix_orig.iloc[:,results==i].to_csv('results/Lombardia_cluster_%d.csv' %i)