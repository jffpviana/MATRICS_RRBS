##
library("TxDb.Rnorvegicus.UCSC.rn6.refGene") # load genome specific library
input_dir <- "/home/vianaj/Documents/MATRICS/analysis/CTR/HC/methylation/"
output_dir <- "/home/vianaj/Documents/MATRICS/analysis/CTR/HC/methylation/"
genome <- "rn6"
current_anno <- "annotations_rn6_130421.RData"
##

library(stringr) #load libraries
library(plyr)
library(data.table)
library(annotatr)
library(GenomicRanges)

list_datasets <- list() # creates a list

list_cov <- dir(path=input_dir, pattern ="*.cov") # creates the list of all .cov files in the directory

print(list_cov) #print the list of .cov files so can check on log files

load(current_anno)#load annotations object

for (i in 1:length(list_cov)){ #for all the .cov files in the folder execute the following loop
	read.table(paste0(input_dir, list_cov[i]), stringsAsFactors=FALSE)->temp_file #read current file
	 #attribute these column names

	c("chr", "start", "end", "methylation_percentage", "count_methylated", "count_unmethylated")->colnames(temp_file) #attribute these column names

	scaffold_match <- grep('[.]1', temp_file$chr) #get indexes of chr that have letters but extract only unplaced scaffolds (exclude MT, X, etc). The unplaced scaffold have a '.1' at the end of the chromosome name. In the annotation file they have a 'chrUn_' at the start and 'v1' at the end.

	temp_file[scaffold_match,"chr"] <- paste0("chrUn_", temp_file[scaffold_match,"chr"]) #place 'chrUn_' at the start of the scaffold name
	temp_file[scaffold_match,"chr"] <- str_replace(temp_file[scaffold_match,"chr"], '[.]1', 'v1') # replace '.1' for 'v1'

	numeric_match <- grep('^[0-9]*$', temp_file$chr) #get indexes of chr that are numeric
	temp_file[numeric_match,"chr"] <- paste0("chr", temp_file[numeric_match,"chr"]) #substitute chr number by starting with chr to match annotations object

  ranges_temp <- makeGRangesFromDataFrame(temp_file, keep.extra.columns=TRUE) #make GenomicRanges object from .cov file

	temp_annotated <- annotate_regions(regions = ranges_temp, annotations = annotations, ignore.strand = TRUE, quiet = FALSE)

	save(temp_annotated, file=paste0(output_dir, "annotated_cov_",  str_replace(list_cov[i], ".cov", ""), "RData"))
}
####STOPPED HERE, GENERATED ANNOTATION FOR EACH FILE SPARATE, BUT HOW WILL I INPUT INTO BISEQ? MAYBE IT'S BETTER TO DO THIS AFTER MERGING THE COV FILES.###
