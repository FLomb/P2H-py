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

from utils import load_obj, save_obj, netcdf_to_data, profile_dict_to_matrix
from calliope_process import p2h_plot
from summary_plots import choropleth_map_nrmse, choropleth_map_energy

calliope.set_log_verbosity('ERROR') #sets the level of verbosity of Calliope's operations

#%% 
# Auxiliary functions and objects
###

start = '2015-01-01 00:00:00'
stop = '2015-01-07 23:59:00'
x = pd.date_range(start,stop, freq='T')
x_h = pd.date_range(start,stop, freq='H')
x_h_year = pd.date_range(start,'2015-12-31 23:00:00', freq='H')

administrative_units = pd.read_csv('input_data/administrative_units.csv', sep=',')
provinces = administrative_units['province'].to_list()

#%%
# Definition of load profiles and other timeseries
###

# profiles_dict = load_obj('profiles_dict_Italy_50k')
# regional_prof_matr = {}
# regional_arch_matr = {}
# regions = list(set(administrative_units['region']))
# for reg in regions:
#     regional_prof_matr[reg], regional_arch_matr[reg] = profile_dict_to_matrix(dict((k, profiles_dict[k]) for k in administrative_units[administrative_units['region'] == reg]['province'])) 
#     regional_prof_matr[reg] = -regional_prof_matr[reg]/1e3
# cop_regions = pd.read_csv('cop_dhw_regions.csv')
# pv_regions = pd.read_csv('solar_resource_regions.csv')

#%%
# Individual Calliope optimisations and saving

# regional_p2h_dict = {}

# for reg in regions:
#     regional_p2h_dict[reg] = {}

#     for us in [list(regional_prof_matr[reg].columns)[0]]:
#         regional_prof_matr[reg][us].to_csv('timeseries_data/demand_dhw.csv', sep=',', header=['dwelling'])
#         cop_regions[reg].to_csv('timeseries_data/cop_dhw.csv', sep=',', header=['dwelling'])
#         pv_regions[reg].to_csv('timeseries_data/solar_resource.csv', sep=',', header=['dwelling'])
#         model = calliope.Model('model.yaml')
#         model.run(build_only=True)
#         model.backend.update_param('energy_cap_equals', {'dwelling::hp_dhw' : regional_arch_matr[reg][us].loc['hp_size']})
#         model.backend.update_param('energy_cap_equals', {'dwelling::tes_dhw' : regional_arch_matr[reg][us].loc['hp_size']})
#         model.backend.update_param('storage_cap_equals', {'dwelling::tes_dhw' : regional_arch_matr[reg][us].loc['tes_size']})
#         regional_p2h_dict[reg][0] = model.run()
#         model.to_netcdf('NetCDFs/results_%s_%d.nc' %(reg,us)) 
    
    # for us in list(regional_prof_matr[reg].columns)[1:]:
    #     model.backend.update_param('energy_cap_equals', {'dwelling::hp_dhw' : regional_arch_matr[reg][us].loc['hp_size']})
    #     model.backend.update_param('energy_cap_equals', {'dwelling::tes_dhw' : regional_arch_matr[reg][us].loc['hp_size']})
    #     model.backend.update_param('storage_cap_equals', {'dwelling::tes_dhw' : regional_arch_matr[reg][us].loc['tes_size']})
    #     for t in x_h:
    #         model.backend.update_param('resource', {('dwelling::demand_dhw',t) : regional_prof_matr[reg][us].loc[t]})
    #         model._model_data.resource.loc[{'loc_techs_finite_resource':'dwelling::demand_dhw', 'timesteps':t}] = regional_prof_matr[reg][us].loc[t]
    #     regional_p2h_dict[reg][us] = model.backend.rerun()
    #     for v in regional_p2h_dict[reg][us]._model_data.data_vars:
    #         if (isinstance(regional_p2h_dict[reg][us]._model_data[v].values.flatten()[0],(np.bool_,bool))):
    #             regional_p2h_dict[reg][us]._model_data[v] = regional_p2h_dict[reg][us]._model_data[v].astype(float)
    #     regional_p2h_dict[reg][us].to_netcdf('NetCDFs/results_%s_%d.nc' %(reg,us))
        
#%%
# Importing and processing results
###
# p2h_dict = {}
# for reg in regions:
#     p2h_dict[reg] = {}
#     for us in list(regional_prof_matr[reg].columns):
#         try:
#             p2h_dict[reg][us] = netcdf_to_data(calliope.read_netcdf('NetCDFs/results_%s_%d.nc' %(reg,us)))
#             print('done %d' %us)
#         except:
#             break
# save_obj(p2h_dict,'p2h_dict_realistic')       
p2h_dict = load_obj('p2h_dict_realistic')       

#%%
# p2h_tot_dict = {}
# for reg in p2h_dict.keys():
#     p2h_tot = pd.DataFrame(index=p2h_dict['Lombardia'][0].index, columns=p2h_dict['Lombardia'][0].columns).astype('float').fillna(0)
#     for us in p2h_dict[reg].keys():
#         for col in p2h_dict[reg][us].columns:
#             p2h_tot[col] += p2h_dict[reg][us][col]
#     p2h_tot_dict[reg] = p2h_tot

# save_obj(p2h_tot_dict, 'regional_p2h_opt_dict_50k')
# p2h_tot_dict = load_obj('regional_p2h_opt_dict_50k')
# p2h_plot(p2h_tot_dict['Sardegna'],start,stop)
#(-p2h_tot['dhw_load']).to_csv('results/demand_dhw_tot.csv')

# choropleth_map_nrmse(regional_p2h_nrmse)
# choropleth_map_nrmse(regional_p2h_nrmse_smart)
