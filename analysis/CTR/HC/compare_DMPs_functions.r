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


##### FUNCTIONS #####
#function to add -log10(p-values) to table
add_log10 <- function(results_table){
  results_table$log10pval1 <- -log10(results_table$p.val1)
  results_table$log10pval2 <- -log10(results_table$p.val2)
  return(results_table)
}

#funtion to add -log10(p-values) of no weighted to other tables for color gradient in plots
add_log10_nw <- function(results_table, nw_table){
  results_table$logpval1_nw <- nw_table[match(rownames(results_table),rownames(nw_table)), "log10pval1"]
  results_table$logpval2_nw <- nw_table[match(rownames(results_table),rownames(nw_table)), "log10pval2"]
  return(results_table)
}

#function to create dataframe for ploting
create_data<- function(results_table){

if("logpval1_nw"%in%colnames(results_table)){ #if this is one of the weighted results table it will have this column name, then do this

  logt <- -log10(1:nrow(results_table)/nrow(results_table)) # calculate theoretical quantiles for qq plot

  logp1 <- cbind(results_table[, c("p.val1", "log10pval1","logpval1_nw")], logt, rep("low_vs_inter", nrow(results_table))) #get data frame with results relative to low vs inter comparison

  logp2 <- cbind(results_table[, c("p.val2", "log10pval2","logpval2_nw")], logt, rep("low_vs_high", nrow(results_table))) #get data frame with results relative to low vs high comparison

  colnames(logp1)<- c("pval", "log10pval", "log10pval_nw", "theoretical", "identity")
  rownames(logp1)<-NULL #remore rownames so we can row bind the low vs inter and low vs high results
  colnames(logp2)<- c("pval", "log10pval", "log10pval_nw", "theoretical", "identity")
  rownames(logp2)<-NULL

  data<-rbind(logp1, logp2)
  return(data)

  }else{ #if the results table is the non weighted results than it will have one   logt <- -log10(1:nrow(results_table)/nrow(results_table)) # calculate theoretical quantiles for qq plot
    logt <- -log10(1:nrow(results_table)/nrow(results_table)) # calculate theoretical quantiles for qq plot

    logp1 <- cbind(results_table[, c("p.val1", "log10pval1")], logt, rep("low_vs_inter", nrow(results_table))) #get data frame with results relative to low vs inter comparison

    logp2 <- cbind(results_table[, c("p.val2", "log10pval2")], logt, rep("low_vs_high", nrow(results_table))) #get data frame with results relative to low vs high comparison

    colnames(logp1)<- c("pval", "log10pval", "theoretical", "identity")
    rownames(logp1)<-NULL #remore rownames so we can row bind the low vs inter and low vs high results
    colnames(logp2)<- c("pval", "log10pval", "theoretical", "identity")
    rownames(logp2)<-NULL

    data<-rbind(logp1, logp2)
    return(data)
  }
}
##### end of functions specification #####
