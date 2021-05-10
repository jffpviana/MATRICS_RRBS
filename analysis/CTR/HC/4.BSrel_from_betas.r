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


identical(pheno[, region], colnames(meth_betas)[1:nrow(pheno)])






BSrel(metadata=pheno, meth_betas)



betaResults <- betaRegression(formula = ~group,
link = "probit",
object = meth_betas,
type = "BR")
