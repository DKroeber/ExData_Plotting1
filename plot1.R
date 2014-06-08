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
 png(file = "plot1.png") ## Open png device; create 'plot1.png' in my working directory
 
####make plot1
with(total, hist(Global_active_power,
                 main="Global Active Power", 
                 breaks=13,
                 col="red", 
                 xlab="Global Active Power (kilowatts)",
#                  xaxt='n'   ###so that I can make custom x-axis later
                 )
     )


# axis(side=1, at=c(0,2,4,6), labels=c(0,2,4,6))  ###custom x-axis
 
 ####close device -- ALWAYS DO!!
 dev.off()
 
 
 
