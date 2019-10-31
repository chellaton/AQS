library(dplyr)
library(ggplot2)
#
# get list of Motor Vehicles related codes from SCC.rds
#SCC <- readRDS("Source_Classification_Code.rds")
#NEI <- readRDS("summarySCC_PM25.rds")
# filter for Baltimore & LA
baltimoreData <- subset(NEI, fips=="24510" | fips=="06037")
motorSCC <- (SCC[grep("Motor",SCC$Short.Name),1:3])
# join Baltimore NEI data with motorSCC by SCC
motorNEI <- merge(baltimoreData, motorSCC, by="SCC")
# filter for Baltimore, group_by year & summarize
motorNEIgroup <- group_by(baltimoreData, fips, year)
motorNEIsumm <- summarize(motorNEIgroup, "Total_Emissions"=sum(Emissions))
#
# plot the graph in png file
#
baseLA <- motorNEIsumm %>% filter(year==1999 & fips=="06037")
baseMD <- motorNEIsumm %>% filter(year==1999 & fips=="24510")

LA <- motorNEIsumm %>% filter(fips=="06037")  %>% mutate(Total_Emissions/baseLA$Total_Emissions)
MD <- motorNEIsumm %>% filter(fips=="24510")  %>% mutate(Total_Emissions/baseMD$Total_Emissions)
names(LA) <- c(names(motorNEIsumm),"PCT")
names(MD) <- c(names(motorNEIsumm),"PCT")
motorNEIsumm <- rbind(LA, MD)

png("plot6.png", height = 480, width = 480, type="quartz")
p <- ggplot(motorNEIsumm, aes(year, Total_Emissions, group=fips, color=fips)) + 
  ylab("Emissions from Motor Vehicles in tons") +
  geom_line() + geom_point()
print(p)
dev.off()

png("plot6a.png", height = 480, width = 480, type="quartz")
p <- ggplot(motorNEIsumm, aes(year, PCT, group=fips, color=fips)) + 
  ylab("PCT Emissions from Motor Vehicles in tons") +
  geom_line() + geom_point()
print(p)
dev.off()
# close file