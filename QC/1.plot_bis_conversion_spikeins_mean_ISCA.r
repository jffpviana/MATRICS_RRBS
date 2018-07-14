args <- commandArgs(TRUE) # option to read arguments from bash script
args[1]->cohort
args[2]->brain_region
args[3]->pdf_path2

library(stringr) #load library


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

meanUn<-NA #empty vector for mean reads across unmethylated spike-ins in one sample
meanMe<-NA #empty vector for mean reads across methylated spike-ins in one sample

for(k in 1:length(list_datasets)){ #loop through the list of samples
	get(ls(pattern=list_datasets[k]))->temp_data #select 1 dataframe
	temp_data[grep("Seq", temp_data$chromosome ),]->spikes #extract coverage of spike-ins
	meanUn<-na.omit(c(meanUn, mean(spikes[c(grep("Seq1", spikes$chromosome),grep("Seq2", spikes$chromosome)),4]))) #calculate mean reads of unmethylated spike-ins in current sample
	meanMe<-na.omit(c(meanMe, mean(spikes[c(grep("Seq5", spikes$chromosome),grep("Seq6", spikes$chromosome)),4]))) #calculate mean reads of methylated spike-ins in current sample
}

colours_samples<-colorRampPalette(c("blue", "yellow"))(length(list_datasets)) #create a colour gradient

pdf(paste0(pdf_path2, paste(cohort, brain_region, sep="_"), ".pdf")) #start pdf file
	par(mar=c(5.1, 4.1, 2, 6.8), xpd=TRUE) #graphical parameters, i.e. margins and allow writting outside plot
	plot(c(meanUn, meanMe), col=c(colours_samples,colours_samples), pch=c(rep(17, length(meanUn)), rep(20, length(meanMe))),  xlab="Position in sequence", ylab="Mean % DNA methylation") #plot mans of unmethylated and methylated spike-ins for each sample.
	legend("topright", inset=c(-0.27,0), box.col="white", c(list_datasets, "Unmethylated spike-ins", "Methylated spike-ins"), col=c(colours_samples, "black", "black"), pch=c(rep(1, length(list_datasets)), 17, 20), cex=0.6) #legend of plot

dev.off() # close pdf