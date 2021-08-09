#make Genomic Ranges object from beta values
library(stringr) #load libraries
library(plyr)
library(ggpubr)
library(viridis)
library(BiSeq)
library(annotatr)
library(GenomicRanges)

input_dir="/home/vianaj/Documents/MATRICS/analysis/CTR/HC/analysis/"
output_dir="/home/vianaj/Documents/MATRICS/analysis/CTR/HC/analysis/"
pheno_path <- "/home/vianaj/Documents/MATRICS/analysis/CTR/phenoCTR.csv"
function_path <- "/home/vianaj/Documents/MATRICS/MATRICS_repo/analysis/change_chr.r"

region <- "HC_ID"
cohort <- "CTR"

genome <- "rn6"
current_anno <- "/home/vianaj/Documents/MATRICS/analysis/CTR/annotations_rn6_130421.RData"

source(function_path) #load external function to change the chr names in the object
load(current_anno)#load annotations object


#load betas
load(paste0(input_dir, "betas_all_obj_", cohort, "_", str_replace(region, "_ID", "")))

#calculate methylation levels in percentage
betasperc <-data.frame(100*methLevel(betas_all_obj))

#create new columns with chr and position of betas (take from rownames)
betasperc$chr <- str_replace(rownames(betasperc), ':.*', '')
betasperc$start <- str_replace(rownames(betasperc), '[^:]*.', '')
betasperc$end <- str_replace(rownames(betasperc), '[^:]*.', '')


#make Genomic Ranges object
ranges_temp <- makeGRangesFromDataFrame(betasperc, keep.extra.columns=TRUE)


#change chr names with functions previously created
#substitute chr names to match the annotation object, separate function change_chr to do that
ranges_temp<-change_chr(ranges_temp)

#substitute the scaffold names
ranges_temp<-change_scaffold(ranges_temp, annotations)

#annotate the GRanges betas object
all_betas_annotated <- annotate_regions(regions = ranges_temp, annotations = annotations, ignore.strand = TRUE, quiet = FALSE)

#save the all betas annotated GRanges object
save(all_betas_annotated, file=paste0(output_dir, "betas_all_obj_anno_", cohort, "_", str_replace(region, "_ID", "")))
