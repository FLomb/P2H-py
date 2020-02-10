# P2H-py
Python code for the simulation of different P2H configurations.

## Overview
Power-to-Heat Python (P2H-py) is an open-source code for the simulation of different P2H configurations - including a heat pump (HP) and a thermal storage (TES) - and regulation logics of practical relevance. Those include: thermostatically-controlled regulation (TC), PV-friendly thermostatically-controlled regulation (PV-TC) and "smart" direct load control regulation (DLC). Further details about such regulation logics are given in the associated publication (see *Citing* below).

<img src="" width="700">

The repository also hosts all the input files used to generate the profiles appearing in the abovementioned study, which may be also used as a reference example.

## Requirements
The model is developed in Python 3.6, and requires the following libraries:
* os
* numpy
* pandas
* matplotlib
* math
* calliope

## Authors
The model has been developed by:

**Francesco Lombardi** <br/>
Politecnico di Milano, Italy <br/>
E-mail: francesco.lombardi@polimi.it <br/>

## Citing
Please cite the original Journal publication if you use P2H-py in your research:
*F. Lombardi, S. Quoilin, E. Colombo, Modelling distributed Power-to-Heat technologies as a flexibility option for smart heat-electricity integration, ECOS 2020*

## Contribute
This project is open-source. Interested users are therefore invited to test, comment or contribute to the tool. Submitting issues is the best way to get in touch with the development team, which will address your comment, question, or development request in the best possible way. We are also looking for contributors to the main code, willing to contibute to its capabilities, computational-efficiency, formulation, etc. 

## License
Copyright 2020 P2H-py, contributors listed in **Authors**

Licensed under the European Union Public Licence (EUPL), Version 1.1; you may not use this file except in compliance with the License. 

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License
