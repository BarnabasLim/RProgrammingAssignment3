GDPUrl<-'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
if(!file.exists('./GDPData')){dir.create('./GDPData')}
download.file(GDPUrl,destfile = './GDPData/GDPData.csv',method = 'curl')
downloaddate<-date()
downloaddate
GDPData<-read.csv('./GDPData/GDPData.csv',skip = 4)

eduUrl<-'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv'
if(!file.exists('./EDUData')){dir.create('./EDUData')}
download.file(eduUrl,destfile = './EDUData/EDUData.csv',method = 'curl')
downloaddate<-date()
downloaddate
eduData<-read.csv('./EDUData/EDUData.csv')

str(GDPData)
head(GDPData,6)
str(eduData)

#qn 3 counting matches in short names
#GDPData<-GDPData[!(GDPData$X=='')&!(GDPData$X.1==''),]
#sum(GDPData$X %in% eduData$CountryCode)

#GDPData[order(GDPData$X.1,decreasing = TRUE),][13,]
#qn 3 identifying 13 row descending order
#library(plyr)
#arrange(GDPData,desc(X.1))[13,]
#GDPData[13,]

#qn 4
names(GDPData)[1] <- "CountryCode"
names(GDPData)[2] <- "ranking"
names(GDPData)[3] <- "Economy"
GDPDataNew<-GDPData[,c("CountryCode","ranking","Economy")]

CombinedData<-merge(eduData,GDPDataNew,by="CountryCode",all=TRUE)                             #use Merge
CombinedData<-CombinedData[,c("CountryCode","Income.Group","Economy","ranking")]                        #extract relavant column
CombinedData<-CombinedData[!(CombinedData$CountryCode=="")&!(CombinedData$Income.Group==""),] #remove empty columns
CombinedData$ranking<-as.numeric(CombinedData$ranking)                                        #convert ranking to numeric

str(CombinedData)
head(CombinedData,10)

#ddply(CombinedData,.(Income.Group),summarize,sum=ave(ranking,FUN = mean))
rankSplit<-split(CombinedData$ranking,CombinedData$Income.Group)
rankSplit
sapply(rankSplit, function(x) mean(x, na.rm=TRUE))

#qn 5
#install.packages("Hmisc")
library(Hmisc)
CombinedData$rankGrp=cut2(CombinedData$ranking,g=5)
str(CombinedData)
table(CombinedData$Income.Group,CombinedData$rankGrp)
#qn3
arrange(CombinedData,desc(ranking))[13,]