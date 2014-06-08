#### We will only be using data from the dates 2007-02-01 and 2007-02-02


 data<-read.table("household_power_consumption.txt", sep=";", header=TRUE, stringsAsFactors=F)
 data$Date<-as.Date(data$Date, "%d/%m/%Y")

##subset the data
data<-split(data, data$Date)
data1<-data$"2007-02-01"
data2<-data$"2007-02-02"

###merge the data for those two dates into one data table and remove 
###all other ones to free up memory

total<-rbind(data1,data2)     ####has 2880 rows
# rm(data,data1,data2)

####set all ? to NA 
####First of all, have to turn the column of interest into numeric
 total$Sub_metering_1<-as.numeric(total$Sub_metering_1)
total[ , total$Sub_metering_1 == "?" ] = NA
 total$Sub_metering_2<-as.numeric(total$Sub_metering_2)
 total[ , total$Sub_metering_2 == "?" ] = NA
 total$Sub_metering_3<-as.numeric(total$Sub_metering_3)
 total[ , total$Sub_metering_3 == "?" ] = NA
 
###save plot
 png(file = "plot3.png") ## Open png device; create 'plot1.png' in my working directory
 
 ####make a x axis value that can be converted to thu, fri, sat
 x=seq(as.POSIXct("2007-02-01 00:00:00"),by="min",length.out=24*60*2)
 
 ####define range of y-axis. Sub_metering_1 is limiting factor
 maxy<-range(total$Sub_metering_1, na.rm=TRUE)
 
####make plot1
with(total, plot(x,Global_active_power, 
                 ylab="Energy sub metering",
                 xlab="",
                 type='n',   ###so that I can make custom plot later
                  ylim=maxy
                 )
     )
lines(x,total$Sub_metering_1, col=1)
 lines(x,total$Sub_metering_2, col=2)
 lines(x,total$Sub_metering_3, col=4)

 ####add the legend
 
  plotnames<-c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
 legend("topright", # places a legend at the appropriate place 
        plotnames, # puts text in the legend 
        lty=c(1,1,1), # gives the legend appropriate symbols (lines)
        col=c(1,2,4),
        cex=0.9
 )
 
 
 ####close device -- ALWAYS DO!!
 dev.off()
 
 
 
 
