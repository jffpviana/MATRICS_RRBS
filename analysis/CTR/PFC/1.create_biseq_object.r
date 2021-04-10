library(stringr) #load libraries
library(plyr)
library(data.table)
library(BiSeq)

input_dir <- "/rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTR/HPT/methylation/"
output_dir <- "/rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTR/HPT/analysis/"
region <- "HPT_ID"
cohort <- "CTR"

list_datasets <- list() # creates a list
list_cov <- dir(path=input_dir, pattern ="*.cov") # creates the list of all .cov files in the directory

print(list_cov) #print the list of .cov files so can check on log files

pheno <- read.csv("/rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTR/phenoCTR.csv", stringsAsFactors=FALSE) #load phenotype file

data_meth <- readBismark(files = paste0(input_dir, "/", list_cov), colData = pheno[ , region]) #create BiSeq object with all samples

save(data_meth, file=paste0(output_dir, "biseq_rawmeth_obj_", cohort, "_", str_replace(region, "_ID", ""))) #save BiSeq object
