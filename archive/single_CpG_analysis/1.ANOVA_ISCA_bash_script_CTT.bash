
#!/bin/sh
#PBS -V # export all environment variables to the batch job.
#PBS -q sq # submit to the serial queue
#PBS -l walltime=50:00:00 # Maximum wall time for the job.
#PBS -A Research_Project-129726 # research project to submit under. 
#PBS -l procs=1 # specify number of processors.
#PBS -m e -M j.f.viana@exeter.ac.uk # email me at job completion

module load R/3.3.1-foss-2016b #load R module


#####CTT_PFC samples####
#arguments:
cohort="CTT"
brain_region="PFC"
CpG_path="/gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_PFC/bismark_alignment/"
pheno_path="/gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_PFC/phenotype_files/phenoCTT.csv"
output_path="/gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_PFC/analysis/"
group1="control"
group2="low"
group3="high"

Rscript /gpfs/ts0/projects/Research_Project-129726/MATRICS/general_scripts/single_site_analysis/1.ANOVA_ISCA.r $cohort $brain_region $CpG_path $pheno_path $output_path $group1 $group2 $group3




#####CTT_HC samples####
#arguments:
cohort="CTT"
brain_region="HC"
CpG_path="/gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_HC/bismark_alignment/"
pheno_path="/gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_HC/phenotype_files/phenoCTT.csv"
output_path="/gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_HC/analysis/"
group1="control"
group2="low"
group3="high"


Rscript /gpfs/ts0/projects/Research_Project-129726/MATRICS/general_scripts/single_site_analysis/1.ANOVA_ISCA.r $cohort $brain_region $CpG_path $pheno_path $output_path $group1 $group2





#####CTT_HPT samples####
#arguments:
cohort="CTT"
brain_region="HPT"
CpG_path="/gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_HPT/bismark_alignment/"
pheno_path="/gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_HPT/phenotype_files/phenoCTT.csv"
output_path="/gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_HPT/analysis/"
group1="control"
group2="low"
group3="high"

Rscript /gpfs/ts0/projects/Research_Project-129726/MATRICS/general_scripts/single_site_analysis/1.ANOVA_ISCA.r $cohort $brain_region $CpG_path $pheno_path $output_path $group1 $group2


