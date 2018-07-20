#Generates a correlation network with all the samples (except the water samples as we are only using DMSO as the true control).
#Uses the soft-thesholding power chosen from the plot created in the 1.calculate_soft_power.r script.
#Outputs an R object with the network created by the WGCNA  package and a list of genes with each corresponding network module.

args <- commandArgs(TRUE) # option to read arguments from bash script
args[1]->cohort
args[2]->brain_region
args[3]->output_path
args[4]->pheno_path
args[5]->softPower 

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

min_mod_size = 50 #we don't want any modules that are smaller than 20 genes

network_pearson = blockwiseModules(data, power = softPower, TOMType = network.type, minModuleSize = min_mod_size, reassignThreshold = 0, mergeCutHeight = 0.25, numericLabels = TRUE, saveTOMs= FALSE, verbose = 3) #create the network

 
data.frame(network_pearson$colors)->colorsmod #extract the module each gene is in

rownames(colorsmod)<-rownames(countslog) #give the rows the names of the genes in the counts objects

data.frame(table(colorsmod))->tab_modules #create table with the number of genes in each module
labels2colors(as.numeric(as.vector(tab_modules[,1])))->col_modules #extract list of module colours. The colours are arbitrary attributed by WGCNA


save(network_pearson, colorsmod, tab_modules, col_modules, file = paste(output_path, "WGCNA_network_", cohort, brain_region, "_", network.type, "_.Rdata", sep = "")) # save the network and the list of genes with each corresponding network module in an R object

