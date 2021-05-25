library(stringr) #load libraries
library(plyr)
library(data.table)
library(BiSeq)


input_dir="/home/vianaj/Documents/MATRICS/analysis/CTR/PFC/analysis/"
output_dir="/home/vianaj/Documents/MATRICS/analysis/CTR/PFC/analysis/"
region="PFC_ID"
cohort="CTR"

load(file=paste0(input_dir, "biseq_rawmeth_obj_", cohort, "_", str_replace(region, "_ID", ""))) #load raw BiSeq object

load(file=paste0(input_dir, "biseq_predictedmeth_obj_", cohort, "_", str_replace(region, "_ID", ""))) #load clustered/smooth BiSeq objects


rrbs.raw.reduced <- filterBySharedRegions(object=data_meth, groups=colData(data_meth)$Group, perc.samples=0.5, minCov=10) #remove low coverage and lowly represented sites, keep consistent with what was used in the clustering steps

dim(data_meth)
#4091893      24

dim(rrbs.raw.reduced)
#1316026     24

#convert BSRaw to BSRel object (coverage to methylation values)
rrbs.raw.rel <- rawToRel(rrbs.raw.reduced)

RRBS_rawbetas <- as.data.frame(methLevel(rrbs.raw.rel)) #extract raw methylation values
dim(RRBS_rawbetas)
#1316026       24

coordinates_raw <- as.data.frame(rrbs.raw.rel@rowRanges) # extract CpG positions
rownames(RRBS_rawbetas) <- paste(coordinates_raw$seqnames, ":", coordinates_raw$start, sep="") #add as rownames of methylation values

RRBS_rawbetas <- cbind(RRBS_rawbetas, coordinates_raw)#add coordinates to data-frame so we can create a BSrel object later

RRBS_rawbetas[, "cluster.id"] <- NA #the smoothed betas have a column indicating which cluster they have been assigned to. Add a column to raw betas with cluster id = NA


RRBS_smoothbetas <- as.data.frame(methLevel(predictedMeth)) #extract smoothed methylation values
dim(RRBS_smoothbetas)
#1892970     24

coordinates_pred <- as.data.frame(predictedMeth@rowRanges)
rownames(RRBS_smoothbetas) <- paste(coordinates_pred$seqnames, ":", coordinates_pred$start, sep="") #add as rownames of methylation values #add as rownames of methylation values
RRBS_smoothbetas <- cbind(RRBS_smoothbetas, coordinates_pred)#add coordinates to data-frame so we can create a BSrel object later


reduced_RRBS_rawbetas <- RRBS_rawbetas[-which(rownames(RRBS_rawbetas)%in%rownames(RRBS_smoothbetas)),] #excluse sites that are present in the smoothed data frame


all_betas <- rbind(reduced_RRBS_rawbetas, RRBS_smoothbetas) #join raw and smoother betas
dim(all_betas)
#2092056      30

all_betas_order <- all_betas[order(rownames(all_betas)),] #order by coordinate


write.csv(all_betas_order, file=paste0(output_dir, "complete_betas_", cohort, "_", str_replace(region, "_ID", ""))) #save complete betas
