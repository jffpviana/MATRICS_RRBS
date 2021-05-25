library(stringr) #load libraries
library(plyr)
library(data.table)
library(BiSeq)
library(parallel)

input_dir="/home/vianaj/Documents/MATRICS/analysis/CTR/PFC/analysis/"
output_dir="/home/vianaj/Documents/MATRICS/analysis/CTR/PFC/analysis/"
pheno_path <- "/home/vianaj/Documents/MATRICS/analysis/CTR/phenoCTR.csv"

region="PFC_ID"
cohort="CTR"


betaResults <- read.csv(file=paste0(input_dir, "DMPs_", cohort, "_", str_replace(region, "_ID", ""), ".csv")) # read in DMP analysis results

bonferroni <- 0.05/nrow(betaResults)

bonferroni

betaResults_bonf <- betaResults[which(betaResults$p.val1 <= bonferroni | betaResults$p.val2 <= bonferroni),]
