##
library("TxDb.Rnorvegicus.UCSC.rn6.refGene") # load genome specific library
input_dir <- "/home/vianaj/Documents/MATRICS/analysis/CTR/HC/analysis/"
anno_dir <- "/home/vianaj/Documents/MATRICS/analysis/CTR/"
genome <- "rn6"
current_anno <- "annotations_rn6_130421.RData"
region <- "HC_ID"
cohort <- "CTR"
##

library(stringr) #load libraries
library(plyr)
library(data.table)
library(annotatr)
library(GenomicRanges)

load(file=paste0(input_dir, "biseq_rawmeth_obj_", cohort, "_", str_replace(region, "_ID", ""))) #load BiSeq object

load(file=paste0(anno_dir, current_anno))#load annotations object

seqlevels(data_meth@rowRanges)[grep('^[0-9]*$', seqlevels(data_meth@rowRanges))] <- paste0("chr", seqlevels(data_meth@rowRanges)[grep('^[0-9]*$', seqlevels(data_meth@rowRanges))]) #substitute chr number by starting with 'chr' to match annotations object

#repeat for MT, X and Y
seqlevels(data_meth@rowRanges)[grep('MT', seqlevels(data_meth@rowRanges))] <- str_replace(seqlevels(data_meth@rowRanges)[grep('MT', seqlevels(data_meth@rowRanges))], 'MT', 'chrM')

seqlevels(data_meth@rowRanges)[grep('X', seqlevels(data_meth@rowRanges))] <- str_replace(seqlevels(data_meth@rowRanges)[grep('X', seqlevels(data_meth@rowRanges))], 'X', 'chrX') #substitute chr number by starting with 'chr' to match annotations object

seqlevels(data_meth@rowRanges)[grep('Y', seqlevels(data_meth@rowRanges))] <- str_replace(seqlevels(data_meth@rowRanges)[grep('Y', seqlevels(data_meth@rowRanges))], 'Y', 'chrY') #substitute chr number by starting with 'chr' to match annotations object

scaffolds <- seqlevels(data_meth@rowRanges)[grep('[.]1', seqlevels(data_meth@rowRanges))] # The unplaced scaffold have a '.1' at the end of the chromosome name. In the annotation file they have a 'chrUn_' at the start and 'v1' at the end. Replace '.1' for 'v1

#Look for each scaffold in the annotation object and replace its name with the one in the annotation object
for(i in scaffolds){
	new_scaffold <- seqlevels(annotations)[grep(str_replace(i, '[.]1', ''), seqlevels(annotations))] # look for same name in annotations file
	seqlevels(data_meth@rowRanges)[grep(i, seqlevels(data_meth@rowRanges))] <- new_scaffold # replace in the data object
}

temp_annotated <-  annotateGRanges(object = data_meth@rowRanges, regions = annotations, name = 'Anno', regionInfo = 'tx_id')

data_meth@rowRanges <- temp_annotated


save(data_meth, file=paste0(input_dir, "biseq_anno_meth_obj_", cohort, "_", str_replace(region, "_ID", ""), ".RData"))
