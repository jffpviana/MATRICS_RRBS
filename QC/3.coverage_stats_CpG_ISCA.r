args <- commandArgs(TRUE) # option to read arguments from bash script
args[1]->cohort
args[2]->brain_region
args[3]->save_csv


library(stringr) #load library
library(plyr) #load library


all_files <- list() # creates a list
list_cov <- dir(pattern = "*.bismark.cov") # creates the list of all the cov files in the directory

print(list_cov) #print the list of .cov files so can check on log files


for (i in 1:length(list_cov)){ #for all the .cov files in the folder execute the following loop
	read.table(list_cov[i])->temp_file #read current file
	c("chromosome", "start_position", "end_position", "methylation_percentage", "count_methylated", "count_unmethylated")->colnames(temp_file) #attribute these column names
	if(is.na(str_match(list_cov,paste0(cohort,"(.*?)",brain_region))[1,1])){ #if the sample names are not the cohort+sample+brain region, then find the sequencing identifier and use that
	assign(str_match(list_cov,paste0("S","([01-9]*[01-9])"))[,1][i], temp_file)
	
		}else{
		assign(str_match(list_cov,paste0(cohort,"(.*?)",brain_region))[,1][i], temp_file) #if the sample names ARE the cohort+sample+brain region use that
		}
	rm(list="temp_file") #remove te temporary data frame
	}
	

	 #list of data frames (each sample)
if(is.na(str_match(list_cov,paste0(cohort,"(.*?)",brain_region))[1,1])){ #if the sample names are not the cohort+sample+brain region, then find the sequencing identifier and use that
	str_match(list_cov,paste0("S","([01-9]*[01-9])"))[,1]->list_datasets
	
	}else{
	str_match(list_cov,paste0(cohort,"(.*?)",brain_region))[,1]->list_datasets #if the sample names ARE the cohort+sample+brain region use that
	}


summary.id<-matrix(data = NA, nrow = length(list_datasets), ncol = 9) #matrix for summary statistics of coverage for each sample
colnames(summary.id)<-c("Number_of_Sites", "Min_Read_Depth", "1st_Quantile_Read_Depth", "Mean_Read_Depth", "Median_Read_Depth", "3rd_Quantile_Read_Depth", "Max_Read_Depth", "Sites:Read_Depth_10", "Percentage_Sites:Read_Depth_10") #column names for the matrix
rownames(summary.id)<-list_datasets #row names will the the samples names

#remove spike-ins and low coverage reads - minumum of coverage: 10 reads - save the files 
for(k in 1:length(list_datasets)){ #loop through the list of samples
	get(ls(pattern=list_datasets[k]))->temp_data #select 1 dataframe
	temp_data[-grep("Seq", temp_data$chromosome ),]->spikes #exclude spike-ins from sample
	summary.id[k,1]<-nrow(spikes) #extract Number_of_Sites 
	summary.id[k,2]<-min((spikes[,5]+spikes[,6])) #extract Min_Read_Depth
	summary.id[k,3]<-quantile((spikes[,5]+spikes[,6]), 0.25) #extract 1st_Quantile_Read_Depth
	summary.id[k,4]<-mean((spikes[,5]+spikes[,6])) #extract Mean_Read_Depth
	summary.id[k,5]<-median((spikes[,5]+spikes[,6])) #extract Median_Read_Depth
	summary.id[k,6]<-quantile((spikes[,5]+spikes[,6]), 0.75) #extract 3st_Quantile_Read_Depth
	summary.id[k,7]<-max((spikes[,5]+spikes[,6])) #extract Max_Read_Depth
	summary.id[k,8]<-length(which((spikes[,5]+spikes[,6]) >= 10)) #extract Sites:Read_Depth_10
	summary.id[k,9]<-length(which((spikes[,5]+spikes[,6]) >= 10))/nrow(spikes)*100 #extract Percentage_Sites:Read_Depth_10
	
	rm(list=c("temp_data", "spikes")) # remove unecessary objects 
}


write.csv(summary.id, paste0(save_csv, paste(cohort, brain_region, sep="_"), ".csv"))









