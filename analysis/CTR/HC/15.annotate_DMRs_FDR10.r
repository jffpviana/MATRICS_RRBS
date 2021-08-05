library(stringr) #load libraries
library(plyr)
library(tidyverse)
library(ggpubr)
library(viridis)
library(BiSeq)
library(annotatr)

input_dir="/home/vianaj/Documents/MATRICS/analysis/CTR/HC/analysis/"
output_dir="/home/vianaj/Documents/MATRICS/analysis/CTR/HC/analysis/"
pheno_path <- "/home/vianaj/Documents/MATRICS/analysis/CTR/phenoCTR.csv"
function_path <- "/home/vianaj/Documents/MATRICS/MATRICS_repo/analysis/change_chr.r"

region="HC_ID"
cohort="CTR"

genome <- "rn6"
current_anno <- "/home/vianaj/Documents/MATRICS/analysis/CTR/annotations_rn6_130421.RData"

source(function_path) #load external function to change the chr names in the object

#load DMR objects
load(file=paste0(output_dir, "DMRs_low_vs_inter_FDR10_", cohort, "_", str_replace(region, "_ID", ""), ".RData"))

load(file=paste0(output_dir, "DMRs_low_vs_high_FDR10_", cohort, "_", str_replace(region, "_ID", ""), ".RData"))


load(current_anno)#load annotations object

#substitute chr names to match the annotation object, separate function change_chr to do that
DMRs1chr<-change_chr(DMRs1)
DMRs2chr<-change_chr(DMRs2)

#substitute the scaffold names
DMRs1chrsc<-change_scaffold(DMRs1chr)
DMRs2chrsc<-change_scaffold(DMRs2chr)

#get all the annotations available to loop through them
colname_anno <- colnames(annotations@elementMetadata)

DMRs1chrsc->DMRs1anno
for(i in colname_anno){
    DMRs1anno <-  annotateGRanges(object = DMRs1anno, regions = annotations, name = i, regionInfo = i)
}

DMRs2chrsc->DMRs2anno
for(i in colname_anno){
    DMRs2anno <-  annotateGRanges(object = DMRs2anno, regions = annotations, name = i, regionInfo = i)
}


save(DMRs1anno, DMRs2anno, file=paste0(output_dir, "DMR_FDR10_anno_", cohort, "_", str_replace(region, "_ID", ""), ".RData"))
