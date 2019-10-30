library(dplyr)
library(ggplot2)
#
# get list of Coal related codes from SCC.rds
#SCC <- readRDS("Source_Classification_Code.rds")
#NEI <- readRDS("summarySCC_PM25.rds")

coalSCC <- (SCC[grep("Coal",SCC$Short.Name),1:3])
#
# join NEI data with coalSCC by SCC
coalNEI <- merge(NEI, coalSCC, by="SCC")
# group_by year & summarize
coalNEIgroup <- group_by(coalNEI, year)
coalNEIsumm <- summarize(coalNEIgroup, "Total_Emissions"=sum(Emissions))
png("plot4.png", height = 480, width = 480, type="quartz")
p <- ggplot(coalNEIsumm, aes(year, Total_Emissions)) + ylab("Emissions from Coal in tons") +
  geom_line() + geom_point()

print(p)
dev.off()
