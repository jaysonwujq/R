etrddCG<-read.table("rdd-et-methy-CG",head = F,sep="")
etrddCHG<-read.table("rdd-et-methy-CHG",head = F,sep="")
etrddCHH<-read.table("rdd-et-methy-CHH",head = F,sep="")

etrddCG<-etrddCG[,-c(2,3)]
etrddCHG<-etrddCHG[,-c(2,3)]
etrddCHH<-etrddCHH[,-c(2,3)]

etrdd <- merge(etrddCG,etrddCHG,by="V1")
etrdd <- merge(etrdd,etrddCHH,by="V1")

names(etrdd)[1:7]<-c("id","CG","rddCG","CHG","rddCHG","CHH","rddCHH")

etrdd <- etrdd[,c("id","CG","CHG","CHH","rddCG","rddCHG","rddCHH")]

rnames<-etrdd$id
rownames(etrdd)<-rnames

etrdd<-etrdd[,-1]
etrdd<-etrdd*100

et500rddCG<-read.table("rdd-500-et-methy-CG",head = F,sep="")
et500rddCHG<-read.table("rdd-500-et-methy-CHG",head = F,sep="")
et500rddCHH<-read.table("rdd-500-et-methy-CHH",head = F,sep="")

et500rddCG<-et500rddCG[,-c(2,3)]
et500rddCHG<-et500rddCHG[,-c(2,3)]
et500rddCHH<-et500rddCHH[,-c(2,3)]

et500rdd <- merge(et500rddCG,et500rddCHG,by="V1")
et500rdd <- merge(et500rdd,et500rddCHH,by="V1")

names(et500rdd)[1:7]<-c("id","500CG","500rddCG","500CHG","500rddCHG","500CHH","500rddCHH")

et500rdd <- et500rdd[,c("id","500CG","500CHG","500CHH","500rddCG","500rddCHG","500rddCHH")]

rnames<-et500rdd$id
rownames(et500rdd)<-rnames

et500rdd<-et500rdd[,-1]
et500rdd<-et500rdd*100

et200rddCG<-read.table("rdd-200-et-methy-CG",head = F,sep="")
et200rddCHG<-read.table("rdd-200-et-methy-CHG",head = F,sep="")
et200rddCHH<-read.table("rdd-200-et-methy-CHH",head = F,sep="")

et200rddCG<-et200rddCG[,-c(2,3)]
et200rddCHG<-et200rddCHG[,-c(2,3)]
et200rddCHH<-et200rddCHH[,-c(2,3)]

et200rdd <- merge(et200rddCG,et200rddCHG,by="V1")
et200rdd <- merge(et200rdd,et200rddCHH,by="V1")

names(et200rdd)[1:7]<-c("id","200CG","200rddCG","200CHG","200rddCHG","200CHH","200rddCHH")

et200rdd <- et200rdd[,c("id","200CG","200CHG","200CHH","200rddCG","200rddCHG","200rddCHH")]

rnames<-et200rdd$id
rownames(et200rdd)<-rnames

et200rdd<-et200rdd[,-1]
et200rdd<-et200rdd*100

etrdd3 <- cbind(et200rdd,et500rdd,etrdd)
etrdd3 <- etrdd3[,c("200CG","200CHG","200CHH","500CG","500CHG","500CHH","CG","CHG","CHH","200rddCG","200rddCHG","200rddCHH","500rddCG","500rddCHG","500rddCHH","rddCG","rddCHG","rddCHH")]
write.table(etrdd3,file = "et-rdd-mC-methy",sep = "\t",quote =F)