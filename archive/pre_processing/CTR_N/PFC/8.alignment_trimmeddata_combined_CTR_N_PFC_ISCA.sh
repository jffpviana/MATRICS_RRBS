
#!/bin/sh
#PBS -V # export all environment variables to the batch job.
#PBS -q sq # submit to the serial queue
#PBS -l walltime=50:00:00 # Maximum wall time for the job.
#PBS -A Research_Project-129726 # research project to submit under. 
#PBS -l procs=1 # specify number of processors.
#PBS -m e -M j.f.viana@exeter.ac.uk # email me at job completion

module load Perl/5.24.1-GCCcore-6.3.0 #load perl, needed for bismark

#run Bismark: NOTE assumes directional.
mkdir /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTR_N_PFC/bismark_alignment

cd /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTR_N_PFC/trim_galore_output/

for i in *_trimmed.fq
do
file=`basename $i`
sample=`echo $file `
read1=`ls *.fq | grep ^$sample`;

perl ~/software/Bismark-0.19.0/Bismark-0.19.0/bismark -N 1 --un --ambiguous --gzip -q --se $read1 --path_to_bowtie /gpfs/ts0/shared/software/Bowtie2/2.2.9-foss-2016a/bin --genome_folder /gpfs/ts0/home/jfv203/reference_files/Rat/Rnor6.0_GCA_000001895.4 -o /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTR_N_PFC/bismark_alignment

done