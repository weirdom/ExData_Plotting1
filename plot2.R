
library(lubridate)
hhpc <- read.table("household_power_consumption.txt",header = TRUE, sep =";")
#Add Datetime columns concat Date and Time
hhpc$Datetime <- paste(hhpc$Date, hhpc$Time)
hhpc$Datetime <- dmy_hms(hhpc$Datetime)

#Subset asked two days 
hhpc.filtered <- subset (hhpc, hhpc$Datetime >= ymd("2007-02-01")  &  hhpc$Datetime < ymd("2007-02-03"))

#convert data
hhpc.filtered$Global_active_power <- as.numeric(as.character(hhpc.filtered$Global_active_power))

# open device
png(file = "plot2.png", bg = "white")

with(hhpc.filtered, plot(Global_active_power ~ Datetime, type = "l", ylab = "Global active power (kilowatts)", xlab = NA))
dev.off()



