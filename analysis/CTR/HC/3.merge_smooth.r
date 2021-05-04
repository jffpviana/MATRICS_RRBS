library(stringr) #load libraries
library(plyr)
library(data.table)
library(BiSeq)

input_dir <- "/rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTR/HC/analysis/"
output_dir <- "/rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTR/HC/analysis/"
plots_dir <- "/rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTR/HC/QC/plots/"
region <- "HC_ID"
cohort <- "CTR"


load(file=paste0(input_dir, "biseq_predictedmeth_obj_", cohort, "_", str_replace(region, "_ID", ""))) #load BiSeq object

dim(predictedMeth)
#2606331      24




round(perc.samples*ncol(object))









data_reduced <- filterBySharedRegions(object=data_meth, groups=colData(data_meth)$Group, perc.samples=0.5, minCov=10) #This method determines the regions which are covered in a given fraction of samples and reduces the object to these regions.

dim(data_reduced)
# 1047652      24

nrow(data_meth) - nrow(data_reduced)
# 2275083
