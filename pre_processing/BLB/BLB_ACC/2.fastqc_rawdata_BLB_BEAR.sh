
#!/bin/sh
#PBS -V # export all environment variables to the batch job.
#PBS -q sq # submit to the serial queue
#PBS -l walltime=50:00:00 # Maximum wall time for the job.
#PBS -A Research_Project-129726 # research project to submit under.
#PBS -l procs=1 # specify number of processors.
#PBS -m e -M j.f.viana@exeter.ac.uk # email me at job completion



module load FastQC/0.11.5-Java-1.8.0_92 #load the module fastqc
cd /gpfs/ts0/scratch/jfv203/MATRICS/BLB_ACC/raw_data/CB2N2ANXX #change directory
fastqc *.fq -o /gpfs/ts0/scratch/jfv203/MATRICS/BLB_ACC/raw_data/CB2N2ANXX # run fastqc for all samples and output in the directory of the respective cohort
