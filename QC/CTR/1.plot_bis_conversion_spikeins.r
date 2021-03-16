args <- commandArgs(TRUE) # option to read arguments from bash script
args[1] -> input_dir
args[2] -> plots_dir


library(data.table)
library(stringr) #load library


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

	pdf(paste0(plots_dir, "spikeins_cov", list_cov[k],".pdf")) #start pdf file
	par(mar=c(5.1, 4.1, 2, 6.8), xpd=FALSE) #graphical parameters, i.e. margins and allow writting outside plot
	plot(spikes_unmeth$start_position, spikes_unmeth$methylation_percentage, pch=16, ylim=c(-1,101), col="dark blue", xlim=c(1, max(c(spikes_meth$start_position, spikes_unmeth$start_position))+1), xlab="Position in sequence", ylab="% DNA methylation") #plot spike-in sequence (unmethylated)
	abline(h=10, col="red")
	abline(h=90, col="red")
	points(spikes_meth$start_position, spikes_meth$methylation_percentage ,col="dark green", pch=16) #plot spike-in sequence (methylated)
	par(xpd=TRUE)
	legend("topright", inset=c(-0.27,0), box.col="white", c("Unmethylated control", "Methylated control"), col=c("dark blue", "dark green"), pch=16, cex=0.6) #legend of plot

	dev.off() #close pdf file
}
