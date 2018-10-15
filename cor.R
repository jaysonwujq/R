#! /usr/bin/env Rscript

#相关系数分析
WTa <- read.table("WT-a.count",sep="")
WTb <- read.table("WT-b.count",sep="")

#变量重命名：
fix(data)  #修改变量名
#或者 > names(data)[1]<-"geneid"  > names(data)[1：4]<-c("geneid","count","q1","q2")
#rename函数需要plry包

WTa <- read.table("WT-a.count",sep="")
WTb <- read.table("WT-b.count",sep="")
#> mdata<-cbind(WTa,WTb[,2])

WTc <- read.table("WT-c.count",sep="")
ros1a <- read.table("ros1-a",sep="")
ros1b <- read.table("ros1-b",sep="")
ros1c <- read.table("ros1-c",sep="")
ros1d <- read.table("ros1-d",sep="")
ros1e <- read.table("ros1-e",sep="")
ros1f <- read.table("ros1-f",sep="")
mydata <- cbind(ros1a,ros1b[,2],ros1c[,2],ros1d[,2],ros1e[,2],ros1f[,2],WTa[,2],WTb[,2],WTc[,2])
write.table(mdata,file="mydata",row.names=F,col.names=F,quote=F)
names(mydata)[2:10]<-c("ros1-1","ros1-2","ros1-3","ros1-4","ros1-5","ros1-6","WT-1","WT-2","WT-3")

#cor计数
counts <- read.table("mydata",sep="",header=TRUE)
cor_table = cor(counts)
write.table(cor_table,"ros1-wt-gene.cla.data")