#create connection 
con<-url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlcode<-readLines(con)
#close connection
close(con)
linetoRead<-c(10,20,30,100)

#print out the number of characters in the desired lines
for (i in seq_len(length(linetoRead))){
  print(nchar(htmlcode[linetoRead[i]]))
  }