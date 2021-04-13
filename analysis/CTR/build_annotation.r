##
library("TxDb.Rnorvegicus.UCSC.rn6.refGene") # load genome specific library
input_dir <- "/home/vianaj/Documents/MATRICS/analysis/CTR/HC/methylation/"
output_dir <- "/home/vianaj/Documents/MATRICS/analysis/CTR/HC/methylation/"
genome <- "rn6"
##

library(stringr) #load libraries
library(plyr)
library(data.table)
library(annotatr)
library(GenomicRanges)

list_datasets <- list() # creates a list

list_cov <- dir(path=input_dir, pattern ="*.cov") # creates the list of all .cov files in the directory

print(list_cov) #print the list of .cov files so can check on log files

annos <- builtin_annotations()[grep(genome, builtin_annotations())] #all anotations available for this genome in he package
annotations = build_annotations(genome = genome, annotations = annos) #build annotation object

save(annos, annotations, file="annotations_rn6_130421.RData")
