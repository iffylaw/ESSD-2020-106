# Function for computing Mean Annual Ground Surface Temperature (MAGST) index
#
# Seasonal thawing–freezing n factor (nt∕nf)
# The seasonal thawing–freezing n factor (nt∕nf) relates thawing and 
# freezing degree-days (DDTa∕DDTs∕DDFa∕DDFs) 
# in seasonal air temperature to ground surface temperatures; 
# 
# nt = DDTs/DDTa
# nf = DDFs/DDFa
# where DDTa = ∑Ta, Ta > 0
#       DDFa = ∑Ta, Ta < 0
#		DDTs = ∑Ts, Ts > 0
#		DDFs = ∑Ts, Ts < 0
# MAGST = (nt*DDTs − nf*DDFs)/P, P=365
#
# Reference:
# Smith, M. W. , & Riseborough, D. W.: Permafrost monitoring and detection of climate change. 
#   Permafrost and Periglacial Processes, 7(4), 301-309, 1996.
#   http://doi.org/10.1002/(SICI)1099-1530(199610)7:43.0.CO;2-R
#
# Luo, L., Zhang, Z., Ma, W., Yi, S., and Zhuang, Y.: PIC v1.3: 
#   comprehensive R package for computing permafrost indices with daily weather observations 
#   and atmospheric forcing over the Qinghai–Tibet Plateau, Geosci Model Dev, 11, 2475-2491, 2018. 
#   https://doi.org/10.5194/gmd-11-2475-2018
# 
# Author: Lihui Luo (E-mail: luolh@lzb.ac.cn)
# Cold and Arid Regions Environmental and Engineering Research Institute, 
# or new institute name, the same institute to me, just changed a name 
# Northwest Institute of Eco-Environment and Resources,
# Chinese Academy of Sciences
# updated: 30/03/2021
#

################################################################################
# Computing thawing index (ti)
# if input air temperature variablename: Thawing degree-days of air (Celsius degree-days)
# if input ground temperature variablename: Thawing degree-days of ground surface (Celsius degree-days)
################################################################################
Thawing_index <- function(Year, TempName, data=QTP_ATM) {
  
  ti <- sapply(Year, function(Year) tryCatch({
    abs(tapply(data[TempName][data[TempName] > 0 & data$Year==Year], 
                     data$Year[data[TempName] > 0 & data$Year==Year], sum, na.rm=T))
  }, error = function ( e ) {ti <- NA}
  , warning = function ( e ) {ti <- NA}
  ), simplify=T)
  
  idx <- !(sapply(ti, length))
  ti[idx] <- NA
  ti <- unlist(ti)
  
  names(ti) <- Year
  return(ti)
}

################################################################################
# computing Freezing index (fi)
# if input air temperature variablename: Freezing degree-days of air (Celsius degree-days) 
# if input ground temperature variablename: Freezing degree-days of ground surface (Celsius degree-days)
################################################################################
Freezing_index <- function(Year, TempName, data=QTP_ATM) {
  
  fi <- sapply(Year, function(Year) tryCatch({
    abs(tapply(data[TempName][data[TempName] <= 0 & data$Year==Year], 
               data$Year[data[TempName] <= 0 & data$Year==Year], sum, na.rm=T))
  }, error = function ( e ) {fi <- NA}
    , warning = function ( e ) {fi <- NA}
  ), simplify=T)
  
  idx <- !(sapply(fi, length))
  fi[idx] <- NA
  fi <- unlist(fi)
  
  names(fi) <- Year
  return(fi)
}

################################################################################
# nt: seasonal thawing n factor 
################################################################################
NT <- function(Year, AirTempName, GroundTempName, data=QTP_ATM) {
  
  nt_a <- sapply(Year, function(Year) tryCatch({
    Thawing_index(Year=Year, TempName=GroundTempName, data=data)
  }, error = function ( e ) {nt_a <- NA}
  , warning = function ( e ) {nt_a <- NA}
  ), simplify=T)
  
  nt_b <- sapply(Year, function(Year) tryCatch({
    Thawing_index(Year=Year, TempName=AirTempName, data=data)
  }, error = function ( e ) {nt_b <- NA}
  , warning = function ( e ) {nt_b <- NA}
  ), simplify=T)
  
  nt <- nt_a/nt_b
  
  names(nt) <- Year
  return(nt)
}

################################################################################
# nf: seasonal freezing n factor 
################################################################################
NF <- function(Year, AirTempName, GroundTempName, data=QTP_ATM) {
  
  nf_a <- sapply(Year, function(Year) tryCatch({
    Freezing_index(Year=Year, TempName=GroundTempName, data=data)
    }, error = function ( e ) {nf_a <- NA}
    , warning = function ( e ) {nf_a <- NA}
  ), simplify=T)
    
  nf_b <- sapply(Year, function(Year) tryCatch({  
    Freezing_index(Year=Year, TempName=AirTempName, data=data)
  }, error = function ( e ) {nf_b <- NA}
    , warning = function ( e ) {nf_b <- NA}
  ), simplify=T)
  
  nf <- nf_a/nf_b
  
  names(nf) <- Year
  return(nf)
}

################################################################################
# Computing Mean Annual Ground Surface Temperature (MAGST)
################################################################################
MAGST <- function(Year, AirTempName="Temperature", GroundTempName="GT", data=QTP_ATM) {
  
  magst <- sapply(Year, function(Year) tryCatch({((NT(Year=Year, AirTempName=AirTempName, GroundTempName=AirTempName, data) * 
                                              Thawing_index(Year=Year, TempName=GroundTempName, data)) 
                                           - (NF(Year=Year, AirTempName=AirTempName, GroundTempName=AirTempName, data) * 
                                                Freezing_index(Year=Year, TempName=GroundTempName, data))) /365
  }, error = function ( e ) {magst <- NA}
  , warning = function ( e ) {magst <- NA}
  ), simplify=T)
  
  names(magst) <- Year
  return(magst)
}

# EOF