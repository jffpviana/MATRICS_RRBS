library(stringr) #load libraries
library(plyr)
library(data.table)
library(annotatr)

input_dir <- "/home/vianaj/Documents/MATRICS/analysis/CTR/HC/methylation"
output_dir <- "/home/vianaj/Documents/MATRICS/analysis/CTR/HC/methylation"

list_datasets <- list() # creates a list

list_cov <- dir(path=input_dir, pattern ="*.cov") # creates the list of all .cov files in the directory


print(list_cov) #print the list of .cov files so can check on log files
