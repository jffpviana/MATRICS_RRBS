library(stringr) #load libraries
library(plyr)
library(data.table)
library(BiSeq)
library(ggplot2)
library(gridExtra)

input_dir="/home/vianaj/Documents/MATRICS/analysis/CTR/HC/analysis/"
output_dir="/home/vianaj/Documents/MATRICS/analysis/CTR/HC/analysis/plots/"
region="HC_ID"
cohort="CTR"


meth_betas <- read.csv(paste0(input_dir, "complete_betas_", cohort, "_", str_replace(region, "_ID", "")), row.names=1) #save complete betas


vec <- sample(rownames(na.omit(meth_betas)), 10)


dat <- as.data.frame(t(meth_betas[vec,]))

pdf(paste0(output_dir, "beta_distr_examples_", cohort, "_", str_replace(region, "_ID", ""), ".pdf"))
par(mfrow = c(5,2))
for(i in 1:ncol(dat)){
  plot(density(dat[,i]), main=NA)
}
dev.off()
