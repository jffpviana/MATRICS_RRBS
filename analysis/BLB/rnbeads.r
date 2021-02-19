library(RnBeads)
library("RnBeads.mm10")
library(stringr)
library(dplyr)

cohort <- "BLB"
region <- "ACC"
input_dir  <- "/rds/projects/v/vianaj-genomics-brain-development/MATRICS/BLB/ACC/methylation"
output_dir <- "/rds/projects/v/vianaj-genomics-brain-development/MATRICS/BLB/ACC/analysis/"
reports_dir <- "/rds/projects/v/vianaj-genomics-brain-development/MATRICS/BLB/ACC/analysis/reports"
sample_annotation <-"/rds/projects/v/vianaj-genomics-brain-development/MATRICS/BLB/ACC/BLBACC_pheno.csv"
genome <- "mm10"
analysis_name <- paste0(cohort, "_", region)


load(file=paste0(output_dir, cohort, region, "_rnb_set.RData"))

# sample annotation
pheno <- pheno(rnb_set)
pheno
# CpG methylation
mm <- meth(rnb_set, "sites")
dim(mm)
head(mm)
#coverage
cc <- covg(rnb_set)
dim(cc)
head(cc)


### Quality Control
#Generate a sample statistics table containing CpG coverage information and statistics on the number of covered CpGs for each region type.

sumTab <- rnb.sample.summary.table(rnb_set)
str(sumTab)



pdf(paste0(output_dir, cohort, region, "_cov_CpGs.pdf"))
rnb.plot.num.sites.covg(rnb_set,   addSampleNames =TRUE)
dev.off()
