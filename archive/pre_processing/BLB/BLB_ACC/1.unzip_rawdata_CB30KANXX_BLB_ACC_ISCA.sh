
#!/bin/sh
#PBS -V # export all environment variables to the batch job.
#PBS -q sq # submit to the serial queue
#PBS -l walltime=50:00:00 # Maximum wall time for the job.
#PBS -A Research_Project-129726 # research project to submit under. 
#PBS -l procs=1 # specify number of processors.
#PBS -m e -M j.f.viana@exeter.ac.uk # email me at job completion



cd /gpfs/ts0/scratch/jfv203/MATRICS/BLB_ACC/raw_data/CB30KANXX  # change directory to the MATRICS project directory, MATRICS folder, respective cohort within that, and sequencing cluster folder where the raw data is
gunzip -d *.fq.gz # Unzip the samples
