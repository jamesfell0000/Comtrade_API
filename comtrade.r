comtrade <- function (API_key,HS_codes,Export_or_Import,Partner,Reporter,Periodicity,Period) {
  required_packages <- c("httr", "jsonlite")
  not_installed <- required_packages[!(required_packages %in% installed.packages()[ , "Package"])]
  if(length(not_installed)) install.packages(not_installed)
  library(httr)
  library(jsonlite)
  
  url <- paste0("https://comtradeapi.un.org/data/v1/get/C/",Periodicity,"/HS?reporterCode=",Reporter,"&period=",Period,"&partnerCode=",Partner,"&cmdCode=",HS_codes,"&flowCode=",Export_or_Import)
  json_response <- GET(url, add_headers("Cache-Control" =  "no-cache","Ocp-Apim-Subscription-Key"= API_key))
  comtrade_data <- fromJSON(content(json_response, as = "text"))$data
  return(comtrade_data)
}
