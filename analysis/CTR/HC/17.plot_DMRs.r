library(stringr) #load libraries
library(plyr)
library(ggpubr)
library(viridis)
library(BiSeq)
library(annotatr)
library(GenomicRanges)
library(Gviz)

input_dir="/home/vianaj/Documents/MATRICS/analysis/CTR/HC/analysis/"
output_dir="/home/vianaj/Documents/MATRICS/analysis/CTR/HC/analysis/"
pheno_path <- "/home/vianaj/Documents/MATRICS/analysis/CTR/phenoCTR.csv"
function_path <- "/home/vianaj/Documents/MATRICS/MATRICS_repo/analysis/change_chr.r"

region="HC_ID"
cohort="CTR"

#load DMRs 5% FDR
load(file=paste0(output_dir, "DMR_FDR5_anno_", cohort, "_", str_replace(region, "_ID", ""), ".RData"))

#load DMPs
load(file=paste0(output_dir, "BetaReg_results_anno_DMRoverlap_", cohort, "_", str_replace(region, "_ID", ""), ".RData"))

#load betas
load(paste0(input_dir, "betas_all_obj_", cohort, "_", str_replace(region, "_ID", "")))

#calculate methylation levels in percentage
betasperc <-100*methLevel(betas_all_obj)






atrack <- AnnotationTrack(DMRs2anno, name = "DMRs")

#add genome name to object
genome(DMRs2anno)<-'rn6'

chr <- as.character(unique(seqnames(DMRs2anno)))
gen <- genome(DMRs2anno)

atrack <- AnnotationTrack(DMRs2anno[1], name = "DMRs", genome='rn6')
gtrack <- GenomeAxisTrack()
itrack <- IdeogramTrack(genome = gen[1], chromosome = chr)





dmptrack<- betas_bonf_annotated[findOverlaps(DMRs2anno[1], betas_bonf_annotated)@to,]

plotTracks(list(itrack, gtrack, atrack, dmptrack))
