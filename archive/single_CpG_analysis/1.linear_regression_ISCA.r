args <- commandArgs(TRUE) # option to read arguments from bash script
args[1]->cohort
args[2]->brain_region
args[3]->CpG_path
args[4]->pheno_path
args[5]->output_path
args[6]->group1
args[7]->group2


library(stringr) #load library
library(dplyr) #load library


read.csv(pheno_path)->pheno #load phenotype file
pheno[, paste0(brain_region, "_ID")]->rownames(pheno) #use the sample ID as row names

list_cov <- dir(CpG_path, pattern = "*_coveredCpGs.txt") # creates the list of all the files of interest in the directory

print(list_cov) #print the list of files so can check on log files


for (i in 1:length(list_cov)){ #for all the .cov files in the folder execute the following loop
	read.table(paste0(CpG_path, list_cov[i]), stringsAsFactors=FALSE)->temp_file #read current file
	
	temp_file[order(temp_file$chromosome, temp_file$start_position),]->temp_file #order by chromosome and position
	
	temp_file$CpG_position<-NA#create new column for CpG identifier
	paste0("chr", temp_file$chromosome, ":", temp_file$start_position)->temp_file$CpG_position #assign new column with chr:postion information
	
	assign(str_match(list_cov, paste0(cohort,"(.*?)",brain_region))[,1][i], temp_file) #assign the variable of the current sample to the data frame
	rm(list="temp_file") #remove te temporary data frame
	}
	


list_files<-str_match(list_cov, paste0(cohort,"(.*?)",brain_region))[,1] #list of all samples
print(paste("Row names pheno equals list of files:", identical(list_files, rownames(pheno)))) #check if pheno and list of files is oreres the same
pheno[list_files,]->pheno #reorder
print(paste("Row names pheno equals list of files after ordering:", identical(list_files, rownames(pheno)))) #check again



matrix_temp <- merge(get(list_files[1]), get(list_files[1+1]), by= "CpG_position", all.x= TRUE, all.y= TRUE) #merge first sample with next by CpG position, filling with NAs with the CpG isn't present in one of the samples


for(i in 2:(length(list_files)-1)){ #merge next sample with next by CpG position in a loop, filling with NAs with the CpG isn't present in one of the samples
	matrix_temp <- merge(matrix_temp, get(list_files[i+1]), by= "CpG_position", all.x= TRUE, all.y= TRUE)
}

print(paste0("Total number of CpGs in ", cohort, "_", brain_region, ": ", nrow(matrix_temp)))

matrix_temp[,grep("methylation_percentage", colnames(matrix_temp))]->matrix_perc #extract only methylation percentage for all samples from the merged matrix
rownames(matrix_perc)<-matrix_temp$CpG_position #use CpG positions as row names
colnames(matrix_perc)<-list_files #use list of samples as colnames
print(paste("Row names pheno equals column names matrix of methylation percentages:", identical(colnames(matrix_perc), rownames(pheno)))) #check if still identical with pheno

matrix_temp[,grep("count_methylated", colnames(matrix_temp))]->matrix_count_meth #extract only counts of methylated reads for all samples from the merged matrix
rownames(matrix_count_meth)<-matrix_temp$CpG_position #use CpG positions as row names
colnames(matrix_count_meth)<-list_files #use list of samples as colnames
print(paste("Row names pheno equals column names matrix of methylated counts:", identical(colnames(matrix_count_meth), rownames(pheno)))) #check if still identical with pheno


matrix_temp[,grep("count_unmethylated", colnames(matrix_temp))]->matrix_count_unmeth  #extract only counts of unmethylated reads for all samples from the merged matrix
rownames(matrix_count_unmeth)<-matrix_temp$CpG_position  #use CpG positions as row names
colnames(matrix_count_unmeth)<-list_files  #use list of samples as colnames
print(paste("Row names pheno equals column names matrix of unmethylated counts:", identical(colnames(matrix_count_unmeth), rownames(pheno)))) #check if still identical with pheno


which(pheno$Group==group1)->control_group # separate two groups
which(pheno$Group==group2)->cases_group


#keep CpGs only if there are complete observations in both groups
apply(matrix_perc[,control_group], 1, function(x) {length(which(!is.na(x)))} )->NAcontrol_group #sum NAs in each site in the control group
apply(matrix_perc[,cases_group], 1, function(x) {length(which(!is.na(x)))} )->NAcases_group #sum NAs in each site in the cases group
cbind(NAcontrol_group, NAcases_group)->NA_all #create a matrix with the sum of NAs per site in both controls and cases

matrix_perc[which(NA_all[,1]>=length(control_group) & NA_all[,2]>=length(cases_group)), ]->matrix_perc_more2 #exclude sites with at least 1 NA 
print(paste0("Number of CpGs with NA in ", cohort, "_", brain_region, ": ", nrow(matrix_perc)-nrow(matrix_perc_more2)))


#exclude if all 0 except for 1 in either group
apply(matrix_perc_more2[,control_group], 1, function(x) {length(which(x!=0))} )->zero_control_group #sum non-zeros in each site in the control group
apply(matrix_perc_more2[,cases_group], 1, function(x) {length(which(x!=0))} )->zero_cases_group #sum non-zeros in each site in the cases group
cbind(zero_control_group, zero_cases_group)->zeros_all #create a matrix with the sum of non-zeros per site in both controls and cases

matrix_perc_more2[which(zeros_all[,1]>=2 | zeros_all[,2]>=2), ]->matrix_perc_nozeros #keep sites with at least two samples non-zeros in one of the groups

print(paste0("Number of CpGs after removing zeros in ", cohort, "_", brain_region, ": ", nrow(matrix_perc_nozeros)))

#exclude if all 100 except for 1 in either group
apply(matrix_perc_nozeros[,control_group], 1, function(x) {length(which(x!=100))} )->hund_control_group #sum non-100s in each site in the control group
apply(matrix_perc_nozeros[,cases_group], 1, function(x) {length(which(x!=100))} )->hund_cases_group #sum non-100s in each site in the cases group
cbind(hund_control_group, hund_cases_group)->hunds_all #create a matrix with the sum of non-100s per site in both controls and cases

matrix_perc_nozeros[which(hunds_all[,1]>=2 | hunds_all[,2]>=2), ]->matrix_perc_no100 #keep sites with at least two samples non-100s in one of the groups

print(paste0("Number of CpGs after removing fully methylated in ", cohort, "_", brain_region, ": ", nrow(matrix_perc_no100)))



#average counts in each group
rowMeans(matrix_count_meth[rownames(matrix_perc_no100),control_group], na.rm=TRUE)->count_meth_control_group
rowMeans(matrix_count_meth[rownames(matrix_perc_no100),cases_group], na.rm=TRUE)->count_meth_cases_group
rowMeans(matrix_count_unmeth[rownames(matrix_perc_no100),control_group], na.rm=TRUE)->count_unmeth_control_group
rowMeans(matrix_count_unmeth[rownames(matrix_perc_no100),cases_group], na.rm=TRUE)->count_unmeth_cases_group



#regression model
group<-factor(as.character(pheno$Group), levels = c("cByJ", "cJ"))
cage<-factor(as.character(pheno$Cage))

model1<- apply(matrix_perc_no100,1,function(x){lm(x~group+cage)}) # regression model controlling for cage

#extract p values from model
pval<-lapply(model1,function(x){summary(x)$coefficients[2,"Pr(>|t|)"]})

t(as.data.frame(pval))->P.Value

#extract estimates

estimates<-lapply(model1,function(x){summary(x)$coefficients[2,"Estimate"]})

t(as.data.frame(estimates))->Estimates

cbind(Estimates, P.Value)->results
colnames(results)<-c("Estimate", "P.Value")

results[order(results[,"P.Value"]),]->results1


cbind(results, matrix_perc_no100, count_meth_control_group, count_unmeth_control_group, count_meth_cases_group, count_unmeth_cases_group)->results_counts
results_counts[order(results_counts[,"P.Value"]),]->results_counts1


write.csv(results1, paste0(output_path, "linear_regression_results", cohort, brain_region, ".csv"))
write.csv(results_counts1,  paste0(output_path, "linear_regression_results_withcounts", cohort, brain_region, ".csv"))
