require(dplyr)
require(ggplot2)
#reading data into R
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#fitering SCC for motor vehicle
SCC.motor.vehicle <- SCC$SCC[grepl('motor vehicle', SCC$SCC.Level.Three, ignore.case = T)]
#filtering for desired SCC and region
NEI.vehicle.BM <- filter(NEI, SCC %in% SCC.motor.vehicle & fips == "24510")
png("plot5.png", 400, 400)
print(ggplot(NEI.vehicle.BM, aes(x=as.factor(year), y = Emissions)) + 
        geom_point(size = 4) +
        #geom_violin(aes(color=year)) +
        theme_bw() +
        #geom_histogram(aes(color=year), stat = "identity", alpha = 0.1) + 
        #coord_flip() +
        labs(x = "Year", y = "Emissions") +
        ggtitle("Emissions from motor vehicle sources in Baltimore City"))
#shut down graphic device
dev.off()