#Qn 1
#Step 1: Download data
#Step 1.1: create folder for each data-> if folder does not exist, create else do nothing 
fileUrl1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"

if(!file.exists("./course3/week1")){
  dir.create("./course3/week1")
}
download.file(fileUrl1, destfile = "./course3/week1/q1.csv")

dateDownloaded<-date()
dateDownloaded

#Step 2: read the csv file using read.csv not additional parameters required 
quiz1Data<-read.csv("./course3/week1/q1.csv")
print(head(quiz1Data))

#Using the code book we identify that that val column is the column for Property value
#recall: dataframe basics $ and [[]] both return a vector
print(head(quiz1Data$VAL))

print(sum(quiz1Data$VAL>=24&!is.na(quiz1Data$VAL)))
sum(quiz1Data$VAL == 24, na.rm = TRUE)


#Qn3
#Step 1: Download data
#Step 1.1: create folder for each data-> if folder does not exist, create else do nothing 
fileURL2<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
library(xlsx)

if(!file.exists("./course3/week1")){
  dir.create("./course3/week1")
}

download.file(fileURL2,destfile ="./course3/week1/q3.xlsx",method = "curl" )
dateDownloaded<-date()
dateDownloaded

#Step 2: read the csv file using read.csv not additional parameters required 
#quiz1Data2<-read.xlsx("./course3/week1/q3.xlsx" ,sheetIndex=1,header=TRUE)
col <- 7:15
row <- 18:23
dat1<-read.xlsx("./course3/week1/q3.xlsx",sheetIndex = 1,colIndex = col,rowIndex = row)
print(head(dat1))
print(dat1$Zip*dat1$Ext, na.rm=TRUE)


#Qn4
#Step 1: Download data
#Step 1.1: create folder for each data-> if folder does not exist, create else do nothing 
fileURL3<-"http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
library(XML)

if(!file.exists("./course3/week1")){
  dir.create("./course3/week1")
}

doc<-xmlTreeParse(fileURL3,useInternal=TRUE)
rootNode<-xmlRoot(doc)
zip_code<-xpathSApply(rootNode,"//zipcode",xmlValue)
sum(zip_code=="21231")
print(xmlName(rootNode))
