library(stringr) #load libraries
library(plyr)
library(data.table)
library(BiSeq)
library(parallel)
library(hrbrthemes)
library(tidyverse)
library(ggpubr)
library(viridis)
extrafont::loadfonts()

#set variables
input_dir="/home/vianaj/Documents/MATRICS/analysis/CTR/HC/analysis/"
output_dir="/home/vianaj/Documents/MATRICS/analysis/CTR/HC/analysis/"
plots_dir="/home/vianaj/Documents/MATRICS/analysis/CTR/HC/analysis/plots/"
pheno_path <- "/home/vianaj/Documents/MATRICS/analysis/CTR/phenoCTR.csv"

region="HC_ID"
cohort="CTR"

function_path="/home/vianaj/Documents/MATRICS/MATRICS_repo/analysis/CTR/HC/compare_DMPs_functions.r"

source(function_path)

betaResults <- read.csv(file=paste0(input_dir, "DMPs_", cohort, "_", str_replace(region, "_ID", ""), ".csv")) #load results of beta regression without weights

betaResults_r <- read.csv(file=paste0(input_dir, "DMPs_weighted_row_", cohort, "_", str_replace(region, "_ID", ""), ".csv")) #load results of beta regression weighted globally

bonf <- 0.05/nrow(betaResults) #calculate bonferroni threshold

#remove rows ith NA results
na.omit(betaResults)->betaResults
na.omit(betaResults_r)->betaResults_r

#add chr + position as row names
paste0(betaResults$chr, ":", betaResults$pos)-> rownames(betaResults)
paste0(betaResults_r$chr, ":", betaResults_r$pos)-> rownames(betaResults_r)

##the following functions functions are written in a separate script (compare_DMRs_functions.r)
#add -log10(p-values) to each results table
add_log10(betaResults) -> betaResults
add_log10(betaResults_r) -> betaResults_r

# add -log10(p-values) of no weighted to other tables for color gradient in plots
add_log10_nw(results_table = betaResults_r, nw_table = betaResults) -> betaResults_r

#create dataset with required data for the plotting. In these datasets the low_vs_inter and low_vs_high are the same columns with a separate column indicating which comparison the values correspond to (identity column)
data_nw <- create_data(betaResults)
data_r <- create_data(betaResults_r)

####qq plots####

q <- data_nw %>%
  ggplot( aes(theoretical, log10pval, color=identity)) +
  geom_point() +
  geom_abline(intercept = 0, slope = 1) +
  geom_hline(yintercept = -log10(bonf), color='red')

#####

q_r <- data_r %>%
  ggplot( aes(theoretical, log10pval, color=identity)) +
  geom_point() +
  geom_abline(intercept = 0, slope = 1) +
  geom_hline(yintercept = -log10(bonf), color='red')

pdf(paste0(plots_dir, "DMPs_weight_comparison_qqplot1", cohort, "_", str_replace(region, "_ID", ""), ".pdf"))
  print(q)
dev.off()

pdf(paste0(plots_dir, "DMPs_weight_comparison_qqplot2", cohort, "_", str_replace(region, "_ID", ""), ".pdf"))
  print(q_r)
dev.off()
