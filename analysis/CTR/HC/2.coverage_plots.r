library(stringr) #load libraries
library(plyr)
library(data.table)
library(BiSeq)

input_dir <- "/rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTR/HC/methylation/"
output_dir <- "/rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTR/HC/analysis/"
region <- "HC_ID"
cohort <- "CTR"


load(file=paste0(output_dir, "biseq_rawmeth_obj_", cohort, "_", str_replace(region, "_ID", ""))) #load BiSeq object
