install.packages(c("httr","jsonlite")) #Need to install httr and jsonlite
library(httr) #Need this for your API call
library(jsonlite) #Need this for translating the data to R
API_key <- "YOUR_API_KEY_GOES_HERE"
years <- "2016,2017,2018,2019,2020"
HS_code <- "100199"
Export_or_Import <- "X"
Partner <- "0"
Reporter <- "124"

url <- paste0("https://comtradeapi.un.org/data/v1/get/C/A/HS?reporterCode=",Reporter,"&period=",years,"&partnerCode=",Partner,"&cmdCode=",HS_code,"&flowCode=",Export_or_Import)
json_response <- GET(url, add_headers("Cache-Control" =  "no-cache","Ocp-Apim-Subscription-Key"= API_key))
comtrade_data <- fromJSON(content(json_response, as = "text"))$data
graph_data <- aggregate(comtrade_data$"primaryValue",list(Year=comtrade_data$period),sum)

#Change the units from USD to billion USD:
graph_data$x <- graph_data$x/1000000000



#install a graph package:
install.packages("ggplot2")
library(ggplot2)

#Draw a graph
ggplot(data=graph_data, aes(x=Year, y=x)) +
  geom_bar(stat="identity",fill="lightblue") +
  labs(title = "Wheat exports from Canada to World", x = NULL, y = "USD (billion)") +
  scale_color_brewer(palette = "Dark2") +
  theme_classic(base_size = 16)

#Save the graph
ggsave("graph_Canada_wheat_exports.png",width = 8,height = 4,bg = NULL)
