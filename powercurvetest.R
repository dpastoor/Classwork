#Author: devin.pastoor@gmail.com


library(ggplot2)
library(plyr)
library(reshape2)
library(lattice)
library(grid)

esize<-c(0,25,35,50,55,60,65,70,75,80,100)
power<-data.frame(xaxis = c(0,25,35,50,55,60,65,70,75,80,100),
                  t1=c(0.052,0.377,0.592,0.858,0.915,0.942,0.968,0.990,0.993,0.993,1),
                  s1=c(0.042,0.525,0.787,0.964,0.986,0.994,0.998,0.998,1,1,1),
                  t2=c(0.049,0.535,0.792,0.965,0.978,0.995,0.999,0.999,1,1,1),
                  s2=c(0.040,0.746,0.926,0.997,0.998,1,1,1,1,1,1),
                  t3=c(0.049,0.677,0.927,0.998,1,1,1,1,1,1,1),
                  s3=c(0.049,0.855,0.984,1,1,1,1,1,1,1,1),
                  t4=c(0.057,0.808,0.979,0.999,1,1,1,1,1,1,1),
                  s4=c(0.061,0.951,0.995,1,1,1,1,1,1,1,1))


head(power)
par(mfrow=c(1,1))
matplot(esize,power[,1:8],cex=2.0,cex.lab=1.5,cex.axis=2.0,type="b",lty = c(1,1,2,2,3,3,4,4),
        col=c(2,3,2,3,2,3,2,3),lwd=3.0,xlab="% Effect due to Clobazam",ylab="Power",pch=c(15,17,16,18,15,17,15,17),
        xlim=c(0,100),ylim=c(0,1))
legend(50,0.7, legend=(c("n=20/grp,t-test","n=20/grp,Model","n=30/grp,t-test","n=30/grp,Model","n=45/grp,t-test",
                         "n=45/grp,Model","n=60/grp,t-test","n=60/grp,Model")),lty = c(1,1,2,2,3,3,4,4),col=c(2,3,2,3,2,3,2,3),
       bty="n",cex=1.2,
       lwd=2.5,pch=c(16,17,16,17,16,17,16,17))
abline(h=0.9, lty=5, lwd=3.5)


