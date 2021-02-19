library(RnBeads)
library("RnBeads.mm10")


#set cohort and region specific options
cohort <- "BLB"
region <- "ACC"
input_dir <- "/rds/projects/v/vianaj-genomics-brain-development/MATRICS/BLB/ACC/methylation"
output_dir <- "/rds/projects/v/vianaj-genomics-brain-development/MATRICS/BLB/ACC/analysis/"
sample_annotation <- "/rds/projects/v/vianaj-genomics-brain-development/MATRICS/BLB/ACC/BLBACC_pheno.csv"
analysis_name <- paste0(cohort, "_", region)

#set RnBeads options, such as type of data file and genome assembly
rnb.options(import.bed.style = "bismarkCov", assembly = "mm10", analysis.name = analysis_name)

data_source <- c(input_dir, sample_annotation) # source of data and phenotype (sample annotation file)

#inport .cov files and generate RnBeads object
rnb_set <- rnb.execute.import(data.source=data_source, data.type="bs.bed.dir")

#save RnBeads object
save.rnb.set(rnb_set, path=paste0(output_dir, "rnb.set"), archive=FALSE)
