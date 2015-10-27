require(dplyr)
require(ggplot2)
#reading data into R
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#fitering SCC for motor vehicle
SCC.motor.vehicle <- SCC$SCC[grepl('motor vehicle', SCC$SCC.Level.Three, ignore.case = T)]
#filtering for desired SCC and region
NEI.vehicle.BM.LA <- filter(NEI, SCC %in% SCC.motor.vehicle & (fips == "24510" | fips == "06037"))
png("plot6.png", 400, 400)
print(ggplot(NEI.vehicle.BM.LA, aes(x=as.factor(year), y = Emissions)) + 
              geom_point(aes(color = fips), size = 4) +
              #geom_violin(aes(color=year)) +
              theme_bw() +
              #geom_histogram(aes(color=year), stat = "identity", alpha = 0.1) + 
              #coord_flip() +
              labs(x = "Year", y = "Emissions") +
              ggtitle(expression("Comparison of Emissions from motor vehicle sources \n in Baltimore City and LA")))
#shut down graphic device
dev.off()