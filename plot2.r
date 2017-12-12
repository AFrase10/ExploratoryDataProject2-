############# 2)  Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.

if(!file.exists("exdata%2Fdata%2FNEI_data.zip")) { 
  temp <- tempfile() 
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",temp)
  file <- unzip(temp) 
  unlink(temp)
} 

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

Balt <- NEI[NEI$fips == "24510",]
Btotals <- aggregate(Emissions ~ year, data = Balt, sum)
png("plot2.png")
plot(Btotals)
abline(lm(Btotals$Emissions~Btotals$year), col="red")
dev.off()
