
housingUrl<-'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
if(!file.exists('./course3/week4/housing')){dir.create('./course3/week4/housing')}
download.file(housingUrl,destfile = './course3/week4/housing/housing.csv',method = 'curl')
downloaddate<-date()
downloaddate

housingData<-read.csv('./course3/week4/housing/housing.csv')
str(housingData)
newName<-strsplit(names(housingData),split = "wgtp")
newName[123]
