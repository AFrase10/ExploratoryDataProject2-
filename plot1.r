##### 1))Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base 
# plotting system, make a plot showing the total PM2.5 emission from all sources for each of 
# the years 1999, 2002, 2005, and 2008.

if(!file.exists("exdata%2Fdata%2FNEI_data.zip")) { 
  temp <- tempfile() 
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",temp)
  file <- unzip(temp) 
  unlink(temp)
} 

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

totals <- aggregate(Emissions ~ year, data = NEI, sum)

png("plot1.png")
plot(totals)
abline(lm(totals$Emissions~totals$year), col="red")
dev.off()
### Yes the total amount of PM2.5 emission decreased with year. Points on the graph represent
# the total amount of emission per the corresponding year.

