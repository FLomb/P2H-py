# -*- coding: utf-8 -*-
"""
Created on Fri Nov  1 10:41:59 2019

@author: FLomb
"""

import pandas as pd
import numpy as np
import math
import os

from p2h_functions_std import p2h_fixedspeed_realistic, p2h_fixedspeed_vpp, p2h_varspeed_realistic, p2h_varspeed_vpp
from p2h_functions_smart import p2h_varspeedsmart_realistic, p2h_varspeedsmart_vpp
from plots import comparative_plot, single_plot, single_plot_threeus
from calliope_process import p2h_to_data, p2h_plot

os.chdir('RAMP')
from utils import load_obj, save_obj
os.chdir('..')

#%% 
# Import libraries and objects
###
start = '2015-01-01 00:00:00'
stop = '2015-01-07 23:59:00'
x = pd.date_range(start,stop, freq='T')
x_h = pd.date_range(start,stop, freq='H')
x_h_year = pd.date_range(start,'2015-12-31 23:00:00', freq='H')

administrative_units = pd.read_csv('RAMP/time_series/administrative_units.csv', sep=';')
administrative_units = administrative_units[administrative_units['region'] == 'Lombardia']
provinces = administrative_units['province'].to_list()
archetypes = pd.read_csv('RAMP/time_series/building_archetypes.csv', sep=';', index_col=0)
n_dict = {'U1': 0.253, 'U2': 0.263, 'U3': 0.484}
pv_regions = pd.read_csv('energy_timeseries/pv_2016.csv', sep=';').drop('time', axis=1)#, index_col=0)
pv_regions.loc[-1] = pv_regions.loc[8759] 
pv_regions.sort_index(inplace=True)
pv_regions = pv_regions.drop(8759, axis=0).set_index(x_h_year)
cop_dhw = pd.read_csv('energy_timeseries/cop_dhw.csv', sep=',').drop('Unnamed: 0', axis=1)
cop_dhw.loc[-1] = cop_dhw.loc[8759] 
cop_dhw.sort_index(inplace=True)
cop_dhw = cop_dhw.drop(8759, axis=0).set_index(x_h_year)

os.chdir('RAMP')
profiles_dict = load_obj('profiles_dict_lombardia_4k')
profile_avg_dict = {'U1': np.zeros(10080), 'U2': np.zeros(10080), 'U3': np.zeros(10080)}

for prov in profiles_dict.keys():
    for arch in profiles_dict[prov].keys():
        for us in profiles_dict[prov][arch].keys():
            for k in profiles_dict[prov][arch][us].keys():
                profile_avg_dict[us] += profiles_dict[prov][arch][us][k]

#%%
##Thermodynamic system technical specifics
#

system_spec = {} # Daikin Monoblocco EKHH2E-AV3 + 2E200AV3

system_spec['tank_size'] = 200 # litres
system_spec['T_hp_supply'] = 55 # °C
system_spec['T_ref_gw'] = 15 # °C
system_spec['T_min_dhw'] = 40 # °C
system_spec['q_loss_tes'] = 0.01 # fraction of SOC per timestep
system_spec['tes_initial_soc'] = 0.375 # fraction of SOC max
system_spec['tes_max_soc'] = 4.186*system_spec['tank_size']*(system_spec['T_hp_supply'] - system_spec['T_ref_gw'])/3600 # kWh
system_spec['tes_min_soc'] = 4.186*system_spec['tank_size']*(system_spec['T_hp_supply'] - system_spec['T_min_dhw'])/3600 # kWh
system_spec['hp_nominal_th_power'] = 1.82 # kW thermal

#system_spec_vs = {}
#
#system_spec_vs['tank_size'] = 80 # litres
#system_spec_vs['T_hp_supply'] = 55 # °C
#system_spec_vs['T_ref_gw'] = 15 # °C
#system_spec_vs['T_min_dhw'] = 40 # °C
#system_spec_vs['q_loss_tes'] = 0.01 # fraction of SOC per timestep
#system_spec_vs['tes_initial_soc'] = 0 # fraction of SOC max
#system_spec_vs['tes_max_soc'] = 4.186*system_spec_vs['tank_size']*(system_spec_vs['T_hp_supply'] - system_spec_vs['T_ref_gw'])/3600 # kWh
#system_spec_vs['hp_nominal_el_power'] = 2.2 # kW
#system_spec_vs['hp_minimum_el_power'] = 0.1 # kW
#system_spec_vs['hp_inverter_reg'] = (system_spec_vs['hp_minimum_el_power'] - system_spec_vs['hp_nominal_el_power'])/(system_spec_vs['tank_size']*4.186*(system_spec_vs['T_hp_supply']-system_spec_vs['T_ref_gw'])/3600) # HP output to SOC ratio
#

#%% Generating P2H simulations

p2h_fs = p2h_fixedspeed_realistic(provinces, archetypes, n_dict, system_spec, profiles_dict, cop_dhw, single_user=True)
#p2h_vs = p2h_varspeed_realistic(provinces, archetypes, n_dict, system_spec_vs, profiles_dict, single_user=True)
#p2h_vs_sm = p2h_varspeedsmart_realistic(administrative_units, archetypes, n_dict, system_spec_vs, profiles_dict, pv_series, single_user=True)

tot_p2h_fs = p2h_fixedspeed_realistic(provinces, archetypes, n_dict, system_spec, profiles_dict, cop_dhw, scale_factor=1e3)
#tot_p2h_vs = p2h_varspeed_realistic(provinces, archetypes, n_dict, system_spec_vs, profiles_dict)
#tot_p2h_vs_sm = p2h_varspeedsmart_realistic(administrative_units, archetypes, n_dict, system_spec_vs, profiles_dict, pv_series)

#vpp_p2h_fs = p2h_fixedspeed_vpp(provinces, archetypes, n_dict, system_spec, tot_p2h_fs)
#vpp_p2h_vs = p2h_varspeed_vpp(provinces, archetypes, n_dict, system_spec_vs, tot_p2h_vs)
#vpp_p2h_vs_sm1 = p2h_varspeedsmart_vpp(administrative_units, archetypes, n_dict, system_spec_vs, tot_p2h_vs_sm, pv_series, single_user=False, new_load=profile_avg_dict['U1'])
#vpp_p2h_vs_sm2 = p2h_varspeedsmart_vpp(administrative_units, archetypes, n_dict, system_spec_vs, tot_p2h_vs_sm, pv_series, single_user=False, new_load=profile_avg_dict['U2'])
#vpp_p2h_vs_sm3 = p2h_varspeedsmart_vpp(administrative_units, archetypes, n_dict, system_spec_vs, tot_p2h_vs_sm, pv_series, single_user=False, new_load=profile_avg_dict['U3'])


#%% Saving

#save_obj(tot_p2h_fs, 'tot_p2h_fs')
#save_obj(tot_p2h_vs, 'tot_p2h_vs')
#save_obj(tot_p2h_vs_sm, 'tot_p2h_vs_sm')

#%% Loading

#tot_p2h_vs_sm = load_obj('tot_p2h_vs_sm')

#%% Plotting

#comparative_plot(tot_p2h_fs, vpp_p2h_fs)
#comparative_plot(tot_p2h_vs, vpp_p2h_vs)
#comparative_plot(tot_p2h_vs_sm, vpp_p2h_vs_sm)

#single_plot(vpp_p2h_fs)
#single_plot(vpp_p2h_vs)
p2h_plot(p2h_to_data(p2h_fs,system_spec), start, stop)

#single_plot_threeus(vpp_p2h_vs_sm1, vpp_p2h_vs_sm2, vpp_p2h_vs_sm3)
#single_plot(p2h_vs_sm)

#comparative_plot(tot_p2h_vs, tot_p2h_vs_sm, hours=24)
