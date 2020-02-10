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

from p2h_functions_std import p2h_fixedspeed_realistic, p2h_fixedspeed_vpp, p2h_varspeed_realistic, p2h_varspeed_vpp
from p2h_functions_smart import p2h_varspeedsmart_realistic, p2h_varspeedsmart_vpp
from plots import comparative_plot, single_plot, single_plot_threeus

os.chdir('RAMP')
from utils import load_obj, save_obj
os.chdir('..')

#%% 
# Import objects
###

pv_series = pd.read_csv('energy_timeseries/pv_2016.csv', sep=';', index_col=0)
administrative_units = pd.read_csv('RAMP/time_series/administrative_units.csv', sep=';')
provinces = administrative_units['province'].to_list()
archetypes = pd.read_csv('RAMP/time_series/building_archetypes.csv', sep=';', index_col=0)
n_dict = {'U1': 0.253, 'U2': 0.263, 'U3': 0.484}

profiles_clust_dict = {}
cluster_share = {}
for i in range(1,6):
    profiles_clust_dict[i] = pd.read_csv('results/Lombardia_cluster_%d.csv' %i)
    cluster_share[i] = len(profiles_clust_dict[i].columns)/sum(len(profiles_clust_dict[v].columns) for v in profiles_clust_dict.keys())

os.chdir('RAMP')
profiles_dict = load_obj('profiles_dict_lombardia')

#%%
##Thermodynamic system technical specifics
#

system_spec_vs = {}

system_spec_vs['tank_size'] = 80 # litres
system_spec_vs['T_hp_supply'] = 55 # °C
system_spec_vs['T_min_dhw'] = 40 # °C
system_spec_vs['T_ref_gw'] = 15 # °C
system_spec_vs['q_loss_tes'] = 0.01 # fraction of SOC per timestep
system_spec_vs['tes_initial_soc'] = 0 # fraction of SOC max
system_spec_vs['tes_max_soc'] = 4.186*system_spec_vs['tank_size']*(system_spec_vs['T_hp_supply'] - system_spec_vs['T_min_dhw'])/3600 # kWh
system_spec_vs['hp_nominal_el_power'] = 0.75 # kW
system_spec_vs['hp_minimum_el_power'] = 0.1 # kW
system_spec_vs['hp_inverter_reg'] = (system_spec_vs['hp_minimum_el_power'] - system_spec_vs['hp_nominal_el_power'])/(system_spec_vs['tank_size']*4.186*(system_spec_vs['T_hp_supply']-system_spec_vs['T_ref_gw'])/3600) # HP output to SOC ratio


#%%
#tot_p2h_vs_sm = load_obj('tot_p2h_vs_sm_lombardia')

#%% Generating P2H simulations

administrative_units = administrative_units[administrative_units['region'] == 'Lombardia']

tot_p2h_vs_sm = p2h_varspeedsmart_realistic(administrative_units, archetypes, n_dict, system_spec_vs, profiles_dict, pv_series, scale_factor=1e2)

vpp_p2h_dict = {}
for i in range(1,6):
    vpp_p2h_dict[i] = p2h_varspeedsmart_vpp(administrative_units, archetypes, n_dict, system_spec_vs, tot_p2h_vs_sm, pv_series, single_user=False, new_load=profiles_clust_dict[i].sum(axis=1).values, scale_factor=(1e2*(1/cluster_share[i])))

vpp_p2h_vs_sm_cum = copy.deepcopy(vpp_p2h_dict[1])
for i in range(2,6):
    vpp_p2h_vs_sm_cum += vpp_p2h_dict[i]

vpp_p2h_vs_sm = p2h_varspeedsmart_vpp(administrative_units, archetypes, n_dict, system_spec_vs, tot_p2h_vs_sm, pv_series, single_user=False, scale_factor=1e2)

#%%
single_plot(tot_p2h_vs_sm)

#for i in range(1,6):
#    single_plot(vpp_p2h_dict[i])

comparative_plot(tot_p2h_vs_sm, vpp_p2h_vs_sm)
#comparative_plot(tot_p2h_vs_sm, vpp_p2h_vs_sm_cum)

#%%
save_obj(tot_p2h_vs_sm, 'tot_p2h_vs_sm_lombardia')

#%%
#tot_p = np.zeros(10080)
#for prov in profiles_dict.keys():
#    for arch in profiles_dict[prov].keys():    
#       for us in profiles_dict[prov][arch].keys():
#           for k in profiles_dict[prov][arch][us].values():
#               tot_p = tot_p + k
#tot_p = pd.DataFrame(tot_p).set_index(x).resample('H').mean().values[:,0]/1e3
#
#tot_p_clu = np.zeros(168)
#for clu in profiles_clust_dict.values():
#    tot_p_clu = tot_p_clu + clu.sum(axis=1).values/1e3
##tot_p_clu = pd.DataFrame(tot_p_clu).set_index(x).resample('H').mean().values[:,0]/1e3
