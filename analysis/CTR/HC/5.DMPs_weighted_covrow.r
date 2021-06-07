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


source(function_path) #load the beta regression function

numcores <- detectCores() #detect number of cores available for parallel


load(paste0(input_dir, "betas_all_obj_", cohort, "_", str_replace(region, "_ID", ""))) #load BiSeq object

load(file=paste0(input_dir, "biseq_rawmeth_obj_", cohort, "_", str_replace(region, "_ID", ""))) #load raw BiSeq object

group <- colData(betas_all_obj)$Group #create variable with groups to test

coverage <- totalReads(data_meth) #extract coverage and use chromosome:position as rownames
rownames(coverage) <- paste0(as.character(data.frame(rowRanges(data_meth))$seqnames), ":", as.character(data.frame(rowRanges(data_meth))$start))

row_max <- rowMax(coverage) #calculate the maximum coverage of each CpG (row)

weight_cov <- apply(coverage, 2, function(x) (x*10)/row_max)

betaResults <- betaRegressionWeights(formula = ~group, link = "probit", object = betas_all_obj, weights=weight_cov,  type = "BR", mc.cores=numcores) #perform weithed beta regression

write.csv(betaResults, file=paste0(output_dir, "DMPs_weighted_row_", cohort, "_", str_replace(region, "_ID", ""), ".csv")) #write out results
