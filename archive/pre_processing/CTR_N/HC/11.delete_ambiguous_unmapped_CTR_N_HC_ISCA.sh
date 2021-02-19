
#!/bin/sh
#PBS -V # export all environment variables to the batch job.
#PBS -q sq # submit to the serial queue
#PBS -l walltime=50:00:00 # Maximum wall time for the job.
#PBS -A Research_Project-129726 # research project to submit under. 
#PBS -l procs=1 # specify number of processors.
#PBS -m e -M j.f.viana@exeter.ac.uk # email me at job completion

#AFTER checking the mapped data, and if everything is ok, remove the ambiguous and unmapped reads from the server to free up space.
rm /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTR_N_HC/bismark_alignment/*_unmapped_reads.fq.gz
rm /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTR_N_HC/bismark_alignment/*_ambiguous_reads.fq.gz