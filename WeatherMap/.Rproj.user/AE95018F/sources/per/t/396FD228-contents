library(tidyverse)
library(tibble)
library(httr)
library(geojson)
library(rjson)

##########################################################################################
## 
##########################################################################################
weather.meta <- function(lat, lon) {
  points.url <- paste("https://api.weather.gov/points/", lat, ",", lon, sep = "")

  resp <- httr::GET(points.url)
  status_cd <- status_code((resp))
  if(200 != status_cd) {
    return
  }
  
  body <- content(resp, "parsed", encoding = "UTF-8", type = "application/json")

  meta.tbl <- tibble( 
    http_status = 200,
    cwa = body$properties$cwa,
    gridX = body$properties$gridX,
    gridY = body$properties$gridY,
    forecast.office.url = body$properties$forecastOffice,
    forecast.url = body$properties$forecast,
    forecast.hourly.url = body$properties$forecastHourly,
    forecast.grid.data.url = body$properties$forecastGridData,
    forecast.grid.stations.url = body$properties$observationStations,
    forecast.zone.url = body$properties$forecastZone,
    county = body$properties$county,
    fire.zone = body$properties$fireWeatherZone,
    time.zone = body$properties$timeZone,
    radar.station = body$properties$radarStation
  )
  attr(meta.tbl, 'info.type') <- 'nws.meta'
  meta.tbl
}

##########################################################################################
## 
##########################################################################################

forecast.periodic <- function(meta) {
  
  if("nws.meta" != attr(meta, "info.type")) {
    print("BLEAH")
  }
  
  resp <- httr::GET(meta$forecast.url)
  status_cd <- status_code((resp))
  if(200 != status_cd) {
    return
  }
  
  body <- content(resp, "parsed", encoding = "UTF-8", type = "application/json")
  body  
  
  #okay, now we build the tibble.
}

forecast.hourly <- function(meta) {
  if("nws.meta" != attr(meta, "info.type")) {
    print("BLEAH")
  }
}

forecast.gridpoints <- function(meta) {
  if("nws.meta" != attr(meta, "info.type")) {
    print("BLEAH")
  }
}

tb.meta.info <- weather.meta(28.0, -82.0)
tb.forecast <- forecast.periodic(tb.meta.info)