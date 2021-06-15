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

load(file=paste0(input_dir, "biseq_predictedmeth_obj_", cohort, "_", str_replace(region, "_ID", ""))) #load clustered/smooth BiSeq objects


sample(colData(predictedMeth)$Group)->shuffle #shuffle group factor

betaResults <- betaRegression3Groups(formula = ~shuffle, link = "probit", object = predictedMeth, type = "BR", mc.cores=10)

write.csv(betaResults, file=paste0(output_dir, "Betareg_NULL_", cohort, "_", str_replace(region, "_ID", ""), ".csv"))
