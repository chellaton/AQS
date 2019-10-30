library(dplyr)
library(ggplot2)
bg <- group_by(baltimoreData, type, year)
bg$year <- as.character(bg$year)

df2 <- bg %>% summarize("Total_Emissions"=sum(Emissions))
png(filename="plot3.png", width = 480, height = 480, type="quartz")
p <- ggplot(df2, aes(x=year, y=Total_Emissions, group=type, color=type)) + ylab("Emissions in tons") + 
  geom_line() + 
  theme(legend.title=element_blank())
print(p)
dev.off()

