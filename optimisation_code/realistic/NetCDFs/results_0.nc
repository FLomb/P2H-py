�HDF

                    ��������9�     ��������        `                               OHDRb"     �       ��      uv      �v      
          �      `      �       
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             Ryp9FRHP              �      �o      �       �              P             Δ                                            (  A      3�`BTHD       d(�              j�˩BTHD 	      d(�              -}4BFSHD  g                            P x (        <     D       D       .8WBTLF      9      $� �    L     �*%    J     l3�- v   P  	   �J7 @   
    kW�G �   7     @�k          �T�v �    �     ���          Ûŀ �   �    �2� �   ;  
   ��    `     ���� O    1     ʻ#� �    ,     ��N����                                                                                                                                                                                                                                                                        BTLF 	     9       O    1      �    ,      @   
     �    L      �    �      �   �     �   7         `      v   P  	    �   ;  
                           J     ӟO                                                                                                                                                                                                                                                                                                                                BTHD       d(�n              \���    _model_run         �Z         scenario:
applied_overrides: ''
techs:
  demand_dhw:
    inheritance:
    - demand
    essentials:
      parent: demand
      carrier: dhw
      color: '#F507D8'
      name: DHW demand
      carrier_in: dhw
      carrier_out: resource
    constraints: {}
    required_constraints:
    - resource
    allowed_constraints:
    - energy_con
    - force_resource
    - resource
    - resource_area_equals
    - resource_scale
    - resource_unit
    allowed_group_constraints:
    - cost_max
    - cost_min
    - cost_equals
    - cost_var_max
    - cost_var_min
    - cost_var_equals
    allowed_costs:
    - om_con
  grid:
    inheritance:
    - supply
    essentials:
      parent: supply
      carrier_out: electricity
      color: '#9CBC90'
      name: Electricity grid
      carrier_in: resource
    constraints: {}
    required_constraints: []
    allowed_constraints:
    - energy_cap_equals
    - energy_cap_equals_systemwide
    - energy_cap_max
    - energy_cap_max_systemwide
    - energy_cap_min
    - energy_cap_min_use
    - energy_cap_per_unit
    - energy_cap_scale
    - energy_eff
    - energy_prod
    - energy_ramping
    - export_cap
    - export_carrier
    - force_resource
    - lifetime
    - resource
    - resource_area_equals
    - resource_area_max
    - resource_area_min
    - resource_area_per_energy_cap
    - resource_min_use
    - resource_scale
    - resource_unit
    - units_equals
    - units_equals_systemwide
    - units_max
    - units_max_systemwide
    - units_min
    allowed_group_constraints:
    - demand_share_min
    - demand_share_max
    - demand_share_equals
    - demand_share_per_timestep_min
    - demand_share_per_timestep_max
    - demand_share_per_timestep_equals
    - demand_share_per_timestep_decision
    - supply_share_min
    - supply_share_max
    - supply_share_equals
    - supply_share_per_timestep_min
    - supply_share_per_timestep_max
    - supply_share_per_timestep_equals
    - cost_max
    - cost_min
    - cost_equals
    - cost_var_max
    - cost_var_min
    - cost_var_equals
    - cost_investment_min
    - cost_investment_max
    - cost_investment_equals
    - energy_cap_share_min
    - energy_cap_share_max
    - energy_cap_min
    - energy_cap_max
    - resource_area_min
    - resource_area_max
    allowed_costs:
    - depreciation_rate
    - energy_cap
    - export
    - interest_rate
    - om_annual
    - om_annual_investment_fraction
    - om_con
    - om_prod
    - purchase
    - resource_area
  hp_dhw:
    inheritance:
    - conversion
    essentials:
      parent: conversion
      carrier_in: electricity
      carrier_out: dhw
      color: '#E33B78'
      name: HP DHW
      primary_carrier_in: electricity
      primary_carrier_out: dhw
    constraints: {}
    required_constraints: []
    allowed_constraints:
    - energy_cap_equals
    - energy_cap_equals_systemwide
    - energy_cap_max
    - energy_cap_max_systemwide
    - energy_cap_min
    - energy_cap_min_use
    - energy_cap_per_unit
    - energy_cap_scale
    - energy_con
    - energy_eff
    - energy_prod
    - energy_ramping
    - export_cap
    - export_carrier
    - lifetime
    - units_equals
    - units_equals_systemwide
    - units_max
    - units_max_systemwide
    - units_min
    allowed_group_constraints:
    - demand_share_min
    - demand_share_max
    - demand_share_equals
    - demand_share_per_timestep_min
    - demand_share_per_timestep_max
    - demand_share_per_timestep_equals
    - demand_share_per_timestep_decision
    - supply_share_min
    - supply_share_max
    - supply_share_equals
    - supply_share_per_timestep_min
    - supply_share_per_timestep_max
    - supply_share_per_timestep_equals
    - cost_max
    - cost_min
    - cost_equals
    - cost_var_max
    - cost_var_min
    - cost_var_equals
    - cost_investment_min
    - cost_investment_max
    - cost_investment_equals
    - energy_cap_share_min
    - energy_cap_share_max
    - energy_cap_min
    - energy_cap_max
    allowed_costs:
    - depreciation_rate
    - energy_cap
    - export
    - interest_rate
    - om_annual
    - om_annual_investment_fraction
    - om_con
    - om_prod
    - purchase
  pv_rooftop:
    inheritance:
    - supply_plus
    essentials:
      parent: supply_plus
      carrier_out: electricity
      color: '#F3F149'
      name: Photovoltaic power distributed
      carrier_in: resource
    constraints: {}
    required_constraints: []
    allowed_constraints:
    - charge_rate
    - energy_cap_per_storage_cap_min
    - energy_cap_per_storage_cap_max
    - energy_cap_per_storage_cap_equals
    - energy_cap_equals
    - energy_cap_equals_systemwide
    - energy_cap_max
    - energy_cap_max_systemwide
    - energy_cap_min
    - energy_cap_min_use
    - energy_cap_per_unit
    - energy_cap_scale
    - energy_eff
    - energy_prod
    - energy_ramping
    - export_cap
    - export_carrier
    - force_resource
    - lifetime
    - parasitic_eff
    - resource
    - resource_area_equals
    - resource_area_max
    - resource_area_min
    - resource_area_per_energy_cap
    - resource_cap_equals
    - resource_cap_equals_energy_cap
    - resource_cap_max
    - resource_cap_min
    - resource_eff
    - resource_min_use
    - resource_scale
    - resource_unit
    - storage_cap_equals
    - storage_cap_max
    - storage_cap_min
    - storage_cap_per_unit
    - storage_initial
    - storage_loss
    - units_equals
    - units_equals_systemwide
    - units_max
    - units_max_systemwide
    - units_min
    allowed_group_constraints:
    - demand_share_min
    - demand_share_max
    - demand_share_equals
    - demand_share_per_timestep_min
    - demand_share_per_timestep_max
    - demand_share_per_timestep_equals
    - demand_share_per_timestep_decision
    - supply_share_min
    - supply_share_max
    - supply_share_equals
    - supply_share_per_timestep_min
    - supply_share_per_timestep_max
    - supply_share_per_timestep_equals
    - cost_max
    - cost_min
    - cost_equals
    - cost_var_max
    - cost_var_min
    - cost_var_equals
    - cost_investment_min
    - cost_investment_max
    - cost_investment_equals
    - energy_cap_share_min
    - energy_cap_share_max
    - energy_cap_min
    - energy_cap_max
    - resource_area_min
    - resource_area_max
    allowed_costs:
    - depreciation_rate
    - energy_cap
    - export
    - interest_rate
    - om_annual
    - om_annual_investment_fraction
    - om_con
    - om_prod
    - purchase
    - resource_area
    - resource_cap
    - storage_cap
  tes_dhw:
    inheritance:
    - storage
    essentials:
      parent: storage
      carrier: dhw
      color: '#F0A0BD'
      name: Thermal storage DHW
      carrier_in: dhw
      carrier_out: dhw
    constraints: {}
    required_constraints: []
    allowed_constraints:
    - charge_rate
    - energy_cap_per_storage_cap_min
    - energy_cap_per_storage_cap_max
    - energy_cap_per_storage_cap_equals
    - energy_cap_equals
    - energy_cap_equals_systemwide
    - energy_cap_max
    - energy_cap_max_systemwide
    - energy_cap_min
    - energy_cap_min_use
    - energy_cap_per_unit
    - energy_cap_scale
    - energy_con
    - energy_eff
    - energy_prod
    - energy_ramping
    - export_cap
    - export_carrier
    - force_asynchronous_prod_con
    - lifetime
    - storage_cap_equals
    - storage_cap_max
    - storage_cap_min
    - storage_cap_per_unit
    - storage_initial
    - storage_loss
    - storage_time_max
    - storage_discharge_depth
    - units_equals
    - units_equals_systemwide
    - units_max
    - units_max_systemwide
    - units_min
    allowed_group_constraints:
    - cost_max
    - cost_min
    - cost_equals
    - cost_var_max
    - cost_var_min
    - cost_var_equals
    - cost_investment_min
    - cost_investment_max
    - cost_investment_equals
    - energy_cap_share_min
    - energy_cap_share_max
    - energy_cap_min
    - energy_cap_max
    allowed_costs:
    - depreciation_rate
    - energy_cap
    - export
    - interest_rate
    - om_annual
    - om_annual_investment_fraction
    - om_prod
    - purchase
    - storage_cap
tech_groups:
  conversion:
  - hp_dhw
  conversion_plus: []
  demand:
  - demand_dhw
  storage:
  - tes_dhw
  supply:
  - grid
  supply_plus:
  - pv_rooftop
  transmission: []
locations:
  dwelling:
    techs:
      demand_dhw:
        constraints:
          resource: file=demand_dhw.csv:dwelling
          energy_con: true
          force_resource: true
          resource_unit: energy
      grid:
        constraints:
          energy_cap_equals: 100
          energy_prod: true
          force_resource: false
          lifetime: 80
          resource: inf
          resource_unit: energy
        costs:
          monetary:
            om_prod: 0.4
      hp_dhw:
        constraints:
          energy_cap_equals: 2.2
          energy_con: true
          energy_eff: file=cop_dhw.csv:dwelling
          energy_prod: true
          lifetime: 30
        costs:
          monetary:
            depreciation_rate: 0.1060792482526339
            energy_cap: 300
            om_prod: 0.04
      pv_rooftop:
        constraints:
          energy_cap_equals: 2
          energy_prod: true
          force_resource: true
          lifetime: 30
          resource: file=solar_resource.csv:dwelling
          resource_eff: 1.0
          resource_unit: energy_per_cap
        costs:
          monetary:
            depreciation_rate: 0.1060792482526339
            energy_cap: 2200
            om_annual: 43
            om_prod: 0.0411
      tes_dhw:
        constraints:
          energy_cap_equals: 2.2
          storage_cap_equals: 3.7
          energy_con: true
          energy_eff: 1
          energy_prod: true
          lifetime: 40
          storage_cap_max: inf
          storage_discharge_depth: 0.625
          storage_initial: 0.625
          storage_loss: 0.01
        costs:
          monetary:
            depreciation_rate: 0.1022594144143695
            energy_cap: 50
            om_prod: 0.01
run:
  backend: pyomo
  bigM: 1000000.0
  cyclic_storage: true
  ensure_feasibility: true
  mode: plan
  objective_options:
    cost_class:
      monetary: 1
    sense: minimize
  objective: minmax_cost_optimization
  operation:
    window: 24
    horizon: 48
    use_cap_results: false
  save_logs:
  solver_io:
  solver_options:
    BarConvTol: 0.0001
    BarHomogeneous: 1
    Crossover: 0
    FeasibilityTol: 1e-05
    Method: 2
    OptimalityTol: 1e-05
  solver: gurobi
  zero_threshold: 1e-10
model:
  calliope_version: 0.6.3
  group_share: {}
  name: Heat-pump prova
  random_seed:
  reserve_margin:
    electricity: 0.1
  subset_time:
  - '2015-01-01'
  - '2015-01-07'
  time: {}
  timeseries_data_path: timeseries_data
  timeseries_data:
  timeseries_dateformat: '%Y-%m-%d %H:%M:%S'
  file_allowed:
  - clustering_func
  - energy_con
  - energy_eff
  - energy_prod
  - energy_ramping
  - export
  - force_resource
  - om_con
  - om_prod
  - parasitic_eff
  - resource
  - resource_eff
  - storage_loss
  - carrier_ratios
group_constraints: {}
sets:
  resources:
  - resource
  - dhw
  - electricity
  carriers:
  - dhw
  - electricity
  carrier_tiers:
  - out
  - in
  costs:
  - monetary
  locs:
  - dwelling
  techs_non_transmission:
  - grid
  - tes_dhw
  - hp_dhw
  - demand_dhw
  - pv_rooftop
  techs_demand:
  - demand_dhw
  techs_supply:
  - grid
  techs_supply_plus:
  - pv_rooftop
  techs_conversion:
  - hp_dhw
  techs_conversion_plus: []
  techs_storage:
  - tes_dhw
  techs_transmission_names: []
  techs_transmission: []
  techs:
  - grid
  - tes_dhw
  - hp_dhw
  - demand_dhw
  - pv_rooftop
  timesteps:
  - '2015-01-01 00:00:00'
  - '2015-01-01 01:00:00'
  - '2015-01-01 02:00:00'
  - '2015-01-01 03:00:00'
  - '2015-01-01 04:00:00'
  - '2015-01-01 05:00:00'
  - '2015-01-01 06:00:00'
  - '2015-01-01 07:00:00'
  - '2015-01-01 08:00:00'
  - '2015-01-01 09:00:00'
  - '2015-01-01 10:00:00'
  - '2015-01-01 11:00:00'
  - '2015-01-01 12:00:00'
  - '2015-01-01 13:00:00'
  - '2015-01-01 14:00:00'
  - '2015-01-01 15:00:00'
  - '2015-01-01 16:00:00'
  - '2015-01-01 17:00:00'
  - '2015-01-01 18:00:00'
  - '2015-01-01 19:00:00'
  - '2015-01-01 20:00:00'
  - '2015-01-01 21:00:00'
  - '2015-01-01 22:00:00'
  - '2015-01-01 23:00:00'
  - '2015-01-02 00:00:00'
  - '2015-01-02 01:00:00'
  - '2015-01-02 02:00:00'
  - '2015-01-02 03:00:00'
  - '2015-01-02 04:00:00'
  - '2015-01-02 05:00:00'
  - '2015-01-02 06:00:00'
  - '2015-01-02 07:00:00'
  - '2015-01-02 08:00:00'
  - '2015-01-02 09:00:00'
  - '2015-01-02 10:00:00'
  - '2015-01-02 11:00:00'
  - '2015-01-02 12:00:00'
  - '2015-01-02 13:00:00'
  - '2015-01-02 14:00:00'
  - '2015-01-02 15:00:00'
  - '2015-01-02 16:00:00'
  - '2015-01-02 17:00:00'
  - '2015-01-02 18:00:00'
  - '2015-01-02 19:00:00'
  - '2015-01-02 20:00:00'
  - '2015-01-02 21:00:00'
  - '2015-01-02 22:00:00'
  - '2015-01-02 23:00:00'
  - '2015-01-03 00:00:00'
  - '2015-01-03 01:00:00'
  - '2015-01-03 02:00:00'
  - '2015-01-03 03:00:00'
  - '2015-01-03 04:00:00'
  - '2015-01-03 05:00:00'
  - '2015-01-03 06:00:00'
  - '2015-01-03 07:00:00'
  - '2015-01-03 08:00:00'
  - '2015-01-03 09:00:00'
  - '2015-01-03 10:00:00'
  - '2015-01-03 11:00:00'
  - '2015-01-03 12:00:00'
  - '2015-01-03 13:00:00'
  - '2015-01-03 14:00:00'
  - '2015-01-03 15:00:00'
  - '2015-01-03 16:00:00'
  - '2015-01-03 17:00:00'
  - '2015-01-03 18:00:00'
  - '2015-01-03 19:00:00'
  - '2015-01-03 20:00:00'
  - '2015-01-03 21:00:00'
  - '2015-01-03 22:00:00'
  - '2015-01-03 23:00:00'
  - '2015-01-04 00:00:00'
  - '2015-01-04 01:00:00'
  - '2015-01-04 02:00:00'
  - '2015-01-04 03:00:00'
  - '2015-01-04 04:00:00'
  - '2015-01-04 05:00:00'
  - '2015-01-04 06:00:00'
  - '2015-01-04 07:00:00'
  - '2015-01-04 08:00:00'
  - '2015-01-04 09:00:00'
  - '2015-01-04 10:00:00'
  - '2015-01-04 11:00:00'
  - '2015-01-04 12:00:00'
  - '2015-01-04 13:00:00'
  - '2015-01-04 14:00:00'
  - '2015-01-04 15:00:00'
  - '2015-01-04 16:00:00'
  - '2015-01-04 17:00:00'
  - '2015-01-04 18:00:00'
  - '2015-01-04 19:00:00'
  - '2015-01-04 20:00:00'
  - '2015-01-04 21:00:00'
  - '2015-01-04 22:00:00'
  - '2015-01-04 23:00:00'
  - '2015-01-05 00:00:00'
  - '2015-01-05 01:00:00'
  - '2015-01-05 02:00:00'
  - '2015-01-05 03:00:00'
  - '2015-01-05 04:00:00'
  - '2015-01-05 05:00:00'
  - '2015-01-05 06:00:00'
  - '2015-01-05 07:00:00'
  - '2015-01-05 08:00:00'
  - '2015-01-05 09:00:00'
  - '2015-01-05 10:00:00'
  - '2015-01-05 11:00:00'
  - '2015-01-05 12:00:00'
  - '2015-01-05 13:00:00'
  - '2015-01-05 14:00:00'
  - '2015-01-05 15:00:00'
  - '2015-01-05 16:00:00'
  - '2015-01-05 17:00:00'
  - '2015-01-05 18:00:00'
  - '2015-01-05 19:00:00'
  - '2015-01-05 20:00:00'
  - '2015-01-05 21:00:00'
  - '2015-01-05 22:00:00'
  - '2015-01-05 23:00:00'
  - '2015-01-06 00:00:00'
  - '2015-01-06 01:00:00'
  - '2015-01-06 02:00:00'
  - '2015-01-06 03:00:00'
  - '2015-01-06 04:00:00'
  - '2015-01-06 05:00:00'
  - '2015-01-06 06:00:00'
  - '2015-01-06 07:00:00'
  - '2015-01-06 08:00:00'
  - '2015-01-06 09:00:00'
  - '2015-01-06 10:00:00'
  - '2015-01-06 11:00:00'
  - '2015-01-06 12:00:00'
  - '2015-01-06 13:00:00'
  - '2015-01-06 14:00:00'
  - '2015-01-06 15:00:00'
  - '2015-01-06 16:00:00'
  - '2015-01-06 17:00:00'
  - '2015-01-06 18:00:00'
  - '2015-01-06 19:00:00'
  - '2015-01-06 20:00:00'
  - '2015-01-06 21:00:00'
  - '2015-01-06 22:00:00'
  - '2015-01-06 23:00:00'
  - '2015-01-07 00:00:00'
  - '2015-01-07 01:00:00'
  - '2015-01-07 02:00:00'
  - '2015-01-07 03:00:00'
  - '2015-01-07 04:00:00'
  - '2015-01-07 05:00:00'
  - '2015-01-07 06:00:00'
  - '2015-01-07 07:00:00'
  - '2015-01-07 08:00:00'
  - '2015-01-07 09:00:00'
  - '2015-01-07 10:00:00'
  - '2015-01-07 11:00:00'
  - '2015-01-07 12:00:00'
  - '2015-01-07 13:00:00'
  - '2015-01-07 14:00:00'
  - '2015-01-07 15:00:00'
  - '2015-01-07 16:00:00'
  - '2015-01-07 17:00:00'
  - '2015-01-07 18:00:00'
  - '2015-01-07 19:00:00'
  - '2015-01-07 20:00:00'
  - '2015-01-07 21:00:00'
  - '2015-01-07 22:00:00'
  - '2015-01-07 23:00:00'
  techlists: []
  group_constraints: []
  loc_carriers:
  - dwelling::electricity
  - dwelling::dhw
  loc_tech_carriers_con:
  - dwelling::tes_dhw::dhw
  - dwelling::demand_dhw::dhw
  - dwelling::hp_dhw::electricity
  loc_tech_carriers_conversion_all:
  - dwelling::hp_dhw::dhw
  loc_tech_carriers_conversion_plus: []
  loc_tech_carriers_demand:
  - dwelling::demand_dhw::dhw
  loc_tech_carriers_export: []
  loc_tech_carriers_prod:
  - dwelling::tes_dhw::dhw
  - dwelling::hp_dhw::dhw
  - dwelling::grid::electricity
  - dwelling::pv_rooftop::electricity
  loc_tech_carriers_supply_all:
  - dwelling::grid::electricity
  - dwelling::pv_rooftop::electricity
  loc_tech_carriers_supply_conversion_all:
  - dwelling::hp_dhw::dhw
  - dwelling::grid::electricity
  - dwelling::pv_rooftop::electricity
  loc_techs:
  - dwelling::pv_rooftop
  - dwelling::tes_dhw
  - dwelling::hp_dhw
  - dwelling::grid
  - dwelling::demand_dhw
  loc_techs_area: []
  loc_techs_asynchronous_prod_con: []
  loc_techs_conversion:
  - dwelling::hp_dhw
  loc_techs_conversion_all:
  - dwelling::hp_dhw
  loc_techs_conversion_plus: []
  loc_techs_cost:
  - dwelling::pv_rooftop
  - dwelling::tes_dhw
  - dwelling::hp_dhw
  - dwelling::grid
  loc_techs_costs_export: []
  loc_techs_demand:
  - dwelling::demand_dhw
  loc_techs_export: []
  loc_techs_finite_resource:
  - dwelling::pv_rooftop
  - dwelling::demand_dhw
  loc_techs_finite_resource_demand:
  - dwelling::demand_dhw
  loc_techs_finite_resource_supply: []
  loc_techs_finite_resource_supply_plus:
  - dwelling::pv_rooftop
  loc_techs_in_2: []
  loc_techs_in_3: []
  loc_techs_investment_cost:
  - dwelling::pv_rooftop
  - dwelling::tes_dhw
  - dwelling::hp_dhw
  loc_techs_milp: []
  loc_techs_non_conversion:
  - dwelling::pv_rooftop
  - dwelling::tes_dhw
  - dwelling::grid
  - dwelling::demand_dhw
  loc_techs_non_transmission:
  - dwelling::pv_rooftop
  - dwelling::tes_dhw
  - dwelling::hp_dhw
  - dwelling::grid
  - dwelling::demand_dhw
  loc_techs_om_cost:
  - dwelling::pv_rooftop
  - dwelling::tes_dhw
  - dwelling::hp_dhw
  - dwelling::grid
  loc_techs_om_cost_conversion:
  - dwelling::hp_dhw
  loc_techs_om_cost_conversion_plus: []
  loc_techs_om_cost_supply:
  - dwelling::grid
  loc_techs_om_cost_supply_plus:
  - dwelling::pv_rooftop
  loc_techs_out_2: []
  loc_techs_out_3: []
  loc_techs_purchase: []
  loc_techs_ramping: []
  loc_techs_storage:
  - dwelling::tes_dhw
  loc_techs_store:
  - dwelling::tes_dhw
  loc_techs_supply:
  - dwelling::grid
  loc_techs_supply_all:
  - dwelling::pv_rooftop
  - dwelling::grid
  loc_techs_supply_conversion_all:
  - dwelling::pv_rooftop
  - dwelling::hp_dhw
  - dwelling::grid
  loc_techs_supply_plus:
  - dwelling::pv_rooftop
  loc_techs_transmission: []
constraint_sets:
  loc_carriers_system_balance_constraint:
  - dwelling::electricity
  - dwelling::dhw
  loc_techs_balance_supply_constraint: []
  loc_techs_balance_demand_constraint:
  - dwelling::demand_dhw
  loc_techs_resource_availability_supply_plus_constraint:
  - dwelling::pv_rooftop
  loc_techs_balance_transmission_constraint: []
  loc_techs_balance_supply_plus_constraint:
  - dwelling::pv_rooftop
  loc_techs_balance_storage_constraint:
  - dwelling::tes_dhw
  loc_techs_storage_initial_constraint:
  - dwelling::tes_dhw
  loc_techs_storage_discharge_depth:
  - dwelling::tes_dhw
  carriers_reserve_margin_constraint:
  - electricity
  loc_techs_cost_constraint:
  - dwelling::pv_rooftop
  - dwelling::tes_dhw
  - dwelling::hp_dhw
  - dwelling::grid
  loc_techs_cost_investment_constraint:
  - dwelling::pv_rooftop
  - dwelling::tes_dhw
  - dwelling::hp_dhw
  loc_techs_cost_var_constraint:
  - dwelling::pv_rooftop
  - dwelling::tes_dhw
  - dwelling::grid
  loc_carriers_update_system_balance_constraint: []
  loc_tech_carriers_export_balance_constraint: []
  loc_techs_update_costs_var_constraint: []
  loc_tech_carriers_export_max_constraint: []
  loc_techs_storage_capacity_constraint:
  - dwelling::tes_dhw
  loc_techs_energy_capacity_storage_constraint_old: []
  loc_techs_energy_capacity_storage_equals_constraint: []
  loc_techs_energy_capacity_storage_min_constraint: []
  loc_techs_energy_capacity_storage_max_constraint: []
  loc_techs_resource_capacity_constraint: []
  loc_techs_resource_capacity_equals_energy_capacity_constraint: []
  loc_techs_resource_area_constraint: []
  loc_techs_resource_area_per_energy_capacity_constraint: []
  locs_resource_area_capacity_per_loc_constraint: []
  loc_techs_energy_capacity_constraint:
  - dwelling::pv_rooftop
  - dwelling::tes_dhw
  - dwelling::hp_dhw
  - dwelling::grid
  - dwelling::demand_dhw
  techs_energy_capacity_systemwide_constraint: []
  loc_tech_carriers_carrier_production_max_constraint:
  - dwelling::tes_dhw::dhw
  - dwelling::hp_dhw::dhw
  - dwelling::grid::electricity
  - dwelling::pv_rooftop::electricity
  loc_tech_carriers_carrier_production_min_constraint: []
  loc_tech_carriers_carrier_consumption_max_constraint:
  - dwelling::tes_dhw::dhw
  - dwelling::demand_dhw::dhw
  loc_techs_resource_max_constraint:
  - dwelling::pv_rooftop
  loc_tech_carriers_ramping_constraint: []
  loc_techs_storage_max_constraint:
  - dwelling::tes_dhw
  loc_techs_unit_commitment_milp_constraint: []
  loc_techs_unit_capacity_milp_constraint: []
  loc_tech_carriers_carrier_production_max_milp_constraint: []
  loc_techs_carrier_production_max_conversion_plus_milp_constraint: []
  loc_tech_carriers_carrier_production_min_milp_constraint: []
  loc_techs_carrier_production_min_conversion_plus_milp_constraint: []
  loc_tech_carriers_carrier_consumption_max_milp_constraint: []
  loc_techs_energy_capacity_units_milp_constraint: []
  loc_techs_storage_capacity_units_milp_constraint: []
  loc_techs_energy_capacity_max_purchase_milp_constraint: []
  loc_techs_energy_capacity_min_purchase_milp_constraint: []
  loc_techs_storage_capacity_max_purchase_milp_constraint: []
  loc_techs_storage_capacity_min_purchase_milp_constraint: []
  loc_techs_update_costs_investment_units_milp_constraint: []
  loc_techs_update_costs_investment_purchase_milp_constraint: []
  techs_unit_capacity_systemwide_milp_constraint: []
  loc_techs_asynchronous_prod_con_milp_constraint: []
  loc_techs_balance_conversion_constraint:
  - dwelling::hp_dhw
  loc_techs_cost_var_conversion_constraint:
  - dwelling::hp_dhw
  loc_techs_balance_conversion_plus_primary_constraint: []
  loc_techs_carrier_production_max_conversion_plus_constraint: []
  loc_techs_carrier_production_min_conversion_plus_constraint: []
  loc_techs_cost_var_conversion_plus_constraint: []
  loc_techs_balance_conversion_plus_in_2_constraint: []
  loc_techs_balance_conversion_plus_in_3_constraint: []
  loc_techs_balance_conversion_plus_out_2_constraint: []
  loc_techs_balance_conversion_plus_out_3_constraint: []
  loc_techs_symmetric_transmission_constraint: []
  techlists_group_share_energy_cap_min_constraint: []
  techlists_group_share_energy_cap_max_constraint: []
  techlists_group_share_energy_cap_equals_constraint: []
  techlists_carrier_group_share_carrier_prod_min_constraint: []
  techlists_carrier_group_share_carrier_prod_max_constraint: []
  techlists_carrier_group_share_carrier_prod_equals_constraint: []
  constraint_groups: []
BTLF $      �Z             �v      �9             wW��                                                                                                                                                                                                                                                                                                                                                                                                                                                                      OHDRM                                                 �                   �            �     �            ������������������������0        CLASS                DIMENSION_SCALE -       NAME                 loc_carriers 4       _Netcdf4Dimid                             ��j!OHDRV                                                 �                   �             ��     �            ������������������������0        CLASS                DIMENSION_SCALE 6       NAME                 loc_tech_carriers_con 4       _Netcdf4Dimid                            |���OHDR                                                 �                   �             �I     Z            ������������������������0        CLASS                DIMENSION_SCALE 7       NAME                 loc_tech_carriers_prod   !���OHDRJ                                                 �                   �            ٴ     .          	 ������������������������0        CLASS                DIMENSION_SCALE *       NAME       
          loc_techs 4       _Netcdf4Dimid                            0$��     5 4       _Netcdf4Dimid                          �qcBTHD      d(8      h       T��BTHD      d(N�       h       ���                                                         _debug_data        �9         comments:
  model_run:
    techs:
      demand_dhw:
        essentials:
          parent: From parent tech_group `demand`
          carrier_in: Set from essentials.carrier
      grid:
        essentials:
          parent: From parent tech_group `supply`
      hp_dhw:
        essentials:
          parent: From parent tech_group `conversion`
      pv_rooftop:
        essentials:
          parent: From parent tech_group `supply_plus`
      tes_dhw:
        essentials:
          parent: From parent tech_group `storage`
          carrier_in: Set from essentials.carrier
    locations: {}
config_initial:
  run:
    backend: pyomo
    bigM: 1000000.0
    cyclic_storage: true
    ensure_feasibility: true
    mode: plan
    objective_options:
      cost_class:
        monetary: 1
      sense: minimize
    objective: minmax_cost_optimization
    operation:
      window: 24
      horizon: 48
      use_cap_results: false
    save_logs:
    solver_io:
    solver_options:
      BarConvTol: 0.0001
      BarHomogeneous: 1
      Crossover: 0
      FeasibilityTol: 1e-05
      Method: 2
      OptimalityTol: 1e-05
    solver: gurobi
    zero_threshold: 1e-10
  model:
    calliope_version: 0.6.3
    group_share: {}
    name: Heat-pump prova
    random_seed:
    reserve_margin:
      electricity: 0.1
    subset_time:
    - '2015-01-01'
    - '2015-01-07'
    time: {}
    timeseries_data_path: timeseries_data
    timeseries_data:
    timeseries_dateformat: '%Y-%m-%d %H:%M:%S'
    file_allowed:
    - clustering_func
    - energy_con
    - energy_eff
    - energy_prod
    - energy_ramping
    - export
    - force_resource
    - om_con
    - om_prod
    - parasitic_eff
    - resource
    - resource_eff
    - storage_loss
    - carrier_ratios
  tech_groups:
    conversion:
      required_constraints: []
      allowed_constraints:
      - energy_cap_equals
      - energy_cap_equals_systemwide
      - energy_cap_max
      - energy_cap_max_systemwide
      - energy_cap_min
      - energy_cap_min_use
      - energy_cap_per_unit
      - energy_cap_scale
      - energy_con
      - energy_eff
      - energy_prod
      - energy_ramping
      - export_cap
      - export_carrier
      - lifetime
      - units_equals
      - units_equals_systemwide
      - units_max
      - units_max_systemwide
      - units_min
      allowed_group_constraints:
      - demand_share_min
      - demand_share_max
      - demand_share_equals
      - demand_share_per_timestep_min
      - demand_share_per_timestep_max
      - demand_share_per_timestep_equals
      - demand_share_per_timestep_decision
      - supply_share_min
      - supply_share_max
      - supply_share_equals
      - supply_share_per_timestep_min
      - supply_share_per_timestep_max
      - supply_share_per_timestep_equals
      - cost_max
      - cost_min
      - cost_equals
      - cost_var_max
      - cost_var_min
      - cost_var_equals
      - cost_investment_min
      - cost_investment_max
      - cost_investment_equals
      - energy_cap_share_min
      - energy_cap_share_max
      - energy_cap_min
      - energy_cap_max
      allowed_costs:
      - depreciation_rate
      - energy_cap
      - export
      - interest_rate
      - om_annual
      - om_annual_investment_fraction
      - om_con
      - om_prod
      - purchase
      essentials:
        parent:
      constraints:
        energy_con: true
        energy_prod: true
    conversion_plus:
      required_constraints: []
      allowed_constraints:
      - carrier_ratios
      - energy_cap_equals
      - energy_cap_equals_systemwide
      - energy_cap_max
      - energy_cap_max_systemwide
      - energy_cap_min
      - energy_cap_min_use
      - energy_cap_per_unit
      - energy_cap_scale
      - energy_con
      - energy_eff
      - energy_prod
      - energy_ramping
      - export_cap
      - export_carrier
      - lifetime
      - units_equals
      - units_equals_systemwide
      - units_max
      - units_max_systemwide
      - units_min
      allowed_group_constraints:
      - demand_share_min
      - demand_share_max
      - demand_share_equals
      - demand_share_per_timestep_min
      - demand_share_per_timestep_max
      - demand_share_per_timestep_equals
      - demand_share_per_timestep_decision
      - supply_share_min
      - supply_share_max
      - supply_share_equals
      - supply_share_per_timestep_min
      - supply_share_per_timestep_max
      - supply_share_per_timestep_equals
      - cost_max
      - cost_min
      - cost_equals
      - cost_var_max
      - cost_var_min
      - cost_var_equals
      - cost_investment_min
      - cost_investment_max
      - cost_investment_equals
      - energy_cap_share_min
      - energy_cap_share_max
      - energy_cap_min
      - energy_cap_max
      allowed_costs:
      - depreciation_rate
      - energy_cap
      - export
      - interest_rate
      - om_annual
      - om_annual_investment_fraction
      - om_con
      - om_prod
      - purchase
      essentials:
        parent:
      constraints:
        energy_con: true
        energy_prod: true
    demand:
      required_constraints:
      - resource
      allowed_constraints:
      - energy_con
      - force_resource
      - resource
      - resource_area_equals
      - resource_scale
      - resource_unit
      allowed_group_constraints:
      - cost_max
      - cost_min
      - cost_equals
      - cost_var_max
      - cost_var_min
      - cost_var_equals
      allowed_costs:
      - om_con
      essentials:
        parent:
      constraints:
        energy_con: true
        force_resource: true
        resource_unit: energy
    storage:
      required_constraints: []
      allowed_constraints:
      - charge_rate
      - energy_cap_per_storage_cap_min
      - energy_cap_per_storage_cap_max
      - energy_cap_per_storage_cap_equals
      - energy_cap_equals
      - energy_cap_equals_systemwide
      - energy_cap_max
      - energy_cap_max_systemwide
      - energy_cap_min
      - energy_cap_min_use
      - energy_cap_per_unit
      - energy_cap_scale
      - energy_con
      - energy_eff
      - energy_prod
      - energy_ramping
      - export_cap
      - export_carrier
      - force_asynchronous_prod_con
      - lifetime
      - storage_cap_equals
      - storage_cap_max
      - storage_cap_min
      - storage_cap_per_unit
      - storage_initial
      - storage_loss
      - storage_time_max
      - storage_discharge_depth
      - units_equals
      - units_equals_systemwide
      - units_max
      - units_max_systemwide
      - units_min
      allowed_group_constraints:
      - cost_max
      - cost_min
      - cost_equals
      - cost_var_max
      - cost_var_min
      - cost_var_equals
      - cost_investment_min
      - cost_investment_max
      - cost_investment_equals
      - energy_cap_share_min
      - energy_cap_share_max
      - energy_cap_min
      - energy_cap_max
      allowed_costs:
      - depreciation_rate
      - energy_cap
      - export
      - interest_rate
      - om_annual
      - om_annual_investment_fraction
      - om_prod
      - purchase
      - storage_cap
      essentials:
        parent:
      constraints:
        energy_con: true
        energy_prod: true
        storage_cap_max: inf
    supply:
      required_constraints: []
      allowed_constraints:
      - energy_cap_equals
      - energy_cap_equals_systemwide
      - energy_cap_max
      - energy_cap_max_systemwide
      - energy_cap_min
      - energy_cap_min_use
      - energy_cap_per_unit
      - energy_cap_scale
      - energy_eff
      - energy_prod
      - energy_ramping
      - export_cap
      - export_carrier
      - force_resource
      - lifetime
      - resource
      - resource_area_equals
      - resource_area_max
      - resource_area_min
      - resource_area_per_energy_cap
      - resource_min_use
      - resource_scale
      - resource_unit
      - units_equals
      - units_equals_systemwide
      - units_max
      - units_max_systemwide
      - units_min
      allowed_group_constraints:
      - demand_share_min
      - demand_share_max
      - demand_share_equals
      - demand_share_per_timestep_min
      - demand_share_per_timestep_max
      - demand_share_per_timestep_equals
      - demand_share_per_timestep_decision
      - supply_share_min
      - supply_share_max
      - supply_share_equals
      - supply_share_per_timestep_min
      - supply_share_per_timestep_max
      - supply_share_per_timestep_equals
      - cost_max
      - cost_min
      - cost_equals
      - cost_var_max
      - cost_var_min
      - cost_var_equals
      - cost_investment_min
      - cost_investment_max
      - cost_investment_equals
      - energy_cap_share_min
      - energy_cap_share_max
      - energy_cap_min
      - energy_cap_max
      - resource_area_min
      - resource_area_max
      allowed_costs:
      - depreciation_rate
      - energy_cap
      - export
      - interest_rate
      - om_annual
      - om_annual_investment_fraction
      - om_con
      - om_prod
      - purchase
      - resource_area
      essentials:
        parent:
      constraints:
        energy_prod: true
        resource: inf
        resource_unit: energy
    supply_plus:
      required_constraints: []
      allowed_constraints:
      - charge_rate
      - energy_cap_per_storage_cap_min
      - energy_cap_per_storage_cap_max
      - energy_cap_per_storage_cap_equals
      - energy_cap_equals
      - energy_cap_equals_systemwide
      - energy_cap_max
      - energy_cap_max_systemwide
      - energy_cap_min
      - energy_cap_min_use
      - energy_cap_per_unit
      - energy_cap_scale
      - energy_eff
      - energy_prod
      - energy_ramping
      - export_cap
      - export_carrier
      - force_resource
      - lifetime
      - parasitic_eff
      - resource
      - resource_area_equals
      - resource_area_max
      - resource_area_min
      - resource_area_per_energy_cap
      - resource_cap_equals
      - resource_cap_equals_energy_cap
      - resource_cap_max
      - resource_cap_min
      - resource_eff
      - resource_min_use
      - resource_scale
      - resource_unit
      - storage_cap_equals
      - storage_cap_max
      - storage_cap_min
      - storage_cap_per_unit
      - storage_initial
      - storage_loss
      - units_equals
      - units_equals_systemwide
      - units_max
      - units_max_systemwide
      - units_min
      allowed_group_constraints:
      - demand_share_min
      - demand_share_max
      - demand_share_equals
      - demand_share_per_timestep_min
      - demand_share_per_timestep_max
      - demand_share_per_timestep_equals
      - demand_share_per_timestep_decision
      - supply_share_min
      - supply_share_max
      - supply_share_equals
      - supply_share_per_timestep_min
      - supply_share_per_timestep_max
      - supply_share_per_timestep_equals
      - cost_max
      - cost_min
      - cost_equals
      - cost_var_max
      - cost_var_min
      - cost_var_equals
      - cost_investment_min
      - cost_investment_max
      - cost_investment_equals
      - energy_cap_share_min
      - energy_cap_share_max
      - energy_cap_min
      - energy_cap_max
      - resource_area_min
      - resource_area_max
      allowed_costs:
      - depreciation_rate
      - energy_cap
      - export
      - interest_rate
      - om_annual
      - om_annual_investment_fraction
      - om_con
      - om_prod
      - purchase
      - resource_area
      - resource_cap
      - storage_cap
      essentials:
        parent:
      constraints:
        energy_prod: true
        resource: inf
        resource_eff: 1.0
        resource_unit: energy
    transmission:
      required_constraints: []
      allowed_constraints:
      - energy_cap_equals
      - energy_cap_max
      - energy_cap_min
      - energy_cap_per_unit
      - energy_cap_scale
      - energy_con
      - energy_eff
      - energy_eff_per_distance
      - energy_prod
      - force_asynchronous_prod_con
      - lifetime
      - one_way
      allowed_group_constraints:
      - cost_max
      - cost_min
      - cost_equals
      - cost_var_max
      - cost_var_min
      - cost_var_equals
      - cost_investment_min
      - cost_investment_max
      - cost_investment_equals
      - energy_cap_min
      - energy_cap_max
      allowed_costs:
      - depreciation_rate
      - energy_cap
      - energy_cap_per_distance
      - interest_rate
      - om_annual
      - om_annual_investment_fraction
      - om_prod
      - purchase
      - purchase_per_distance
      essentials:
        parent:
      constraints:
        energy_con: true
        energy_prod: true
  techs:
    demand_dhw:
      essentials:
        carrier: dhw
        color: '#F507D8'
        name: DHW demand
        parent: demand
    grid:
      constraints:
        energy_cap_equals: 100
        force_resource: false
        lifetime: 80
        resource: inf
      costs:
        monetary:
          interest_rate: 0.1
          om_prod: 0.4
      essentials:
        carrier_out: electricity
        color: '#9CBC90'
        name: Electricity grid
        parent: supply
    hp_dhw:
      constraints:
        energy_eff: file=cop_dhw.csv
        lifetime: 30
      costs:
        monetary:
          energy_cap: 300
          interest_rate: 0.1
          om_prod: 0.04
      essentials:
        carrier_in: electricity
        carrier_out: dhw
        color: '#E33B78'
        name: HP DHW
        parent: conversion
        primary_carrier_in: electricity
        primary_carrier_out: dhw
    pv_rooftop:
      constraints:
        energy_cap_equals: 2
        force_resource: true
        lifetime: 30
        resource: file=solar_resource.csv
        resource_unit: energy_per_cap
      costs:
        monetary:
          energy_cap: 2200
          interest_rate: 0.1
          om_annual: 43
          om_prod: 0.0411
      essentials:
        carrier_out: electricity
        color: '#F3F149'
        name: Photovoltaic power distributed
        parent: supply_plus
    tes_dhw:
      constraints:
        energy_eff: 1
        lifetime: 40
        storage_discharge_depth: 0.625
        storage_initial: 0.625
        storage_loss: 0.01
      costs:
        monetary:
          energy_cap: 50
          interest_rate: 0.1
          om_prod: 0.01
      essentials:
        carrier: dhw
        color: '#F0A0BD'
        name: Thermal storage DHW
        parent: storage
  locations:
    dwelling:
      techs:
        demand_dhw:
          constraints:
            resource: file=demand_dhw.csv
        grid:
        hp_dhw:
          constraints:
            energy_cap_equals: 2.2
        pv_rooftop:
        tes_dhw:
          constraints:
            energy_cap_equals: 2.2
            storage_cap_equals: 3.7
  config_path: model.yaml
GCOL                                       dwelling::dhw                 dwelling::electricity                  
              dwelling::hp_dhw::electricity                 dwelling::demand_dhw::dhw                     dwelling::tes_dhw::dhw                               dwelling::grid::electricity            !       dwelling::pv_rooftop::electricity                     dwelling::hp_dhw::dhw                 dwelling::tes_dhw::dhw                               dwelling::grid                dwelling::demand_dhw                  dwelling::hp_dhw              dwelling::tes_dhw                      dwelling::pv_rooftop    !               &              dwelling::hp_dhw'              dwelling::grid  (              dwelling::tes_dhw       )              dwelling::pv_rooftop    *               .              dwelling::hp_dhw/              dwelling::tes_dhw       0              dwelling::pv_rooftop    1               6              dwelling::hp_dhw7              dwelling::grid  8              dwelling::tes_dhw       9              dwelling::pv_rooftop    :               @       
       demand_dhw      A       
       pv_rooftop      B              hp_dhw  C              tes_dhw D              grid    E               H              in      I              out     J               M              electricity     N              dhw     O               Q              electricity     R               T              monetaryU               X              dwelling::dhw   Y              dwelling::electricity   Z               ]              dwelling::demand_dhw::dhw       ^              dwelling::tes_dhw::dhw  _               d              dwelling::grid::electricity     e       !       dwelling::pv_rooftop::electricity       f              dwelling::hp_dhw::dhw   g              dwelling::tes_dhw::dhw  h               j              dwelling::hp_dhw::dhw   k               m              dwelling::demand_dhw::dhw       n               q       !       dwelling::pv_rooftop::electricity       r              dwelling::grid::electricity     s               w       !       dwelling::pv_rooftop::electricity       x              dwelling::grid::electricity     y              dwelling::hp_dhw::dhw   z               |              dwelling::hp_dhw}                             dwelling::demand_dhw    �               �              dwelling::tes_dhw       �               �              dwelling::pv_rooftop    �               �              dwelling::hp_dhw�               �              dwelling::hp_dhw�               �              dwelling::hp_dhw�              dwelling::grid  �              dwelling::tes_dhw       �              dwelling::pv_rooftop    �               �              dwelling::hp_dhw�              dwelling::tes_dhw       �              dwelling::pv_rooftop    �               �              dwelling::grid  �              dwelling::tes_dhw       �              dwelling::pv_rooftop    �               �              dwelling::hp_dhw�               �              dwelling::demand_dhw    �               �              dwelling::grid  �              dwelling::demand_dhw    �              dwelling::hp_dhw�              dwelling::tes_dhw       �              dwelling::pv_rooftop    �               �              dwelling::demand_dhw    �              dwelling::pv_rooftop    �               �              dwelling::demand_dhw    �               �              dwelling::pv_rooftop    �               �              dwelling::grid  �              dwelling::demand_dhw    �              dwelling::tes_dhw       �              dwelling::pv_rooftop    �               �              dwelling::grid  �              dwelling::demand_dhw    �              dwelling::hp_dhw�              dwelling::tes_dhw       �              dwelling::pv_rooftop    �               �              dwelling::hp_dhw�               �              dwelling::grid  �               �              dwelling::pv_rooftop    �               �              dwelling::pv_rooftop            OHDRO                                                 �      !             �      !       �     �            ������������������������0        CLASS                DIMENSION_SCALE /       NAME                 loc_techs_cost 4       _Netcdf4Dimid                            >x#!OHDRZ                                                 �      *             �      *      �"     �            ������������������������0        CLASS                DIMENSION_SCALE :       NAME                 loc_techs_investment_cost 4       _Netcdf4Dimid                            Ѥ�OHDRR                                                 �      1             �      1      ��     �            ������������������������0        CLASS                DIMENSION_SCALE 2       NAME                 loc_techs_om_cost 4       _Netcdf4Dimid                            {{%OHDRF                                                 �      :             �      :      �O                ������������������������0        CLASS                DIMENSION_SCALE &       NAME                 techs 4       _Netcdf4Dimid                            ]r�OHDR                                                 �      E             �      E       j�      Z            ������������������������0        CLASS                DIMENSION_SCALE .       NAME                 carrier_tiers   E�5�FRHP               ���������.      �       @                    h                                                         �#      ��W.FSHD  8                             P x          �(     P       P       o�`;BTLF �?� R   wm- �  " �8 B	  ' �!2 @   �P� �  + oK	 �
   t�	 }   u2 �   �2� M  ! �B� �  - ~�W �
    +˾ 4   ( w::  �  ! ���  �  # ��q& �  + ���) E  ; ٽ�* �  + aL/ �  " ڞu/ �   »�2 \   ) ��9 �  7 �`< 9  % H:�= �   W�I@ �  4 ��C ^  * ��l                                                                                                                                                                                                                                   BTLF              <        4   ( =        \   ) >        �    ?        �   ! @        �   , A        �   $ B           C        *    D        J   E        e  5 F        �   G        �  9 H          G I        \  F J        �  3 K        �  + L           / M        /  : N        i  : O        �  6 P          7 Q        L  ; R        �  ' S        �  + T        �  , U        �  7 V          0 W        E  ; X        �  # Y        �  7 Z          , [        A  3 |       OCHK    Q~     �       4       _Netcdf4Dimid                            E��OHDRI                                                 �      J             �      J      ��                ������������������������0        CLASS                DIMENSION_SCALE )       NAME       	          carriers 4       _Netcdf4Dimid                       	     G��OHDRc                                                 �      O             �      O       �C                 ������������������������0        CLASS                DIMENSION_SCALE C       NAME       #          carriers_reserve_margin_constraint 4       _Netcdf4Dimid                       
   ��OHDRF                                                 �      R             �      R      �     n           ������������������������0        CLASS                DIMENSION_SCALE &       NAME                 costs 4       _Netcdf4Dimid                            ��OHDRg                                                 �      U             �      U       �C                  ������������������������0        CLASS                DIMENSION_SCALE G       NAME       '          loc_carriers_system_balance_constraint 4       _Netcdf4Dimid                          �i2,OHDRu                                                 �      Z             �      Z       	D                  ������������������������0        CLASS                DIMENSION_SCALE U       NAME       5          loc_tech_carriers_carrier_consumption_max_constraint 4       _Netcdf4Dimid                          ?%�OHDRt                                                 �      _             �      _       )D     @            ������������������������0        CLASS                DIMENSION_SCALE T       NAME       4          loc_tech_carriers_carrier_production_max_constraint 4       _Netcdf4Dimid                          .�H�OHDRa                                                 �      h             �      h       iD                 ������������������������0        CLASS                DIMENSION_SCALE A       NAME       !          loc_tech_carriers_conversion_all 4       _Netcdf4Dimid                          /��\OHDRY                                                 �      k             �      k       yD                 ������������������������0        CLASS                DIMENSION_SCALE 9       NAME                 loc_tech_carriers_demand 4       _Netcdf4Dimid                          m�gOHDR#                                                 �      n             �      n       #J     Z            ������������������������0        CLASS                DIMENSION_SCALE =       NAME                 loc_tech_carriers_supply_all   f<�QOHDRh                                                 �      s             �      s       �D     0            ������������������������0        CLASS                DIMENSION_SCALE H       NAME       (          loc_tech_carriers_supply_conversion_all 4       _Netcdf4Dimid                          �|OHDRh                                                 �      z             �      z       �D                 ������������������������0        CLASS                DIMENSION_SCALE H       NAME       (          loc_techs_balance_conversion_constraint 4       _Netcdf4Dimid                          a|�OHDRd                                                 �      }             �      }       �D                 ������������������������0        CLASS                DIMENSION_SCALE D       NAME       $          loc_techs_balance_demand_constraint 4       _Netcdf4Dimid                          �8�OHDR+                                                 �      �             �      �       }J     Z            ������������������������0        CLASS                DIMENSION_SCALE E       NAME       %          loc_techs_balance_storage_constraint   �V�wOHDRi                                                 �      �             �      �       	E                 ������������������������0        CLASS                DIMENSION_SCALE I       NAME       )          loc_techs_balance_supply_plus_constraint 4       _Netcdf4Dimid                          -��OHDRU                                                 �      �             �      �       /     �            ������������������������0        CLASS                DIMENSION_SCALE 5       NAME                 loc_techs_conversion 4       _Netcdf4Dimid                            ��0"OHDRY                                                 �      �             �      �       )E                 ������������������������0        CLASS                DIMENSION_SCALE 9       NAME                 loc_techs_conversion_all 4       _Netcdf4Dimid                          iɴ/OHDRZ                                                 �      �             �      �       9E     @            ������������������������0        CLASS                DIMENSION_SCALE :       NAME                 loc_techs_cost_constraint 4       _Netcdf4Dimid                          ?��UOHDRe                                                 �      �             �      �       yE     0            ������������������������0        CLASS                DIMENSION_SCALE E       NAME       %          loc_techs_cost_investment_constraint 4       _Netcdf4Dimid                          T���OHDR$                                                 �      �             �      �       �J     Z            ������������������������0        CLASS                DIMENSION_SCALE >       NAME                 loc_techs_cost_var_constraint   L���OHDRi                                                 �      �             �      �       �E                 ������������������������0        CLASS                DIMENSION_SCALE I       NAME       )          loc_techs_cost_var_conversion_constraint 4       _Netcdf4Dimid                          8$OHDRQ                                                 �      �             �      �       �E                 ������������������������0        CLASS                DIMENSION_SCALE 1       NAME                 loc_techs_demand 4       _Netcdf4Dimid                          S�\�OHDRe                                                 �      �             �      �       �E     P            ������������������������0        CLASS                DIMENSION_SCALE E       NAME       %          loc_techs_energy_capacity_constraint 4       _Netcdf4Dimid                          �%��OHDRZ                                                 �      �             �      �      ��                ������������������������0        CLASS                DIMENSION_SCALE :       NAME                 loc_techs_finite_resource 4       _Netcdf4Dimid                            ���OHDRa                                                 �      �             �      �       iF                 ������������������������0        CLASS                DIMENSION_SCALE A       NAME       !          loc_techs_finite_resource_demand 4       _Netcdf4Dimid                           d���OHDR                                                  �      �             �      �       yF                 ������������������������0        CLASS                DIMENSION_SCALE     N�      �                �gG�        �!�BTIN \        t  8 ~           �        ^  . j�      !N�      !ʷ     Wy     f���                                                                                                                                                                                                                                                                                                                                                                                                                                     BTLF ]        �  + ^        �  - _          / `        3  + a        ^  0 b        �  I c          4 d        �  $ e        I  8 f        �  4 g        �  7 h        �  3 i        �  " j        	  # k        B	  ' l        i	  2 m        �	  ( n        �	   o        �	   p        
  # q        8
   r        W
  ) s        �
    t        �
   u        �
  $ v        �
   w        �
   x           y        9  % z        ^  * {        �  " |        �   }        �    ��#       OCHKF       NAME       &          loc_techs_finite_resource_supply_plus 4       _Netcdf4Dimid                       !   �� OHDRY                                                 �      �             �      �       �s     �            ������������������������0        CLASS                DIMENSION_SCALE 9       NAME                 loc_techs_non_conversion 4       _Netcdf4Dimid                       "     �wsEOHDR[                                                 �      �             �      �       �F     P            ������������������������0        CLASS                DIMENSION_SCALE ;       NAME                 loc_techs_non_transmission 4       _Netcdf4Dimid                       #   I�Z3OHDR]                                                 �      �             �      �       G                 ������������������������0        CLASS                DIMENSION_SCALE =       NAME                 loc_techs_om_cost_conversion 4       _Netcdf4Dimid                       $   c�OHDRY                                                 �      �             �      �       )G                 ������������������������0        CLASS                DIMENSION_SCALE 9       NAME                 loc_techs_om_cost_supply 4       _Netcdf4Dimid                       %   :s��OHDR^                                                 �      �             �      �       9G                 ������������������������0        CLASS                DIMENSION_SCALE >       NAME                 loc_techs_om_cost_supply_plus 4       _Netcdf4Dimid                       &   t\1OHDR=                                                 �      �             �      �       1K     Z            ������������������������0        CLASS                DIMENSION_SCALE W       NAME       7          loc_techs_resource_availability_supply_plus_constraint   �POHDRb                                                 �K                  �K            YG                 ������������������������0        CLASS                DIMENSION_SCALE B       NAME       "          loc_techs_resource_max_constraint 4       _Netcdf4Dimid                       (   ��f$OHDRR                                                 �K                  �K            iG                 ������������������������0        CLASS                DIMENSION_SCALE 2       NAME                 loc_techs_storage 4       _Netcdf4Dimid                       )   vP��OHDRf                                                 �K                  �K            yG                 ������������������������0        CLASS                DIMENSION_SCALE F       NAME       &          loc_techs_storage_capacity_constraint 4       _Netcdf4Dimid                       *   ���OHDR(                                                 �K     
             �K     
       �[     Z            ������������������������0        CLASS                DIMENSION_SCALE B       NAME       "          loc_techs_storage_discharge_depth   �+pBOHDRe                                                 �K                  �K            �G                 ������������������������0        CLASS                DIMENSION_SCALE E       NAME       %          loc_techs_storage_initial_constraint 4       _Netcdf4Dimid                       ,   ��f/OHDR                                                  �K                  �K            �G                 ������������������������0        CLASS                DIMENSION_SCALE     8     �                ���'                            �\�BTIN ���D 
  # ��O� e  5 j�      ��     %8     (
n��                                                                                                                                                                                                                                                                                                                                                                                                                                                                     BTLF T��� [   1M7� q  " n�� �    �X� �  $ �N� �
   �9p�    %�� /  : �Fݵ i	  2 SQ� t  8 ��_� �
   J鱷 �  ' �Pr� 8
   O�Z� �  ! �t1� �  , �� �  7 j0G� �  $ 7��� �  - Nr� �   , $��� �  3 ��� �  9 �F.� #   ���� �  # Ѧ�    X���   / )�:�   & Da�� ;  # l,�� �   �X�   , d�� J   �t�� �	   F�f�     �$J� �  ' �}"� �   ���� A  3 7�� �   $ ���   G d��   " v� �	   ���� n   m�� ^  0 ���                                                              OCHKA       NAME       !          loc_techs_storage_max_constraint 4       _Netcdf4Dimid                       -   �[�OHDRP                                                 �K                  �K           �     >          
 ������������������������0        CLASS                DIMENSION_SCALE 0       NAME                 loc_techs_store 4       _Netcdf4Dimid                       .     ��3�OHDRQ                                                 �K                  �K            �G                 ������������������������0        CLASS                DIMENSION_SCALE 1       NAME                 loc_techs_supply 4       _Netcdf4Dimid                       /   pR�yOHDRU                                                 �K                  �K            �G                  ������������������������0        CLASS                DIMENSION_SCALE 5       NAME                 loc_techs_supply_all 4       _Netcdf4Dimid                       0   )�;TOHDR`                                                 �K                  �K            �G     0            ������������������������0        CLASS                DIMENSION_SCALE @       NAME                  loc_techs_supply_conversion_all 4       _Netcdf4Dimid                       1    w��OHDRV                                                 �K     %             �K     %      t     �            ������������������������0        CLASS                DIMENSION_SCALE 6       NAME                 loc_techs_supply_plus 4       _Netcdf4Dimid                       2     �ќcOHDRE                                                 �K     (             �K     (       9H                 ������������������������0        CLASS                DIMENSION_SCALE %       NAME                 locs 4       _Netcdf4Dimid                       3   �/+OHDRJ                                                 �K     +             �K     +       IH     0            ������������������������0        CLASS                DIMENSION_SCALE *       NAME       
          resources 4       _Netcdf4Dimid                       4   �]'OHDRQ                                                 �K     2             �K     2       yH                 ������������������������0        CLASS                DIMENSION_SCALE 1       NAME                 techs_conversion 4       _Netcdf4Dimid                       5   �D"OHDRM                                                 �K     5             �K     5       �H                 ������������������������0        CLASS                DIMENSION_SCALE -       NAME                 techs_demand 4       _Netcdf4Dimid                       6   �ĺ�OHDRW                                                 �K     8             �K     8       �H     P            ������������������������0        CLASS                DIMENSION_SCALE 7       NAME                 techs_non_transmission 4       _Netcdf4Dimid                       7    �OHDRN                                                 �K     C             �K     C       �H                 ������������������������0        CLASS                DIMENSION_SCALE .       NAME                 techs_storage 4       _Netcdf4Dimid                       8   } �OHDRM                                                 �K     F             �K     F       �H                 ������������������������0        CLASS                DIMENSION_SCALE -       NAME                 techs_supply 4       _Netcdf4Dimid                       9   CQWOHDRR                                                 �K     I             �K     I       	I                 ������������������������0        CLASS                DIMENSION_SCALE 2       NAME                 techs_supply_plus 4       _Netcdf4Dimid                       :   ��OHDRw         �       �                 @     �[     _                   �    D\     @           ������������������������0        CLASS                DIMENSION_SCALE *       NAME       
          timesteps 4       _Netcdf4Dimid                       ;   ?       units                hours since 2015-01-01 00:00:00�O� 4       _Netcdf4Dimid                       ;   �<FSSE �        �    � K    �             
 � J    '�%4FSSE �        �     �   
  �	     �     �   .��;FHDB ��       
  X{Hp       techs_conversionP     q       techs_demand�     r       techs_non_transmission     s       techs_storagei     t       techs_supply�     u       techs_supply_plus     v       	timestepsz     w       resourceDd     x       resource_eff5r     y       storage_cap_equals�t     z       storage_discharge_depth�v     {       storage_cap_max�     |       storage_loss�     }       resource_unit��     �       cost9�     FHDB ��         ��w.c       !loc_techs_resource_max_constraint)�      e       %loc_techs_storage_capacity_constraint��      f       !loc_techs_storage_discharge_depthg      g       $loc_techs_storage_initial_constraint�     h        loc_techs_storage_max_constraint     j       loc_techs_supply
     k       loc_techs_supply_allz     l       loc_techs_supply_conversion_all�     m       loc_techs_supply_plusG     n       locs�     o       	resources�               FHDB ��         *���Z       loc_techs_finite_resourcec�      [        loc_techs_finite_resource_demand��      \       %loc_techs_finite_resource_supply_plus6�      ]       loc_techs_non_conversion��      ^       loc_techs_non_transmissionA�      _       loc_techs_om_cost_conversion��      `       loc_techs_om_cost_supply�      a       loc_techs_om_cost_supply_plusv�      b       6loc_techs_resource_availability_supply_plus_constraint��      i       loc_techs_store�            FHDB ��         L��P       $loc_techs_balance_storage_constraint��      Q       (loc_techs_balance_supply_plus_constraint��      S       loc_techs_conversion_all��      T       loc_techs_cost_constraint�      U       $loc_techs_cost_investment_constraint�      V       loc_techs_cost_var_constraint��      W       (loc_techs_cost_var_conversion_constraint �      X       loc_techs_demand��      Y       $loc_techs_energy_capacity_constraint��      d       loc_techs_storage��        FHDB ��         5q�eH       4loc_tech_carriers_carrier_consumption_max_constraintM�      I       3loc_tech_carriers_carrier_production_max_constraint��      J        loc_tech_carriers_conversion_allN�      K       loc_tech_carriers_demand��      L       loc_tech_carriers_supply_all �      M       'loc_tech_carriers_supply_conversion_allO�      N       'loc_techs_balance_conversion_constraint��      O       #loc_techs_balance_demand_constraint7�      R       loc_techs_conversionS�      FHDB ��          Ae�z        loc_carriers�p      <       loc_tech_carriers_conOr      =       loc_tech_carriers_prod�s      >       	loc_techs�t      ?       loc_techs_cost��      @       loc_techs_investment_costM�      A       loc_techs_om_cost��      B       techs�      C       carrier_tiersc�      D       carriers��      E       "carriers_reserve_margin_constraint�      F       costs��      G       &loc_carriers_system_balance_constraint��                           FSSE �        �     �   
  �	     �     �     �   �    ��s hޏFHDB �          ��C)    objective_function_value         ?      @ 4 4�                         �>ƞ~RpA    solution_time    ?      @ 4 4�                         =)��?    time_finished                2019-11-25 23:16:01    _NCProperties      "          version=2,netcdf=4.6.2,hdf5=1.10.5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     FHDB �       @   �;_� 	   defaults           �	         available_area: null
carrier_ratios: {}
charge_rate: false
coordinates: {x: 0, y: 0}
cost_energy_cap: 0
cost_energy_cap_per_distance: 0
cost_export: 0
cost_interest_rate: 0
cost_om_annual: 0
cost_om_annual_investment_fraction: 0
cost_om_con: 0
cost_om_prod: 0
cost_purchase: 0
cost_resource_area: 0
cost_resource_cap: 0
cost_storage_cap: 0
energy_cap_equals: false
energy_cap_equals_systemwide: false
energy_cap_max: .inf
energy_cap_max_systemwide: .inf
energy_cap_min: 0
energy_cap_min_use: false
energy_cap_per_storage_cap_equals: false
energy_cap_per_storage_cap_max: false
energy_cap_per_storage_cap_min: false
energy_cap_per_unit: false
energy_cap_scale: 1.0
energy_con: false
energy_eff: 1.0
energy_eff_per_distance: 1.0
energy_prod: false
energy_ramping: false
exists: true
export_cap: .inf
export_carrier: null
force_asynchronous_prod_con: false
force_resource: false
group_cost_equals: null
group_cost_investment_equals: null
group_cost_investment_max: .inf
group_cost_investment_min: 0
group_cost_max: .inf
group_cost_min: 0
group_cost_var_equals: null
group_cost_var_max: .inf
group_cost_var_min: 0
group_demand_share_equals: null
group_demand_share_max: .inf
group_demand_share_min: 0
group_demand_share_per_timestep_decision: null
group_demand_share_per_timestep_equals: null
group_demand_share_per_timestep_max: .inf
group_demand_share_per_timestep_min: 0
group_energy_cap_max: .inf
group_energy_cap_min: 0
group_energy_cap_share_max: .inf
group_energy_cap_share_min: 0
group_net_import_share_equals: null
group_net_import_share_max: null
group_net_import_share_min: null
group_resource_area_max: .inf
group_resource_area_min: 0
group_supply_share_equals: null
group_supply_share_max: .inf
group_supply_share_min: 0
group_supply_share_per_timestep_equals: null
group_supply_share_per_timestep_max: .inf
group_supply_share_per_timestep_min: 0
lifetime: null
one_way: false
parasitic_eff: 1.0
resource: 0
resource_area_equals: false
resource_area_max: .inf
resource_area_min: 0
resource_area_per_energy_cap: false
resource_cap_equals: false
resource_cap_equals_energy_cap: false
resource_cap_max: .inf
resource_cap_min: 0
resource_eff: 1.0
resource_min_use: false
resource_scale: 1.0
resource_unit: energy
storage_cap_equals: false
storage_cap_max: .inf
storage_cap_min: 0
storage_cap_per_unit: false
storage_discharge_depth: 0
storage_initial: 0
storage_loss: 0
techs: None
transmission_node: false
units_equals: false
units_equals_systemwide: false
units_max: false
units_max_systemwide: .inf
units_min: false
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      FHDB �           Q���    calliope_version           	          0.6.5-dev    applied_overrides                      	   scenario                     None    allow_operate_mode                                             model_config       �          calliope_version: 0.6.3
name: Heat-pump prova
reserve_margin:
  electricity: 0.1
subset_time:
- '2015-01-01'
- '2015-01-07'
timeseries_data_path: timeseries_data
timeseries_dateformat: '%Y-%m-%d %H:%M:%S'
    run_config         �         backend: pyomo
bigM: 1000000.0
cyclic_storage: true
ensure_feasibility: true
mode: plan
objective_options:
  cost_class:
    monetary: 1
  sense: minimize
objective: minmax_cost_optimization
operation:
  window: 24
  horizon: 48
  use_cap_results: false
solver_options:
  BarConvTol: 0.0001
  BarHomogeneous: 1
  Crossover: 0
  FeasibilityTol: 1e-05
  Method: 2
  OptimalityTol: 1e-05
solver: gurobi
zero_threshold: 1e-10
    termination_condition                optimal              FHIB �           =     )     ��������������������������������������������������������������������������������-     ������������������������NU=�   �            �            �            �            �      
      �            �            �         !   �            �             �            �            �            �            �      )      �      (      �      &      �      '      �      0      �      /      �      .      �      9      �      8      �      6      �      7      �      D      �      C      �      B   
   �      @   
   �      A      �      I      �      H      �      N      �      M      �      Q      �      T      �      Y      �      X      �      ^      �      ]      �      g      �      f      �      d   !   �      e      �      j      �      m      �      r   !   �      q      �      y      �      x   !   �      w      �      |      �            �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �      �K           �K           �K     	      �K           �K           �K           �K           �K           �K           �K           �K     $      �K     #      �K     "      �K     '      �K     *      �K     1      �K     0      �K     /      �K     4   
   �K     7      �K     B      �K     A      �K     @   
   �K     >   
   �K     ?      �K     E      �K     H   
   �K     K   x^c`@�?����x^�5x #�x^c` �'� $x^c` �� gpx^�Y����� �x^�cc ��nooFF"# 4 .tx^c`�~|���C��}�= +�|x^c`��\�B~8 A= �x^cd   x^c`�> �{ � )�4          OCHK   �v     �       4       _Netcdf4Dimid                            I0hOCHK    �D             4       _Netcdf4Dimid                          �?oOCHK    �D            4       _Netcdf4Dimid                          �OCHK    �E     0       4       _Netcdf4Dimid                          ���TOCHK    IG            4       _Netcdf4Dimid                       '   ,��GCOL                                       dwelling::pv_rooftop                                 dwelling::tes_dhw                      	              dwelling::tes_dhw       
                             dwelling::tes_dhw                                    dwelling::tes_dhw                                    dwelling::tes_dhw                                    dwelling::tes_dhw                                    dwelling::grid                               dwelling::grid                dwelling::pv_rooftop                   "              dwelling::grid  #              dwelling::hp_dhw$              dwelling::pv_rooftop    %               '              dwelling::pv_rooftop    (               *              dwelling+               /              electricity     0              dhw     1              resource2               4              hp_dhw  5               7       
       demand_dhw      8               >       
       demand_dhw      ?       
       pv_rooftop      @              hp_dhw  A              tes_dhw B              grid    C               E              tes_dhw F               H              grid    I               K       
       pv_rooftop      L              c�      M              c�      N              z     O              c�      P              �     Q              �     R              �     S              �     T               U              c�      X              energy  Y              energy_per_cap  Z              �t      [              �t      \              c�      ]              �t      ^              �t      _              �     `              �t      a              �t      b              z     c              ��      d              ��      e              ��      f              ��      g              ��      h              M�      i              ��      j              ��      k              M�      l              ��      m              ��      n              ��      o               p              �      v              #F507D8 w              #F3F149 x              #E33B78 y              #F0A0BD z              #9CBC90 {               |              �      �              demand  �              supply_plus     �       
       conversion      �              storage �              supply  �               �              �      �       
       DHW demand      �              Photovoltaic power distributed  �              HP DHW  �              Thermal storage DHW     �              Electricity grid�              ��      �               �              �p      �       F       dwelling::tes_dhw::dhw,dwelling::hp_dhw::dhw,dwelling::demand_dhw::dhw  �       [       dwelling::hp_dhw::electricity,dwelling::grid::electricity,dwelling::pv_rooftop::electricity     �               �              ��      �              dwelling::grid::electricity     �              dwelling::demand_dhw::dhw       �              dwelling::tes_dhw::dhw  �       !       dwelling::pv_rooftop::electricity       �               �              c�      �              c�      �              S�      �              dwelling::hp_dhw::electricity   �              dwelling::hp_dhw::dhw   �              z     �              z     �              ��      �              ��      �              �t      �              �s      �              �s      �              z     �              Or      �              Or      �              z     �              ��      �              ��      �              ��      �              �     �              �     �              �     �              z     �              G     �              G     �              z     �              G     �              ��      �              ��      �              ��      �              ��      �              ��      �              z     �              ��      �              ��      �              M�      �              �p      �              �p      �              z     �              �s                     OCHK    �G            4       _Netcdf4Dimid                       +   �-a�OCHK   �w     |      ;    	   calendar                     proleptic_gregorian6��                                                                	       
                                                                                                                                                                  !       "       #       $       %       &       '       (       )       *       +       ,       -       .       /       0       1       2       3       4       5       6       7       8       9       :       ;       <       =       >       ?       @       A       B       C       D       E       F       G       H       I       J       K       L       M       N       O       P       Q       R       S       T       U       V       W       X       Y       Z       [       \       ]       ^       _       `       a       b       c       d       e       f       g       h       i       j       k       l       m       n       o       p       q       r       s       t       u       v       w       x       y       z       {       |       }       ~              �       �       �       �       �       �       �       �       �       �       �       �       �       �       �       �       �       �       �       �       �       �       �       �       �       �       �       �       �       �       �       �       �       �       �       �       �       �       �       �       x^c�5���a�L#c� � �<
x^c` �'� $x^c`�@�������z �kx^�a�����  Y x^c��֤��>��̣�i�����]����cL.x^{S]=K_Dd��u�f������p&wU�̥-Kn� �%x^cgT�� �h�PUYQV�& !K�x^cc�b�f@� �� �&� m�-M�hb ' �x^f�c@� �� �&� �&N��G 7�Ux^c��0쬷 +Cx^�vc ��nooFFf΀� C/�x^S��d@�@��@�,�-X�� �jNx^�e ��nooFFV��� 6�6x^c`�`��a� �! s��x^c`�`��a� �! s��x^c��� =��x^cd�    x^c�5���̙% �!�x"<@�=F�HA  $q	x^Sk��̣�g^^�_M�!��8��S��#�`��  ��\x^�5x #�x^�]�-���= �Ex^����~�]�kNw>�b<�Z��W{{ �I�x^cX��������������Zʰ8���-���p�7�\ K�A�.�G ���������İ��g����������x^��7h��}ZO�2-�k���Cr�                                      OHDR�(                �              �           ?      @ 4 4�              �            �8             shuffle            deflate            �g        �           ������������������������P        _FillValue       ?      @ 4 4�                               �D    
   is_result                                           `       DIMENSION_LIST                                    �K     M      �K     N   }�j�OCHK            �D    
   is_result                                           P       DIMENSION_LIST                                    �K     Z   @��vOCHK            �D    
   is_result                                          p       DIMENSION_LIST                                    �~     	      �~     
      �~        	���            ���          v��2TREE  ����������������                               5z                    �                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      OHDR�                           ?      @ 4 4�              �            �8             shuffle            deflate            U                ������������������������P        _FillValue       ?      @ 4 4�                               �D    
   is_result                                           P       DIMENSION_LIST                                    �K     O    ��+OCHK    ��     �       P        _FillValue       ?      @ 4 4�                               �D    
   is_result                                           ��           ��             A�             �OHDR�                           ?      @ 4 4�              �            �8             shuffle            deflate            ��                ������������������������P        _FillValue       ?      @ 4 4�                               �D    
   is_result                                           P       DIMENSION_LIST                                    �K     P   A �BOHDR�                           ?      @ 4 4�              �            �8             shuffle            deflate            ��                ������������������������P        _FillValue       ?      @ 4 4�                               �D    
   is_result                                           P       DIMENSION_LIST                                    �K     Q   �9�)OHDR (                �              �           ?      @ 4 4�      t     �                   �8             shuffle            deflate            ��        �           ������������������������                  H#x�(OCHKP        _FillValue       ?      @ 4 4�                               �43G�                     x^͖�W�Eǿ�H�djb���V�4S@���h���x_,�$)"������l���E�E�E!Dr�G*T��GL�tg~���_��|��|���~����? aO�9�#��Z�����/�t�0uJ|�k�-�����k��h��,����;޿z�������g\����h��+���\+�k$�M�DJT}T�i'�{����,�c�M-�����9�i"y�JF���i?R=���TL�L��b�M4�����'�"���a��̷��=�ah�s�M��F�t�RtG��m�_Z���Y�}�n��6%z��y�alhi�*��:�M;$���5 KYbYz�&��yN�.I���,ϼ���ԟ1�wVt(Q�2�5.$g�rF�P7Kr��mh�����3^]YV>���c�T�Iñ�r�ؘ��sQ�]�'W�N�{,���矁�K\�/�	�x��ͪ�u���q��P�^o�Z�<����_G��#ȿE�M�|��E�A"�<x��-��]soL�������Mf���\5i��U��"�=��E��L,i9l�3��{X>龍�+�*�%�&�0��Ek�u�5q�T���~�ң��tC�����.�=g��@��V����$�N�����s_�xF���N�Z$��E�w�I,�MC�����HŢo<�]�gH��y:��=�
a�AKڏ�p��_�lU�+����<�-f�]�v�=J��T4v	*,t�vq��F��R�I>q^��H�엚5}j�d͐x�k����u�F'�I��z�,����n���|���g�En<V�3v�x�07��ۺu$vM���>�Z2�d����] *��^�8���)��5�z��s���|R%��j\
i��S���}�ڣ��+��e�ӖD��9�[S9�12)K�X�6oz���nm{$��]�w�%�,��ηWt|ڤ�x�T��r��-wo����a#慌�x9?��&�.s��==mq]�����R,�+w	�q�w�
>b@u;T!��aIq�~ҝz�H����+w�V~�����uԖ"�q"a}�2JL5���+
ƧOOI��)�_
���ʲs�%�=S_\ZZ��]����*SY~���:U��}��5���|F�����_ov.y�-����ӵ�fs�T!�m=���!�yA�2o�?�c����f�@f��D��d��'.�V�`�A�b�D������1�Y��o�G�m����L�g���Ϣؼ Oc�{�,�*S�<����%����:|�(ŋe�c"'GTREE  ����������������                       I                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           TREE  ����������������                       (I                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           TREE  ����������������                       5I                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           OHDR�                           ?      @ 4 4�              �            �8             shuffle            deflate            ��                ������������������������P        _FillValue       ?      @ 4 4�                               �D    
   is_result                                           P       DIMENSION_LIST                                    �K     R   ,��TREE  ����������������                       BI                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           OHDR�                           ?      @ 4 4�              �            �8             shuffle            deflate            ˣ                ������������������������P        _FillValue       ?      @ 4 4�                               �D    
   is_result                                           P       DIMENSION_LIST                                    �K     S   ���TREE  ����������������                       OI                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           OHDR�                                                 �K     T             �K     T   8             shuffle            deflate            ��                ������������������������D     
   is_result                                           P       DIMENSION_LIST                                    �K     U   �}4OCHK            �`       DIMENSION_LIST                                    �K     a      �K     b   ?
I�OCHK    �     �       P        _FillValue       ?      @ 4 4�                               ���  ���TREE  ����������������                       _I                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           OHDR                            ?      @ 4 4�      Cf     �                   �8             shuffle            deflate            �                ������������������������    �y     ^                       n>�BTLF         2   �        M  ! �        n   �        �  $ �        �  " �        �   �        �  ! �          " �        2  ) �        [   �        z   �        �   �        �   �        �  ! �          & �        ;  # ���                                                                                                                                                                                                                                                                      FSSE �        �     �   
  �	     �     �     �    ߞFHDB ��          ��~       
energy_con��            lifetimeA�     �       force_resourceL�     �       energy_prod#�     �       energy_cap_equals.�     �       storage_initialG�     �       
energy_eff�x     �       cost_om_annual	�     �       cost_energy_capP     �       cost_depreciation_rate�	     �       cost_om_prod1     �       colors�     �       inheritance�F     �       namesTP     �       reserve_marginZ                           TREE  ����������������                       xI                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           OHDR�                           ?      @ 4 4�              �            �8             shuffle            deflate            �                ������������������������P        _FillValue       ?      @ 4 4�                               �D    
   is_result                                           P       DIMENSION_LIST                                    �K     [   ]x0>TREE  ����������������                       �I                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           OHDR�                                  	      �      �8             shuffle            deflate            ��                ������������������������D     
   is_result                                           $       dtype                boolP       DIMENSION_LIST                                    �K     \   ���OCHK    IF             �     t  REFERENCE_LIST       dataset                                       dimension                                                                      Dd             5r             ��             L�             �5nLTREE  ����������������
                       �I                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           OHDR�                           ?      @ 4 4�              �            �8             shuffle            deflate            ��                ������������������������P        _FillValue       ?      @ 4 4�                               �D    
   is_result                                           P       DIMENSION_LIST                                    �K     ]    Em�TREE  ����������������                       �I                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           OHDR�                           ?      @ 4 4�              �            �8             shuffle            deflate            �                ������������������������P        _FillValue       ?      @ 4 4�                               �D    
   is_result                                           P       DIMENSION_LIST                                    �K     ^   ��OHDR (                                         ?      @ 4 4�      �     t                   �8             shuffle            deflate            t                   ������������������������                  "�W�TREE  ����������������                       �a                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           OHDR�                           ?      @ 4 4�              �            �8             shuffle            deflate            @�                ������������������������P        _FillValue       ?      @ 4 4�                               �D    
   is_result                                           P       DIMENSION_LIST                                    �K     _   |L�/OHDR (                �              �           ?      @ 4 4�      �     t                   �8             shuffle            deflate            T        �           ������������������������                  4��             �AE$TREE  ����������������                       �a                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           OHDR (                �              �           ?      @ 4 4�      7�     $                  �8             shuffle            deflate            U�        �           ������������������������                  :��             �gi�TREE  �����������������                              �                    �                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      OCHK            �D    
   is_result                                           `       DIMENSION_LIST                                    �K     d      �K     e   �ĳOHDR�                                                 �K     o             �K     o   8             shuffle            deflate            _>                ������������������������D     
   is_result                                           P       DIMENSION_LIST                                    �K     p   p��                 	�            Ĝ6pOHDR�(                                                         �        �8             shuffle            deflate            �                   ������������������������D     
   is_result                                           `       DIMENSION_LIST                                    �K     g      �K     h   ���OCHK    �A             �     t  REFERENCE_LIST       dataset                                       dimension                                                                      e             �j             ��׋OHDR�(                                         ?      @ 4 4�              �            �8             shuffle            deflate            �&                   ������������������������P        _FillValue       ?      @ 4 4�                               �D    
   is_result                                           `       DIMENSION_LIST                                    �K     j      �K     k   _09OCHK            �`       DIMENSION_LIST                                    �~           �~        �!�OCHK    [�     �       D    
   is_result                                          	���  x^c`�_���H22~w����J�{�����l��mg;�ց�VV��4��6?�}��A[f�e�Sl�D����Y�1цe��י�ʳ�p
�e�k�;:��;oT���~�?êO��ߜ���ԧ����v�[�N��[kfp���N;_�|%�Mj&�	�o*9�UB�WĎ)�aV��u.S�[�Ef ��G�(L t�������W/�b�ϛ&�b�z��ν�=V/Vl��^#�il��,�u�[��/v�/���ꁯ��e�z���S*f�]�x�*�[BO��F*4�#��mw�o�~�c��X�ɬO����bɥ��^"��n�`�;�r����G�6D|�ʱ��̿s��z��	����M����[0������Q0
8f�d͉��r�UQ�y��gQ�r�I�?��]��A���u����ȄW��uw��?���6�s���k��u���׹���+[���]��0A{b���7M8��:G���R7�l�s<{��W����Y�v��dǾ���N���1�d`��o�7ņ�{Z���E���^1�D��I�����=
F�`k%�r���q�Hv��C�.��n4��.๱��6�E�̺c��Ū_���V�������)�dV�2���u鶎?\^��b�5�-}�5���*w��^s�^�0���צ�qIs�!�+띥�Ulo��������f�$�Grz�4�[�Z��1�سj��܆�7�Ul���.�7�{�`�Ktw��Q0�@ό�!�fj���v��_��2q�f-��e[�{������[Ug��M֩J����b�G.��{n��h�#���J����N�V�#������m�?���1].�ɳ7h�rp���s�Ի�;�q�խ���ao���ȹ�;J�[7���k��m���.#�:�*�z���ٳ�J�4�.�I�'/o���Q0
����'�W�Z��D����i�}|�����ϝ8��k���-��9:���ڱv��5K�M�T�]t��l�FDH��w��6Ֆf���x$�0N})������2ׄ��B&���y�l��/�n��	��OOn]R�uo���W�}��c\>}��B�/�>=�yrh���������T���[���q�ݣ�2�c��Cp '� �P ��P����8777�P=Dp��s�L$�\`�1�!��D��wP��"�a� ��� #i�@TREE  ����������������                               �a                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          TREE  ����������������                               �a                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          OCHK    9C     P       �     t  REFERENCE_LIST       dataset                                       dimension                                                                      �             �F             TP             ��FTREE  ����������������                                �a                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          OHDR�(                                         ?      @ 4 4�              �            �8             shuffle            deflate            '4                   ������������������������P        _FillValue       ?      @ 4 4�                               �D    
   is_result                                           `       DIMENSION_LIST                                    �K     m      �K     n   �3�OHDR                            ?      @ 4 4�      e�     t                   �8             shuffle            deflate            �                ������������������������    �[     �                       ��A�MsTREE  ����������������(                               �a                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          TREE  ����������������                        b                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           OHDR�                                                 �K     {             �K     {   8             shuffle            deflate            $H                ������������������������D     
   is_result                                           P       DIMENSION_LIST                                    �K     |    �TREE  ����������������!                       9b                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           OHDR�                                                 �K     �             �K     �   8             shuffle            deflate            �Q                ������������������������D     
   is_result                                           P       DIMENSION_LIST                                    �K     �   �إ�TREE  ����������������"                       Zb                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           OHDR�                           ?      @ 4 4�              �            �8             shuffle            deflate            �\                ������������������������P        _FillValue       ?      @ 4 4�                               �D    
   is_result                                           P       DIMENSION_LIST                                    �K     �   ��6�OCHKP        _FillValue       ?      @ 4 4�                               �D    
   is_result                                          f��X                             Z             �ΡTREE  ����������������                       |b                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           OHDR�                                                 �K     �             �K     �   8             shuffle            deflate            �i                ������������������������D     
   is_result                                           P       DIMENSION_LIST                                    �K     �   ���OHDR (                �              �           ?      @ 4 4�      �     �                   �8             shuffle            deflate            -�        �           ������������������������                  Z 4l     �     �   � R   ��.	FHDB ��         ���       lookup_loc_carrierse     �       lookup_loc_techs�q     �       lookup_loc_techs_conversion�|     �       timestep_resolutionE�     �       timestep_weightsP�     �       max_demand_timestepsg�     �       objective_cost_class��     �       
energy_cap3     �       carrier_prodp�     �       carrier_con+�     �       storage_cap�     �       storage"�     �       resource_con��     �       resource_cap                  TREE  ����������������                       �b                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           OHDR�                                                 �K     �             �K     �   8             shuffle            deflate            ht                ������������������������D     
   is_result                                           P       DIMENSION_LIST                                    �K     �   rs(OCHK    �F     @       �     t  REFERENCE_LIST       dataset                                       dimension                                                                      �q             �&1�TREE  ����������������                        �b                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           OHDR�(                                                               �K     �             �K     �   8             shuffle            deflate            �                   ������������������������D     
   is_result                                           `       DIMENSION_LIST                                    �K     �      �K     �   ~tJ�OCHK    �C             �     t  REFERENCE_LIST       dataset                                       dimension                                                                      �|             �^V{OCHK    E            �     t  REFERENCE_LIST       dataset                                       dimension                                                                      �|            8�*�TREE  ����������������                               �b                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          OHDR�         �       �           ?      @ 4 4�              �            �8             shuffle            deflate             �     �           ������������������������P        _FillValue       ?      @ 4 4�                               �D    
   is_result                                           P       DIMENSION_LIST                                    �K     �   QC�TREE  ����������������                       �b             �                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              OHDR�         �       �           ?      @ 4 4�              �            �8             shuffle            deflate            7�     �           ������������������������P        _FillValue       ?      @ 4 4�                               �D    
   is_result                                           P       DIMENSION_LIST                                    �K     �   ;u}VOHDR (                �              �           ?      @ 4 4�      ��     $                  �8             shuffle            deflate            
�        �           ������������������������                  �W��TREE  ����������������                       �b             �                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              OHDR�                                 @             �            �8             shuffle            deflate            j�                ������������������������D     
   is_result                                           ?       units                hours since 2015-01-02 11:00:00;    	   calendar                     proleptic_gregorianP       DIMENSION_LIST                                    �K     �   �wl�TREE  ����������������                       c                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           OHDRq                                 @             �            �8             shuffle            deflate            5�                ������������������������D     
   is_result                                           P       DIMENSION_LIST                                    �K     �   xfOCHK    �B     @       �     t  REFERENCE_LIST       dataset                                       dimension                                                                      9�            �gD�            �	             1             ��             �'1TREE  ����������������                       c                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           OCHK            �P       DIMENSION_LIST                                    �K     �   �6��OCHK    9B     P           t  REFERENCE_LIST       dataset                                       dimension                                                                      ��             A�             #�             .�             �x             3             9q}TREE  ����������������%                       'c                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           OCHK            �P        _FillValue       ?      @ 4 4�                               �D    
   is_result                                          `       DIMENSION_LIST                                    �K     �      �K     �   ��G|OCHK            �`       DIMENSION_LIST                                    �~           �~        1�Fa                                                              p�             Y��OHDR (                                         ?      @ 4 4�      ��     $                  �8             shuffle            deflate            ��                   ������������������������                  ܇,�           >�VTREE  ����������������}                              ��                    �                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      BTLF @MNI �  6 ƷvL   4 )m�M �  & y��P �   o�6Q W
  ) ��-S �  , ��S 2  ) �`T *    ���U �  ' � V �  ' 6�gV 2   &�V �   ! F�Y    .��Z �   ��]   7 ���] �  7 �A�^ �	  ( �Lb �  3 �d 3  + ��e    O�mi 	  # FY*j _   �I�j ^  . o=�n z   �Elo I  8 ̹�p 0  " '	�t i  : {�t   0 ��{ �    1��{ �
  $ F��|    / �T>} �  " G�+~ L  ; 0d�� \  F M߫� �   �<� �   	��� �  I ����                                                                                               OCHK            �P        _FillValue       ?      @ 4 4�                               �D    
   is_result                                          `       DIMENSION_LIST                                    �K     �      �K     �   4D�9OCHK    �A     0       �     t  REFERENCE_LIST       dataset                                       dimension                                                                      +�             ��^5OHDR (                �              �           ?      @ 4 4�      �     $                  �8             shuffle            deflate            �(        �           ������������������������                  X�r�           +�            ɺ�OCHK            �P        _FillValue       ?      @ 4 4�                               �D    
   is_result                                          `       DIMENSION_LIST                                    �K     �      �K     �   z^=�OCHK    �B     @       �     t  REFERENCE_LIST       dataset                                       dimension                                                                      	�            1            b             ��            ��             9�             ���OCHK         �       P        _FillValue       ?      @ 4 4�                               ����R            x^��w4�����q�=��.T�wQZE�RjU#*f�B��R�&����ՎY�ڢ�M�P����C<������y�����z�O�o�\IX�,���B��c�T�~�<g/�8t���CK���Q��#�\��#��5���mDQ�ypz��[޼qvZ_�y��R9E��M�U�����J�}��gK��B"�ո�*B��°Q)�C��w�:nF
�4CF�j�^n/�1��l���;�K�C�<�261wY�v!�M��@�?���T�j�����;־��H,K�D=�����
	�����t�/����Jm���K�r��Z	�,�VJ����X�J�Eh$�Y�K��G�S6�ͺ3����fO�G���А��.��Z8>Qb�'�Z�2F?����ß¥��1�)h���>#���EM��
ꏍ�[㯚�Y�N@��wt&�!�9�g{Ѱ��$�rE��6)�~y3r;���|�
���£�H��@�A��̻u�Yܳ��z�ǈ"�W���{c�
�����,p&78�>�;:��SɄ0����Bw����b�E��b�5t�L��"�H�ԠPg�~/�*�����}�M���p��6��p�1s���=��DLܵ5Wn<��I&���=|akL��Z���m����x����Nn�&Hў\�T���ZNI;�f]��Oܝ��cUO���[�$~�X����i���<m�����*���s�|X}x��&��L��u��Z}G��yۧ�0�?�l)�َ���zQi���񡐔�tΙ��c�?�k���ZTz�ëLF���S�A['rI��=���c�A����	�KT1��ߺ�NV̳����x=����Zf�����ɺb"�Mq�n ߻�CP�ٞ.���@]͛YdV�w��ϕ��ГR?k!X�5�xo����WC�v���1��(9	FϜ��	��G�s�7���v��3���P�]�VJ[>f���!Z�U�Z੬?N���Z���;آڋ����m��mp��D�LӀ�u�V����/��#w��%5���ad��, ����1.^����E�������X��.�;.n/\E�Wj�ޤ; �es9 �.D\[�w�E�
�יI��~��[�d71ۇ�D%�����p��9. �	�V�2������K�z�����ab�OW��P��18,���F)e"|o�(s�%H��~jR^&:�_Qdr
�bU���P	Kt�o��c�@%C��Q.���E�c|�J�����S�}f����r��@Ajddc�!�V��Md��8��m9=FjL)>VL�Z:�>-���_��	J���_�]~޷�l�sѧ�i���ub6�h��k����9�[���֍�y(��G�<�bk¢c�Q�&7�� A�IiL�ݺp�@p���)�|jZ#��+�\lTtC�87@��sWik�1L����h�i%R�qG�u�;��>�d�Vӵ��{�Z���\m��^��y]d��q� ��n�`�&%�Bc3=V�[�<R���ajAd�Fiv�^y��D�p��[N���K'�H�]t���b �������3�;e/nv_-���_w�r1�R���乬s�a���I0<�ޡ���O�k�A2}������5�q��E�K"et���˥7��]������>6���3���~�ظ)�b�{sv�p�I6s�u�������u�T>_%X_IhV 38���G���0�']���!7�0�����B�ŕ{k�E7�G��25�"��a�Q��d���]6�ٰaOmԽF�/I�7���~�u�j�����m�9��+Io�����Xe�$�2��d���5�sVV������y�x7�JN�O[.&S#�}��>�j%i��tc�5�o��܌xO��J.t��*�B^�"v����=jpI��ek���|-UD�	d�mom7��0�~�l��[:|�&h��90V���K�
��.�[�)�WN;����ޒh�]݌�'-�/֒\�yP8M3��2��iG�v���MNMo���`�,!׍79��P������Wܪ�?�a�W�jgϗZ�vkq� �x�� �:�P�dνi�%ޭ��F�pm�Q�j�n�[���k���V�V��]�)>����u���U�L���7�j�J�Իe���]�eA1E�������r�v�Ϸ����e��Pp��  IY?�}���eg��9��ը��qM�����q�����yv����M�d�Y[��7��u��%�l����	�g>�a�����O�K`��2�S�B�s{�������--X��=�+mm�u���	�]���e�ڦ��UC�Xe
8�$a�v��M���'��L*�Hc�^,J�֒���D���{����[���'	|9����#��|�
��-�1��Rؐ�b����'?H�T���W h��������?[�w��� �|�B��ɽ�I���q�D����Tү�f�0����|��&6�ef�0]��~��D�zE��*�PP Q?r�w�/'��ҧr~%�R�rJ(���Dz��p�_�c�ˍҴ!��<gK	�k-����06�^S��D�N��>!�(dI�?vY5��'G�Z"��H�n=�b4��uO9N"^�ƅr�7�RyZ��jDU���;��!w�%�>��IA�9ê��9ǅ9���L���z�N�H�Ǵ�`�yN���ޘ˓L��@�}�521���eR�w?$ˇP���s�L>�?��=}F'�oX�Z�M�I���N�~r��*��8��I��R�n�v�-�,���r��WO��W�2���T�PW�G�X�-s9o�7Z��kz��?`�������o|qf+��� �˄6�̓����m|cx�Eİ����r�����q��7�7ͦ�&�Aj6�v&_�zj|�q�<�ںqe�3|��6,�d�P`s�J�u$�ReJ�z,���J�oMY�aVv�#��6p���p�\^z�Cܣ{?ba=f'��&>o�(G���s|WW�鉘��r�J�ē��Udصtx�80)[7�S�sJ��K��D;���o��*��.���������PU�63T\�?�~�hb_�r稅\��#�4ʠ�s���nO´���ORq�3�d��I�W#E��-3	]"dL�O�΅&�-�ck=����i>���Ne����c�*iI�7�mO�������m�ςၻu6�YtA������ER�{�U��e]��'3��l����f ����j�p�D��������e)��S�_�����O���)�nt���v�V����n$r7�pe�V���	/E�2�o:�ԉ��J�g����&��z
�l�wo]��>zh5ҧL�J{k9��AQP���]��ps�qw�� W���蚷�ü)�P�?P�����#ྰ^�y����_����;�ZgW{�O�4�c��������+u�x� �5'�������G���gA�����#��0j�����WH���
�w_��!~��H�%������o�_y��9�dBZ�Pffv{]�&p������'��z2I�E������=�R'Rq))�ܯ�2k�,/����iإLB
.�H� �	-��|�880��!�8B�(Ox�Ҿ4���ֆ�M�^�g�3�	�u�����9J�z��(5.6:<<����ox��dldD^Hhx]ddLQ:�3%����?*(8/�&2:6!��vp��@`�	�� 
�jo�8:�7��F�0^U���m)�;�I��&68�b��$&�ts��j���.�M�'�a/`���wo����E}�鹙�4�c�GF>wb<�bvvz�����Ό�`�Ēց���|������hh0�z7����O������������tg<���U���1�"�1TREE  ����������������Y                              B�                    �                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      x^�V�;��>>Zɖ�%Ih�ŮmZD�/ۇ�5Yƒ}�KY���jke�	1)�X�&;�"�~��~�u������y��,�98����,��gN�����q�q�F�e|���6{~|	�=��M�&є�=4�˱����-���k��:��������x�o�������[�/*,��?�<`/�>(ea�î����C�%Ն�Y
!��7f�g��3m���)������({�Z��������>k)��#o� �d@;(p1��!l��b06ܱ�A8���qp�$�0��n{(�w��g��ʀ]��V:A�������F��3h<�<�c?�	w�H�9�2J��Ǖ,Mt1��-by~H��Y���́FT�A.�chnU;P��F���6\���!����d�IT�/ݔt��T�8���;}k�Fq��I�kmk]��P����ӆq�Q=A���6wߛ%	ě1����FT���[.4�ӷr]��҈.s�\�.Wfn1�+u�z�T���<"fj��~ڈHLծ����ٶ�\vs��UEː����
!�����1��.�̓f�-�K��Ӈ����J�+������yB�'ߢ7t�����t��U/>����<O�M!��C��	�hg:E]��*\���f�e����Fv}�;����[\�ԃ�n9�`x�Ae& ����MBX�xU�Uk�!��1�	uT��$E0/�� � $�3�l�	�(�Q(�]�2��� $�U�����{�dA���WU�� �K�1������[�K�C,�m�<�N�Nf!�[��5{1����,ZM}��,�S*���k�T����=g�I����{R�I���7�
��*�7����f�؟�G����,=>�-Q�Q(�+B*&m�����M]��D��Ck~f����J`�K�t��>�%?�
��qi|���^V�x�߸��j�[�8*�	I.�۔�;At��趘Ď�X+�a�y^��f���������!\Ȍ~b�N�ݰċ�P��EV���m�D0Nfa�/~K��r�s�
ˣs;P�!�XL��*��5�y'�����k7�_��j�J���5�T�w�������م��w�|�*��D�s������v� E3Z{��;��z�p~w''L
��S:�R���P	@�:�v!$�f���V�����>��7Ԩ��h
�@��$P��FZ�ܶ�&�d��˟���n�}����}����c!J�7J��^�?:ϣ�Z0�[ƕ�6z��I[�w����da�j2�
Tf�Mj��kw�0rv�`�{��EAv�%�OsK�CM��[�!S+�aC�������RU�����S&�]�:�o���1�h+�M�У�q���:J>t�ͳ��23��`�=-|M��V��MT<�D��m}S�=�7�Tm��*$<Rwd��{l�I����c�x�iT���>������J����$�|3�l]����	�ȿ�CZ����$��T�S^���8ѻ�>F�g�c�@]9-k�?�P}��^�EC��m�I_h6�[���̃�(ƌƞ��T%�BC��� �O����ڣHX�
��w�s��vE��;��hE� T��������)p��Q���94�طƯ��t�@�J��8�9�𲕠�04ѵ��@`N��iҥιn���\u�|�S}b;�gP:�G��h
u7�b����vh������4�U<֣ISxZj|%�f�6#/�<��'=��%��#�7�Pu����������K�����XKm�y�S�.Y.T�XXR)��t�������Z�I#W��ĴWSW�Iŗ����<���N�3��B);6�H���!LP7d�H.r��ym3~�>��Ç�X�Uq(�S�{E�rU���ZZ�\�f�;�#�w�<��+s����꿰�+����*��a?$���4���7���1�c�����/4K������n�0n]����j"̴ϬUU�S�?���YN����V&�`�UCpN��$X�$�� �R��
�W����!5"躎���'D7�����b3�pՇ{6�n웃�}p%�w�� ��1&e�N�Aaܱ��,�<w��G	�9A�k�()꯼Ss�bMgԔ���r�K�|(_֛0O���"u��:�2U��ܭ��5�U���q��!�Z����)Ί�E�TG�_R�*��iq���(m���'���o�w:��Ы����4��ͥ���2鰣7
��׊O�Z������'� �:���^&N䦓����[���Ԣ��W7��t/�V92c�/�My��&`qW��� -�i/����.֡���^�j��w�4pEJ�~����`���i���|�f[eo�� ��:�\���1L--uݶ��3J��QZ�l�]ɿ�%�ɺ|����D�Xԇ=�T�.Ni������!B��B����f��Wss��5����U���pz��3�َ�xr��.(������'�!�%�;C�Iy��M��vp_���m.�����΀��iO�A���(yQW�vL�F���M�K�����j�� �X�j|����eɏ;7va�A�;C��d�w�R�p��@�'=.��Rǋ���S�26�i.�Bﬥ���,u�Ŵq�Lbb:=�����g��~�˼��m��HR/���Kle�y�b�7Z\N����'�p�999�!�"���y�)$/�(1�q6��р���D�;��\Q�����A(.��bqdxb�� ���%74��ő����޲�}dEB[O ������o�M�q��<"!8:8���g�@�~���ƥ?M��^ ���
�c>vl�PP���_h�|���s[8�c^����N&X�<����À�ý*F�P'VA���,45A��KpO��{�7-A�V�,&A���F�PX�9�[������/#V1�^T"���b�<�QBJN^���GV�EP�	�H$��#@S��E��ûb�����h4
�T�S<��mB��P��z4���*�+뮧SPdr�O����b�
H�Ω-�f���O��^���O�j�
pR�Q(�q�Q�������b����u��/�g��.ʿ�\��N����d������'�?rM��TREE  ����������������)                               Lc                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          OHDR�                           ?      @ 4 4�              �            �8             shuffle            deflate            �                ������������������������P        _FillValue       ?      @ 4 4�                               �D    
   is_result                                          P       DIMENSION_LIST                                    �K     �   ��hOCHK            �P        _FillValue       ?      @ 4 4�                               �D    
   is_result                                          `       DIMENSION_LIST                                    �K     �      �K     �   ,ºL      N8��TREE  ����������������                       uc                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           OCHK            �D    
   is_result                                          `       DIMENSION_LIST                                    �K     �      �K     �   uČEOCHK    �G             	   t  REFERENCE_LIST       dataset                                       dimension                                                                      �t             �v             �             �             G�             �             "�             =K�OOHDR/                           ?      @ 4 4�      �     �                   �8             shuffle            deflate            =5                ������������������������P        _FillValue       ?      @ 4 4�                               ����N�TREE  ����������������6                              �$                    �                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      OHDRC(                                         ?      @ 4 4�      Z     h                   �8             shuffle            deflate            Ԫ                   ������������������������P        _FillValue       ?      @ 4 4�                               ��t-        �j            ��OCHK    �     �       P        _FillValue       ?      @ 4 4�                               �D    
   is_result                                          ��GOCHK            �D    
   is_result                                          P       DIMENSION_LIST                                    �K     �   |���OCHK    )H            �     t  REFERENCE_LIST       dataset                                       dimension                                                                      ��                          }��OHDR8                       �                     �           ?      @ 4 4�              �            �8             shuffle            deflate            mA           �           ������������������������P        _FillValue       ?      @ 4 4�                               �D    
   is_result                                          p       DIMENSION_LIST                                    �K     �      �K     �      �K     �   <�J�OCHK    �B     0       �     t  REFERENCE_LIST       dataset                                       dimension                                                                      P            �	            �M            ���c            ��             9�             b              �5VFHIB ��          �&     �$     �"     �      �     �     �     �g     m=     ���������������������������������������������������������                                                    x^c�i�P���@Z���ْY���	,�\�r��;a��\�:�^��[����s��*�;��y��ulϒ{�*NQ��O�H_����o�NLIKz�6V~|n�"㐂�[߮L8��C�iCĚ0������DdZ3�6�k�֏�5%K�V_��sW������Vv\�Gk��,���G�N��k1�������t��f>Ǚǃku��z�X���?��[�_N������,��K~�?�&��Y^�+r�gN�ͼJqˇ���k�߼�z���JBU�nZs�h���U�E�m�t��z&�z���7�{�ti�^Q�}{�rr����}B'ξ�}��3orj���o�o;��d��u�����x��NV�J�;���g�d�ur��@D�X��]&Ί��[
?�������=}Z�ً-�0t�����<e�^�����Of�$�3v&3���,=if��b�L�s۷$]���u�����w&�'�鋮��a�5�J!ò��ݽ]�3��m�.n
�|:[54�ቭPO�L�����>z|?h�/��m'�[f� ��96�	5����Z��9���σ\�+J���}�����'T��V��YA7m��3��@�	����3f�l��m�a����J��18̀��^������i�OO�+dx>j����~n}ܹ����=gg}
ޛ�pk�X�[�=?��
lw#�����������N�V����յW,��
��~����襵�;���($S�y��/��x��3H�Ϝ�7s��֫♚k���W��bx5���l��K��B��~�C�.�i_f�P��Π��	��ef� 0�k��wG�ڍ��B���P���X�D�v��WB�r����l��p�╛����v��4�Z+�~�Q4Tß���3p	+�YxFd��>֠1u���3gf5��Vw�o�t񷄑o�C�{>���+�mU��Qr�A���⤅7?�X�v�=%�kVç��@Aՙ_�?�w��z&&f0`�&���H� X��A �(�������⳰��ظyyyxy��a&�h&f��Pq�7�b�H;/� �  ]=oTREE  ����������������C                              �2                    �                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      x^c`���v"a�-mg`|(8j+��\���4q}	�W�B����{��E=�<��&>;�
�eh�k�2$7܅&��t���ܯ�E���+�k�x�bф�g�?��= �M<oj��x�S��5DX;R�o鿄&��W���]�h�K��.=z��M�z�t�[=�Ag�ql�#���h��t�?8��#���+6Ͱ�\(�&�Vvq�����h��w�ӝl�WM|�iZ~~D���'�<e�ef����^������='Є��ߙ�Bw�#z�0r���9���&�{rR���e��h�o�Lh?�ʋ&~$.�1^|k$���mB^�*��_��3�nM�1�1zz�]�u����h�{2����- M|�S�;���颛��k�������+�Jca�.ڦ�&�z���X����m�ߝ*b�&����ނmiIh�J�kz��~F�_��n��+�C��W+�G��]4��iG�]�mю&���@��ft�	�����߼}���l4��{�߱y)z�m������v���<r�������D_��˗�^\�&2���ז����r���K�7�����  ED�	TREE  ����������������                       �c                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           FHDB ��         I))�       cost_varb      �       cost_investment�M     �       unmet_demand�j     �       capacity_factor�f     �       systemwide_capacity_factor�     �       systemwide_levelised_costc}     �       total_levelised_costW{                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  TREE  �����������������                                      �P                           �                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              OHDR�(                                         ?      @ 4 4�              �            �8             shuffle            deflate            ~`                   ������������������������P        _FillValue       ?      @ 4 4�                               �D    
   is_result                                          `       DIMENSION_LIST                                    �K     �      �K     �   ��OCHK    9C     P       �     t  REFERENCE_LIST       dataset                                       dimension                                                                      �             �F             TP             �            c}            Z�{�            b              �M             ���x^��wP�ۺ� �APD�
�i*E�@�"��^E�)� �@���E�"�b�Mz��	(]P�
H�v��ɝ=�{�g�0�'�Ǭ!+_ ���|�~k���t�&D ���_g?Uy'�Fw�y\��O`��4�Q�D��uwp}l�����V�ݓ �s�x��2ɞ��lWj���� o6�:�s�����^�{���J��Ur�u��TG̾nz����ɭE^��>Rvafo�U�Y�_t��W%$�$w�]�z�<:wg(�c�a��j+^[ɋ��I�3��TEF/(&RV�����ZԠM<D;?L��_;ʞ����{w+��p?�u�-�C��Nv����_��y&��"������MU�Z8�Z�JswM�X���岖��E�V� �>	[י�сr�P�3������I�+Y�?�@��T�8e��N6�̓��g�~p���#��&�5$,h{Q�1���a��f�/(?�k(���W�<H^刐F�3Ӯ�o*$�(ҷ�iN8�,3��	�����/t����@��5�YBx��ޭ�W��x�8w�X
�O�o�sW��. Ƿ
3�f�O�Lwés�����)�u��[�18������N�l]�P$�?v$�w��;�i�OP�a�3�n�ۧB�z�P��ޢ2� �1r꽒y9�ȓ�+je��J�vq�"��Ś��Q1��/�6�Q�F��|��r�9"���in�)H�|��̨�y?��Ձ�����W�o���DʘԒ
h�⤉c��"�M8��J��a���#�	7^_k@��Ԓ�G��^G�_NSO��+J=;����}��\��;a���5> ���%	*�`'Þg�_S�h�B�Z�8σ��ڣ� �3��M".�W���9�#Ls��ޔ2.V5ߑ��ɩ�νS��X8yi�P+���KA.N�&���:ؘ0��9�Ma��ϸ\ї�,k��hȤ�&�7�ѓ���L�ڸd��)�ʡB�nԫ����r�"�Pv&7rv���B޺�W����T���$J�Z'[��tD�h#3�d"���7�ܑ�-S�[��Д�;d�$����m��74�EgStp�}������}qz'c�=��L!�qa##W�`���l��ɯ���Ҥ�&'u�����ڤ��B%�+��cz�,rʧ���r��Y����0,�S��V�{�<�M}Lp��b+�&�l���5���	n[	��5�_j���dW��p��d�<A��bD^x4"���S��S9i�����;��mT��IZ�3�_P��:WK|o<}[f{iy���عͳ�^3Թ�$�ݸ� �~��$�~\��<�Q��:���%��g&-)߿i�U��-=l���k-8��-�z���N�z۾��ӾAjߡ�WC�)f[%�Ֆn��֗
A��O�5�q&�՚��qrų���a���T����e��~y���r;�|�ò�]���P[�i0K c`x:���*��i�5ə�v�R#�oV�Gg�)�z�_@�B(hs�d�X�buBj߭}��^P�a#��;�$x��x�������B��`'�ƣ�.�"�t[��b�P�ݞ�dC�|K|���/��ľ_e���䦨�����=z����<�Ah3Mׇs������F0�{S��<�cD�^H�7Fk~� p(����ao1ٔ$H�����M���ʸ�?_Sk%-%s:�T�3��3h뎈�dQ<a<4y�ahQ�~��Z�����v���aU��^f������ʾ�rߌ%Ԯb�#hJ�y?�f�̻$�������])̤�E.A���?������9�Oa�����N���#�J"7�}򍪯�:]���{F.N�]�	��iB	�.QH��U@��Pb�"��No�N���Z��}h|D��.��%[(�l������h�9�^��^�Qߩ�������s]B|,{H�ŕ�i;c�TNA��z#8~LFR���j��X�V��-�"��:m����?��5�$Li��.�S][1J�*�
9+L��VV�����ׅ����R]��m���:�;A8&#Rz�Mk��W��ߍ��0�����|X<�ܴ����%7�}�:x��+W�W-v��3����4�:�P����_�ؖHmg'|�)�_���+���#r��R���b�hY3U�.ߞ��Y���&pR�G����$���o.i���CU�)HQڊ���hd<h�gΗF������Y������|�y����Ȕ״ŗ�j?��
z�v:fyS7�EI�V��2�t�0~6�A��vy
S��]&Op@��_23��De~����~� ��N���ɉ��g������s<,`��gf�Ƙ����%澪�yɧK�/�Q�q���ϕ��9;"g�a'�1��M�C�C6�5P��u��xm�US�y��1�d��8^R���n��Ȍ�$"ݻ�Q�v�;�4g�:�B�.�;�#�E�μ�ᇙ��������"XŚ��~���{ϔ�
��[��HQm.I���\�!�*�������j*v�L�mY�� �	+z�8�%o�!�=�T�B5��f������3(׺2'�ΗŻdu���a��m�Z8� E�"���Nj����r\1SN	�J���A�ڳ.�.����mY:��*��Z�.#�}RU�+�l)l/���F�</�1w���:�1i��ߑ����Qt��5��]�'*�jl�}���BG�Y+�Q ��߳%��ss�Kp~���z�~�z�\K�<�a�a)�%g�D�n��u�y�
L��^��;]��T�B/�Õ�'�1�$u.=5�dUSS�wM<ᾐ�*� �Jv�X"�;A���l-F�S�n��U��h��E�P
��6\f٬.��X'}&b����>���{����4h���@��h"/���-u%��Y�?����s��dm9�
R��L䉅"
;�ʒ�Dn�4e��Gp��z�����u�i]������b�p;�;�xrq�,���\���SW�&˦`�k�sa�٬z��(�q�5����, �/�>Բ�9+̯�%6��:S�@���s���>�ӓ)���L/��G3��xXA�|~�s�L:!�Q��A�;K�t�=��5bR�[1��M����٩q��Ԙ�zM��碡�Y�B�n9=#S�|1�Ս�>�E��I/=��I���R����6xﹽ���}峎%�l�j�x�X��o��PT��J���˂�g7���d7^AM&�a��>���nl�M�eB����@���}��qYy,VB͙x?&�q���0��O�v��_G�iu�x�?�pՔo�-<�7��j��������Z��ף:z��q�Ғ>Ԏ'u��R
�{2�Ac����oI��?�j�n��A���p��֥0⴬�a������̚�H9t��[J=�'h�"j��T]��k�GBF����(���
��w0#'����Y�)9"����&&b����.:-3�yr��?8����cN�:N���av���V#��Tb����(�<--�M*jJF���( �*F���@��Sqb@�����@���@� C2J ��Y�?5�'abb�8~������/ E���2 ����g��I $��?�B�()i�((��o�31�� 0�6
�t|0���������c\>�8(���������knn�R\��ohh�o3	7�����*�����7L;��g`c`�o`hl�+��U������M,��`F0��\�"*V�53��7��&�0yA9񯰰�@��n)��fjaj��x�!8-+%� ��񾁚���'�����%l8rp�����U�F?|��i�KRR�vF ��(�hLTbnG�I�^�@��!�8�8ӏrk�D���ѩ�($����/�=��p�G1��Jp��s_����បPlx�MV�A{�?��y�;�s�?��������;�������*�P��1�4���O�B�c�TREE  ����������������!                               �c                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          OHDR�(                �              �           ?      @ 4 4�              �            �8             shuffle            deflate            �l        �           ������������������������P        _FillValue       ?      @ 4 4�                               �D    
   is_result                                          `       DIMENSION_LIST                                    �K     �      �K     �   ?Pj�TREE  ����������������@                              �                    �                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      OCHK    �A     @       �     t  REFERENCE_LIST       dataset                                       dimension                                                                      p�             �f             ���JOCHK            �X    t  REFERENCE_LIST       dataset                                       dimension                                                                      Dd            �x            E�             P�             p�            +�            "�            ��            b             �j            �f            �L��BTLF �        �  & �        �  # �        �  ' �        �  ' �        #   �        @   �        _   �        �   �        }   �        �   �        �   �        �   �           �        0  " �        R   �        q  " �        �  - �        �  , �        �  ' ]p��                                                                                                                                                                                                                         OHDR�(                                         ?      @ 4 4�              �            �8             shuffle            deflate            �                   ������������������������P        _FillValue       ?      @ 4 4�                               �D    
   is_result                                          `       DIMENSION_LIST                                    �~           �~        ��        K��OHDRW8                                                       ?      @ 4 4�      g     �                   �8             shuffle            deflate            x�                      ������������������������P        _FillValue       ?      @ 4 4�                               ����                                       GCOL                        �s                    z                   ��                    ��                    �                    ��                    ��                    ��      	              ��      
              ��                    �                    ��                    ��                    ��              �                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      x^��oHq��_�*YQ>�
*�AJ�=��e���	>�&�)E����)�d�e�1��3�M(*�Sʬ\��ԅ����$&i��Q(���!�~v���;Bfk����ִk�X�B��2���>�0
��_�&��4��̹�4;�rp���M"
�C�#�ɏ �	!?y#��=5���WT��{�w��3Ȝ�^���ьN���"�o�BW�S�.Da6��rz� Q�Ͼ����tj�'i�{���ˋ�]E&�MbJ�5�)O��d/�'���e!��
a�e3qm�>���mǺ�c*T��]�o�N ��&������&�N�E�'�=�"��A�H���k[�V>G�v֒��7�?�踵\�_ݟڹL�0*�,J�u緌gul�Ajwz�� B��x��"T�ܸ�`�}:�:u��vT����ך �m�+�T�@��禘��z���!Da?� �iA�+ell����N����P+*	��_��>"F��h������58�^��U#�!���Da�l��(�.����_�߾�M����I���{���?���)TREE  ����������������o                              e�                    �                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      x^��y4������ز��D�,��$K��}71C(&��Ì��.k�n4���%Cd��d��lO�}�y���s�����c�|_�>�:ߙ�=s���X�::��$�����ֳ��$�q���uN~�|�7Ei�Q�ޔU�}�m�CuYQ��ic��P҃���)���8���=�U����Y�K�%�g�m˿�0jU7#�pK�9R����o�s���G��u�����\�9$�(���U�&���;̨���X��s�;�)>���!�LE18�j,|Ǯxetq
�E�����J������c�Tb�\-
�?ݟ9����)�?�M��\=ƍ���Q����tQ����]/�+�L�_c~���D;�Yz�0�bZP��ބ��h�=��J�g�rdo�I��~�%�s¯}o�T��xt	`T@����6V\��B���	�bЦB%����p51�<"(|�jY�ku:C�x}�l�~]�V��vf��I6��Z놟�(��๾^3yy�Ԡz�<�������d<bI��� ;0��d<$�@��ZrjߙU�jdyc*{Y�l����;�����1��mS��)�=J��p��-g��m`
O��&l�ɛ§��`���:
�����}�e?X��O�����U:��V�K����9�v�D�0n�onk���5�p�z��k���"/sz�oa��3�=��Q��v�K���T�Ѷ�X�S��e����S���b�˟b����U�&��,1�@������F9QJ�� �1Y����_G�^e���9��F��ahq�*l��)��w�O�V��Zԧ�����*�u��e��=x�z%�LnP\Nw]l{��6�������i�%c������F@S�n;=��+X�D��MQy�$�U����N�އ�W���\|�s��|�'3����D���/ӈĥ�+#1b�)\kW���E�3�o�����v�ω�LM'6�����~W)�S�:{�2O�}��:��+�B����'-�H���T{n5���SǺ�%�L{��]�T�w�����i��,u�=�5|��p��r1P>�ZX`��yf�<\��k�!q�����^y^1�#�
>�Ah<d��9��ĦiL�1�R�[Bh�ە�
c�{|��2v��M~0�M��٠��<g``ja]�����.l�f��^RԼ��i�3Ǻ^�����]��!�J�K`__q(q6m�O-�Te:�m����'a�Ǘ��sa�w�pL�V������D����=�����P�@�����)M�����M�mmQ �:~�h@q������&*g�_��X��|E��_I�����jAB��3�Z�l������7���R��S'��(7c.o'5�T�d P� 7��@���w��6��<�T�"���cw������>=߸��:�6�������Yj�����>G�|ֻ�9z����:�ᘑV��{έ�����������c�s�ɥ���F5'� ���猙���7��nL�?������������F{w�����uH��N�,oR����ٯ���&��Ff�J�-NtH83�e;��xOD���Ư�FG���@_Gk��~ɇN
߈!; c�,�5a^~��gP��>�}y:X�.6x�*�߼�2|��#k�F2���*��|x]�����o|9�䷲��QK�|���C�i
����^�L�]�MX���w���a�p��9���p�0������TB���2*�&j�
�Bjh�ʜ������l���+Q9Ѱ>�h��3Q�>T{���#�΋{��;өAXVB�IF ���;�^�DI�����=n�E̸~5h6IL��!M�������;�T���'KvG�Ʊ>�Hb�*J�o�4D�w�!����8<ҧ��l���'xY��6��ો�Ĵ�˚�K4��'V5�>OT��|����+d�|yU	��8wf�4&.�3��Ƙ�����@:>��)ړ��_���"�#�ľKzhy�I���4�h3��=�p)Y�����3gTrM@t�3�`R ���v"�_��*��X;	���'oxHm�9ϧRxq��G�4�$C(�Y�ɍ�y�f�31���ޯkj5��m���Vr�}[�߫�`�����sgX��������X$��uQRl������e����X~5���w����-3=q�[(�j/mx{����~�̺DyR�d���][�;�l��}�(�xD&�����}?���!v�xj
/���=�X8X��~4郰\��P'-?As0_<Ig� ;�1�#sr9M05l�Ά0��3k�J�a
�6�� �.wܐ�-4;�0Ae��rp�qZda�<����J% ��씮u���:wדYB�|3���m�<P[\����X�2m̧�׿�)��yw7�n�j驢E7�����f�s�����ol��c�fB�rǟ�tt ��M=2��t�z�ˇ�N �u����`6?Z�nh!`�K�k�����B:	�j�.:����N����`a��Bū��D��"�]�C�;S:�k��_��֒;�̊(~���P��(aH-~yBM�b+x����:��3���������"�����'o�Z�\�-��kͷ��X�h��m�B���Aq���_I�+Ik��� �*��r��89=R����5��b�D����R�&y��ea�/9���r�E���̷��Q6xe*�6H����k+9h�E*��{^
x���i������L]�v�
o�ey���TQ8aVe�0� I9�:�63\uc���uδ���$(�h-��e��ڃuq����|��ӟ@t}t�B>�0�w������"S���{G�`>8b<�:�i綧�3b�B�͢�.�?�Q��+]�f�)I����$V���L��g3�_�1�U-j${sD�[�i!yg��$�����w{���3-3@}�(b���d6�hT�rF��m���U���x�+P����f�I�On++g�	i��w����|�t/h�3>�o�%�`2Օv�QM}v�$�o_=d(���L���2�V�
7��*J9k�M/ߋ絋AD�<�%����=j�q���$�XvU���4=��2�*��E��\{�M���(�G���ԗ��*����݊6���-x�G�p��n��*L�[+䧄Ry�6��3G/��ǲ���H�g���n��5*!Xyj�6$a�-�E����L���sHA���� �����G�(!Ђ���ς���U�_!I�%3��j�}��GU=VqH]�����;,�މM��#�"lS*��ّ�鄴K���k��M2TW1��
'툻lZ�HRx��s[O��r���=k�~�`�C� �ph���pq�B��v���1���aa�8�la� �à}P,����Op8�
'���"��׿�Hd����k�l��N/���枋D�!s,\�.ش��
uv�����m�������s�������Cf���sy��"��=>6&*2�>3���ne)5!ߑ��\[�8����X���b�q�8bBbjV~y�����>q*v ����`�J���ps/q�qѣ	�(L\">�O�Y�8~W܏[i툏�D���tc�������ɷ��\0za�{��WQ���8@꫙�]�Ό���9����u������g����`!3a��:�J>�V�~q���k	

��I+h����_Gr���pq��������A	��	�������� ꦉ��>��%Xύ� ��� ��� ���%�>"�d$yN23se�C�c#ڢ�p��W�9	���:04B�oDQxde[WoogS$�g�}�'b)��a��7��έkom.� ?Oi�7�?!o8�����:%�/�T����)?���S#�����:TREE  ����������������S                               �c                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          OCHK    �C            H    t  REFERENCE_LIST       dataset                                       dimension                                                        
       
       	�             P             �	             1             ��             9�             b              �M             c}            W{            ��p                dimension                                                        	       	       	�             P             �	             1             ��             9�             b              �M             c}            z�<TREE  ����������������I                                       ��                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         OCHK    �C             �     t  REFERENCE_LIST       dataset                                       dimension                                                                      Z             g�             �             c}             W{             �W'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  x^c�)�������!�;�\ +�aK�L ˈAp"�e�p�ªc�
a5}���Ǉ�>�xPoo__D�� ��TREE  ����������������                               d                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          