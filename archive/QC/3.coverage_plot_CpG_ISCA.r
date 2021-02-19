args <- commandArgs(TRUE) # option to read arguments from bash script
args[1]->cohort
args[2]->brain_region
args[3]->save_path
args[4]->pdf_path

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

coverage_before<-NA #empty vector for coverage of CpGs in one sample before excluding low coverage reads
coverage_after<-NA #empty vector for coverage of CpGs in one sample after excluding low coverage reads

#remove spike-ins and low coverage reads - minumum of coverage: 10 reads - save the files 
for(k in 1:length(list_datasets)){ #loop through the list of samples
	get(ls(pattern=list_datasets[k]))->temp_data #select 1 dataframe
	temp_data[-grep("Seq", temp_data$chromosome ),]->spikes #exclude spike-ins from sample
	coverage_before<-na.omit(c(coverage_before, nrow(spikes))) #extract coverage before excluding low coverage reads
	spikes[which(spikes$count_methylated+spikes$count_unmethylated>10),]->spikes_good_cov #select only CpG with a at least 10 total reads (unmethylated+methylated)
	coverage_after<-na.omit(c(coverage_after, nrow(spikes_good_cov))) #extract coverage after excluding low coverage reads
	assign(paste0(list_datasets[k], "_2"), spikes_good_cov) #assign the variable of the current sample to the data frame
	write.table(assign(paste0(list_datasets[k], "_2"), spikes_good_cov), paste0(save_path, list_datasets[k], "_coveredCpGs.txt")) #save the well covered CpGs on he bismark_alignment folder of that cohort
	rm(list=c("temp_data", "spikes", "spikes_good_cov")) # remove unecessary objects 
}



colours_samples<-colorRampPalette(c("blue", "yellow"))(length(list_datasets)) #create a colour gradient

pdf(paste0(pdf_path, paste(cohort, brain_region, sep="_"), ".pdf")) #start pdf file
	options(scipen=5) #specify number of digits allowed in R
	
	ymax<-round(max(rbind(coverage_before, coverage_after)), digits=-(nchar(max(rbind(coverage_before, coverage_after)))-1)) #determine y-axis maximum
	
	par(mar=c(7, 8, 2, 6.5), xpd=TRUE) #graphical parameters, i.e. margins and allow writting outside plot
	barplot(rbind(coverage_before, coverage_after), ylab="Coverage", names.arg=list_datasets, beside=TRUE, las=2, col=c("red4", "coral"),  cex.names=0.9, ylim=c(0,ymax), mgp = c(5, 1, 0)) #plot mans of unmethylated and methylated spike-ins for each sample.
	legend("topright", inset=c(-0.27,0), box.col="white", c("All CpGs", ">10 reads CpGs"), pch=c(15, 15), cex=0.6, col=c("red4", "coral")) #legend of plot

dev.off() # close pdf

