getwd()
util<-read.csv("P3-Machine-Utilization.csv")
#?as.POSIXct
util$posixtime<-as.POSIXct(util$Timestamp,format="%d/%m/%Y %H:%M")
util$Percent.util<-1-util$Percent.Idle
rl1<-util[util$Machine=="RL1",]
rl2<-util[util$Machine=="RL2",]
head(rl1,15)
rl1<-rl1[,c(4,2,5,1,3)]
head(rl1,15)
rl1$Timestamp<-NULL
rl1$Percent.Idle<-NULL
unknown_hours<-rl1[is.na(rl1$Percent.util),]
head(rl1,15)
m1<-max(rl1$Percent.util,na.rm = TRUE)
m1
maxutil<-rl1[which(rl1$Percent.util==m1),]
maxutil
m2<-min(rl1$Percent.util,na.rm = TRUE)
m2
minutil<-rl1[which(rl1$Percent.util==m2),]
minutil
vec<-rl1$Percent.util<0.9
vec
util_check<-nrow(rl1[vec,])>1
util_check
library(ggplot2)
p<-ggplot(data=util,aes(x=posixtime,y=Percent.util,colour=Machine))
q<-p+geom_line(size=1.0)+facet_grid(Machine~.,scales="free")+geom_hline(yintercept=0.9,size=1)
q<-q+ylab("Percentage Utilization")+xlab("Time")+ggtitle("Plot for Machine Utilization")
plot<-q   
listRl1<-list("DATA"=rl1,"MACHINE"="RL1","UNKNOWN HOURS"=unknown_hours,"MAX UTIL"=maxutil,"MIN UTIL"=minutil,"DROP BELOW 90%"=util_check,"PLOT"=plot)
listRl1


