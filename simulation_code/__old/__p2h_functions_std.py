# -*- coding: utf-8 -*-
"""
Created on Mon Nov  4 12:08:54 2019

@author: FLomb
"""

import pandas as pd
import numpy as np
import math

start = '2017-01-01 00:00:00'
stop = '2017-01-07 23:59:00'
x = pd.date_range(start,stop, freq='T')
x_day = pd.date_range(start,stop, freq='D')

#%%
# P2H with fixed-speed heat pumps, realistic dispatch treating each user independenty
###

def p2h_fixedspeed_realistic(provinces, archetypes, n_dict, system_spec, profiles_dict, cop_series, single_user=False, scale_factor=1):
    
    example_profile = pd.DataFrame(profiles_dict[provinces[0]]['apartment_block']['U1']['0']).set_index(x).resample('H').mean()
    
    if single_user == True:
        provinces = [provinces[0]]
        archetypes = archetypes.loc['single_family'].to_frame().T.drop('single_family')
        archetypes.loc['single_family'] = 1
        n_dict = {'U1': 1}
    else:
        pass
    
    p2h_dict = {}

    for prov in provinces:
        
        p2h_dict[prov] = {}
        
        for arch in archetypes[prov].index:
    
            p2h_dict[prov][arch] = {}
            n = archetypes[prov].loc[arch]/scale_factor
            
            for us in n_dict.keys():
                
                p2h_dict[prov][arch][us] = {}
                
                for k in range(int(round(n_dict[us]*n))):
                    
                    load_profile = pd.DataFrame(profiles_dict[prov][arch][us]['%d' %k]).set_index(x).resample('H').mean()
                    p2h_dict[prov][arch][us]['%d' %k] = pd.DataFrame(index=range(int(len(example_profile))), columns = ['dhw_load','en_tes_disch','en_prod_hp','en_prod_elh','soc_tes']).astype('float')
    
                    ###
                    # Variables definition
                    ###
                    
                    # DHW load
                    dhw_load = load_profile.values[:,0]/1e3
                    
                    # TES
                    en_tes_disch = np.zeros(len(dhw_load))
                    soc_tes = np.zeros(len(dhw_load))
                    soc_tes_0 = system_spec['tes_initial_soc']*system_spec['tes_max_soc'] # kWh
                    soc_tes_max = system_spec['tes_max_soc']
                    soc_tes_min = system_spec['tes_min_soc']
                    
                    # HP
                    cop_hp = cop_series.values[0:(len(dhw_load)),0]
                    en_prod_cap_hp = system_spec['hp_nominal_th_power']
                    en_prod_hp = np.ones(len(dhw_load))*en_prod_cap_hp
                    en_con_hp = en_prod_hp/cop_hp
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
    
                    for col in p2h_dict[prov][arch][us]['%d' %k].columns:
                        p2h_dict[prov][arch][us]['%d' %k][col] =  p2h_labels[col]
                    p2h_dict[prov][arch][us]['%d' %k]['en_con_hp'] = en_prod_hp/cop_hp    
                    
    tot_p2h = pd.DataFrame(index=range(int(len(example_profile))), columns = ['dhw_load','en_tes_disch','en_prod_hp','en_con_hp','en_prod_elh','soc_tes']).astype('float').fillna(0)
    
    for prov in provinces:
        for arch in archetypes[prov].index:
            n = archetypes[prov].loc[arch]/scale_factor
            for us in n_dict.keys():
                for k in range(int(round(n_dict[us]*n))):
                     for col in tot_p2h.columns:
                         tot_p2h[col] += p2h_dict[prov][arch][us]['%d' %k][col]
    return(tot_p2h)

#%%
# P2H with fixed-speed heat pumps, VPP dispatch aggregating all user into a single VPP
###

def p2h_fixedspeed_vpp(provinces, archetypes, n_dict, system_spec, tot_p2h, single_user=False):
    
    scale_factor = 4
        
    if single_user == True:
        provinces = [provinces[0]]
        archetypes = archetypes.loc['single_family'].to_frame().T.drop('single_family')
        archetypes.loc['single_family'] = scale_factor
    else:
        pass
    
    T_amb = pd.read_csv('time_series/ambient_temperatures.csv', sep=';', usecols=provinces)[0:int(len(tot_p2h))].mean(axis=1).values
    
    ###
    # Variables definition
    ###
    
    if single_user == True:    
        tot_users = 1
    else:
        tot_users = int(archetypes[provinces].sum().sum()/scale_factor)
            
    # DHW load
    dhw_load = tot_p2h['dhw_load'].values #example_profile.values[:,0]/scale_factor
    
    # TES
    en_tes_disch = np.zeros(len(dhw_load))
    soc_tes = np.zeros(len(dhw_load))
    soc_tes_0 = system_spec['tes_initial_soc']*system_spec['tes_max_soc']*tot_users # kWh
    soc_tes_max = system_spec['tes_max_soc']*tot_users
    
    # HP
    cop_hp = np.zeros(len(dhw_load))
    for t in range(len(dhw_load)):
        cop_hp[t] = 13.905 - 0.363*(system_spec['T_hp_supply']-T_amb[t]) + 0.003*math.pow((system_spec['T_hp_supply']-T_amb[t]),2)
    en_con_cap_hp = system_spec['hp_nominal_el_power']*tot_users
    en_prod_hp = np.ones(len(dhw_load))*en_con_cap_hp*cop_hp
    en_prod_elh = np.zeros(len(dhw_load))

    # Dict to associate variables and dataframe columns
    p2h_labels = {'dhw_load': dhw_load,'en_tes_disch': en_tes_disch,'en_prod_hp': en_prod_hp,
                  'en_prod_elh': en_prod_elh,'soc_tes': soc_tes}

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
        
        elif soc_tes[t] < 0: # if lower than 0: auxiliary Electric Heater must be turned ON to supply the delta
            
            en_prod_elh[t] = 0-soc_tes[t]
            
            if t == 0:
                soc_tes[t] = soc_tes_0*(1 - system_spec['q_loss_tes']) + en_prod_hp[t] - en_tes_disch[t] + en_prod_elh[t]
            else:
                soc_tes[t] = soc_tes[t-1]*(1 - system_spec['q_loss_tes']) + en_prod_hp[t] - en_tes_disch[t] + en_prod_elh[t]
            
        else:
            pass
    vpp_p2h = pd.DataFrame(index=range(int(len(tot_p2h))), columns = ['dhw_load','en_tes_disch','en_prod_hp', 'en_prod_elh','soc_tes']).astype('float').fillna(0)

    for col in vpp_p2h.columns:
        vpp_p2h[col] = p2h_labels[col]
    vpp_p2h['en_con_hp'] = en_prod_hp/cop_hp
    
    return(vpp_p2h)

#%%
# P2H with variable-speed heat pumps, realistic dispatch treating each user independenty
###

def p2h_varspeed_realistic(provinces, archetypes, n_dict, system_spec, profiles_dict, single_user=False):

    scale_factor = 4
    
    example_profile = pd.DataFrame(profiles_dict['AQUILA']['apartment_block']['U1']['0']).set_index(x).resample('H').mean()
    
    p2h_dict = {}
    
    if single_user == True:
        provinces = [provinces[0]]
        archetypes = archetypes.loc['single_family'].to_frame().T.drop('single_family')
        archetypes.loc['single_family'] = scale_factor
        n_dict = {'U1': 1}
    else:
        pass
    
    for prov in provinces:
        T_amb = pd.read_csv('time_series/ambient_temperatures.csv', sep=';', usecols=[prov])[0:int(len(example_profile))].values[:,0]
        p2h_dict[prov] = {}
        
        for arch in archetypes[prov].index:
    
            p2h_dict[prov][arch] = {}
            n = archetypes[prov].loc[arch]/scale_factor
            
            for us in n_dict.keys():
                
                p2h_dict[prov][arch][us] = {}
                
                for k in range(int(round(n_dict[us]*n))):
                    
                    load_profile = pd.DataFrame(profiles_dict[prov][arch][us]['%d' %k]).set_index(x).resample('H').mean()
                    p2h_dict[prov][arch][us]['%d' %k] = pd.DataFrame(index=range(int(len(example_profile))), columns = ['dhw_load','en_tes_disch','en_prod_hp','en_prod_elh','soc_tes']).astype('float')
    
                    ###
                    # Variables definition
                    ###
                    
                    # DHW load
                    dhw_load = load_profile.values[:,0]/scale_factor
                    
                    # TES
                    en_tes_disch = np.zeros(len(dhw_load))
                    soc_tes = np.zeros(len(dhw_load))
                    soc_tes_0 = system_spec['tes_initial_soc']*system_spec['tes_max_soc'] # kWh
                    soc_tes_max = system_spec['tes_max_soc']
                    
                    # HP
                    cop_hp = np.zeros(len(dhw_load))
                    for t in range(len(dhw_load)):
                        cop_hp[t] = 13.905 - 0.363*(system_spec['T_hp_supply']-T_amb[t]) + 0.003*math.pow((system_spec['T_hp_supply']-T_amb[t]),2)
                    en_con_cap_hp = system_spec['hp_nominal_el_power']
                    en_prod_hp = np.ones(len(dhw_load))*en_con_cap_hp*cop_hp
                    en_prod_elh = np.zeros(len(dhw_load))
                    
                    # Dict to associate variables and dataframe columns
                    p2h_labels = {'dhw_load': dhw_load,'en_tes_disch': en_tes_disch,'en_prod_hp': en_prod_hp,
                                  'en_prod_elh': en_prod_elh,'soc_tes': soc_tes}
                    
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
                            en_prod_hp[t] =  en_prod_hp[t] + system_spec['hp_inverter_reg']*soc_tes[t-1]
                            soc_tes[t] = soc_tes[t-1]*(1 - system_spec['q_loss_tes']) + en_prod_hp[t] - en_tes_disch[t]
                        
                        # Check SOC level (thermostatic set-point control)
                        if soc_tes[t] > soc_tes_max: # if higher than maximum, nonsense: HP must be turned OFF or produce just as needed
                            
                            en_prod_hp[t] = 0
                            
                            if t == 0:
                                soc_tes[t] = soc_tes_0*(1 - system_spec['q_loss_tes']) + en_prod_hp[t] - en_tes_disch[t] 
                            else:
                                soc_tes[t] = soc_tes[t-1]*(1 - system_spec['q_loss_tes']) + en_prod_hp[t] - en_tes_disch[t]
                        
                        elif soc_tes[t] < 0: # if lower than 0: auxiliary Electric Heater must be turned ON to supply the delta
                            
                            en_prod_elh[t] = 0-soc_tes[t]
                            
                            if t == 0:
                                soc_tes[t] = soc_tes_0*(1 - system_spec['q_loss_tes']) + en_prod_hp[t] - en_tes_disch[t] + en_prod_elh[t]
                            else:
                                soc_tes[t] = soc_tes[t-1]*(1 - system_spec['q_loss_tes']) + en_prod_hp[t] - en_tes_disch[t] + en_prod_elh[t]
                            
                        else:
                            pass
    
                    for col in p2h_dict[prov][arch][us]['%d' %k].columns:
                        p2h_dict[prov][arch][us]['%d' %k][col] =  p2h_labels[col]
                    p2h_dict[prov][arch][us]['%d' %k]['en_con_hp'] = en_prod_hp/cop_hp
                    
    tot_p2h = pd.DataFrame(index=range(int(len(example_profile))), columns = ['dhw_load','en_tes_disch','en_prod_hp', 'en_con_hp', 'en_prod_elh','soc_tes']).astype('float').fillna(0)
    
    for prov in provinces:
        for arch in archetypes[prov].index:
            n = archetypes[prov].loc[arch]/scale_factor
            for us in n_dict.keys():
                for k in range(int(round(n_dict[us]*n))):
                     for col in tot_p2h.columns:
                         tot_p2h[col] += p2h_dict[prov][arch][us]['%d' %k][col]
    return(tot_p2h)

#%%
# P2H with variable-speed heat pumps, VPP dispatch aggregating all user into a single VPP
###

def p2h_varspeed_vpp(provinces, archetypes, n_dict, system_spec, tot_p2h_vs, single_user=False):

    scale_factor = 4
    
    if single_user == True:
        provinces = [provinces[0]]
        archetypes = archetypes.loc['single_family'].to_frame().T.drop('single_family')
        archetypes.loc['single_family'] = scale_factor
    else:
        pass
    
    T_amb = pd.read_csv('time_series/ambient_temperatures.csv', sep=';', usecols=provinces)[0:int(len(tot_p2h_vs))].mean(axis=1).values
    
    ###
    # Variables definition
    ###
    
    if single_user == True:    
        tot_users = 1
    else:
        tot_users = int(archetypes[provinces].sum().sum()/scale_factor)
        
    # DHW load
    dhw_load = tot_p2h_vs['dhw_load'].values #example_profile.values[:,0]/scale_factor
    
    # TES
    en_tes_disch = np.zeros(len(dhw_load))
    soc_tes = np.zeros(len(dhw_load))
    soc_tes_max = system_spec['tes_max_soc']* tot_users # kWh
    soc_tes_0 = system_spec['tes_initial_soc']*soc_tes_max # kWh
    
    # HP
    cop_hp = np.zeros(len(dhw_load))
    for t in range(len(dhw_load)):
        cop_hp[t] = 13.905 - 0.363*(system_spec['T_hp_supply']-T_amb[t]) + 0.003*math.pow((system_spec['T_hp_supply']-T_amb[t]),2)
    en_con_cap_hp = system_spec['hp_nominal_el_power']*tot_users
    en_prod_hp = np.ones(len(dhw_load))*en_con_cap_hp*cop_hp
    en_prod_elh = np.zeros(len(dhw_load))

    # Dict to associate variables and dataframe columns
    p2h_labels = {'dhw_load': dhw_load,'en_tes_disch': en_tes_disch,'en_prod_hp': en_prod_hp,
                  'en_prod_elh': en_prod_elh,'soc_tes': soc_tes}

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
            en_prod_hp[t] = en_prod_hp[t] + system_spec['hp_inverter_reg']*soc_tes[t-1]
            soc_tes[t] = soc_tes[t-1]*(1 - system_spec['q_loss_tes']) + en_prod_hp[t] - en_tes_disch[t]
        
        # Check SOC level (thermostatic set-point control)
        if soc_tes[t] > soc_tes_max: # if higher than maximum, nonsense: HP must be turned OFF
            
            en_prod_hp[t] = 0
            
            if t == 0:
                soc_tes[t] = soc_tes_0*(1 - system_spec['q_loss_tes']) + en_prod_hp[t] - en_tes_disch[t] 
            else:
                soc_tes[t] = soc_tes[t-1]*(1 - system_spec['q_loss_tes']) + en_prod_hp[t] - en_tes_disch[t]
        
        elif soc_tes[t] < 0: # if lower than 0: auxiliary Electric Heater must be turned ON to supply the delta
            
            en_prod_elh[t] = 0-soc_tes[t]
            
            if t == 0:
                soc_tes[t] = soc_tes_0*(1 - system_spec['q_loss_tes']) + en_prod_hp[t] - en_tes_disch[t] + en_prod_elh[t]
            else:
                soc_tes[t] = soc_tes[t-1]*(1 - system_spec['q_loss_tes']) + en_prod_hp[t] - en_tes_disch[t] + en_prod_elh[t]
            
        else:
            pass
    vpp_p2h = pd.DataFrame(index=range(int(len(tot_p2h_vs))), columns = ['dhw_load','en_tes_disch','en_prod_hp', 'en_prod_elh','soc_tes']).astype('float').fillna(0)

    for col in vpp_p2h.columns:
        vpp_p2h[col] = p2h_labels[col]
    vpp_p2h['en_con_hp'] = en_prod_hp/cop_hp
    
    return(vpp_p2h)