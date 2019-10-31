library(dplyr)
library(ggplot2)
#
# get list of Motor Vehicles related codes from SCC.rds
#SCC <- readRDS("Source_Classification_Code.rds")
#NEI <- readRDS("summarySCC_PM25.rds")
# filter for Baltimore
baltimoreData <- subset(NEI, fips=="24510")
motorSCC <- (SCC[grep("Motor",SCC$Short.Name),1:3])
# join Baltimore NEI data with motorSCC by SCC
motorNEI <- merge(baltimoreData, motorSCC, by="SCC")
# filter for Baltimore, group_by year & summarize
motorNEIgroup <- group_by(baltimoreData, year)
motorNEIsumm <- summarize(motorNEIgroup, "Total_Emissions"=sum(Emissions))
png("plot5.png", height = 480, width = 480, type="quartz")
p <- ggplot(motorNEIsumm, aes(year, Total_Emissions)) + ylab("Baltimore Emissions from Motor Vehicles in tons") +
  geom_line() + geom_point()

print(p)
dev.off()
