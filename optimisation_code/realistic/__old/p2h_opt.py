# -*- coding: utf-8 -*-
"""
Created on Wed Nov 13 11:56:13 2019

@author: FLomb
"""

import pandas as pd
import numpy as np
import math
import os
import copy
import calliope

from obj_utils import load_obj, save_obj
from calliope_process import netcdf_to_data, p2h_plot, profile_dict_to_matrix

calliope.set_log_verbosity('ERROR') #sets the level of verbosity of Calliope's operations

#%% 
# Auxiliary functions and objects
###

start = '2015-01-01 00:00:00'
stop = '2015-01-07 23:59:00'
x = pd.date_range(start,stop, freq='T')
x_h = pd.date_range(start,stop, freq='H')
x_h_year = pd.date_range(start,'2015-12-31 23:00:00', freq='H')

administrative_units = pd.read_csv('auxiliary_data/administrative_units.csv', sep=',')
#administrative_units = administrative_units[administrative_units['region'] == 'Lombardia']
provinces = administrative_units['province'].to_list()
T_amb = pd.read_csv('auxiliary_data/ambient_temperatures.csv', sep=';')[361:].astype('float')#.set_index(x_h_year)
T_amb.loc[-1] = T_amb.iloc[8759,:]
T_amb.sort_index(inplace=True)
T_amb = T_amb.drop(8759, axis=0).set_index(x_h_year)
pv_regions = pd.read_csv('auxiliary_data/pv_2016.csv', sep=';').drop('time', axis=1).set_index(x_h_year)
#pv_regions.loc[-1] = pv_regions.loc[8759] 
#pv_regions.sort_index(inplace=True)
#pv_regions = pv_regions.drop(8759, axis=0).set_index(x_h_year)

cop = pd.DataFrame(index=x_h_year, columns=provinces).astype('float')
pv = pd.DataFrame(index=x_h_year, columns=provinces).astype('float')
for prov in provinces:
    for t in cop.index:
        cop[prov].loc[t] = 13.905 - 0.363*(55-T_amb[prov].loc[t]) + 0.003*math.pow((55-T_amb[prov].loc[t]),2)
    pv[prov] = pv_regions['Lombardia']

pv_ready = pv.to_frame()
pv_ready.columns = ['dwelling']
pv_ready.to_csv('timeseries_data/solar_resource.csv', sep=',')

#pv_ready_clust = pv.mean(axis=1).to_frame()
#pv_ready_clust.columns = ['clu_1']
#clust_col = ['clu_1', 'clu_2', 'clu_3', 'clu_4', 'clu_5']
#for col in clust_col[1:]:
#    pv_ready_clust[col] = pv_ready_clust['clu_1']
#pv_ready_clust.to_csv('timeseries_data/solar_resource_clust.csv', sep=',')
#
#cop_ready = cop.mean(axis=1).to_frame()
#cop_ready.columns = ['dwelling']
#cop_ready.to_csv('timeseries_data/cop_dhw.csv', sep=',')

#cop_ready_clust = cop_ready
#cop_ready_clust.columns = ['clu_1']
#clust_col = ['clu_1', 'clu_2', 'clu_3', 'clu_4', 'clu_5']
#for col in clust_col[1:]:
#    cop_ready_clust[col] = cop_ready_clust['clu_1']
#cop_ready_clust.to_csv('timeseries_data/cop_clust.csv', sep=',')

#%%
# Definition of load profiles
###

profiles_dict = load_obj('profiles_dict_lombardia_4k')
profiles_matrix, arch_matrix = profile_dict_to_matrix(copy.deepcopy(profiles_dict)) 
profiles_matrix = -profiles_matrix/1e3

#%%
# Individual Calliope optimisations and saving

p2h_individual_dict = {}

for us in [list(profiles_matrix.columns)[0]]:
    profiles_matrix[us].to_csv('timeseries_data/demand_dhw.csv', sep=',', header=['dwelling'])
    model = calliope.Model('model.yaml')
    model.run(build_only=True)
    model.backend.update_param('energy_cap_equals', {'dwelling::hp_dhw' : arch_matrix[us].loc['hp_size']})
    model.backend.update_param('energy_cap_equals', {'dwelling::tes_dhw' : arch_matrix[us].loc['hp_size']})
    model.backend.update_param('storage_cap_equals', {'dwelling::tes_dhw' : arch_matrix[us].loc['tes_size']})
    p2h_individual_dict[0] = model.run()
    model.to_netcdf('NetCDFs/results_%d.nc' %us) 

for us in list(profiles_matrix.columns)[3667:]:
    model.backend.update_param('energy_cap_equals', {'dwelling::hp_dhw' : arch_matrix[us].loc['hp_size']})
    model.backend.update_param('energy_cap_equals', {'dwelling::tes_dhw' : arch_matrix[us].loc['hp_size']})
    model.backend.update_param('storage_cap_equals', {'dwelling::tes_dhw' : arch_matrix[us].loc['tes_size']})
    for t in x_h:
        model.backend.update_param('resource', {('dwelling::demand_dhw',t) : profiles_matrix[us].loc[t]})
        model._model_data.resource.loc[{'loc_techs_finite_resource':'dwelling::demand_dhw', 'timesteps':t}] = profiles_matrix[us].loc[t]
    p2h_individual_dict[us] = model.backend.rerun()
    for v in p2h_individual_dict[us]._model_data.data_vars:
        if (isinstance(p2h_individual_dict[us]._model_data[v].values.flatten()[0],(np.bool_,bool))):
            p2h_individual_dict[us]._model_data[v] = p2h_individual_dict[us]._model_data[v].astype(float)
    p2h_individual_dict[us].to_netcdf('NetCDFs/results_%d.nc' %us)
    
#%%
# Importing and processing results
###
p2h_dict = {}
for us in list(profiles_matrix.columns):
    try:
        p2h_dict[us] = netcdf_to_data(calliope.read_netcdf('NetCDFs/results_%d.nc' %us))
        print('done %d' %us)
    except:
        break
# save_obj(p2h_dict,'p2h_dict_realistic')       

#%%
p2h_tot = pd.DataFrame(index=p2h_dict[0].index, columns=p2h_dict[0].columns).astype('float').fillna(0)
for us in p2h_dict.keys():
    for col in p2h_dict[us].columns:
        p2h_tot[col] += p2h_dict[us][col]

p2h_plot(p2h_tot,start,stop)
#(-p2h_tot['dhw_load']).to_csv('results/demand_dhw_tot.csv')
#