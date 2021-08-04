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

#####change this values based on the variogram plotted in the previous script #####
sill1 <- 1.2
sill2 <- 1.25
#####

load(paste0(input_dir, "Variograms_", cohort, "_", str_replace(region, "_ID", ""), ".RData")) # load the R object with the two varigrams


#smooth using sills determined previously from variogram (previous script)
vario1.sm <- smoothVariogram(vario1, sill = sill1)

vario2.sm <- smoothVariogram(vario2, sill = sill2)


#plot the two variograms
pdf(paste0(output_dir, "Variograms_sill_", cohort, "_", str_replace(region, "_ID", ""), ".pdf"))

  plot(vario1$variogram$v, main="low vs inter")
  lines(vario1.sm$variogram[,c("h", "v.sm")],
  col = "red", lwd = 1.5)
 ## results of interest:
  plot(vario2$variogram$v, main="low vs inter")
  lines(vario2.sm$variogram[,c("h", "v.sm")],
  col = "red", lwd = 1.5)

dev.off()

#save the smoothed varigrams
save(vario1.sm, vario2.sm, file=paste0(output_dir, "Variograms_smooth_", cohort, "_", str_replace(region, "_ID", ""), ".RData"))
