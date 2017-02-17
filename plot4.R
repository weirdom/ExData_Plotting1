
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
hhpc.filtered$Global_active_power <- as.numeric(as.character(hhpc.filtered$Global_active_power))

hhpc.filtered$Voltage <- as.numeric(as.character(hhpc.filtered$Voltage))
hhpc.filtered$Global_reactive_power <- as.numeric(as.character(hhpc.filtered$Global_reactive_power))

# open device
png(file = "plot4.png", bg = "white")


par(mfrow = c(2,2))

##1
with(hhpc.filtered, plot(Global_active_power ~ Datetime, type = "l", ylab = "Global active power (kilowatts)", xlab = NA))

##2
with(hhpc.filtered, plot(Voltage ~ Datetime, type = "l", ylab = "Voltage", xlab = "datetime"))

##3
with(hhpc.filtered, plot(Sub_metering_1 ~ Datetime, type = "l",
                 ylab = "Energy sub metering", xlab = NA,  col = "black"))
lines(hhpc.filtered$Datetime, hhpc.filtered$Sub_metering_2, col = "red")
lines(hhpc.filtered$Datetime, hhpc.filtered$Sub_metering_3, col = "blue")


legend("topright",  legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1,1,1), col = c("black", "red", "blue"),bty="n")

##4
with(hhpc.filtered, plot(Global_reactive_power ~ Datetime, type = "l", ylab = "Global_reactive_power", xlab = "datetime"))


dev.off()



