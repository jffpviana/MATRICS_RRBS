args <- commandArgs(TRUE) # option to read arguments from bash script
args[1]->cohort
args[2]->brain_region
args[3]->output_path

read.table(paste0(output_path, "CpG_regions_txt_", cohort, brain_region, ".txt"), header=TRUE) -> results #read results file from brain regio 

-(log10(results$P.Value))->minuslogpvales #log trasnform the p-values

o <- sort(minuslogpvales, decreasing=F) #sort p-values crescent order
e <- sort(-log10(ppoints(length(results$P.Value)))) #calculate expected quantiles

pdf(paste0(output_path, "QQplot_", cohort, brain_region, ".pdf"))
plot(e,o,xlab = "Expected quantiles", ylab = "Observed quantiles",  ylim = c(0, max(o)), xlim = c(0,max(e)), pch=".", col="red")
abline(a =0, b = 1)

dev.off()
