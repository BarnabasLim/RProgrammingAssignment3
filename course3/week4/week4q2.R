GDPUrl<-'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
if(!file.exists('./course3/week4/GDP')){dir.create('./course3/week4/GDP')}
download.file(GDPUrl,destfile = './course3/week4/GDP/GDP.csv',method = 'curl')
downloaddate<-date()
downloaddate

GDPData<-read.csv('./course3/week4/GDP/GDP.csv')
str(GDPData)
colSums((is.na(GDPData)))
colSums(sapply(GDPData,function(x) x==""))

#header Names
newheader<-c("CountryCode","Ranking","Economy","GDP")
GDPData<- GDPData[,c(1,2,4,5)]
names(GDPData)<-newheader
str(GDPData)
GDPData<-GDPData[4:nrow(GDPData),]
str(GDPData)
GDPData<-GDPData[!(GDPData$CountryCode=="")&!(GDPData$Ranking==""),]
str(GDPData)
colSums(sapply(GDPData,function(x) x==""))
GDPData$GDP<-gsub(",","",GDPData$GDP)
str(GDPData)
`GDPData$GDP<-as.numeric(GDPData$GDP)
sapply(GDPData, function(x) mean(x,na.rm = TRUE))