.libPaths(c("/GPFS01/softwares/R3.3.3lib", .libPaths()))
args <- commandArgs(TRUE)
if(length(args) != 3){
  print('methylKit_call.R group1_sid,group2_sid,group', quote=F)
  quit()
}

group1_sids<-args[1]
group2_sids<-args[2]
group <- args[3]

library(bsseq)
g1<-unlist(strsplit(group1_sids,split=','))
g1_size=length(g1)
g2<-unlist(strsplit(group2_sids,split=','))
g2_size=length(g2)
ids=c(g1,g2)

for (i in 1:22){
  chrom<-paste0('chr',i)
  Type <-c(rep(c("Case"),g1_size),rep(c("Ctrl"),g2_size))
  Pair <-c(paste("Pair",1:g1_size,sep=""),paste("Pair",1:g2_size,sep=""))
  
  fs=paste0("/GPFS07/InternalResearch/Mercury/201908_WGBS_merge/cg_report/",ids)
  suffix=paste(chrom,"CG_report.txt",sep = '.')
  f.list=paste(fs,suffix,sep = '.')
  
  bsseq <-  read.bismark(files=f.list, sampleNames=ids, rmZeroCov = TRUE, strandCollapse = TRUE, 
                         fileType = "cytosineReport" , mc.cores = 30,verbose = TRUE)
  bsseq[[1]] <- Type
  bsseq[[2]] <- Pair
  pData(bsseq) <- setNames(pData(bsseq),c("Type","Pair"))
  
  bsseq.smoothed <-BSmooth(BSseq = bsseq,ns=50,h=1000,keep.se = FALSE,mc.cores=30,mc.preschedule = TRUE,verbose = TRUE)
  bsseq.smooth <- updateObject(bsseq.smoothed)
  BS.cov <- getCoverage(bsseq.smooth)
  keepLoci.ex <- which(rowSums(BS.cov[, bsseq$Type=="Case"] >= 2) >= 2 & rowSums(BS.cov[, bsseq$Type=="Ctrl"] >= 2) >= 2)
  BSdata.smoothed.filt <- bsseq.smooth[keepLoci.ex, ]
  BSdata.stat <- BSmooth.tstat(BSdata.smoothed.filt,
                               group1 = g1,
                               group2 = g2,
                               estimate.var = "group2",
                               local.correct = TRUE,
                               verbose = TRUE) 
  
  dmrs0 <- dmrFinder(BSdata.stat, cutoff = NULL,qcutoff = c(0.05,0.95),maxGap = 500,stat = "tstat.corrected",verbose = TRUE)
  dmrs <- subset(dmrs0, n >= 3 & abs(meanDiff) >= 0.1)
  write.table(dmrs,file = paste0('DMR/CHR/',group,'.',chrom,'.tsv'),sep = '\t',row.names = F,col.names = T,quote = F)
  
}
