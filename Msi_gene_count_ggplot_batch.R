library(patchwork)
library(dplyr)
library(ggplot2)
library(RColorBrewer)

df<-read.csv("Msi_gene_count_ratio_pie_input.csv",header=T,sep=',',stringsAsFactors = FALSE)
#颜色设置
color.get <-function(x){
  res<-c(brewer.pal(9,"Reds")[x],
         brewer.pal(9,"Blues")[x],
         brewer.pal(9,"Greens")[x],
         brewer.pal(9,"Purples")[x],
         brewer.pal(9,"Oranges")[x],
         brewer.pal(9,"PuBuGn")[x])
  return(res)
}
myset <- color.get(7)

plot.g<-function(x,dfz){
  numx<-x
  dfname <-filter(dfz,flag==numx)
  label1 <- paste0(round(dfname$count/sum(dfname$count) * 100, 1), '%')
  p<-ggplot(dfname,aes(x=type,y=count,fill=gene)) +
    geom_bar(stat = 'identity', width = 0.5, position = 'stack')+
	#修改颜色
    scale_fill_manual(values = myset)+
	#转换为极坐标
    coord_polar(theta = 'y', direction = 1)+
	#修改x轴y轴以及图板标题
    labs(x="",y="",title=paste(name1,numx))+
    theme(
      plot.title = element_text(hjust = 0.5,vjust=-5,size = 15),
      axis.text = element_blank(),
      axis.ticks = element_blank(),
      panel.background = element_rect(I(0))
    )+
	#显示百分比标签
    geom_text(aes(x=1.1,label=as.character(label1)),
              position = position_stack(reverse =F,vjust=0.5),size=5)
  return(p)
}

type_list <- c("Germline","Somatic")
for (name1 in type_list){
  dfx <-filter(df,type==name1)
  #这里Germline为2，Somatic为3是因为Germline中样本只有一种三基因组合
  numx<-switch (name1,
                Germline=2,
                Somatic=3
  )
  if(numx==2){
    p1<-plot.g(1,dfx)
    p2<-plot.g(2,dfx)
    pdf(paste0(name1,"_piex.pdf"),width = 10,height = 10) 
    print(wrap_plots(p1, p2))
    dev.off()
  }else{
    p1<-plot.g(1,dfx)
    p2<-plot.g(2,dfx)
    p3<-plot.g(3,dfx)
    pdf(paste0(name1,"_piex.pdf"),width = 10,height = 10) 
    print(wrap_plots(p1, p2, p3,ncol = 2))
    dev.off()
  }
}
