library(ggplot2)

df<-read.csv("Msi_gene_count_pie_all_harm_input.csv",header=T,sep=',',stringsAsFactors = FALSE)

name1 <- "Somatic"
df$type[df$type=="Mutant"] <-name1
gdf <-filter(df,type==name1)
gdf[3,2] <-"Other"
#设置颜色
color.get <-function(x){
  res<-c(brewer.pal(9,"Reds")[x],
         brewer.pal(9,"Blues")[x],
         brewer.pal(9,"Greens")[x],
         brewer.pal(9,"Purples")[x],
         brewer.pal(9,"Oranges")[x],
         brewer.pal(9,"PuBuGn")[x])
  return(res)
}
myset <- color.get(8)


numx<-"1"
dfname <-filter(gdf,flag==numx)
dfname$gene<-factor(dfname$gene,levels = dfname$gene)
#标签
label1 <- paste0(round(dfname$count/sum(dfname$count) * 100, 1), '%')
p1<-ggplot(dfname,aes(x=type,y=count,fill=gene)) +
  geom_bar(stat = 'identity', width = 0.5, position = 'stack')+
  #scale_fill_brewer(palette ="",direction = 1)+
  #scale_fill_hue(name="",l = 50)+
  #添加颜色
  scale_fill_manual(values = c("#006D2C","#A63603","#54278F","#08519C","#A50F15"))+
  coord_polar(theta = 'y', direction = 1)+
  labs(x="",y="",title=paste(name1,numx))+
  theme(
    plot.title = element_text(hjust = 0.5,vjust=-5,size = 15),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    panel.background = element_rect(I(0))
  )+
  #设置标签，标签重叠的情况下，可以考虑调整x和size,或者指定分块的顺序
  geom_text(aes(x=1.15,label=paste0(as.character(label1),"(",count,")") ),
            position = position_stack(reverse =F,vjust=0.5),size=5,colour = "white")
  #geom_text_repel( aes( label = paste0(as.character(label1),"(",count,")"),x=xpos,y=ypos) , 
  #                 color="white" , size=5)

ggsave(p1,filename = paste0(name1,numx,"_pienewh.pdf"),height = 7,width = 7)
