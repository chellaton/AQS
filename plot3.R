library(dplyr)
library(ggplot2)
# use subset to filter out Baltimore data with fips==24510
baltimoreData <- subset(NEI, fips=="24510")
# use group_by to group by type and year
bg <- group_by(baltimoreData, type, year)
bg$year <- as.character(bg$year)
# summarize total emissions by type and year
#
df2 <- bg %>% summarize("Total_Emissions"=sum(Emissions))
#
# initialize png file
png(filename="plot3.png", width = 480, height = 480, type="quartz")
p <- ggplot(df2, aes(x=year, y=Total_Emissions, group=type, color=type)) + ylab("Emissions in tons") + 
  geom_line() + 
  theme(legend.title=element_blank())
print(p)
# close png file
dev.off()
rm(p)
# remove object with output of ggplot since it has been printed to file
# end.

