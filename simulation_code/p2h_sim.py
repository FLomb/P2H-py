# -*- coding: utf-8 -*-
"""
Created on Fri Nov  1 10:41:59 2019

@author: FLomb
"""

import pandas as pd
import os
import math

from p2h_functions_std import p2h_fixedspeed_realistic, p2h_fixedspeed_vpp
from p2h_functions_smart import p2h_varspeedsmart_realistic, p2h_varspeedsmart_vpp
from utils import load_obj, save_obj, p2h_to_data, p2h_plot, profile_dict_to_matrix
from summary_plots import choropleth_map_nrmse, choropleth_map_energy

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
# Import libraries and objects
###
start = '2015-01-01 00:00:00'
stop = '2015-01-07 23:59:00'
x = pd.date_range(start,stop, freq='T')
x_h = pd.date_range(start,stop, freq='H')
x_h_year = pd.date_range(start,'2015-12-31 23:00:00', freq='H')
# reg_dict = {'Piemonte':'R1',"Valle D'Aosta":'R2','Lombardia':'R3','Trentino Alto Adige':'R4',
#             'Veneto':'R5','Friuli Venezia Giulia':'R6','Liguria':'R7','Emilia-Romagna':'R8',
#             'Toscana':'R9','Umbria':'R10','Marche':'R11','Lazio':'R12','Abruzzo':'R13',
#             'Campania':'R14','Molise':'R15','Puglia':'R16','Basilicata':'R17','Calabria':'R18',
#             'Sicilia':'SICI','Sardegna':'SARD'}

# pv_cap_us = pd.read_csv('input_data/pv_cap_us.csv', index_col=0).T
administrative_units = pd.read_csv('input_data/administrative_units.csv', sep=',')
provinces = administrative_units['province'].to_list()
archetypes = pd.read_csv('input_data/building_archetypes.csv', sep=';', index_col=0)
pv_regions = pd.read_csv('processed_data/solar_resource_regions.csv', sep=',', index_col=0).set_index(x_h_year)
cop_dhw_regions = pd.read_csv('processed_data/cop_dhw_regions.csv', sep=',', index_col=0).set_index(x_h_year)
# for reg in reg_dict.keys():
#     pv_regions[reg] = pv_regions[reg]*pv_cap_us[reg_dict[reg]].values[0]

profiles_dict = load_obj('profiles_dict_Italy_50k')
regional_prof_matr = {}
regional_arch_matr = {}
regions = list(set(administrative_units['region']))
for reg in regions:
    regional_prof_matr[reg], regional_arch_matr[reg] = profile_dict_to_matrix(dict((k, profiles_dict[k]) for k in administrative_units[administrative_units['region'] == reg]['province'])) 
    regional_prof_matr[reg] = -regional_prof_matr[reg]/1e3

#%%
# Thermodynamic system (initial) technical specifics - subject to changes depending on household specifics
##

system_spec = {} # Daikin Monoblocco EKHH2E-AV3 + 2E200AV3

system_spec['tank_size'] = 200 # litres
system_spec['T_hp_supply'] = 55 # °C
system_spec['T_ref_gw'] = 15 # °C
system_spec['T_min_dhw'] = 40 # °C
system_spec['q_loss_tes'] = 0.01 # fraction of SOC per timestep
system_spec['tes_initial_soc'] = 0.625 # fraction of SOC max
system_spec['tes_max_soc'] = 4.186*system_spec['tank_size']*(system_spec['T_hp_supply'] - system_spec['T_ref_gw'])/3600 # kWh
system_spec['tes_min_soc'] = 0.625
system_spec['tes_over_soc'] = 1.125
system_spec['hp_nominal_th_power'] = 1.82 # kW thermal

#%% Generating P2H simulations

# regional_p2h_dict = {}
regional_p2h_vpp_dict = {}
# regional_p2h_nrmse = {}

# regional_p2h_dict_smart = {}
regional_p2h_vpp_dict_smart = {}
# regional_p2h_nrmse_smart = {}

for reg in regions:
    # regional_p2h_dict[reg] = p2h_fixedspeed_realistic(system_spec, regional_prof_matr[reg], regional_arch_matr[reg], cop_dhw_regions[reg].to_frame(), single_user=True)
    regional_p2h_vpp_dict[reg] = p2h_fixedspeed_vpp(system_spec, regional_prof_matr[reg], regional_arch_matr[reg], cop_dhw_regions[reg].to_frame(), single_user=True, fs_to_vsvpp=False)
    # regional_p2h_nrmse[reg] = nrmse(regional_p2h_vpp_dict[reg],regional_p2h_dict[reg])

    # regional_p2h_dict_smart[reg] = p2h_varspeedsmart_realistic(system_spec, regional_prof_matr[reg], regional_arch_matr[reg], cop_dhw_regions[reg].to_frame(), pv_regions[reg].to_frame(), single_user=False)
    regional_p2h_vpp_dict_smart[reg] = p2h_varspeedsmart_vpp(system_spec, regional_prof_matr[reg], regional_arch_matr[reg], cop_dhw_regions[reg].to_frame(), pv_regions[reg].to_frame(), single_user=True)
    # regional_p2h_nrmse_smart[reg] = nrmse(regional_p2h_vpp_dict_smart[reg],regional_p2h_dict_smart[reg])

#%% Saving

# save_obj(regional_p2h_dict, 'tot_p2h_fs_50k')
# save_obj(regional_p2h_dict_smart, 'tot_p2h_vs_50k')

#%% Loading

regional_p2h_dict = load_obj('tot_p2h_fs_50k')
regional_p2h_dict_smart = load_obj('tot_p2h_vs_50k')

#%% Plotting

p2h_plot(p2h_to_data(regional_p2h_dict['Toscana'],system_spec), start, stop)
p2h_plot(p2h_to_data(regional_p2h_vpp_dict['Toscana'],system_spec), start, stop)

p2h_plot(p2h_to_data(regional_p2h_dict_smart['Toscana'],system_spec), start, stop)
p2h_plot(p2h_to_data(regional_p2h_vpp_dict_smart['Toscana'],system_spec), start, stop)

# choropleth_map_nrmse(regional_p2h_nrmse)
# choropleth_map_nrmse(regional_p2h_nrmse_smart)
