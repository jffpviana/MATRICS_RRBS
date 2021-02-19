
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
output_path="/gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_PFC/analysis/"
genome="mm10"

Rscript /gpfs/ts0/projects/Research_Project-129726/MATRICS/general_scripts/single_site_analysis/3.annotate_CpGs.r $cohort $brain_region $output_path $genome



#####CTT_HC samples####
#arguments:
cohort="CTT"
brain_region="HC"
output_path="/gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_HC/analysis/"
genome="mm10"

Rscript /gpfs/ts0/projects/Research_Project-129726/MATRICS/general_scripts/single_site_analysis/3.annotate_CpGs.r $cohort $brain_region $output_path $genome




#####CTT_HPT samples####
#arguments:
cohort="CTT"
brain_region="HPT"
output_path="/gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_HPT/analysis/"
genome="mm10"

Rscript /gpfs/ts0/projects/Research_Project-129726/MATRICS/general_scripts/single_site_analysis/3.annotate_CpGs.r $cohort $brain_region $output_path $genome



