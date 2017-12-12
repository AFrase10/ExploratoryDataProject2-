############### 4) Across the United States, how have emissions from coal combustion-related sources 
# changed from 1999-2008?

if(!file.exists("exdata%2Fdata%2FNEI_data.zip")) { 
  temp <- tempfile() 
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",temp)
  file <- unzip(temp) 
  unlink(temp)
} 

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


merged <- merge(NEI, SCC, by="SCC")
library(data.table)
df <- data.table(merged, na.rm = TRUE)

# Filter for coal combustion-related sources
coalCom <- grepl("coal", df$Short.Name, ignore.case=TRUE) & grepl("comb", df$Short.Name, ignore.case=TRUE)
coalComDF <- df[coalCom, ]

totals <- aggregate(Emissions ~ year, data = coalComDF, sum)

png("plot4.png", width = 540, height = 440 )
par(mfrow = c(1, 2), mar = c(4, 4, 3, 4.5), cex = 0.65)
plot(Emissions ~ year, data = totals, main = "Total Emissions / Year Produced by Coal Combustion")
abline(lm(totals$Emissions~totals$year), col="red")
boxplot(Emissions ~ year, data = coalComDF, ylim = c(0, 6), main = "Distribution of Data", xlab = "year")
dev.off()

