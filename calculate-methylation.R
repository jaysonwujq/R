setwd("F:/A-WB/data-analysis-RNA-Methy/whole-genome-methylation/500-pro")


ros12CG<-read.table("ros1-wt-200-methy-level-CG",head = F,sep="")


rdd2CG<-read.table("rdd-wt-200-methy-level-CG.fa",head = F,sep="")


dme2CG<-read.table("dme-wt-200-methy-level-CG.fa",head = F,sep="")


rddgbCHH<-read.table("rdd-wt-methy-level-CHH",head = TRUE,sep="")
head(rddgbCHH)
mean(rddgbCHH$rdd)

#计算分组中的个数
length(which(dme2CG$V4==0))
length(which(dme2CG$V4>0 & dme2CG$V4 <0.01))
length(which(dme2CG$V4>=0.01 & dme2CG$V4 <0.1))
length(which(dme2CG$V4>=0.1))

#计算各个分组中平均数
ros15CG<-read.table("ros1-wt-500-methy-level-CG",head = F,sep="")
mean(ros15CG[ros15CG$V4==0,]$V4)
mean(ros15CG[ros15CG$V4>0 & ros15CG$V4 <0.01,]$V4)
mean(ros15CG[ros15CG$V4>=0.01 & ros15CG$V4 <0.1,]$V4)
mean(ros15CG[ros15CG$V4>=0.1,]$V4)

mean(ros15CG[ros15CG$V5==0,]$V5)
mean(ros15CG[ros15CG$V5>0 & ros15CG$V5 <0.01,]$V5)
mean(ros15CG[ros15CG$V5>=0.01 & ros15CG$V5 <0.1,]$V5)
mean(ros15CG[ros15CG$V5>=0.1,]$V5)

rdd5CG<-read.table("rdd-wt-500-methy-level-CG",head = F,sep="")
mean(rdd5CG[rdd5CG$V4==0,]$V4)
mean(rdd5CG[rdd5CG$V4>0 & rdd5CG$V4 <0.01,]$V4)
mean(rdd5CG[rdd5CG$V4>=0.01 & rdd5CG$V4 <0.1,]$V4)
mean(rdd5CG[rdd5CG$V4>=0.1,]$V4)

mean(rdd5CG[rdd5CG$V5==0,]$V5)
mean(rdd5CG[rdd5CG$V5>0 & rdd5CG$V5 <0.01,]$V5)
mean(rdd5CG[rdd5CG$V5>=0.01 & rdd5CG$V5 <0.1,]$V5)
mean(rdd5CG[rdd5CG$V5>=0.1,]$V5)

dme5CG<-read.table("dme-wt-500-methy-level-CG",head = F,sep="")
mean(dme5CG[dme5CG$V4==0,]$V4)
mean(dme5CG[dme5CG$V4>0 & dme5CG$V4 <0.01,]$V4)
mean(dme5CG[dme5CG$V4>=0.01 & dme5CG$V4 <0.1,]$V4)
mean(dme5CG[dme5CG$V4>=0.1,]$V4)

mean(dme5CG[dme5CG$V5==0,]$V5)
mean(dme5CG[dme5CG$V5>0 & dme5CG$V5 <0.01,]$V5)
mean(dme5CG[dme2CG$V5>=0.01 & dme5CG$V5 <0.1,]$V5)
mean(dme5CG[dme2CG$V5>=0.1,]$V5)

#计算野生型的CG CHG CHH平均甲基化水平；
ttwtCHG<-cbind(ros1gbCHG$wt,dmegbCHG$wt,rddgbCHG$wt)
cor(ttwtCHG)
ttwtCHGmean <- rowMeans(ttwtCHG)
mean(ttwtCHGmean)