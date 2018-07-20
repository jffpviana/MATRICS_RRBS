args <- commandArgs(TRUE) # option to read arguments from bash script
args[1]->cohort
args[2]->brain_region
args[3]->output_path
args[4]->genome

library(GenomicRanges) #load library
library(annotatr) #load library

read.table(paste0(output_path, "CpG_regions_txt_", cohort, brain_region, ".txt"), header=TRUE) -> txt_file #load txt file with CpG sites included in this analysis

paste(txt_file$chrom, txt_file$chromStart, sep=":") -> txt_file$Pos #create column with position ID

txt_file[order(txt_file$Pos),] -> txt_file #order by position

makeGRangesFromDataFrame(txt_file, keep.extra.columns=TRUE) -> GRanges_object #make a GRanges object from the regions 

c(paste0(genome, '_cpgs'), paste0(genome, '_basicgenes'), paste0(genome, '_genes_intergenic'), paste0(genome, '_genes_intronexonboundaries')) ->annots #anotations of interest

build_annotations(genome = genome, annotations = annots) -> annotations # build the annotations

annotate_regions(regions = GRanges_object, annotations = annotations, ignore.strand = TRUE, quiet = FALSE)-> CpGs_annotated #annotate the CpGs in this analysis
 
data.frame(CpGs_annotated) -> CpGs_annotated_dataframe #extract data frame

#after these the CpGs with multiple annotations will be in repeated rows, so we will collapse the annotations to have 1 row per CpG

unique(CpGs_annotated_dataframe$Pos) -> unique_pos #create vector of unique positions


"annot.seqnames", "annot.start", "annot.end", "annot.width", "annot.strand", "annot.id", "annot.tx_id", "annot.gene_id", "annot.symbol", "annot.type"
	#list of columns that have new information (annotation)
#list of columns that are a repetition (data)



for(i in 1:length(unique_pos)){ #loop through each of the unique CpG positions
	CpGs_annotated_dataframe[which(CpGs_annotated_dataframe$Pos == unique_pos[i]),] -> current_pos #extract all rows with the current position
	
	apply(current_pos, 2, function(x){paste(as.character(x), collapse=";")})
	current_pos$annot.seqnames
	current_pos$annot.start
	current_pos$annot.end
	current_pos$annot.width
	current_pos$annot.strand
	current_pos$annot.id
	current_pos$annot.tx_id
	current_pos$annot.gene_id
	current_pos$annot.symbol
	current_pos$annot.type
}


write.table(CpGs_annotated_dataframe, paste0(output_path, "CpG_annotation_", cohort, brain_region, ".txt")) #write file with annotation