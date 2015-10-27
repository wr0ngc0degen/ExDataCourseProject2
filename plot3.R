#load ggplot2 package
require(ggplot2)
require(reshape2)
#reading data into R
NEI <- readRDS("summarySCC_PM25.rds")
#filter Baltimore data
BM <- NEI[NEI$fips == "24510",]

BM.molten <- melt(BM, id.vars = c("year", "type"),measure.vars = c("Emissions"))
#count sum for particular year and type
BM.sum <- dcast(BM.molten, year + type ~ variable, sum)
#open device for plotting
png("plot3.png",height = 400, width = 800)
#plotting on four different panels - separate panel for different type 
print(ggplot(BM.sum, aes(year, Emissions)) + geom_point(size = 5) + 
              facet_grid(. ~ type) + 
              geom_smooth(method = "lm", se = FALSE, color = "orange", size = 2) + 
              ylab("Total PM2.5 Emission") +
              ggtitle("Total PM2.5 Emissions in Baltimore grouped by type") +
              theme_bw())
#shut down graphic device
dev.off()

#alternative
# BM <- BM[BM$Emissions != 0, ]
# ggplot(BM, aes(as.factor(year), log(Emissions))) + 
#         facet_grid(type ~ .) +
#         geom_smooth(aes(group = 1), method = "lm", 
#                     se = FALSE, color = "yellow", size = 2, alpha = 1/2) + 
#         ylab("log PM2.5 Emission") +
#         ggtitle("PM2.5 Emissions in Baltimore grouped by type (log scale)") +
#         xlab("Year") +
#         theme_bw() +
#         geom_jitter(alpha=1/2, aes(color=as.factor(type)),
#                     position = position_jitter(width = 0.3))