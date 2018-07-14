
#!/bin/sh
#PBS -V # export all environment variables to the batch job.
#PBS -q sq # submit to the serial queue
#PBS -l walltime=10:00:00 # Maximum wall time for the job.
#PBS -A Research_Project-129726 # research project to submit under. 
#PBS -l procs=1 # specify number of processors.
#PBS -m e -M j.f.viana@exeter.ac.uk # email me at job completion

module load Perl/5.24.1-GCCcore-6.3.0 
module load Python/3.5.2-intel-2016b 

mkdir /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_HPT/trim_galore_output

#trim the reads
perl /gpfs/ts0/home/jfv203/software/TrimGalore-0.4.3/trim_galore -q 20  --phred33 --rrbs --gzip --fastqc_args "--outdir /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_HPT/trim_galore_output" --output_dir /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_HPT/trim_galore_output  /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_HPT/raw_data/combined/*.fastq

perl /gpfs/ts0/home/jfv203/software/TrimGalore-0.4.3/trim_galore -q 20  --phred33 --rrbs --gzip --fastqc_args "--outdir /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_HPT/trim_galore_output" --output_dir /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_HPT/trim_galore_output  /gpfs/ts0/projects/Research_Project-129726/MATRICS/CTT_HPT/raw_data/combined/*.fq
