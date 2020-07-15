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

#####################################################################################################################
#Recomended Answer

#qn3 alternate
GDPData1<-read.csv('./GDPData/GDPData.csv',skip = 5,header=FALSE)
eduData1<-read.csv('./EDUData/EDUData.csv')

#Step 1: data exploration
str(GDPData1)
str(eduData1)

names(GDPData1)
names(eduData1)

#results: 
#1.GDPData1$V1 correspond to eduData1$CountryCode
#2.GDPData1$V2 is the ranking
#3.GDPData1$V4 is the country names but may not correspond to eduData1$Long.Name
#4.GDPData1$V5 is the actual GDP

#Step 2: identifing NA and missing data
sapply(GDPData1,function(x) x=="")
#Checking NA
colSums(is.na(GDPData1))
colSums(is.na(eduData1))
#results: 
#1.GDPData1$V3, $V7, $V8, $V9, $V10 only consist of NAs

#Checking ""
colSums(sapply(GDPData1,function(x) x==""),na.rm = TRUE)
colSums(sapply(eduData1,function(x) x==""),na.rm = TRUE)

#results: 
#1.GDPData1$V1 (CountryCode):98 observation has no country code
#2.GDPData1$V2 (Ranking)    :132 observation has no ranking
#3.GDPData1$V4 (Economy)    :98 observation has economy names
#4.GDPData1$V5 (GDP)        :99 observation has no gdp

colSums(is.na(GDPData1) | sapply(GDPData1,function(x) x==""))
colSums(is.na(eduData1) | sapply(eduData1,function(x) x==""))

#Actions:
#1.rename GDPData1 data frame to $V1, $V2, $V3, $V5 to CountryCode, Ranking, Economy, GDP respectively
#2.remove empty rows from GDPData1


#Selecting only the columns containing non-NA values  
FinalGDP.Data <- GDPData1[,c(1,2,4,5)]
head(FinalGDP.Data)
newheader<-c("CountryCode","Ranking","Economy","GDP")
names(FinalGDP.Data)<-newheader
FinalGDP.Data$Ranking<-as.numeric(FinalGDP.Data$Ranking)
colSums(sapply(FinalGDP.Data,function(x) x==""),na.rm = TRUE)
#removing empty rows in CountryCode
FinalGDP.Data<-FinalGDP.Data[!(FinalGDP.Data$CountryCode=="")&!(FinalGDP.Data$Ranking==""),]

#Checking ""
str(FinalGDP.Data)
colSums(sapply(FinalGDP.Data,function(x) x==""),na.rm = TRUE)

#qn3
sum(eduData1$CountryCode %in% FinalGDP.Data$CountryCode)
mergedDF<-merge(eduData1,FinalGDP.Data,by="CountryCode",all=FALSE)
nrow(mergedDF)
library(plyr)
arrange(mergedDF,desc(Ranking))[13,'Economy']


#qn4 using groupby recomended
library(dplyr)

groupedDF <- group_by(mergedDF, Income.Group)
avgRankings<- dplyr::summarize(groupedDF, agvGDP = mean(Ranking))
filter(avgRankings, Income.Group %in% c('High income: nonOECD', 'High income: OECD'))

#qn4 using slit-apply-combine
rankSplit<-split(mergedDF$Ranking,mergedDF$Income.Group)
sapply(rankSplit, function(x) mean(x, na.rm=TRUE))

#qn5
mergedDF$rankGrp=cut2(mergedDF$Ranking,g=5)
str(mergedDF)
table(mergedDF$Income.Group,mergedDF$rankGrp)