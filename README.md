# R code of permafrost indices and visualization

#### R Script for Plot Meteorogical station observation data and permafrost indices (MAAT and MAGST)


----

### Scripts

> ##### MAAT.R
>- Function for computing Mean Annual Air Temperature (MAAT) index

> ##### MAGST.R
>- Function for computing Mean Annual Ground Surface Temperature (MAGST) index

> ##### Meteorogical.R
>- Plot Meteorogical station observation data, MAAT and MAGST indices

----

### Data

>  The **Data directory** "./Data" contains the following data:


|     Data file                                           |     Description    |   
|---------------------------------------------------------|----------------------|
| Golmud1955-2018.csv | Meteorological observations of Golmud field station |
| Wudaoliang1956-2018.csv | Meteorological observations of Wudaoliang field station |
| XDTMS2014-2018.csv |Meteorological observations of Xidatan field station |
| XDTMS2014-2018_GT.csv | Xidatan field station, ONLY Ground Temperature in different layers|
| XDTMS2014-2018_PREC.csv | Xidatan field station, ONLY Precipitation|
| MAAT_MAGST_Golmud_Wudaoliang_1956-2018.csv | After running MAAT and MAGST, the data of the two field stations need to be merged together for plot. This data is data that has been manually merged.|

----

### Usage


> **Please execute the following statement in Rstudio or R software.** 

>  First, please install **ggplot2** package in Rstudio or R software, and set the environment variables.
> 
```r
install.packages('ggplot2')
library('ggplot2')
# Init
# clear the environment
rm(list=ls())
# set workdir
# setwd('./Script')
# Data directory
DataRoot  <- './Data'
# Figure directory
FigRoot  <- './Figure'
```

> and then run Meteorological.R.

```r
source('Meteorological.R')
```

> Or copy the code in Meteorological.R **in turn** and execute it in Rstudio or R software.

> MAAT.R and MAGST.R have been implemented in Meteorological.R, **no additional execution is required.**

> 
```r
source('MAAT.R')
source('MAGST.R')
```

----
### Operation video
![Operation GIF](https://github.com/iffylaw/ESSD-2020-106/blob/main/ScriptRstudio.gif)

----
### Requirements

>- RStudio Version 1.3.959 or later
>- R Statistical Computing Software, 4.0.2 or later
>- Package ggplot2 version 3.3.2

----
### License

> Apache License 2.0

----
### Acknowledgements

> The R Scripts were prepared as part of the Manuscript “An integrated observation dataset of the hydrological-thermal-deformation dynamics in the permafrost slopes and engineering infrastructure in the Qinghai-Tibet Engineering Corridor” (https://doi.org/10.5194/essd-2020-106) funded by the National Natural Science Foundation of China (41871065), the National Science Fund for Distinguished Young Scholars (41825015), the Key Research Project of Frontier Science of Chinese Academy of Sciences (QYZDJ-SSW-DQC040), and the Strategic Priority Research Program of the Chinese Academy of Sciences (XDA19090122)..

----
### Contact

>- Dr. Lihui Luo 
>- Northwest Institute of Eco-Environment and Resources, Chinese Academy of Sciences
>- <luolh@lzb.ac.cn>

----
### Reference:

> Luo, L., Zhuang, Y., Zhang, M., Zhang, Z., Ma, W., Zhao, W., Zhao, L., Wang, L., Shi, Y., Zhang, Z., Duan, Q., Tian, D., and Zhou, Q.,  An integrated observation dataset of the hydrological-thermal-deformation dynamics in the permafrost slopes and engineering infrastructure in the Qinghai-Tibet Engineering Corridor. Earth Syst. Sci. Data Discuss. 2020.<https://doi.org/10.5194/essd-2020-106>

----
updated: 31/03/2021
