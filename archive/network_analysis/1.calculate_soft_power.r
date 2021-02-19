#Plots the scale-free topology fit index as a function of a soft-thresholding power. 
#This plot is used the decide on the most appropriated soft-thresholding power for the network.
#For more information on how to determine the correct soft-thresholding power bsed on the resulting plot please see the WGCNA manual and tutorials
args <- commandArgs(TRUE) # option to read arguments from bash script
args[1]->cohort
args[2]->brain_region
args[3]->output_path
args[4]->pheno_path

library('WGCNA') #load library

enableWGCNAThreads(10) #enables parallel calculation, determine number of processors depending on your system


read.table(paste0(output_path, "CpG_regions_txt_", cohort, brain_region, ".txt"), header=TRUE) -> results #read results file from brain region 1  This has the counts that were used in the analysis too. 

paste(results$chrom, results$chromStart, sep=":") -> rownames(results) #create row names with position ID

read.csv(pheno_path)->pheno #load phenotype file
pheno[, paste0(brain_region, "_ID")]->rownames(pheno) #use the sample ID as row names


log2(results[, rownames(pheno)]+1)->countslog #log transform the counts so they can be used by WGCNA with a Pearson

rm(list=c("results")) #remove these objects to free up more memory

data<-t(countslog) #transpose betas (rows=samples, columns=counts)

network.type = "signed" #network type. In this study we are using a signed network because we are interested in genes that change the expression in the same direction together

powers = c(c(1:10), seq(from = 12, to = 20, by = 2)) #choose a set of soft-thresholding powers to test

sft = pickSoftThreshold(data, powerVector = powers, verbose = 5, networkType = network.type) #call the network topology analysis function
#blockSize is the size of the block of genes that will be analysed by parallel analysis, here we are using the default which is 1000, but this can be reduced to speed up the proccess if needed


##plot results
pdf(paste(output_path, "WGCNA_powers_", cohort, brain_region, "_", network.type, "_.pdf", sep = "")) #write the plot into a pdf file. If working with RStudio you don't have to do this
plot(sft$fitIndices[,1], -sign(sft$fitIndices[,3])*sft$fitIndices[,2], xlab = "Soft Threshold (power)", ylab = "Scale Free Topology Model Fit, signed R^2", type = "n", main = paste("Scale independence")) #plots the scale-free topology fit index as a function of a soft-thresholding power
text(sft$fitIndices[,1], -sign(sft$fitIndices[,3])*sft$fitIndices[,2], labels= powers, cex = 0.8, col = "red") #plot the power number as text in red
##this line corresponds to using an R^2 cut off of h
abline(h = 0.9, col = "red") #adds a line on 0.9, but can be removed or moved

plot(sft$fitIndices[,1], sft$fitIndices[,5], xlab = "Soft Threshold (power)", ylab = "Mean Connectivity", type = "n", main = paste("Mean connectivity")) #Second plot is the mean connectivity as a function of the soft-thresholding power
text(sft$fitIndices[,1], sft$fitIndices[,5], labels = powers, cex=0.8, col = "red") #plot the power number as text in red
dev.off()


