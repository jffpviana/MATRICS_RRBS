library(data.table)
library(stringr)
library(ggplot2)
library(ggpubr)

input_dir <- "/rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTR/HPT/methylation/"
plots_dir <- "/rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTR/HPT/QC/plots/"


list_datasets <- list() # creates a list
list_cov <- dir(path=input_dir, pattern ="*.cov") # creates the list of all .cov files in the directory

print(list_cov) #print the list of .cov files so can check on log files


for (i in 1:length(list_cov)){ #for all the .cov files in the folder execute the following loop
	fread(paste0(input_dir, list_cov[i]))->temp_file #read current file
	c("chromosome", "start_position", "end_position", "methylation_percentage", "count_methylated", "count_unmethylated")->colnames(temp_file) #attribute these column names
	temp_file -> list_datasets[[i]] #places the current data frame in the corresponding position of the empty list
 	names(list_datasets)[[i]] <- list_cov[i] #name the current element of the list
}


for(k in 1:length(list_cov)){ #loop through the list of samples
	as.data.frame(list_datasets[[k]], stringsAsFactors=FALSE)->temp_data #select 1 dataframe
	temp_data[grep("RRBS_methylated_control", temp_data$chromosome),]->spikes_meth #extract coverage of meth spike-ins
	temp_data[grep("RRBS_unmethylated_control", temp_data$chromosome),]->spikes_unmeth #extract coverage of unmeth spike-ins

	pos_factor_meth<-factor(as.character(spikes_meth$start_position), levels=spikes_meth$start_position)
	pos_factor_unmeth<-factor(as.character(spikes_unmeth$start_position), levels=spikes_unmeth$start_position)

	pdf(paste0(plots_dir, "spikeins_coverage_read", list_cov[k],".pdf")) #start pdf file
	p1<-ggplot(data=spikes_meth, aes(x=pos_factor_meth, y=(count_methylated + count_unmethylated))) +
	  geom_bar(stat="identity", color="dark blue", fill="dark blue") + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_blank()) + labs(title = sub(".cov", "" ,list_cov[k]), x = "Position in read", y = "Number of reads")

	p2<-ggplot(data=spikes_unmeth, aes(x=pos_factor_unmeth, y=(count_methylated + count_unmethylated))) +
		  geom_bar(stat="identity", color="dark green", fill="dark green") + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_blank()) + labs(x = "Position in read", y = "Number of reads")

		ggarrange(p1, p2, labels = c("A", "B"), ncol = 1, nrow = 2)

	dev.off() #close pdf file
}
