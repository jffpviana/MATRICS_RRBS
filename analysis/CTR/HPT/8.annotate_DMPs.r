library(stringr) #load libraries
library(plyr)
library(tidyverse)
library(ggpubr)
library(viridis)
library(BiSeq)
library(annotatr)



input_dir="/home/vianaj/Documents/MATRICS/analysis/CTR/HPT/analysis/"
output_dir="/home/vianaj/Documents/MATRICS/analysis/CTR/HPT/analysis/"
pheno_path <- "/home/vianaj/Documents/MATRICS/analysis/CTR/phenoCTR.csv"

region="HPT_ID"
cohort="CTR"

genome <- "rn6"
current_anno <- "/home/vianaj/Documents/MATRICS/analysis/CTR/annotations_rn6_130421.RData"


load(file=paste0(input_dir, "BetaReg_results_", cohort, "_", str_replace(region, "_ID", ""), ".RData")) #writing in a new csv#save in object with bonf threshold and original results


load(current_anno)#load annotations object


colnames(betaResults_bonf)[which(colnames(betaResults_bonf)=="pos")]<-"start" # substitute 'pos' by 'start'

betaResults_bonf$end <- betaResults_bonf$start #add a column with the 'end' of the position (same as 'start')

if(length(grep('chr', betaResults_bonf$chr))==0){
  betaResults_bonf$chr <- paste0("chr", betaResults_bonf$chr)#change chromosome from just the number to having 'chr' in from (to match annotation)
  }else{
}
ranges_temp <- makeGRangesFromDataFrame(betaResults_bonf, keep.extra.columns=TRUE) #make GenomicRanges object from results file

betas_bonf_annotated <- annotate_regions(regions = ranges_temp, annotations = annotations, ignore.strand = TRUE, quiet = FALSE)


bonf_anno <-cbind(betas_bonf_annotated@elementMetadata, data.frame(betas_bonf_annotated$annot))

save(betas_bonf_annotated , betaResults, bonferroni, betaResults_bonf, file=paste0(output_dir, "BetaReg_results_anno_", cohort, "_", str_replace(region, "_ID", ""), ".RData")) #writing in a new csv#save in object with bonf threshold and original results

write.csv(bonf_anno, paste0(output_dir, "BetaReg_results_anno_", cohort, "_", str_replace(region, "_ID", ""), ".csv"))
