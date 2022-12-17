install.packages(c("httr","jsonlite")) #Need to install httr and jsonlite
library(httr) #Need this for your API call
library(jsonlite) #Need this for translating the data to R
json_response <- GET("https://comtradeapi.un.org/data/v1/get/C/A/HS?reporterCode=124&period=2016,2017,2018,2019,2020&partnerCode=0&cmdCode=100199&flowCode=X", add_headers("Cache-Control" =  "no-cache","Ocp-Apim-Subscription-Key"= "4c05c9c7506d403c87367b23c3f32295"))
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
