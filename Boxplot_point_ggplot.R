df <-read.csv("MSI_boxplot.csv",header = T,sep = "\t", stringsAsFactors = FALSE)
df$state <-factor(df$state,levels = c("MSI","MSS"))

ggplot(df, aes(x=state,y=msing_score,fill = state)) +
  #outlier.colour 这里去掉离群点
  geom_boxplot(width=0.5,outlier.colour = NA)+
  #散点扰动
  geom_jitter(aes(color=state))+
  #添加水平线
  geom_hline(aes(yintercept=0.584),linetype="dashed",size=1)+
  #添加水平线的标签
  geom_text(aes(0,0.584,label="58.4%"),vjust=-1,hjust=-0.2)+
  
  labs(y="mising score",x="",fill="Type")+
  #设置Y轴标签
  scale_y_continuous(labels =function(x){paste0(x*100, "%")})+
  #设置color的颜色
  scale_color_manual(guide=FALSE,values=c("#EF3B2C","#4292C6"))+
  #设置fill的颜色
  scale_fill_manual(values = c("#CB181D","#2171B5"))+
  
  theme(
    axis.ticks.x = element_blank(),
    #设置图例背景色
    legend.key = element_rect(fill = "white"),
    #轴标签加粗
    axis.text = element_text(face = "bold")
  )
