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
                       colClasses = c('myDate',"character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),
                       na.strings = "?")
names(h_con_data)
unique(h_con_data$Date)
Dates<-c("2007-02-01", "2007-02-02")
Dates<-as.Date(Dates,  tryFormats = c("%Y-%m-%d", "%Y/%m/%d"))
h_con_data<-h_con_data[h_con_data$Date %in% Dates,]
unique(h_con_data$Date)

#plot 1
par(mfrow=c(1,1))
hist(h_con_data$Global_active_power,xlab = "Global Active Power (kilowatts)",col = "red",main = "Global Active Power")
dev.copy(png,file="./course4/week1/plot1.png")
dev.off()
