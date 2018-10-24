#! /usr/bin/env Rscript

library(clusterProfiler)
library(org.Mm.eg.db)
library(topGO)
library(Rgraphviz)
##去除ID的版本号
diff_gene_ENSEMBL <- unlist(lapply(diff_gene_edgeR, function(x){strsplit(x, "\\.")[[1]][1]}))
##GOid mapping + GO富集
ego <- enrichGO(gene = diff_gene_ENSEMBL, OrgDb = org.Mm.eg.db,
     keytype = "ENSEMBL", ont = "BP", pAdjustMethod = "BH",
     pvalueCutoff = 0.01, qvalueCutoff = 0.05)
##查看富集结果数据
enrich_go <- as.data.frame(ego)
##作图
barplot(ego, showCategory=10)
dotplot(ego)
enrichMap(ego)
plotGOgraph(ego)