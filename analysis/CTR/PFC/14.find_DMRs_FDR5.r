library(stringr) #load libraries
library(plyr)
library(data.table)
library(BiSeq)
library(parallel)


input_dir="/home/vianaj/Documents/MATRICS/analysis/CTR/PFC/analysis/"
output_dir="/home/vianaj/Documents/MATRICS/analysis/CTR/PFC/analysis/"
pheno_path <- "/home/vianaj/Documents/MATRICS/analysis/CTR/phenoCTR.csv"

region<-"PFC_ID"
cohort<-"CTR"

load(paste0(output_dir, "Variograms_smooth_", cohort, "_", str_replace(region, "_ID", ""), ".RData")) #load the R object with the two variograms smoothed


betaResults_sm<- read.csv(file=paste0(input_dir, "DMPs_less_smooth_", cohort, "_", str_replace(region, "_ID", ""), ".csv"), row.names=1)
 #load DMP results from clustered/smooth BiSeq objects, created in previous script

#Remove NA (sites where the analysis didn't work)
dim(betaResults_sm)

betaResults_sm[-which(is.na(betaResults_sm$p.val1) | is.na(betaResults_sm$p.val1)),]->betaResults_less

dim(betaResults_less)


#have two different objects for these results so we can change p.val1 and p.val2 to p.val (so it's recognise by the makeVariogram function)
betaResults_less->betaResults_less1
colnames(betaResults_less1)[grep("p.val1", colnames(betaResults_less1))]<-"p.val"

betaResults_less->betaResults_less2
colnames(betaResults_less2)[grep("p.val2", colnames(betaResults_less2))]<-"p.val"


#make variograms
vario.aux1 <- makeVariogram(betaResults_less1, make.variogram=FALSE)

vario.aux2 <- makeVariogram(betaResults_less2, make.variogram=FALSE)

#replace the pValsList object (test results of the resampled data - null hypothesis) by the test results of interest (for group effect)
#replace the pValsList object (test results of the resampled data - null hypothesis) by the test results of interest (for group effect)

vario1.sm$pValsList <- vario.aux1$pValsList
vario2.sm$pValsList <- vario.aux2$pValsList


#vario.sm dataframes now contains the smoothed variograms under the Null hypothesis together with the P values (and Z scores) from the Wald test.

#Estimate the correlation of the Z scores between two locations in a cluster
locCor1 <- estLocCor(vario1.sm)
locCor2 <- estLocCor(vario2.sm)


#Test each cluster for the presence of at least one DMP.  Use cluster-wise FDR level of x%.

clusters.sig1 <- testClusters(locCor1,
FDR.cluster = 0.05)
#10254 CpG clusters rejected.

clusters.sig2 <- testClusters(locCor2,
FDR.cluster = 0.05)
#3678 CpG clusters rejected.


#trim the rejected CpG clusters to remove the not differentially methylated CpG sites
clusters.trimmed1 <- trimClusters(clusters.sig1, FDR.loc = 0.05)

clusters.trimmed2 <- trimClusters(clusters.sig2, FDR.loc = 0.05)
#These are e objects containing all differentially methylated CpG sites. The p.li column contains the P values estimated in the cluster trimming step.

#For the findDMRs function to work (define DMR boundaries), the column names of these objects need to be consistent with the original/unchanged DMP results table (two groups comparison, rather than 3 groups)

#remove columns regarding the comparison that is not of interest in each dataset and rename the columns
#clusters.trimmed1[, c("chr", "pos", "meth.group1", "meth.group2", "meth.diff1", "estimate1", "std.error1", "p.val", "pseudo.R.sqrt", "cluster.id", "z.score", "pos.new", "p.li")] -> clusters1

#colnames(clusters1) <- c("chr", "pos", "meth.group1", "meth.group2", "meth.diff", "estimate", "std.error", "p.val", "pseudo.R.sqrt", "cluster.id", "z.score", "pos.new", "p.li")

clusters.trimmed2[, c("chr", "pos", "meth.group1", "meth.group3", "meth.diff2", "estimate2", "std.error2", "p.val", "pseudo.R.sqrt", "cluster.id", "z.score", "pos.new", "p.li")] -> clusters2

colnames(clusters2) <- c("chr", "pos", "meth.group1", "meth.group2", "meth.diff", "estimate", "std.error", "p.val", "pseudo.R.sqrt", "cluster.id", "z.score", "pos.new", "p.li")


#identify DMR boundaries. max.dist is the same as used when clustering the CpGs
#DMRs1 <- findDMRs(clusters1, max.dist=500)

DMRs2 <- findDMRs(clusters2, max.dist=500)

#save DMRs objects
#save(DMRs1, file=paste0(output_dir, "DMRs_low_vs_inter_FDR5_", cohort, "_", str_replace(region, "_ID", ""), ".RData")) #save BiSeq object

save(DMRs2, file=paste0(output_dir, "DMRs_low_vs_high_FDR5_", cohort, "_", str_replace(region, "_ID", ""), ".RData")) #save BiSeq object
