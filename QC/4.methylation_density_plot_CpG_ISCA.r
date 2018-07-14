args <- commandArgs(TRUE) # option to read arguments from bash script
args[1]->cohort
args[2]->brain_region
args[3]->pdf_path

library(stringr) #load library
library(plyr) #load library


all_files <- list() # creates a list
list_cov <- dir(pattern = "*_coveredCpGs.txt") # creates the list of all the files with sites with > 10 reads in the directory. these were created with the 3.coverage_plot_CpG_ISCA.r script

print(list_cov) #print the list of files so can check on log files


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

ymax<-NA  #create an empty vector for all maximum frequencies in each dataset to then determine the maximum of the y-axis of the density plot bellow


for (k in 1:length(list_datasets)){ #for all the datasets execute the following loop
	get(ls(pattern=list_datasets[k]))->temp_data  #select 1 dataframe
	ymax<-na.omit(c(ymax, max(density(temp_data[,"methylation_percentage"])$y))) #maximum frequency of te current dataset
	rm(list="temp_data") #remove the temporary data frame
	}


colours_samples<-colorRampPalette(c("blue", "yellow"))(length(list_datasets)) #create a colour gradient


pdf(paste0(pdf_path, paste(cohort, brain_region, sep="_"), ".pdf")) #start pdf file
	par(mar=c(5.1, 4.1, 2, 6.8), xpd=TRUE) #graphical parameters, i.e. margins and allow writting outside plot
	par(yaxs="i") #start plot at origin
	get(ls(pattern=list_datasets[1]))->temp_data  #select 1st dataframe
	plot(density(temp_data[,"methylation_percentage"]), na.rm=T, main="",  lty=1, col=colours_samples[1], xlab="CpG methylation %",  ylim=c(0, max(ymax)+0.05)) #plot density of 1st dataset
	rm(list="temp_data") 
	for (k in 2:length(list_datasets)){ #for all the datasets minus the first one execute the following loop
		get(ls(pattern=list_datasets[k]))->temp_data  #select 1 dataframe
		lines(density(temp_data[,"methylation_percentage"], na.rm=T), col=colours_samples[k], lty=1) #plot density of current dataset
		rm(list="temp_data") #remove the temporary data frame
		}
	legend("topright", inset=c(-0.27,0), box.col="white", c(list_datasets), col=c(colours_samples), lty=1, cex=0.6) #legend of plot

dev.off() #close pdf file

 