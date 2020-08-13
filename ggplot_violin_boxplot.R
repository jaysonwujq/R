##画小提琴图和箱线图
library(ggplot2)

inputx <-read.csv("FFPE_new.csv",header = T,sep = ",", stringsAsFactors = FALSE)
inputx$sid <-as.factor(inputx$sid)

#函数用来提取一组数据的25%，50%，75%的值
median.quantile<-function(x){
  out<-quantile(x,probs=c(0.25,0.5,0.75))
  return(out)
}

ggplot(input, aes(x=ID,y=AF,color = sid)) +
  #画小提琴
  geom_violin(aes(fill = AF))+               
  #画箱线，设置异常值点的颜色和大小
  geom_boxplot(outlier.colour = 'black',outlier.size = 1,width = 0.1)+
  #显示出扰动点
  geom_jitter(size = 1)+
  #设置轴名和画布名
  labs(x="",title = 'FFPE')+
  #分面
  facet_grid(.~sid)+
  #设置y轴的刻度与刻度标签
  scale_y_continuous(breaks=seq(0,100,10),labels = c(seq(0,100,10)))+
  #根据外函数显示标签，这里格式化显示25%，50%，75%的值，并设置颜色，位置与大小
  stat_summary(geom = "text",fun = median.quantile,aes(label=paste0(sprintf("%1.2f",..y..),"%")),color="black",position = position_nudge(x=0.1),size=4)+
  theme(
    axis.text.x=element_blank(),                #取消x轴名
    panel.grid.major = element_blank(),         #取消刻度对应的网格线
    plot.title = element_text(hjust = 0.5),     #设置画布名位置
    panel.grid.minor = element_blank(),         #取消刻度之间的网格线
    axis.ticks.x=element_blank()                #取消x轴 刻度线
  )
