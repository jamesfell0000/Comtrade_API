#This gets wheat exports to the world from Canada in 2016-2020.
#Define and comment/uncomment the location of the comtrade.r file you downloaded
source("/home/USERNAME/comtrade.r") #e.g. on Linux
#source("C:/Downloads/comtrade.r") #e.g. on Windows


#Download from comtrade:
#Note: separate HS_codes with a comma, X for export and M for import, A for annual periodicity and M for monthly periodicity, months can be entered in the period as e.g. 201903 for March 2019.
comtrade_data <- comtrade(API_key="YOUR API KEY GOES HERE",HS_codes="100199",Export_or_Import="X",Partner="0",Reporter="124",Periodicity="A",Period="2016,2017,2018,2019,2020")


#Now make the graph:
graph_data <- aggregate(comtrade_data$"primaryValue",list(Year=comtrade_data$period),sum)
graph_data$x <- graph_data$x/1000000000 #Change the units from USD to billion USD:
install.packages("ggplot2") #install a graph package:
library(ggplot2)
#Draw a graph
ggplot(data=graph_data, aes(x=Year, y=x)) + geom_bar(stat="identity",fill="lightblue") + labs(title = "Wheat exports from Canada to World", x = NULL, y = "USD (billion)") + scale_color_brewer(palette = "Dark2") + theme_classic(base_size = 16)
ggsave("graph_Canada_wheat_exports.png",width = 8,height = 4,bg = NULL) #Save the graph
