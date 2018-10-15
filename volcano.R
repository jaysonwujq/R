#! /usr/bin/env Rscript

# Clear workspace
rm(list = ls())
# Load packages
library(dplyr)
library(ggplot2)
library(ggrepel)
# Read data from the local
path<-setwd("D:/Test/R/R_paint")
results = read.table("volcano_test-1.txt", header=TRUE)
results = mutate(results, sig=ifelse(results$padj<0.05, "p_value<0.05", "Not sig"))
png("volcano.png",width=600,height=800)
p = ggplot(results, aes(log2FC, -log10(pval))) +
  geom_point(aes(col=sig)) +
  scale_color_manual(values=c("blue", "red"))+
  labs(title = "volcano plot")+
  theme(plot.title = element_text(size = 16, hjust = 0.5, face = "bold"))
p
#p+geom_text(data=filter(results, padj<0.05), aes(label=Gene))
p+geom_text_repel(data=filter(results, padj<0.05), aes(label=gene))
dev.off()