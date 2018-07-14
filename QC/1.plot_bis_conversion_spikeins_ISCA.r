args <- commandArgs(TRUE) # option to read arguments from bash script
args[1]->cohort
args[2]->brain_region
args[3]->pdf_path

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


for(k in 1:length(list_datasets)){ #loop through the list of samples
	get(ls(pattern=list_datasets[k]))->temp_data #select 1 dataframe
	temp_data[grep("Seq", temp_data$chromosome ),]->spikes #extract coverage of spike-ins
	pdf(paste0(pdf_path, list_datasets[k],".pdf")) #start pdf file
	par(mar=c(5.1, 4.1, 2, 6.8), xpd=TRUE) #graphical parameters, i.e. margins and allow writting outside plot
	plot(spikes[c(grep("Seq1", spikes$chromosome)),2], spikes[c(grep("Seq1", spikes$chromosome)),4],pch=17, ylim=c(-1,101), col="light blue", xlim=c(1, 134), xlab="Position in sequence", ylab="% DNA methylation") #plot spike-in sequence one (unmethylated forward)
	points(spikes[c(grep("Seq2", spikes$chromosome)),2], spikes[c(grep("Seq2", spikes$chromosome)),4],col="dark blue", pch=17) #plot spike-in sequence two (unmethylated reverse)

	points(spikes[c(grep("Seq5", spikes$chromosome)),2], spikes[c(grep("Seq5", spikes$chromosome)),4],col="light green", pch=20)  #plot spike-in sequence three (methylated forward)

	points(spikes[c(grep("Seq6", spikes$chromosome)),2], spikes[c(grep("Seq6", spikes$chromosome)),4],col="dark green", pch=20) #plot spike-in sequence four (methylated reverse)

	legend("topright", inset=c(-0.27,0), box.col="white", c("Unmethylated forward","Unmethylated reverse","Methylated forward","Methylated reverse"), col=c("light blue", "dark blue", "light green", "dark green"), pch=20, cex=0.6) #legend of plot

	dev.off() #close pdf file
}

 