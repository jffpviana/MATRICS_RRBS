
#!/bin/sh
#PBS -V # export all environment variables to the batch job.
#PBS -q sq # submit to the serial queue
#PBS -l walltime=50:00:00 # Maximum wall time for the job.
#PBS -A Research_Project-129726 # research project to submit under. 
#PBS -l procs=1 # specify number of processors.
#PBS -m e -M j.f.viana@exeter.ac.uk # email me at job completion

module load Perl/5.24.1-GCCcore-6.3.0 #load perl, needed for bismark

#run bismark2bedGraph

cd /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTR_N_PFC/bismark_alignment

for i in CpG_*_trimmed_bismark_bt2.txt.gz
do
file=`basename $i`
sample=`echo $file `
read1=`ls *.gz | grep ^$sample`;


perl ~/software/Bismark-0.19.0/Bismark-0.19.0/bismark2bedGraph $read1 -o $read1

done