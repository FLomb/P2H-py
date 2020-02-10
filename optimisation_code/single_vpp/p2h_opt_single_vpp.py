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
from summary_plots import choropleth_map_nrmse, choropleth_map_energy

calliope.set_log_verbosity('ERROR') #sets the level of verbosity of Calliope's operations

#%%
def nrmse(vpp, tot_real):
    
    n = len(vpp.index)
    sq_diff_hp_con = 0
    sq_diff_tes_soc = 0
    
    for i in range(n):
        sq_diff_hp_con += math.pow((vpp['en_con_hp'].iloc[i] - tot_real['en_con_hp'].iloc[i]),2)
        sq_diff_tes_soc += math.pow((vpp['soc_tes'].iloc[i] - tot_real['soc_tes'].iloc[i]),2)
    
    nrmse_hp_con = math.sqrt(sq_diff_hp_con/n)/(tot_real['en_con_hp'].max() - tot_real['en_con_hp'].min())
    nrmse_tes_soc = math.sqrt(sq_diff_tes_soc/n)/(tot_real['soc_tes'].max() - tot_real['soc_tes'].min())

    return(nrmse_hp_con, nrmse_tes_soc)

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
reg_dict = {'Piemonte':'R1',"Valle D'Aosta":'R2','Lombardia':'R3','Trentino Alto Adige':'R4',
            'Veneto':'R5','Friuli Venezia Giulia':'R6','Liguria':'R7','Emilia-Romagna':'R8',
            'Toscana':'R9','Umbria':'R10','Marche':'R11','Lazio':'R12','Abruzzo':'R13',
            'Campania':'R14','Molise':'R15','Puglia':'R16','Basilicata':'R17','Calabria':'R18',
            'Sicilia':'SICI','Sardegna':'SARD'}
cop_regions = pd.read_csv('processed_data/cop_dhw_regions.csv', index_col=0)
pv_regions = pd.read_csv('processed_data/solar_resource_regions.csv', index_col=0)

ordered_columns = ['Piemonte',"Valle D'Aosta",'Lombardia','Trentino Alto Adige','Veneto','Friuli Venezia Giulia',
                    'Liguria','Emilia-Romagna', 'Toscana','Umbria','Marche','Lazio','Abruzzo','Campania','Molise',
                    'Puglia','Basilicata','Calabria', 'Sicilia','Sardegna']
calliope_columns = ['R1','R2','R3','R4','R5','R6','R7','R8','R9','R10',
                    'R11','R12','R13','R14','R15','R16','R17','R18','SICI','SARD']
#%%
# Definition of load profiles
###

profiles_dict = load_obj('profiles_dict_Italy_50k')
regional_prof_matr = {}
regional_arch_matr = {}
regions = list(set(administrative_units['region']))
for reg in regions:
    regional_prof_matr[reg], regional_arch_matr[reg] = profile_dict_to_matrix(dict((k, profiles_dict[k]) for k in administrative_units[administrative_units['region'] == reg]['province'])) 
    regional_prof_matr[reg] = -regional_prof_matr[reg]/1e3

# demand_regions = pd.DataFrame(index=x_h_year, columns=list(reg_dict.values())).astype('float')
# for reg in reg_dict.keys():
#     demand_regions[reg_dict[reg]] = regional_prof_matr[reg].sum(axis=1)
#%% 
# Calliopisation of data
###
    
# cop_regions = cop_regions[ordered_columns]
# cop_regions.columns = calliope_columns
# pv_regions = pv_regions[ordered_columns]
# pv_regions.columns = calliope_columns
# demand_regions.to_csv('timeseries_data/demand_dhw.csv')
# cop_regions.to_csv('timeseries_data/cop_dhw.csv')
# pv_regions.to_csv('timeseries_data/solar_resource.csv')

#%%
# Calliope VPP run
###

# model = calliope.Model('model.yaml')
# model.run(build_only=True)

# for reg in reg_dict.keys():
#     subset_users = len(regional_prof_matr[reg].columns)
    
#     model.backend.update_param('energy_cap_equals', {'%s::hp_dhw' %reg_dict[reg] : subset_users*regional_arch_matr[reg][0:subset_users].loc['hp_size'].mean()})
#     model.backend.update_param('energy_cap_equals', {'%s::tes_dhw' %reg_dict[reg] : subset_users*regional_arch_matr[reg][0:subset_users].loc['hp_size'].mean()})
#     model.backend.update_param('storage_cap_equals', {'%s::tes_dhw' %reg_dict[reg] : subset_users*regional_arch_matr[reg][0:subset_users].loc['tes_size'].mean()})
#     model.backend.update_param('energy_cap_equals', {'%s::pv_rooftop' %reg_dict[reg] : subset_users*2})
#     model.backend.update_param('energy_cap_equals', {'%s::grid' %reg_dict[reg] : subset_users*100})
#     for t in x_h:
#         model.backend.update_param('resource', {('%s::demand_dhw' %reg_dict[reg],t) : regional_prof_matr[reg].iloc[:,0:subset_users].sum(axis=1).loc[t]})
#         model._model_data.resource.loc[{'loc_techs_finite_resource':'%s::demand_dhw' %reg_dict[reg], 'timesteps':t}] = regional_prof_matr[reg].iloc[:,0:subset_users].mean(axis=1).loc[t]
    
# model_vpp = model.backend.rerun()
    
# model_vpp.to_netcdf('NetCDFs/results_0.nc')

#%%
# Processing results
###

model_vpp = calliope.read_netcdf('NetCDFs/results_0.nc')
p2h_vpp_dict = {}
for reg in reg_dict.keys():
    p2h_vpp_dict[reg_dict[reg]] = netcdf_to_data(model_vpp,reg_dict[reg])

# p2h_plot(p2h_vpp_dict['R11'],start,stop)

#%% Importing realistic results
# p2h_tot_dict = load_obj('regional_p2h_opt_dict_50k')       
# p2h_plot(p2h_tot_dict['Marche'],start,stop)
     
#%% Comparison
# regional_p2h_nrmse = {}

# for reg in regions:
#     regional_p2h_nrmse[reg] = nrmse(p2h_vpp_dict[reg_dict[reg]],p2h_tot_dict[reg])

# choropleth_map_nrmse(regional_p2h_nrmse)
# choropleth_map_energy(p2h_vpp_dict,p2h_tot_dict)

#%%
# Exporting caps for 20-region model
###
hp_cap = 100*model_vpp.get_formatted_array('energy_cap').loc[{'techs':'hp_dhw'}].to_pandas().T
tes_cap = 100*model_vpp.get_formatted_array('storage_cap').loc[{'techs':'tes_dhw'}].to_pandas().T
pd.DataFrame([hp_cap,tes_cap]).T.to_csv('processed_data/p2h_size.csv')
