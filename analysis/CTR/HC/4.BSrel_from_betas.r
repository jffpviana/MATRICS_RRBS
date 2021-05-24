library(stringr) #load libraries
library(plyr)
library(data.table)
library(BiSeq)


input_dir="/home/vianaj/Documents/MATRICS/analysis/CTR/HC/analysis/"
output_dir="/home/vianaj/Documents/MATRICS/analysis/CTR/HC/analysis/"
pheno_path <- "/home/vianaj/Documents/MATRICS/analysis/CTR/phenoCTR.csv"

region="HC_ID"
cohort="CTR"


meth_betas <- read.csv(paste0(input_dir, "complete_betas_", cohort, "_", str_replace(region, "_ID", "")), row.names=1) #save complete betas

pheno <- read.csv(pheno_path, stringsAsFactors=FALSE) #load phenotype file


identical(pheno[, region], colnames(meth_betas)[1:nrow(pheno)]) # check the samples are in the same order

rowRanges <- makeGRangesFromDataFrame(meth_betas[,-(1:(nrow(pheno)))])

betas_all_obj<- BSrel(colData=pheno, methLevel=as.matrix(meth_betas[,1:nrow(pheno)]), rowRanges=rowRanges) # create a BSrel object from all the betas

colData(betas_all_obj)$Group<-factor(colData(betas_all_obj)$Group, levels=c('low', 'inter', 'high'))

save(betas_all_obj, file=paste0(output_dir, "betas_all_obj_", cohort, "_", str_replace(region, "_ID", ""))) #save BiSeq object
