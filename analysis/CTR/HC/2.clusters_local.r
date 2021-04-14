if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("BiSeq")

library(stringr) #load libraries
library(plyr)
library(data.table)
library(BiSeq)

input_dir <- "/home/vianaj/Documents/MATRICS/analysis/CTR/HC/analysis/"
output_dir <- "/home/vianaj/Documents/MATRICS/analysis/CTR/HC/analysis/"
plots_dir <- "/rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTR/HC/QC/plots/"
region <- "HC_ID"
cohort <- "CTR"


load(file=paste0(output_dir, "biseq_rawmeth_obj_", cohort, "_", str_replace(region, "_ID", ""))) #load BiSeq object

dim(data_meth)
# 3322735      24


rrbs.clust.unlim <- clusterSites(object = data_meth,
                                  groups = colData(data_meth)$Group,
                                  perc.samples = 0.5,
                                  min.sites = 5,
                                  max.dist = 500)  #searches for agglomerations of CpG sites acrossall samples








data_reduced <- filterBySharedRegions(object=data_meth, groups=colData(data_meth)$Group, perc.samples=0.5, minCov=10) #This method determines the regions which are covered in a given fraction of samples and reduces the object to these regions.

dim(data_reduced)
# 1047652      24

nrow(data_meth) - nrow(data_reduced)
# 2275083
