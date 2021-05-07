library(stringr) #load libraries
library(plyr)
library(data.table)
library(BiSeq)

input_dir <- "/home/vianaj/Documents/MATRICS/analysis/CTR/HPT/methylation/"
output_dir <- "/home/vianaj/Documents/MATRICS/analysis/CTR/HPT/analysis/"
pheno_path <- "/home/vianaj/Documents/MATRICS/analysis/CTR/phenoCTR.csv"
region <- "HPT_ID"
cohort <- "CTR"

list_datasets <- list() # creates a list
list_cov <- dir(path=input_dir, pattern ="*.cov") # creates the list of all .cov files in the directory

print(list_cov) #print the list of .cov files so can check on log files

pheno <- read.csv(pheno_path, stringsAsFactors=FALSE) #load phenotype file



if(identical(list_cov, paste0(pheno[, region], ".cov"))){

  data_meth <- readBismark(files = paste0(input_dir, "/", list_cov), colData = pheno) #create BiSeq object with all samples

  colnames(data_meth)<-pheno[, region]

  colData(data_meth)$Group <- factor(colData(data_meth)$Group, levels=c("low", "inter", "high"))

}else{
  print("files are not the same order as pheno, please re-order")
}


save(data_meth, file=paste0(output_dir, "biseq_rawmeth_obj_", cohort, "_", str_replace(region, "_ID", ""))) #save BiSeq object
