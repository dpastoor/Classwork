#Author: Devin Pastoor
#email: devin.pastoor@gmail.com
# testing various ggplot settings

setwd("C:/Users/Devin/Documents/Classwork/ggplot_experiments")
library(ggplot2)
library(plyr)
library(reshape2)
library(lattice)
library(grid)

#xaxis data
esize<-c(0,25,35,50,55,60,65,70,75,80,100)

#power data
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

##########Mathangi's Old Code for plotting power curves
par(mfrow=c(1,1))
matplot(esize,power[,1:8],cex=2.0,cex.lab=1.5,cex.axis=2.0,type="b",lty = c(1,1,2,2,3,3,4,4),
        col=c(2,3,2,3,2,3,2,3),lwd=3.0,xlab="% Effect due to Clobazam",ylab="Power",pch=c(15,17,16,18,15,17,15,17),
        xlim=c(0,100),ylim=c(0,1))
legend(50,0.7, legend=(c("n=20/grp,t-test","n=20/grp,Model","n=30/grp,t-test","n=30/grp,Model","n=45/grp,t-test",
                         "n=45/grp,Model","n=60/grp,t-test","n=60/grp,Model")),lty = c(1,1,2,2,3,3,4,4),col=c(2,3,2,3,2,3,2,3),
       bty="n",cex=1.2,
       lwd=2.5,pch=c(16,17,16,17,16,17,16,17))
abline(h=0.9, lty=5, lwd=3.5)


#add x-axis data to dataframe
power[0, ] <- esize





y <- melt(power, id="xaxis", variable_name = "label")

#vector to distinguish whether T-test (T) or model (S)
ts <- rep(c("T", "S", "T", "S", "T", "S", "T", "S"), each = 11)

#vector to distinguish # per group
### 1: n = 20/group
### 2: n = 30/group
### 3: n = 45/group
### 4: n = 60/group
grp <- rep(c(seq(1,4)), each = 22)
y[,4] <- as.factor(ts)
y[,5] <- as.factor(grp)
head(y)

#basic qplot to see overall shape
qplot(xaxis, value, data = y, color = variable) + geom_line()

## Plot of power curves 
plot <- ggplot(data = y, aes(x = xaxis, y = value, color = V5)) +
  geom_point(aes(shape = V4), size = 5) +
  geom_line(aes(group = variable, linetype = V4), size = 1.2) +
  labs(color = "# per group", shape = "Method", linetype = "Method") +    #if don't set linetype to same name will separate to 3 legends
  geom_hline(aes(yintercept = 0.9), linetype="dashed", size = 1.05) +
  scale_color_discrete(name = "# per group",
                       labels = c("20/group", "30/group", "45/group", "60/group")) +
  scale_linetype_discrete(name = "Method", labels = c("t-test", "Model")) +
  scale_shape_discrete(name = "Method", labels = c("t-test", "Model")) +
  scale_x_continuous(name = "% Effect due to Clobazam") +
  scale_y_continuous(name = "Power") +
  #to edit out grid lines
  #theme(panel.grid.minor=element_blank(), panel.grid.major=element_blank()) +
  theme(axis.title.x = element_text(size=20)) +
  theme(axis.title.y = element_text(size=20)) +
  theme(axis.text.x = element_text(size=20)) +
  theme(axis.text.y = element_text(size=20)) +
  theme(legend.title = element_text(size = 16)) +
  theme(legend.text = element_text(size = 14)) +
  theme(legend.justification=c(1,0), legend.position=c(1,0)) + 
  theme(legend.key.width= unit(2, "lines")) #part of grid

plot
# messing with shortening
ggplot(data = y, aes(xaxis, value, color = V5, linetype = V4)) +
  geom_point(aes(shape = V4), size = 4) + geom_line(size = 1.2) + 
  labs(color = "# per group", linetype = "test2", shape = "test")