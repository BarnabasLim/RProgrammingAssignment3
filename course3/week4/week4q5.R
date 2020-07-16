install.packages("quantmod")
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
str(sampleTimes)

timeDT <- data.table::data.table(timeCol = sampleTimes)

# How many values were collected in 2012? 
timeDT[(timeCol >= "2012-01-01") & (timeCol) < "2013-01-01", .N ]
# Answer: 
# 250

# How many values were collected on Mondays in 2012?
timeDT[((timeCol >= "2012-01-01") & (timeCol < "2013-01-01")) & (weekdays(timeCol) == "Monday"), .N ]
# Answer:
# 47