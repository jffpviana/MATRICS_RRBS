
#!/bin/sh
#PBS -V # export all environment variables to the batch job.
#PBS -q sq # submit to the serial queue
#PBS -l walltime=50:00:00 # Maximum wall time for the job.
#PBS -A Research_Project-129726 # research project to submit under. 
#PBS -l procs=1 # specify number of processors.
#PBS -m e -M j.f.viana@exeter.ac.uk # email me at job completion

module load R/3.3.1-foss-2016b #load R module


#####CTT samples####
#arguments:
cohort="CTT"
input_path1="/gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_PFC/analysis/"
input_path2="/gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_HC/analysis/"
input_path3="/gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_HPT/analysis/"
brain_region1="PFC"
brain_region2="HC"
brain_region3="HPT"
p_val="0.001"

Rscript /gpfs/ts0/projects/Research_Project-129726/MATRICS/general_scripts/plots/overlap_sig_CpGs_brain_regions.r $cohort $input_path1 $input_path2 $input_path3 $brain_region1 $brain_region2 $brain_region3 $p_val