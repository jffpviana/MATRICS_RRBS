args <- commandArgs(TRUE) # option to read arguments from bash script
args[1]->cohort
args[2]->brain_region
args[3]->output_path
args[4]->results_type

read.csv(paste0(output_path, results_type, cohort, brain_region, ".csv"), row.names=1) -> results #load results file

gsub("\\..*", "", rownames(results)) -> chromosomes # extract the chromosome in each position

gsub(".*?\\.", "", rownames(results)) -> pos_start #extract the starting position

as.numeric(pos_start)+1 -> pos_end #add one for final position


as.matrix(cbind(chromosomes, pos_start, pos_end, results)) -> matrix_txt #create matrix to write into txt file

c("chrom", "chromStart", "chromEnd", colnames(results)) -> colnames(matrix_txt) #change column names


write.table(matrix_txt, paste0(output_path, "CpG_regions_txt_", cohort, brain_region, ".txt"), row.names = FALSE)