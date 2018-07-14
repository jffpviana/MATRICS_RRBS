
#!/bin/sh
#PBS -V # export all environment variables to the batch job.
#PBS -q sq # submit to the serial queue
#PBS -l walltime=10:00:00 # Maximum wall time for the job.
#PBS -A Research_Project-129726 # research project to submit under. 
#PBS -l procs=1 # specify number of processors.
#PBS -m e -M j.f.viana@exeter.ac.uk # email me at job completion



module load FastQC/0.11.5-Java-1.8.0_92 #load the module fastqc
cd /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_PFC/trim_galore_output #change directory to where the trimmed reads are

gunzip -d *.fq.gz # Unzip the trimmed CTT PFC samples (prefrontal cortex of Italian mice)

fastqc *.fq -o /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_PFC/trim_galore_output # run fastqc for all samples and output in the directory of the trimmed reads


###after this check FASTQC reports to look at quality and coverage