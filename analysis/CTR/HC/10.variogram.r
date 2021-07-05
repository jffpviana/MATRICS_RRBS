library(stringr) #load libraries
library(plyr)
library(data.table)
library(BiSeq)
library(parallel)



input_dir="/home/vianaj/Documents/MATRICS/analysis/CTR/HC/analysis/"
output_dir="/home/vianaj/Documents/MATRICS/analysis/CTR/HC/analysis/"
pheno_path <- "/home/vianaj/Documents/MATRICS/analysis/CTR/phenoCTR.csv"

region="HC_ID"
cohort="CTR"

read.csv(paste0(output_dir, "Betareg_NULL_", cohort, "_", str_replace(region, "_ID", ""), ".csv"), stringsAsFactors=FALSE)-> betaResultsNull # load the null results

#separate the null results into comparison
betaResultsNull->null.pval1
colnames(null.pval1)[grep("p.val1", colnames(null.pval1))]<-"p.val" #change column name to p.val so we can run makeVriogram()

betaResultsNull->null.pval2
colnames(null.pval2)[grep("p.val2", colnames(null.pval2))]<-"p.val" #change column name to p.val so we can run makeVriogram()

#make variograms

vario1 <- makeVariogram(null.pval1)
vario2 <- makeVariogram(null.pval2)
