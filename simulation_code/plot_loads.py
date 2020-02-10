# -*- coding: utf-8 -*-
"""
Created on Thu Jan  2 15:03:11 2020

@author: FLomb
"""
import pandas as pd
import os
import math
import matplotlib.pyplot as plt

from utils import load_obj, save_obj, profile_dict_to_matrix

#%%
def profile_dict_to_matrix(profiles_dict):
    tot_p = 0
    for prov in profiles_dict.keys():
        for arch in profiles_dict[prov].keys():    
           for us in profiles_dict[prov][arch].keys():
               tot_p += len(profiles_dict[prov][arch][us])
               
    profiles_matrix = pd.DataFrame(index=x_h, columns=list(range((tot_p)))).astype('float')
    arch_matrix = pd.DataFrame(index=['hp_size','tes_size'], columns=list(range((tot_p)))).astype('float')
    arch_to_hp_size = {'single_family': 2.2, 'double_family': 2.2 , 'multi_family': 1.8 , 'apartment_block': 1.8 }
    arch_to_tes_size = {'single_family': 500, 'double_family': 300 , 'multi_family': 200 , 'apartment_block': 200 }

    count = 0       
    for prov in profiles_dict.keys():
        for arch in profiles_dict[prov].keys():    
           for us in profiles_dict[prov][arch].keys():
                for p in profiles_dict[prov][arch][us].keys():
                    profiles_dict[prov][arch][us][p] = (
                                            pd.DataFrame(profiles_dict[prov][arch][us][p]).set_index(x).resample('H').mean().astype('float')
                                            )
                    profiles_dict[prov][arch][us][p][profiles_dict[prov][arch][us][p] < 0.1] = 0                    
                    profiles_matrix[count] = profiles_dict[prov][arch][us][p].values[:,0]
                    arch_matrix[count].loc['hp_size'] = arch_to_hp_size[arch]
                    arch_matrix[count].loc['tes_size'] = arch_to_tes_size[arch]*4.186*40/3600
                    count += 1
    return(profiles_matrix, arch_matrix)

#%%
start = '2015-01-01 00:00:00'
stop = '2015-01-07 23:59:00'
x = pd.date_range(start,stop, freq='T')
x_h = pd.date_range(start,stop, freq='H')
x_h_year = pd.date_range(start,'2015-12-31 23:00:00', freq='H')

administrative_units = pd.read_csv('input_data/administrative_units.csv', sep=',')
provinces = administrative_units['province'].to_list()

profiles_dict = load_obj('profiles_dict_Italy_50k')
regional_prof_matr = {}
regional_arch_matr = {}
regions = list(set(administrative_units['region']))
for reg in regions:
    regional_prof_matr[reg], regional_arch_matr[reg] = profile_dict_to_matrix(dict((k, profiles_dict[k]) for k in administrative_units[administrative_units['region'] == reg]['province'])) 
    regional_prof_matr[reg] = -regional_prof_matr[reg]/1e3

#%%
    
fig = plt.figure(figsize=(10,5))
for p in regional_prof_matr['Toscana'].columns:
    plt.plot(-regional_prof_matr['Toscana'][p], alpha=0.25)
# for pp in regional_prof_matr['Lombardia'].columns:
#     plt.plot(-regional_prof_matr['Lombardia'][pp], color='b', alpha=0.1)
plt.margins(0)
plt.ylabel('Hourly DHW demand (kWh)')
plt.xlabel('Time (UTC)')