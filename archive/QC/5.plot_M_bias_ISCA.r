args <- commandArgs(TRUE) # option to read arguments from bash script
args[1]->cohort
args[2]->brain_region
args[3]->pdf_path

library(stringr) #load library


all_files <- list() # creates a list
list_files <- dir(pattern = "*.M-bias.txt") # creates the list of all the relevant files in the directory

print(list_files) #print the list of .cov files so can check on log files


for (i in 1:length(list_files)){ #for all the relevant files in the folder execute the following loop
	read.table(list_files[i], skip = 3, nrow = 50)->temp_file_CpG #read current file, only rows corresponding to CpG context
	c("position", "count_methylated", "count_unmethylated", "perc_methylation", "coverage")->colnames(temp_file_CpG)  #attribute these column names

	if(is.na(str_match(list_files,paste0(cohort,"(.*?)",brain_region))[1,1])){ #if the sample names are not the cohort+sample+brain region, then find the sequencing identifier and use that
	assign(paste0(str_match(list_files,paste0("S","([01-9]*[01-9])"))[,1][i], "_CpG"), temp_file_CpG)
	
		}else{
		assign(paste0(str_match(list_files,paste0(cohort,"(.*?)",brain_region))[,1][i], "_CpG"), temp_file_CpG) #if the sample names ARE the cohort+sample+brain region use that
		}	
	
	rm(list="temp_file_CpG") #remove the temporary data frame

	read.table(list_files[i], skip = 57, nrow = 50)->temp_file_CHG #read current file, only rows corresponding to CHG context
	c("position", "count_methylated", "count_unmethylated", "perc_methylation", "coverage")->colnames(temp_file_CHG)  #attribute these column names
	if(is.na(str_match(list_files,paste0(cohort,"(.*?)",brain_region))[1,1])){ #if the sample names are not the cohort+sample+brain region, then find the sequencing identifier and use that
	assign(paste0(str_match(list_files,paste0("S","([01-9]*[01-9])"))[,1][i], "_CHG"), temp_file_CHG)
	
		}else{
		assign(paste0(str_match(list_files,paste0(cohort,"(.*?)",brain_region))[,1][i], "_CHG"), temp_file_CHG) #if the sample names ARE the cohort+sample+brain region use that
		}
	rm(list="temp_file_CHG") #remove the temporary data frame	
	
	read.table(list_files[i], skip = 111, nrow = 50)->temp_file_CHH #read current file, only rows corresponding to CHH context
	c("position", "count_methylated", "count_unmethylated", "perc_methylation", "coverage")->colnames(temp_file_CHH)  #attribute these column names
	if(is.na(str_match(list_files,paste0(cohort,"(.*?)",brain_region))[1,1])){ #if the sample names are not the cohort+sample+brain region, then find the sequencing identifier and use that
	assign(paste0(str_match(list_files,paste0("S","([01-9]*[01-9])"))[,1][i], "_CHH"), temp_file_CHH)
	
		}else{
		assign(paste0(str_match(list_files,paste0(cohort,"(.*?)",brain_region))[,1][i], "_CHH"), temp_file_CHH) #if the sample names ARE the cohort+sample+brain region use that
		}
	rm(list="temp_file_CHH") 
	}



#list of data frames of CpG context(each sample)
if(is.na(str_match(ls(),paste0(cohort,"(.*?)",brain_region))[1,1])){ #if the sample names are not the cohort+sample+brain region, then find the sequencing identifier and use that
	na.omit(str_match(ls(),paste0("S","([01-9]*[01-9])")))[,1]->list_datasets_CpG 
	
	}else{
	na.omit(str_match(ls(),paste0(cohort,"(.*?)",brain_region, "_CpG")))[,1]->list_datasets_CpG #if the sample names ARE the cohort+sample+brain region use that
	}

	#list of data frames of CpG context(each sample)
if(is.na(str_match(ls(),paste0(cohort,"(.*?)",brain_region))[1,1])){ #if the sample names are not the cohort+sample+brain region, then find the sequencing identifier and use that
	na.omit(str_match(ls(),paste0("S","([01-9]*[01-9])")))[,1]->list_datasets_CHG 
	
	}else{
	na.omit(str_match(ls(),paste0(cohort,"(.*?)",brain_region, "_CHG")))[,1]->list_datasets_CHG #if the sample names ARE the cohort+sample+brain region use that
	}

	#list of data frames of CHH context(each sample)
if(is.na(str_match(ls(),paste0(cohort,"(.*?)",brain_region))[1,1])){ #if the sample names are not the cohort+sample+brain region, then find the sequencing identifier and use that
	na.omit(str_match(ls(),paste0("S","([01-9]*[01-9])")))[,1]->list_datasets_CHH
	
	}else{
	na.omit(str_match(ls(),paste0(cohort,"(.*?)",brain_region, "_CHH")))[,1]->list_datasets_CHH #if the sample names ARE the cohort+sample+brain region use that
	}

for(k in 1:length(list_datasets_CpG)){ #loop through the list of samples
	get(ls(pattern=list_datasets_CpG[k]))->temp_data_CpG #select 1 CpG dataframe
	get(ls(pattern=list_datasets_CHG[k]))->temp_data_CHG #select corresponding CHG dataframe
	get(ls(pattern=list_datasets_CHH[k]))->temp_data_CHH #select corresponding CHG dataframe
 
	
	pdf(paste0(pdf_path, str_match(list_datasets_CpG, paste0(cohort,"(.*?)",brain_region))[,1][k],".pdf")) #start pdf file
	par(mar=c(5.1, 4.1, 2, 6.8), xpd=TRUE) #graphical parameters, i.e. margins and allow writting outside plot
	plot(temp_data_CpG[, "position"], temp_data_CpG[, "perc_methylation"], type="l", col="red", ylim=c(0,100), ylab="% DNA methylation", xlab="Position") #plot methylation percantage for every position in CpG reads
	lines(temp_data_CHG[, "position"], temp_data_CHG[, "perc_methylation"],  col="green")  #plot methylation percantage for every position in CHG reads
	lines(temp_data_CHH[, "position"], temp_data_CHH[, "perc_methylation"],  col="blue")  #plot methylation percantage for every position in CHH reads

	legend("topright", inset=c(-0.27,0), box.col="white", c("Total CpG calls","Total CHG calls","Total CHH calls"), col=c("red4", " dark green", "dark blue"), pch=20, cex=0.6) #legend of plot

	dev.off() #close pdf file
}

 