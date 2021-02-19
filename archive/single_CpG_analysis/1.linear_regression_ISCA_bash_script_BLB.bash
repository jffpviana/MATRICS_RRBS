
#!/bin/sh
#PBS -V # export all environment variables to the batch job.
#PBS -q sq # submit to the serial queue
#PBS -l walltime=50:00:00 # Maximum wall time for the job.
#PBS -A Research_Project-129726 # research project to submit under. 
#PBS -l procs=1 # specify number of processors.
#PBS -m e -M j.f.viana@exeter.ac.uk # email me at job completion

module load R/3.3.1-foss-2016b #load R module


#####BLB_ACC samples####
#arguments:
cohort="BLB"
brain_region="ACC"
CpG_path="/gpfs/ts0/scratch/jfv203/MATRICS/BLB_ACC/bismark_alignment/"
pheno_path="/gpfs/ts0/scratch/jfv203/MATRICS/BLB_ACC/phenotype_files/BLBbrains_pheno_ACC.csv"
output_path="/gpfs/ts0/scratch/jfv203/MATRICS/BLB_ACC/analysis/"
group1="cByJ"
group2="cJ"

Rscript /gpfs/ts0/projects/Research_Project-129726/MATRICS/general_scripts/single_site_analysis/1.linear_regression_ISCA.r $cohort $brain_region $CpG_path $pheno_path $output_path $group1 $group2




#####BLB_MCC samples####
#arguments:
cohort="BLB"
brain_region="MCC"
CpG_path="/gpfs/ts0/scratch/jfv203/MATRICS/BLB_MCC/bismark_alignment/"
pheno_path="/gpfs/ts0/scratch/jfv203/MATRICS/BLB_MCC/phenotype_files/BLBbrains_pheno_MCC.csv"
output_path="/gpfs/ts0/scratch/jfv203/MATRICS/BLB_MCC/analysis/"
group1="cByJ"
group2="cJ"

Rscript /gpfs/ts0/projects/Research_Project-129726/MATRICS/general_scripts/single_site_analysis/1.linear_regression_ISCA.r $cohort $brain_region $CpG_path $pheno_path $output_path $group1 $group2





#####BLB_VMH samples####
#arguments:
cohort="BLB"
brain_region="VMH"
CpG_path="/gpfs/ts0/scratch/jfv203/MATRICS/BLB_VMH/bismark_alignment/"
pheno_path="/gpfs/ts0/scratch/jfv203/MATRICS/BLB_VMH/phenotype_files/BLBbrains_pheno_VMH.csv"
output_path="/gpfs/ts0/scratch/jfv203/MATRICS/BLB_VMH/analysis/"
group1="cByJ"
group2="cJ"

Rscript /gpfs/ts0/projects/Research_Project-129726/MATRICS/general_scripts/single_site_analysis/1.linear_regression_ISCA.r $cohort $brain_region $CpG_path $pheno_path $output_path $group1 $group2


