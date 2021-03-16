args <- commandArgs(TRUE) # option to read arguments from bash script
args[1]->cohort
args[2]->region
args[3]->pdf_path




#set cohort and region specific options
cohort <- "BLB"
region <- "ACC"
input_dir <- "/rds/projects/v/vianaj-genomics-brain-development/MATRICS/BLB/ACC/methylation/"
output_dir <- "/rds/projects/v/vianaj-genomics-brain-development/MATRICS/BLB/ACC/analysis/"
sample_annotation <- "/rds/projects/v/vianaj-genomics-brain-development/MATRICS/BLB/ACC/BLBACC_pheno.csv"
analysis_name <- paste0(cohort, "_", region)


library(stringr) #load library



list_datasets <- list() # creates a list
list_cov <- dir(path=input_dirpattern ="*.cov") # creates the list of all the cov files in the directory

print(list_cov) #print the list of .cov files so can check on log files


for (i in 1:length(list_cov)){ #for all the .cov files in the folder execute the following loop
	read.table(list_cov[i])->temp_file #read current file
	c("chromosome", "start_position", "end_position", "methylation_percentage", "count_methylated", "count_unmethylated")->colnames(temp_file) #attribute these column names
	temp_file -> list_datasets[[i]]
	names(list_datasets)[[i]] <- list_cov[i]
}


for(k in 1:length(list_cov)){ #loop through the list of samples
	as.data.frame(list_datasets[[k]], stringsAsFactors=FALSE)->temp_data #select 1 dataframe
	temp_data[grep("RRBS_methylated_control", temp_data$chromosome),]->spikes_meth #extract coverage of meth spike-ins
	temp_data[grep("RRBS_unmethylated_control", temp_data$chromosome),]->spikes_unmeth #extract coverage of unmeth spike-ins

	pdf(paste0(output_path, list_datasets[k],".pdf")) #start pdf file
	par(mar=c(5.1, 4.1, 2, 6.8), xpd=TRUE) #graphical parameters, i.e. margins and allow writting outside plot
	plot(spikes[c(grep("Seq1", spikes$chromosome)),2], spikes[c(grep("Seq1", spikes$chromosome)),4],pch=17, ylim=c(-1,101), col="light blue", xlim=c(1, 134), xlab="Position in sequence", ylab="% DNA methylation") #plot spike-in sequence one (unmethylated forward)
	points(spikes[c(grep("Seq2", spikes$chromosome)),2], spikes[c(grep("Seq2", spikes$chromosome)),4],col="dark blue", pch=17) #plot spike-in sequence two (unmethylated reverse)

	points(spikes[c(grep("Seq5", spikes$chromosome)),2], spikes[c(grep("Seq5", spikes$chromosome)),4],col="light green", pch=20)  #plot spike-in sequence three (methylated forward)

	points(spikes[c(grep("Seq6", spikes$chromosome)),2], spikes[c(grep("Seq6", spikes$chromosome)),4],col="dark green", pch=20) #plot spike-in sequence four (methylated reverse)

	legend("topright", inset=c(-0.27,0), box.col="white", c("Unmethylated forward","Unmethylated reverse","Methylated forward","Methylated reverse"), col=c("light blue", "dark blue", "light green", "dark green"), pch=20, cex=0.6) #legend of plot

	dev.off() #close pdf file
}
