##### 5) How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

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
Balt <- df[df$fips == "24510",]

MotVeh <- grepl("veh", Balt$Short.Name, ignore.case=TRUE) & grepl("motor", Balt$Short.Name, ignore.case=TRUE)
mvDF <- Balt[MotVeh, ]


totals <- aggregate(Emissions ~ year, data = Balt, sum)


png("plot5.png", width = 540, height = 440 )
par(mfrow = c(1, 2), mar = c(5, 3.95, 2, 3), cex = 0.7)
plot(Emissions ~ year, data = totals, main = "Total Motor Vehicle Emissions / Year")
abline(lm(totals$Emissions~totals$year), col="red")
boxplot(Emissions ~ year, data = Balt, ylim = c(0, 5), main = "Distribution of Data", xlab = "year")
dev.off()