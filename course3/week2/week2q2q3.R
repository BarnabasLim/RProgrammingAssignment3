install.packages("sqldf")
library(sqldf)
acs<-read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv")
head(acs)

#qn 2
sqldf("select * from acs where AGEP<50")
sqldf("select pwgtp1 from acs where AGEP<50")

#qn 3
sqldf("select distinct AGEP from acs")