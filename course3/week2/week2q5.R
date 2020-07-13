fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
SST <- read.fwf(fileUrl, skip=4, widths=c(12, 7, 4, 9, 4, 9, 4, 9, 4))
raw<-read.fwf(fileUrl, skip=4,widths=c(1, 9, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3) )
head(raw)
head(SST)
sum(SST[,4])