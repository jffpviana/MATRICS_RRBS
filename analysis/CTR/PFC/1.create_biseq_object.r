library(stringr) #load libraries
library(plyr)
library(data.table)
library(BiSeq)

input_dir <- "/home/vianaj/Documents/MATRICS/analysis/CTR/PFC/methylation/"
output_dir <- "/home/vianaj/Documents/MATRICS/analysis/CTR/PFC/analysis/"
pheno_path <- "/home/vianaj/Documents/MATRICS/analysis/CTR/phenoCTR.csv"
region <- "PFC_ID"
cohort <- "CTR"

list_datasets <- list() # creates a list
list_cov <- dir(path=input_dir, pattern ="*.cov") # creates the list of all .cov files in the directory

print(list_cov) #print the list of .cov files so can check on log files

pheno <- read.csv(pheno_path, stringsAsFactors=FALSE) #load phenotype file

data_meth <- readBismark(files = paste0(input_dir, "/", list_cov), colData = pheno) #create BiSeq object with all samples


colData(data_meth)$Group <- factor(colData(data_meth)$Group, levels=c("low", "inter", "high"))

save(data_meth, file=paste0(output_dir, "biseq_rawmeth_obj_", cohort, "_", str_replace(region, "_ID", ""))) #save BiSeq object
