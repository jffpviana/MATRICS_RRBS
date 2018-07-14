
#!/bin/sh
#PBS -V # export all environment variables to the batch job.
#PBS -q sq # submit to the serial queue
#PBS -l walltime=50:00:00 # Maximum wall time for the job.
#PBS -A Research_Project-129726 # research project to submit under. 
#PBS -l procs=1 # specify number of processors.
#PBS -m e -M j.f.viana@exeter.ac.uk # email me at job completion

module load R/3.3.1-foss-2016b #load R module


#####CTR_N_PFC samples####
#arguments:
cohort="CTR_N"
brain_region="PFC"
save_path="/gpfs/ts0/projects/Research_Project-129726/MATRICS/CTR_N_PFC/bismark_alignment/"
pdf_path="/gpfs/ts0/projects/Research_Project-129726/MATRICS/CTR_N_PFC/analysis/coverage_CpGs_"
save_csv="/gpfs/ts0/projects/Research_Project-129726/MATRICS/CTR_N_PFC/analysis/coverage_CpGs_statistics_"

cd /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTR_N_PFC/bismark_alignment/ #change directory

mkdir /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTR_N_PFC/analysis/ #make analysis directory

gunzip -d /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTR_N_PFC/bismark_alignment/*bismark.cov.gz #unzip the DNA methylation coverage files

Rscript /gpfs/ts0/projects/Research_Project-129726/MATRICS/general_scripts/QC/3.coverage_plot_CpG_ISCA.r $cohort $brain_region $save_path $pdf_path
Rscript /gpfs/ts0/projects/Research_Project-129726/MATRICS/general_scripts/QC/3.coverage_stats_CpG_ISCA.r $cohort $brain_region $save_csv




#####CTR_N_HC samples####
#arguments:
cohort="CTR_N"
brain_region="HC"
save_path="/gpfs/ts0/projects/Research_Project-129726/MATRICS/CTR_N_HC/bismark_alignment/"
pdf_path="/gpfs/ts0/projects/Research_Project-129726/MATRICS/CTR_N_HC/analysis/coverage_CpGs_"
save_csv="/gpfs/ts0/projects/Research_Project-129726/MATRICS/CTR_N_HC/analysis/coverage_CpGs_statistics_"


cd /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTR_N_HC/bismark_alignment/ #change directory

mkdir /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTR_N_HC/analysis/ #make analysis directory

gunzip -d /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTR_N_HC/bismark_alignment/*bismark.cov.gz #unzip the DNA methylation coverage files

Rscript /gpfs/ts0/projects/Research_Project-129726/MATRICS/general_scripts/QC/3.coverage_plot_CpG_ISCA.r $cohort $brain_region $save_path $pdf_path
Rscript /gpfs/ts0/projects/Research_Project-129726/MATRICS/general_scripts/QC/3.coverage_stats_CpG_ISCA.r $cohort $brain_region $save_csv




#####CTR_N_HPT samples####
#arguments:
cohort="CTR_N"
brain_region="HPT"
save_path="/gpfs/ts0/projects/Research_Project-129726/MATRICS/CTR_N_HPT/bismark_alignment/"
pdf_path="/gpfs/ts0/projects/Research_Project-129726/MATRICS/CTR_N_HPT/analysis/coverage_CpGs_"
save_csv="/gpfs/ts0/projects/Research_Project-129726/MATRICS/CTR_N_HPT/analysis/coverage_CpGs_statistics_"


cd /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTR_N_HPT/bismark_alignment/ #change directory

mkdir /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTR_N_HPT/analysis/ #make analysis directory

gunzip -d /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTR_N_HPT/bismark_alignment/*bismark.cov.gz #unzip the DNA methylation coverage files

Rscript /gpfs/ts0/projects/Research_Project-129726/MATRICS/general_scripts/QC/3.coverage_plot_CpG_ISCA.r $cohort $brain_region $save_path $pdf_path
Rscript /gpfs/ts0/projects/Research_Project-129726/MATRICS/general_scripts/QC/3.coverage_stats_CpG_ISCA.r $cohort $brain_region $save_csv
