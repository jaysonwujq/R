#! /usr/bin/env Rscript

library(edgeR)
##跟DESeq2一样，导入数据，预处理（用了cpm函数）
exprSet<- read.table(file = "mouse_all_count.txt", sep = "\t", header = TRUE, row.names = 1, stringsAsFactors = FALSE)
group_list <- factor(c(rep("control",2),rep("Akap95",2)))
exprSet <- exprSet[rowSums(cpm(exprSet) > 1) >= 2,]
 
##设置分组信息，并做TMM标准化
exprSet <- DGEList(counts = exprSet, group = group_list)
exprSet <- calcNormFactors(exprSet)
 
##使用qCML（quantile-adjusted conditional maximum likelihood）估计离散度（只针对单因素实验设计）
exprSet <- estimateCommonDisp(exprSet)
exprSet <- estimateTagwiseDisp(exprSet)
 
##寻找差异gene(这里的exactTest函数还是基于qCML并且只针对单因素实验设计)，然后按照阈值进行筛选即可
et <- exactTest(exprSet)
tTag <- topTags(et, n=nrow(exprSet))
diff_gene_edgeR <- subset(tTag$table, FDR < 0.05 & (logFC > 1 | logFC < -1))
diff_gene_edgeR <- row.names(diff_gene_edgeR)
write.csv(tTag$table,file = "control_vs_Akap95_edgeR.csv")