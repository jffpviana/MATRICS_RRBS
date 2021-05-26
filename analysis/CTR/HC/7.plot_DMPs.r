library(stringr) #load libraries
library(plyr)
library(tidyverse)
library(ggpubr)
library(viridis)
library(BiSeq)


input_dir="/home/vianaj/Documents/MATRICS/analysis/CTR/HC/analysis/"
output_dir="/home/vianaj/Documents/MATRICS/analysis/CTR/HC/analysis/"
pheno_path <- "/home/vianaj/Documents/MATRICS/analysis/CTR/phenoCTR.csv"

region="HC_ID"
cohort="CTR"

load(file=paste0(output_dir, "BetaReg_results_", cohort, "_", str_replace(region, "_ID", ""), ".RData")) #writing in a new csv#save in object with bonf threshold and original results


load(file=paste0(input_dir, "biseq_rawmeth_obj_", cohort, "_", str_replace(region, "_ID", ""))) #load raw BiSeq object

coverage <- totalReads(data_meth) #extract coverage and use chromosome:position as rownames
rownames(coverage) <- paste0(as.character(data.frame(rowRanges(data_meth))$seqnames), ":", as.character(data.frame(rowRanges(data_meth))$start))

load(paste0(input_dir, "betas_all_obj_", cohort, "_", str_replace(region, "_ID", ""))) #load beta values object

rownames(betaResults_bonf)<-paste0(betaResults_bonf$chr, ":", betaResults_bonf$pos) #add chromosome:position as rownames of the bonferroni beta regression values

identical(rownames(colData(data_meth)), colnames(methLevel(betas_all_obj))) #check if the samples are in the same order
identical(rownames(colData(data_meth)), colnames(coverage)) #check if the samples are in the same order

#create vectors of all the examples to plot: only bonferroni significant in low vs inter, only bonferrori significant in low vs high, significant in both
v_inter <- rownames(betaResults_bonf[which(betaResults_bonf$p.val1 <= bonferroni & betaResults_bonf$p.val2 > bonferroni),]) # only bonferroni significant in low vs inter

v_high <- rownames(betaResults_bonf[which(betaResults_bonf$p.val2 <= bonferroni & betaResults_bonf$p.val1 > bonferroni),]) # only bonferroni significant in low vs inter

v_both <- rownames(betaResults_bonf[which(betaResults_bonf$p.val1 <= bonferroni & betaResults_bonf$p.val2 <= bonferroni),]) #significant in both

list_vec <- list(low_inter=v_inter, low_high=v_high, sig_both=v_both) #make a list with all vectors

for(i in 1:length(list_vec)){ #for each vector (situation), start a new pdf

  pdf(paste0(output_dir,  names(list_vec)[i],"_DMPs_BoxplotAndCov_", cohort, "_", str_replace(region, "_ID", ""), ".pdf"))

    for(j in list_vec[[i]]){ #for each vector/situation, create a plot for each site
      betas <- methLevel(betas_all_obj)[j,] #extract the methylation values of the each site to plot

      coverage_site <- coverage[j,] #extract the coverag of the same site

      data<- data.frame(group=colData(data_meth)$Group, betas=betas, coverage=coverage_site)

      #boxplot and scatter of NA methylation values by aggression group
      b<-ggplot(data=data, aes(x=group, y=betas, fill=group)) +
        geom_boxplot(fill="blue") +
        geom_jitter() +
        theme(legend.position="none", plot.title = element_text(size=11), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_blank()) +
        ggtitle(paste0("chr", j)) +
        xlab("Aggression level") +
        xlab("DNA methylation")

        #boxplot and scatter of coverage by aggression group
      c<-ggplot(data=data, aes(x=group, y=coverage_site)) +
        geom_boxplot(fill="dark blue") +
        geom_jitter() +
        theme(legend.position="none", plot.title = element_text(size=11), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_blank()) +
        ggtitle(paste0("chr", j)) +
        xlab("Aggression level") +
        xlab("Coverage")

      print(ggarrange(b, c))

    }
  dev.off()
}
