args <- commandArgs(TRUE) # option to read arguments from bash script
args[1]->cohort
args[2]->brain_region
args[3]->pdf_path

library(stringr) #load library


read.csv("/gpfs/ts0/projects/Research_Project-129726/MATRICS/general_files/spikein_positions.csv")->spike_positions #load file with all spike-in positions

length(which(spike_positions$Seq_code=="Seq1"))+length(which(spike_positions$Seq_code=="Seq_2"))->unmeth_position #count all the unmethylated positions on the spike-in unmethylated control
length(which(spike_positions$Seq_code=="Seq_5"))+length(which(spike_positions$Seq_code=="Seq_6"))->meth_position #count all the methylated positions on the spike-in methylated control


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

covUn<-NA #empty vector for percentage of unmethylated spike-ins covered in one sample
covMe<-NA #empty vector for percentage of methylated spike-ins covered in one sample

for(k in 1:length(list_datasets)){ #loop through the list of samples
	get(ls(pattern=list_datasets[k]))->temp_data #select 1 dataframe
	temp_data[grep("Seq", temp_data$chromosome ),]->spikes #extract coverage of spike-ins
	nrow(spikes[c(grep("Seq1", spikes$chromosome),grep("Seq2", spikes$chromosome)),])->num_um_spikes #number of covered positions in the unmethylated spike-ins in this samples
	nrow(spikes[c(grep("Seq5", spikes$chromosome),grep("Seq6", spikes$chromosome)),])->num_me_spikes #number of covered positions in the methylated spike-ins in this samples
	
	covUn<-na.omit(c(covUn, num_um_spikes/unmeth_position*100)) #calculate mean reads of unmethylated spike-ins in current sample
	covMe<-na.omit(c(covMe, num_me_spikes/meth_position*100)) #calculate mean reads of methylated spike-ins in current sample	
}

colours_samples<-colorRampPalette(c("blue", "yellow"))(length(list_datasets)) #create a colour gradient

pdf(paste0(pdf_path, paste(cohort, brain_region, sep="_"), ".pdf")) #start pdf file
	par(mar=c(7, 4.1, 2, 6.8), xpd=TRUE) #graphical parameters, i.e. margins and allow writting outside plot
	barplot(rbind(covUn, covMe), ylab="% positions covered", names.arg=list_datasets, beside=TRUE, las=2, col=c("dark blue", "dark green"),  cex.names=0.9, ylim=c(0,100)) #plot mans of unmethylated and methylated spike-ins for each sample.
	legend("topright", inset=c(-0.27,0), box.col="white", c("Unmethylated spike-ins", "Methylated spike-ins"), pch=c(15, 15), cex=0.6, col=c("dark blue", "dark green")) #legend of plot

dev.off() # close pdf






