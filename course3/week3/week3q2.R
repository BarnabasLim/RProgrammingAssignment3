install.packages("jpeg")
library(jpeg)
jpegURL<-"http://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
if (!file.exists("./imgData")){dir.create("./imgData")}
download.file(jpegURL,destfile = "./imgData/imgData.jpg",method = 'curl')
jpegData<-readJPEG("./imgData/imgData.jpg", native = TRUE)
head(jpegData,n=2)
x<-quantile(jpegData,probs = c(0.3,0.8))
x