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

# extract CpG positions of CpGs that survived clustering
coordinates_pred <- as.data.frame(predictedMeth@rowRanges)
pos_pred <- paste(coordinates_pred$seqnames, ":", coordinates_pred$start, sep="")

#get custer.id from the smoothed object
cluster_id <- as.matrix(rowData(predictedMeth)$cluster.id)
rownames(cluster_id)<-pos_pred

betaResults <- read.csv(file=paste0(input_dir, "DMPs_", cohort, "_", str_replace(region, "_ID", ""), ".csv")) # read in DMP analysis results

rownames(betaResults) <- paste0(betaResults$chr, ":", betaResults$pos)

betaResults[pos_pred,] -> betaResults_less #extract DMP results for only the CpG sites that survived the original clustering

#check cluster.id and DMP analysis results dataframe have the same order
identical(rownames(cluster_id), rownames(betaResults_less))

#join cluster_id to results and change column name
cbind(betaResults_less, cluster_id)-> betaResults_less

colnames(betaResults_less)[grep("cluster_id", colnames(betaResults_less))]<-"cluster.id"

write.csv(betaResults_less, file=paste0(output_dir, "DMPs_less_smooth_", cohort, "_", str_replace(region, "_ID", ""), ".csv"))
