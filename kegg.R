#! /usr/bin/env Rscript

library(clusterProfiler)
library(org.Mm.eg.db)

##ID转化
ids <- bitr(diff_gene_ENSEMBL, fromType = "ENSEMBL", toType = "ENTREZID", OrgDb = "org.Mm.eg.db")
##会提示百分之几比对失败，

kk <- enrichKEGG(gene = ids[,2], organism = "mmu", keyType = "kegg",
          pvalueCutoff = 0.05, pAdjustMethod = "BH", qvalueCutoff = 0.1)
##查看富集结果数据
enrich_kegg <- as.data.frame(kk)
##作图
dotplot(kk)