# Baltimore city data
# fips = 24510

baltimoreData <- subset(NEI, fips=="24510")
baltimireSumm <- with(baltimoreData, tapply(Emissions, year, sum, rm.na=TRUE))
year <- unique(baltimoreData$year)
png("plot2.png", height=480, width=480, type="quartz")
plot(year, baltimireSumm, pch=19, col="dark green", type="b", xlab="Year", ylab="Total Emissions in tons")
dev.off()