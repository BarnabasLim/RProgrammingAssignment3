if(!file.exists('./housingData')){dir.create('./housingData')}
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl,destfile = './housingData/housing.csv',method = 'curl')
housingData<-read.csv('./housingData/housing.csv')
#households on greater than 10 acres(ACR=3) who sold more than $10,000(AGS=6) worth of agriculture products
agricultureLogical<-housingData$ACR==3 & housingData$AGS==6

housingDataFiltered<-housingData[which(agricultureLogical),]
housingDataFiltered