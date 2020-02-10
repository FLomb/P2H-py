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

from scipy.cluster.hierarchy import dendrogram, linkage, fcluster
from scipy.cluster.hierarchy import cophenet
from scipy.spatial.distance import pdist

from obj_utils import load_obj, save_obj
from calliope_process import profile_dict_to_matrix

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

profiles_dict = load_obj('profiles_dict_lombardia_4k')

profiles_matrix_u1 = pd.DataFrame(index=x_h).astype('float')
profiles_matrix_u2 = pd.DataFrame(index=x_h).astype('float')
profiles_matrix_u3 = pd.DataFrame(index=x_h).astype('float')

count = 0
profiles_per_user_dict = {}
for prov in profiles_dict.keys():
    for arch in profiles_dict[prov].keys():
        for us in profiles_dict[prov][arch].keys():
            for k in profiles_dict[prov][arch][us].values():
                if us == 'U1':
                    profiles_matrix_u1 = pd.concat((profiles_matrix_u1,pd.DataFrame(k).set_index(x).resample('H').mean()), axis=1)
                elif us == 'U2':
                    profiles_matrix_u2 = pd.concat((profiles_matrix_u2,pd.DataFrame(k).set_index(x).resample('H').mean()), axis=1)
                else:
                    profiles_matrix_u3 = pd.concat((profiles_matrix_u3,pd.DataFrame(k).set_index(x).resample('H').mean()), axis=1)
                count += 1

profiles_matrix, arch_matrix = profile_dict_to_matrix(copy.deepcopy(profiles_dict))
profiles_matrix = -profiles_matrix

#profiles_subset = -profiles_matrix.iloc[:,0:4079]/1e3
#profiles_subset_orig = copy.deepcopy(profiles_subset)
#profiles_subset_adim = copy.deepcopy(profiles_subset)
#
#for col in profiles_subset.columns:
#    profiles_subset_adim[col] = profiles_subset[col]/profiles_subset[col].sum()
#    profiles_subset_adim[col][profiles_subset_adim[col] < 0.01] = 0

#Z = linkage(profiles_subset_adim.T, method='complete', metric='cityblock')
##pd.DataFrame(Z).to_csv('results/z_matrix.csv')
##### OR
##Z = pd.read_csv('results/z_matrix.csv', index_col=0)
#
#c, coph_dists = cophenet(Z, pdist(profiles_subset_adim.T))
#c

#%% 
#dendrogram(
#    Z,
#    truncate_mode='lastp',  # show only the last p merged clusters
#    p=12,  # show only the last p merged clusters
#    show_leaf_counts=False,  # otherwise numbers in brackets are counts
#    leaf_rotation=90.,
#    leaf_font_size=12.,
#    show_contracted=True,  # to get a distribution impression in truncated branches
#)
#plt.show()
#
#k = 5
#print_clusters(profiles_subset, Z, k, plot=False)
#results = fcluster(Z, k, criterion='maxclust')


#%%
#fig, (ax1, ax2, ax3, ax4, ax5) = plt.subplots(5,1, figsize=(8,8), sharex='col')
#ax1.plot(profiles_subset_orig.iloc[:,results==1].sum(axis=1), alpha=1, color='b')
#ax2.plot(profiles_subset_orig.iloc[:,results==2].sum(axis=1), color='r')
#ax3.plot(profiles_subset_orig.iloc[:,results==3].sum(axis=1), color='g')
#ax4.plot(profiles_subset_orig.iloc[:,results==4].sum(axis=1), color='orange')
#ax5.plot(profiles_subset_orig.iloc[:,results==5].sum(axis=1), color='purple')
#for ax in [ax1, ax2, ax3, ax4, ax5]:
#    ax.set_ylabel('DHW load (kW)')
#    
#arch_matrix.iloc[:,results==1]
#arch_matrix.iloc[:,results==2]
#arch_matrix.iloc[:,results==3]
#arch_matrix.iloc[:,results==4]

#%%

fig, (ax1, ax2, ax3, ax4) = plt.subplots(4,1, figsize=(8,8), sharex='col')
ax1.plot(profiles_matrix_u1.sum(axis=1), alpha=1, color='b')
ax2.plot(profiles_matrix_u2.sum(axis=1), color='r')
ax3.plot(profiles_matrix_u3.sum(axis=1), color='g')
#ax4.plot(-profiles_matrix.sum(axis=1), color='purple')
for ax in [ax1, ax2, ax3, ax4, ax5]:
    ax.set_ylabel('DHW load (kW)')
#    
#%%
dhw_demand_clusters = pd.DataFrame(index=profiles_subset.index, columns=['clu_1', 'clu_2', 'clu_3', 'clu_4'])#, 'clu_5'])
for i in range(1,4):
    dhw_demand_clusters.iloc[:,i-1] = profiles_subset_orig.iloc[:,results==i].sum(axis=1)
(-dhw_demand_clusters).to_csv('results/demand_dhw_clusters.csv')

#cop = pd.read_csv('timeseries_data/cop_dhw.csv', index_col=0)
#pv = pd.read_csv('timeseries_data/solar_resource.csv', index_col=0)
#for i in range(1,5):
#    cop = pd.concat([cop,cop.iloc[:,0]], axis=1)
#    pv = pd.concat([pv,pv.iloc[:,0]], axis=1)
#cop.columns = ['clu_1', 'clu_2', 'clu_3', 'clu_4', 'clu_5']
#pv.columns = ['clu_1', 'clu_2', 'clu_3', 'clu_4', 'clu_5']
#cop.to_csv('results/cop_clusters.csv')
#pv.to_csv('results/pv_clusters.csv')

#%%
'''
clusters = pd.DataFrame(index=pv.columns, columns=['pv_cap', 'hp_cap', 'tes_cap']).astype('float').fillna(0)
count = 1
for i in clusters.index:
    clusters.loc[i]['pv_cap'] = 2*len(profiles_subset_orig.iloc[:,results==count].columns)
    clusters.loc[i]['hp_cap'] = 2.2*len(profiles_subset_orig.iloc[:,results==count].columns)
    clusters.loc[i]['tes_cap'] = 3.7*len(profiles_subset_orig.iloc[:,results==count].columns)
    count += 1

#%%
cluster_dict = {}
for i in range(1,6):
    cluster_dict[i] = copy.deepcopy(profiles_subset_orig.iloc[:,results==i])
    cluster_dict[i].columns = ['0']*len(cluster_dict[i].columns)
    
color_list = (
        ['b']*len(cluster_dict[1]) +
        ['r']*len(cluster_dict[2]) +
        ['g']*len(cluster_dict[3]) +
        ['orange']*len(cluster_dict[4]) +
        ['purple']*len(cluster_dict[5])
        )

#%%

fig, ax1 = plt.subplots(figsize=(10,6))
ax1.stackplot(profiles_subset_orig.index, 
              cluster_dict[1].sum(axis=1),
              cluster_dict[2].sum(axis=1),
              cluster_dict[3].sum(axis=1),
              cluster_dict[4].sum(axis=1),
              cluster_dict[5].sum(axis=1),
              colors=['b','r','g','orange','purple'], alpha=0.6)
ax1.set_ylim(ymax=3000)
ax1.margins(0)
plt.show()
'''