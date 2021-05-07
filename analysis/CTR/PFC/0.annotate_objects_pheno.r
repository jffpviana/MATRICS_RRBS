#Script to merge smoothed DNA methylation (Biseq) and raw methylation, so we don't lose sites that were not asigned to clusters

library(stringr) #load libraries
library(plyr)
library(data.table)
library(BiSeq)


input_dir="/home/vianaj/Documents/MATRICS/analysis/CTR/PFC/analysis/"
output_dir="/home/vianaj/Documents/MATRICS/analysis/CTR/PFC/analysis/"
pheno_path <- "/home/vianaj/Documents/MATRICS/analysis/CTR/phenoCTR.csv"

region="PFC_ID"
cohort="CTR"

load(file=paste0(output_dir, "biseq_rawmeth_obj_", cohort, "_", str_replace(region, "_ID", ""))) #load raw BiSeq object

load(file=paste0(output_dir, "biseq_predictedmeth_obj_", cohort, "_", str_replace(region, "_ID", ""))) #load clustered/smooth BiSeq objects

pheno <- read.csv(pheno_path, stringsAsFactors=FALSE) #load phenotype file

identical(colnames(data_meth), pheno[, region])
identical(colnames(rrbs.clust.lim), pheno[, region])
identical(colnames(rrbs.clust.unlim), pheno[, region])

#ONLY DO THIS IS COLDATA IS EMPTY, DO NOT KEEP RUNNING THIS SCRIPT AND KEEP ADDING TO METADATA

if(ncol(colData(data_meth))==0){ #if the object doesn't have metadata, add each column of the pheno file to the metaata fo the oject
    for(i in colnames(pheno)){
      colData(data_meth)[, i]<- pheno[, i]
    }
  }else{
  }

if(ncol(colData(data_meth))>0 && is.character(colData(data_meth)$Group)){ # if the oject already has metadata but the Group column is stored as a characater, transform into a factor with the order low, inter and high
  colData(data_meth)$Group <- factor(colData(data_meth)$Group, levels=c("low", "inter", "high"))
  }else{
  }


if(ncol(colData(rrbs.clust.unlim))==0){ #if the object doesn't have metadata, add each column of the pheno file to the metaata fo the oject
    for(i in colnames(pheno)){
      colData(rrbs.clust.unlim)[, i]<- pheno[, i]
    }
  }else{
  }

if(ncol(colData(rrbs.clust.unlim))>0 && is.character(colData(rrbs.clust.unlim)$Group)){ # if the oject already has metadata but the Group column is stored as a characater, transform into a factor with the order low, inter and high
  colData(rrbs.clust.unlim)$Group <- factor(colData(rrbs.clust.unlim)$Group, levels=c("low", "inter", "high"))
  }else{
  }

  if(ncol(colData(rrbs.clust.lim))==0){ #if the object doesn't have metadata, add each column of the pheno file to the metaata fo the oject
      for(i in colnames(pheno)){
        colData(rrbs.clust.lim)[, i]<- pheno[, i]
      }
    }else{
    }

  if(ncol(colData(rrbs.clust.lim))>0 && is.character(colData(rrbs.clust.lim)$Group)){ # if the oject already has metadata but the Group column is stored as a characater, transform into a factor with the order low, inter and high
    colData(rrbs.clust.lim)$Group <- factor(colData(rrbs.clust.lim)$Group, levels=c("low", "inter", "high"))
    }else{
    }


save(data_meth, file=paste0(output_dir, "biseq_rawmeth_obj_", cohort, "_", str_replace(region, "_ID", ""))) #save BiSeq object
save(rrbs.clust.unlim, rrbs.clust.lim, predictedMeth, file=paste0(output_dir, "biseq_predictedmeth_obj_", cohort, "_", str_replace(region, "_ID", ""))) #save BiSeq object
