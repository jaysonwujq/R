#differential expression analysis

library(DESeq)
counts <- read.table("a1-6.gene.m2w.count",sep="\t",header=TRUE)
counts = cbind (counts[,1:2],counts[,4:6])
head(counts)
               muta1 muta2 wild1 wild2 wild3
LOC_Os01g01010   655   743   909   910   750
LOC_Os01g01019   315   310   358   510   284
LOC_Os01g01030   118   121   101   101    92
LOC_Os01g01040   773   799   846   893   825
LOC_Os01g01050   302   316   281   316   274
LOC_Os01g01060  1777  1833  1561  1777  1795
conditions=c(rep("muta", 2),rep("wild", 3))
cds <- newCountDataSet(counts, conditions)
cds <- estimateSizeFactors(cds)
sizeFactors(cds)
    muta1     muta2     wild1     wild2     wild3 
0.8890513 0.9143368 1.0712609 1.1769994 0.9924176 
cds <- estimateDispersions(cds, method = "per-condition", sharingMode="maximum")
dispTable(cds)
  muta   wild 
"muta" "wild" 
et <- nbinomTest(cds, "muta", "wild")
write.table(et,file = "a1-6.de.gene.DESeq.out",sep = "\t")