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

betaResults_g <- read.csv(file=paste0(input_dir, "DMPs_weighted_global_", cohort, "_", str_replace(region, "_ID", ""), ".csv")) #load results of beta regression weighted by row

betaResults_r <- read.csv(file=paste0(input_dir, "DMPs_weighted_row_", cohort, "_", str_replace(region, "_ID", ""), ".csv")) #load results of beta regression weighted globally

bonf <- 0.05/nrow(betaResults) #calculate bonferroni threshold

#remove rows ith NA results
na.omit(betaResults)->betaResults
na.omit(betaResults_r)->betaResults_r
na.omit(betaResults_g)->betaResults_g

#add chr + position as row names
paste0(betaResults$chr, ":", betaResults$pos)-> rownames(betaResults)
paste0(betaResults_r$chr, ":", betaResults_r$pos)-> rownames(betaResults_r)
paste0(betaResults_g$chr, ":", betaResults_g$pos)-> rownames(betaResults_g)

##the following functions functions are written in a separate script (compare_DMRs_functions.r)
#add -log10(p-values) to each results table
add_log10(betaResults) -> betaResults
add_log10(betaResults_r) -> betaResults_r
add_log10(betaResults_g) -> betaResults_g

# add -log10(p-values) of no weighted to other tables for color gradient in plots
add_log10_nw(results_table = betaResults_r, nw_table = betaResults) -> betaResults_r
add_log10_nw(results_table = betaResults_g, nw_table = betaResults) -> betaResults_g

#create dataset with required data for the plotting. In these datasets the low_vs_inter and low_vs_high are the same columns with a separate column indicating which comparison the values correspond to (identity column)
data_nw <- create_data(betaResults)
data_r <- create_data(betaResults_r)
data_g <- create_data(betaResults_g)



###correlation of p-values
data_cor_inter<- data.frame(cbind(data_r[data_r$identity%in%"low_vs_inter", "log10pval"], data_r[data_r$identity%in%"low_vs_inter", "log10pval_nw"]))

data_cor_high<- data.frame(cbind(data_r[data_r$identity%in%"low_vs_high", "log10pval"], data_r[data_r$identity%in%"low_vs_high", "log10pval_nw"]))


colnames(data_cor_inter)<-c("lo10pval_inter", "log10pval_nw_inter")

colnames(data_cor_high)<-c("lo10pval_high", "log10pval_nw_high")

p_inter_all <- ggscatter(data_cor_inter, y = "lo10pval_inter", x = "log10pval_nw_inter", add = "reg.line", add.params = list(color = "blue")) +
  stat_cor(method = "pearson")

p_high_all <- ggscatter(data_cor_high, y = "lo10pval_high", x = "log10pval_nw_high", add = "reg.line", add.params = list(color = "blue")) +
  stat_cor(method = "pearson")


#only plot p-value > 0.05 to observe better

p_inter_sig <- ggscatter(data_cor_inter[which(data_cor_inter$log10pval_nw_inter> (-log10(0.05))), ], y = "lo10pval_inter", x = "log10pval_nw_inter", add = "reg.line", add.params = list(color = "blue")) +
  stat_cor(method = "pearson")

p_high_sig <- ggscatter(data_cor_high[which(data_cor_high$log10pval_nw_high> (-log10(0.05))), ], y = "lo10pval_high", x = "log10pval_nw_high", add = "reg.line", add.params = list(color = "blue")) +
  stat_cor(method = "pearson")



pdf(paste0(plots_dir, "DMPs_weight_comparison_correlations_all_", cohort, "_", str_replace(region, "_ID", ""), ".pdf"))

print(p_inter_all)

print(p_high_all)

dev.off()



pdf(paste0(plots_dir, "DMPs_weight_comparison_correlations_sig_", cohort, "_", str_replace(region, "_ID", ""), ".pdf"))

print(p_inter_sig)

print(p_high_sig)

dev.off()
