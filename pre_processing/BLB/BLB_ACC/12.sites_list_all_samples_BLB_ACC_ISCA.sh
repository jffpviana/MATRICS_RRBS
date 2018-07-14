#!/bin/sh
#PBS -V # export all environment variables to the batch job.
#PBS -q sq # submit to the serial queue
#PBS -l walltime=50:00:00 # Maximum wall time for the job.
#PBS -A Research_Project-129726 # research project to submit under. 
#PBS -l procs=1 # specify number of processors.
#PBS -m e -M j.f.viana@exeter.ac.uk # email me at job completion


mkdir /gpfs/ts0/scratch/jfv203/MATRICS/BLB_ACC/analysis #make new folder for analysis

cd /gpfs/ts0/scratch/jfv203/MATRICS/BLB_ACC/bismark_alignment

gzip -d CpG_context_*_trimmed_bismark_bt2.txt.gz #unzip CpG context text files for all samples
cat CpG_context_*_trimmed_bismark_bt2.txt | cut -f3,4 | sort | uniq -c > /gpfs/ts0/scratch/jfv203/MATRICS/BLB_ACC/analysis/All_CpG_Sites_AcrossAllSamples_BLB_ACC.txt #Get list of all sites across all samples