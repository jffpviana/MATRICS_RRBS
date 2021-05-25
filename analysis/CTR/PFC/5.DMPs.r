library(stringr) #load libraries
library(plyr)
library(data.table)
library(BiSeq)
library(parallel)

args <- commandArgs(TRUE) # option to read arguments from bash script
args[1]->input_dir
args[2]->output_dir
args[3]->pheno_path
args[4]->function_path
args[5]->region
args[6]->cohort

source(function_path)
numcores <- detectCores()

load(paste0(input_dir, "betas_all_obj_", cohort, "_", str_replace(region, "_ID", ""))) #save BiSeq object

group <- colData(betas_all_obj)$Group

betaResults <- betaRegression3Groups(formula = ~group, link = "probit", object = betas_all_obj, type = "BR", mc.cores=numcores)

write.csv(betaResults, file=paste0(output_dir, "DMPs_", cohort, "_", str_replace(region, "_ID", ""), ".csv"))
