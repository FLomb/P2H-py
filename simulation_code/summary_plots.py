# -*- coding: utf-8 -*-
"""
Created on Wed Oct  9 15:17:38 2019

@author: FLomb
"""
import seaborn as sns
import matplotlib.pyplot as plt
import geopandas as gpd
import pandas as pd
import numpy as np
import os


#%% Choropleth map NRMSE

def choropleth_map_nrmse(regional_p2h_nrmse):
    
    regions_geo = f'regioni.geojson'    
    
    nrmse_hp_con = pd.DataFrame(index=['hp_con'], columns=list(regional_p2h_nrmse.keys()))
    nrmse_tes_soc = pd.DataFrame(index=['tes_soc'], columns=list(regional_p2h_nrmse.keys()))
    
    for col in nrmse_hp_con.columns:
        nrmse_hp_con[col] = regional_p2h_nrmse[col][0]*100
        nrmse_tes_soc[col] = regional_p2h_nrmse[col][1]*100

    
    lista_regioni = ['Piemonte', "Valle D'Aosta", 'Lombardia', 'Trentino Alto Adige',
                     'Veneto', 'Friuli Venezia Giulia', 'Liguria', 'Emilia-Romagna',
                     'Toscana', 'Umbria', 'Marche', 'Lazio', 'Abruzzo', 'Molise',
                     'Campania', 'Puglia', 'Basilicata', 'Calabria', 'Sicilia',
                     'Sardegna']
    
    map_df = gpd.read_file(regions_geo)
    map_df['NOME_REG'] = lista_regioni
    merged_hp = map_df.set_index('NOME_REG').join(nrmse_hp_con.T)
    merged_tes = map_df.set_index('NOME_REG').join(nrmse_tes_soc.T)

    vmin, vmax = 0, 20
    
    fig, (ax1, ax2) = plt.subplots(1,2, sharey='row', gridspec_kw = {'height_ratios':[1], 'wspace':0.1, 'hspace':0.25}, figsize=(12,10))
    
    or_reds = plt.cm.get_cmap('OrRd', 10)
  
    merged_hp.plot(column='hp_con', cmap=or_reds, vmax=vmax, linewidth=0.8, ax=ax1, edgecolor='0.7')
    merged_tes.plot(column='tes_soc', cmap=or_reds, vmax=vmax, linewidth=0.8, ax=ax2, edgecolor='0.7')

    sm_hp = plt.cm.ScalarMappable(cmap=or_reds, norm=plt.Normalize(vmin=vmin, vmax=vmax))
    cbar = fig.colorbar(sm_hp, ax=ax2, fraction=0.045, pad=0.04)
    
    ax1.tick_params(axis='both', which='both', bottom=False, left=False, labelbottom=False, labelleft=False)
    ax2.tick_params(axis='both', which='both', bottom=False, left=False, labelbottom=False, labelleft=False)

    ax1.axis('off')
    ax1.set_title('NRMSE - P2H consumption (%)', weight='bold')
    ax2.axis('off')
    ax2.set_title('NRMSE - TES State of Charge (%)', weight='bold')

    fig.tight_layout()

    return(fig)
    
#%% Choropleth map energy data

def choropleth_map_energy(regional_p2h_dict, regional_prof_matr):
    
    regions_geo = f'regioni.geojson'    
    
    nrm_hp_con = pd.DataFrame(index=['hp_con'], columns=list(regional_p2h_dict.keys()))
    nrm_tes_soc = pd.DataFrame(index=['tes_soc'], columns=list(regional_p2h_dict.keys()))
    
    for col in nrm_hp_con.columns:
        nrm_hp_con[col] = (regional_p2h_dict[col]['en_con_hp']/len(regional_prof_matr[col].columns)).sum()
        nrm_tes_soc[col] = (regional_p2h_dict[col]['soc_tes']/len(regional_prof_matr[col].columns)).mean()

    
    lista_regioni = ['Piemonte', "Valle D'Aosta", 'Lombardia', 'Trentino Alto Adige',
                     'Veneto', 'Friuli Venezia Giulia', 'Liguria', 'Emilia-Romagna',
                     'Toscana', 'Umbria', 'Marche', 'Lazio', 'Abruzzo', 'Molise',
                     'Campania', 'Puglia', 'Basilicata', 'Calabria', 'Sicilia',
                     'Sardegna']
    
    map_df = gpd.read_file(regions_geo)
    map_df['NOME_REG'] = lista_regioni
    merged_hp = map_df.set_index('NOME_REG').join(nrm_hp_con.T)
    merged_tes = map_df.set_index('NOME_REG').join(nrm_tes_soc.T)

    vmin, vmax = 0, 25
    
    fig, (ax1, ax2) = plt.subplots(1,2, sharey='row', gridspec_kw = {'height_ratios':[1], 'wspace':0.1, 'hspace':0.25}, figsize=(12,10))
    
    reds = plt.cm.get_cmap('Reds', 10)
    purples = plt.cm.get_cmap('Purples', 10)
    
    merged_hp.plot(column='hp_con', cmap=reds, vmax=vmax, linewidth=0.8, ax=ax1, edgecolor='0.7')
    merged_tes.plot(column='tes_soc', cmap=purples, vmax=vmax, linewidth=0.8, ax=ax2, edgecolor='0.7')

    sm_hp = plt.cm.ScalarMappable(cmap=reds, norm=plt.Normalize(vmin=vmin, vmax=vmax))
    sm_tes = plt.cm.ScalarMappable(cmap=purples, norm=plt.Normalize(vmin=vmin, vmax=vmax))
    
    cbar = fig.colorbar(sm_hp, ax=ax1, fraction=0.045, pad=0.04)
    cbar2 = fig.colorbar(sm_tes, ax=ax2, fraction=0.045, pad=0.04)
    
    ax1.tick_params(axis='both', which='both', bottom=False, left=False, labelbottom=False, labelleft=False)
    ax2.tick_params(axis='both', which='both', bottom=False, left=False, labelbottom=False, labelleft=False)

    ax1.axis('off')
    ax1.set_title('P2H weekly consumption (kWh/user)', weight='bold')
    ax2.axis('off')
    ax2.set_title('TES average state of Charge (kWh/user)', weight='bold')

    fig.tight_layout()

    return(fig)