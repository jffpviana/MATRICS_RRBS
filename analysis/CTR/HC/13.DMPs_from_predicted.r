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

#to do the DMR analysis we need the DMP results but only from the CpG sites that survived the early step of clustering the CpGs.
#In this script I use the predictedMeth object (CpGs that survived clustering) to see what CpGs are

load(file=paste0(input_dir, "biseq_predictedmeth_obj_", cohort, "_", str_replace(region, "_ID", "")))  #load clustered/smooth BiSeq objects

# extract CpG positions of CpGs thst urvived clustering
coordinates_pred <- as.data.frame(predictedMeth@rowRanges)
pos_pred <- paste(coordinates_pred$seqnames, ":", coordinates_pred$start, sep="")


betaResults <- read.csv(file=paste0(input_dir, "DMPs_", cohort, "_", str_replace(region, "_ID", ""), ".csv")) # read in DMP analysis results

rownames(betaResults) <- paste0(betaResults$chr, ":", betaResults$pos)

betaResults[pos_pred,] -> betaResults_less


vario.aux <- makeVariogram(predictedMeth, make.variogram=FALSE)




#replace the pValsList object (test results of the resampled data - null hypothesis) by the test results of interest (for group effect)
