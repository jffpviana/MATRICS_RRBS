library(stringr) #load libraries
library(plyr)
library(data.table)
library(BiSeq)
library(parallel)

input_dir="/home/vianaj/Documents/MATRICS/analysis/CTR/HC/analysis/"
output_dir="/home/vianaj/Documents/MATRICS/analysis/CTR/HC/analysis/"
pheno_path <- "/home/vianaj/Documents/MATRICS/analysis/CTR/phenoCTR.csv"

region="HC_ID"
cohort="CTR"


betaResults <- read.csv(file=paste0(input_dir, "DMPs_", cohort, "_", str_replace(region, "_ID", ""), ".csv")) # read in DMP analysis results

bonferroni <- 0.05/nrow(betaResults) #calculate Bonferroni threshold

bonferroni
#4.772577e-08

betaResults_bonf <- betaResults[which(betaResults$p.val1 <= bonferroni | betaResults$p.val2 <= bonferroni),] #extract results that are under the Bonferroni threshold in either p-value

write.csv(betaResults_bonf, file=paste0(output_dir, "Bonferroni_DMPs_", cohort, "_", str_replace(region, "_ID", ""), ".csv")) #writing in a new csv

save(betaResults, bonferroni, betaResults_bonf, file=paste0(output_dir, "BetaReg_results_", cohort, "_", str_replace(region, "_ID", ""), ".RData")) #writing in a new csv#save in object with bonf threshold and original results
