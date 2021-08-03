#!/bin/bash
#SBATCH --ntasks 10
#SBATCH --time 1-0:0:0
#SBATCH --qos castles
#SBATCH --mail-type ALL

set -e

module purge; module load bluebear
module load R-bundle-Bioconductor/3.10-foss-2019b-R-3.6.2

export R_LIBS_USER=${HOME}/R/library/${EBVERSIONR}/${BB_CPU}

cd /rds/projects/v/vianaj-genomics-brain-development/MATRICS/jobs/CTR/HC/


input_dir="/rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTR/HC/analysis/"
output_dir="/rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTR/HC/analysis/"
pheno_path="/rds/projects/v/vianaj-genomics-brain-development/MATRICS/CTR/phenoCTR.csv"
region="HC_ID"
cohort="CTR"


Rscript 10.variogram.r $input_dir $output_dir $pheno_path $region $cohort
