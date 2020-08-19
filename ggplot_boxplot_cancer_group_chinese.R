library(showtext)
showtext_auto()

df <-read.csv("cancer_index_all_tmb_t (4).txt",header = T,sep = ",", encoding = "UTF-8",stringsAsFactors = FALSE)
df$status <-factor(df$status,levels = c("MSI","MSS","POLE"))
df$cancer <-factor(df$cancer,levels=c("结直肠癌",
                                      "肺癌",
                                      "胃癌",
                                      "子宫内膜癌",
                                      "胰腺癌",
                                      "乳腺癌"))
cname <-c("结直肠癌",
          "肺癌",
          "胃癌",
          "子宫内膜癌",
          "胰腺癌",
          "乳腺癌")

p<-ggplot(df, aes(x=status,y=value)) +
  geom_jitter(aes(color=status,alpha=0.05),size=1)+
  geom_boxplot(width=0.5,outlier.colour = NA,alpha=0.01)+
  labs(x="",y="TMB",color="")+
  facet_grid(.~cancer)+
  #geom_hline(aes(yintercept=0.584),linetype="dashed",size=1)+
  #geom_text(aes(0,0.584,label="0.584"),vjust=-1,hjust=-0.2)+
  #labs(y="mising score",x="",fill="Type")+
  #scale_y_continuous(labels =function(x){paste0(x*100, "%")})+
  scale_color_manual(values=c("#EF3B2C","#6BAED6","#238B45"))+
  scale_alpha_continuous(guide=FALSE)+
  #scale_fill_manual(values = c("#993404","#084081"))+
  theme(
    axis.ticks.x = element_blank(),
    legend.key = element_rect(fill = "white"),
    axis.text = element_text(face = "bold"),
    axis.text.x = element_text(size=10)
  )

ggsave(p,filename = "Plot.pdf",height = 6,width = 10)
