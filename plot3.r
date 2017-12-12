############## 3) Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable,
# which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? Which have seen 
# increases in emissions from 1999-2008? Use the ggplot2 plotting system to make a plot answer this question.

if(!file.exists("exdata%2Fdata%2FNEI_data.zip")) { 
  temp <- tempfile() 
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",temp)
  file <- unzip(temp) 
  unlink(temp)
} 

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)

totals <- aggregate(Emissions ~ year + type, data = NEI, sum)
png("plot3.png")
qplot(year, Emissions, data = totals, color = type) + geom_smooth(method = "lm")
dev.off()