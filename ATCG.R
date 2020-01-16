#plot ATCG distru
library(ggplot2)
ATCG<-read.csv("/GPFS01/home/wangb/code_fastq_bam/ATCG.output",header = T,sep = "\t", stringsAsFactors = FALSE)
colnames(ATCG) <-c(1:dim(ATCG)[2])
ATCG<-data.frame(t(ATCG))

colnames(ATCG) <-c('C','G','T','A')
ATCG$sampleC <-rep('C',dim(ATCG)[1])
ATCG$sampleG <-rep('G',dim(ATCG)[1])
ATCG$sampleT <-rep('T',dim(ATCG)[1])
ATCG$sampleA <-rep('A',dim(ATCG)[1])

dfC<-data.frame(ATCG$C,ATCG$sampleC)
colnames(dfC) <-c('Content','Base')
dfG<-data.frame(ATCG$G,ATCG$sampleG)
colnames(dfG) <-c('Content','Base')
dfT<-data.frame(ATCG$T,ATCG$sampleT)
colnames(dfT) <-c('Content','Base')
dfA<-data.frame(ATCG$A,ATCG$sampleA)
colnames(dfA) <-c('Content','Base')

df <-rbind(dfC,dfG,dfT,dfA)
df$Site <-rep(1:151,4)

ggplot(df, aes(x=Site, y=Content,group=Base)) + geom_line()
