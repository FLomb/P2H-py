# -*- coding: utf-8 -*-
"""
Created on Mon Mar 4 2019

A script to run and post-process the Calliope-P2H test model

@author: F.Lombardi
"""
#%% Initialisation
import calliope
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
import math

calliope.set_log_verbosity('ERROR') #sets the level of verbosity of Calliope's operations

#%%
model_0 = calliope.read_netcdf('NetCDFs/results_0.nc')
start = '2015-01-01 00:00:00'
stop = '2015-01-07 23:00:00'

start = '2015-01-01 00:00:00'
stop = '2015-01-07 23:59:00'
x = pd.date_range(start,stop, freq='T')
x_h = pd.date_range(start,stop, freq='H')
x_h_year = pd.date_range(start,'2015-12-31 23:00:00', freq='H')

#%%
def netcdf_to_data(model_inst,reg):
    demand_dhw = model_inst.get_formatted_array('carrier_con').loc[{'techs':'demand_dhw', 'carriers':'dhw', 'locs':reg}].sum('locs').to_pandas().T
    hps_dhw = model_inst.get_formatted_array('carrier_prod').loc[{'techs':'hp_dhw', 'carriers':'dhw', 'locs':reg}].sum('locs').to_pandas().T
    hps_dhw_inputs = model_inst.get_formatted_array('carrier_con').loc[{'techs':'hp_dhw', 'carriers':'electricity', 'locs':reg}].sum('locs').to_pandas().T
    tes_dhw_out = model_inst.get_formatted_array('carrier_prod').loc[{'techs':'tes_dhw', 'carriers':'dhw', 'locs':reg}].sum('locs').to_pandas().T
    tes_dhw_in = model_inst.get_formatted_array('carrier_con').loc[{'techs':'tes_dhw', 'carriers':'dhw', 'locs':reg}].sum('locs').to_pandas().T
    tes_dhw_o = tes_dhw_out+tes_dhw_in
    tes_dhw_o[tes_dhw_o<0]=0
    tes_dhw_i = tes_dhw_out+tes_dhw_in
    tes_dhw_i[tes_dhw_i>0]=0
    tes_dhw_cap = model_inst.get_formatted_array('storage').loc[{'techs':'tes_dhw', 'locs':reg}].sum('locs').to_pandas().T
    tes_dhw_charge_min = model_inst.get_formatted_array('storage_cap_equals').loc[{'techs':'tes_dhw', 'locs':reg}].sum('locs').to_pandas().T * model_inst.get_formatted_array('storage_discharge_depth').loc[{'techs':'tes_dhw'}].values[0]
    
    grid = model_inst.get_formatted_array('carrier_prod').loc[{'techs':'grid', 'carriers':'electricity', 'locs':reg}].sum('locs').to_pandas().T
    pv_rooftop = model_inst.get_formatted_array('carrier_prod').loc[{'techs':'pv_rooftop', 'carriers':'electricity', 'locs':reg}].sum('locs').to_pandas().T
    
    #DHW production
    hp_dhw = hps_dhw
    sto_dhw_o = hp_dhw + (tes_dhw_o)
    hp_dhw_el = -hps_dhw_inputs
    sto_dhw_i = tes_dhw_i
    loa_dhw = -demand_dhw
    soc_tes = tes_dhw_cap - tes_dhw_charge_min
    
    #Electricity generation and consumption
    pv = pv_rooftop 
    grid = pv + grid

    tot_p2h = pd.DataFrame(index=demand_dhw.index, columns = ['dhw_load','en_tes_disch','en_prod_hp', 'en_con_hp', 'soc_tes', 'pv']).astype('float').fillna(0)
    p2h_dict = {'dhw_load': loa_dhw, 'en_tes_ch': sto_dhw_i, 'en_tes_disch': sto_dhw_o, 'en_prod_hp': hp_dhw, 'en_con_hp': hp_dhw_el, 'soc_tes': soc_tes, 
                'pv': pv, 'grid': grid}
    for k in p2h_dict.keys():
        tot_p2h[k] = p2h_dict[k]
    
    return(tot_p2h)
    
#%%

def p2h_plot(tot_p2h, start, stop):
   
    fig, (ax1, ax2) = plt.subplots(2,1, sharex = 'col', gridspec_kw = {'height_ratios':[1,1], 'wspace':0.1, 'hspace':0.1}, figsize=(8,8))
    
    ax1.plot(tot_p2h['dhw_load'][start:stop].index,tot_p2h['dhw_load'][start:stop].values,'#000000', alpha=0.5, linestyle = '-', label ='DHW load')
    ax1b = ax1.twinx()
    ax1b.plot(tot_p2h['soc_tes'][start:stop].index,tot_p2h['soc_tes'][start:stop].values,'#000000', alpha=0.5, linestyle = '--', label ='TES SOC')
    ax1b.set_ylabel('SOC (kWh)')
    ax1.plot(tot_p2h['en_prod_hp'][start:stop].index,tot_p2h['en_prod_hp'][start:stop].values,'#DC2A62', alpha=0.2)
    ax1.plot(tot_p2h['en_tes_disch'][start:stop].index,tot_p2h['en_tes_disch'][start:stop].values,'#E06E92', alpha=0.2)
    ax1.plot(tot_p2h['en_tes_ch'][start:stop].index,tot_p2h['en_tes_ch'][start:stop].values,'#E06E92', alpha=0.2)
    ax1.set_ylabel('Power (kW)',labelpad = 11)
    ax1.margins(x=0)
    ax1.margins(y=0)
    ax1.fill_between(tot_p2h['en_prod_hp'][start:stop].index,0,tot_p2h['en_prod_hp'][start:stop].values,facecolor = '#DC2A62', alpha = 0.7, label = 'DHW Heat Pumps')
    ax1.fill_between(tot_p2h['en_tes_disch'][start:stop].index,tot_p2h['en_prod_hp'][start:stop].values,tot_p2h['en_tes_disch'][start:stop].values,facecolor = '#E06E92', alpha = 0.6, label = 'DHW Thermal storage')
    ax1.fill_between(tot_p2h['en_tes_ch'][start:stop].index,0,tot_p2h['en_tes_ch'][start:stop].values,facecolor = '#E06E92', alpha = 0.6)
    lgd1 = ax1.legend(loc=0,  bbox_to_anchor=(1.3,1), fontsize='x-small')
    
    ax2.plot(tot_p2h['en_con_hp'][start:stop].index,tot_p2h['en_con_hp'][start:stop].values,'#000000', alpha=0.5, color = 'r', linestyle = '--', label ='HPs power consumption')
    ax2.plot(tot_p2h['pv'][start:stop].index,tot_p2h['pv'][start:stop].values,'#EBF125', alpha=0.2)
    ax2.plot(tot_p2h['grid'][start:stop].index,tot_p2h['grid'][start:stop].values,'#8834C2', alpha=0.2)
    ax2.set_ylabel('Power kW)',labelpad = 11)
    ax2.margins(x=0)
    ax2.margins(y=0)
    ax2.fill_between(tot_p2h['pv'][start:stop].index,0,tot_p2h['pv'][start:stop].values,facecolor = '#EBF125', alpha = 0.6, label = 'Rooftop PV')
    ax2.fill_between(tot_p2h['grid'][start:stop].index,tot_p2h['pv'][start:stop].values,tot_p2h['grid'][start:stop].values,facecolor = '#8834C2', alpha = 0.6, label = 'Electricity grid')
    lgd4 = ax2.legend(loc=0,  bbox_to_anchor=(1.3,1), fontsize='x-small')

    return(fig)
    
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