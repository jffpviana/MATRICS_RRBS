args <- commandArgs(TRUE) # option to read arguments from bash script
args[1]->cohort
args[2]->brain_region
args[3]->output_path
args[4]->genome

library(GenomicRanges) #load library
library(annotatr) #load library

read.table(paste0(output_path, "CpG_regions_txt_", cohort, brain_region, ".txt"), header=TRUE) -> txt_file #load txt file with CpG sites included in this analysis

makeGRangesFromDataFrame(txt_file, keep.extra.columns=TRUE) -> GRanges_object #make a GRanges object from the regions 

c(paste0(genome, '_cpgs'), paste0(genome, '_basicgenes'), paste0(genome, '_genes_intergenic'), paste0(genome, '_genes_intronexonboundaries')) ->annots #anotations of interest

build_annotations(genome = genome, annotations = annots) -> annotations # build the annotations

annotate_regions(regions = GRanges_object, annotations = annotations, ignore.strand = TRUE, quiet = FALSE)-> CpGs_annotated #annotate the CpGs in this analysis
 
data.frame(CpGs_annotated) -> CpGs_annotated_dataframe #extract data frame

write.table(CpGs_annotated_dataframe, paste0(output_path, "CpG_annotation_", cohort, brain_region, ".txt")) #write file with annotation