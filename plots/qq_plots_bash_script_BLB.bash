
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
output_path="/gpfs/ts0/projects/Research_Project-129726/MATRICS/BLB_ACC/analysis/"

Rscript /gpfs/ts0/projects/Research_Project-129726/MATRICS/general_scripts/plots/qq_plots.r $cohort $brain_region $output_path 


#####BLB_MCC samples####
#arguments:
cohort="BLB"
brain_region="MCC"
output_path="/gpfs/ts0/projects/Research_Project-129726/MATRICS/BLB_MCC/analysis/"

Rscript /gpfs/ts0/projects/Research_Project-129726/MATRICS/general_scripts/plots/qq_plots.r $cohort $brain_region $output_path




#####BLB_VMH samples####
#arguments:
cohort="BLB"
brain_region="VMH"
output_path="/gpfs/ts0/projects/Research_Project-129726/MATRICS/BLB_VMH/analysis/"

Rscript /gpfs/ts0/projects/Research_Project-129726/MATRICS/general_scripts/plots/qq_plots.r $cohort $brain_region $output_path 



