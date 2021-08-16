library(stringr) #load libraries
library(plyr)
library(ggpubr)
library(viridis)
library(BiSeq)
library(annotatr)
library(GenomicRanges)
library(Gviz)
library(GenomicFeatures)
library("TxDb.Rnorvegicus.UCSC.rn6.refGene") # load genome specific library

input_dir="/home/vianaj/Documents/MATRICS/analysis/CTR/HC/analysis/"
output_dir="/home/vianaj/Documents/MATRICS/analysis/CTR/HC/analysis/"
pheno_path <- "/home/vianaj/Documents/MATRICS/analysis/CTR/phenoCTR.csv"
function_path <- "/home/vianaj/Documents/MATRICS/MATRICS_repo/analysis/nearest_annotations.r"


region="HC_ID"
cohort="CTR"

#load genome annotation
current_anno <- "/home/vianaj/Documents/MATRICS/analysis/CTR/annotations_rn6_130421.RData"
load(current_anno)

#load external functions
source(function_path)

#load DMRs 5% FDR
load(file=paste0(output_dir, "DMR_FDR5_anno_", cohort, "_", str_replace(region, "_ID", ""), ".RData"))

#load DMPs
load(file=paste0(output_dir, "BetaReg_results_anno_DMRoverlap_", cohort, "_", str_replace(region, "_ID", ""), ".RData"))

#load betas
load(paste0(input_dir, "betas_all_obj_anno_", cohort, "_", str_replace(region, "_ID", "")))


#add genome name to object
genome(DMRs2anno)<-'rn6'

#set chromosome names and genome
chr <- as.character(unique(seqnames(DMRs2anno)))
gen <- genome(DMRs2anno)

#create track for current DMR
atrack <- AnnotationTrack(DMRs2anno[1], name = "DMRs", genome='rn6')
#create the genome track with the coordinates
gtrack <- GenomeAxisTrack()

#create the chromosome track
itrack <- IdeogramTrack(genome = gen[1], chromosome = chr)


#find the nearest CpG island using function I created and saved externally
island <- nearest_island(DMRs2anno[1], annotations)[[1]]
distance_island <- nearest_island(DMRs2anno[1], annotations)[[2]]

#create track for nearest CpG island
islandtrack <- AnnotationTrack(island, name = "CpG islands", genome='rn6', fill=elementMetadata(island)$colours)

#find the nearest gene using function I created and saved externally
anno_gene <- nearest_gene(DMRs2anno[1], annotations)[][1]]
distance_gene <- nearest_gene(DMRs2anno[1], annotations)[][2]]

#make nearest gene track
genetrack <- GeneRegionTrack(TxDb.Rnorvegicus.UCSC.rn6.refGene, genome = gen[1], chromosome = chr)


#make beta values track
betas_dmr <-  unique(subsetByOverlaps(all_betas_annotated, DMRs2anno[1])) #extract betas of the current dmr

unique(as.character(seqnames(betas_dmr))) ->seqlevels(betas_dmr) #re write the chromosome names to the ones that are reall present in the object
dmptrack<- DataTrack(betas_dmr, name='DNA methylation')


##############################################
####check the all_betas_annotated object, loads of values duplicated. check row 14:9017524 as example##########################################




#First plot is the DMR in relation to the nearest gene (if closer than 100kb) an closest CpG island

  plotTracks(list(itrack, gtrack, atrack,  genetrack, islandtrack), dmptrack, from= start(DMRs2anno[1])-100000, to= end(DMRs2anno[1])+100000)
