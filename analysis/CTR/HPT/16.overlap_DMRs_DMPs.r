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
function_path <- "/home/vianaj/Documents/MATRICS/MATRICS_repo/analysis/change_chr.r"

region="HPT_ID"
cohort="CTR"

#load DMPs
load(file=paste0(output_dir, "BetaReg_results_anno_", cohort, "_", str_replace(region, "_ID", ""), ".RData"))


#load DMRs 10% FDR
load(file=paste0(output_dir, "DMR_FDR10_anno_", cohort, "_", str_replace(region, "_ID", ""), ".RData"))

#rename the DMRs object so we can load the DMRs 5% FDR object (they were saved with the same names)
DMRs1anno -> DMRs1anno10
DMRs2anno -> DMRs2anno10
rm(list=c('DMRs1anno', 'DMRs2anno'))

#load DMRs 5% FDR
load(file=paste0(output_dir, "DMR_FDR5_anno_", cohort, "_", str_replace(region, "_ID", ""), ".RData"))


#rename the DMRs 5%FDR object
DMRs1anno -> DMRs1anno5
DMRs2anno -> DMRs2anno5
rm(list=c('DMRs1anno', 'DMRs2anno'))


#find the overlaps between the DMPs and DMRs
overlap1_10<- findOverlaps(betas_bonf_annotated, DMRs1anno10)

overlap2_10<- findOverlaps(betas_bonf_annotated, DMRs2anno10)

overlap1_5<- findOverlaps(betas_bonf_annotated, DMRs1anno5)

overlap2_5<- findOverlaps(betas_bonf_annotated, DMRs2anno5)


#create empty columns in the DMPs object to add DMR location (if it exists)

betas_bonf_annotated@elementMetadata$annot$DMRs10_low_vs_inter<-NA
betas_bonf_annotated@elementMetadata$annot$DMRs10_low_vs_high<-NA

betas_bonf_annotated@elementMetadata$annot$DMRs5_low_vs_inter<-NA
betas_bonf_annotated@elementMetadata$annot$DMRs5_low_vs_high<-NA

#Add DMRs positions to DMP objects
#FDR 10 low vs inter
betas_bonf_annotated@elementMetadata$annot$DMRs10_low_vs_inter[overlap1_10@from]<-paste0(as.vector(seqnames(DMRs1anno10[overlap1_10@to,])), ":", ranges(DMRs1anno10[overlap1_10@to,]))

#FDR 10 low vs high
betas_bonf_annotated@elementMetadata$annot$DMRs10_low_vs_high[overlap2_10@from]<-paste0(as.vector(seqnames(DMRs2anno10[overlap2_10@to,])), ":", ranges(DMRs2anno10[overlap2_10@to,]))

#FDR 5 low vs inter
betas_bonf_annotated@elementMetadata$annot$DMRs5_low_vs_inter[overlap1_5@from]<-paste0(as.vector(seqnames(DMRs1anno5[overlap1_5@to,])), ":", ranges(DMRs1anno5[overlap1_5@to,]))

#FDR 5 low vs high
betas_bonf_annotated@elementMetadata$annot$DMRs5_low_vs_high[overlap2_5@from]<-paste0(as.vector(seqnames(DMRs2anno5[overlap2_5@to,])), ":", ranges(DMRs2anno5[overlap2_5@to,]))


#load DMPs
save(betas_bonf_annotated, file=paste0(output_dir, "BetaReg_results_anno_DMRoverlap_", cohort, "_", str_replace(region, "_ID", ""), ".RData"))
