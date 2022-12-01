library(sqldf)
library(DPpack)
library(ggplot2)
library(tidyverse)
instdata1<-read.csv(file = 'E:/Tufts/CS151/Project/project/US_Accidents_Dec21_updated.csv')
data1<-as.data.frame(data1)
head(data1)

moststate<-sqldf("select state,count(*) from data1 GROUP BY state ORDER BY COUNT(*) DESC LIMIT 1")
epilson <- c(0.0025, 0.005, 0.0075, 0.01, 0.0125)

result<-matrix(nrow = 10,ncol = 5)
runningtime<-array(dim = 5)

moststate_count<-moststate$`count(*)`
noiseresult<-matrix(nrow = 5,ncol =10)
for (x in 1:5) {
  start_time <- Sys.time() 
  for (y in 1:10) {
    noiseresult[x,y]=LaplaceMechanism(moststate$`count(*)`, epilson[x], 1)
  }
  end_time <- Sys.time()
  runningtime[x] <-end_time-start_time
}
print(noiseresult)
print(runningtime)
runningtime<-as.data.frame(runningtime)
ggplot(data = runningtime, aes(x = epilson, y = runningtime)) +
  geom_line()



noiseresult<-as.data.frame(noiseresult)
row.names(noiseresult)<-epilson

error<-abs(noiseresult-moststate_count)
error<-rowMeans(error)
errormean<-as.data.frame(error)
ggplot(data = errormean, aes(x = epilson, y = error)) +
  geom_line()



sqldf("SELECT Weather_Condition, Count(*) FROM data1 GROUP BY Weather_Condition ORDER BY COUNT(*) DESC LIMIT 1")

sqldf("SELECT Street, COUNT(*) FROM data1 WHERE Street = ‘MA’ GROUP BY Street ORDER BY COUNT(*) DESC LIMIT 10 ")




