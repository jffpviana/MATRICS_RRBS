library(stringr) #load libraries
library(plyr)
library(data.table)
library(BiSeq)

input_dir <- "/rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTR/HC/methylation/"
output_dir <- "/rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTR/HC/analysis/"
plots_dir <- "/rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTR/HC/QC/plots/"
region <- "HC_ID"
cohort <- "CTR"


load(file=paste0(output_dir, "biseq_rawmeth_obj_", cohort, "_", str_replace(region, "_ID", ""))) #load BiSeq object

pdf(paste0(plots_dir, "coverage_boxplots", str_replace(region, "_ID", ""),".pdf")) #start pdf file
covBoxplots(data_meth, col = "blue", las = 2)
dev.off()
