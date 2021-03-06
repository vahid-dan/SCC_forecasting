if (!"mvtnorm" %in% installed.packages()) install.packages("mvtnorm")
if (!"ncdf4" %in% installed.packages()) install.packages("ncdf4")
if (!"glmtools" %in% installed.packages()) install.packages('glmtools', repos=c('http://cran.rstudio.com', 'http://owi.usgs.gov/R'))
library(mvtnorm)
library(glmtools)
library(ncdf4)
library(lubridate)

Folder = getwd()

source(paste0(Folder,'Rscripts/EnKF_GLM_wNOAAens_V2.R'))
source(paste0(Folder,'Rscripts/evaluate_forecast.R'))

## EXAMPLE LAUCHING A FORECAST
out <- run_forecast(
  first_day = '2018-07-06 00:00:00',
  sim_name = NA, 
  hist_days = 1,
  forecast_days = 15,
  restart_file = NA,
  Folder = Folder,
  machine = 'mac'
  )

## EXAMPLE EVALUATING FORECAST AFTER TIME HAS PAST
evaluate_forecast(
  forecast_folder = 'forecast_2018_7_6_2018726_12_9',
  Folder = Folder,
  sim_name = '2018_7_6',
  machine = 'mac'
)

## EXAMPLE EVALUATING FORECAST AFTER TIME HAS PAST USING THE WHAT IS RETURNED FROM RUN_FORECAST.R
evaluate_forecast(
  forecast_folder = unlist(out)[3],
  Folder = Folder,
  sim_name = unlist(out)[2],
  machine = 'mac'
)

## EXAMPLE OF LAUCHING A FORECAST FROM A PREVIOUS STEP THROUGH THE ENKF

#INIITIAL LAUNCH
out <- run_forecast(
  first_day= '2018-07-06 00:00:00',
  sim_name = NA, 
  hist_days = 1,
  forecast_days = 1,
  restart_file = NA,
  Folder = Folder,
  machine = 'mac'
)

#SUBSEQUENT DAYS LAUNCH
restart_file_name <- run_forecast(first_day= '2018-07-07 00:00:00',
  sim_name = NA, 
  hist_days = 1,
  forecast_days = 8,
  restart_file = paste0(Folder,'/Forecasts/',unlist(out)[3],'/',unlist(out)[1]),
  Folder = Folder,
  machine = 'mac'
)

