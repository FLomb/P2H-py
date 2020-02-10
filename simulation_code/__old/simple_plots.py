# -*- coding: utf-8 -*-
"""
Created on Mon Nov  4 14:15:23 2019

@author: FLomb
"""
import matplotlib.pyplot as plt

#%%
def comparative_plot (p2h_1, p2h_2, hours=168):
    
    fig, ((ax1, ax3), (ax2,ax4)) = plt.subplots(2,2, sharex='col', sharey='all', gridspec_kw = {'height_ratios':[1,1], 'wspace':0.15, 'hspace':0.05}, figsize=(16,8))
    
    p2h_1 = p2h_1.iloc[0:hours]
    p2h_2 = p2h_2.iloc[0:hours]
        
    ax1.plot(p2h_1['dhw_load'], color='black', linestyle='-', label= 'DHW load')
    ax1.fill_between(range(len(p2h_1)),0, p2h_1['en_tes_disch'], color='orange', alpha=0.6, label='TES discharge')
    if 'pv_cf' in p2h_1.columns:
        ax1b = ax1.twinx()
        ax1b.plot(p2h_1['pv_cf'], color='red', linestyle='-', alpha=0.5, label='PV capacity factor')
        ax1b.margins(0)
    ax1.margins(0)
    ax1.set_ylabel('Power (kW)')
    ax1.set_title('Aggregate of 24067 individual users', weight='bold')
    
    ax2.stackplot(range(len(p2h_1)),p2h_1['en_prod_hp'], p2h_1['en_prod_elh'], colors=['red','purple'], alpha=0.6, labels=['HP','El.Heater'])
    ax2.plot(p2h_1['dhw_load'], color='black', linestyle='-', alpha=0.6)
    ax2.plot(p2h_1['en_con_hp'], color='blue', linestyle='dotted', alpha=0.6)
    ax2b = ax2.twinx()
    ax2b.plot(p2h_1['soc_tes'], color='black', linestyle='--', label='TES state of charge')
    ax2b.margins(0)
    ax2b.set_ylim(ymin=0)
    ax2.set_xlabel('Time (hours)')
    ax2.set_ylabel('Power (kW)')
    
    ax3.plot(p2h_2['dhw_load'], color='black', linestyle='-')
    ax3.fill_between(range(len(p2h_2['dhw_load'])),0,p2h_2['en_tes_disch'], color='orange', alpha=0.6)
    if 'pv_cf' in p2h_2.columns:
        ax3b = ax3.twinx()
        ax3b.plot(p2h_2['pv_cf'], color='red', linestyle='-', alpha=0.5, label='PV capacity factor')
        ax3b.margins(0)
        ax3b.set_ylabel('Average PV capacity factor (-)')
    ax3.margins(0)
    ax3.set_title('Single VPP for 24067 individual users', weight='bold')
    
    ax4.stackplot(range(len(p2h_2['dhw_load'])),p2h_2['en_prod_hp'], p2h_2['en_prod_elh'], colors=['red','purple'], alpha=0.6)
    ax4.plot(p2h_2['dhw_load'], color='black', linestyle='-', alpha=0.6)
    ax4.plot(p2h_2['en_con_hp'], color='blue', linestyle='dotted', alpha=0.6)
    ax4b = ax4.twinx()
    ax4b.plot(p2h_2['soc_tes'], color='black', linestyle='--')
    ax4b.set_ylabel('TES state of charge (kWh)')
    ax4.margins(0)
    ax4b.set_ylim(ymin=0)
    ax4.set_xlabel('Time (hours)')
    
    for sax in [ax4b]:
        sax.get_shared_y_axes().join(ax2b, sax)
    ax2b.autoscale()
    ax2b.yaxis.set_tick_params(labelright=False)
    
    if 'pv_cf' in p2h_1.columns and 'pv_cf' in p2h_2.columns:
        for sax in [ax3b]:
            sax.get_shared_y_axes().join(ax1b, sax)
        ax1b.autoscale()
        ax1b.yaxis.set_tick_params(labelright=False)
        
    return(fig)

#%%
def single_plot (p2h_1, hours=168):
    
    p2h_1 = p2h_1.iloc[0:hours]
        
    fig, (ax1, ax2) = plt.subplots(2,1, sharex='col', sharey='all', gridspec_kw = {'height_ratios':[1,1], 'wspace':0.05, 'hspace':0.05}, figsize=(8,8))
        
    ax1.plot(p2h_1['dhw_load'], color='black', linestyle='-', label= 'DHW load')
    ax1.fill_between(range(len(p2h_1)),0, p2h_1['en_tes_disch'], color='orange', alpha=0.6, label='TES discharge')
    ax1.margins(0)
    ax1.set_ylabel('Power (kW)')
    ax1.set_title('Individual user', weight='bold')
    if 'pv_cf' in p2h_1.columns:
        ax1b = ax1.twinx()
        ax1b.plot(p2h_1['pv_cf'], color='red', linestyle='-', alpha=0.5, label='PV capacity factor')
        ax1b.margins(0)
        
    ax2.stackplot(range(len(p2h_1)),p2h_1['en_prod_hp'], p2h_1['en_prod_elh'], colors=['red','purple'], alpha=0.6, labels=['HP','El.Heater'])
    ax2.plot(p2h_1['dhw_load'], color='black', linestyle='-', alpha=0.6)
    ax2.plot(p2h_1['en_con_hp'], color='blue', linestyle='dotted', alpha=0.6)    
    ax2b = ax2.twinx()
    ax2b.plot(p2h_1['soc_tes'], color='black', linestyle='--', label='TES state of charge')
    ax2b.margins(0)
    ax2b.set_ylim(ymin=0)
    ax2.set_xlabel('Time (hours)')
    ax2.set_ylabel('Power (kW)')
    ax2b.set_ylabel('TES state of charge (kWh)')
    
    return(fig)

#%%
def single_plot_threeus (p2h_1, p2h_2, p2h_3, hours=168):
    
    p2h_1 = p2h_1.iloc[0:hours]
        
    fig, (ax1, ax2) = plt.subplots(2,1, sharex='col', sharey='all', gridspec_kw = {'height_ratios':[1,1], 'wspace':0.05, 'hspace':0.05}, figsize=(8,8))
    
#    total_load = p2h_1['dhw_load'] + p2h_2['dhw_load'] + p2h_3['dhw_load']
#    total_tes_discharge = 
    ax1.plot(p2h_1['dhw_load'], color='black', linestyle='--', label= 'DHW load U1')
    ax1.plot(p2h_2['dhw_load'], color='black', linestyle=':', label= 'DHW load U2')
    ax1.plot(p2h_3['dhw_load'], color='black', linestyle='-.', label= 'DHW load U3')
    
    ax1.fill_between(range(len(p2h_1)),0, p2h_1['en_tes_disch'], color='orange', alpha=0.6, label='TES discharge U1')
    ax1.fill_between(range(len(p2h_2)),0, p2h_2['en_tes_disch'], color='orange', alpha=0.6, label='TES discharge U2')
    ax1.fill_between(range(len(p2h_3)),0, p2h_3['en_tes_disch'], color='orange', alpha=0.6, label='TES discharge U3')
    
    ax1.margins(0)
    ax1.set_ylabel('Power (kW)')
    ax1.set_title('Individual user', weight='bold')
    if 'pv_cf' in p2h_1.columns:
        ax1b = ax1.twinx()
        ax1b.plot(p2h_1['pv_cf'], color='red', linestyle='-', alpha=0.5, label='PV capacity factor')
        ax1b.margins(0)
        
    ax2.stackplot(range(len(p2h_1)),p2h_1['en_prod_hp'], p2h_2['en_prod_hp'], p2h_1['en_prod_hp'], p2h_1['en_prod_elh'], p2h_2['en_prod_elh'], p2h_3['en_prod_elh'], colors=['red', 'red', 'red', 'purple', 'purple', 'purple'], alpha=0.6, labels=['HP U1', 'HP U2', 'HP U3','El.Heater U1', 'El.Heater U2', 'El.Heater U3'])
#    ax2.plot(p2h_1['dhw_load'], color='black', linestyle='-', alpha=0.6)
    ax2.plot(p2h_1['en_con_hp'], color='blue', linestyle='--', alpha=0.6)    
    ax2.plot(p2h_2['en_con_hp'], color='blue', linestyle=':', alpha=0.6)    
    ax2.plot(p2h_3['en_con_hp'], color='blue', linestyle='-.', alpha=0.6)    
    ax2b = ax2.twinx()
    ax2b.plot(p2h_1['soc_tes'], color='black', linestyle='--', label='TES state of charge')
    ax2b.margins(0)
    ax2b.set_ylim(ymin=0)
    ax2.set_xlabel('Time (hours)')
    ax2.set_ylabel('Power (kW)')
    ax2b.set_ylabel('TES state of charge (kWh)')
    
    return(fig)
