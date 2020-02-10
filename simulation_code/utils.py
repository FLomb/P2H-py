# -*- coding: utf-8 -*-
"""
Created on Mon Mar 4 2019

A script to run and post-process the Calliope-P2H test model

@author: F.Lombardi
"""
#%% Initialisation
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
import math
import pickle

#%%
start = '2015-01-01 00:00:00'
stop = '2015-01-07 23:00:00'

x = pd.date_range(start,stop, freq='T')
x_h = pd.date_range(start,stop, freq='H')
x_h_year = pd.date_range(start,'2015-12-31 23:00:00', freq='H')

#%%
def save_obj(obj, name ):
    with open('results/'+ name + '.pkl', 'wb') as f:
        pickle.dump(obj, f, pickle.HIGHEST_PROTOCOL)

def load_obj(name ):
    with open('input_data/' + name + '.pkl', 'rb') as f:
        return pickle.load(f)
        
#%%
def p2h_to_data(p2h_case, system_spec):
    
    p2h_case = p2h_case.set_index(x_h)
    
    demand_dhw = p2h_case['dhw_load']
    hps_dhw_inputs = p2h_case['en_con_hp']
    tes_dhw_charge_min = p2h_case['soc_tes_max']*system_spec['tes_min_soc']
    hp_dhw = p2h_case['en_prod_hp']

    sto_dhw_i = -(hp_dhw.where(hp_dhw>demand_dhw) - demand_dhw.where(hp_dhw>demand_dhw)).fillna(0)
    sto_dhw_o = (demand_dhw.where(hp_dhw<demand_dhw).fillna(0) - hp_dhw.where(hp_dhw<demand_dhw).fillna(0)) 
    hp_dhw_el = hps_dhw_inputs
    loa_dhw = demand_dhw
    soc_tes = p2h_case['soc_tes'] - tes_dhw_charge_min
    
    tot_p2h = pd.DataFrame(index=demand_dhw.index, columns = ['dhw_load','en_tes_disch','en_prod_hp', 'en_con_hp', 'soc_tes', 'pv']).astype('float').fillna(0)
    p2h_dict = {'dhw_load': loa_dhw, 'en_tes_ch': sto_dhw_i, 'en_tes_disch': sto_dhw_o, 
                'en_prod_hp': hp_dhw, 'en_con_hp': hp_dhw_el, 'soc_tes': soc_tes}
    for k in p2h_dict.keys():
        tot_p2h[k] = p2h_dict[k]
        
    if 'pv_cf' in p2h_case.columns:    
        tot_p2h['pv'] = p2h_case['pv_cf']
    
    return(tot_p2h)
    
#%%

def p2h_plot(tot_p2h, start, stop):
   
    fig, (ax1, ax2) = plt.subplots(2,1, sharex = 'col', gridspec_kw = {'height_ratios':[1,1], 'wspace':0.1, 'hspace':0.1}, figsize=(8,8))
    
    ax1.plot(tot_p2h['dhw_load'][start:stop].index,tot_p2h['dhw_load'][start:stop].values,'#000000', alpha=0.5, linestyle = '-', label ='DHW load')
    ax1b = ax1.twinx()
    ax1b.plot(tot_p2h['soc_tes'][start:stop].index,tot_p2h['soc_tes'][start:stop].values,'#000000', alpha=0.5, linestyle = '--', label ='TES SOC')
    ax1b.set_ylabel('SOC (kWh)')
    ax1b.set_ylim(ymin=0)
    ax1.plot(tot_p2h['en_prod_hp'][start:stop].index,tot_p2h['en_prod_hp'][start:stop].values,'#DC2A62', alpha=0.2)
    ax1.plot(tot_p2h['en_tes_disch'][start:stop].index,(tot_p2h['en_tes_disch'][start:stop].values+tot_p2h['en_prod_hp'][start:stop].values),'#E06E92', alpha=0.2)
    ax1.plot(tot_p2h['en_tes_ch'][start:stop].index,tot_p2h['en_tes_ch'][start:stop].values,'#E06E92', alpha=0.2)
    ax1.set_ylabel('Power (kW)',labelpad = 11)
    ax1.margins(x=0)
    ax1.margins(y=0)
    ax1.fill_between(tot_p2h['en_prod_hp'][start:stop].index,0,tot_p2h['en_prod_hp'][start:stop].values,facecolor = '#DC2A62', alpha = 0.7, label = 'DHW Heat Pumps')
    ax1.fill_between(tot_p2h['en_tes_disch'][start:stop].index,tot_p2h['en_prod_hp'][start:stop].values,(tot_p2h['en_tes_disch'][start:stop].values+tot_p2h['en_prod_hp'][start:stop].values),facecolor = '#E06E92', alpha = 0.6, label = 'DHW Thermal storage')
    ax1.fill_between(tot_p2h['en_tes_ch'][start:stop].index,0,tot_p2h['en_tes_ch'][start:stop].values,facecolor = '#E06E92', alpha = 0.6)
    # lgd1 = ax1.legend(loc='lower right',  bbox_to_anchor=(1,1), fontsize='small')
    
    ax2.plot(tot_p2h['en_con_hp'][start:stop].index,tot_p2h['en_con_hp'][start:stop].values, alpha=0.5, color = 'r', linestyle = '--', label ='HPs power consumption')
    if 'pv' in tot_p2h.columns:
        ax2b =ax2.twinx()
        ax2b.set_ylabel('PV capacity factor (-)')
        ax2b.plot(tot_p2h['pv'][start:stop].index,tot_p2h['pv'][start:stop].values, color='#EBF125', alpha=1, label='PV output')
        ax2b.margins(x=0)
        ax2b.margins(y=0)
    else:
        pass
   # ax2.plot(tot_p2h['grid'][start:stop].index,tot_p2h['grid'][start:stop].values,'#8834C2', alpha=0.2)
    ax2.set_ylabel('Power kW)',labelpad = 11)
    ax2.margins(x=0)
    ax2.margins(y=0)
#    ax2.fill_between(tot_p2h['pv'][start:stop].index,0,tot_p2h['pv'][start:stop].values,facecolor = '#EBF125', alpha = 0.6, label = 'Rooftop PV')
#    ax2.fill_between(tot_p2h['grid'][start:stop].index,tot_p2h['pv'][start:stop].values,tot_p2h['grid'][start:stop].values,facecolor = '#8834C2', alpha = 0.6, label = 'Electricity grid')
    # lgd4 = ax2b.legend(loc=1,  bbox_to_anchor=(1,1), fontsize='small')

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