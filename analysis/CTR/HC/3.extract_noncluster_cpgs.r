library(stringr) #load libraries
library(plyr)
library(data.table)
library(BiSeq)


input_dir="/home/vianaj/Documents/MATRICS/analysis/CTR/HC/analysis/"
output_dir="/home/vianaj/Documents/MATRICS/analysis/CTR/HC/analysis/"
region="HC_ID"
cohort="CTR"

load(file=paste0(output_dir, "biseq_rawmeth_obj_", cohort, "_", str_replace(region, "_ID", ""))) #load raw BiSeq object

load(file=paste0(output_dir, "biseq_predictedmeth_obj_", cohort, "_", str_replace(region, "_ID", ""))) #load clustered/smooth BiSeq objects


rrbs.reduced <- filterBySharedRegions(object=data_meth, groups=colData(data_meth)$Group, perc.samples=0.5, minCov=10)
