
#!/bin/sh
#PBS -V # export all environment variables to the batch job.
#PBS -q sq # submit to the serial queue
#PBS -l walltime=50:00:00 # Maximum wall time for the job.
#PBS -A Research_Project-129726 # research project to submit under. 
#PBS -l procs=1 # specify number of processors.
#PBS -m e -M j.f.viana@exeter.ac.uk # email me at job completion

module load R/3.3.1-foss-2016b #load R module


#####CTR_N PFC samples####
#arguments:
cohort="CTR_N"
brain_region="PFC"
output_path="/gpfs/ts0/projects/Research_Project-129726/MATRICS/CTR_N_PFC/analysis/"
pheno_path="/gpfs/ts0/projects/Research_Project-129726/MATRICS/CTR_N_PFC/phenotype_files/CTR_Nbrains_pheno_PFC.csv"
softPower=14 #pick the soft-thresholding power based on the plot created using the 1.calculate_soft_power.r script

Rscript /gpfs/ts0/projects/Research_Project-129726/MATRICS/general_scripts/network_analysis/2.generate_network.r $cohort $brain_region $output_path $pheno_path $softPower

#####CTR_N HC samples####
#arguments:
cohort="CTR_N"
brain_region="HC"
output_path="/gpfs/ts0/projects/Research_Project-129726/MATRICS/CTR_N_HC/analysis/"
pheno_path="/gpfs/ts0/projects/Research_Project-129726/MATRICS/CTR_N_HC/phenotype_files/CTR_Nbrains_pheno_HC.csv"
softPower=10 #pick the soft-thresholding power based on the plot created using the 1.calculate_soft_power.r script

Rscript /gpfs/ts0/projects/Research_Project-129726/MATRICS/general_scripts/network_analysis/2.generate_network.r $cohort $brain_region $output_path $pheno_path $softPower


#####CTR_N HPT samples####
#arguments:
cohort="CTR_N"
brain_region="HPT"
output_path="/gpfs/ts0/projects/Research_Project-129726/MATRICS/CTR_N_HPT/analysis/"
pheno_path="/gpfs/ts0/projects/Research_Project-129726/MATRICS/CTR_N_HPT/phenotype_files/CTR_Nbrains_pheno_HPT.csv"
softPower=10 #pick the soft-thresholding power based on the plot created using the 1.calculate_soft_power.r script

Rscript /gpfs/ts0/projects/Research_Project-129726/MATRICS/general_scripts/network_analysis/2.generate_network.r $cohort $brain_region $output_path $pheno_path $softPower
