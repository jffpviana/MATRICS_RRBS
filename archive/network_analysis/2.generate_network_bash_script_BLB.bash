
#!/bin/sh
#PBS -V # export all environment variables to the batch job.
#PBS -q sq # submit to the serial queue
#PBS -l walltime=50:00:00 # Maximum wall time for the job.
#PBS -A Research_Project-129726 # research project to submit under. 
#PBS -l procs=1 # specify number of processors.
#PBS -m e -M j.f.viana@exeter.ac.uk # email me at job completion

module load R/3.3.1-foss-2016b #load R module


#####BLB ACC samples####
#arguments:
cohort="BLB"
brain_region="ACC"
output_path="/gpfs/ts0/projects/Research_Project-129726/MATRICS/BLB_ACC/analysis/"
pheno_path="/gpfs/ts0/projects/Research_Project-129726/MATRICS/BLB_ACC/phenotype_files/BLBbrains_pheno_ACC.csv"
softPower=14 #pick the soft-thresholding power based on the plot created using the 1.calculate_soft_power.r script

Rscript /gpfs/ts0/projects/Research_Project-129726/MATRICS/general_scripts/network_analysis/2.generate_network.r $cohort $brain_region $output_path $pheno_path $softPower

#####BLB ACC samples####
#arguments:
cohort="BLB"
brain_region="MCC"
output_path="/gpfs/ts0/projects/Research_Project-129726/MATRICS/BLB_MCC/analysis/"
pheno_path="/gpfs/ts0/projects/Research_Project-129726/MATRICS/BLB_MCC/phenotype_files/BLBbrains_pheno_MCC.csv"
softPower=9 #pick the soft-thresholding power based on the plot created using the 1.calculate_soft_power.r script

Rscript /gpfs/ts0/projects/Research_Project-129726/MATRICS/general_scripts/network_analysis/2.generate_network.r $cohort $brain_region $output_path $pheno_path $softPower


#####BLB ACC samples####
#arguments:
cohort="BLB"
brain_region="VMH"
output_path="/gpfs/ts0/projects/Research_Project-129726/MATRICS/BLB_VMH/analysis/"
pheno_path="/gpfs/ts0/projects/Research_Project-129726/MATRICS/BLB_VMH/phenotype_files/BLBbrains_pheno_VMH.csv"
softPower=14 #pick the soft-thresholding power based on the plot created using the 1.calculate_soft_power.r script

Rscript /gpfs/ts0/projects/Research_Project-129726/MATRICS/general_scripts/network_analysis/2.generate_network.r $cohort $brain_region $output_path $pheno_path $softPower
