library(stringr) #load libraries
library(plyr)
library(data.table)
library(BiSeq)
library(parallel)


input_dir="/home/vianaj/Documents/MATRICS/analysis/CTR/HC/analysis/"
output_dir="/home/vianaj/Documents/MATRICS/analysis/CTR/HC/analysis/"
pheno_path <- "/home/vianaj/Documents/MATRICS/analysis/CTR/phenoCTR.csv"

region<-"HC_ID"
cohort<-"CTR"

load(paste0(input_dir, "Variograms_", cohort, "_", str_replace(region, "_ID", ""), ".RData")) # load the R object with the two varigrams


#plot the two variograms
pdf(paste0(input_dir, "Variograms_", cohort, "_", str_replace(region, "_ID", ""), ".pdf"))

plot(vario1$variogram$v, main="low vs inter")
plot(vario2$variogram$v, main="low vs inter")

dev.off()
