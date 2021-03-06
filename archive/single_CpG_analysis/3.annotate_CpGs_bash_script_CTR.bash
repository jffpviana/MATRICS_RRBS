
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
output_path="/gpfs/ts0/projects/Research_Project-129726/MATRICS/CTR_N_PFC/analysis/"
genome="rn6"

Rscript /gpfs/ts0/projects/Research_Project-129726/MATRICS/general_scripts/single_site_analysis/3.annotate_CpGs.r $cohort $brain_region $output_path $genome



#####CTR_N_HC samples####
#arguments:
cohort="CTR_N"
brain_region="HC"
output_path="/gpfs/ts0/projects/Research_Project-129726/MATRICS/CTR_N_HC/analysis/"
genome="rn6"

Rscript /gpfs/ts0/projects/Research_Project-129726/MATRICS/general_scripts/single_site_analysis/3.annotate_CpGs.r $cohort $brain_region $output_path $genome




#####CTR_N_HPT samples####
#arguments:
cohort="CTR_N"
brain_region="HPT"
output_path="/gpfs/ts0/projects/Research_Project-129726/MATRICS/CTR_N_HPT/analysis/"
genome="rn6"

Rscript /gpfs/ts0/projects/Research_Project-129726/MATRICS/general_scripts/single_site_analysis/3.annotate_CpGs.r $cohort $brain_region $output_path $genome



