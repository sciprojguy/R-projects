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
  print(body)  
  
  #okay, now we build the tibble.  this tibble has "nws.forecast" as its info.type attribute
  #and it has 
  # point <- body$geometry$geometries[1]
  # polygon <- body$geometry$geometries[2]
  # last.updated <- body$properties$updated
  # units <- body$properties$units
  # generator <- body$properties$forecastGenerator
  # generated <- body$properties$generatedAt
  # update.time <- body$properties$updateTime
  # valid.start <- body$properties$validTimes  ... needs to be parsed into two datetime objects
  # valid.end <- body$properties$validTimes  ... needs to be parsed into two datetime objects
  # elevation <- body$properties$elevation$value
  # unit.code <- body$properties$elevation$unitCode
  
  # forecast.periods <- body$properties$periods unrolled
  for( period in body$properties$periods ) {
    # number <- period$number
    # name <- period$name
    # start.time <- period$startTime
    # end.time <- period$endTime
    # is.daytime <- period$isDaytime
    # temperature <- period$temperature
    # temperature.unit <- period$temperatureUnit
    # wind.speed <- period$windSpeed
    # wind.direction <- period$windDirection
    # short.forecast <- period$shortForecast
    # detailed.forecast <- period$detailedForecast
  }
}

forecast.hourly <- function(meta) {
  if("nws.meta" != attr(meta, "info.type")) {
    print("BLEAH")
  }
}

#this is the money shot - here we get a tibble with a lot of vectors with
#named rows (named with date/time of forecasted values)

forecast.gridpoints <- function(meta) {
  if("nws.meta" != attr(meta, "info.type")) {
    print("BLEAH")
  }
  
  #forecast.gridpoints results have an "info.type" attribute of "grid.data"
  #
}

tb.meta.info <- weather.meta(28.0, -82.0)
tb.forecast <- forecast.periodic(tb.meta.info)