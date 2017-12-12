################# 6) Compare emissions from motor vehicle sources in Baltimore City with emissions from motor 
# vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes 
# over time in motor vehicle emissions?

if(!file.exists("exdata%2Fdata%2FNEI_data.zip")) { 
  temp <- tempfile() 
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",temp)
  file <- unzip(temp) 
  unlink(temp)
} 

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#filter for city
merged <- merge(NEI, SCC, by="SCC")
library(data.table)
df <- data.table(merged)
cal <- df[df$fips == "06037",] 
balt <- df[df$fips == "24510",]
bothDF <- rbind(cal, balt)

# filter for motor vehicle emissions
MotVeh <- grepl("veh", bothDF$Short.Name, ignore.case=TRUE) & grepl("motor", bothDF$Short.Name, ignore.case=TRUE)
mvDF <- bothDF[MotVeh, ]

library(ggplot2)

totals <- aggregate(Emissions ~ year + fips, data = mvDF, sum)

png("plot6.png")
qplot(year, Emissions, data = totals, color = fips, main = "Motor Veh. Emissions in Cali. and Balt.") + geom_smooth(method = "lm")
dev.off()

