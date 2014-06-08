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

####set all ? to NA, otherwise hist() wont' work. 
####First of all, have to turn the column of interest into numeric
total$Global_active_power<-as.numeric(total$Global_active_power)
total[ , total$Global_active_power == "?" ] = NA

 
###save plot
 png(file = "plot2.png") ## Open png device; create 'plot1.png' in my working directory
 
 ####make a x axis value that can be converted to thu, fri, sat
 x=seq(as.POSIXct("2007-02-01 00:00:00"),by="min",length.out=24*60*2)
 
####make plot1
with(total, plot(x,Global_active_power, 
                 ylab="Global Active Power (kilowatts)",
                 type='n'   ###so that I can make custom plot later
                 )
     )
lines(x,total$Global_active_power)

 ####close device -- ALWAYS DO!!
 dev.off()
 
 
 
 
