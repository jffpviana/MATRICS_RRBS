#!/bin/bash
#SBATCH --ntasks 1
#SBATCH --time 2:0:0
#SBATCH --qos bbdefault
#SBATCH --mail-type ALL

set -e

module purge; module load bluebear

module load FastQC/0.11.9-Java-11 #load the module fastqc

cd /rds/projects/v/vianaj-genomics-brain-development/MATRICS/raw_data_test #change directory
fastqc *.fq -o /rds/projects/v/vianaj-genomics-brain-development/MATRICS/raw_data_test/fastqc/ # run fastqc for all samples and output in the directory of the respective cohort
