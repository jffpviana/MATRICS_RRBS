library(stringr) #load libraries
library(plyr)
library(data.table)
library(BiSeq)
library(parallel)


input_dir <- "/home/vianaj/Documents/MATRICS/analysis/CTR/HC/analysis/"
output_dir <- "/home/vianaj/Documents/MATRICS/analysis/CTR/HC/analysis/"
pheno_path <- "/home/vianaj/Documents/MATRICS/analysis/CTR/phenoCTR.csv"
function_path <- "/home/vianaj/Documents/MATRICS/MATRICS_repo/analysis/betaRegression3Groups.r"

source(function_path)
numcores <- detectCores()

region="HC_ID"
cohort="CTR"

load(paste0(input_dir, "betas_all_obj_", cohort, "_", str_replace(region, "_ID", ""))) #save BiSeq object

group <- colData(betas_all_obj)$Group

betaResults <- betaRegression3Groups(formula = ~group, link = "probit", object = betas_all_obj, type = "BR", mc.cores=numcores)
