
library(lubridate)
hhpc <- read.table("household_power_consumption.txt",header = TRUE, sep =";")
#Add Datetime columns concat Date and Time
hhpc$Datetime <- paste(hhpc$Date, hhpc$Time)
hhpc$Datetime <- dmy_hms(hhpc$Datetime)

#Subset asked two days 
hhpc.filtered <- subset (hhpc, hhpc$Datetime >= ymd("2007-02-01")  &  hhpc$Datetime < ymd("2007-02-03"))

#convert data
hhpc.filtered$Sub_metering_1 <- as.numeric(as.character(hhpc.filtered$Sub_metering_1))
hhpc.filtered$Sub_metering_2 <- as.numeric(as.character(hhpc.filtered$Sub_metering_2))
hhpc.filtered$Sub_metering_3 <- as.numeric(as.character(hhpc.filtered$Sub_metering_3))

# open device
png(file = "plot3.png", bg = "white")

with(hhpc.filtered, plot(Sub_metering_1 ~ Datetime, type = "l",
                 ylab = "Energy sub metering", xlab = NA,  col = "black"))
lines(hhpc.filtered$Datetime, hhpc.filtered$Sub_metering_2, col = "red")
lines(hhpc.filtered$Datetime, hhpc.filtered$Sub_metering_3, col = "blue")


legend("topright",  legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1,1,1), col = c("black", "red", "blue"))
dev.off()



