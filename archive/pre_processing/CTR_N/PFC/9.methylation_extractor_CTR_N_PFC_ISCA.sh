
#!/bin/sh
#PBS -V # export all environment variables to the batch job.
#PBS -q sq # submit to the serial queue
#PBS -l walltime=50:00:00 # Maximum wall time for the job.
#PBS -A Research_Project-129726 # research project to submit under. 
#PBS -l procs=1 # specify number of processors.
#PBS -m e -M j.f.viana@exeter.ac.uk # email me at job completion

module load Perl/5.24.1-GCCcore-6.3.0 #load perl, needed for bismark

cd /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTR_N_PFC/bismark_alignment
gunzip -d *_trimmed_bismark_bt2.sam.gz # Unzip the CTR N PFC samples (prefrontal cortex of Naive Lausanne rats)

perl ~/software/Bismark-0.19.0/Bismark-0.19.0/bismark_methylation_extractor  -s --gzip --comprehensive --multicore 4 --bedGraph *_trimmed_bismark_bt2.sam --samtools_path /gpfs/ts0/shared/software/SAMtools/1.5-foss-2016b/bin/