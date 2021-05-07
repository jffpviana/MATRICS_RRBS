library(stringr) #load libraries
library(plyr)
library(data.table)
library(BiSeq)


args <- commandArgs(TRUE) # option to read arguments from bash script
args[1]->input_dir
args[2]->output_dir
args[3]->region
args[4]->cohort


load(file=paste0(input_dir, "biseq_rawmeth_obj_", cohort, "_", str_replace(region, "_ID", ""))) #load BiSeq object

dim(data_meth)
# 3322735      24


rrbs.clust.unlim <- clusterSites(object = data_meth,
                                  groups = colData(data_meth)$Group,
                                  perc.samples = 0.5,
                                  min.sites = 5,
                                  max.dist = 500,
                                  minCov=10)  #searches for agglomerations of CpG sites across all samples

#In the smoothing step CpG sites with high coverages get high weights. To reduce bias due to unusually high coverages we limit the coverage.
#Number of methylated and unmethylated reads of a CpG site with coverage above maxCov are reduced such that the methylation level remains unchanged.

ind.cov <- totalReads(rrbs.clust.unlim) > 0
quant <- quantile(totalReads(rrbs.clust.unlim)[ind.cov], 0.9)
quant
rrbs.clust.lim <- limitCov(rrbs.clust.unlim, maxCov = quant)

#We then smooth the methylation values of CpG sites within the clusters with the default bandwidth h = 80 base pairs.
predictedMeth <- predictMeth(object = rrbs.clust.lim, mc.cores=8)

save(rrbs.clust.unlim, rrbs.clust.lim, predictedMeth, file=paste0(output_dir, "biseq_predictedmeth_obj_", cohort, "_", str_replace(region, "_ID", ""))) #save BiSeq object
