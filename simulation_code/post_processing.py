# -*- coding: utf-8 -*-
"""
Created on Wed Jan  8 16:41:30 2020

@author: FLomb
"""

import pandas as pd
import os
import copy
import matplotlib.pyplot as plt

from utils import load_obj, save_obj, p2h_to_data

#%%
# Functions
###

def regionwide_aggregation(regional_df):
    regional_df = regional_df.T
    zonal_df = pd.DataFrame(columns=regional_df.columns)
    zonal_df.loc['NORD'] = regional_df.loc[['R1','R2','R3','R4','R5','R6','R7','R8']].sum().rename('NORD') 
    zonal_df.loc['CNOR'] = regional_df.loc[['R9','R10','R11']].sum().rename('NORD') 
    zonal_df.loc['CSUD'] = regional_df.loc[['R12','R13','R14']].sum().rename('CSUD')
    zonal_df.loc['SUD'] = regional_df.loc[['R15','R16','R17','R18','GR']].sum().rename('SUD')
    zonal_df.loc['SARD'] = regional_df.loc[['SARD']].sum().rename('NORD') 
    zonal_df.loc['SICI'] = regional_df.loc[['SICI']].sum().rename('NORD') 
    
    return(zonal_df.T)

#%% 
# Import libraries and objects
###
start = '2015-06-15 00:00:00'
stop = '2015-06-21 23:59:00'
x = pd.date_range(start,stop, freq='T')
x_h = pd.date_range(start,stop, freq='H')
x_h_year = pd.date_range('2015-01-01 00:00:00','2015-12-31 23:00:00', freq='H')

administrative_units = pd.read_csv('input_data/administrative_units_new.csv', sep=',')
provinces = administrative_units['province'].to_list()
archetypes = pd.read_csv('input_data/building_archetypes.csv', sep=';', index_col=0)
archetypes_dhw = copy.deepcopy(archetypes)
archetypes_elboilers = copy.deepcopy(archetypes)
administrative_units['ratio_ebl_dhw'] = administrative_units['share_el_DHW_boiler']/administrative_units['share_DHW_independent']
for prov in provinces:
    archetypes_dhw[prov] = (round(archetypes[prov] * administrative_units['share_DHW_independent'][administrative_units['province']==prov].values))
    archetypes_elboilers[prov] = (round(archetypes[prov] * administrative_units['share_el_DHW_boiler'][administrative_units['province']==prov].values))
regions = list(set(administrative_units['region']))

#%% Loading
regional_p2h_dict = load_obj('tot_p2h_fs_50k')
regional_p2h_dict_smart = load_obj('tot_p2h_vs_50k')

#%% Results
# hp_cons = 0
# hp_cons_smart = 0
# for reg in regions:
#     hp_cons += regional_p2h_dict[reg]['en_con_hp'].sum()
#     hp_cons_smart += regional_p2h_dict_smart[reg]['en_con_hp'].sum()

#%% Calliope-ready elaboration
demand_regions = pd.DataFrame(index=x_h_year, columns=regions).astype('float')
demand_regions_boilers = pd.DataFrame(index=x_h_year, columns=regions).astype('float')
for reg in regions:
    demand_regions[reg].loc[start:stop] = -100*regional_p2h_dict[reg]['dhw_load'].values
    demand_regions_boilers[reg].loc[start:stop] = -100*regional_p2h_dict[reg]['dhw_load'].values*administrative_units[administrative_units['region'] == reg]['ratio_ebl_dhw'].iloc[0]
    

ordered_columns = ['Piemonte',"Valle D'Aosta",'Lombardia','Trentino Alto Adige','Veneto','Friuli Venezia Giulia',
                    'Liguria','Emilia-Romagna', 'Toscana','Umbria','Marche','Lazio','Abruzzo','Campania','Molise',
                    'Puglia','Basilicata','Calabria', 'Sicilia','Sardegna']
calliope_columns = ['R1','R2','R3','R4','R5','R6','R7','R8','R9','R10',
                    'R11','R12','R13','R14','R15','R16','R17','R18','SICI','SARD']

zones_dict = {}
demand_regions = demand_regions[ordered_columns]
demand_regions.columns = calliope_columns
demand_regions_boilers = demand_regions_boilers[ordered_columns]
demand_regions_boilers.columns = calliope_columns

demand_el_zones_terna =  pd.read_csv('input_data/regional_demand_fullTerna.csv', sep=',', index_col=0)
demand_el_zones_noboil = demand_el_zones_terna - regionwide_aggregation(demand_regions_boilers)

p2h_load_tcl = pd.DataFrame(columns=demand_regions_boilers.columns).astype(float)
p2h_load_pvtcl = pd.DataFrame(columns=demand_regions_boilers.columns).astype(float)

k = 0
for reg in ordered_columns:
    p2h_load_tcl[calliope_columns[k]] = -100*regional_p2h_dict[reg]['en_con_hp'].values
    p2h_load_pvtcl[calliope_columns[k]] = -100*regional_p2h_dict_smart[reg]['en_con_hp'].values
    k += 1

demand_zones_p2h_tcl = (demand_el_zones_noboil + regionwide_aggregation(p2h_load_tcl.set_index(x_h))).fillna(0)
demand_zones_p2h_pvtcl = (demand_el_zones_noboil + regionwide_aggregation(p2h_load_pvtcl.set_index(x_h))).fillna(0)

#%%
# Saving outputs
###

demand_el_zones_noboil.to_csv('processed_data/demand_zones_noboil.csv')
demand_zones_p2h_tcl.to_csv('processed_data/demand_zones_p2h_tcl.csv')
demand_zones_p2h_pvtcl.to_csv('processed_data/demand_zones_p2h_pvtcl.csv')
demand_regions.to_csv('processed_data/demand_regions_heat.csv')
demand_el_zones_terna.to_csv('processed_data/demand_zones_terna.csv')

#%%
# Plotting
###

plt.plot(x_h,-demand_el_zones_noboil['NORD'][start:stop], color='blue')
plt.plot(x_h,-demand_zones_p2h_tcl['NORD'][start:stop], color='purple')
plt.plot(x_h,-demand_zones_p2h_pvtcl['NORD'][start:stop], color='red')
