#!/bin/sh
#PBS -V # export all environment variables to the batch job.
#PBS -q sq # submit to the serial queue
#PBS -l walltime=50:00:00 # Maximum wall time for the job.
#PBS -A Research_Project-129726 # research project to submit under. 
#PBS -l procs=1 # specify number of processors.
#PBS -m e -M j.f.viana@exeter.ac.uk # email me at job completion


mkdir /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTR_N_HC/analysis #make new folder for analysis

cd /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTR_N_HC/bismark_alignment

gzip -d CpG_context_*_trimmed_bismark_bt2.txt.gz #unzip CpG context text files for all samples
cat CpG_context_*_trimmed_bismark_bt2.txt | cut -f3,4 | sort | uniq -c > All_CpG_Sites_AcrossAllSamples_CTR_N_HC.txt #Get list of all sites across all samples