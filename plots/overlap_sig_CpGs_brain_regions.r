args <- commandArgs(TRUE) # option to read arguments from bash script
args[1]->cohort
args[2]->input_path1
args[3]->input_path2
args[4]->input_path3
args[5]->brain_region1
args[6]->brain_region2
args[7]->brain_region3
args[8]->p_val

library("VennDiagram") #load package

read.table(paste0(input_path1, "CpG_regions_txt_", cohort, brain_region1, ".txt"), header=TRUE) -> results1 #read results file from brain region 1 
read.table(paste0(input_path2, "CpG_regions_txt_", cohort, brain_region2, ".txt"), header=TRUE) -> results2 #read results file from brain region 2
read.table(paste0(input_path3, "CpG_regions_txt_", cohort, brain_region3, ".txt"), header=TRUE) -> results3 #read results file from brain region 3

paste(results1$chrom, results1$chromStart, sep=":") -> results1$Pos #create column with position ID
paste(results2$chrom, results2$chromStart, sep=":") -> results2$Pos
paste(results3$chrom, results3$chromStart, sep=":") -> results3$Pos


results1[which(results1$P.Value<as.numeric(p_val)),] -> results1_sig #extract P-values less than 0.001
results2[which(results2$P.Value<as.numeric(p_val)),] -> results2_sig 
results3[which(results3$P.Value<as.numeric(p_val)),] -> results3_sig 

#calculate the overlaps of between the brain regions to imput in the plot
length(which(results1_sig$Pos %in% results2_sig$Pos)) -> overlap_12 #overlap between brain regions 1 and 2
length(which(results2_sig$Pos %in% results3_sig$Pos)) -> overlap_23 #overlap between brain regions 2 and 3
length(which(results1_sig$Pos %in% results3_sig$Pos)) -> overlap_13 #overlap between brain regions 1 and 3
length(which(results1_sig$Pos %in% results2_sig$Pos[which(results2_sig$Pos %in% results3_sig$Pos)])) -> overlap_123 #overlap between brain regions 1, 2 and 3

pdf(paste0(input_path1, "Venn_CpGs_pval_", p_val, "_", cohort, brain_region1, ".pdf")) #open the pdf. It will be outputed to the folder of the first brain region
draw.triple.venn(length(results1_sig$Pos), length(results2_sig$Pos), length(results3_sig$Pos), overlap_12, overlap_23, overlap_13, overlap_123) #draw the venn diagram
dev.off() #close the pdf

matrix(NA, 7, 1) -> mat_overlap #make an empty matrix to add the values and write to a .csv file
"Region_or_overlap" -> colnames(mat_overlap) #change the name of the column
c(paste0("Total_", brain_region1), paste0("Total_", brain_region2), paste0("Total_", brain_region3), paste0("Overlap_", brain_region1, "_", brain_region2), paste0("Overlap_", brain_region2, "_", brain_region3), paste0("Overlap_", brain_region1, "_", brain_region3), paste0("Overlap_", brain_region1, "_", brain_region2, "_", brain_region3)) -> rownames(mat_overlap) #change the row names

#populate matrix
length(results1_sig$Pos) -> mat_overlap[1,1]
length(results2_sig$Pos) -> mat_overlap[2,1]
length(results3_sig$Pos) -> mat_overlap[3,1]
overlap_12 -> mat_overlap[4,1]
overlap_23 -> mat_overlap[5,1]
overlap_13 -> mat_overlap[6,1]
overlap_123 -> mat_overlap[7,1]

write.csv(mat_overlap, paste0(input_path1, "Overlap_CpGs_pval_", p_val, "_", cohort, brain_region1, ".csv")) #write the marix into a .csv file