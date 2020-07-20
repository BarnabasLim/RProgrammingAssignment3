if (!file.exists("./course4/week1/")){dir.create("./course4/week1/")}
file.exists("./course4/week1/exdata_data_household_power_consumption.zip")
unzip("./course4/week1/exdata_data_household_power_consumption.zip",exdir ="./course4/week1/exdata_data_household_power_consumption" )

#Check the files in the unzip files
path="./course4/week1/exdata_data_household_power_consumption/"
file.names <- dir(path)
for(i in 1:length(file.names)){
  print(file.names[i])
}

setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )

h_con_data<-read.table("./course4/week1/exdata_data_household_power_consumption/household_power_consumption.txt",sep=";",
                       header = TRUE,
                       colClasses = c('character',"character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),
                       na.strings = "?")
h_con_data$DateTime<-paste(h_con_data$Date,h_con_data$Time)
h_con_data$DateTime<-as.POSIXlt(h_con_data$DateTime,format="%d/%m/%Y %H:%M:%OS")
h_con_data$Date<-as.Date(h_con_data$Date,format="%d/%m/%Y")
names(h_con_data)
unique(h_con_data$Date)
Dates<-c("2007-02-01", "2007-02-02")
Dates<-as.Date(Dates,  tryFormats = c("%Y-%m-%d", "%Y/%m/%d"))
h_con_data<-h_con_data[h_con_data$Date %in% Dates,]
unique(h_con_data$Date)
h_con_data<-h_con_data[!is.na(h_con_data$Time),]


#plot 2
par(mfrow=c(1,1))
with(h_con_data,plot(DateTime,Global_active_power,type="l",ylab = "Global Active Power (kilowatts)",xlab = ""))
dev.copy(png,file="./course4/week1/plot2.png")
dev.off()

