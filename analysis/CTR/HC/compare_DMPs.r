library(stringr) #load libraries
library(plyr)
library(data.table)
library(BiSeq)
library(parallel)
library(hrbrthemes)
library(tidyverse)
library(ggpubr)
library(viridis)

input_dir="/home/vianaj/Documents/MATRICS/analysis/CTR/HC/analysis/"
output_dir="/home/vianaj/Documents/MATRICS/analysis/CTR/HC/analysis/"
plots_dir="/home/vianaj/Documents/MATRICS/analysis/CTR/HC/analysis/plots/"
pheno_path <- "/home/vianaj/Documents/MATRICS/analysis/CTR/phenoCTR.csv"

region="HC_ID"
cohort="CTR"


betaResults <- read.csv(file=paste0(input_dir, "DMPs_", cohort, "_", str_replace(region, "_ID", ""), ".csv"))

betaResults_g <- read.csv(file=paste0(input_dir, "DMPs_weighted_global_", cohort, "_", str_replace(region, "_ID", ""), ".csv"))

betaResults_r <- read.csv(file=paste0(input_dir, "DMPs_weighted_row_", cohort, "_", str_replace(region, "_ID", ""), ".csv"))

bonf <- 0.05/nrow(betaResults)



#####dataframe for ploting#####
create_data<- function(results_table, name){

  logp1 <- -log10(na.omit(results_table$p.val1))
  logt1 <- -log10(1:length(logp1)/length(logp1))
  logp1 <- logp1[order(-logp1)]

  logp2 <- -log10(na.omit(results_table$p.val2))
  logp2 <- logp2[order(-logp2)]

  data<-data.frame(cbind(c(logp1, logp2), c(na.omit(results_table$p.val1), na.omit(results_table$p.val2)), c(logt1, logt1), c(rep("low_vs_inter", length(logp1 )), rep("low_vs_high", length(logp1 )))))

  colnames(data) <- c("logpval", "pval", "theoretical", "identity")

  data$logpval<- as.numeric(data$logpval)
  data$pval<- as.numeric(data$pval)
  data$theoretical<- as.numeric(data$theoretical)

  assign(name, data, envir = .GlobalEnv)
  return(name)
}
#####

create_data(betaResults, "data_nw")
create_data(betaResults_r, "data_r")

pdf(paste0(plots_dir, "Bregression_weighting_comparison_", cohort, "_", str_replace(region, "_ID", ""), ".pdf"
#####plot not weighted analysis#####
p <- data_nw %>%
  ggplot( aes(x=pval, fill=identity)) +
    geom_histogram( binwidth=0.001,  alpha=0.6) +
    scale_fill_manual(values=c("blue", "red")) +
    geom_vline(xintercept = bonf, color='red') +
    ggtitle("p-values not weighted") +
    theme_ipsum() +
    theme(
      plot.title = element_text(size=15)
    )

q <- data_nw %>%
  ggplot( aes(theoretical, logpval, color=identity)) +
  geom_point() +
  geom_abline(intercept = 0, slope = 1) +
  theme_ipsum() +
  geom_hline(yintercept = -log10(bonf), color='red')

print(ggarrange(p, q))
#####

#####plot weighted by row#####
p1 <- data_nw %>%
  ggplot( aes(x=pval, fill=identity)) +
    geom_histogram( binwidth=0.001,  alpha=0.6) +
    scale_fill_manual(values=c("blue", "red")) +
    geom_vline(xintercept = bonf, color='red') +
    ggtitle("p-values not weighted") +
    theme_ipsum() +
    theme(
      plot.title = element_text(size=15)
    )

p2 <- data_nw %>%
    ggplot( aes(x=pval, fill=identity)) +
    geom_histogram( binwidth=0.001,  alpha=0.6) +
    scale_fill_manual(values=c("blue", "red")) +
    geom_vline(xintercept = bonf, color='red') +
    ggtitle("p-values not weighted") +
    theme_ipsum() +
    theme(
      plot.title = element_text(size=15)
    )

q <- data_nw %>%
  ggplot( aes(theoretical, logpval, color=identity)) +
  geom_point() +
  geom_abline(intercept = 0, slope = 1) +
  theme_ipsum() +
  geom_hline(yintercept = -log10(bonf), color='red')

print(ggarrange(p, q))
#####
