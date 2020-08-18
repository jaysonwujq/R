library(ggplot2)
library(RColorBrewer)
library(tidyverse)
#读取数据
dftile<-read.table("input_file_sample.csv",header=T,sep=',',stringsAsFactors = FALSE)
#设定顺序
dftile$cancer <-factor(dftile$cancer,levels = c("Colorectal n=224",
                                                "Lung n=59",
                                                "Gastric n=46",
                                                "Endometrial n=19",
                                                "Pancreatic n=7",
                                                "Breast n=7",
                                                "Head n=4",
                                                "Ovarian n=3",
                                                "Hepatocellular n=3",
                                                "Neuroendocrine n=2",
                                                "Cholangiocarcinoma n=2",
                                                "Cervical n=2",
                                                "Esophageal n=1"))
#设置横轴标签，需要将英文转换成中文
SoilSciGuylabs <- c("结直肠癌 n=224",
                    "肺癌 n=59",
                    "胃癌 n=46",
                    "子宫内膜癌 n=19",
                    "胰腺癌 n=7",
                    "乳腺癌 n=7",
                    "头颈癌 n=4",
                    "卵巢癌 n=3",
                    "肝癌 n=3",
                    "神经内分泌肿瘤 n=2",
                    "胆管癌 n=2",
                    "宫颈癌 n=2",
                    "食管癌 n=1")

ggplot(dftile,aes(x=cancer,y=gene,fill=ratio))+
  geom_tile(colour="white",size=1.75, stat="identity") + 
  #设置颜色
  scale_fill_gradient(low ="#FEE0D2",high ="red")+
  #添加每个tile对应数值标签
  geom_text(aes(label = ratio), color="black")+
  #添加坐标轴标签
  scale_x_discrete(labels= SoilSciGuylabs)+
  theme(
    axis.text.x = element_text(angle = 45,hjust = 1,size = 10),
    axis.title=element_blank()
  )
