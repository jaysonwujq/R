library(ggplot2)
library(tidyr)
library(RColorBrewer) 

df<-read.csv("bar_input.csv",stringsAsFactors = F)
#生成新列
df$cancer_total <-paste(df$Cancer,df$Sample_num,sep=" n = ")
#设成因子，按照排好序的作图
df$cancer_total <-factor(df$cancer_total,levels = df$cancer_total)

ggplot(df,aes(x=cancer_total,y=MSI_rate,fill="red"))+
  geom_bar(stat="identity",width = 0.8)+
  theme_bw()+
  labs(y="MSI rate",x="")+
  #y轴添加%，限定范围
  scale_y_continuous(labels =function(x){paste0(x, "%")},limits = c(0,50),breaks = seq(0,50,5))+
  #bar上添加标签
  geom_text(aes(label=MSI_num), vjust=-0.3, size=3.5)+
  #调整颜色
  scale_fill_hue(c = 80,l = 40)+
  theme(
    panel.grid =element_blank(),
    legend.position = "none",
    #x轴坐标旋转，移位
    axis.text.x = element_text(angle = 90,hjust = 1,vjust = 0.5,face="bold"),
    axis.ticks.x = element_blank(),
    axis.ticks.y = element_blank()
  )
  
