#reading data into R
NEI <- readRDS("summarySCC_PM25.rds")
#calculate sum by year and create a data frame to use for plotting
#filtering only fips for Baltimore, Maryland
emission.total.baltimore <- as.data.frame(tapply(NEI[NEI$fips == "24510",]$Emissions, 
                                                 NEI[NEI$fips == "24510",]$year, sum))
#add year as a first column
emission.total.baltimore <- cbind(year = as.numeric(rownames(emission.total.baltimore)), 
                                  emission.total.baltimore)
#set appropriate column names
colnames(emission.total.baltimore) <- c("Year", "Total")
#open device for plotting
png("plot2.png")
#plot points
plot(emission.total.baltimore, ylab = "Total PM2.5 Emission", pch = 19, lwd = 5,
     main = "Total PM2.5 Emission by Year in Baltimore, Maryland")
#plot linear model
abline(lm(Total ~ Year, emission.total.baltimore), lwd = 2, col = "red")
#shut down graphic device
dev.off()