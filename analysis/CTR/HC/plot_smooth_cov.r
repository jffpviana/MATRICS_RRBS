library(stringr) #load libraries
library(plyr)
library(data.table)
library(BiSeq)

input_dir <- "/rds/projects/v/vianaj-genomics-brain-development/MATRICS/C
TR/HC/analysis/"
output_dir <- "/rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTR/HC/analysis/"
plots_dir <- "/rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTR/HC/analysis/plots/"
region <- "HC_ID"
cohort <- "CTR"


load(file=paste0(input_dir, "biseq_predictedmeth_obj_", cohort, "_", str_replace(region, "_ID", ""))) #load BiSeq object

dim(predictedMeth)
#2606331      24


pdf(paste0(plots_dir, "coverage_after_cluster_", cohort, "_", str_replace(region, "_ID", "")))

covBoxplots(rrbs.clust.lim, col = "blue", las = 2)

dev.off()
