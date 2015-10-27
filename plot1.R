#reading data into R
NEI <- readRDS("summarySCC_PM25.rds")
#calculate sum by year and create a data frame to use for plotting
emission.total <- as.data.frame(tapply(NEI$Emissions, NEI$year, sum))
#add year as a first column
emission.total <- cbind(year = as.numeric(rownames(emission.total)), emission.total)
#set appropriate column names
colnames(emission.total) <- c("Year", "Total")
#open device for plotting
png("plot1.png")
#plot points
plot(emission.total, ylab = "Total PM2.5 Emission", pch = 19, lwd = 5)
#plot linear model
abline(lm(Total ~ Year, emission.total), lwd = 2, col = "red")
#shut down graphic device
dev.off()