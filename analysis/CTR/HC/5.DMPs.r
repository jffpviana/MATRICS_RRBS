library(stringr) #load libraries
library(plyr)
library(data.table)
library(BiSeq)


input_dir <- "/home/vianaj/Documents/MATRICS/analysis/CTR/HC/analysis/"
output_dir <- "/home/vianaj/Documents/MATRICS/analysis/CTR/HC/analysis/"
pheno_path <- "/home/vianaj/Documents/MATRICS/analysis/CTR/phenoCTR.csv"
function_path <- "/home/vianaj/Documents/MATRICS/MATRICS_repo/analysis/betaRegression3Groups.r"

source(function_path)

region="HC_ID"
cohort="CTR"

load(paste0(input_dir, "betas_all_obj_", cohort, "_", str_replace(region, "_ID", ""))) #save BiSeq object


#betaResults <- betaRegression3Groups(formula = ~group, link = "probit", object = betas_all_obj, type = "BR")
group <- colData(betas_all_obj)$Group
totest <- methLevel(betas_all_obj)[100,]
min.meth <- min(totest[totest > 0], na.rm=TRUE)
max.meth <- max(totest[totest < 1], na.rm=TRUE)

totest[totest == 0] <- min.meth
totest[totest == 1] <- max.meth


lmodel <- betareg(formula = totest~group)
summary(lmodel)


totestinter<- 
groupinter<-group[which(group=="low"|group=="inter")]
totesthigh
