# -*- coding: utf-8 -*-
"""
Created on Mon Nov  4 12:08:54 2019

@author: FLomb
"""

import pandas as pd
import numpy as np
import copy
import random

start = '2015-01-01 00:00:00'
stop = '2015-01-07 23:59:00'
x = pd.date_range(start,stop, freq='T')
x_day = pd.date_range(start,stop, freq='D')

#%%
# P2H with fixed-speed heat pumps, realistic dispatch treating each user independenty
###

def p2h_fixedspeed_realistic(system_spec, profiles_matrix, arch_matrix, cop_series, single_user=False, scale_factor=1):

    example_profile = profiles_matrix.iloc[:,0]
    
    if single_user == True:
        random_profile = int(random.uniform(1,len(profiles_matrix.columns)))
        profiles_matrix = profiles_matrix.iloc[:,random_profile].to_frame()
    else:
        pass
    
    p2h_dict = {}

    for k in profiles_matrix.columns:
        
        p2h_dict[k] = pd.DataFrame(index=range(int(len(example_profile))), columns = ['dhw_load','en_tes_disch','en_prod_hp','en_prod_elh','soc_tes']).astype('float')
        load_profile = copy.deepcopy(profiles_matrix[k])

        ###
        # Variables definition
        ###
        
        # DHW load
        dhw_load = -load_profile.values
        
        # TES
        en_tes_disch = np.zeros(len(dhw_load))
        soc_tes = np.zeros(len(dhw_load))
        soc_tes_max = arch_matrix[k].loc['tes_size']
        soc_tes_min = system_spec['tes_min_soc']*arch_matrix[k].loc['tes_size']
        soc_tes_0 = random.uniform(soc_tes_min,soc_tes_max) #system_spec['tes_initial_soc']*arch_matrix[k].loc['tes_size'] # kWh
        
        # HP
        cop_hp = cop_series.values[0:(len(dhw_load)),0]
        en_con_cap_hp = arch_matrix[k].loc['hp_size']/3 #typical ratio between nominal thermal power and electric consumption in commercial datasheets
        en_con_hp = np.ones(len(dhw_load))*en_con_cap_hp
        en_prod_hp = cop_hp*en_con_hp
        en_prod_elh = np.zeros(len(dhw_load))
        
        # Dict to associate variables and dataframe columns
        p2h_labels = {'dhw_load': dhw_load,'en_tes_disch': en_tes_disch,'en_prod_hp': en_prod_hp,
                      'en_con_hp': en_con_hp, 'en_prod_elh': en_prod_elh,'soc_tes': soc_tes}
        
        ###
        # Thermodynamic simulation
        ###
        
        for t in range(len(dhw_load)):
            
            # Energy balance
            en_tes_disch[t] = dhw_load[t]
            
            # SOC
            if t == 0:
                soc_tes[t] = soc_tes_0*(1 - system_spec['q_loss_tes']) + en_prod_hp[t] - en_tes_disch[t] 
            else:
                soc_tes[t] = soc_tes[t-1]*(1 - system_spec['q_loss_tes']) + en_prod_hp[t] - en_tes_disch[t]
            
            # Check SOC level (thermostatic set-point control)
            if soc_tes[t] > soc_tes_max: # if higher than maximum, nonsense: HP must be turned OFF
                
                en_prod_hp[t] = 0
                
                if t == 0:
                    soc_tes[t] = soc_tes_0*(1 - system_spec['q_loss_tes']) + en_prod_hp[t] - en_tes_disch[t] 
                else:
                    soc_tes[t] = soc_tes[t-1]*(1 - system_spec['q_loss_tes']) + en_prod_hp[t] - en_tes_disch[t]
            
            elif soc_tes[t] < soc_tes_min: # if lower than 0 useful energy: auxiliary Electric Heater must be turned ON to supply the delta
                
                en_prod_elh[t] = soc_tes_min-soc_tes[t]
                
                if t == 0:
                    soc_tes[t] = soc_tes_0*(1 - system_spec['q_loss_tes']) + en_prod_hp[t] - en_tes_disch[t] + en_prod_elh[t]
                else:
                    soc_tes[t] = soc_tes[t-1]*(1 - system_spec['q_loss_tes']) + en_prod_hp[t] - en_tes_disch[t] + en_prod_elh[t]
                
            else:
                pass

        for col in p2h_dict[k].columns:
            p2h_dict[k][col] =  p2h_labels[col]
        p2h_dict[k]['en_con_hp'] = en_prod_hp/cop_hp 
                    
    tot_p2h = pd.DataFrame(index=range(int(len(example_profile))), columns = ['dhw_load','en_tes_disch','en_prod_hp','en_con_hp','en_prod_elh','soc_tes']).astype('float').fillna(0)
    
    if single_user == True:
        k = profiles_matrix.columns.values[0]
        for col in tot_p2h.columns:
            tot_p2h[col] += p2h_dict[k][col]
    else:
        for k in profiles_matrix.columns:
            for col in tot_p2h.columns:
                tot_p2h[col] += p2h_dict[k][col]
    if single_user == False:
        tot_p2h['soc_tes_max'] = arch_matrix.loc['tes_size'].sum()
    else:
        tot_p2h['soc_tes_max'] = soc_tes_max
        
    return(tot_p2h)

#%%
# P2H with fixed-speed heat pumps, VPP dispatch aggregating all user into a single VPP
###

def p2h_fixedspeed_vpp(system_spec, profiles_matrix, arch_matrix, cop_series, single_user=False, fs_to_vsvpp=False):
    
    if single_user == True:
        random_profile = int(random.uniform(1,len(profiles_matrix.columns)))
        profiles_matrix = profiles_matrix.iloc[:,random_profile].to_frame()
        arch_matrix = arch_matrix.iloc[:,random_profile].to_frame()
    else:
        pass
    
    load_profile = copy.deepcopy(profiles_matrix.sum(axis=1))
    hp_size = int(arch_matrix.loc['hp_size'].mean()*100)/100*len(arch_matrix.columns)
    tes_size = int(arch_matrix.loc['tes_size'].mean()*100)/100*len(arch_matrix.columns)
    p2h_frame = pd.DataFrame(index=profiles_matrix.index, columns = ['dhw_load','en_tes_disch','en_prod_hp','en_prod_elh','soc_tes']).astype('float')
        
    ###
    # Variables definition
    ###
    
    # DHW load
    dhw_load = -load_profile.values
    
    # TES
    en_tes_disch = np.zeros(len(dhw_load))
    soc_tes = np.zeros(len(dhw_load))
    soc_tes_max = tes_size
    soc_tes_min = system_spec['tes_min_soc']*tes_size
    soc_tes_0 = (soc_tes_max + soc_tes_min)/2 #system_spec['tes_initial_soc']*tes_size # kWh
    
    # HP
    cop_hp = cop_series.values[0:(len(dhw_load)),0]
    en_con_cap_hp = hp_size/3 #typical ratio between nominal thermal power and electric consumption in commercial datasheets
    en_con_hp = np.ones(len(dhw_load))*en_con_cap_hp
    en_prod_hp = cop_hp*en_con_hp
    en_prod_elh = np.zeros(len(dhw_load))

    # Dict to associate variables and dataframe columns
    p2h_labels = {'dhw_load': dhw_load,'en_tes_disch': en_tes_disch,'en_prod_hp': en_prod_hp,
                  'en_con_hp': en_con_hp, 'en_prod_elh': en_prod_elh,'soc_tes': soc_tes}
    
    ###
    # Thermodynamic simulation
    ###
    
    for t in range(len(dhw_load)):
        
        # Energy balance
        en_tes_disch[t] = dhw_load[t]
        
        # SOC
        if t == 0:
            soc_tes[t] = soc_tes_0*(1 - system_spec['q_loss_tes']) + en_prod_hp[t] - en_tes_disch[t] 
        else:
            soc_tes[t] = soc_tes[t-1]*(1 - system_spec['q_loss_tes']) + en_prod_hp[t] - en_tes_disch[t]
        
        # Check SOC level (thermostatic set-point control)
        if soc_tes[t] > soc_tes_max: # if higher than maximum, nonsense: HP must be turned OFF
            
            if fs_to_vsvpp == False:
                en_prod_hp[t] = 0
            else:
                en_prod_hp[t] = en_prod_hp[t]*(1-(soc_tes[t-1]-soc_tes_min)/(soc_tes_max-soc_tes_min))

            if t == 0:
                soc_tes[t] = soc_tes_0*(1 - system_spec['q_loss_tes']) + en_prod_hp[t] - en_tes_disch[t] 
            else:
                soc_tes[t] = soc_tes[t-1]*(1 - system_spec['q_loss_tes']) + en_prod_hp[t] - en_tes_disch[t]
        
        elif soc_tes[t] < soc_tes_min: # if lower than 0 useful energy: auxiliary Electric Heater must be turned ON to supply the delta
            
            en_prod_elh[t] = soc_tes_min-soc_tes[t]
            
            if t == 0:
                soc_tes[t] = soc_tes_0*(1 - system_spec['q_loss_tes']) + en_prod_hp[t] - en_tes_disch[t] + en_prod_elh[t]
            else:
                soc_tes[t] = soc_tes[t-1]*(1 - system_spec['q_loss_tes']) + en_prod_hp[t] - en_tes_disch[t] + en_prod_elh[t]
            
        else:
            pass

        for col in p2h_frame.columns:
            p2h_frame[col] =  p2h_labels[col]
        p2h_frame['en_con_hp'] = en_prod_hp/cop_hp    
                    
        tot_p2h = pd.DataFrame(index=profiles_matrix.index, columns = ['dhw_load','en_tes_disch','en_prod_hp','en_con_hp','en_prod_elh','soc_tes']).astype('float').fillna(0)

    for col in tot_p2h.columns:
            tot_p2h[col] += p2h_frame[col]
    tot_p2h['soc_tes_max'] = soc_tes_max
    
    return(tot_p2h)
    