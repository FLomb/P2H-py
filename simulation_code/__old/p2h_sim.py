# -*- coding: utf-8 -*-
"""
Created on Fri Nov  1 10:41:59 2019

@author: FLomb
"""
import pandas as pd
import numpy as np
import math

start = '2017-01-01 00:00:00'
stop = '2017-01-07 23:59:00'
x = pd.date_range(start,stop, freq='T')
x_day = pd.date_range(start,stop, freq='D')

provinces = pd.read_csv('time_series/gw_temp_province.csv', sep=';', index_col=0).columns.to_list()
archetypes = pd.read_csv('time_series/building_archetypes.csv', sep=';', index_col=0)
archetypes_ratio = {'single_family': 1, 'double_family': 1.2 , 'multi_family': 1.6 , 'apartment_block': 2.1 }
n_dict = {'U1': 0.253, 'U2': 0.263, 'U3': 0.484}

example_profile = pd.DataFrame(profiles_dict['AQUILA']['apartment_block']['U1']['0']).set_index(x).resample('H').mean()

T_gw = pd.read_csv('time_series/gw_temp_province.csv', sep=';', index_col=0, usecols=['day','AQUILA'])[0:int(len(example_profile)/24)].set_index(x_day).resample('H').ffill()
T_gw = T_gw.reindex(T_gw.index.union(pd.date_range('2017-01-01 00:00:00', '2017-01-07 23:00:00', freq='H')), method='ffill')
T_gw_array = T_gw.values[:,0]

T_amb = pd.read_csv('time_series/ambient_temperatures.csv', sep=';', usecols=['AQUILA'])[0:int(len(example_profile))].values[:,0]

#%%
# Automatisation for several profiles
###

p2h_dict = {}

for prov in provinces:
    
    T_gw = pd.read_csv('time_series/gw_temp_province.csv', sep=';', index_col=0, usecols=['day',prov])[0:int(len(example_profile)/24)].set_index(x_day).resample('H').ffill()
    T_gw = T_gw.reindex(T_gw.index.union(pd.date_range('2017-01-01 00:00:00', '2017-01-07 23:00:00', freq='H')), method='ffill')
    T_gw_array = T_gw.values[:,0]
    T_amb = pd.read_csv('time_series/ambient_temperatures.csv', sep=';', usecols=[prov])[0:int(len(example_profile))].values[:,0]
    
    p2h_dict[prov] = {}
    
    for arch in archetypes[prov].index:

        p2h_dict[prov][arch] = {}
        n = archetypes[prov].loc[arch]/1e3
        
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
                soc_tes_0 = 3.7 # kWh, for 80 l tank @55°C
                q_loss_tes = 0.01
                
                # HP
                T_hp_supply = 55 # °C
                cop_hp = np.zeros(len(dhw_load))
                for t in range(len(dhw_load)):
                    cop_hp[t] = 13.905 - 0.363*(T_hp_supply-T_amb[t]) + 0.003*math.pow((T_hp_supply-T_amb[t]),2)
                en_con_cap_hp = 0.250 # kW
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
                        soc_tes[t] = soc_tes_0*(1 - q_loss_tes) + en_prod_hp[t] - en_tes_disch[t] 
                    else:
                        soc_tes[t] = soc_tes[t-1]*(1 - q_loss_tes) + en_prod_hp[t] - en_tes_disch[t]
                    
                    # Check SOC level (thermostatic set-point control)
                    if soc_tes[t] > soc_tes_0: # if higher than maximum, nonsense: HP must be turned OFF
                        
                        en_prod_hp[t] = 0
                        
                        if t == 0:
                            soc_tes[t] = soc_tes_0*(1 - q_loss_tes) + en_prod_hp[t] - en_tes_disch[t] 
                        else:
                            soc_tes[t] = soc_tes[t-1]*(1 - q_loss_tes) + en_prod_hp[t] - en_tes_disch[t]
                    
                    elif soc_tes[t] < 0: # if lower than 0: auxiliary Electric Heater must be turned ON to supply the delta
                        
                        en_prod_elh[t] = 0-soc_tes[t]
                        
                        if t == 0:
                            soc_tes[t] = soc_tes_0*(1 - q_loss_tes) + en_prod_hp[t] - en_tes_disch[t] + en_prod_elh[t]
                        else:
                            soc_tes[t] = soc_tes[t-1]*(1 - q_loss_tes) + en_prod_hp[t] - en_tes_disch[t] + en_prod_elh[t]
                        
                    else:
                        pass

                for col in p2h_dict[prov][arch][us]['%d' %k].columns:
                    p2h_dict[prov][arch][us]['%d' %k][col] =  p2h_labels[col]

tot_p2h = pd.DataFrame(index=range(int(len(example_profile))), columns = ['dhw_load','en_tes_disch','en_prod_hp','en_prod_elh','soc_tes']).astype('float').fillna(0)

for prov in provinces:
    for arch in archetypes[prov].index:
        n = archetypes[prov].loc[arch]/1e3
        for us in n_dict.keys():
            for k in range(int(round(n_dict[us]*n))):
                 for col in tot_p2h.columns:
                     tot_p2h[col] += p2h_dict[prov][arch][us]['%d' %k][col]

#%%
# Plotting multiple
###

fig, (ax1, ax2) = plt.subplots(2,1, sharex='col', sharey='col', gridspec_kw = {'height_ratios':[1,1], 'wspace':0.1, 'hspace':0.2}, figsize=(12,8))

ax1.plot(tot_p2h['dhw_load'], color='black', linestyle='-')
ax1.fill_between(range(len(tot_p2h)),0, tot_p2h['en_tes_disch'], color='orange', alpha=0.6)

ax2.stackplot(range(len(tot_p2h)),tot_p2h['en_prod_hp'], tot_p2h['en_prod_elh'], colors=['red','purple'], alpha=0.6)
ax3 = ax2.twinx()
ax3.plot(tot_p2h['soc_tes'], color='black', linestyle='--')
ax2.margins(0)

#%%
# Aggregate simulation
###


T_gw = pd.read_csv('time_series/gw_temp_province.csv', sep=';', index_col=0)[0:int(len(example_profile)/24)].set_index(x_day).resample('H').ffill()
T_gw = T_gw.reindex(T_gw.index.union(pd.date_range('2017-01-01 00:00:00', '2017-01-07 23:00:00', freq='H')), method='ffill')
T_gw = T_gw.mean(axis=1)
T_gw_array = T_gw.values
T_amb = pd.read_csv('time_series/ambient_temperatures.csv', sep=';')[0:int(len(example_profile))].mean(axis=1).values

###
# Variables definition
###

# DHW load
dhw_load = tot_p2h['dhw_load'].values #example_profile.values[:,0]/1e3

# TES
en_tes_disch = np.zeros(len(dhw_load))
soc_tes = np.zeros(len(dhw_load))
soc_tes_0 = 3.7*int(archetypes.sum().sum()/1e3) # kWh, for 80 l tank @55°C
q_loss_tes = 0.01

# HP
T_hp_supply = 55 # °C
cop_hp = np.zeros(len(dhw_load))
for t in range(len(dhw_load)):
    cop_hp[t] = 13.905 - 0.363*(T_hp_supply-T_amb[t]) + 0.003*math.pow((T_hp_supply-T_amb[t]),2)
en_con_cap_hp = 0.250*int(archetypes.sum().sum()/1e3) # kW
en_prod_hp = np.ones(len(dhw_load))*en_con_cap_hp*cop_hp
en_prod_elh = np.zeros(len(dhw_load))

###
# Thermodynamic simulation
###

for t in range(len(dhw_load)):
    
    # Energy balance
    en_tes_disch[t] = dhw_load[t]
    
    # SOC
    if t == 0:
        soc_tes[t] = soc_tes_0*(1 - q_loss_tes) + en_prod_hp[t] - en_tes_disch[t] 
    else:
        soc_tes[t] = soc_tes[t-1]*(1 - q_loss_tes) + en_prod_hp[t] - en_tes_disch[t]
    
    # Check SOC level (thermostatic set-point control)
    if soc_tes[t] > soc_tes_0: # if higher than maximum, nonsense: HP must be turned OFF
        
        en_prod_hp[t] = 0
        
        if t == 0:
            soc_tes[t] = soc_tes_0*(1 - q_loss_tes) + en_prod_hp[t] - en_tes_disch[t] 
        else:
            soc_tes[t] = soc_tes[t-1]*(1 - q_loss_tes) + en_prod_hp[t] - en_tes_disch[t]
    
    elif soc_tes[t] < 0: # if lower than 0: auxiliary Electric Heater must be turned ON to supply the delta
        
        en_prod_elh[t] = 0-soc_tes[t]
        
        if t == 0:
            soc_tes[t] = soc_tes_0*(1 - q_loss_tes) + en_prod_hp[t] - en_tes_disch[t] + en_prod_elh[t]
        else:
            soc_tes[t] = soc_tes[t-1]*(1 - q_loss_tes) + en_prod_hp[t] - en_tes_disch[t] + en_prod_elh[t]
        
    else:
        pass

#%%
# Plotting single
###
fig, (ax1, ax2) = plt.subplots(2,1, sharex='col', sharey='row', gridspec_kw = {'height_ratios':[1,1], 'wspace':0.1, 'hspace':0.2}, figsize=(12,8))
    
ax1.plot(dhw_load, color='black', linestyle='-')
ax1.fill_between(range(len(dhw_load)),0,en_tes_disch, color='orange', alpha=0.6)
ax1.set_ylabel('Power (kW)')
ax1.set_title('Individual user', weight='bold')

ax2.stackplot(range(len(dhw_load)),en_prod_hp, en_prod_elh, colors=['red','purple'], alpha=0.6)
ax3 = ax2.twinx()
ax3.plot(soc_tes, color='black', linestyle='--')
ax2.margins(0)
ax2.set_xlabel('Time (hours)')
ax2.set_ylabel('Power (kW)')
ax2b.set_ylabel('TES state of charge (kWh)')

#%%
# Plotting comparison
###

fig, ((ax1, ax3), (ax2,ax4)) = plt.subplots(2,2, sharex='col', sharey='all', gridspec_kw = {'height_ratios':[1,1], 'wspace':0.05, 'hspace':0.05}, figsize=(16,8))
    
dhw = ax1.plot(tot_p2h['dhw_load'], color='black', linestyle='-', label= 'DHW load')
tes_d = ax1.fill_between(range(len(tot_p2h)),0, tot_p2h['en_tes_disch'], color='orange', alpha=0.6, label='TES discharge')
ax1.margins(0)
ax1.set_ylabel('Power (kW)')
ax1.set_title('Aggregate of 24067 individual users', weight='bold')

hp_el = ax2.stackplot(range(len(tot_p2h)),tot_p2h['en_prod_hp'], tot_p2h['en_prod_elh'], colors=['red','purple'], alpha=0.6, labels=['HP','El.Heater'])
ax2.plot(tot_p2h['dhw_load'], color='black', linestyle='-', alpha=0.6)
ax2b = ax2.twinx()
soc = ax2b.plot(tot_p2h['soc_tes'], color='black', linestyle='--', label='TES state of charge')
ax2b.margins(0)
ax2.set_xlabel('Time (hours)')
ax2.set_ylabel('Power (kW)')

ax3.plot(dhw_load, color='black', linestyle='-')
ax3.fill_between(range(len(dhw_load)),0,en_tes_disch, color='orange', alpha=0.6)
ax3.margins(0)
ax3.set_title('Single VPP for 24067 individual users', weight='bold')

ax4.stackplot(range(len(dhw_load)),en_prod_hp, en_prod_elh, colors=['red','purple'], alpha=0.6)
ax4.plot(tot_p2h['dhw_load'], color='black', linestyle='-', alpha=0.6)
ax4b = ax4.twinx()
ax4b.plot(soc_tes, color='black', linestyle='--')
ax4b.set_ylabel('TES state of charge (kWh)')
ax4.margins(0)
ax4.set_xlabel('Time (hours)')

for sax in [ax4b]:
    sax.get_shared_y_axes().join(ax2b, sax)
ax2b.autoscale()
ax2b.yaxis.set_tick_params(labelright=False)

#lgd = ax3.legend(handles=[dhw,tes_d,hp_el,soc], loc=1, bbox_to_anchor=(1.2,1.3))
#fig.add_artist(lgd)
##fig.savefig('samplefigure', bbox_extra_artists=(lgd,), bbox_inches='tight')
