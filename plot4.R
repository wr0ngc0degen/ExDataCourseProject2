require(dplyr)
require(ggplot2)
#reading data into R
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
SCC.coal.combustion <- SCC$SCC[grepl('combustion', SCC$Short.Name, ignore.case = T) & 
                                       grepl('coal', SCC$Short.Name, ignore.case = T)]
NEI.coal <- filter(NEI, SCC %in% SCC.coal.combustion)
NEI.coal <- arrange(NEI.coal, year, desc(Emissions))
png("plot4.png", 1200, 400)
print(ggplot(NEI.coal, aes(x=as.factor(year), y = Emissions)) + 
              geom_violin(aes(color=year)) +
              theme_bw() +
              geom_histogram(aes(color=year), stat = "identity", alpha = 0.1) + 
              coord_flip() +
              labs(x = "Year", 
                   y = "Emissions/Total PM2.5 Emission  from coal combustion-related sources",
                   title = "Emissions from coal combustion-related sources change across US")
)
#shut down graphic device
dev.off()