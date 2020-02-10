# -*- coding: utf-8 -*-
"""
Created on Wed Nov 27 13:44:12 2019

@author: FLomb
"""

import pandas as pd
import os
import copy 
import math

#%%
start = '2015-01-01 00:00:00'
stop = '2015-01-07 23:59:00'
x = pd.date_range(start,stop, freq='T')
x_h = pd.date_range(start,stop, freq='H')
x_h_year = pd.date_range(start,'2015-12-31 23:00:00', freq='H')

administrative_units = pd.read_csv('input_data/administrative_units.csv', sep=',')
provinces = administrative_units['province'].to_list()
regions = list(set(administrative_units['region']))
T_amb = pd.read_csv('input_data/ambient_temperatures.csv', sep=';')[361:].astype('float').set_index(x_h_year)

pv_regions = pd.read_csv('input_data/pv_2016.csv', sep=';').drop('time', axis=1).set_index(x_h_year)
cop = pd.DataFrame(index=x_h_year, columns=provinces).astype('float')
for prov in provinces:
    for t in cop.index:
        cop[prov].loc[t] = 6.81 - 0.121*(55-T_amb[prov].loc[t]) + 0.000630*math.pow((55-T_amb[prov].loc[t]),2)

cop_regions = pd.DataFrame(index=x_h_year, columns=regions).astype('float')
for reg in regions:
    cop_regions[reg] = cop[administrative_units[administrative_units['region'] == reg]['province']]

# ordered_columns = ['Piemonte',"Valle D'Aosta",'Lombardia','Trentino Alto Adige','Veneto','Friuli Venezia Giulia',
#                    'Liguria','Emilia-Romagna', 'Toscana','Umbria','Marche','Lazio','Abruzzo','Campania','Molise',
#                    'Puglia','Basilicata','Calabria', 'Sicilia','Sardegna']
# calliope_columns = ['R1','R2','R3','R4','R5','R6','R7','R8','R9','R10',
#                     'R11','R12','R13','R14','R15','R16','R17','R18','SICI','SARD']

# pv_regions = pv_regions[ordered_columns]
# pv_regions.columns = calliope_columns
# cop_regions = cop_regions[ordered_columns]
# cop_regions.columns = calliope_columns

pv_regions.to_csv('processed_data/solar_resource_regions.csv', sep=',')
cop.to_csv('processed_data/cop_dhw.csv', sep=',')
cop_regions.to_csv('processed_data/cop_dhw_regions.csv', sep=',')
