#The CTR HC samples were named by the sequencing service with different names than the standard CTR...HC. The phenotype file phenoCTRnaive.csv has these IDs stored as HC_ID_alt.
#This script renames the .cov files generated by Bismark for further analysis.

setwd("/rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTR/HC/methylation") # change directory to where methylation files are

list_cov <- dir(pattern ="*.cov") # creates the list of all .cov files in the directory


pheno <- read.csv("/rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTR/phenoCTR.csv", stringsAsFactors=FALSE) #load phenotype file

#rename each file, output the sample name and file name to make sure they match
for(i in 3:nrow(pheno)){
  index_file<-grep(paste0(pheno$HC_ID_alt[i], "_"), list_cov)
  print(paste("In phenotype file: ", pheno$HC_ID_alt[i]))
  print(paste("Original file name: ", list_cov[index_file]))
  file.rename(list_cov[index_file], paste0(pheno$HC_ID[i], ".cov"))
}