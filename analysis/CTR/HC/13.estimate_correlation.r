library(stringr) #load libraries
library(plyr)
library(data.table)
library(BiSeq)
library(parallel)


input_dir="/home/vianaj/Documents/MATRICS/analysis/CTR/HC/analysis/"
output_dir="/home/vianaj/Documents/MATRICS/analysis/CTR/HC/analysis/"
pheno_path <- "/home/vianaj/Documents/MATRICS/analysis/CTR/phenoCTR.csv"

region<-"HC_ID"
cohort<-"CTR"

load(paste0(output_dir, "Variograms_smooth_", cohort, "_", str_replace(region, "_ID", ""), ".RData")) #load the R object with the two variograms smoothed

load(file=paste0(input_dir, "biseq_predictedmeth_obj_", cohort, "_", str_replace(region, "_ID", "")))  #load clustered/smooth BiSeq objects

vario.aux <- makeVariogram(predictedMeth, make.variogram=FALSE)




#replace the pValsList object (test results of the resampled data - null hypothesis) by the test results of interest (for group effect)
