library(stringr) #load libraries
library(plyr)
library(data.table)
library(BiSeq)
library(parallel)


args <- commandArgs(TRUE) # option to read arguments from bash script
args[1]->input_dir
args[2]->output_dir
args[3]->pheno_path
args[4]->region
args[5]->cohort


read.csv(paste0(input_dir, "Betareg_NULL_", cohort, "_", str_replace(region, "_ID", ""), ".csv"), stringsAsFactors=FALSE)-> betaResultsNull # load the null results

#separate the null results into comparison
betaResultsNull->null.pval1
colnames(null.pval1)[grep("p.val1", colnames(null.pval1))]<-"p.val" #change column name to p.val so we can run makeVriogram()

betaResultsNull->null.pval2
colnames(null.pval2)[grep("p.val2", colnames(null.pval2))]<-"p.val" #change column name to p.val so we can run makeVriogram()

#make variograms

vario1 <- makeVariogram(null.pval1)
vario2 <- makeVariogram(null.pval2)

save(vario1, vario2, file=paste0(output_dir, "Variograms_", cohort, "_", str_replace(region, "_ID", ""), ".RData"))
